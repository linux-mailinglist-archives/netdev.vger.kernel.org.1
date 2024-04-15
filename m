Return-Path: <netdev+bounces-88049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEA8A5741
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD261F237D2
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4664B80BF7;
	Mon, 15 Apr 2024 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr7VNy1/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCAD7F7FD
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197514; cv=none; b=OoQBFQFzgZra10Yt+boVsnVoTuBtpLCrrTPuyfju1EKP1yLxVIHkc/7G/6McrF0qg+SK8DP/FIMWO0CYEqItlSZ3zZSC3heG0CIMStwXXlXrRUPPzMYAYvb4PdoZY4e9XneA3nXC4erh3VX/OENpTyMewmOQx50+2p0xRupciDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197514; c=relaxed/simple;
	bh=1qAbL1E5bjFVJRrhYe8lPEowwrjwcOMDrfK5vCabtZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GhTtdVSeuQyNqNDFoGKa9yCEk+mO2Zu/FJT6xJoXajfrMF+Eorx2DuFF24J1n+3lDy4iV4aG4dPaTWbt4VbeM5kquxz+BXYIx8ZxDh8Wbr9vNyXALUYSc7gcUdUhZm5OqGXT1uEPLIHkU3e6V9daV+WPxKE7zKM5cMWwbCRJnCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zr7VNy1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713197511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1qAbL1E5bjFVJRrhYe8lPEowwrjwcOMDrfK5vCabtZY=;
	b=Zr7VNy1/Kump2vSs9wUVZ6kYK1QJHOwDCNNXh7gTW24dy2g2tN+g3U8iP0zB8Fh4EjQrr1
	zUW6cgcGWLtBoWZVEu/rulLah43BMB7xuVqM2wlerD2LVaLfWRbYcmXEXI3JkvwzozlZIx
	RTVWz6OnGEZoEE6MnOuzdubvqNrp+tI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-eoCoS2GSMraUd7qzTEOr3A-1; Mon, 15 Apr 2024 12:11:49 -0400
X-MC-Unique: eoCoS2GSMraUd7qzTEOr3A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41883749d66so410135e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197508; x=1713802308;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qAbL1E5bjFVJRrhYe8lPEowwrjwcOMDrfK5vCabtZY=;
        b=Jhu9pNeUM9IZBSakD5YOvVommAy+ulM67S1RPEU+SqTaNj9SA6yZMqAjZagS+ZtTgz
         bqzzqwrPPoPzC8yQfAHn8nxzZGcNKZsiOdc0JCYlEw71p3jK5FyEinQ6fEzMw/zMdAPX
         pBCb9EL0Qvy+CNPO+3PUQLa5clh0SQAfL97DHfv+Q3NXHR97vSm8YfzW1XyNngMWEQXK
         /tXbg/Vzs6/GYBp4qWhgF840Lz0htkvkGtRVkmHtnEzX7VjqWnBRGDbr4u+6rNEj8Sks
         hsZBBaghdW6fuwqNh0cYL9OH7+0TbGWXvEzvL328PHRggheLOHF2OBPz9CRPGVgukZtL
         NLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXmEoKkMtQdlhjjqT5TeeEg9CMmQYhxbXh8O53GYnS0r9XePzNqSFXMRYbpome8SJWe11jZTCFH6UgjeTZQigRC5x6CCcjd
X-Gm-Message-State: AOJu0Yx3eG5OdvrzzW9FW1gOqxe1CCFc9wRNSLn8ZNK9W880v7JB4u4Z
	cCqOGkMXaWBVOCY4wAPZu6Rqjan/MhjiCrEwYIaGCJNuC6/7i98t+C4MfDszYxOU24Pgq5YT6/+
	tI1J33G53a1zL01cP0U8/JOFkG34YGzP3CKDd0eOLQ1kW2cieyLgr+w==
X-Received: by 2002:a5d:64c5:0:b0:347:1d65:385c with SMTP id f5-20020a5d64c5000000b003471d65385cmr6645660wri.6.1713197508056;
        Mon, 15 Apr 2024 09:11:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9G5m9VD4lhTKjrquVnhlya0eJJGnUtMwvZCc8R5JkZRHM9fOqDcc/9uZQW543hY21jlFAWw==
X-Received: by 2002:a5d:64c5:0:b0:347:1d65:385c with SMTP id f5-20020a5d64c5000000b003471d65385cmr6645632wri.6.1713197507650;
        Mon, 15 Apr 2024 09:11:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-238.dyn.eolo.it. [146.241.228.238])
        by smtp.gmail.com with ESMTPSA id j20-20020a5d4534000000b003434f526cb5sm12444013wra.95.2024.04.15.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:11:47 -0700 (PDT)
Message-ID: <228279a70720e4ff9983006efb76eaff4e0732fb.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: define endpoint
 structures
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	shuah@kernel.org, petrm@nvidia.com, linux-kselftest@vger.kernel.org, 
	willemb@google.com
Date: Mon, 15 Apr 2024 18:11:45 +0200
In-Reply-To: <20240415071914.23589fb8@kernel.org>
References: <20240412233705.1066444-1-kuba@kernel.org>
	 <20240412233705.1066444-2-kuba@kernel.org>
	 <a80414c647940747c37a8c750bad4290ec81bd66.camel@redhat.com>
	 <20240415071914.23589fb8@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-15 at 07:19 -0700, Jakub Kicinski wrote:
> On Mon, 15 Apr 2024 10:57:31 +0200 Paolo Abeni wrote:
> > If I read correctly the above will do a full ssh handshake for each
> > command. If the test script/setup is complex, I think/fear the overhead
> > could become a bit cumbersome.
>=20
> Connection reuse. I wasn't sure if I should add a hint to the README,
> let me do so.

I'm sorry for the multiple, incremental feedback. I think such hinto
the readme will be definitely useful, thanks!

Paolo


