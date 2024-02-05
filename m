Return-Path: <netdev+bounces-69143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20FA849B67
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44111C2183D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C581CA9A;
	Mon,  5 Feb 2024 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAmJTaRb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AF1CD01
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138521; cv=none; b=EoSekl73q8OpokykIdl4HiioB1so2oKRKbVXEUiv83cc02Fk6kXbmle97ifyjXc1qPmJLrBzoFOvWumsDcKnaZi67msxYtVm0CKP8q+CLcODau343f9J77ShSIbsyF7f/1H26II+CvNsViEK30ov8JlvLDvipq/V3xyIq/m7+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138521; c=relaxed/simple;
	bh=nkOe2A26aIi/aBtdqu6j/wWZO5uYLvItpsocnEEY3xY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dryAV4Mvu9X4i581PUYZmiYfgI71gAsYzhasLZq9NCgJxIe1BcRpKsenwezzO2b4RxEbpNz/Fgka0SKnp+4a3dFpGyJ5g3T7FSwbHQszfKkYfCXcpb1g+BYxXsqgpMErKiJj+Tjk4WsB5HWq7qNgdJgpWcFpUUTE00yqNv/9c6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAmJTaRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707138518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Elk+v4Y+ED/4T2H+8uQLqgMyCrp4tt5/vHD0v7FV0YQ=;
	b=LAmJTaRbfsmJB2wPc4z65jnUCb2LtOBqEEX4oF1LAg1Pn6WT/CyY/9S0OXT4+T9nQKK6KP
	Mc6hf8Rh9mmW8DS1d4DvkWlCvShYFD1HUednMUO17z8sTUjR+IC4O5TtOsh2RSYYNZIMGp
	nwqulpfVnfQXletnqpiqkJAkMIzA4ck=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-GTK86jeYM22F2-xy88Xvcg-1; Mon, 05 Feb 2024 08:08:37 -0500
X-MC-Unique: GTK86jeYM22F2-xy88Xvcg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-511545632b8so585862e87.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 05:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138516; x=1707743316;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Elk+v4Y+ED/4T2H+8uQLqgMyCrp4tt5/vHD0v7FV0YQ=;
        b=V0zd8+YFCfqVnX3sYik1/PhTGLpi7S6KzNnxfYaKkJamucxPD4aGNZjHpKfLVfUJGF
         yyuX2+bNbPF+GhFyCBcFqZbzOVz/aiNitkSl+8yPKfn0jieo2zCrDtjOfn8RtPVdKEBU
         ImpPEFyVhNFSKNW5jhhomGLvwjstx5FFdNcRmSME1WkKR9KLd7/Sa8/wqxe6Q80/0ObE
         P1QhrPxUyZhXingmqMepZlf9B3jtK+MnOTpiaKRlqKNZf+o4t8Cbaihos+HkTLjpQYh0
         P4pcQJXlNUMLF2l7HO9hggkYf6OdosWAwEQVIRH8DgE3H1FSZPAEOCe8hLpSaQPdQe6i
         bUUw==
X-Gm-Message-State: AOJu0YxPH+edD8DQysRkP111p4IsqjsfT3gd/1LWZQjGBxYAZTqfGZ6w
	auXPmA6iwwBBDrIPSZJnDQgTDpTKVc0mLjzerhLOkgEi06sziRfuiuyFZIBimedNBJ+PJHW/Bbx
	r8rcE0l/KKzbsDqNZuulmz0sbXCNoV6/5LkdKGfmpRe/yC3bUBlBfSw==
X-Received: by 2002:a05:6512:3a85:b0:511:4c51:d18e with SMTP id q5-20020a0565123a8500b005114c51d18emr3336180lfu.4.1707138516018;
        Mon, 05 Feb 2024 05:08:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiAJDw5eN6qa8POs40iTfiHHEb/rI9ieOQTBR9KzJjFWWONNoyotynQql4+bMXXnwDod1BGQ==
X-Received: by 2002:a05:6512:3a85:b0:511:4c51:d18e with SMTP id q5-20020a0565123a8500b005114c51d18emr3336161lfu.4.1707138515690;
        Mon, 05 Feb 2024 05:08:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV41yZ8cfXLJxxZH9bT8jss4AsYLJ12FGx76gydrZPmFRyojfsDyeM9YhLPAWQGUy1IMPSMNXuSSN99FB1GAz8K06mkTcddlrieLKvSQgdlUbqWxwmx67d9NnJEkj9osyc8+NN7EJ9Xrzbgdd9Jyt+hNn56woD/A2rRtWpV0OyTrkG3N9AWSVj2cKknWYZmZMi94QSj4eC1RO6pfO1wkDrQ5txPRcZojwwb3IRGfL3lz5NKJo4L/qmyWz0vGRynH1Q8gfuWZFKvF+USWulSfrAp8vBkuT/bFBacRlX4eiVczFLFESw+Kgzwc9TnJoIhlyUrBoBgsvIuQKbwFB85nOSTfs/Z0YmG2IPFXxcYY9BtoWGiSy9HeLetJduZseFna5BeTeY09D3hmQZyLxL3XwsvCNIXXZmSsFHuCfxzdgzxGHAiFRRDxY23AwusX7slkcLiT9x5LlPW3883jdFuOmzvQC3ouweutpSAiRNgx9Uotl8/
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id lj7-20020a170907188700b00a366c9781b7sm4318288ejc.168.2024.02.05.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:08:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 03D63108AEB2; Mon,  5 Feb 2024 14:08:35 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, magnus.karlsson@intel.com,
 bjorn@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 netdev@vger.kernel.org, maciej.fijalkowski@intel.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, j.vosburgh@gmail.com,
 andy@greyhouse.net, hawk@kernel.org, john.fastabend@gmail.com,
 edumazet@google.com
Cc: bpf@vger.kernel.org, Prashant Batra <prbatra.mail@gmail.com>
Subject: Re: [PATCH net] bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY
In-Reply-To: <20240205123011.22036-1-magnus.karlsson@gmail.com>
References: <20240205123011.22036-1-magnus.karlsson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Feb 2024 14:08:35 +0100
Message-ID: <87le7zvz1o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Magnus Karlsson <magnus.karlsson@gmail.com> writes:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
>
> Do not report the XDP capability NETDEV_XDP_ACT_XSK_ZEROCOPY as the
> bonding driver does not support XDP and AF_XDP in zero-copy mode even
> if the real NIC drivers do.
>
> Fixes: cb9e6e584d58 ("bonding: add xdp_features support")
> Reported-by: Prashant Batra <prbatra.mail@gmail.com>
> Link: https://lore.kernel.org/all/CAJ8uoz2ieZCopgqTvQ9ZY6xQgTbujmC6XkMTamhp68O-h_-rLg@mail.gmail.com/T/
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/bonding/bond_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 4e0600c7b050..79a37bed097b 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1819,6 +1819,8 @@ void bond_xdp_set_features(struct net_device *bond_dev)
>  	bond_for_each_slave(bond, slave, iter)
>  		val &= slave->dev->xdp_features;
>  
> +	val &= ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> +
>  	xdp_set_features_flag(bond_dev, val);
>  }
>  
> @@ -5910,8 +5912,10 @@ void bond_setup(struct net_device *bond_dev)
>  		bond_dev->features |= BOND_XFRM_FEATURES;
>  #endif /* CONFIG_XFRM_OFFLOAD */
>  
> -	if (bond_xdp_check(bond))
> +	if (bond_xdp_check(bond)) {
>  		bond_dev->xdp_features = NETDEV_XDP_ACT_MASK;
> +		bond_dev->xdp_features &= ~NETDEV_XDP_ACT_XSK_ZEROCOPY;
> +	}

Shouldn't we rather drop this assignment completely? It makes no sense
to default to all features, it should default to none...

-Toke


