Return-Path: <netdev+bounces-191334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42AABAEDC
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C173B20BB
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC93D2135A3;
	Sun, 18 May 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QQXb3bgK"
X-Original-To: netdev@vger.kernel.org
Received: from sonic313-21.consmr.mail.sg3.yahoo.com (sonic313-21.consmr.mail.sg3.yahoo.com [106.10.240.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A8B211A3F
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747558683; cv=none; b=nD1wbn8Angwkgu+MuVuypVh8z2cjMjQKj8HnNJwDo6bTXULQwr9xWz/+p9PXku3i77XqO7joDu7+L2NpNJm1NDNY+4S18cRvIe/XZB4284S7/0K1489U2Gqt6KKuW4GbCDHxYni1WkBaETELxcZcU6lzNns4l1/hnynDlyqy2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747558683; c=relaxed/simple;
	bh=OENrZiGPHXag9CI5yU/qDPHApUy331WU9m8fJV5O3hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJirrp/oHXZkbmbDX0NkX0+jjTS4YQepRP+bMTdgAbKgXVTu2m+shRKTd2tkpomOhXnjzr6PjIejluaIMwnP5t5RMF1siAVvQ9LbKv5bHruCjYST6PL9kaXi9JmgsJ7+5H5UEPVYXIk9FR5e3J68+tKxW/m8odJjDFcvPVZWxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QQXb3bgK; arc=none smtp.client-ip=106.10.240.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747558673; bh=rP7YTQMRPswU0p4VhwO0vUYRcgbF4TlW/OGoRp+S8Qo=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=QQXb3bgKGsUnFcDakW76tRI50209Lyg42sol8eQIjBQBCmKpXF+tUONLqrvCRITvSGFcUnOSbyGrOhKuPW6FZqhh8UzuwyPMF9vTZZgdrq/0+G/XU+vUGZgje3xdzZ4o1yW1kkiRPilhIz+G69Lky47B5rN/qiNHR+JX9xu40Tn+hoaCiPX3/1Ccw3QD1EePH0+RkfT9QCdvmCfFS4BBQTX29lZBm6/Ieu6Sj1QIhyNHkkPDelzcxUCryWqntClqflo2rcnJ/7+wpMfRG+EYe03puG5wkvPyPdj3oFdNLPvSQxz4UJSnt9K35EomC2POgigiM0KdZBhM/w8U02FZYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747558673; bh=NeO7CG926WmhXYEBj0wPsyd16cwTjdAT8iCu++gFmVw=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=kg3iyZz7tGYrR5Y2ep37H3mYquOCPdPKOcuLir1HKIUA+bBumvsHdsS4g1zoqxsE8gy0iC3m1fOMBsDbGRZ7LKGYBA5OOiUOFEZyFqSEEIyf4o4S2BQhNlmUbhRGXY93++Nli2VQiN5BaWz1CG0qcaekVDVWgTIjgP0ianRUHOGNt5PQDnjvhkPWENu18qPYs72fkasDtMRRC4u23RtXeOqsW/tvpsHxkVfgN+Df6sXt3JhwvBQ0f8RFSHZnUpQ9CXWO/en31YfP2JVPDEFZL6zbq8HoChn/14znum8cZ8Ml2aOdB4rRkgfbsuHnVb4p3y8zXoEzYsYguHC/LsePKg==
X-YMail-OSG: CM2KRnoVM1nVYSPtQIlXQLRmUNQMyz4cvppJ11UiR1WhhhFDyCXe.xrAkArlTB6
 49ErVQsW3WObFNIFBrV3YHHxTtc_BfHs2GAcyjzjqU8nmkWDSEaoaKkkWnetCWywvrPUnASURMKm
 k3MAN_kUMQBTCp.82gi5C_8lAOH5Yz9Asl_3w5Jbg7B9tyOPExWzLjA.buj5vS_B0nmPQSd3xwq_
 uMnyESrE9neWlGXFHyjgnpISmtGuGq8F68laZlsxaMy8CJAjXtNE.S7WPqVcebC7ZyDhvPF5XRtR
 sR4140DX_VHHgLkEIAXlpxkTE2lvnfoLLETp5S3NSsOVDCDrjhLllGFdqp3.MBN9Y2AQbct9D0uI
 WHb9NmkYDV0hH1znYMTutsg0Wb6aVarHF_KCLrZpMzHqMyEoW96UTnDEC5_.c4Y1qmsC4Rc386UZ
 kwbub6GJbQLI.N0TwIZeWB9PuxpYS5PItReSdPM2FpPjdAgcAB.d7XAQLYXAFlS.VrSAetejYPZf
 A2WeGxlLUUhQpfkxmL8x1MvM3nehtH6XBxg2jKnLvQsxlW7W1uO39LOCC.TomzMMduZsd.SG1Lz1
 2P5nY9XM78gBRvl3oCmd9m88Mi2MrD2zlF6B7l0YN2GheJVvPQt0oA8o2bg4Q4ej5LyJQdNDSsfM
 DhhejBPVkxL.neQPI2htc5oeFkoQ8ZUxI56PLHTw8zMwmuM97fiXWubDk9_ffrraM5fQKq8VC4r0
 X334KnkTOGgsbQxjmjrVD63m5QCBwiCiu82Aa410U7EHHNeK0gUwdwDHeC5.1DIHOGXX1EYD4xy1
 Zkkegtnhj8pUW_inReYQAJRzFd9fIHlN3uOjpcbiPU0lkprdNdGwfInE4G8PpVzqE4og2IL4aHEf
 iQVAskyWX1ZCAMv43Vfa_W00xUJzQHaYb.6J0upKSJY0yg9tL2oSVs54WoJ5q8tm47ZBSMs.qy3g
 ajyvVLP6dQdd2cEBqy5RCkj19VB7C7SFjbWWdtM4EVjga3PT0Ll0WGPerDaUKZhX.P1j2YgDs3Bk
 eToTUgmKDPT0.64fydJQZpPE0C.kRvqrblEMD6FLAL_QgsrGhYDo2FpNzjuCZ01GekVl6pwL.aC.
 Fdp1RqG_16E2MAgYJsQWlN8zack7CZrKXwozUXss0iae9OtVJCX.6aFH1Q2QqiuZRw5lWOZJe4p6
 6ew_UbksmeRw2il57VZl4BVVflye7Tjby5SRUqAHzaviilqq1I6yWGf47e.qGuT8Xc89thhLgb3t
 A2ZUGko4dzfgcO3hcePm8CSsn9BE7DxkQ2vCNAXL1WA8aVkFNtsWJJFKf_euEcwcPhom0NzqlBeQ
 6Nd18slTR2umrWB8n1oREI5uLJ8B3ZRj82262pl0PvCpPXew02Y.9EfkHwa8auGd72DejO8eqIgc
 pH.SL2BWJZCziG2q16UzJ0LkDIdY0R_8GylL0txRyCnPHKbEJOAXpYSCTm6pQSwzmGm3CIgFXtds
 O7PYGigwLczQ2qpBSWmFw3SD0Lhb5Jlqebngh32tuKH17XN6LjEqh2Q95Kh46kQ6uQQZJnW7vSMP
 8fVdSuMqXlHUO0K_yVXOE8x36NL5k6onVUlbTrAXLqDEfjKx8aS1I3QUmPN5XIZu1gZNTTHVGZzP
 h.aadPpgBhKpxvOA9oLbIXo6IwuXnL4TekyvHnHJrJ3mn_Qys0N33Mz8BrxgcZrLF0XirnrRLF50
 fWqWtw6luFSl7WoSWhP98oMSxkuryuzsKLQbxpsAZFPODecjWwx2gB2iij3kehfCVtyeoojrLuWD
 Rx5JoMVfr71eb12dL_8T26SA5MldwkLh2dWeb7kgsXKttPIGeJzOSmEFGnqJnC.3yuzRlgQlWQpv
 SQGLRIK3U0SndgGfRhYEdF7in29Ck_p.XPFvUJT0FymzFq4tZO31sZKDm3ulvFj6jjIEp0GzsBoW
 3eybDTmNvjLQDs1RW9iRJBTCywE.lB0paq4ul8tEFLe_IhR2Dz982lT_KKPpEukVvtSCg0W5qZTr
 nvKnrhdArTfzjdNh6lWNYDK8zXkP9NDGrEL8mhS1MNFSU8vVdnShOpgZ8lpkdrqdlxuobnMRfEFL
 DGayNrkABhTF8jsvIjTWMUM7MBFraR1DhUeQHNO2yj14T5yFbdteVWP1tr8MVoSqA7OPaf0if4FT
 bHbCGaqXXC0qDzXqs5kk2n.DfPw49Es5bmNG.xQriGzRm1UM6wDwu_kIZtJnGuttP7zr7YTNRiJM
 qLWuY
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 76796a44-d442-482a-a222-3d6ac21e76d2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.sg3.yahoo.com with HTTP; Sun, 18 May 2025 08:57:53 +0000
Received: by hermes--production-gq1-74d64bb7d7-k2g2q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c07c4a4ea2b90ef9265870a2a8be7fd4;
          Sun, 18 May 2025 08:57:50 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: bongsu.jeon@samsung.com,
	krzk@kernel.org
Cc: Sumanth Gavini <sumanth.gavini@yahoo.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nfc: virtual_ncidev: Correct Samsung "Electronics" spelling in copyright headers
Date: Sun, 18 May 2025 01:57:28 -0700
Message-ID: <20250518085734.88890-3-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
References: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the misspelling in Virtual NCI device simulation driver.

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>
---
 drivers/nfc/virtual_ncidev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/virtual_ncidev.c b/drivers/nfc/virtual_ncidev.c
index 6b89d596ba9a..9ef8ef2d4363 100644
--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -2,7 +2,7 @@
 /*
  * Virtual NCI device simulation driver
  *
- * Copyright (C) 2020 Samsung Electrnoics
+ * Copyright (C) 2020 Samsung Electronics
  * Bongsu Jeon <bongsu.jeon@samsung.com>
  */
 
-- 
2.43.0


