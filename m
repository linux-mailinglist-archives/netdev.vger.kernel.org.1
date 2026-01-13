Return-Path: <netdev+bounces-249524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36442D1A701
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF61D30A889B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914F534DCE4;
	Tue, 13 Jan 2026 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rJyeHE1m"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-48.consmr.mail.ne1.yahoo.com (sonic303-48.consmr.mail.ne1.yahoo.com [66.163.188.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32CA30AAD8
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323157; cv=none; b=HTD0qcYRWW1j1r86b0kpREpY4y+rlsz6VxL5SMHyUQcwOJ7lO7RJkZRnDMZmaw7zwxCF3e/tYgmsoe+ZNLgvTrSChu2NMKW45+ry6Vhd59xe7+7X5T1kvUQiTcNozhsqoNmqFfQ+/GQDDJJ7Q8FirgHnZhbJTmKaCDbbTgRT6Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323157; c=relaxed/simple;
	bh=Ka2c+f7cKYrDNOEeGzycd0g5ak922xHdu7igTZVlUKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Mf7RAbDOh82sjG0hegEjFPqbs6yEonJH0tDzwqyneioX5/FNRX8NgmWFMKvDldIWU7xNwVoGz3HXVOc+vY3RzvvkAcZgVTHRz0DjmboJSV4HqWFC0t6OhVUUYlbN11ptU47VTwCvrrOvYY2VABtB3v+RBzjVMVpNBlHi3YPcJSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rJyeHE1m; arc=none smtp.client-ip=66.163.188.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768323152; bh=vCUpaCooJZwcd2Xh0qe1ZUXItKm1jGVNkgmZ/ssEtTg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=rJyeHE1moehC+pUjfn7c4KCIJ9Ar1ME3yzH5it0FhYy7m/1umYX3MrQfKzVu61D2cNmc1JgG/YFiw8ZZJJtxDGAH6p0bJG8Yr+e1kvlWvDKRC4nOjuzKYkZrsTPY2o7ibjjrTfio9SCiUjU96HMSeB2laHvheasH9tGXMtw0KqlHWewLizublZAmeDYCoME37T3900hmUStneF2DWtiN64MVf2VTALQzsIm2lQGJ94n0Thtw1cT1loAfPEBIvy8AFRj9So7bNBEb72wgR/28YtP5TzZp1Nn4h93suPAWRGpVHG8UFAaoO3Wbo7brrGSdPgVhTO6t+QDtJzQ+CvZB9w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1768323152; bh=rBnk9HGKpFlKHed9XoC3LvY2bMMaXB8/wYYcCl76S+3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SEudGLHgL4bHDSIknEdPpcli/2kc5ocdHu55p2nbi/kWoRRz+kEb7iUaOiqwR4R2xAwGv93jmJlpsSZkaEx4SNoUXe3eFnVrfFd1CQg2tjQx3ChDK3pIPDBZupt1ne36bcucPYRuNTuGA0KjNF1jgmUm12/nwA5QItdXsMXeozFPqfsetNjoTd0T2vNr7cmgxVZddYv8p1aTlGJ5Ti8WbOQUKOJkLY6hv3QoyuBL0IJy4Gum1b/TFMNH5GXW/innN5KwAqyUzOOWOuU0ISuhWpfN3Y96lVUOzLkJtQdTfdPnyq3VUZabNd1FXapKOjNMdAufc9WE1vvUB613kbvZKg==
X-YMail-OSG: TY2fSmwVM1nD_LVBOrEJHiRgM_bjaOdoDU.OdalHzEbGuADQuBl6nX5IAuN5C9K
 vgfLH1kMVJ_SyOtpAAXVkW212cbjWoGyD0kzWPszmL9mSfkmTY2HNmQ4ivz2bCz3HZNkgk_.EOIb
 h_exDkdI4p8b1ho0Zi2XEaAC9Oh82CYIJ2WkUjFIGRndwnZavVKQduEapoS_SAZtXjDXzUv4VDmN
 cFylC.LSwK104rooVyKZFJ0Jq8YjXsvJxZ.50DL.hBahbHFtzJKzyJvUjliIqFDO.QZIbZ_WL6zw
 4JG3kWdwQLWGIUBaVVDqPRNNyJm1cjnrW2BIff.Qy_Kj_KuhbzkQjCXiM9KLssPU3B52cIuINQJE
 AzNyIYm884biCoMM7DBjMFwSZntMnksdHUyPxOtXsg1mr3VSzjYn3eGldPTUFTLoeyNx5zW4VL.x
 e3Vjn1cMdz_Xcac4S.AFTOP6DxZCR64KgsqX41xVMgzjIhbag.3vKz3Mpd.l43reUnzV.VUOFe8f
 WPBU5ORpgpxKDFDf__HhkPC1lAVjOkZt7et3R2HO.CZjntocrYqxYL86CAQVe8cajfHBOOMef49x
 v6.mj1vWXmxOnwP.nhEgt4a5c1GeTpTbjzSSuR18OxjSWVUemv763wzK42n2toQt3DIBAbMFJYh1
 HsgqlHS8gbs1DcODXTxfVJfRCV2GglZ3ZGG83eZfBs4rK8nE1cIj6QNXe_CvRWbkqVClaP_hwnfs
 Bn2VNBSBehd6D2lFeIU2HsP95jJz8SQe_kumZUChDOsOT8VGeFezVWrQxZUQUEKx_42F54zh5kwp
 40Km6i3cOQCIGfDzfCFHBknR1w4oqqmfrdPgSXlIgxT_52HdQaAMwwREHJ0WNvS0av0Enj_4TXLx
 xzIVaIrJ7.k7eHpU0NnqLocXk7N5SmCGA7jlm0x2Eo5AXBuy_4gCrPJ5O1byz1Ej2cYGC3yO_u2v
 XDNfJ4MdUb.moJbXJ2qzE.2SdAP2tR2wzdpk6SIPixOGc1qC80CuNJTDhxm7.FA39pC49o.mmZ3S
 EQKB0Idt3Xy1PuEOwbgXnxU4lNcX6Z48KeeVKs26MwyzaCZAxxaUBtMINgIVzvWJXbMVQhNHIuUb
 SpZd8WUM6AZpL80ZPQ6P6Om6MdQuiib5eVwfCmNl3Q.AbCj_v70ANJUgUmMFRvDbbaqmWcecWcv5
 QtfZgOeztxXnap.VXuGOb7QqC8Mgwd2lSVAbrxMzmUUExl27UDW8Wb_b6G1woqeEPQRpSbsJcU82
 tJK9liWHxcfMH7uT5NWLQ0VXSwPWolH5jgx7ReWziLJEmLA5B46REh1kTv0E6Iq2K.Y.Dy8kwoKj
 yGpYbDtMZazgj0av_BzQDfJqhVR.FmadNwysIbQ1UJllAGXacgWT25K3VYvP1Md8XwgWCpl4SuTn
 GnKNYplBCyMclPk2JCeZjo8OntZtF3ecIcgDBS7bYXoGn8McevVec56DbwlVbk1sxybB9bVwBveM
 fsjZWQf5XOrGqGDLt3kq42Vbatkm.er1XZ8x_n3ul0Ni_Fi2T2Rj6RP_oCCtft4jYtzinjbxSyEF
 Rc19EmlmAZnn.5jMcWybPHVh4VzciwmnLINnwjuEI_OdBGcUE_GMKYDSjd1ZK9b9TvYr4WfBC.6K
 JwcEYEXG0fVYAVfywjeLx_5RJuOeG.J7aKHybD3hDj9MrWrXCj_Fqyhlm2YBepiKr4F5Mv2mW5xP
 s_pqpEvafMfemVGeKhP4wW7OancpL1Otb_osj1pfJX7u4NeJHZBxn.21vNK7QgX_EUrc0R8QNXpg
 b6ZyMryqa_0.o7TYFQauO7l.sWTExgHuy5vKPtXC3ZemvahnSkiVBjRonWZGrbeH9qQbaDQx0WPN
 _wfxr.pFccfPuHNbQtVQIBlkaMo3EYdZ3xXK1jVOKSm3Zm7zeiXM0jq1aMyEeenYbwjm.Y1.IYTd
 UPh2RasI1Pe_gBmUSMaTrzurLHDodLE_TLFwjHAbLzPYncLJdttq1ippL_Qp1PLdryzjwrIR2HoJ
 tzBCuqVSlsgJAFAWH.afN6lAPD7L7RVE4ibIUu9LN6teQxf7ULN2_nk_ageBfZDZhwc9C6w8vGPX
 .A2Uh2iG_n9gHuk0PHra0xf.RB10J1SOW9Aoj9OC2VK7sasFW.nZZEkJD_z37y.MgMJ0SC2iPZZq
 S3PNT7oXiAj_wZRYO4ejaMxPTIAsA_lODSOK9uwzgwFUeiffzYv5GLUavzrUfNZfvn.rJKPkkWS6
 0tX_tR7uHE0NN8Ys-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: eba165af-e7b6-4cd4-8007-5a8497b98392
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 13 Jan 2026 16:52:32 +0000
Received: by hermes--production-ir2-6fcf857f6f-7nlzs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 11e96f127f9288c2e2174b22f2ee0351;
          Tue, 13 Jan 2026 16:30:15 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v5 00/11] net: tunnel: introduce noref xmit flows for tunnels
Date: Tue, 13 Jan 2026 17:29:43 +0100
Message-ID: <20260113162954.5948-1-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260113162954.5948-1-mmietus97.ref@yahoo.com>

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

Changes in v5:
 - Reverted dstref object implementation
 - Converted tunnel xmit functions to be noref instead of using dstref objects
 - Added a "noref" output boolean argument in the tunnel lookup functions in order to return noref dsts

Link to v4: https://lore.kernel.org/netdev/20251112072720.5076-1-mmietus97@yahoo.com/

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
 net/ipv6/sit.c                 |  13 +---
 net/sctp/ipv6.c                |   4 +-
 net/sctp/protocol.c            |   4 +-
 net/tipc/udp_media.c           |   6 +-
 18 files changed, 372 insertions(+), 103 deletions(-)

-- 
2.51.0


