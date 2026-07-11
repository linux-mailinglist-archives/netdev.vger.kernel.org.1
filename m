Return-Path: <netdev+bounces-306797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AQOWNkYRUmrKLgMAu9opvQ
	(envelope-from <netdev+bounces-306797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:47:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1367411B5
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:47:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=PUdOj3DH;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306797-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306797-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 430083009544
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2437A30EF7E;
	Sat, 11 Jul 2026 09:47:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C585368D46
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763268; cv=none; b=s1rtKsGp+kiAnZIZnfbmEGDx1Kj/G8V7lUk/BiTZ2liaYT0WKtYWh7AaxTkcTU+vhID1nfuAr5KprxsbPal2jxQlwS0EQbDKhb9fH9Og/CMJMl1GbXk2eN7TgHRv+O9XZHRsWUxaEexSnSfRud56kS7Uv5H6xdzyYLfmT2QVf8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763268; c=relaxed/simple;
	bh=D/JWDGiv+GFbLz/rmqVwJwoWaRCj4idGRuN0Yr6rH2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7ek4KoW1Ul3jyWds82gRSNh08uwLsqgd9X2aglU1wMef8XB8qD+A2m0iuP88MhCepm0tec63PEfgSDZRTes1dZuPEWLwG2yocUNsOx+GCgAQYNoU02xUG9kf1X+rohbVPDKZIxwNNJ1bCF8nK0rKw9M2DTzjfwU3UTKtIEs1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=PUdOj3DH; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493b779003fso7802755e9.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1783763264; x=1784368064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aWhxyFPSwTbaR6FrKsip6tznrAqeOIOdJdsCVc6RZdw=;
        b=PUdOj3DHg7a4b6YmnvEtqI1/3ONlwJqiIqRTKByD2xr/UsSCaeUN4UjdHjvgym1cgv
         cYzOKe/qgLFx+hYeQDjp1Hdesmz/cpQnAqMuqf5wJPKIqybjCzZoxVxZZizkY6Tofgsc
         mLMeISdXoBN9gZQheU8DR9Z9tlZV6+qPA+taQDnCj7y2tEyqv6izIvba3hxvQOi2Xlh8
         oWU8NKHklULdfpSZ/X+mXklPc7VBhd7LKWJgqIdD3znvyKv1ec+ioCxOkJI2e2UskVo2
         X11gF8ehu22QDRz/JYNTeVPIMaVWim0i43tNhvX1jgEejceMQcJ1h1GYYSZev1K4rMJS
         cnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783763264; x=1784368064;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aWhxyFPSwTbaR6FrKsip6tznrAqeOIOdJdsCVc6RZdw=;
        b=MLe9IBPuOquZTWw45/aH8FC6/0Q+P7BFiMxWjHxG/xYCFQ2A/SXsEepjCQlkew5bmS
         BDwnVL6I1475wpePwmlppF0/hCxmwaQeF1q3k8ndGtREaVxMf11qkefefn95Md91Vqgw
         kFnco6XoGp68P96xkBVS9d+fIQtp5KzXSbOcu+syDTqCp1NHt+Vl983kcKEWJNXJa1qC
         koIpF9eGXyEklw0BzQbnkjUPx4df1ZFkx4tn1yR5uZqHl/LtF5cxFqO0AsVohEwNLKRv
         LKxSRtiBNqvc81DWHHNGmkfA6mPbfobP1WS37rB3wQkBENcLoiNtfRAdjK+f3WrroOUq
         Z85g==
X-Forwarded-Encrypted: i=1; AHgh+RrY2Y5Q+zNgdRAcJiK1X5kIv/yd42Y31TNtMzTYQY4pJDXkdPkq7Ra7wL77xRC3sFR6Guhnxro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTlB8BM8lmVS8IbFaQsv42dcnOEC0wuvr07uT9+9gZ9yEItFJ
	nZodsdZ6X75LWevv0M8w8QFuhCsvEHkXt2PQw7Tn3s4tDLqTmjz92EtIsz2ovaZRMZo=
X-Gm-Gg: AfdE7ckimuyt5xkQNuX3XYtCBQa8y3kFXGXvzkDjADVDwIZKqRfZIZ/l2aM+5M+QaEI
	685WHGggmeokjK0K+ZiccuUWHKQC5u7GyBDP/Y/W/Tb1YtIaCshlPgAp8VOaS/RxxdFt7dWqC7i
	9ER1HohNMXKenKctg1bHyvXWB1hZKdNpPVz0ruDD/Ahqyhm1bMX4RFlP/ZVAd5B/ZuurhUIHTmg
	sznxhf7DZMAU/wK6UHH02+GzMCfQ+6Fd/Z9LfQ6R1f19jNREytY3S7ADqhK/RCJHED9wMb63bZJ
	qcjUox2/hNVvVGeqJVT2Sazd0jR2W+Kq1NGTcUutqwMbdziZxYi69ODswEIls8dVas+P4i3Nbu0
	cLB5cVWhVUSIg4q0QrVsZnH6BLjXI3fWTfZ/uJCWQLJlTUrHT70xiirX/7ye8kCGFzjqxj0JtjA
	zeHpre9USf5wzPqEPhnGD/JdS+4Y1zX7G6dImfQjHLp9Y=
X-Received: by 2002:a05:600c:4e8e:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-493f87e5945mr20258105e9.14.1783763263451;
        Sat, 11 Jul 2026 02:47:43 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3b85sm331096245e9.2.2026.07.11.02.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 02:47:42 -0700 (PDT)
Message-ID: <a6f4c117-f58f-4cd7-910a-0fff3c3aeb27@blackwall.org>
Date: Sat, 11 Jul 2026 12:47:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
Content-Language: en-US, bg
To: Alice Mikityanska <alice.kernel@fastmail.im>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xin Long <lucien.xin@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <stfomichev@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
 Alice Mikityanska <alice@isovalent.com>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260710134242.216538-1-alice.kernel@fastmail.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306797-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alice.kernel@fastmail.im,m:daniel@iogearbox.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lucien.xin@gmail.com,m:willemdebruijn.kernel@gmail.com,m:willemb@google.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:fw@strlen.de,m:netdev@vger.kernel.org,m:alice@isovalent.com,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,isovalent.com:email,blackwall.org:from_mime,blackwall.org:email,blackwall.org:mid,blackwall.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D1367411B5

On 10/07/2026 16:42, Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
> IPv6 BIG TCP doesn't require stripping the HBH in all various
> combinations in tunneled traffic, adding BIG TCP becomes feasible.
> 
> Patch 01 adds accessors for the length field in the UDP header, as
> suggested by Paolo in review. The usage of udp_set_len is then added in
> the following patches that start using length=0 in BIG TCP UDP packets.
> 
> Patches 02-04 close the gaps that prevent BIG TCP packets from going
> through UDP tunnel code.
> 
> Patch 05 validates packets in udp_gro_receive to exclude packets with
> length=0 from GRO aggregation.
> 
> Patch 06 is for proper formatting in tcpdump (set UDP len to 0 rather
> than a trimmed value on overflow).
> 
> Patches 07-08 bump up tso_max_size for VXLAN and GENEVE.
> 
> Patch 09 adds selftests.
> 
> Thanks all!
> 
> v9 changes: Converted the selftest to iptables counters to avoid the
> issue with tcpdump pcaps taking all space in /tmp.
> 
> v8: https://lore.kernel.org/netdev/20260706181941.385672-1-alice.kernel@fastmail.im/
> 
> v8 changes: Addressed Paolo's and Jason's review comments. Made the
> selftest more robust, added checks for SACK and mode with disabled tx
> checksum offload on lower veth netdevs. Added details to commit
> messages. Kept skb_segment logic unchanged, because the frags overflow
> issue is not specific to BIG TCP.
> 
> v7: https://lore.kernel.org/netdev/20260611192955.604661-1-alice.kernel@fastmail.im/
> 
> v7 changes: Addressed Paolo's comments to properly block malformed
> packets with UDP length=0 at udp_rcv level.
> 
> v6: https://lore.kernel.org/netdev/20260602093931.516281-1-alice.kernel@fastmail.im/
> 
> v6 changes: Lowered the packets threshold in the selftest to pass
> upstream CI on debug kernels, also made it configurable.
> 
> v5: https://lore.kernel.org/netdev/20260526161200.1135899-1-alice.kernel@fastmail.im/
> 
> v5 changes: Rebased, dropped one of the patches that came in via the net
> tree, addressed an overflow in nsim_do_psp found by Sashiko.
> 
> v4: https://lore.kernel.org/netdev/20260512165648.386518-1-alice.kernel@fastmail.im/
> 
> v4 changes: Rebased, addressed Sashiko AI review [1] and Willem's
> comment about netperf flags.
> 
> My comments on Sashiko AI review per patch:
> 
> 01: I'd prefer to keep the cases that I haven't tested outside of the
> scope of this series, which is for VXLAN/GENEVE tunnels, not for ESP.
> 
> 02: The patch doesn't have behavioral changes other than fixing the
> checksum. The final uh->len assignment assigns the actual length, not
> 64k.
> 
> 03: The check can't be loosened, because total_len is also assigned to
> UDP length. BIG TCP works in the mode without GRO hint option.
> 
> 04: Fixed the fallback value for udplen. BIG TCP is fine, it's the
> uh->len = 0 case, uh->len can't exceed 64k.
> 
> 05: In the BIG TCP case, partial GSO splits the SKB in two. If full
> segmentation is needed, the SKB is split in many MSS-sized SKBs without
> fragments.
> 
> 06: Invalid packets from the wire are addressed in 08.
> 
> 07: __udp_gso_segment only handles UDP GSO packets, which can't be
> bigger than 64k. Kept udp_set_len_short in nf_nat_mangle_udp_packet, as
> the function doesn't support BIG TCP packets anyway (see
> mangle_contents).
> 
> 08: udp_gro_receive handles packets before aggregation, there are no BIG
> TCP packets at this point. RFC 768 doesn't say that padded UDP packets
> are valid. Real jumbograms don't seem to be supported in this path
> anyway.
> 
> 09: The packet goes to skb_udp_tunnel_segment, not __udp_gso_segment.
> __skb_udp_tunnel_segment handles this case.
> 
> 12: Improved process cleanup by killing everything inside netns before
> deleting them, and by avoiding killing netserver outside of netns.
> netperf with -r in TCP_STREAM mode works, and the option has the
> intended effect, but I replaced it with -m. Added dependency check for
> tcpdump.
> 
> [1]: https://sashiko.dev/#/patchset/20260410150943.993350-1-alice.kernel%40fastmail.im
> 
> v3: https://lore.kernel.org/netdev/20260410150943.993350-1-alice.kernel@fastmail.im/
> 
> v3 changes: Fixed the redirect in the selftest, rebased over my L2TP fix
> [2] for the syzbot report [3].
> 
> [2]: https://lore.kernel.org/netdev/20260403174949.843941-1-alice.kernel@fastmail.im/
> [3]: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/
> 
> v2: https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/
> 
> v2 changes: Addressed the review comments: added UDP len helpers,
> consolidated UDP len sanity checks in patch 08 into one, added
> selftests. Added fixups to related code (patch 01-03).
> 
> v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/
> 
> Alice Mikityanska (8):
>    net: Use helpers to get/set UDP len tree-wide
>    net: Enable BIG TCP with partial GSO
>    udp: Support BIG TCP GSO packets where they can occur
>    udp: Support gro_ipv4_max_size > 65536
>    udp: Validate UDP length in udp_gro_receive
>    udp: Set length in UDP header to 0 for big GSO packets
>    vxlan: Enable BIG TCP packets
>    selftests: net: Add a test for BIG TCP in UDP tunnels
> 
> Daniel Borkmann (1):
>    geneve: Enable BIG TCP packets
> 
>   drivers/infiniband/core/lag.c                 |   2 +-
>   drivers/infiniband/sw/rxe/rxe_net.c           |   4 +-
>   drivers/net/amt.c                             |   6 +-
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   2 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
>   drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   2 +-
>   .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +-
>   .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
>   drivers/net/ethernet/sfc/falcon/selftest.c    |   4 +-
>   drivers/net/ethernet/sfc/selftest.c           |   4 +-
>   drivers/net/ethernet/sfc/siena/selftest.c     |   4 +-
>   drivers/net/ethernet/sfc/tc_encap_actions.c   |   2 +-
>   .../stmicro/stmmac/stmmac_selftests.c         |   4 +-
>   drivers/net/geneve.c                          |   4 +-
>   drivers/net/netconsole.c                      |   2 +-
>   drivers/net/netdevsim/dev.c                   |   2 +-
>   drivers/net/netdevsim/psample.c               |   2 +-
>   drivers/net/netdevsim/psp.c                   |   8 +-
>   drivers/net/vxlan/vxlan_core.c                |   2 +
>   drivers/net/wireguard/receive.c               |   2 +-
>   include/linux/udp.h                           |  27 +++
>   include/trace/events/icmp.h                   |   2 +-
>   lib/tests/blackhole_dev_kunit.c               |   2 +-
>   net/6lowpan/nhc_udp.c                         |  10 +-
>   net/core/pktgen.c                             |   4 +-
>   net/core/selftests.c                          |   4 +-
>   net/core/skbuff.c                             |  10 +-
>   net/core/tso.c                                |   3 +-
>   net/ipv4/esp4.c                               |   2 +-
>   net/ipv4/fou_core.c                           |   2 +-
>   net/ipv4/ipconfig.c                           |   6 +-
>   net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |   4 +-
>   net/ipv4/route.c                              |   2 +-
>   net/ipv4/udp.c                                |   7 +-
>   net/ipv4/udp_offload.c                        |  49 ++---
>   net/ipv4/udp_tunnel_core.c                    |   2 +-
>   net/ipv6/esp6.c                               |   5 +-
>   net/ipv6/fou6.c                               |   2 +-
>   net/ipv6/ip6_udp_tunnel.c                     |   2 +-
>   net/ipv6/udp.c                                |   7 +-
>   net/ipv6/udp_offload.c                        |   2 +-
>   net/l2tp/l2tp_core.c                          |   2 +-
>   net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
>   net/netfilter/nf_conntrack_proto_udp.c        |  15 +-
>   net/netfilter/nf_log_syslog.c                 |   2 +-
>   net/netfilter/nf_nat_helper.c                 |   2 +-
>   net/psp/psp_main.c                            |   2 +-
>   net/sched/act_csum.c                          |   4 +-
>   net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
>   tools/testing/selftests/net/Makefile          |   1 +
>   .../testing/selftests/net/big_tcp_tunnels.sh  | 188 ++++++++++++++++++
>   53 files changed, 340 insertions(+), 102 deletions(-)
>   create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
> 

Very nice work. The set LGTM.

For the series:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Thanks,
  Nik


