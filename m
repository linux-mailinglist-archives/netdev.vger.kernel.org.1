Return-Path: <netdev+bounces-267149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKGbLFrmsmktQwAAu9opvQ
	(envelope-from <netdev+bounces-267149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:14:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC2C2755A2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2107D30210D0
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D64738AC6B;
	Thu, 12 Mar 2026 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D8I5qElN"
X-Original-To: netdev@vger.kernel.org
Received: from sonic307-9.consmr.mail.ne1.yahoo.com (sonic307-9.consmr.mail.ne1.yahoo.com [66.163.190.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DB3C5DBB
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331656; cv=none; b=QbS4XgbBZ9EQVYUJ2qvETG8vUld/WuoF/ovy0SFSbd4zmS/UpMBvDF97366Q3WDBSOwrBotJz8PKOlKWIBljKnWssyNN9v9cHUZqZDN19uZC0OggbrVbDVhIF+KFWFRqxjWlTt6OS8AkR0x5SY7cP1TCRXbHgPWl8csx44I5E2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331656; c=relaxed/simple;
	bh=KL2c+0gWja18QkcF4+JGFFSBsZsbD8ALfrpD7YrnWqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Qw+gdgoMOdSxFqu7DY8bgx+bEAHKsgHfHxDX10vP/VCfmuybguqDw6XZaBtVxXlrmQrI1mQwO5ss6zAmV+j+bKc+aqeWJeZmy7Xt3O3M2Omtutw8rRUsNBbcSoEKzgVy3hN/2hOl923kreaekBOJPGAI5RWT8z14m+QJVM1Lf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D8I5qElN; arc=none smtp.client-ip=66.163.190.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331647; bh=vjmGQk2hoBYb67tsD/bAMtPiNr8ReIneaOpxAYD1UW4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=D8I5qElNZtU0hg74FAZ2nZvJotsEizHKEZkpl+weKDZmqOVJ1on3pVT/sj6kEypw8N54eHB9n0H0YktZOMQ1ktqQNHxc5tNDcrNw4546Gs3lu6BUBkn9hHCmGTUGueklwc4SS/Gl89+8RqfZ9koYjxDg3L7nIFbOgjL0wJFatBj1GexsbO1luR1MXEE3jLVUadhg+SetMOAuO/rxOB26MEV8iBnn9stpvZf69gRvQ3OSoYs+jPfqlNUv4QG1DLuyilgQV0HGixdbGr8GPzLA7l3DGbqhwCExjMz11oDZHU5nBvi308ytlHo33jrVCsRpuh1QQburkaDPxuJov3h1sQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1773331647; bh=HmkWD+ydQtSpnfPP6QlJZh/Zj1gqndj7X4/AJWat85D=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CKqa2+pMLyBQTxkIbDfixmEoIT4snwo7sxu/VIfw71k2Qs+Bun/9GKqu5WspATY2i+KkKripzExnAiRUNm0xWamvT0Pc2mCwuA75gXQvsjWqfBevvWoCtJgFCNL1aMu9gcE8knb5sIUcbBnUy9PlpxSY9stIVJBEWuR6X+/wZvzbxBkb6kRvBio3qO9A3pW5RXmujUFD4WqWULT88yMAZcnDp/mKpFw7gm/N99YgeSlrkShRC6bVDyqvvnXBiomgrQdisfSsUn8Y8MyzXkCFT1o9c1QRjD7QeiXhqh+CnosfbKhUMkpgyaVbgwDwhKIBVFDJuXVAsSs1HVpz/K4JjA==
X-YMail-OSG: KuACKi4VM1kydNo0pUGfMtSN1sOwfQoJV1M.DPzePz4eX3f_oyzmR3qTuW9nW8m
 YJ1PU.yB2x7NYsy9S5FeQqstvrjRoVU9hzGi9pNGtSqRCGcmJMSG._wCMQL_Kgn_bP9yosAb5RIF
 UdR_a4w8v6ubGo7vcXc6npknZi_HSv25KcnKNOrApwghHPXo3UOfu7H8oY94VS.TZu9ExA6D0B_t
 d54EtzxmSvdruoZUeeRy9673ArIucTYjYRY6dYik56G.rZeEGct7fPFU6Lbw9u211D9UQ5BrNXey
 CoAdRTTUDTsYXf6ZMQ6wCU_SglXBrg19hnYT96nSva1U2IjYXK8oTNe8SM5SB0cPjuwzzOvOwkWQ
 AsvWVFxUbziyiFxxfper8lPsi_VBWwDCJgE8qkoYSCfn8EUAKNHTyVxViDwsrn4E.FLYnHKK1vmU
 _IRR1XcS3Gn21GYFrg1p21A5X8aNGzzrz9liufrlq11_wCjNTQVZb3oQQjUylRSKEZxJCvTqjN_9
 lNP4WP0sqa1QR6ZYvy_SuBPz4slz1rVCO1.LUS599uwg8vOunJmGHMPFqKXRdwWSsu3eiPttyqIa
 .yG5EJ0qsuGiDn5cVmDLraIejLwq7YCuUl351QMZGRjGB6xdP8XwPWsu1yG1Zy3TY6l1Hep_OBYo
 n3y.rMrgFtFMyGP3GOD3QmJEvdelgqzqXqo2oXXlNT6BrT4DpsH0qbUXUVsNf6Slrf_X2jd2vsKr
 RnbpqsfMSFOFhgshpWzT601t6DfEjGh3UR4zn9_uBLlzKlE5Nk70FKy316VjZnN6bRNJHfsHvQj_
 M268o2QKExoUi_EsYLbO8XAxKRlbLGvoQTv06vARIAZfbHnKuRJnwCVHxOP5_rGNwecKCKtWnbnW
 QKMC0OapvN9sG9wrN5MvcpMjSyeM7zWEhYwMsGb5m_QXw4RKFhuKbOSA_IQFLahuWAJTOkyb4kQk
 lJE5_02C_1RkH2qwf0Qhh9hBq1DMWuSdQr2a1S1QUYTV3u2yfA914hi.OAf9YqMZgxSJXUuop4E8
 h1uTc4ffcjEr267ojKfAz551HnwZ8SQrQ2iM14xfoig78EL5tgGhJuXsGStlBJv9RLVhlMn_tfT6
 jQohK_rDoffYJ3WKs6.JrqItHTLyNooVqwL5mrazt0lJKca0TjzBjfWQUpOg61xJ0ayZ1EFX45Wj
 kc3HGmWH5yo6FG_CpGtK5ueQ5HbXj8.4rrfTzdsJbkTzYB2_nufBviJYM..QvtTlPDSRVouQq1xz
 pHAbtUKe03dWEHcj6PxyEoAv4EoE8hgXQlOzO3SpbKSHevhA6_9jeopYvEccqqp84Eb7N_IoAsFR
 0XOpIXHV7wSYpB0Px7wexRtFQ.Jq_CqKmR_rtPmA5kdXzPhDiR30873gz7JkMPgHk1Hy8O_fWDcn
 tg9Jox._f6PaXsQjVajia4w0FitkU6bdQl5YGLNQM9FDOgsPJf3l9nfifvJQtZNEMlI.o3zk9Y9X
 Er9rndj1dyDNhag0IyS17F42_tEJ21zEEVTv4tDf6egR_.tOmmLRbomg4KG83iwueRdVvejeSckD
 eLgRy1YsYf.vkFa9Y69CN_XjN3RUpcqA0sg4ENFAfrSuFL2sBEHVdHeCtGs2QnzOYQFttdl8_q4P
 Ye2fKy9WFURwI26UYVLsTsa32ip5K.j3mFFs2._rBVjltjMaMUzqxTKh4ixsBVPgEu5V6pkfQEek
 _mzjEfRKsDQRaVg5YKXAtBoFdjDH0OZZ.ZAWOvKKfVD7W7294GktvpPsLrslIrlVpkpfftbnQAxV
 rxbleG7kPrEuTQUkjMIwyFrob1dMDF4BeUfiAfdqf9BUrS3kBJ7tqFHIiq8xryqo.vDDJpEXu7.8
 jJtTK09vK2lUaYk628EkseUU5Sa4_rKVwA_Z9CmWVGfSd0k.llOGA9ZF.bMgwfKhMECy_zeWDtN7
 TppLPdPklfoDy20ClkZKtoihG1UZbq4E_09Xd.7vxqDMMSksHeYtbGc8aPLyKNPAXE.K1nq5DAo3
 pKbPD5s3e1MQYA6KTVoY9cpULgxR5RFzLWNhV1u4ZXMO7fIk8.M1wHL601kFJvcgx9gYPxDaq6td
 XVeBEeMhHnb4HuMEvQjTfYAU6Dko46fRLtmTXrggW3KcgLRu39ve1x2k3NnvcNIvcXWTN.O76PPT
 Y_ievLjESkvi.V596MDJhY5jxvNRgtJFFXh5i6nIKIq_1IM_uZhzD
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: cf444a6f-b26d-474c-800d-bd6f46c30609
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Mar 2026 16:07:27 +0000
Received: by hermes--production-ir2-bbcfb4457-pgdzr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 87d652406d88cc03e8e5278a11075b9d;
          Thu, 12 Mar 2026 15:57:17 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v8 00/11] net: tunnel: introduce noref xmit flows for tunnels
Date: Thu, 12 Mar 2026 16:56:46 +0100
Message-ID: <20260312155657.25676-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260312155657.25676-1-mmietus97.ref@yahoo.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4AC2C2755A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently, tunnel xmit flows always take a reference on the dst_entry
for each xmitted packet. These atomic operations are redundant in some
flows.

This patchset introduces the infrastructure required for converting
the tunnel xmit flows to noref, and converts them where possible.

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

clean:      72.52 gb/sec, stddev = 1.39
patched:    75.39 gb/sec, stddev = 0.94

TL;DR - This patchset results in a 4% improvement in throughput for
vxlan. It's safe to assume that we might see similar results when testing
other tunnels.

Changes in v8:
 - Removed repetitive "if (!noref) dst_release()" flows by updating the
output routing lookup flow to decrement the refcount for the dst, essentially
making all dsts noref.

Link to v7: https://lore.kernel.org/netdev/20260127070452.6581-1-mmietus97@yahoo.com/

Marek Mietus (11):
  net: dst_cache: add noref versions for dst_cache
  net: tunnel: convert iptunnel_xmit to noref
  net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
  net: tunnel: return noref dsts in udp_tunnel{,6}_dst_lookup
  net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
  wireguard: socket: convert send{4,6} to use a noref dst when possible
  net: tunnel: convert ip_md_tunnel_xmit to use noref dsts
  net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
  net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
  net: sit: convert ipip6_tunnel_xmit to use a noref dst
  net: tipc: convert tipc_udp_xmit to use a noref dst

 drivers/net/amt.c              |   3 +
 drivers/net/bareudp.c          |   4 -
 drivers/net/geneve.c           |  11 ---
 drivers/net/gtp.c              |   7 ++
 drivers/net/ovpn/udp.c         |   8 +-
 drivers/net/vxlan/vxlan_core.c |   6 --
 drivers/net/wireguard/socket.c |  12 ++-
 include/net/dst_cache.h        |  71 ++++++++++++++++++
 net/core/dst_cache.c           | 133 ++++++++++++++++++++++++++++++---
 net/ipv4/ip_tunnel.c           |  32 ++++----
 net/ipv4/ip_tunnel_core.c      |   2 +-
 net/ipv4/udp_tunnel_core.c     |   6 +-
 net/ipv6/ip6_udp_tunnel.c      |  10 ++-
 net/ipv6/sit.c                 |  14 +---
 net/sctp/ipv6.c                |   6 +-
 net/sctp/protocol.c            |   7 +-
 net/tipc/udp_media.c           |   6 +-
 17 files changed, 258 insertions(+), 80 deletions(-)

-- 
2.51.0


