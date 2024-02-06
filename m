Return-Path: <netdev+bounces-69397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DCB84B0D3
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821C41F22CCC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88886481DB;
	Tue,  6 Feb 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW4TQSoP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90E5B687
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707210937; cv=none; b=k62+JU9ZHDetxBiNj/wkuFcfXnfsGNyJAZAQwlFwHFtbaCWY/z8EAosqLSqCU48IkO/P+W0F7ci0F3/qNiFv8BUaSLMQ3vMOCtUjlEyUaHsqAV0nfoAmGuv7tIZR+0+Aosf79imUNev6svF3mc2g+YknjrfvX0Wb98N/vwi1lbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707210937; c=relaxed/simple;
	bh=zH3aJYOVZXjHm4sG6Zqlksv0vw7v4ng3w44dPEnmKz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W1nGaVwC9Yo8o7625FPSEbrSkntpzvGDpaloJ5AmnQMpHvU5/CUe9CWTQa8f7sqB2EdTDlvZa3RNv1rLLGxALqdMlAQ2xvww1i6hIK5+cwdvTmPZIZq22zYv97wPE4TwK2AzMzIsrFCsix3zL1j7o2z0HJIljfyGHbw08ABx+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dW4TQSoP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707210934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mP9uBLPG/V18f0msfaOTg/Von0gFh1D/sZrOu5FWkss=;
	b=dW4TQSoPLcB4v26cKEYzzkNs4qM14IWnVnuIBFGge+zgVPie+XgBmPQjc+OrTbpfYhaVoh
	sRCPEqfFTGlrL/ERuh5cmu6En12i+q51yg+ZdAyiZcQm+WDFK2iFkV5p6hOQV3RUZOrnY0
	uX9KeT71MxGu6kBFRC/tUVVJFBt+IEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-XmVagQoEPLilc-RXX18Swg-1; Tue, 06 Feb 2024 04:15:31 -0500
X-MC-Unique: XmVagQoEPLilc-RXX18Swg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40ef6441d1aso7632415e9.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 01:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707210931; x=1707815731;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mP9uBLPG/V18f0msfaOTg/Von0gFh1D/sZrOu5FWkss=;
        b=JlPS8OVs0Mq2UjtRUELJLD7YovmfHpwd6GXxVPnLF3uVhWXEc7XypKtVkZNQoe89EJ
         76AkJuEOeSuppJjFJkV75NjEC4jrZOwRMn7LSvtsSZjp1AZ0PLVMP+D5L/KuJQXVi7Ta
         5BfHPhC9IOnZIFK26nRapHYKUGgdlQFqiEyyba/bDnUMYRuYC64kwTwGZy/HeJ4kItrg
         jSoZbYc/9IStqqlORy9XhHZPv00/dOa6f6GJuSgdbQJPRW//3uKFxIf/Be6womVbPXoI
         jlI+rI1dmth2uwWpcq31+MrOrjMrd2CzfFFxZyXtWGmTQHE5eTuG1KzMjV+3hg2NlLLt
         ajKA==
X-Forwarded-Encrypted: i=1; AJvYcCWFTpNfhasWN5neonryRlhtJaavtapFOm7VAPeJb8rpfjSYl4cgsHK+N9rAZvpsw6FS7KRAJFnFygUXi4qnQMjdodxgATKw
X-Gm-Message-State: AOJu0YxNk6GdDmq0SaM2Za9cvHYr4a5ivRw4czqXN70qLDW77N2owtDH
	buQZzR+EPKMiLApz/RbEAHv6onXjXFdCGItVbhtvnVy6IfaWBe7AVDG6YPoT4CmcZxzEtg3ZeZR
	FqSbaYkatWxdz8IQ3JAZ9RM/CeuWnVKg0bI1hsTkOl9wpu76Kks6S8g==
X-Received: by 2002:a05:600c:3d8e:b0:40f:e930:9ebe with SMTP id bi14-20020a05600c3d8e00b0040fe9309ebemr413708wmb.0.1707210930884;
        Tue, 06 Feb 2024 01:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUcruEk0VeLSloahhhTCR2Nye1wgOBYUB+zG1v0dEMEFH7/9ttq+OUdIRK3LDrzESaeBptjQ==
X-Received: by 2002:a05:600c:3d8e:b0:40f:e930:9ebe with SMTP id bi14-20020a05600c3d8e00b0040fe9309ebemr413696wmb.0.1707210930562;
        Tue, 06 Feb 2024 01:15:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHD19iM6xswTdpMrj/JwagQoP7rb2BEQgKrfK8szmesy/ooxTzQ8bc96QIN1/n7Vi5tV5wBiNd19Iz9W4V13FByxn0XnL7clhKSifCCrw+rgSH5J3UBkieIyH63jncHFLmgyW0r/fdrIVVt+PxcrsqNs1K6i987J2xyu7YfR93H5I3umI=
Received: from gerbillo.redhat.com (146-241-224-127.dyn.eolo.it. [146.241.224.127])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b0040ee8765901sm1312235wmo.43.2024.02.06.01.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:15:30 -0800 (PST)
Message-ID: <9ee7f0562ae3c646c4c362c5e1ed19f31e0f8dd4.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 00/15]  net: more factorization in
 cleanup_net() paths
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Date: Tue, 06 Feb 2024 10:15:28 +0100
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
References: <20240205124752.811108-1-edumazet@google.com>
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

On Mon, 2024-02-05 at 12:47 +0000, Eric Dumazet wrote:
> This series is inspired by recent syzbot reports hinting to RTNL and
> workqueue abuses.
>=20
> rtnl_lock() is unfair to (single threaded) cleanup_net(), because
> many threads can cause contention on it.
>=20
> This series adds a new (struct pernet_operations) method,
> so that cleanup_net() can hold RTNL longer once it finally
> acquires it.
>=20
> It also factorizes unregister_netdevice_many(), to further
> reduce stalls in cleanup_net().
>=20
> v3: Dropped "net: convert default_device_exit_batch() to exit_batch_rtnl =
method"
>     Jakub (and KASAN) reported issues with bridge, but the root cause was=
 with this patch.
>     default_device_exit_batch() is the catch-all method, it includes "lo"=
 device dismantle.
>=20

I *think* this still causes KASAN splat in the CI WRT vxlan devices,
e.g.:

https://netdev-3.bots.linux.dev/vmksft-net/results/453141/17-udpgro-fwd-sh/=
stdout

(at least this series is the most eye catching thing that landed into
the relevant batch)

Cheers,

Paolo


