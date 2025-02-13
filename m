Return-Path: <netdev+bounces-166112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DACA34907
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C75A3AEE64
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815CA201026;
	Thu, 13 Feb 2025 16:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfJBoFPH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276C1E0087
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739462497; cv=none; b=ujbK48Btrk0d01WBaiGDvTnWV56agsTbals8sDoOUXIBrcRbxN1m2z9+Rw2K6VVd8xqSWObyz4EY3pUSshWuMGEGCH7jvQHv14M40EQ/HwDBOmUKAQPQjdPfcc8aPprA7bGOJFwB40BRYBniQ3+TGH3cwBhosmykNgDJdX0wFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739462497; c=relaxed/simple;
	bh=Hfy6lAqDIDE1OOhjjOyqY3Hk/eK787fqBcZfdvyVNmU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=darx9k5UvuXGuvHsJ2NJmwLm60WQdSpmAYvIq9r0kkjTteNxLN6FxzXFI416bdAXIknXkzFKArV/D0/kPIf15ADzw1H2PmymTCA8ceqOVNzTM3d8Krh+x4OVGdV2ANL/xQ923BqWtfvqtp3KB1EHLZxaKOdm+KnB6T0F2xdTaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfJBoFPH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c07351d2feso159165285a.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739462494; x=1740067294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m82pVVXPI/Q3KBO/8frAJiJGmwq7GYTcGNiep1oopPM=;
        b=kfJBoFPHs2fXOJTEjex0WJVi8RqhyTYdJxR+QdAdi6OpfXg5/MrJkx0GVv6kiUmPgf
         wbVrs/XJD1P5nadygdj5dPTxt3VzDPUl6/45AXdHuB7vG9TkJsEqv/sJc7j4ERk3SSrM
         3eToU0TA1jm9yJ7BC7K2eZK6Bj4KmJdU/oBUxqwm/C7epAUOO+CLLXOEInD/HzRKOhRB
         sX1bakYiKwl7wG/1uvBEqBDI/BiVwjSzYxSLSQ7kWt6DZ6qVkzUQdafI33t7ofQfRnxw
         UI6wo3FZH4UdvQgjPzjoG8z/3elizRd4uutHgyhuVlH8vy1xqvTZwerYR4kfUmzdrspe
         IfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739462494; x=1740067294;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m82pVVXPI/Q3KBO/8frAJiJGmwq7GYTcGNiep1oopPM=;
        b=QuPaZ0grlNQvXH1UwofuMjyXFZ7XzfYqWoeBzpPRbIR4PqpGzQb5JEYHxmqaJOfBZk
         BEfVOfUIA+ZEfT0J5gkePUTXpb2LYeJuQNzn51UXefF9pULLY0x0Mcqpbap8RnjEpp8m
         MuY2dAggYWJjzvlkIruJmJizJA8sqziZaDQ2MT8UmYaav9+Y14FM+v5oqwAowxD+43pi
         G2lUTEgEtVVc+1xeq1IV5A83wmCInWs0WBM6jNJ3/o2t2bskTQkZ4imVv6xZU9FOHa62
         LWZMdAZ7/n09pSHmE62QvSRkOz/Llk1ax8lm5p08jI2yuavQmQvZCDQikuf55L2Tovcm
         /IOQ==
X-Gm-Message-State: AOJu0Yy4vEInUnTK5t86yrgQrlVVxmwYAVrte7gjOClvwHhGgPlEXafH
	1HFq7xGm56qEklD7g90UmCGY6crPLQqyxUVlFAQk9UeNhZsuviVcER3OUA==
X-Gm-Gg: ASbGncvc8GSBhTa0YeKSCcbUPaSOcU9YXUByDsXOul5kGjQXHHE57zIE9qiHfnTyi6d
	UQABXUWYThmoXinJ+27yn12Vu3br+KBJxsLy6HIuibuuR/bTISsJmwDb+kCxUMLCZFKURdKB34X
	JOCykBpTPclXvvPZGcTRPHkV1JG30yCW+xgVUscY30Y3mmjGRxCif+CW+RPiBwKi5+glw430bvv
	kK+1u8tXQCP9Qu83bny1p/FpTEksF1mqWuTG9Y4S7RkP8V3yK20OxpyppRJvwxipVdwLobm5t4u
	4ccEN4K0EXyvDvBif+906O5wAKf8JkRYUJswpgUVfHLq4y4GYuEtzvnVjW/MTFI=
X-Google-Smtp-Source: AGHT+IFTdaSCukROAxayaQFytQZ1Xz2xBkTfiTMPW65j8nfkkh/bx4Kh0QPKkmFjymbeT9tCjQ/aGw==
X-Received: by 2002:a05:620a:1986:b0:7bf:f916:faf3 with SMTP id af79cd13be357-7c07a112bdemr592682385a.8.1739462494383;
        Thu, 13 Feb 2025 08:01:34 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861afbsm103647585a.82.2025.02.13.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:01:33 -0800 (PST)
Date: Thu, 13 Feb 2025 11:01:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemb@google.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <67ae175d7a7fc_24be45294be@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250213003454.1333711-4-kuba@kernel.org>
References: <20250213003454.1333711-1-kuba@kernel.org>
 <20250213003454.1333711-4-kuba@kernel.org>
Subject: Re: [PATCH net-next 3/3] selftests: drv-net: add a simple TSO test
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

> +def test_builder(name, cfg, ipv4, feature, tun=None, inner_ipv4=None):
> +    """Construct specific tests from the common template."""
> +    def f(cfg):
> +        if ipv4:
> +            cfg.require_v4()
> +        else:
> +            cfg.require_v6()
> +
> +        if not cfg.have_stat_super_count and \
> +           not cfg.have_stat_wire_count:
> +            raise KsftSkipEx(f"Device does not support LSO queue stats")
> +
> +        if tun:
> +            remote_v4, remote_v6 = build_tunnel(cfg, ipv4, tun)
> +        else:
> +            remote_v4 = cfg.remote_v4
> +            remote_v6 = cfg.remote_v6
> +
> +        has_gso_partial = tun and 'tx-gso-partial' in cfg.features
> +
> +        # First test without the feature enabled.
> +        ethtool(f"-K {cfg.ifname} {feature} off")
> +        if has_gso_partial:
> +            ethtool(f"-K {cfg.ifname} tx-gso-partial off")
> +        run_one_stream(cfg, ipv4, remote_v4, remote_v6, should_lso=False)
> +
> +        # Now test with the feature enabled.
> +        if has_gso_partial:
> +            ethtool(f"-K {cfg.ifname} tx-gso-partial on")

Is the special handling of GSO partial needed?

This test is not trying to test that feature.

> +def main() -> None:
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        cfg.ethnl = EthtoolFamily()
> +        cfg.netnl = NetdevFamily()
> +
> +        query_nic_features(cfg)
> +
> +        tun_info = (
> +            # name,         ethtool_feature              tun:(type,    args   4/6 only)
> +            ("",            "tx-tcp6-segmentation",          None),

tx-tcp6-segmentation implies v6 only? The catch-all is tcp-segmentation-offload.

> +            ("vxlan",       "tx-udp_tnl-segmentation",       ("vxlan", "id 100 dstport 4789 noudpcsum")),
> +            ("vxlan_csum",  "tx-udp_tnl-csum-segmentation",  ("vxlan", "id 100 dstport 4789 udpcsum")),
> +            ("gre",         "tx-udp_tnl-segmentation",       ("ipgre",  "",   True)),
> +            ("gre",         "tx-udp_tnl-segmentation",       ("ip6gre", "",   False)),
> +        )
> +
> +        cases = []
> +        for outer_ipv4 in [True, False]:
> +            for info in tun_info:
> +                # Skip if it's tunnel which only works for a specific IP version
> +                if info[2] and len(info[2]) > 2 and outer_ipv4 != info[2][2]:
> +                    continue
> +
> +                cases.append(test_builder(info[0], cfg, outer_ipv4, info[1],
> +                                          tun=info[2], inner_ipv4=True))
> +                if info[2]:
> +                    cases.append(test_builder(info[0], cfg, outer_ipv4, info[1],
> +                                              tun=info[2], inner_ipv4=False))
> +
> +        ksft_run(cases=cases, args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()
> -- 
> 2.48.1
> 



