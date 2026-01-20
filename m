Return-Path: <netdev+bounces-251559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHzDA/7Rb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:05:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 954EF49FE7
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937BC82E98A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBC33AD83;
	Tue, 20 Jan 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="O0tMIq6A"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E533B6FD
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927556; cv=none; b=XpaEA4cMFD4wqgxabYharyX21kOmE2pkVdfGHXU1h0E5CBMogR95B1MxLmRWlUFh2DAzixhdA3q/LaG3Hqm+rsTQEwebwQKQuuwmj1oX7KhNHA9ONpDjGfsHxt5J+c6hEb1Y27JD5/W22EniIujjOe3WbX+nmkkL9cpgTMfMy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927556; c=relaxed/simple;
	bh=ka6zy0vMRU3xlTDzXsammyCT8YFL60hNroirp5Qjl3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=bFp/jhSDo0Myc/ulKbdRN1kUUHN4mYQEUYiU3mSQ/kr3xc/N1W0NSkmI96soLoWJGQua03UHve9ct5m0oZJ7oLcEBc6VTIdyF/wJjsvKqleDlHTydvM5T4/ZVxg1W7tnb9/4NLpObai+Un7hJqv+ExJ89PEU1MGwhGZ/5+pcbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=O0tMIq6A; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927554; bh=MPPNU+UqEcPIAcUa2EVYTXPUfQ/csyYzPBMa9wRh36w=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=O0tMIq6AktYJqsjVfwHzEhj128mzfbmWsID6b7FNFQdp+mokyoGwi7Crqhq9eGG67ywMR4cIWsE1pkp5htxtswHkoMLI0DS4OpTZ6kA2LMDThLsWF0obaGj4gQQXUuelMtHlcqP4JhxhFHc+TELZgv7L6t6yppoy8W9W3igWnmFlU8JbJLB8OKxXhZs+bs0r17VsfbVdLMkIWch3idc1wIjG3yxKc8VD98SqP6mgxcF4Np4OVD/rY4EeBaagv22u4f2Rc16pTmMfv7+Ob5eqcztGhLn+EkxHzJ0Yth/j1y/2RxIPoj0bJ+yGhPkQ5c1+hgb9l3hxMzk44/y/BSV6Pw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768927554; bh=LMM2Zp1enHi3phwnJHrmTZWhvHQ9bZ6275GB3li29YU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=CcWXOr1SbCB7zODQGS3CvEAxPTfNyyWgkfRmJqmah3DQCkPtnJhDF/IluXyndN8JZvXgxNFRuaVYuAHB5RCCksVOL9VxCouUpFqQ6I4emQkDbJlZlNWrKD702IiGRF6KISZ1ufmL2zycdcCYcLLOy/OBcjJJzuTWQ5M9AI8YehX3BufyKJPCvHqUypGXQO+zimz8ls2ejx73bntcM8ojR5xy/al6fvSG2WZZzqq2P+Vjw2So8OzOOq3eKjNVeFI19LP/sC/BckrKgUecZRNqGQUNBfucdcwRQNjw8BPiiunXPuWelzQI6yf9szHlWTOpgFqNDcC3jFi5usexuDQW+Q==
X-YMail-OSG: TWrnKW0VM1mCOvMLfsZDAAYyLZZ1OVdKYWyMsUQRy_CzU9TgDB_ZA23MohgmGAz
 vyV_z9mhncGLy8zeUFksAm.3DjuiJNxi2FuHpsyKzkCeQAS92N07oOrYDPMQFDZPXiovayzA_2a4
 cGHPSE3O80sh4eKJPlPsaSXrzUNwjIT60SmEY59x1vIbzzESsFqMCJXqHIpiITsoyKkCyYVfugtf
 _Z93bVXGiBSA0TfMfpsk3H76MQgjWIuYe8bBBJf4mwSnigZtf_Fam_B73WDQQNFc_8ocF3T.VtMM
 QEGHcBj2P1n9d.bPD.J40Q0BMCittMDKowJ3pqec2nZSxkJGTdHVhqOng3CXoCMLgl11xJLD0j_c
 s2BFig23L.kG2LK1OolzO3siJdZdmYOMVJHQI4pvbiaUoRZp9AlfFHSwkdJ7KhMzxhRk66eThMuC
 CW9c9oc09bkYaAi9QXOkdzxKBe.HDsmlJjqjpEMFUnY.59Qn0vhUNkYGgJZ95jFlE7sfSmtaeN5l
 Xgl_5LBGtpL0BlZnIDbufVf4lW6Bh_KXg4RFRsKSMkw6B6AYq8WWNOFeyTKiML23mht3GfiH7REm
 O.c1PHfdUjgnOsfppS8rt5Myks7XwpXTRx8iN5p7hdrwo7iAB2DKdGaNecd4LEcoGH_J.lFZJuvG
 ZeYUqVmyrzkjrbymdQqoi_lAoxMN643dJ4avC75NlRQgEvHfKXBRYPUL60t4_Vu4ri3WruxazyyO
 OUGaxO.hNzjgFKOsJNuSJY1P3iuxZScHIe_RJqSVzYnlCCptW_kMMuEjl_dR_q_NsjUyUlRk.dtQ
 pscZ0KkKFFV0zScUKyTzbytQhDou_xbh9_IE8UTpqDjLWCjKe.HOX3EE7ll0T_gluiqenLPleC5m
 04oj2j5KOBCloRtImX5.DwRsgwgQr31X3p8IpHzYXEFCF8iVltpGgCBRTaz23.OXrgjd1SUn2KuI
 O9qbsWqudiJWouXpzUK9Q.qnExs9.fcRT3_5qQ3IuCifm9QyzqzX7gMEnEvk1646elRhLU_PDoDn
 D4an92YgDI0rxIoAITOharKvEABEf5AK20YMJ128I78RJW5quqYGJ.7gn8xg6LVQtMTbEOaBohZ2
 Kxl1kGQhx4Koj1mf5yO6hw5qJJ0dNBeQ5TwsNWgW1N3joS4oPVxVWPlxUJg3yNAFrR2rwmLtUDk4
 5E8MnFYUhxUEhOg0vxosFjCfPNTIgr9epwwzPfrhNhJ1BhmS2g3N.fzJ0nBgGq2HecJMKRv5T26K
 lFx3K9UKJpPKh625_qquvAZhTp7ug6znNiOQpHyXDt3XGHWJF2xPGPdldrMsfFc44.8y89YHZyz2
 CLiIW6zqGEuo5C7_784lKuVaZ8riwH.k0DQgV3ZUyUDDsYFIn9yEQ2CaPxxJ_KIijByw_jEuM_NV
 Mu6WtL19YHvAddB89bg_NPUPy55_zMpf5eUCXrIrK5YDq34nrHvSoJW6uCmSN4AtVuSrujdRLSbW
 vUfIc6kKNA6NDEV7Yl442O2ptImFxNSSOKBLjY1xnp6e0MjMJSFzJtnV0TRRKWXDMfnfiTdEFi32
 NMKonM.Zbe6LqgdnJj41kiAKH6LQlyqjei81iHlEn.1xrAfAU3h9.nKvrSd1Dgm7kGNdt5SaRKos
 zh6RVPh390jU3XwLTVYScOZPnxFguwnG9rZ5NpJxedCjFvp0cATmzP01dKXUEDhsj_ovlNvP6E5r
 ntfqAp_4pPIb_kh4bY6G8sblaQhLA8vNVU_D7ZUHf7eHX4Wzv7P9LDDwv2MUguVHTUyDlz5BOBev
 F6VvTYJHVZYxT4df46AfoZKqQ7M9HEJo2GWITOOaXSQ7pUZQSU_K5m13viYtOxU6Ur5gNK4WYXVv
 Jh1zXaM5SEi_dEdicuRBu8BKzmNow5Ti9mpU4rREbNJuSux7cele4irfvPB0Y.ORHC0UPV3ODEVa
 kWSejMOezMsDZ7ZZSdpOtDwDUe3YP1H3MtqmgkIhc6OYSeckD_ulIns39uXBgwD2oHgO3F5.ht5O
 6GcMzBRZc1BZHsWbKZFjriSJc515qU0R.3qLo_fyAa2HNYXVwjYrRDNkVXqP1S7DoUklyHTtN_TC
 H3ivgFa3rUUBs663EiSy_g5lbvBoijA4pcQqqPiFKgTA8LknPCyu1fmHEvI2jBOqPHFgohZtpCe1
 FD_Oquuk6TFJ71RIq6fnJ0gfvBx53qEmw8vOo7DAd
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: a323780f-c895-4527-91d2-cc4fb404fb6e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jan 2026 16:45:54 +0000
Received: by hermes--production-ir2-6fcf857f6f-vw7gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5c743ac7fc5feeb5bdbb197ea32f25e9;
          Tue, 20 Jan 2026 16:25:33 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v6 00/11] net: tunnel: introduce noref xmit flows for tunnels
Date: Tue, 20 Jan 2026 17:24:40 +0100
Message-ID: <20260120162451.23512-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260120162451.23512-1-mmietus97.ref@yahoo.com>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_FROM(0.00)[bounces-251559-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	DMARC_POLICY_ALLOW(0.00)[yahoo.com,reject];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 954EF49FE7
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

clean:      71.95 mb/sec, stddev = 1.71
patched:    74.92 mb/sec, stddev = 1.35

TL;DR - This patchset results in a 4% improvement in throughput for
vxlan. It's safe to assume that we might see similar results when testing
other tunnels.

Changes in v6:
 - Removed buggy call to ip_rt_put on noref dst in ipip6_tunnel_xmit
 - Added missing calls to rcu_read_lock/unlock in sctp xmit functions

Link to v5: https://lore.kernel.org/netdev/20260113162954.5948-1-mmietus97@yahoo.com/

Marek Mietus (11):
  net: dst_cache: add noref versions for dst_cache
  net: tunnel: convert iptunnel_xmit to noref
  net: tunnel: convert udp_tunnel{6,}_xmit_skb to noref
  net: tunnel: allow noref dsts in udp_tunnel{,6}_dst_lookup
  net: ovpn: convert ovpn_udp{4,6}_output to use a noref dst
  wireguard: socket: convert send{4,6} to use a noref dst when possible
  net: tunnel: convert ip_md_tunnel_xmit to use a noref dst when
    possible
  net: tunnel: convert ip_tunnel_xmit to use a noref dst when possible
  net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
  net: sit: convert ipip6_tunnel_xmit to use a noref dst
  net: tipc: convert tipc_udp_xmit to use a noref dst

 drivers/net/amt.c              |   3 +
 drivers/net/bareudp.c          |  28 +++++--
 drivers/net/geneve.c           |  59 ++++++++++-----
 drivers/net/gtp.c              |   5 ++
 drivers/net/ovpn/udp.c         |   8 +-
 drivers/net/vxlan/vxlan_core.c |  39 +++++++---
 drivers/net/wireguard/socket.c |  12 ++-
 include/net/dst_cache.h        |  71 ++++++++++++++++++
 include/net/udp_tunnel.h       |   6 +-
 net/core/dst_cache.c           | 133 ++++++++++++++++++++++++++++++---
 net/ipv4/ip_tunnel.c           |  47 +++++++-----
 net/ipv4/ip_tunnel_core.c      |   2 +-
 net/ipv4/udp_tunnel_core.c     |  16 ++--
 net/ipv6/ip6_udp_tunnel.c      |  19 +++--
 net/ipv6/sit.c                 |  14 +---
 net/sctp/ipv6.c                |   6 +-
 net/sctp/protocol.c            |   7 +-
 net/tipc/udp_media.c           |   6 +-
 18 files changed, 377 insertions(+), 104 deletions(-)

-- 
2.51.0


