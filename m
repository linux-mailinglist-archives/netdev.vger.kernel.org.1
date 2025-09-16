Return-Path: <netdev+bounces-223574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB245B59A2C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B801188B8A3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F34320A38;
	Tue, 16 Sep 2025 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUqWIZAZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A2D30F528
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032812; cv=none; b=PbBSXR4d4XmhKpi87vDJsDWc+EMYWw1CxsrJK34iB56h3/8wh7pPMSztTzQqFtlo8Zf4VCk55Hfo/WHaN+2VrZ4G+PRADdT1MvhDO7qA9q/lIGfldGR4Eb5Ld0qNDs6OV/VszarKghCGofLA3QwEsSIW3YSggied0rVvgXHep/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032812; c=relaxed/simple;
	bh=my+Q7dEHUc5ialRgpreKXsB/majGXMlrcKZ5miiUyW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPAcLKkac5IE8pzsZsVsReueYfjVptGfgRysFlPSPRG43MO21GVn7uVyF0RRF29gzwUl9+bI39JS8hBAOgWobsOeR5X8grAn9Oxp8SNwbplNRoDBEcoPMOkf86U91LLDbCLYDUo541f79JBVyulZeXY0CiuXLt0l00ygvHCOt+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUqWIZAZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ebf23c0d27so1027583f8f.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032808; x=1758637608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Zf4U+FX0WVldyBueXghFqY5DGCqMSEWSoM3TnvY6N8=;
        b=LUqWIZAZ2oahas/7T+/3rjHDRUhKy7SAiuFdy5/+s5XGAIEhHtu0kNF7QFIDiQXW5Z
         4DpEWR23yDY/Ted4jOEswFM8NlQ8KcIHiDboO2gZBFCCiTq07/xLju35V98urQ/r9NKc
         Mrffh4L7Ee6w3DUAWWDwrWkpqFRMwHKzTSKFJY27WgkOSw9OT1suV7U0WVls42ZKwAW5
         O10uy4MM4SjcNVmSyxZhCMRo9uTsG3+3zDxeWPOaUwkcTY71mEwEwgEkkwSc7wHNBGZS
         bmXAsoLjsVPxt6hPVW70Gu7rYxy/3a0rd65MIEoRVPwwd7pKsjiqqUStJ/cXJPT3jPLd
         EfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032808; x=1758637608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Zf4U+FX0WVldyBueXghFqY5DGCqMSEWSoM3TnvY6N8=;
        b=MBA5qTGTNP7y3UhIfWqQJnf9JYT9N4VYDnAsMq+xIfadbjoRtNVOVBXOHf6DRugF6/
         QqRjRYtcktau1XuufOBm5WFna1uTjv8TcwE/Xu16BQAqKc/5BrS6ZAp2Y1aRkemCLtlM
         2URJZuipDP24JPWRsOPWO1cioS1IxXEu5WI4MHqMt7/JMSEey73i8dPE9aHm39k91Ezl
         XIIEm/gINMK+krnwaPSDDjBRVvwBu2e7e9g64t6ERC9uhYKUig4aSX+Tfxb9uYF/TYmB
         5NSjifihuMQRlhKSrFin/JjoK6LoF55SVwKAzWXN/D9RuTPh+as7FbqLrSR7iFnShPZ/
         6fEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+mDxTxwnLhecN+InplWutX6ua/Posmpf40OEBXvhPb8DRH/I/xT5hT4gTAk+sLWbXTkTjI2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/orpjafoZDFqytbrEK90K+5xgvCmn569I+LViWmKPSipo5nzz
	y2OvsZFf7k8ewKAgC6Cj7LTA26OX9wnvK/Vx2wv2MJI3JXMZJIcAz7Cz
X-Gm-Gg: ASbGncvAAMIj2Mshn00CvH9Df7b9IyVrojqjoj9sCdWWPBmmACYaZbBdrnUrVynGoca
	FjYq/rbvPCy1RGwgL0XlgoakhrBjecsBdHr71ovW5NYznScxRPe4SoxAYwqghgidx7XuJjOi4I9
	EmtkyVKx7F/UKrqQ5FfNg1ExILOP+kef4bSnzU31uZ9ufPywoBu6dXApbBr7MWN/Dn0NpkSzbve
	TuJipCdMNIWg7q2i7dcxxaOIRf+AGVH0OYW0Kyuaq1+IoHE8FNTg+IBuKyGPx4sb3zMSeAdftLN
	jCdLBoAl63mmSDcrvyIXnoGmxBr/QPR1d2gK6W59+d0x7ONkl+q6F+0N9g/SD+x01BwGaUGgSRR
	5KcvA2w==
X-Google-Smtp-Source: AGHT+IHgly2HboHXGWES/kkqSLsldYjPeQisFh0CvTWXK/3eqU5RbsMXaeIVzAtDFLxNkeUOlpWHFQ==
X-Received: by 2002:a05:6000:2289:b0:3e5:47a9:1c7a with SMTP id ffacd0b85a97d-3e765a157b7mr15407646f8f.62.1758032808298;
        Tue, 16 Sep 2025 07:26:48 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:8149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm327971f8f.46.2025.09.16.07.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:47 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org
Subject: [PATCH io_uring for-6.18 02/20] io_uring/zcrx: replace memchar_inv with is_zero
Date: Tue, 16 Sep 2025 15:27:45 +0100
Message-ID: <1464bccfdbd45ff98c875c7086bbc67e14386ae7.1758030357.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758030357.git.asml.silence@gmail.com>
References: <cover.1758030357.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memchr_inv() is more ambiguous than mem_is_zero(), so use the latter
for zero checks.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index c02045e4c1b6..a4a0560e8269 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -566,7 +566,7 @@ int io_register_zcrx_ifq(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	if (copy_from_user(&rd, u64_to_user_ptr(reg.region_ptr), sizeof(rd)))
 		return -EFAULT;
-	if (memchr_inv(&reg.__resv, 0, sizeof(reg.__resv)) ||
+	if (!mem_is_zero(&reg.__resv, sizeof(reg.__resv)) ||
 	    reg.__resv2 || reg.zcrx_id)
 		return -EINVAL;
 	if (reg.if_rxq == -1 || !reg.rq_entries || reg.flags)
-- 
2.49.0


