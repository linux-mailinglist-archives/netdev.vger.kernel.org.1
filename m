Return-Path: <netdev+bounces-151015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A6B9EC5E2
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 08:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090B718818D4
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5147F1C5F12;
	Wed, 11 Dec 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jXgl5NEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C05A78F40
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903216; cv=none; b=JvxJlVPgBr35mtnK+5N1rF47/j246R671FhQE2YlC3qkN5WoeQ2KRL3M+IXCiO4hlvfk1I519P+Qqe0DflzVXYRqXmxl1dRlKEgpOJWs8Rx9MQmpgsJOAUs3Ryh0xvUrXr7BXl5Ro0IDO+E9LD70Dtn7dXoCnAfayurM/Ya87J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903216; c=relaxed/simple;
	bh=FnQk6LMP81qmn3S6l8fnW8cTvZUUeI1oGiogDyWmcCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lrquf69AH062kWOmivEFsMyuq2qQILRsJamPGmf+sr2cjQ98MzcXQjcUGQXvCv3GxBt2nDX/Vw/SH/t1Wqxxn55LtQMP05C7vmOaeCqJk4wiXgQNznhoxIUFTyb1sbILqEtRzxoKHEYklHIQbQQgpChLghD2+rzFuCtZND3xfDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jXgl5NEt; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso6294764a12.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 23:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903213; x=1734508013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nihOqOArRew16AAHK4CQFS0f4CQx6/nT7PMwtt+y5Bs=;
        b=jXgl5NEts2r7557zb1sjO4XZj1rnr3ux7KIhX5ywNBsqtmOj21dHs+Wc/YxSyyrEGp
         dyxPFgsOpBoppA4yeeXutCfaSpmqXcMGnPINCo1Y1ZgFtlUHL4cLQxUM8eIwJ9SiIx5P
         WNa5N3ClFXGwLDWtuXiRCax+72RYwmldZpy+EGY4GFx6FsmsJER3TNxmtXPYdqVHtY2C
         W2bhGEXIsX51MtE8u8H0AeMi6rkoVs5cEko8XZ1mzqmAy0g6TVIkHz6zCynf/NNztfTA
         hIlUlRlxujxiBPBdwxGX1AqZoO4i3ctm9xgkipwpCEOTT47ccF8uG0bVOkjSqgCzj06V
         9h4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903213; x=1734508013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nihOqOArRew16AAHK4CQFS0f4CQx6/nT7PMwtt+y5Bs=;
        b=EE3pdEO16iSB3scTV6Zytbl5tpm+TtwSWV8VgXKOAv+DgXXHZqk7j/ITUkmVOmlZby
         3Ph5iamk8ytU32gQd1uyh2u8+l3wjxTYjYdg0cSnrcCWnF/aH0lQwSot0BC3WNgn8+ER
         RK77uawBg1uvdWulwWobVhl47NrURLahWliownfA5xjkoHDQqHD/iGu6xhOPiMmSqt3w
         PdeJKnOho08pFdPtftzshowJcUYi20fjPiyK5dCfQDjAsTzr0HVTFu3fVqFfBWjKCgzV
         S3eRSh7BFaY5giI8R4SbZOM96MJi1AOE04DYHhKewX26s7f9UKU4iPEIaBnDXtoSHsOZ
         /Arg==
X-Forwarded-Encrypted: i=1; AJvYcCVLiWCIFOusz2RcXnG4TBVA7ksw5VD36I3iE/WcmJIZjMoLZglSZGnyLZAJZT2ju/vcXtNZ1ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsM3rADKDT80iEwl3Nv3ISMk2BO0tc3VrZJeyR8PnfSR26j9SC
	uDSr9h8JoCrdG0puf7g8GgrXzNDKXC9zJfHi37KURTiCAL7nhqqsOati3YL2ETc=
X-Gm-Gg: ASbGncsCKWgl/QCwaALCiItamtRNFvp8AJSROy87I0ZcOKHMroj/RHvl8p5eeG3zCwl
	/B3VX5F51hOfGmELg/nfDk7oS9+GcQhL/eN3bwn1U/hD4uH1Cen4r+B5VW1idGHPajqli5voVmm
	lyVBtqeOyXKgiIJJq6l06EuKrYrTckd1IUK28N30H05B+hhtLQ7ez4hsa/PGdSz5szZdeH+p2PP
	Mww7WimrudZkkH0oyTd28wrbF1DJNiG/xvVWr5n+Feh+VaZahLyjTA5
X-Google-Smtp-Source: AGHT+IHwJ5IBl9sNy/TsZfxIeeqn0vDKi5YF+SVvc4dx4slfHBiXb5SyfRrUofds/SELoceBTHQt2g==
X-Received: by 2002:a17:906:1ba9:b0:aa6:995d:9ef1 with SMTP id a640c23a62f3a-aa6b115b17emr151700666b.12.1733903212884;
        Tue, 10 Dec 2024 23:46:52 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e2c3csm949616266b.182.2024.12.10.23.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:46:52 -0800 (PST)
Message-ID: <0f7cf08c-58fc-45f4-84a3-57b8fae91074@blackwall.org>
Date: Wed, 11 Dec 2024 09:46:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/5] bonding: Fix feature propagation of
 NETIF_F_GSO_ENCAP_ALL
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Drivers like mlx5 expose NIC's vlan_features such as
> NETIF_F_GSO_UDP_TUNNEL & NETIF_F_GSO_UDP_TUNNEL_CSUM which are
> later not propagated when the underlying devices are bonded and
> a vlan device created on top of the bond.
> 
> Right now, the more cumbersome workaround for this is to create
> the vlan on top of the mlx5 and then enslave the vlan devices
> to a bond.
> 
> To fix this, add NETIF_F_GSO_ENCAP_ALL to BOND_VLAN_FEATURES
> such that bond_compute_features() can probe and propagate the
> vlan_features from the slave devices up to the vlan device.
> 
> Given the following bond:
> 
>   # ethtool -i enp2s0f{0,1}np{0,1}
>   driver: mlx5_core
>   [...]
> 
>   # ethtool -k enp2s0f0np0 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: on
>   rx-udp-gro-forwarding: off
> 
>   # ethtool -k enp2s0f1np1 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: on
>   rx-udp-gro-forwarding: off
> 
>   # ethtool -k bond0 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: off [fixed]
>   rx-udp-gro-forwarding: off
> 
> Before:
> 
>   # ethtool -k bond0.100 | grep udp
>   tx-udp_tnl-segmentation: off [requested on]
>   tx-udp_tnl-csum-segmentation: off [requested on]
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: off [fixed]
>   rx-udp-gro-forwarding: off
> 
> After:
> 
>   # ethtool -k bond0.100 | grep udp
>   tx-udp_tnl-segmentation: on
>   tx-udp_tnl-csum-segmentation: on
>   tx-udp-segmentation: on
>   rx-udp_tunnel-port-offload: off [fixed]
>   rx-udp-gro-forwarding: off
> 
> Various users have run into this reporting performance issues when
> configuring Cilium in vxlan tunneling mode and having the combination
> of bond & vlan for the core devices connecting the Kubernetes cluster
> to the outside world.
> 
> Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Indeed, I've tested a similar change a year ago to get the expected performance.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


