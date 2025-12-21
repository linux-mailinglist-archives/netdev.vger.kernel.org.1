Return-Path: <netdev+bounces-245647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CA7CD437C
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD403006A9D
	for <lists+netdev@lfdr.de>; Sun, 21 Dec 2025 17:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3689283FE3;
	Sun, 21 Dec 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bRLCm1Oy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8008C2FF147
	for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766339394; cv=none; b=HTPj6kJTjRnDcIGHkrE8ZRVxYWFVMHgcjAwRF35FNxmcxAHGRKLxqXqPrb0FfBvGSl8mIRXja7VzmHdnJi+DXk/YUzYDEYyfG6s5hCvrP3h9thgMavxnVdxhlG8CmPU4bw0pgMDP98YpcdUddr6mXrci5unZMbAllkoYl8MWh9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766339394; c=relaxed/simple;
	bh=fk2pEYDrRaibSF8Fp4jhW9Nqqawahtk/5CmDc78Ib6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FRbilUvHrd8JMhzmjPiZK6yo5hDelsF9YV4sh/N5FuL65Tpea9nfGNLOHdpyd0iVpAfln7fpujJe6zmAtlVgJ3cIfpmpGmrH5NTOEc2LCcqdtr6XYksSZapm+Y7GCtRHWSccgDxmb+sBt+QukfuuuZPt4ICiNi4kSi5bYoWiIKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bRLCm1Oy; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2486085f8f.1
        for <netdev@vger.kernel.org>; Sun, 21 Dec 2025 09:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766339391; x=1766944191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lu1MTTPGFaX2niuw1oWMpIJBCK10vZmjUILBJklfoc=;
        b=bRLCm1OyPm9RUaeUNrrvaBtH3lcVdKh/DZFNACKxzSek/YjCPXZK6mxWqnJQtMvDcs
         Q/oUS95hrtOFqUlCTA13AAT402FHF1YaGBhzQoo0RWzz+jvr60FoqR9brf5D33xK19vI
         rGznvdD6aAvWFbNt7mWTpSZmEOXvnZs2ePEl38pXbNDYI6qODr21MWar0lZIF9pMfmz/
         v0OlZHNIOJ1p+BWf9BBZQ2qeX+QZlNGwtv8vkrbuml9j/KU+70fsnWqG3uA73tl8xbVM
         bIXmfDdVeEi89nhcMOV1FEwdMY4NATqF/jhO7rEkYbPqNAG3Ob0kmAQn1IC2vEt7SZjz
         rQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766339391; x=1766944191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lu1MTTPGFaX2niuw1oWMpIJBCK10vZmjUILBJklfoc=;
        b=RDrrk+hYg8cU6eHM+tkihS5yfTvEmGrytDtPe1d7zEPHVGc71AeOpiMmRBHKy+VUsD
         ah6nTbSw09b0BAgtzT38/PuGsACVGyV4IQ6axrAqgf6Fc+Gm6ZJ8zQd3jy8FmWRbYNjZ
         3O45ICZYKVMv3dF2QCyH1qQPkmfgJ8Pz5gUf7Qt0oo/44Z0h9qIzRx8CMadrpBVsQlnf
         E/WYjzRsE4YWI8MK7j/W/QGX5S9S5Uq76RhS7lgaSYyxKhMxhDirLSUcvCypyq1o2Q0g
         lThe0y+VAJ6+nTjcBfW6gou9ucZdBiHO0bxjbfwOHIdjjzaWNA2jzEfGfALIbBcBP+pJ
         zHBw==
X-Gm-Message-State: AOJu0YzzCS1WJ78mHCTN5VGkSD1t9So7XRGlRmereJ+6rxlNzOmgtLrO
	iIkoBtU85+RnrBwjiKShK0AQf2UqvoMcNNIMeE4OLgT5rhqi4vrab+pPywpZC+mXXLmQrRQa9fi
	+RLnDenM=
X-Gm-Gg: AY/fxX7DoWJ8HJyEMhtVKNzQ4EUx/q1bSxHuorbJaZf/FVodwHWY6dFawg27jCZEdow
	ryuBUJSMJrwbn+KkeRt5SqS3/RR2JyICuRo9R6B+V1xoE8ByGnPWeYZvMcRqEHq6qwkzcxE3lpD
	qMs+ORbuoo6ug6WchgZwaxv/b4LUzVkozga9U1S1r5WT7aTOETHH5xdicNoxNZ/FxITF12UpsCU
	wg+F5hfRlnBarcmA7iwK8o/TZelJlJ8pecocpzw1izaS3SLiP7hni5eVUbe1MG6gT9j6SIbdbTG
	NHBjuGjbm/3kWgk5wSo33szvO1UZ44qWzIdHA6glEN+s1evBqbJLKpVYmSbq7WDAnreQdvNKK8D
	Dpf3XTUvU49GBIzHJD4hv25GLLcPYJ4XKtNdacFy7FJdAN49s+nlkXMzqbCItXx94YDO31mxTMt
	O/fvUn/JwDIGZHhvKF2Rca3lrbiEhkVMzL7TwYdiz/sJd2T4yxTA==
X-Google-Smtp-Source: AGHT+IHXEPynciFqgyviCesGmATX10R0hL/t/zXX7BXoZcW+0pT514Xo94osC39CATzUrf9uKPwrtA==
X-Received: by 2002:a5d:5887:0:b0:42b:38b1:e32e with SMTP id ffacd0b85a97d-4324e50d611mr9715335f8f.46.1766339390658;
        Sun, 21 Dec 2025 09:49:50 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm17491358f8f.35.2025.12.21.09.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 09:49:50 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] utils: do not be restrictive about alternate network device names
Date: Sun, 21 Dec 2025 09:49:45 -0800
Message-ID: <20251221174945.8346-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel does not impose restrictions on alternate interface
names; therefore ip commands should not either.

This allows colon, slash, even .. as alternate names.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/utils.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 0719281a..13e8c098 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -847,10 +847,15 @@ int nodev(const char *dev)
 	return -1;
 }
 
-static int __check_ifname(const char *name)
+/* These checks mimic kernel checks in dev_valid_name */
+int check_ifname(const char *name)
 {
-	if (*name == '\0')
+	if (*name == '\0' || strnlen(name, IFNAMSIZ) == IFNAMSIZ)
+		return -1;
+
+	if (!strcmp(name, ".") || !strcmp(name, ".."))
 		return -1;
+
 	while (*name) {
 		if (*name == '/' || isspace(*name))
 			return -1;
@@ -859,17 +864,13 @@ static int __check_ifname(const char *name)
 	return 0;
 }
 
-int check_ifname(const char *name)
+/* Many less restrictions on altername names */
+int check_altifname(const char *name)
 {
-	/* These checks mimic kernel checks in dev_valid_name */
-	if (strlen(name) >= IFNAMSIZ)
+	if (*name == '\0' || strnlen(name, ALTIFNAMSIZ) == ALTIFNAMSIZ)
 		return -1;
-	return __check_ifname(name);
-}
 
-int check_altifname(const char *name)
-{
-	return __check_ifname(name);
+	return 0;
 }
 
 /* buf is assumed to be IFNAMSIZ */
-- 
2.51.0


