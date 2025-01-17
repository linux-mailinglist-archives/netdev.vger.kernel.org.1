Return-Path: <netdev+bounces-159474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B409A15964
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8017188D0EB
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DED1ACED2;
	Fri, 17 Jan 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QTG2Hu+D"
X-Original-To: netdev@vger.kernel.org
Received: from sonic308-2.consmr.mail.bf2.yahoo.com (sonic308-2.consmr.mail.bf2.yahoo.com [74.6.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0204B1A9B5C
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151713; cv=none; b=UV4eCDnM4A0hLS21dY3pou7ZmKQZTPNc2hSvWDreSgn8CgIh4H+5Ymvx9THXZoO6huHL54JB6YRohKk1fEYloYNhhsqRydTddyvDUVTBVpLBqrD9uUdy23EQ4DgSMB9VUNIieFCsvt2XGFSLP8SYOwF6YdHQ8ZenC67p6SR25dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151713; c=relaxed/simple;
	bh=kkyJpN2H8f20qQxk/PKUdwzdlkTFXqkJ4LLKWy+l3gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=sJNncF5Gx515KTZFbIz0e8o8AxW3WiK6/KzRiBcBs1np0s+UIykq+TmeVAV5Zm+RF6WmLY8pJ5P3CP66AnGfgA/h3/VkXPNzYzpp9h+/pi0LJNxU4zFSURgHrazpTeUb2hnCNzOj+SW/b902j6F3k+GOMdby2sqtBklZKFlRsD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QTG2Hu+D; arc=none smtp.client-ip=74.6.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737151710; bh=UA83hC/G4Of1hbLyj+LRwSJ/EKvVgrTXzPyDrvhG2+g=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QTG2Hu+DkkxZnUWFW0ELYk9dPSiePXV5d/+CB7NnRsB8S/zgbF5aMhG/WnuDPPArqZTAXYOHW2+4I3TOqll/7iWnIazWGySWkfVhgpksORS6qal0OYbnT01itTQt20ZVr1BKgW049j+PLryQ44g7AjME5gMhOE6+GJLmWSKV0RxGeFYi3ndHXUFQZ+Pi8tVqtjH3wCRrMKeM24bkKHHW8fk1kDG7DogImNrSHDCLB96tL/ksL17nT3w6+gwdyNCsyDZDSR2y6YNq4f0vG0HILuxCKjoZYeG3qw/1VxID9sziT24gPzIbJ9luEO2mpkx2jyIoUAMfbe3uNrF531hVwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1737151710; bh=kHF1Kxmi1SQTEC6hFA4jIew2kM0/HkP+++mUjsRKA1j=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ZI95PnsGeSXo6n6y8e7GPwropNBqcEFxHrGWdFL2/qSEfTEBZx60N7o+RnRsXQdIn/2a8qDJEyxDO45m3smz4me4/EGUymE6q2Zxv2+VcTP3Zl0okdh65mjqT1xvSrGB2VBCLJ6+bLgKH3lVblWNI49wRqY4G5ekT9pGrJdrOShaKQA7nCkAjzpCQYVhJ5HYirV8CSA+B408t9b7G5T5rDFFRlVcI81qezrBJu/CCXdcoJvTj1OWZapNI3EuPAbJpDTBxX5tp/AYd5CR2jPLF7zCersJYKKiBCXHv9W3WOUafO3jFzV8S70l/YqZqWVZ9u3eRGM+OzJuCxoFLXbsYQ==
X-YMail-OSG: xfvZO4IVM1mZQpVg_g9IRENk._e2vX13yiM66cF1HNQExz0_RdVYBichFLlNzYQ
 Ms7se2AOldbZCHZ3atmyVmPXmYedvFnLw9YaZknhH9xrh.AzmZypUotMCAvWLRcePYLT7AHE4zty
 0kWrwZtVxWklQOMzMhsVpf5INuHfFdyJRqk_9vGtWrAUa8ZbHGyeezW889a2fHn8Y4oYFrQd.rL7
 BtVPfuKo6S9FRPxxXs9IpmPiEtx74SH_goO0a3IJsbcwZ6iPXPRf48oOeKhz7kTK4cmsEaBeR1Tc
 Y86miLVkZwYfdVdPOk99zrZT_wsmNe1HhlYLTVYiAqoBzXh4e61xXWHlBpT4fxudPyxZAoXTlmQZ
 HlQ.74afJbAmzWK0xnfcIHTX0jEf_GQkyECzashz0v1hMRBTP9aNcfKJiyqp8dGhnK1c_3XB6W6k
 gpZ9Mz8H48RVBFpJaEYrdyXZAlD3TWiOQtZa9t_BsnVuef5TQ5LvWt3HURC77EJf09a8WsVT92pp
 CQ8FJTC7XRD9JtsQGlmOwm7FIwYT8cCANyafL4avfTIomdYf1qYQDMq4TDtEzSltmJWs8sk..3cc
 OPDC_DBUyZJtYuf7ALLI2poNAlIB7UTaM1IzqLtPEQ8QcCESANloDbJLLSC4fv_Vd_D2rxdWW18i
 5fOxX1koFE49PccEhK.jCwVDo4lfJ2QH4Kva4HwNh7tqaBG_Tb814Uw6k30w7HciCXAKUgiqPRTC
 xmixjec6DJ8g7hU92LMKEKE0Fa9h7BE6xFbcv9X.cQgmaNZhh0KWd4VEmhy0o5Wt.TMX8WTSm3Bh
 F31GRXfRXCQXvVAdsVuo95fbVQhAe89MFa1Lkv0F6DdpVEZFP1jxT3jixUU50AU_PPMp3T0r0SYz
 8p8QlC2_ybIb8T5z9Q_MpF4Hg08fIg89JsDYHeD6V27MvTbdjJWamdxKz0fZ69gn2Q3.5Vgk_8Tx
 IRJAiZyo7cTTBFMIDKw7MKHhVOiv2_uZfVxe4ZeAKLP2uugIX9DtLa0xFLaLL.wOPF0xYohFCxEz
 6z_nCgG6J9XOjvxNuVmz8Ij9oEBN2vB.AU_oBOG8G7HGuVqwMsKy_St125mv2giKS4Ww4HEUTeoH
 M1rpKXbJI.rzF1ga1d9EYc5DaV7DnhAqBwQTyh.UHaaMx_XAlTFRQIj.zC99qYgRzux4atmmP1P4
 zmm6ozclCd01p.pI2yxaBwKTjKspzdsrpMT.l3VCFLvUzFRvCqwUqlqb1c2_mO7Y0IrvDnJk4Bot
 BxmfGRh6xwStsEkxlrvRUJCc08f4Dy8f6c8r4piLjBfAvdhnd38pvYu5r01b9YfkPy90vQEYzJtM
 lzqqbj2MjrG2mVsNESnza8x0wbmcgfGG1aABPL.4AHnsy2fBLbyhOnuFbr5wnk8df4RLPBAwkqia
 NLbwcE_ajF6yVDxGYygo_FwUtlicGBYWsjXlmfYVCiJzMbqqA6BMka8zWK3PKT_b5.k_lra97.Dv
 YjrNd6JBWbpLBLMuqDUHOtyKf.PBkbG4TuklXcNnYZOckd72GnW3VAJHhjfWuI5Vf4pk445GVgon
 K3QoPFB8aTngcF9jemk3cbYOTyvkpk8qoi7Kgb6giqfXVTv9Z_YJgaq8RhgFWwtWpcw22J84pe8k
 gYrrCdcXqlMhHpU_6q4qq9MrpLvv9_aHQ8aSJhuJvozTMIpTHkbJ1H_BgeZcWgdltzH29QHh3kxH
 x6_A3bOJa08ZJAzGh0OCwEZntX04C6oqWOOe0WGnuGM3flaqgRYI0ybOYH1QPClOJzMQu6EdM1cP
 8WgE.x49lW3SPb7omA8vTFid11Nsr9EgGT8fUJtSYXZ2SkLdcD4cpSb8rQBLVIm7r6wPOTGBll6q
 JE4EXzlD0R2e4jwkyNLS4aozAWHTTxCN1HG2f.NbEv.PTW7R3QmOQ7JbVOTVpIDbUByKIlwNGGJl
 W89lYPN4Pem1_w3vDb7vRQUdN0GGbKmdzPPHB15KwPmjcMxm20J34LGRw_RKMIgt1CCRZ3uBvFst
 sq66S2W_t_nW43OK6_SSvAxiiqDcTEkSm9XfimErwmIZPzfBmDhmLFEiGAQRD9X9Ddj9AIQMDL0v
 bF_pWEVwNnNDjELBFlcCvmPQCGkVXyfSD6oo6kQcgrkyN5AbqDvVKmBZain.zDC.HrJ86e09es6m
 B_SSxZevMk4InCWHCCn.Weo.TETfvzSzBWiAXHAn.iJ3C63KsSqe9PhrLR_bTwqTT9ch4cNDV1SQ
 xkUCBZqQwbHRTxQ6DU2FWeJh2IwuGqEf8SbVzc3m.lRBF4mZpPOZSVS5bIlLYnA01Pw--
X-Sonic-MF: <ma.arghavani@yahoo.com>
X-Sonic-ID: c0853c38-5a01-4c1b-b29e-0e25507b8384
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 17 Jan 2025 22:08:30 +0000
Received: by hermes--production-gq1-5dd4b47f46-pfhh2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID faeef59307ebb752fac77bc703b94179;
          Fri, 17 Jan 2025 21:38:06 +0000 (UTC)
From: Mahdi Arghavani <ma.arghavani@yahoo.com>
To: netdev@vger.kernel.org
Cc: ncardwell@google.com,
	edumazet@google.com,
	haibo.zhang@otago.ac.nz,
	david.eyers@otago.ac.nz,
	abbas.arghavani@mdu.se,
	Mahdi Arghavani <ma.arghavani@yahoo.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH net v3] tcp_cubic: fix incorrect HyStart round start detection
Date: Fri, 17 Jan 2025 21:37:51 +0000
Message-ID: <20250117213751.2404-1-ma.arghavani@yahoo.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250117213751.2404-1-ma.arghavani.ref@yahoo.com>

I noticed that HyStart incorrectly marks the start of rounds,
leading to inaccurate measurements of ACK train lengths and
resetting the `ca->sample_cnt` variable. This inaccuracy can impact
HyStart's functionality in terminating exponential cwnd growth during
Slow-Start, potentially degrading TCP performance.

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

I tested with a client and a server connected through two Linux software routers.
In this setup, the minimum RTT was 150 ms, the bottleneck bandwidth was 50 Mbps,
and the bottleneck buffer size was 1 BDP, calculated as (50M / 1514 / 8) * 0.150 = 619 packets.
I conducted the test twice, transferring data from the server to the client for 1.5 seconds.
Before the patch was applied, HYSTART-DELAY stopped the exponential growth of cwnd when
cwnd = 516, and the bottleneck link was not yet saturated (516 < 619).
After the patch was applied, HYSTART-ACK-TRAIN stopped the exponential growth of cwnd when
cwnd = 632, and the bottleneck link was saturated (632 > 619).
In this test, applying the patch resulted in 300 KB more data delivered.

Fixes: 4e1fddc98d25 ("tcp_cubic: fix spurious Hystart ACK train detections for not-cwnd-limited flows")
Signed-off-by: Mahdi Arghavani <ma.arghavani@yahoo.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
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


