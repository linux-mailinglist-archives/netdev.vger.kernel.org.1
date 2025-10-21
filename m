Return-Path: <netdev+bounces-231387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEDBF8721
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1970919C4157
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA311275861;
	Tue, 21 Oct 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SBdXLSmC"
X-Original-To: netdev@vger.kernel.org
Received: from sonic304-22.consmr.mail.ne1.yahoo.com (sonic304-22.consmr.mail.ne1.yahoo.com [66.163.191.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E54274652
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076787; cv=none; b=jW0PSMVkcWIPf+2PGNfC7bKjnrnp4CFsdnV9gffNZ6BKXlqFQaPkBpbUX6cLDU0b8kUhBvYCJ29adGnQKEUETZAEEHQrThFL87VymYbzmPmFP6LNjRZ8uk3gBN/N3A85X08Ci99mGzDilFVmZ7HXGvIGixD3GqfojQe+ecpn5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076787; c=relaxed/simple;
	bh=ftm8M8kgFxXoYSvSNG8QL9Q2OTVexcC82KHUjNMuug8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=E7HzKv8rFqv0VomlThP1EA1KrSvTOjvdkfD6NIMelodzfz2A427NxsjAkGqUzTxj+/eKMe1vbO/65H3zv8IK6NetTPAIC4gqyTrI6YLtZuhNS4Yaah0ijQM2sK+KiTcyp6h/O9YqRx+UIk6o0i+G3srQOJkfvAEhUcWISI6ZUPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SBdXLSmC; arc=none smtp.client-ip=66.163.191.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761076778; bh=yuw/xSUedCmxRkDQiBOXubQo0wketJKhevQXRijonOc=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=SBdXLSmCW0ca850Hu/KHlr99cEZXcfCCPHi01r9PbKkHzDCW0N2yzdwVyTQwwYqauuN2gTe0NJF4FjwQgTWE7OOnanabG4YPUqgVVrb4O7GCIdj+k5onXHECNugk6VPwY7tnAVG7uaBlCAZMOyGulcjEL4phiKsvfva7ahKv5d64z/T9804TWQG04618zDwnz2MZ0Q+4se8pQ/TIrhq9TdKIRa7q995Y/jGaoPrmmdxK2uy9dJ2sj26yjNj0Cv0ub9cVySpXU3jInPK79f5F37Gb6lSGno33dyTxPG5bN/YfL3iA9LhFRBpOwNKPO65Nh/4J8NvC/5SuSAJLaVP9Ag==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761076778; bh=Yjr+I9gSQJKp9U33M3BwunIgQGnPXUumFIj0sYD+GRo=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=dsINZCCLL8yz18RyDSDP/tKLiK27tZDLOmTutRHQcaigrehM4wcTLs2gdkz+vxD3+c3mCblSfupKHHtQ+B5b/loB84Os+ola2Pk+eF5H+eANB2fxWJ8r8ig8ik1f6HSnRBx860cDt3JYSSD7j8yxFotBF3p9evuoXvTM1o6ES7UKYgq8LqU0+PkmxAgrLTVSKiL25PwmPW+PZnhg9ryILjPLvtK9/CWMy9u6/XBiUnXHY7ub49Uwi1+An86OW1gJvCBp0j/UWM7zMbat8oHhKR4h7SNZ2cqsjXNAcq5ONqILc2tV9d5L7geNZcr6zSIL2PuOfcYLxi+mV1jaQu2lvQ==
X-YMail-OSG: icqkR8UVM1lHfL2mdR26SsRoO7KXzIH7e14hZbSvmpRaDlz_Z.TzpXZ3mCNtTH2
 OelXwSQdulJIpVqxhFo1bRz3H2ks0VRWiO_VFD8ApeTTFZWacn6KMDJcaXgZ_GcosoLBhvH3KPHj
 5PcSxxfGd_p1MW8WiGPEuZSGGytdnDDsj.xiPjpAxjpdw7vwTZtY49lVi25tT2tdWres96w1wrqN
 6KXg261iTeWo2gnV4GYZBS134YBWrOlFXFgBJq.YsAz2XyR3F9riM42Cdn88M3HLx4EysBTpU2M3
 BJfCbT0zFoYrVu7uqZ0heeLfQg.V2zYKEt2rFK7yAd5P5bQwoDek2qZbWogKWvfYIZz0dxLcorTN
 I71seWHlFjbNzSXvciB0Qkmom4HJhNfguqfoNQ3Rw3KL.dZkPMoSv_ne1co0hXxKxKYNUmoZl.Jw
 fvXUtts2xXm91k.87zcfMw7bTfgaomMckLIvb2t5byQv5O18Old_1vrhdfrf7EY.Amupf0ciOIBX
 bMJW4IIzVgsMVAL4gBkyJKjk6XzTNZ8jl2tr4PyNokgAfYOeGeZmRvcWdli7JRcilljoRzKHuuz4
 hM.skWky_SaHYVELgzrOlUudbyVHkTCD92oyBH5SfV8km4X66UNeSF.1Mm848x7oU8ybGKfwyx.t
 HPTkf07WadKfwaIBD8PX5m2TCNvaJjK1og8O6kjkWJY9fztHH2caA5W4t0I9bPzB3Bo2GOpyClfh
 dFPuLlyFhh1tYCvB4yn_CJJv0lorxW6tNFU7woXeF1C1tIWhutDC4Mp.3YWT8hj0lxkfM3ryd5a7
 ssSOxELf3F52SBtrujIEX2DdzGbLGkR5zxr.9cDtULxPM2TVQqvDqT_v0BewX.Zu4kBfJ4vs3HoM
 3R_N72IUJzN4i4xk1Xf_s4zomVgXRG86bOlVVZAP_TGWw7kFB1uDkauIdlWCOuwNgMYwsBq3u9kM
 bNFCh2G7X_tpSBZ59Df11htDoVrGlCX8BgXwDvj3k.wkapGXCuPPbKc0FM_WklODPAG2jk_2Bgcp
 LqjKAVY6rV8qHR55vp8Yi3ezVR.uAWgX0zMdKOUd8nR_68uV9LZdt8jGFsOxZljMbOeaBQbatwzz
 ZTWyNmBGdsCSCFw6pjuVEOauDCtjcYkj5DlOGezZ7SlyBtVbUKCF9_RlIh8R3cFH1lFWMdk9lFS2
 NHTuGNH5WBLW3PPU9AvaKLzQitN.uq59K2zSRDXznAUhqyIUB0vRWgivRQPjYTXtlFDz_dhso06G
 BHW3NzfltFxbgbF46O0sPuR0nUk7h6JtMFw2N3nfriWpmQlGDh5JSILBgiVbWMpMrqCOjiMtQwyN
 DE5AeIKm4GYaAlCQyy7MahTyxXLZBQqW4STlJh3dx.SizavZa4I0q3OGqAYKWS3zzdcj5B27JkIa
 8jjdwT35x.ilHUymNTEOjQposCKq8q9THdma7KyrVHw._E690z4mWCTQzXc5XaALVjMshHNoDPiM
 uW0523rkLGqOtBqKCBf3bLPntHyzeA.UoDIs3PebfwBGDsc..1ENqeKwP6jFC9MI45ya9xsQEfVp
 Fr7UafDmhm3JFv6pT7hVLHJInp6RNmwC_Z6wAz2qpHwwpXxGYkk8..FEcrqH.vA08GyxgzpsQm2G
 PWHsxaQoIHjMx1ACjKwHpRpsu7WE1gOrbvbpCV4lc1UtWglOg4Qhdb2.0cc.14hX5iaubNrp__nV
 Y_SH_nnpjdN_XY8xHX0Aar_aG3q2kfMi2V4w2TdKRczw0Iat5ztIiRCLGw2MDv69wDjk85Zi66qJ
 Um1KjtTo01PC3a5lJ73T2ogZtPM1uThVvadjF7gdXl4lrTXn9U.4b2bv6rH6nvynyrkxKYQoiytn
 OkF6E6p8Utbaca.7ea0qmGufanQFg0tiTsNZ1yb_D1YPSqjP.f.TgIi3C5NFh7JQvkykVKHHjiYD
 lEQJ3p.JwzOqNBc_7Y.So1naJPL..KzldzOuCRxRnEN0TwDmuOvq2CwbCTOCLV61TDue.lWEDtoF
 nY6qMJJMeVe0YwA5SIq1tSyuuaX4ZW73wACl.L.fnozNii.zm3myAm3PMAisqeMcmkZJtwDW.32q
 UcxkUEPyWOEntLTSvJo5wEBbr6vfPyNE4sYnXMfUxxZRjoGqoAv1EBuiZlEmV6jLzc0dU5k38jhy
 h8hqcbq8vnbnHIV5EYgGMijBKmbOr7fUD_IjAYzRGdaNoPG4rwGfUmTvXHEFBc6xtSsbZiRhHriQ
 xtcTNUKuAuMXlKr_BWa1D9yqoMJwjyJDRoI50UI2.saqaSMpfOQ2Jont0qYvAWpxWVziopsuDArb
 HiSccbfbKqyRPzARgZPJ5ht0BHQX1f25TNw--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: f1621bcd-986b-4c50-9ca9-6d85d28faec2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Oct 2025 19:59:38 +0000
Received: by hermes--production-bf1-554b85575-5mt2b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa0e9cdb64094f6d0bdee0823e06db68;
          Tue, 21 Oct 2025 19:59:31 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH v2] net: unix: remove outdated BSD behavior comment in unix_release_sock()
Date: Tue, 21 Oct 2025 20:59:06 +0100
Message-ID: <20251021195906.20389-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251021195906.20389-1-adelodunolaoluwa.ref@yahoo.com>

Remove the long-standing comment in unix_release_sock() that described a
behavioral difference between Linux and BSD regarding when ECONNRESET is
sent to connected UNIX sockets upon closure.

As confirmed by testing on macOS (similar to BSD behavior), ECONNRESET
is only observed for SOCK_DGRAM sockets, not for SOCK_STREAM. Meanwhile,
Linux already returns ECONNRESET in cases where a socket is closed with
unread data or is not yet accept()ed. This means the previous comment no
longer accurately describes current behavior and is misleading.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
Changelog:

Changes since v1:
- Remove the entire outdated BSD behavior comment, per review feedback.
- Update commit message to reflect testing results and reviewer input.

 net/unix/af_unix.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 768098dec231..54177caa9c12 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -733,17 +733,6 @@ static void unix_release_sock(struct sock *sk, int embrion)
 
 	/* ---- Socket is dead now and most probably destroyed ---- */
 
-	/*
-	 * Fixme: BSD difference: In BSD all sockets connected to us get
-	 *	  ECONNRESET and we die on the spot. In Linux we behave
-	 *	  like files and pipes do and wait for the last
-	 *	  dereference.
-	 *
-	 * Can't we simply set sock->err?
-	 *
-	 *	  What the above comment does talk about? --ANK(980817)
-	 */
-
 	if (READ_ONCE(unix_tot_inflight))
 		unix_gc();		/* Garbage collect fds */
 }
-- 
2.43.0


