Return-Path: <netdev+bounces-167155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF974A39054
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03113AECA5
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8253537F8;
	Tue, 18 Feb 2025 01:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOnXH10y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0A2AE74
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841720; cv=none; b=iu9wv4efci0W8IY5BaR1QZemQSbLWYxinP+anLX1jzTZNxXWH1nIMGo3dvMyxsT+56Q4hU6PLSpLLQDXTIzA1wW2JPMAWNqgZjxYzNDLWYFmwTTF/AatDr3Yts4IOz1bU7QI0o7y314AMxTo3XVrNv9mi9+OtruFRZsjWBdZf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841720; c=relaxed/simple;
	bh=5YDAaH9ePfyjIuogmaTlTM7VqSOok1Cck+HGvE+m1MY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PxipSlZSj3bNmXg7RMwWlGTOfzVregtPdIDfLKNf5Xqu0avuhO1TRoxOKLrvC0Ec6uy0AC8iO8bKb7sN6NDVLApLqdex7uHlgexR3OdMdXYwpfBBZX7Zy0FNyJBCceG21SeLACXSXSTEV6+KPg5PaW7luy9ext5oEmzp1F2NY2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOnXH10y; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be8f281714so523123785a.1
        for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 17:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739841718; x=1740446518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLP5KgbATxiA0mewxoF9U/sNl+nyo86wkA8b2h9k9Cw=;
        b=bOnXH10yrgHWVBHPUW5peYSMyC9hwuAWudKToJFGchm/eSndyTvbcjR4eDuZm4qZ5w
         GQqdmZ/ViGu2bPCOcD25e5Ntiyben0YkhEBVmaqa2tB5NA+2vjRkeHRN8UrfhbB3TqVf
         y5N/RFYqP6o0q4t2snfbIcEu8vO6CyOspu4ukO5CRRNc3RLIH5EU4cRyslSgwxvwEBz1
         0ePal4PWaRg8DeUKMlJMecYSJMVcY5IaGvRVuQ/OaWkyxMI8rjnXMkikrRDeR6l1uUQ5
         FtD9qXU2FdqlRGiLkfoe+uLDQnt7505KwsubB3zoiqQtO71rIhvbK0GXAGQu3cyLT4vR
         QKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739841718; x=1740446518;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WLP5KgbATxiA0mewxoF9U/sNl+nyo86wkA8b2h9k9Cw=;
        b=axgsZzDbR9y/WhJ7U5XW90akATrYlTCx8f0szfTaRvOXwVPnteHG9X/i8+Jb221u+J
         vbr8GQ48C29OeVgjKq0nTkGB4x3d3zW0HQ/V4/FvnBBsyZUyhf+XcEPhE2sCAuR31jTq
         97G4Pl2ln6FV+0AY72BLkWXVNFVjbtVbESlhA3Dx6Ac6VDg4dlKCpwKnHhQVi3IQbafE
         ml3paUUt3bVZLMrNREkHHk9NA0OI8bAwDgwj3+kOzFgpEGJvVpHav5scrAcao/KjNaQd
         t3veAnqPRmf0mnLpR2dC6eTJHWhQg2snqZJoVoDGTSmA/eRN/Qm3H+DLaKTwak0cU4gp
         i5EQ==
X-Gm-Message-State: AOJu0YygATgWD1Lnim3RhueFHVkFoGTOIzDgxSO9NStCWlnercp5JQIJ
	d6G8zdbV8NM/XldPWT6nmB1y84Ghb/mjikauzElY89WAV6gUl2f5
X-Gm-Gg: ASbGncuuTF70+FN4IhhlZ+wm75Rz2h5HHIO4F7h7/m70eLHFMZCMScybg6r87iXsQby
	tnpvn9vuvawGgdEyyqe+mDGMjvHBggr42W6/2Mr2zuBEfAEjIGzMYVEkN5zkMIvxdab64DeM3SY
	fBA1tH5KXhwLY48QSb68syzx48d+CmsYd82tCPgAHvGyihMhCfSSVN0Zu7rzi27/G9TguDc3JXv
	ZqFiso8JYAMFZ7so2aR/ltguGrXVxhjpdElfzr07ua1wPRJJhHi9+yISILon/g4nfMQBuf3q8GQ
	5qP/OhtKF0NClG9zBL1Dj4PDqEJLOMZPnJFNXwzLUHgUSYr78lmFp3fQNxfkNGc=
X-Google-Smtp-Source: AGHT+IEnhEDdvjEKhM89ZFKIm0NTkCNnE5bQ6WJ8XIM2CFsNSJg2tR0cqqIZclr2QddktymhJwjixA==
X-Received: by 2002:a05:620a:3186:b0:7bd:bafc:32b0 with SMTP id af79cd13be357-7c08aa72db9mr1898709085a.47.1739841718105;
        Mon, 17 Feb 2025 17:21:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f46a8sm57864246d6.82.2025.02.17.17.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:21:57 -0800 (PST)
Date: Mon, 17 Feb 2025 20:21:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 petrm@nvidia.com, 
 stfomichev@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67b3e0b53f246_c0e25294ee@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250217194200.3011136-5-kuba@kernel.org>
References: <20250217194200.3011136-1-kuba@kernel.org>
 <20250217194200.3011136-5-kuba@kernel.org>
Subject: Re: [PATCH net-next v3 4/4] selftests: drv-net: add a simple TSO test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Add a simple test for TSO. Send a few MB of data and check device
> stats to verify that the device was performing segmentation.
> Do the same thing over a few tunnel types.
> 
> Injecting GSO packets directly would give us more ability to test
> corner cases, but perhaps starting simple is good enough?
> 
>   # ./ksft-net-drv/drivers/net/hw/tso.py
>   # Detected qstat for LSO wire-packets
>   KTAP version 1
>   1..14
>   ok 1 tso.ipv4 # SKIP Test requires IPv4 connectivity
>   ok 2 tso.vxlan4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 3 tso.vxlan6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 4 tso.vxlan_csum4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 5 tso.vxlan_csum6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 6 tso.gre4_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 7 tso.gre6_ipv4 # SKIP Test requires IPv4 connectivity
>   ok 8 tso.ipv6
>   ok 9 tso.vxlan4_ipv6
>   ok 10 tso.vxlan6_ipv6
>   ok 11 tso.vxlan_csum4_ipv6
>   ok 12 tso.vxlan_csum6_ipv6
>   ok 13 tso.gre4_ipv6
>   ok 14 tso.gre6_ipv6
>   # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:7 error:0
> 
> Note that the test currently depends on the driver reporting
> the LSO count via qstat, which appears to be relatively rare
> (virtio, cisco/enic, sfc/efc; but virtio needs host support).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v3:
>  - rework after the v4/v6 address split
> v2: https://lore.kernel.org/20250214234631.2308900-4-kuba@kernel.org
>  - lower max noise
>  - mention header overhead in the comment
>  - fix the basic v4 TSO feature name
>  - also run a stream with just GSO partial for tunnels
> v1: https://lore.kernel.org/20250213003454.1333711-4-kuba@kernel.org

> +def test_builder(name, cfg, ipver, feature, tun=None, inner_ipver=None):
> +    """Construct specific tests from the common template."""
> +    def f(cfg):
> +        cfg.require_ipver(ipver)
> +
> +        if not cfg.have_stat_super_count and \
> +           not cfg.have_stat_wire_count:
> +            raise KsftSkipEx(f"Device does not support LSO queue stats")
> +
> +        if tun:
> +            remote_v4, remote_v6 = build_tunnel(cfg, ipver, tun)
> +        else:
> +            remote_v4 = cfg.remote_addr_v["4"]
> +            remote_v6 = cfg.remote_addr_v["6"]
> +
> +        tun_partial = tun and tun[1]
> +        has_gso_partial = tun and 'tx-gso-partial' in cfg.features
> +
> +        # First test without the feature enabled.
> +        ethtool(f"-K {cfg.ifname} {feature} off")
> +        if has_gso_partial:
> +            ethtool(f"-K {cfg.ifname} tx-gso-partial off")
> +        run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=False)
> +
> +        # Now test with the feature enabled.
> +        # For compatible tunnels only - just GSO partial, not specific feature.
> +        if has_gso_partial:
> +            ethtool(f"-K {cfg.ifname} tx-gso-partial on")
> +            run_one_stream(cfg, ipver, remote_v4, remote_v6,
> +                           should_lso=tun_partial)
> +
> +        # Full feature enabled.
> +        if feature in cfg.features:
> +            ethtool(f"-K {cfg.ifname} {feature} on")
> +            run_one_stream(cfg, ipver, remote_v4, remote_v6, should_lso=True)
> +        else:
> +            raise KsftXfailEx(f"Device does not support {feature}")
> +
> +    f.__name__ = name + ((ipver + "_") if tun else "") + "ipv" + ipver

use inner_ipver if tun?

based on previous version of the patch:

    +    if tun:
    +        name += ("4" if inner_ipv4 else "6") + "_"


> +    return f
> +

