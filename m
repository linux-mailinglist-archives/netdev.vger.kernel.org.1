Return-Path: <netdev+bounces-158328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27885A11680
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 02:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339D5188A9FB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70F35945;
	Wed, 15 Jan 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LTa8Bo1y"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-15.consmr.mail.bf2.yahoo.com (sonic313-15.consmr.mail.bf2.yahoo.com [74.6.133.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62D1798F
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736904363; cv=none; b=Awyzox8RSbtr6LRTFmOM5nY4dMo3Ve4amBSMtnpj5yjh3FlBvMv5YcCgOKMELtdhLDhfa4o1KbVj4FqdXjgvCZBUBiTDmSCY1ZUjWzH88eNMtj+F/FZlzKY4HWLkDKlvkUg4YE3XrYoM/CBjH/esf+FdW3LzgtPZXHE7nDuTVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736904363; c=relaxed/simple;
	bh=J596zsZH8nthlDPy8sIPEYZu/ulpgCY7xmtl/nTb4CY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=MtWqGnqT8nLSMxc233BOoccS3apvmsySN1DwVhxgtmrttRuLsCC4jX7TgDIV4tMXyUDgatEGRWugHuNyDititZlIPYgbwbQpTmTtqtnbQOvwD9lUTk69zJQCAGJlAud4scdAhPKcyyDqkyDbZXl1JyLC0lm+aGbyaFMJUmYG10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LTa8Bo1y; arc=none smtp.client-ip=74.6.133.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736904360; bh=WhmMp4DtkoCndYSZG6Zsl0jQwRCj7Qq7I81RrO15sng=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=LTa8Bo1yn518e/RFTKce7AIw7AnAOpdojm9kKWmzBLryf1QQX00pztAg7Kzn0QTvpdeu92PI9RW+gPp6DjowOeGn2SNvqT4NyxwaGjQGiBxYchsWUzO4oq5Ew1HImBehZsIjnfeixmttpdqk0dCk/H27v4740zYj+O3DmbeCZ0cQ6Ru58mPBLqcgT3RM0MHOdW00JxuqtxMp663InencFvauczsxAbSMPOUQBA8bP0vDimHaLhjiE1LWEx8N7kA6SV1UL/Nme1RSqKKtsVVpXSY5p6n0C5Z1kJJ4UALnTJmOWDbnchjXNs+kQSQxra4EYJ4dvzTMftprX0HCp3QUkQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736904360; bh=OKkDey0IY7326fSuv0DGnUuptk+MDBBfCJEsnoknCzz=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PHz0B93Kwgc0pg4IoZq4buWOaIyfoxKFSHXSzCtzB+cZvSUGbDeh1SW+g1xnZJz0gDrzwQYpiy6cKAfmmfy2kSwzhUAz/bZJgxPnxdk7t69SjU4HshjmrdOz1++M8yEfQhrzL9vOstvh0WrtnyA2dI3nPzB48rVEJeoroNYb3SCJgg1/hMMDa0OwQ7r4/+Nz2kV7EkAIO1Of+HISbUoBzTko2VrPDTPT+vK4UUdmmMIz8U/g8uBff7g/peRcC8MeiOPvx1s0KxcwtuZX3UefebjO95nu14LtZEGSlJwlrvFXCwElMUkB35Gag3uKKrWzbHlVwKCnCO/DIyQvSuEOmQ==
X-YMail-OSG: dzcSOXUVM1kaUiYb94Kl_p5m6tJNkvPZxHfyBCRJfQha4S1MZam_TFpyEpNECLl
 3gEZOLZFREfGhSzGU94TA3iXCzsrZBoGKCp7oDBA41CEL7chCskMwN_wViaLotCzYUAnfkNMEqYY
 yfiIVHJBbKEC7TnMqe5l_GCkKVDzPtm2kOzjQ3dvNxyLBHxRzUKYjWNsdMOEj_36oTga0DL3bQT.
 zwvWTaHT5VHz5ORol.HGVeMhqR_ZtlNSxIgnRx3byWdgRprux1jCb51HYfNb9bBDeU0Bfos9C8hx
 36c0gN5dHTAyVY2aHIFw6lSQAdqlHY8b_R3.EA9yOqcuFwzoDXPs0E_PurvU.43rnMP1qBmCCfwe
 5UutrBq1_x4lc9zUmOsUua837fPVWO3BvnxddeCs3n9bvnuw4TBI3P.FVCuhtD6QXOg.Nzfp8IlC
 dkSA6N_umLc4webrl7VFiedGaWpOdMZAFmphDuthmcn1QbtaliDfoG7z1GH95ozUpJk9q8Zkj4iZ
 qGWebNAg.5D8dplNcicSULczzntijxa1ufzuiYpimfAmDsvSl8_k2HzkRP5ax_jNYYPYtpR1CfR5
 zSulz6K1GyTlNSqgpBh3lHL9PHVoWWpUCh3oJBPwFXuig.bleXVFX8.TosVDsjxwH4GQQif846.D
 f0YPMQ8Zj.iX_11TTff8.UeyeA660ZQ08JVORK6B5an5xhqeO6HtTK0KyTu_reYDKunAhipyUsG0
 9GlmMFQR2gK88m2FC5436TzZV7p8q58bWSyYtFfjofmbQg9FkOmnczL9ueAvwyH64KUHi4CvpCKv
 wu9Y1i6WIdpzczmM_gwxRBQpXWWApuaPO9NceWd6qMLXmaolUIOEVCeW.gjw_xhTqJLoNm5RpjfN
 W35ruGu7Cv2y9durzVIlUS5Z175k4Nr8SRK56f0yrFEahw_cahw8ieIYkvw8ObG97GT4ZhGXSJ3N
 CWqhNXtfDkNhU0Co_4FD8gnrEu5V0KLFwHglKEFAC_nlcOfwdqr47yF294fZX1p7lWbBYYA8xRwE
 2CHmftMGpcYd0rjnwPvBBpHWHV15MP9MzUuhabtAXnhdoqhnKW7adJqKaAuq7N1_XKq13_VuuWhP
 58L3hm745cy8c0ho42DMSQ1euJiMIM1EyQb4LzX54Eum28Kxmef6D.5a2chyH6yKH0YZcRnXg5CZ
 2V3SVV2PI5dHsXfkvquOyk8cR0XHS3LOs0HvRD.rfjYFL7b8X_RraFy6CxpYwu8BjKVnfq8.iCXL
 _cQycNxql1b224kUt8QXp4hGyep0LAqGqmqouVXFPc5OtBoE2O9fOKIwC1Ud8queVBHq9ZZPBMxN
 WFCqipygJluKaUacnDjDYGoV4LDQ84VT0Bg.r.VHjCUESZkkTdpEVCLMl8VACLs7erYBblml2Pqm
 Yd.9ADGAW3rq_kEqP_GQfSdiZXnGzbebulS9DOC0gSy2EuI8xBRleyM5CoIVWCLjhiG4jejCAcE3
 .U.OHjPNAnoJv31UxjQibUDcQKd28JEKic0dXs_LJ7_s8W9HT.RRfKXIcgQcmVjJbqYGEsfjYiTc
 ul6TJdo7DOHy5EOqjknDd2MoQ6XmuAdADPDh438x0wTxfsWAkMYXihBxkVbVw7yFA97djXREWOqH
 GuVI9Y5Jm1l02I5C46bJuct53uPP8Od0x71qfP45V0.QolKEyIuUiQUWmqaW3uKNW4ZP6wCYm6ak
 tf_odK4uf7Vn8XmjkJFmnWrb_qDjm7nEPR33IAANDr34IGYhdqp6qSHLJsGbvxAW3u_8bNXIwiIX
 fj1ezrYbhMt5byv78332T52eb_dSAqLgGcf.z1b73ppvMmll9c_xpoGsMl0pNPYeNTiG6EIuwcFZ
 YbZ3_L5vfu2Zl6LIZ.kBXLX5gWDCOjwo.7RR7W624ts1jt.GPmY2WAbBBXAX5KiY1pzjfpKT9kp9
 bNxmY.osTdbhzMS.MpU9y39bnyiDDoBr.xNUAV_rITCboIQAHqx8ZXNCzxCnQi5kiMPYMuvqbKEI
 iI3Gd9RhYV0quWpkNJQyhH90BRpgK7fV5IbITEhhyVfsgzyZyercnRvIhZd4CbvEGyZCxhRShLBh
 pqudvQ0z7btCEdIyaY0SpmbgNQ5vLxpyDPR.BRVZHDJuUGWECvVDUcTPXldI7HXE_5qmPMHFZ7an
 TYBv8F0ylp5dz6Zd6h1o.qfRv4k09sJAmW0fAonAtV6eO5Cl11jJSmwLubOnw9d2yw1YhMYzjEfD
 8MF8ByCe2zeewgZFdemFfK8f05JLaGsMi6hMi.8N9SKwqGhbQJSQ3ddoB_DSj
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: fb8b9fa5-10a8-46f4-a9f6-de356fe3ed47
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 15 Jan 2025 01:26:00 +0000
Received: by hermes--production-gq1-5dd4b47f46-9j75b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d04c840b748146b98f8b7c39c5959005;
          Wed, 15 Jan 2025 01:05:42 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: netdev@vger.kernel.org
Cc: ncardwell@google.com,
	edumazet@google.com,
	haibo.zhang@otago.ac.nz,
	david.eyers@otago.ac.nz,
	abbas.arghavani@mdu.se,
	Mahdi Arghavani <ma.arghavani@yahoo.com>
Subject: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
Date: Wed, 15 Jan 2025 01:04:50 +0000
Message-ID: <20250115010450.2472-1-ma.arghavani@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>

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


