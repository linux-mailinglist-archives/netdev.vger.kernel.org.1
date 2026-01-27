Return-Path: <netdev+bounces-253739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMtTC7BreGlSpwEAu9opvQ
	(envelope-from <netdev+bounces-253739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:39:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289490C5E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C27F13017C24
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB22DC78C;
	Tue, 27 Jan 2026 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kxPzku1t"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-56.consmr.mail.ne1.yahoo.com (sonic308-56.consmr.mail.ne1.yahoo.com [66.163.187.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1F227BA4
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499565; cv=none; b=MyzPeLd0axibkcoYspBLRhSyYgt0QU+kdofhHTMFURfPoGAFxovbBPS1MhZUzDDPC0mI/zZayRTwNsU3LtBi9JQBwjjs9fXRwukiPi1ynxxsSsYjEITvjJmxQyNGAIVFugt6Pz6y34BZkDrHCyI5rmL0Z0fOf/u2F4bus1gfkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499565; c=relaxed/simple;
	bh=0N/YtMRiZdwnpITqNZA7hDBX2/E7yjQbL3Abjl686C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFPbNvPKlY+ZZt2AP2YLmDHtxngDOFugRRhzgw+lIbFISUOJO3nggLvsPOYay3YuDwWUHdkkoqU8OOT2O+rJddXwCzmoiLU+uGV+rPXeZDAHI0Ng3LJq7xVVhJO1bNCJR3GhYC6ZlBhkdtUqPwXdtv/tFyb2gNXGgTwjbpe+fI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kxPzku1t; arc=none smtp.client-ip=66.163.187.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769499562; bh=ZO0gP5JNvG1sVwiPM9TlxEvQxqgo1b4/O0B3z7s7UMg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kxPzku1tZz0UlPuGZ3O34SvOS2/sJs6zTKv9zPu+umowXk1kN4XWALwW1/dcqumtRYRztioAou9JiDGbVp9v5TBaKaBeL36OZuzZxPxpdyYxh0KB089XW4aJBs6kbCFFRZ0FURaaP+DQN9admELtgFYd9Cl/lzYyklPB4XYWlStNLXI4drtERUneDmDgZklozE0GBR8QFwG1Fb6bxW8oHUl9pCiK87c3gyUSPXz+ocwBs6fnmVOepCl/rh56shoHQ/VRCp4LI9I6950p2onYh6PEMQEgCiE7X3uBwWIr+tkGptmU2VeF1Dp87vdpIkQr416wSP8ll6zTKfepGoYEfg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769499562; bh=iUEiJqXQuM7qGZcg0AIpmR4fOFbop67NG7SNI6ACQJ2=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Xikh9Egcz7b5ih02OUuI62MRKca0oIkXyvGTy+wmyT460bjBCqKs6kmk1fU0HMaEB2TetiFCIZSQsPcAfCiTktOHg/ejRkJStDD0BAQKG3fxsxzBZX9bAWw1BVqKhEbW8IudSW02uU2AMLVxE2ZgriyJaAaT0fOYxwbKPlsG+gxPGvb7UoUsR3EchvPqDYO+FFNWWfaV/JYnO/qzxnlPdjWWktlDT+Uv1wL5XIDoGjtOTYlWiGCo5Ve99KuM/1TwLbtU7j9VWYM2fx9rVHysmIqlVSXbzFAK2VctxOrnPPTijy3sA+RNitCRGiY8mz7g3I1akgBfTEji/mShhiL1fg==
X-YMail-OSG: PXOBE7gVM1nrkaJ5trKSQI8fuW2p.WsZXKH1c5MCs1SoInY7R.R.rW0xWiXoEgx
 EihwlHF9AfAY1LG82KZRDukXyQMkNVut4Ur7Zn3iOmj_0oCQzAhlmlQoAoC9350qoAkGJSuEtuAL
 NkYTl9aLsqLVGWxruGgPnh0FzjU7MeaRtZpmSoVs5fxOSnJqUjJTy1WXBaQJzxvoyTkhD8eP7xXN
 kLUj1_BpNEytRNtyUyibY3fNBBj9XqORPnWJBBuCCDR8EBeI0HVQTExiiHrKeuCQ1MWF79Do9exS
 SqWv6jkzTlpmwrbHHM.SHqBP2uiU6yttlMCL_qXaTr_RNWoG5UGp8IVcPLduhvPLj4yvmJ3kfnPk
 gjfi5rKGxkzrIL1BIISnh.Ojb9RhvnVYz7eqzcqanUPOUbKZwmJNXTrHZABW5bxAeUFOZKxGy0Qm
 9IQK9L_qAWEOy1ulw01VAfvNH9SF_eBt7irbGGwfalXO1DcLtwLwxcghGvo4oyAUncMZ0Hhor011
 qTm4J66ECcBJuz7HapVVwLWImVI5dtNKIRSJI.WE3JaD.aQ6NZMgag5JNt9Xbig3jlMJlSKO8din
 QK47yXFRKlpnsYSjT8i4DOY3bi7RSLa9LA.nCp9_YGzKVQ._HqVU4VfEQBstSwDk7wrY_1MJ2xvp
 wnDaACbjkvfAlQPgCQZ9uZD5XjLZdNtpKbyGIwp2zFSPeTosx_Eo79hy93P2xyJ9UfCYlRl1Llxa
 abJaM3P3XPrC_vLvVBNTZp1UrglFZjzY88pk06UWmYbLgYO6lFAVaCYUHgNdk6auu2PMf7mLA3bT
 ayqr.2z6DxFKwa09ZAt_oKMMx0mHs1mP0Qa9TAqJBuCOhTuaVmFn564_1BwJxOg9DnPTDx.ATp2X
 n90vzXhnOEhFiHyZG5VMVA0x_71g0IHEVSkh4uqzi0NBCZE6Dl_6gdwI8Gon_pLu_9GxzZsBlkEp
 SQKeDpcSqQ7B0mWToX8yNy29VZA.Rzfb1lsK8QsyL.mZtP1996jYu_OuaBxCm03C_tkdOKJB_S0b
 OM1QXT4TWOA_AZ5mFvuGWF7.o8.dOXE9IelpBwXGGS961iDvUq0GobiKlo6u5GqV5rVjKiK5xQ2m
 eWbzalFN99y_Q6RuQ39aFTCmVralqDUnSU5DTXxxnTxh1rH_yRhDBK10ec1pd4jZEe7AGGZ0.c3X
 lIZltRkFuJp1iKN.XRe9gQlM.F3jTDbu1d8bbd6KOT6smMCuVseTTYIBt1sAW0AUP0etPep7V2bw
 T_MtjUYVyuciq_8ZZfSPxv10vmVI9bTwtJkgtVFM3eDZGG4tkYSqe.lmdSqPTldCdU0o11hJNgzs
 gPgl4lZ7gHzmT9e61fRU9kw3CEMVWxv11zokT7Ip5BlA8M73mPim6m9Az1vbzTPqLlCQEpNv00OO
 p3cjREokS_RApRoIs5BjKepW0xaS30FEBRY7ff7dALMJq10FBtmjpeD0qYb6fWoE.X0his18ixnv
 CscnyEaXAKaP95TidrPur0nNj1NNVu1qImpEP9U8peUdcLg5HrmvuQ8NDnaSBu1Xs6_ELr4efo_L
 1cwgT98XLFmbWL2UKk53eB9GwI5u2O7ShGqNfPo.7Z.t3fvlaXZ6jd1PGqhChveB2ZII8O1DTk3C
 vaczM5Dj6h1uzgM8qi5agW38KgkDQ3uFgkVuXI2CDIES.vdM6NZW.VWSBBFVv4gGPD9Rc1_ZbuXV
 WQah95bJGJzwKRrhXDdnEkEq.GSIXOYr23avNVaeJ8FNNQ9Hsx5p37HQYHQ7om9JOPtsUDcae8_v
 xXPOFY.1rjxRPBO4COlKZvFg.95_rV8roPZtVGfMqKQhFxwFBvwNJWqqFCF1HgVk.1DV6YP49OC8
 xbCN7ufvdBh5RaxLHcNk82fnOqT_JQyHduMAx8MTTs5yKvdxDEOUSJhy4PtMArxGWhI21smzHsBJ
 Hqez_SFhsSkOXqgtC5QXFTjhYiWfMX78Kvgbjre3yKZqthKK5sc5uCetMHBA_oYh5MB0hTGD3Bez
 GfWcS8CK4G.DY1_GynS3xBJIdpBYFdDKXRYKFBV2psNkQSY3AQMtCA.Ihchvf095TPv5C47TyoQX
 UHGpZAQVUc4GqXcCf16zdnyB884SvnFE7_7bFMp.5xppMiTnV91bcucHhXb6UFxuuXwey7AY4Cuw
 1Oy7ZFOm36xiGh2AscAwjzJJ9zuy0lEuP9PbLRjI7K.K3bwM-
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: a947b7b7-6c60-4071-a97c-c08127f5f582
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 27 Jan 2026 07:39:22 +0000
Received: by hermes--production-ir2-6fcf857f6f-gch58 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84771875e54e61ed0bb89230515c8a5a;
          Tue, 27 Jan 2026 07:08:57 +0000 (UTC)
From: Marek Mietus <mmietus97@yahoo.com>
To: netdev@vger.kernel.org,
	sd@queasysnail.net,
	kuba@kernel.org
Cc: Jason@zx2c4.com,
	Marek Mietus <mmietus97@yahoo.com>
Subject: [PATCH net-next v7 09/11] net: sctp: convert sctp_v{4,6}_xmit to use a noref dst when possible
Date: Tue, 27 Jan 2026 08:04:50 +0100
Message-ID: <20260127070452.6581-10-mmietus97@yahoo.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127070452.6581-1-mmietus97@yahoo.com>
References: <20260127070452.6581-1-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[zx2c4.com,yahoo.com];
	TAGGED_FROM(0.00)[bounces-253739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmietus97@yahoo.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7289490C5E
X-Rspamd-Action: no action

sctp_v{4,6}_xmit unnecessarily clone the dst from the transport when
sending an encapsulated skb.

Reduce this overhead by avoiding the refcount increment introduced by
cloning the dst.

Since t->dst is already assumed to be valid throughout both functions,
it's safe to use the dst without incrementing the refcount.

Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
---
 net/sctp/ipv6.c     | 5 ++---
 net/sctp/protocol.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 54f489c4c41f..71fb9ff6276f 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -219,7 +219,7 @@ int sctp_udp_v6_err(struct sock *sk, struct sk_buff *skb)
 
 static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi6 *fl6 = &t->fl.u.ip6;
 	struct sock *sk = skb->sk;
 	struct ipv6_pinfo *np = inet6_sk(sk);
@@ -243,7 +243,7 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
 		int res;
 
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		rcu_read_lock();
 		res = ip6_xmit(sk, skb, fl6, sk->sk_mark,
 			       rcu_dereference(np->opt),
@@ -266,7 +266,6 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
 	rcu_read_unlock();
-	dst_release(dst);
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 98e5dc217959..fb26b927391b 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1038,7 +1038,7 @@ static int sctp_inet_supported_addrs(const struct sctp_sock *opt,
 /* Wrapper routine that calls the ip transmit routine. */
 static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 {
-	struct dst_entry *dst = dst_clone(t->dst);
+	struct dst_entry *dst = t->dst;
 	struct flowi4 *fl4 = &t->fl.u.ip4;
 	struct sock *sk = skb->sk;
 	struct inet_sock *inet = inet_sk(sk);
@@ -1056,7 +1056,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	SCTP_INC_STATS(sock_net(sk), SCTP_MIB_OUTSCTPPACKS);
 
 	if (!t->encap_port || !sctp_sk(sk)->udp_port) {
-		skb_dst_set(skb, dst);
+		skb_dst_set(skb, dst_clone(dst));
 		return __ip_queue_xmit(sk, skb, &t->fl, dscp);
 	}
 
@@ -1077,7 +1077,6 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
 	rcu_read_unlock();
-	dst_release(dst);
 	return 0;
 }
 
-- 
2.51.0


