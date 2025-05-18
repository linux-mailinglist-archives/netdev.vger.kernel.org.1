Return-Path: <netdev+bounces-191341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D17CABB046
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 15:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4171896B76
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0747D3FC7;
	Sun, 18 May 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HF8KPGvu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC21373
	for <netdev@vger.kernel.org>; Sun, 18 May 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747573291; cv=none; b=j76BZHKZEA/BfTrIxfKdi0E0Naf3uGxH9sZxaya+sD4qp7b/HFG/NBeKeOi6l+JWaYGdKABKqRsJmD0Qg6mBMzcavjAiKhmC5o5DE2ulgLCkzenWT3hlABt1BDp/dL4XwqJjiDHstJJ5Oyo6goNTbjbQYg72HIk44SzQ7QF6yxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747573291; c=relaxed/simple;
	bh=Ho8ZPEiEaP2uQiGzy7VSCJQ+iWr/uCqHlNV4R43olRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QJzluGFhph1NAffAjG0B88oIiTV2eLh6c+ieuVOH3K83q81QEfQ5aQivDxsP/F0GXs2GCLtz9DlJ/7G9sN+2F9VOH314sS4svLWCerPPYCjtKCN7qzCB1EIGBIJX4BTcmDyVk1d4+lT/im/KQ+Xwb/IgGUCiSdKGstNNB68F8J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HF8KPGvu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-551f00720cfso263957e87.0
        for <netdev@vger.kernel.org>; Sun, 18 May 2025 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747573288; x=1748178088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLFsBsfNmOU6zCrPl9XdQAYXUP8IWq13yeciPdyTxPU=;
        b=HF8KPGvuIHrWrrPK0+FOafQfwgOtBpElNwAuciVM5PQJ7684dqY7cqKPlM9QH92J16
         8pjYd4LBxBXCTAuXYHslxpLFT5vKcMh/43RWYXbb7sr4HTf+PMS9iyMFMD5/kevIGpCR
         l8xv5rx8rEHcG2G1D/aYBaJ3rb7Vs119mRbYTu9r2Se9o1hZpBu13Bp2Ar1EjlRu0M3/
         /mh3X2dtn7djp1owdGtdncdiDuc5kdOBaABTY9i/Vw0tMLzv9fSst+pRLDxSCe+qAWQG
         qWyB4TVyhJSxrNI9cWjeOUurbKvhH1mNvb0pKLnF7n2Ai77Yy0Jh4Zkk7ASscxZVyKtV
         Ii8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747573288; x=1748178088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLFsBsfNmOU6zCrPl9XdQAYXUP8IWq13yeciPdyTxPU=;
        b=dxOTjryikEJHrMIqQMiyp9q7APPqYG8OdMJQlT75krYdwJwb4XAowxT0GhiTSlm0yN
         nm33oJ/g16e1FHwAErmWT3iH0DUvvlnB2EBL81GSZrZ0Gs0PA6f6obS3Ekk1a3JJrB6B
         hu21d0OIYLFapGxSbiSqh00y03mdnYuoirrGWNP6VASIks06rJaRSwEsIi9iFDMqKcPN
         V/KegcpM3+PvWWtTo0n6bNflcZMuWWI5Zc9TGl6oQ5vglAHHPTDbUPkFf/Ouj8Fgz9SE
         HnN9lBAoAT9IxSAXVClUg0RMpaDZAznyetjG/7TxZdzGnWnRItyU86XTSTTGromTjKPi
         C2RA==
X-Gm-Message-State: AOJu0YwX35p7QCNgEDNoBkwgtLS7BY2lM/lsczXnP4+gbIELwmcz8ELu
	Lve9bzbE33shzaThdfZNh45WCb+moWGU954XLxL02aLaIWRomHb3MRvB
X-Gm-Gg: ASbGncvrq3x9F9TVFUFW9xeqCyQlmDlRDZogUf9xzWq9DJ+W3xzJXQF3N6P39b9mehJ
	RIW4ga9t1q85k40ZGChsa7aHUO9HkZ+w4PfZyk1YxgRh6H/V7Rn0gs2mjnG5pk19rmHGo3dqAO6
	QSzflZ6XO8Y/wxsCZyeDswM0Qode1W2CgbqfdiGJsLb/vgkhW2AkNB/5nvai0uPvcpzSMnt5O/P
	Tuv/lN3r/ANHhKWSgJ02rm/PTnhAW/hT8yhEqIM6apTw+hJDRMPIW/NJ5HFFe1RU5zoZ3XT++En
	JJqdoUn3sauVBCHaBZZ4G7Obg7dN9qYaVQqHybCU4U9IKKSwtUdIxMDCJu4xa7TWadn4taNkpT6
	BgEJcxa/a919rBK7SpLPJjPUnb1hz
X-Google-Smtp-Source: AGHT+IE1TwOS9Jk1FFjJ/rJ2KPitQgY53FnxYOzmgfgzqdCOnelctqQL2INYkoOo1QsYarV2/eml4A==
X-Received: by 2002:a05:6512:2614:b0:550:df52:310a with SMTP id 2adb3069b0e04-550e7195360mr2504311e87.5.1747573287862;
        Sun, 18 May 2025 06:01:27 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e703c2f3sm1395870e87.214.2025.05.18.06.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 06:01:26 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	AntonMoryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH ethtool V2] json_print: add NULL check before jsonw_string_field() in print_string()
Date: Sun, 18 May 2025 16:01:11 +0300
Message-Id: <20250518130110.965797-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AntonMoryakov <ant.v.moryakov@gmail.com>

Static analyzer (Svace) reported a potential null pointer dereference
in print_string(). Specifically, when both 'key' and 'value' are NULL,
the function falls through to jsonw_string_field(_jw, key, value),
which dereferences both pointers.

Although comments suggest this case is unlikely, it is safer to
explicitly guard against it. This patch adds a check to ensure
both key and value are non-NULL before passing to jsonw_string_field().

This resolves:
DEREF_AFTER_NULL: json_print.c:142

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 json_print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/json_print.c b/json_print.c
index 4f62767..76e654b 100644
--- a/json_print.c
+++ b/json_print.c
@@ -138,13 +138,15 @@ void print_string(enum output_type type,
 			jsonw_name(_jw, key);
 		else if (!key && value)
 			jsonw_string(_jw, value);
-		else
+		else if (key && value)
 			jsonw_string_field(_jw, key, value);
 	} else if (_IS_FP_CONTEXT(type)) {
-		fprintf(stdout, fmt, value);
+		if (value)
+			fprintf(stdout, fmt, value);
 	}
 }
 
+
 /*
  * value's type is bool. When using this function in FP context you can't pass
  * a value to it, you will need to use "is_json_context()" to have different
-- 
2.34.1


