Return-Path: <netdev+bounces-239393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5845C67D69
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C34A54EFAB0
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039DB2FABEE;
	Tue, 18 Nov 2025 07:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzyK5ogh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785452F9DAD
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449628; cv=none; b=ZfDCQgSmD0UII9moeop6v3OQHC07b0V1k7ZFgVBjlqiJNNc0ehsanOPbXViFLXAN3mn4qwGd7jQeWPoO4Z1py6a6LjJhYl1KYVfxl06wg1SKkqi3IQsOqbMQX/cj4OW5uF0zDYzdEkKhzBxacPxf8xPadaQYXTmZxEmPFg62NmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449628; c=relaxed/simple;
	bh=6MY5RszjN79jITllGzV3tPixdoGd66YhqGBbeAdrlkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=td+5qZ41YOHM89Rvhqw7n19lR/Z+4+OhTiqLzc2JLZsPDSeuPWOCSxhc57irN9ojEWwPalJK3Jggfngrb61tKlYkX7Hf1SDTou04GwWq/rTgJTXQ+MxtLjh1kc+VVjUgryzi6KzqbvWLNkTfaSHixL0ZZAJEg5wC54PNF7qGgYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzyK5ogh; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340a5c58bf1so3693755a91.2
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763449627; x=1764054427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDNsUPlP3wC5vEK480EogEefxtuqHFjjo9dpXikS25E=;
        b=BzyK5oghUbYvY6Ox0CKd2lnNr5GwfAVEv/88C60v3XWdP6D5fGOsYOwQYeev2vCSat
         F32ygKkCuFT0vdrqs35pR6Mqj8IS9b5CDeFs1UYnJEDtbvoVMl79S8C0Kd1XvgrUvaWd
         D18tWXSQti4P6cf/RI+TUBqPHftsgESy6vh3W+/R85bqlwC/dlwbDB/UxoU6F7TpJDZq
         G6S1t8K5Yq3FGboSakzYZsf4Z6V2EBnZ61Ag+v3aax3XwQcHw3usVzt0l6AVuXeXsrR3
         sUwGOPt1532XEwIDYN8ZwItwlFTSnz2hC/CI4vddzTf6Oh+Nl70im24mHBgbMqMAV3RM
         VeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449627; x=1764054427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDNsUPlP3wC5vEK480EogEefxtuqHFjjo9dpXikS25E=;
        b=Am4CDnS1bJvOaH13zmyTkkmNYqHNlZ85qnMm3a/qRKoGt+Azi5URtG3OYj0oSoM15H
         BSwd5yPjFhF7qdTMI7usP0XsxD6BG/Fi9NRdrYfiioTtzqEnpsRcVmjfpEF9QFPbcOWY
         kB3Q7ThNVQucNuzvIlv5V0uyT5YiSbr15A+af9R8lOtQ7N1aPCxqmfLkj/qSZ2z8OeM2
         FVtv9Qe+rx5UjucRxJZVVUaYlE5r14ZTPPcysxaNOsnFBdlB2VyLaoQ+99DqwV8wVcfC
         CIuKHEyaaOsk2oZKEWzipbaBPLoGlQM010uROeT99pf4Na4xRvJJrT9eZmCJ1H5wQKcf
         nImg==
X-Gm-Message-State: AOJu0YyJVGJz4abCVeqQkdFmlvumZgO6mkw1zItt5Tz8qyzFR+bfuBj0
	nAjuVYtK8NkJ/LJkpB5szgruIcMpF/i36EAp6gGHk3P3HX15uGLjMB1TsD9W4Nje
X-Gm-Gg: ASbGnct2jZOdfKbeOF1A05fDVV7EUr2IUuIUzWaFbR39EAntXbQdl4e+DuJkQdPRVmM
	RRQTGUyHCDePnNuVivWRHDl9OkJtiTE0KXTjDUmM/FnbaQJG0S4/YyaZVYU+iRhfpbXPbP7hsoC
	VlWbLUsxxvTGsYjB4bBtunh79i/rMCwyO/IgadaQqg+kHDrVD5frtCxlJlhdUMSwHFsbx735N6h
	ELE3XPjpgcy1dAdWVP0SNUVLdUA3jJrnQ3mkQ5zDC5CJgoB5skLI1y3BhWr857ULTDUpEgp8re4
	/bSy6/MzVZo54N+N9S72MUyBCo8iReVNOFTuaRW0IRw8obT3GkoHbFT3iIn31+KbP+GSRlYZ5Lv
	/CZE352ZHQCMuh9K9+YAQJrTBicAImUNlEcr0I/q6Jce/8arhkva4W3ih/m/S4XrEsx2T3v34pC
	+n2UQfrIxScHEJMvXme5ll9qS4fWcngbU5qgDXifo9OcZWaJU=
X-Google-Smtp-Source: AGHT+IHbnc3xo77IPrBTlmh9XlaSx7FK3/shQp3vMCdGFExNgzOSbDBmZah+s/QCAltNrrUwp9v3DQ==
X-Received: by 2002:a17:90b:51c4:b0:32e:9da9:3e60 with SMTP id 98e67ed59e1d1-343fa74fd8cmr16071858a91.36.1763449626710;
        Mon, 17 Nov 2025 23:07:06 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345651183b2sm11868494a91.2.2025.11.17.23.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:07:06 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/4] net: increase default NAPI_SKB_CACHE_BULK to 32
Date: Tue, 18 Nov 2025 15:06:44 +0800
Message-Id: <20251118070646.61344-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251118070646.61344-1-kerneljasonxing@gmail.com>
References: <20251118070646.61344-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The previous value 16 is a bit conservative, so adjust it along with
NAPI_SKB_CACHE_SIZE, which can minimize triggering memory allocation
in napi_skb_cache_get*().

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e4abf0e56776..b6fe7ab85c4a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -224,7 +224,7 @@ static void skb_under_panic(struct sk_buff *skb, unsigned int sz, void *addr)
 }
 
 #define NAPI_SKB_CACHE_SIZE	128
-#define NAPI_SKB_CACHE_BULK	16
+#define NAPI_SKB_CACHE_BULK	32
 #define NAPI_SKB_CACHE_HALF	(NAPI_SKB_CACHE_SIZE / 2)
 
 struct napi_alloc_cache {
-- 
2.41.3


