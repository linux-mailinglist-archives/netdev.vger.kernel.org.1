Return-Path: <netdev+bounces-157579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B273A0AE1F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 05:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2140418865CF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 04:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7980F14A629;
	Mon, 13 Jan 2025 04:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="nCYwFgsb"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-15.consmr.mail.bf2.yahoo.com (sonic313-15.consmr.mail.bf2.yahoo.com [74.6.133.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9213E14A0B7
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736741478; cv=none; b=rrD0OQMHCERooIavYQk5ChVkqOK/BV2gzbsZEEf2MTuE/mERnadGCVX1VNidgO9xub7LmzVXwuEdyUu1rzZhiwTRyklV6o56xnJ9BS8JM3mTDy36VZ4PE/qV/rzCvQNvc+aqVlnyDFoJGgj5KNKW/WM/ZTU4XCueEmDuuhNNsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736741478; c=relaxed/simple;
	bh=VeVFsBj2QxdME0VrZ3xMek5E7CUQuGFqZj1EtNu9urA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=AWMYy0ys1yzbE3WHSo/iDu7It+3Cp2AmQdb8acHulQHM1/u359nZKDA5T22fQc9SntR689VpnpmpFd9DWnVGz4AhLNKRIznz6TJz0W0qxBmCnotQx8+yq6LfRlmMigY85m+waifVHbPhw2adG6J84+OmPdHsH/g70O9HsGJnSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=nCYwFgsb; arc=none smtp.client-ip=74.6.133.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736741475; bh=QPt8HIeVJh8dcP5TCaQXUGbNj0NCzNHfAkHXujytotc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=nCYwFgsb6jWKis3fgqgucGnA3Ds/mM93WwS3aqjQzW5AX0TAgP3YqfXQ3DVtdzgtKW/Q24gUADZdENsAglDW7kOaUYwSpbIBgzMvzMav0GcoylOptMbp8LnH6D0qeGt3CGM7waO7gSJYu9vhMB5zszseOLc7JuycJktwfzfPWQ6m2hF/65m4ZSK6vwR8SQrJ6mtB5Oukkao6g4riNmAZBahhlbLCLzFKaBcHRK/RHstzJlv2K0Mt9R0oUNl89iitUIdJaqtHwbNcNPwnFNZmU+cLmgMVLq/RNN4wcFW2BiNIE6AWLrRLND3f+E/YPl/sPh+XVMdZmkSNnpf1NYMMWQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1736741475; bh=LvmMg1dHcd3n4yAEpjWfZAj0x5TmTFUgIe2yLIibXZa=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=IFGAuw72HgEZIeLziOyvYMM1zxUFfcP2Di+bCVVivqXx90lmQfz/KKYdtaaClGUQG1l+8D2nOfZ7TWb6aNOnhyLQNiyZJVBra4vyWXEpjShUYHb92i/lP+BmzuEUDnAroCo2qIoTtz6IJ8Uc21NPPi5s+6tLyVEabV0B8zTYzb68kSfpGOMKanI3vjVuW5H9VIZ2JIddPUIDuFVEhMhfNXmIOVMOGeVcVrYCtcRicW9rt6tWPg934K9UjF4l7EqA/KXJp3iaIqQ+5U5lOY7jZO6Vi26gEajgW4o1hORERWRjQoO5HmxRbfBowO2+1Km8/U0UjkmOKHiss5yI5YfWlA==
X-YMail-OSG: r3olDncVM1nNX9vNYnhTSUVYqgElgpVztTjCLQNJcmnmUcG4u2lIg4rpRN5MNLe
 4WNrWoiFAK9DTpoHfyulb8rq5_KX8wdxnpRQOuCdpTU4h3znEJG07s_4VISWcT0MzF3gGIvNF7v7
 JsSz4sz49Mbk0z..83izwz_Jny0L4pXwCdlGHG92GZgDaCd4JxPr7vZaapWXHoeBP9Y5WkuIFuf2
 AcymHDTLEy39BPiXY_Y4PRzYmEMJo33o8klcHEOFLp.xJveih15YSebwroywJ9TJMGL0IBb8PtBg
 5OcCXybJJ_zNH8HylzItXFWSL73WZQSdaszuisMaMOA1u1q.6SimMJfBOIlEibcc91mOTBJDNGwL
 hVVmhfMT4rk6Ffz1Kcxg2Hv01ZHt0TgK8W9oCrCKRFiXxxWRhxlOnH3Wl0pOnMQvbNZgz7tul6Dk
 3Vl.xViFa8UpW.J4FS17KhxmGoDTw5me5KKcH3YFWzCpySf7Yt1C__WwWsWXxQYZqnZdd0tq65Rn
 anw3OsD8Rb9v3kAcwkeKwM.QRawaQH4WodWEqPZ4NjoSI9Wsb5anbvyme_xIz0H3oybaBdMr0FzP
 zh6dNgqKorxLGOMEOLHx3Q.FXbaOV7CHfskOa2WbHy8Z7MmkAj1S1dMQfyx4i6luYu2lOCFLIYdw
 q6xOeT4XeEc9ujBz6jj2ujaO67fG_k_XXsKSfcPpBFbJ8uc3FcAjBcrQ0ihIMBhrSo8c_7.EqO5Z
 ZBFkcNiDbWtYWpg_fZlx1RVUqgflYyk8KJ8rHCMJ7n820bmRdOWObLPadM64CsoX1rfkTRfJpk2t
 tc5I5J86jSjmP0bG3ggUxMucVEIgHFp5ELReOd1dMTAqpr_5Dc5Puk0xKtJ2kxA1YpA8p8VMGTy3
 khvK1wPJMzajcXY8BqhCSYeEyGFuBKiz8X2bjxOF8GF9S7mnZ5ta9mbKg4_sl_ASm9XeF6yjRMKU
 j.V1AOClLQzIlS3UqU0o9Ek.0z.VH_5BxfqNWkoJbi.3OtQM8VYkaskTKMgm_HtCVoiaDeQDVErC
 hkK4_YbeycRDxHmiNHmaop5MVAEhpoTxW4qDh7xTAIPm8E0lsrT4DqWEXn68fvHDa8buGoECfdWC
 SK5TyGP.0Pxbw4zc9tulnkslamGvHivbEXI.Q649IO0obZRzb1..74Od.esaZjjJw9t4Si_Fs0Lg
 ia3SKuoQzIqxoz__qckyR.g1..ky1kr3.3qPxzc8OY.gtkFIWoYsW1ISiOPE0fBACQ_qqdbmNJQu
 UlTIN9mh3JGfBPOWCkolQ.lovJ_Utaw159.7s9hnNhUljYjStayJ60v0hYZPmm.7C24DQo_FdTH5
 oY5zLb_9Zzigc4O.FLKQi87QMf1QTUKk4cE7JNPPDMpHE6gB3MVSTrsbp65Y.aF_.9G7Uy11xXox
 dBx8trfSkheBzxlY5twH_7uDnSbf8n64152Gxyc8d3HP8IiljQxfS0Qh8y6GLzATjy7OJFcmZSnH
 TEQOFUxK1qm8psIUWJRvSLwdScizdbO8ZCzqbnWX989feZ7rJyA0o3j87GxTTVFttjiOqd1ktdSc
 p7XB35_wxCYv73M5SPvCPJ4ZSGJZHx3yPjxZy2TDcLBKsTNBK9rxie5lL1WZbENIEOmhZ5vSiHcg
 1WrwDcOqhNWLTrX6bUgrubCXzDjYL9XFOICnpc1uo9VqCWHvRnSfK1nnlBfqss8OsiCfe_IXggHy
 7KFRTlseScrNgibaD5OTrw6iow_TL3Da0LPVuvYwMhzHq96W1nTGr5u04_xHn8YGxmKlcP7YsQ0e
 qafOWxIHNBL_KZGvOMBaMoQFX5HiQXkoCCOH4fj_mOE6sV_i1NiGZuXM7qW415zuAQ.L85n5M_V4
 P2dDRX4yC6r0l_GSObo_opgqFRjufLgHbikmURmUULSLNfNivl8d5Uo8DtVa7isEIJYN8ZplydzE
 ZgBaLraEf2lrucfYdYyh_TkmCskaoITZC4RI.McdQ37cEu7rNLktx1pyZCPlvRbkEKPwWWgbIdKT
 rGnzh2124oSkfJTdCxMyPxTl2TpMSSPu0MsaO8KYtU4BC0b5IReud7OqYkqCyuBicAC5HIIrthTL
 o66l28hcvbWt3Q3ziG2nETxzTa1jkaukLZ6yp3AUno5H5ymoKOTSD_w5lyZvuDiRus1D7eYPYOfm
 E2Dtzv12TmsBj5kywPJsIWZhdmEQjohecmo77oFFEP2APwnEhjzo2VPQgJiHremcWTTgpjzKlIuH
 KOXxr6YIQaizdWJKXnL6uu1kF1YBtncVB_w0WQMiS3Ml8U5BkzCbyvIPCGg--
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: f0b441b7-9587-487c-ac7c-c03144fe67ee
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Mon, 13 Jan 2025 04:11:15 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 38b48d2bb23278eba059861bb4d63b73;
          Mon, 13 Jan 2025 04:11:10 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: netdev@vger.kernel.org
Cc: ncardwell@google.com,
	edumazet@google.com,
	haibo.zhang@otago.ac.nz,
	david.eyers@otago.ac.nz,
	abbas.arghavani@mdu.se,
	Mahdi Arghavani <ma.arghavani@yahoo.com>
Subject: [PATCH net] Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
Date: Mon, 13 Jan 2025 04:06:56 +0000
Message-ID: <20250113040656.3195-1-ma.arghavani@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250113040656.3195-1-ma.arghavani.ref@yahoo.com>

I noticed that HyStart incorrectly marks the start of rounds,
resulting in inaccurate measurements of ACK train lengths.
Since HyStart relies on ACK train lengths as one of two thresholds
to terminate exponential cwnd growth during Slow-Start, this
inaccuracy renders that threshold ineffective, potentially degrading
TCP performance.

The issue arises because the changes introduced in commit
4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
move the caller of the `bictcp_hystart_reset` function inside the `hystart_update` function.

This modification adds an additional condition for triggering the caller,
requiring that (tcp_snd_cwnd(tp) >= hystart_low_window) must also
be satisfied before invoking `bictcp_hystart_reset`.

The proposed fix ensures that `bictcp_hystart_reset` is correctly called
at the start of a new round, regardless of the congestion window size.
This is achieved by moving the condition
(tcp_snd_cwnd(tp) >= hystart_low_window)
from before calling bictcp_hystart_reset to after it.

Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Haibo Zhang <haibo.zhang@otago.ac.nz>
Cc: David Eyers <david.eyers@otago.ac.nz>
Cc: Abbas Arghavani <abbas.arghavani@mdu.se>
---
 Makefile             | 2 +-
 net/ipv4/tcp_cubic.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 7904d5d88088..e20a62ad397f 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 6
 PATCHLEVEL = 13
 SUBLEVEL = 0
-EXTRAVERSION = -rc6
+EXTRAVERSION = -rc7
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
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


