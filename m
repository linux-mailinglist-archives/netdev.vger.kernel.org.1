Return-Path: <netdev+bounces-157991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1293A1000A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 06:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC98B1887E77
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 05:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C0224D6;
	Tue, 14 Jan 2025 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mTTMbjyz"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-15.consmr.mail.bf2.yahoo.com (sonic313-15.consmr.mail.bf2.yahoo.com [74.6.133.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8C233145
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736830934; cv=none; b=fH3FidvZ3LY0evWwdPdErqlDNKNLagbAW0kZ3simchxDuQn0p+o6zy85AEzXfEXSxLTsMIDkI7XhDAGzWwDP8y/WOTm2RFwERWaLghGsTLjEOenliMgwo5UCnWDkP7CGYyySGuy+c2rl35NhGwuBLdvac5KR2t7Gt75JKkktW44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736830934; c=relaxed/simple;
	bh=hcJYHOj1XnndsNPEjxZYCPC4bqmWWhhGR1Yu9P21Jnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=gYVz7/fqbBKmYBxsTqjSb51qOgXikuTw2ijtsHm/83js8poGHxEjBtp8U1CEd6YRR+JbF+Eutm0Q02mx8BZIwgvJ7w84KjZRj3SkZdbudMJVHzAFc9SgXFjBiwbgxFCXdMaWgXUM1R3RcCLDb13yoaVNBSIPuLi78ySEnmgz5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mTTMbjyz; arc=none smtp.client-ip=74.6.133.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736830926; bh=fslgc31tnGO8amLDA0R9D/djwuZ7jE7e8nn4g2ss0Ys=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=mTTMbjyzxJP2VtCGDz6ufmaYDiJZ73cJGY+0rtG4601UXkEmN7B6vjk2YH+ss5saALIPnUoHf5u5KiWx6ZZs4wU3IGmBFSl7OAg/4dPxgUM3hFoX4fFB4b/ZaFbC7FgjaE/CEb4LleGeyWJNE4hz2J6MD/wGyt3taK7VzmNUJQCo6bzzRwHA+bNzzuMc0HYEDvLVY0fqFJNWli4whgdhGQsfkFPV7HAUimY4Wn+a/wqAsgHZ+Eg5OPvTdLt40MCdK0r21cHj74nRwnAQjm0eu5VsGPHx4hjSEjizkpp9nlbZ8Trb9FUKTbCuySB9RT6hME28OOI0VW4YiXvjdCGtJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736830926; bh=rNJZoQQ6q/UUJsvhxjbEj0hmf52jOhlbBEByKJUpoFI=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=aZK3iniRbEF3Nj25dW7fhz06Xg/s32kZy2uxT1/+aNUG9LSsQFa219PTJOWVdZEaQ0N0SBTloPayz9Qt7Ag1Ih3a6K540AwwBx1zcr5EqC4UTqH10aPVnVX5FGHfAAtJxjs0Pf3iAsTrgcoNlmkZ+1yD/AGIF5xQOgBMd17xbRDRyQpzElEUbMtAVbn7pA3Efm7qxFK/PLaaxj9XqV+Y/abqlJrXTb0woVqENiD7MBdpS9Nc1y0wtn9HNdUFy2ymsil1muVeRuN/q/93G24O+ZsYh76KUjNKoEoQdNYocnbjbIwEtSNbCdHFhrEn/xKlhpEMX5IlMQc1xv/TA5xFVA==
X-YMail-OSG: wwywYjYVM1nGP0AcCoKgwiOmlfjTpcCGMmFF2u8ilQaevIh40Xr0uct5KLYKmgi
 Vs7_aZjlctbrpSBCvjNGkqKSOFxQ.JjrA.JQYX0wY5yWQCqGAvtiu6cAZjncfHys2oF6KwlZkhj.
 rM5LPHGMQgnuvzwRgVEhfruddmSxojgYBLkp6mVkfijHpiuw6T3pf6eBWTe1N88KDAhG8z_Tl3oW
 v9XCdhLeg5CwG0qtQYjtIwmhAv61Xg5ZRG_IqSoQfC83Gdy4vqDKRtIE0rDkjxb3BD4sqm15qGe9
 e8CK2pnPAZX_Rc5TImHtfMej_yOVh6jXe0I_0KsOjetDKFn5x5NMBa3jnORDYrtjOYaP4QHFCXOf
 R3dMFqeb.yNTjhn.WCPGM_OvvqW1MNUcBERvNNLvdhSun9Evzme7xHefU4Ddp1lFpbS_ZdwelnDJ
 MTEFaS.Ksqsali4Qd9iL529Gh9XdO9pmp49mvrnpP_3X6tnByxo28wzIRcVURmdpFBO8sUmYwjCu
 RiVRpYrSrdBPjJOP.VuU7O7Duzt33k1wfhNzGe9mIRIaKSqEs5RRx98g7.xuJ1O0zm.7JrWV72BV
 RHwhIy.2hMo670vueH9rRLHrER7Y_lyqufO0mURi281ReCv8n.fkV.i90Qe7S_ulKAx5iC3Y5eKd
 7GXxs8imoy9Qm1eFr_PgsAxj7J_4vNtjbVUfOBuX3nDS2cw4Ge_uz_fQr2YLe_LepLrNNAAXapLZ
 SQJzR4HsdNW2hBetuUOJRmYrKzTO2Q8C4wdoMi7bZgxJY_fVpvFr6fioNuFinqS2X5unoqMTkrXA
 bLC9zvX_bg9IxGDz5xgBqybUXcJusGf46SPmjj0YWD9wFV8CmMvNyHpqL567ifBj_38xBVd3S4Na
 _f1K8.YN97WfIPV0lXmxmCJpTTjWnF_s.AEuOLS9aLDFcts27m__rtXO.y23fWFTwWbg87_ZHhJE
 eb0P_657oG0Ek_FZyNGFTmkwF_fHmarif6.Hc53fijMS8G.IVA5jyuDgvuv3_PP96rlNH6h_9N.w
 LpxQFBcwVydn2W8k4Kr9WZMekRqwUSRGf6Xy34xmTzTTfJVpnDGwvxUM.csLi49nUoSEq6Qm0ygK
 snmxL4TJCjqNDz9qjbFtN39CpkpqSv9_0GaKxBA7wXaJgbp80C_GCvsRazu08hb9uqopovy17sia
 GoBj44t2gRdRKTA7SNzuHtfJ42OerL4AEzpgBn5xstLUgnIbwTe5trjLYG_GkI34dyZJxVyzlvpi
 f.lf6tYl24yiy1bKn5Y4fXCuVKyJ.kQ8zMqPWWBeTtaH69dOGnKKTezKMQfblNc5cILxOBVeTfLS
 zd72I1Uae5AGQQLRetw328KHYIrY1oslDFDrB7ft908bb238zFA6LA7bpn_JuD1MQYVJHEUkkUfs
 9sdB1gAQYBnZSB49yY_YvZrXld86A6TCPQyDmVTREL9Dkpk6tJYkaSBX8SQ0C3tp33FuNYakRYko
 Nrj9LeClSCo_Ih.q5bHFRr.ENSyG0XUeNlRpQmJqMrs4QF8YIZ.jIPWQxfHXisToU1Gk.8IGVW.w
 qt1BA7mYpaMMC9N13YLb0VhXBn4LYiMIqgqe8Cy4sJ.ICrxQaBs4o.3YdR_jOjuxgm6fGd97IY_g
 vKAIVOifwyNhm3vLjoopK7f50Dqr_pMq3U4pUUI9HMIwPhUSfbjK8DTF49DXO6UHttEZyESqCHDi
 8y1_I.BB9zXBhSY1MZhUQJSPao.K.gRH3Q.Mq4cDgxovW.HEdKB9JgXL_kk554GynBsJHOD5Dkbk
 _wtcEnW6Fq4GOVySxO3RYaO7NsHGmc7zq0DaCNieLZRh9th4vgJKMhhGD09doJlY5xvhJQFtUDUc
 GWdc3_R0HppnUBLmN5aAiPOGTkIn2TPLp.YTJjGpimyThCAn_Mm36NBlDR_QHYAF3ZHTT9FS0bNS
 uyYpuXtwF9NPa25JzQhdyOJCSAxmxUiOgvo2juEBG_kPRcmFkKxdNSx8rT7HsvALSezDLt..oFMf
 MoUyPjPMqVxBKxBhnBgHhkJhOKOHnWgno95FI.n1l75d9VXxWR7yqVG27K08uZxbGl3F0P.biTJz
 Ove49lsa0g77w3VVyqh8HUy47DXKhmgi5DOoC6NrxIDzY0Ab2VNehJg7muToqLnPFN2oFogrjR4N
 lUIKO1BY8dVZ2z0Ku4clsYmh2u33kLef4zX5npVSuxxZ63NLwSTZcC4oWSnHV1gDkkGH4.0AWBq_
 n._c4epIa.w3fDo6TdxmpdPmtHYX4K7Qqn._QkScThQ04pFxvQOQ1Vx1VRH78
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: 006fdaa1-d149-4c2b-8d02-8a20ebda85e9
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Tue, 14 Jan 2025 05:02:06 +0000
Received: by hermes--production-gq1-5dd4b47f46-dvwsq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5f2f0f057479afc4a96aa972331f7412;
          Tue, 14 Jan 2025 04:31:40 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: netdev@vger.kernel.org
Cc: ncardwell@google.com,
	edumazet@google.com,
	haibo.zhang@otago.ac.nz,
	david.eyers@otago.ac.nz,
	abbas.arghavani@mdu.se,
	Mahdi Arghavani <ma.arghavani@yahoo.com>
Subject: [PATCH net] tcp_cubic: fix incorrect HyStart round start detection
Date: Tue, 14 Jan 2025 04:31:31 +0000
Message-ID: <20250114043131.2035-1-ma.arghavani@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250114043131.2035-1-ma.arghavani.ref@yahoo.com>

I noticed that HyStart incorrectly marks the start of rounds,
resulting in inaccurate measurements of ACK train lengths.
Since HyStart relies on ACK train lengths as one of two thresholds
to terminate exponential cwnd growth during Slow-Start, this
inaccuracy renders that threshold ineffective, potentially degrading
TCP performance.

The issue arises because the changes introduced in commit 4e1fddc98d25
("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
moved the caller of the `bictcp_hystart_reset` function inside the `hystart_update` function.
This modification added an additional condition for triggering the caller,
requiring that (tcp_snd_cwnd(tp) >= hystart_low_window) must also
be satisfied before invoking `bictcp_hystart_reset`.

This fix ensures that `bictcp_hystart_reset` is correctly called
at the start of a new round, regardless of the congestion window size.
This is achieved by moving the condition
(tcp_snd_cwnd(tp) >= hystart_low_window)
from before calling `bictcp_hystart_reset` to after it.

Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")

Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
Cc: David Eyers <david.eyers@otago.ac.nz>
Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
---
 net/ipv4/tcp_cubic.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 5dbed91c6178..76c23675ae50 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -392,6 +392,10 @@ static void hystart_update(struct sock *sk, u32 delay)
 	if (after(tp->snd_una, ca->end_seq))
 		bictcp_hystart_reset(sk);
 
+	/* hystart triggers when cwnd is larger than some threshold */
+	if (tcp_snd_cwnd(tp) < hystart_low_window)
+		return;
+
 	if (hystart_detect & HYSTART_ACK_TRAIN) {
 		u32 now = bictcp_clock_us(sk);
 
@@ -467,9 +471,7 @@ __bpf_kfunc static void cubictcp_acked(struct sock *sk, const struct ack_sample
 	if (ca->delay_min == 0 || ca->delay_min > delay)
 		ca->delay_min = delay;
 
-	/* hystart triggers when cwnd is larger than some threshold */
-	if (!ca->found && tcp_in_slow_start(tp) && hystart &&
-	    tcp_snd_cwnd(tp) >= hystart_low_window)
+	if (!ca->found && tcp_in_slow_start(tp) && hystart)
 		hystart_update(sk, delay);
 }
 
-- 
2.45.2


