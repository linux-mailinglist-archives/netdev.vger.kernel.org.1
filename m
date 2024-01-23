Return-Path: <netdev+bounces-64966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF98388A7
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 09:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E463BB24249
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DF56470;
	Tue, 23 Jan 2024 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2AG00oa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB856450
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997726; cv=none; b=Yrjk5GZpdeXDdioleL3iOa8KOsZvlrQCn8zO9Y8U3dsj0jG6GdiCY0wmDgiDPga8JZaqfDsMZn+oIn81TdVTYPAa+wBRWM3Pjv0RJGd5LOaiga9AQ+pFOdWdrUnqN4QuBtfEwmdsYq+WEwGz5pKa5E9KWEBd6LMimluchDrZdTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997726; c=relaxed/simple;
	bh=M7xnQP2xrUCA9944w5fpDPR/k7752uMsr3nQToWC+tc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DoFFE+f1y7mdrTBjRSDI5ciG1hQFooJqbnLVnGubyr9DU+62p+xV7Zwu3Yt8ebbuKZGYZQS4UJ76q+1psQDIyeovL+d8HYjleM1K2wRd3FgNGzzI2AxJ0kp0eZVlk1JmL8vnVLZEeIDMlN9wdAa8oG3MjRgb5dwJu8h1MmrKaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W2AG00oa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705997723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MSItGihO0SMUJBP5FRLy98jdy6fH6T9zN2lD1dDxxSg=;
	b=W2AG00oawK88AdtT/LN/u0p/QjzcVqLXAfxcvjQpuCbwzYZwAh9MAVQo7DGftzTY7I4hnz
	oH3MrDy8jKmJo578iPwzMjsQc/vgIG2JI0bePp9A0yUJsgxSuRGKhGbdkt0FVzA+s9RJfj
	sdd3cvsXIof8CcNf6+MtrQBlY1RaVMs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-MNE1VqchPQu1cV5xAOKKrw-1; Tue, 23 Jan 2024 03:15:21 -0500
X-MC-Unique: MNE1VqchPQu1cV5xAOKKrw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e476c518eso8150815e9.0
        for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 00:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997720; x=1706602520;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSItGihO0SMUJBP5FRLy98jdy6fH6T9zN2lD1dDxxSg=;
        b=VhYdIGL5v9LPHy4KPs9AJTzs2MZ9A+faesfVeiht5bYxdGfWyF0aXzoCcJ5BDFAe86
         0534FMusoJlW1yj4bauAV0sMT4ycFq3lCQSsFcMR0DgLNjMz9Q7BTzP6/7rsyL7yZ8u/
         VaeoOWBF0sTuHKpfQuAX6QKPDyAAaRFfPLO7WUk7zp+QQ2/WxqWGFiN6eXFGHtva+vxT
         daI/T6vReqT7uNadcZCjFVBDKK6+bGrcpq9c/SXJzlpm3oh0ZV0Y//H4lVZPJ4VSudA9
         GJDZtXIwcBy/kjbjiF9u9Aik0a4JC2o2ySJKlLz0zOHq6rCHnfu4UmcWo/hdzdQQjL1c
         6hmg==
X-Gm-Message-State: AOJu0YxnwM8869V4hu8uS9dzJkMEktMR/qxxxwfeyJ4QxkvGVG5UVfrs
	Bms2kORCWvjNq8gFW5pebXjxjYdzq8+olHFxoSTgtrejjDWxmkkzso26aphQKFZR9NekpU8xsUC
	r3mZ0VNyTLrB1Fn7ztjC1pXNwpJ4oU3OVeATSk9uVQANGhSqOuQRjSDTvjZoTrw==
X-Received: by 2002:a05:600c:1d11:b0:40e:4912:1df3 with SMTP id l17-20020a05600c1d1100b0040e49121df3mr7776744wms.3.1705997720004;
        Tue, 23 Jan 2024 00:15:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDQEDzEDP1iIUtvYZIBjlMEVZyB4GlY6UO7NSvz61NNJDR2VuPNkfu/eM0B/YSQleHYVmCng==
X-Received: by 2002:a05:600c:1d11:b0:40e:4912:1df3 with SMTP id l17-20020a05600c1d1100b0040e49121df3mr7776730wms.3.1705997719650;
        Tue, 23 Jan 2024 00:15:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c138600b0040d5a9d6b68sm45802448wmf.6.2024.01.23.00.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:15:19 -0800 (PST)
Message-ID: <8f596e31e1d24f418fa1c6b1a2bae5fc00746e33.camel@redhat.com>
Subject: Re: [PATCH] net: use READ_ONCE() to read in concurrent environment
From: Paolo Abeni <pabeni@redhat.com>
To: linke li <lilinke99@qq.com>, netdev@vger.kernel.org
Date: Tue, 23 Jan 2024 09:15:18 +0100
In-Reply-To: <tencent_F35C58B90E47D014455212BC7110EDBB2106@qq.com>
References: <tencent_F35C58B90E47D014455212BC7110EDBB2106@qq.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-23 at 04:24 +0800, linke li wrote:
> In function sk_stream_wait_memory(), reads of sk->sk_err and sk->sk_shutd=
own
> is protected using READ_ONCE() in line 145, 146.
> 145: 		ret =3D sk_wait_event(sk, &current_timeo, READ_ONCE(sk->sk_err) ||
> 146: 				    (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN) ||

The above read happens outside the sk socket lock, see the
sk_wait_event() macro definition...

>=20
> But reads in line 133 are not protected.=C2=A0

... while the above one happens under the sk socket lock. The _ONCE
annotation is not needed.


> This may cause unexpected error
> when other threads change sk->sk_err and sk->sk_shutdown. Function
> sk_stream_wait_connect() has same problem.

Same as above, the access with the _ONCE() annotation is outside the
socket lock and vice versa.


I think this patch is not needed.

Thanks,

Paolo


