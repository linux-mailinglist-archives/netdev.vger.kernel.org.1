Return-Path: <netdev+bounces-191676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63607ABCB26
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CBB74A5DC9
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F163B21D595;
	Mon, 19 May 2025 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Vv4Utfph"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-21.consmr.mail.sg3.yahoo.com (sonic301-21.consmr.mail.sg3.yahoo.com [106.10.242.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B621D599
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.242.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695134; cv=none; b=k9GUYaMDQ4nN8BxLHmfDR/KTKRsOaXHJQEGMYoVei9GUBvO9DiWAtPkKceCCwiEsw6PAB56kBmkr5KJZ/7YkCjukR8LkrS+swvmvPF95dllBpHMqykICDRr96mwxTlVJDwItSAguAjjqbSuoxXZsyIqi95lDXG1PTFqztsg+7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695134; c=relaxed/simple;
	bh=J5OAmadI3Puem8biWtWtI0iUk3W6kyLgtJaNGstnCGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMVoy5lWqCLnVcAnc3rduq0oJFKBES9h0GllHYVShGyCxb8gbBot6gKGjL1OluLxHmz93DquwKSFrB4T31Zb0fHGDR/14FYSyrOmGVDs6uMFSnKrUZRbmD4XgqR7trvDIZhJVmOJ4S52vsL067j1m/F268B+wbTp+QjQTIXhmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Vv4Utfph; arc=none smtp.client-ip=106.10.242.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747695131; bh=GUM+9m8KJK4142bT4Ko5kH+9yddCEjxAngcqskahTgM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Vv4Utfphp7wlpIJf7RVP1enlSDmkfrVigb4Am1erBxiVDY1j8vSO7RvdCmJFV5xbGvm9DI4mM6n2LJaMO26HCNu62BcI2f0S+uH8NhQiLlHVObV37I9PKH1q92e+f+N+JxMhD37nDiieGUzDNTpE/12o0VjdIlBGMyjo0I7eCX8YfaDFpWTGId4jobHQHxWkj4qfivJIVuX3Vo7Tf5LdKzJDaAUK6dUn/+jPFktWHzBdKUFz8ecRKxB2jHvpI43hbbOEFrIXiRF8IG8qc+j4zPsM/jdK6VpWbFbBxRcCuCTEFLDkm4bBNXPl+kZQnnx40mx+xXSkiyEnMDtdpGWz6g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747695131; bh=LdSU0kU4+1sWAli7lfyX6gYCxh0WZ3C0pQ+Wpd7mUiv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=nmplJzCNsThmfI442TL+5Ti550iiUv95GP+ZZ0fwr6iJUxHxPIN564rf8XpfltC8n4avP0IVcy4IS9Q3+cWharQ503LC8XqduTd3ov92u75NMmIdxu4LQOm+EKBN8otR8qRFiBSk/FECr6spKgyJ2G0b0AdbLIro9AdTwt+/p7pdDTn4pe4i4ZECpThF3+lCA+PWVgnvYHnExd3ek2uko72xp980oIGTDS849rrHEsrn8aQXk7nIis1axcbBJ/5RrkbKWUUMFuKykTS+tIz/TdyFdA28R/fk9tNiZdj+tyEveGo37aOrZNSJ/pCqkNzH69CEuVfginyEYwbf4QqCYg==
X-YMail-OSG: 5_YSdPQVM1ls.U2TJndsfHLidJ8M6L.6O_WB0nPOiihccZbjZUvbEWQasTjil0i
 X2IiYgazFtZ8_5D.O2vbyeJsYQMjpzlev3bOGjHHi2RKnk2NYMkhfvCx1TTZIhjv.29RGhh51qIG
 GybwopfzbyBatTth8SbppD4pFAAUW4qrczuTtxQvBOV7fiREUGeRYVA5iZhUiKy3Ajfs5OaM53kc
 EbvF1dt8vqnHgHSltntZrQUuHRjGG7iElKfsL2dc0.ZkRAhZXl4XAqRJdCaR.hItuuYEx4QTSQiU
 x5vVoi6idXuWudh8c3PQsUcXBdezGrWEL5u6YUpnrVjhMhNQG_cMLou8vvsei6oDKaQBoxnmIp65
 cPhonLKDUWrP.cAsGl5ca6jY6x72NlKs5glYFb39VPK9IceQVbjUX7mqTjybBXe1kNYpi1_WHBjz
 FEUypli.9rjUHiig6.SnCn8v06EIpxU9sTNUByWfdbv8QCkJRtKhe68PZFfutbqNBnvlWRMZP1XQ
 YpA0cDerS6QXe7NeH5OL1hHwL0r_aEMxrKBU1bJk3v7sHfxFHkAQwDhOar6SvQ3fYytDLzDFU7eF
 SwtCrgWIDiKKqHNm1aciW9pNc0SPSujfJmO7K0w6GuAxlm3LQBMpl.xHIJWwJ.jueu4AnHQd0zDD
 UM9DK6X3gbLF6Sl8H5_zYuGPNO8rM.cxLlhjyw3Yf6Y7iOCMcWPgyje.nEocC8KLPnt_LUVYow4q
 j76mPIu098KVX7j8TfMoE2CV1T62HQHUmQNjwRDBFzHMUAyBR3dCTKEUreHbm3aiNmZuPfi5EfTz
 EyYAGPIyUqz9IvNk4Lau3GOBcxqscoVU9ObfBU3EUOML0wqFQo3GR0h05T3H.WEWHmtEqF2q_auR
 vSlitFODBaa3CSBB5HMyIQ_KzUZPR8JMNn0DMICF6kGxbpxajzHBVbN1t67Nk.Y26PV9v4QW.dQb
 6Er2absmcA.dHN8IykJMAiit9WverRC5Oz7J5iL2JjHpaZPlVv5YWfZeJS9isGC9jayUK54FkJ69
 6vlGrIdKL.K9I0cZJlgimXihAc8D64pdVR.1yyHE8GFf95H8Vpoqnpk33036p_qMAkxs1VvV9DgO
 rouZTx8rKIrHBQFpypnfyLyqUz0QuJMsSOeYxxbjf8UNfz.pcUIKHm_i2Z7eenQO1ecKtZP0ckCL
 cAZT4wPqEqcUz1a632ItaEXPafSB.2szyIVOTicAp_qk2yo3FO6bTizNH98DfdXZLw9hG_koMPwd
 NMasJwmT1G6TFkwZ1wPZlBcfzoSnmnQaKTd1gSvL_0ZrysKJt4i.fA9lCZ6tuYcjrTnZTsLhVcDK
 jDdyZm8lz2G5tEzzK2SQKGqLyDWm5HOQAI1m3AbgSy28J3LuU7ytMnO6fgyo2SW3K2d_qi4IHJ.1
 zijvp3idXTGVD2B7NHBfQFGs3xTpUc7OgPluvJoKS8OrJHoMy_UEZXp6oMfVaGCm0JDB.he2hcyk
 uKytkoj3nZgbQIHotSk4rxxzlfRW1y7ZReqRvc7Yph2FJudwLRa7JkYVwKYiy9vDCubxDYHDndtd
 zahJ0TLVbuVo3gkQXdgYccepebrcoCzXzCaytanZhsMY41uwIElf8GGdnz8pwu_7I8RyHZhpi3Kk
 0QscTHUymoRkVpTuZN_ijCqLy0j2ZtTjTCXVXYqDPY_RiBOQzDTjNSFXLSgUr8zyh8U1SP2P8.ER
 VmxkYosxlIvewYtQbOkfiSBtYJiskFqKgah9M1Vhji.XIOloilxMNbAkEPGEFNWqMEQQa7OkBabw
 beBD8LYbWxi3.g9d0CkxIiK.UU5_lxwhAsNmlFLvD48a7VbnNraGI3ieSOeDmeAmRzRK2yEZ3hrI
 WB7sLMmpzg0tBi_pSTeHgfkrqT8cT_sZR9tFkzIDDUPCeXGCFd14_Ibie3xEysQJ.GlOGqzp.dSH
 fPvb3IfHkI8PhlH6gd_BJR3AlQFHM58duUiMaPm5cEyheFw2zE7ZiC68ufLF_tG3UqDAzofM75t4
 SzikPO0gnaBkeqeL4TriCK5TIGI.GO9EkZ499oAkRJuYH87_fShagPI4_cqRiSvKoTrwL9ijmKz.
 aG.xlyzH_l_xFMqFpGRIm3EGWczZi1KTv4w.tOSJ52G5p_qaqz4nXJTzBE0XmpYd85Yp9zHqz.16
 XAtZZF4uxfuKUmTO40zytWDd8GoXMHj65RGvIji6oCgGAzXgYphu.IoITTf12hYtBFueuszXMs2e
 TiQrDgx3eaCXNP48NMt6pgodQTzl_siHJ0rUsnXMAmi._8T.CTTq0p9WrxMhbsPL1v1hokuWoBbl
 XrNNzkKF9AMN0xURD5xynbcQy03TIUvpgwLhNjSuk
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 03567a3a-d1be-4cd8-a636-a975c256679e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Mon, 19 May 2025 22:52:11 +0000
Received: by hermes--production-gq1-74d64bb7d7-f4j4n (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9fa29900ff27461313074795fc57d895;
          Mon, 19 May 2025 22:52:06 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: broonie@kernel.org
Cc: bongsu.jeon@samsung.com,
	cw00.choi@samsung.com,
	krzk@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	myungjoo.ham@samsung.com,
	netdev@vger.kernel.org,
	sumanth.gavini@yahoo.com
Subject: WITHDRAWN - [PATCH 0/6] fix: Correct Samsung 'Electronics' spelling in copyright headers
Date: Mon, 19 May 2025 15:52:04 -0700
Message-ID: <20250519225204.147578-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3aa30119-60e5-4dcb-b13a-1753966ca775@sirena.org.uk>
References: <3aa30119-60e5-4dcb-b13a-1753966ca775@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the comment from the reviewer, This series will be replaced by individual subsystem patches. 
Link: https://lore.kernel.org/lkml/3aa30119-60e5-4dcb-b13a-1753966ca775@sirena.org.uk/#t

Regards,
Sumanth

