Return-Path: <netdev+bounces-237866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5572AC50F95
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 08:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 885E64E5A95
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 07:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB242C1589;
	Wed, 12 Nov 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vih4wtyP"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-47.consmr.mail.ne1.yahoo.com (sonic306-47.consmr.mail.ne1.yahoo.com [66.163.189.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEDE283682
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933213; cv=none; b=VUu9+TH9d/8V2JQPvloRdjGR4qPPmlVqYAqKDnz32l6o5h8pNhPTI0MVhHe65k51Aiu8L489jZwLg82pZotmhouxRwkXFWKW7watJkZzVxdxPQPOQB8nFx46RgkbpLT5F7XIkrLJfOtaNyRRewaNR0MuBug803CK1HtbNCM3rUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933213; c=relaxed/simple;
	bh=LSzdYuWoamHebh03fKJ8/lv8BD0HLynbeo5r9QrB2P8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=kpl0Bb8t/CBEXngG/UG8G+bf64f9raSJZofpF2e6z7poXMjtC4EohRvb5IeSwNvGjRYot5K/kqTa9yA6kX7tsErl/gdEN09DuiNJORDqunlh+XEPtn0OJGu/6gVc9/G1c+y9gkvF3frgl38j3C2QWT1w7+Mjh+dyey8uhr2h03o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vih4wtyP; arc=none smtp.client-ip=66.163.189.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933210; bh=xDuVxFAiRdNFEFecMfUNl5KnR+phJ1+xrKIDXhBhgeg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Vih4wtyP7sGTNQkcYoz2sqKuv2DmlemAiuQ1Cn7yKacIIBepUjukw/lHezk832volCKA+t6CWDqH698Ula0WW155Bi7s+6uUnIW7/cnD1pQeVdyGun811zi2ekPH9tplihBevnUna8rlris0xBUP7+1YWiQCLXlYMTGKDJhrhsi6KUrv8Rzta4VZl8aBM2NDPyGmdJhclOkuSAha6apkgMElGHyKCsRih1DT6BI3dItRTvbLocqR5msQI6UVl8r4dBDTW5gyuA7tnjjFv4y99re4Ah2WNqXCIOkINqsWxQRN2Pa2/30nveUaPnlxGL5TY3bEaXkIuAyZJ/Sef+LuQw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762933210; bh=dkrYOcReryFqabQmSxkJPX6XQeI5Ddg2tViiXDR4eEO=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=k8EOicgKGnYOJVn3KVpl2GHdWgxEWcN/1H/GDQNGC0AEegB4mkxJKxd9cSWQutgbmlmpahMSI8G6tATtiSfCCz5Z4Kl59qnR8F6CmLdvBCSMSAfOKZPGpJ0gQVsmDmVXjxXWL2q2o38ebz3wQ62qroQGgf5zRhVb0rs6xoz69YKgGH0QXYNIeRUCAYtxhqeYTHsgmGT5sVNwpocokEwLcrdkjLds8GGLRRr+H/EnKgkP7hAv9dQrDGjb5vrI7EYb8vB0quUZrEpco27G3y0Pi9N9qWFSaFKTD4mRJJ4sXBu9Npml6E9iRuisgmUdqkllTk3tXKqf4IYfdcpalXpmlA==
X-YMail-OSG: Hl8o79gVM1kkVw9eBYg9MfDR4kTQ1gnv3_jMj7jNTPk8YKzGc4KrkDUmGwasjnt
 5ffCIKOV3bQwf85lD2_uo6FEk3XWYYa9jYDG89h0CBVcYLlbtGXCKdOwXStyCmu3HM.b4LDeGFzi
 sH39UbtJjSSHBt7pMb6K.eydwmI3akd0n5ou86igyT3H.p_Xa96x8hj4NEmCncPgVHQdH8JZzkOO
 xZbryVSSW4cOb9IlPe1NCtAvJZBI8cEns42qjJJAwNG.SSu5wkvJ3HYdINSd1g2_SIVV4Y4Pj8QO
 ba49IROW8H.3AiahWmA3orAdznS6JqZIiEOmrc4fZM20Lz7iGNLaRDnl2J2zqGN.58NHYd_d92BB
 2.oWJy3kYnUAPJ7BQxIhz5jjV8KFx8i1ezcRMPR_cYl.DT3OetKo3TZh4HDbvU_xytLkMW.Ji9j9
 3rvB1EClITQvTUsy45np79i1KA5UQdNkRs5a9mTiVCmFbZpkMjZ2DbtEFMiKu676HD4NhD.pPjI4
 _jYfAChUYvtQBJIRFr_F1vSL4AfI3jymjw_djGzvbgG28SB_KzBMUVVbtXeq7lCMwLigwwERn9.q
 geAIqdvSZoV4hFOJWlkTpOgXBO5FVfnrlNYATnCcmYskOOBOlZmd.5USsCgHxfiw.wIRJOsLtsLn
 ijOgUvDxBpnYADsg5Ek5ixyo7ZMVlvUqeNYWMoYEAizBvOnnaTz4xOVVs2nKeDU9oz5_hugO4Qct
 8nHrPa5byWV0guTH.8EpIlPbpEAKCN94YfyLUs9c5e3Pa0DWcm0It5kJ8qutcrt56oVetEOP_eBW
 UOeVZTVahDX2KD8Wrsnt12lqdRUzqYfHpABlUwM_zANZE_IWhfsEHP14HWt.z1_vWLILSBzgtAGE
 edBaZkA03b.9vRcHr3I7YtxNovfuSLuxGzXHYVMsDyJ5ga5VTP66j.hTKDZqFYW_1yjcOoQAgKcO
 ToC5q9xOyn98FHDYQ6.me_qKvspuiyWtrqtYN958.JnAcHV0fiW1NKJZYN3DOdbolRc7ZwRq8_zI
 2qBQdHx6brbNYlTgfxXwYA4tkUBxzNjus4ZVN9A3Nf9qnFc83dxuVBwB2nGD5lRjLPLSpNnn4g6g
 CB2xn7rec_C7knvdEyBpgX8KX1L0JefrSzjvWu8vWnIKsxqFDs2swszJis3RAWMGkrEc1hj7RRc4
 eXC3K0rhytLbTx0nKfnAFS7bUMa5.EpeX5WGJCf.0htKRWSSrBK8DDbFXvlz43LnOJC9nsjOWTYa
 ZUAzjJwKv0Vbu3GASE_trekdkAop_aDMi.scsCFCDzkU.cnGRL4_cvBOgr7jSur3tkoHpugTARTr
 jJXeHADJnLkHEfzimfObMd3Rr3JSQ7MrNI7u5l6DS3uLEPLBM4.INfJ8ytqkbkWL4UtX6OB29Sm0
 fjbLRfrk3t5M2YK5JAFe8VsKrheKjd9wL18JZldwM9oSc5cXTCcr8Xz_fUw07AN9PLxx8MHWOLaH
 sHe0o.Ex7MIByl_.PDtOiJtgJC_n_iOTMM9pKJ2.ohyQpCL8w4ShYP87NY7sH4z3IiOc4.oDI0dU
 egpeMcvvxwGLHWerx6AVqbjpvMXeLbzpU3eWoXFs.LNxITyrdu_Q3p4zRdPwGcWu.Y.CUIg6GOlB
 XJz3PtYLPMAzKALZwhYV8LeMsY4gghuNHUxjvVpJafb5_6EooAtGMkdjOn61gYCeTNoApPrPEaMl
 D06fiCHX7d0NX8PEwXhl2hOHeFPEEu8qWaLFxTKd_CNLSnM1jNleiD8VgN1xYDNDr6nt0_MgfV4x
 lfPGPjMDSaITUsuNl5VC6S9SrXZ4vSyeCf7zYFvS6Fmv.dK5WiFQViZoLrci8AEJgqpZkNJN3Hiz
 jUG_xBKtBrPXKyTiN_a.uHrWGYOjbkjCsRkjgpogbWIWEsBtDhb2CyXdRe_A3q1AzTNeB7ZHsYdU
 IO6T..DQ48ZrWja70dvIQymTXIyzbVM8cb_LUEB5AzsZMN2bgNHXKRQbCr8bZK9lSjoIUHEe2oSw
 wvxpJz8m9vpvCYFZ_RqL1ld1DvuLR8j47QB62ujpjyBOPUhb5N5bTQNMzMEH.QDzrTvnHT5p8o65
 QlD2rNRxWJFHeIoQJT.Ard6pMOWeSpqU6yTTDJD93KuBdJF0xbW7a00Uxn.LscIZut6TUInERXsi
 U2TFVz6_t9Gx74MehWDpuAlYURzcFM7MCOZnEBE55jwY8JEWD4oqRyqfcDhZnh4KPWHimRr1guGN
 V
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 5c5f95ce-5aca-4c2d-ba4c-8828507c9556
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 12 Nov 2025 07:40:10 +0000
Received: by hermes--production-ir2-5fcfdd8d7f-2cnbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ce2e5d13638178c4daec60c4681fbbb6;
          Wed, 12 Nov 2025 07:27:57 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v4 00/14] net: tunnel: introduce noref xmit flows for tunnels
Date: Wed, 12 Nov 2025 08:27:06 +0100
Message-ID: <20251112072720.5076-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251112072720.5076-1-mmietus97.ref@yahoo.com>

Currently, tunnel xmit flows always take a reference on the dst_entry
for each xmitted packet. These atomic operations are redundant in some
flows.

This patchset introduces the infrastructure required for converting
the tunnel xmit flows to noref, and converts them where possible.

A new opaque type "dstref_t" is introduced. It represents a potentially
noref pointer to a dst_entry.
This allows for noref flows while still allowing the original referenced
flows in cases where noref can't be used.

Additionally, RCU variants for dst cache helpers are introduced,
since most tunnels rely on dst cache for dst resolution.

These changes improve tunnel performance, since less atomic operations
are used.

There are already noref optimizations in both ipv4 and ip6.
(See __ip_queue_xmit, inet6_csk_xmit)
This patchset implements similar optimizations in ip and udp tunnels.

Benchmarks:
I used a vxlan tunnel over a pair of veth peers and measured the average
throughput over multiple samples.

I ran 100 samples on a clean build, and another 100 on a patched
build. Each sample ran for 120 seconds. These were my results:

clean:      70.31 mb/sec, stddev = 1.63
patched:    73.13 mb/sec, stddev = 1.28

TL;DR - This patchset results in a 4% improvement in throughput for
vxlan. It's safe to assume that we might see similar results when testing
other tunnels.

Changes in v4:
 - Added the dst_cache_get_rcu function
 - Implemented the dstref object and used it to implement noref xmit flows
 - Converted all tunnels to use noref xmit flows
 - Fixed formatting of comments in dst_cache.h
 - Reworded some messages

Link to v3: https://lore.kernel.org/netdev/20250922110622.10368-1-mmietus97@yahoo.com/

Marek Mietus (14):
  net: dst: implement dstref object
  net: skb: use dstref for storing dst entry
  net: skb: rename skb_dstref_restore to skb_dstref_set
  net: dst_cache: add noref versions for dst_cache
  net: tunnel: use dstref in ip and udp tunnel xmit functions
  net: tunnel: return dstref in udp_tunnel{,6}_dst_lookup
  net: tunnel: make udp_tunnel{,6}_dst_lookup return a noref dst
  net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
  net: wireguard: convert send{4,6} to use a noref dst when possible
  net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when
    possible
  net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
  net: sit: convert ipip6_tunnel_xmit to use a noref dst
  net: tipc: convert tipc_udp_xmit to use a noref dst
  net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible

 drivers/net/amt.c                       |   6 +-
 drivers/net/bareudp.c                   |  63 ++++++-----
 drivers/net/geneve.c                    |  87 +++++++++-------
 drivers/net/gtp.c                       |  10 +-
 drivers/net/ovpn/udp.c                  |  12 +--
 drivers/net/vxlan/vxlan_core.c          |  80 +++++++-------
 drivers/net/wireguard/socket.c          |  34 ++++--
 include/linux/skbuff.h                  |  63 ++++-------
 include/net/dst.h                       |  48 ++++++---
 include/net/dst_cache.h                 |  71 +++++++++++++
 include/net/dst_metadata.h              |   6 +-
 include/net/dstref.h                    | 111 ++++++++++++++++++++
 include/net/ip_tunnels.h                |   2 +-
 include/net/tcp.h                       |   9 +-
 include/net/udp_tunnel.h                |  12 +--
 net/core/dst_cache.c                    | 133 ++++++++++++++++++++++--
 net/core/pktgen.c                       |   2 +-
 net/ieee802154/6lowpan/reassembly.c     |   5 +-
 net/ipv4/icmp.c                         |   6 +-
 net/ipv4/ip_fragment.c                  |   5 +-
 net/ipv4/ip_options.c                   |   8 +-
 net/ipv4/ip_tunnel.c                    |  63 ++++++-----
 net/ipv4/ip_tunnel_core.c               |   9 +-
 net/ipv4/udp_tunnel_core.c              |  42 ++++----
 net/ipv6/ip6_udp_tunnel.c               |  52 +++++----
 net/ipv6/netfilter/nf_conntrack_reasm.c |   5 +-
 net/ipv6/reassembly.c                   |   5 +-
 net/ipv6/sit.c                          |  15 +--
 net/openvswitch/actions.c               |  16 +--
 net/openvswitch/datapath.h              |   2 +-
 net/sched/sch_frag.c                    |  18 ++--
 net/sctp/ipv6.c                         |   6 +-
 net/sctp/protocol.c                     |   6 +-
 net/tipc/udp_media.c                    |  14 +--
 34 files changed, 684 insertions(+), 342 deletions(-)
 create mode 100644 include/net/dstref.h

-- 
2.51.0


