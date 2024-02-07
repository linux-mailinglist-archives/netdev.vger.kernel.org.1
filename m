Return-Path: <netdev+bounces-69999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C384D363
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A16284A4B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84447127B53;
	Wed,  7 Feb 2024 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK+c5liW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340784A30
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339664; cv=none; b=h79WLTZkVKox42eNNTPkznBk6a+sAPnIGtiA+29RIc2/6z5v2PD4mH3U1jlekOqP43JbGXEld7uwQ8QyJOdBjrwcih6XKdBc++2LiXSX5U/UnElr3SIdEeDJdgtokd2NoZuqwTRL9cksSGTucevDxPmt2A7Bq0nZQ5061vvo+Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339664; c=relaxed/simple;
	bh=GUEAS/KSa+L/32rBCmRQ5wVdn8XKv/WUapg3H7JBTDg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o9ZQZrMpkBTVneCGCmC8bggpfenzGiDz/1iFjoUtjMqoCmnuPv6v8qoPREBez8S/ZQb2OOtZd8A3dTOpy2wP+LaJafoO2uc+ifpRds9Z0EgAXZl+xO8hcA/ZjpEg80S+58jB7W9UGQyhNY1SURnIFrstz6/8+jn1/t1eFlskdmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK+c5liW; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-511570b2f49so210066e87.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707339661; x=1707944461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ogkN6LEaTSz/BYO4QwmYZ0SQAykq4f6RwEWzKx8qQ4=;
        b=jK+c5liWeR3LwuDO/AKk9uTgukweYsKE8THnhgTNJ1B33Qy8dHvItYVvqLRaGYbu37
         PLa1+Ri333yhqpMjbHMcYPiRo9l2dS2s6JAp2q5gvamgw1oaa67SNmgQzei1SFGBw2gi
         bGPLqdBSAw0nGnkTdsMGa8Hkvg9EnN05KYwv+Wa2eB6f+3UHjZKuV4bAQOU5XC2y2uHV
         pWqfD/AVQRRfnk6rrnEsqfF/TQOSzY97aVdSUqi16/OhEmKKKg2Ov2PmKg2VFaPHsgP2
         WbVK0W6ivmcCqgN60b0xeJqUDJFzWPMtEQOPbjg0bswYyjUFfL5+gfJvMjiHZMrurPi2
         d6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707339661; x=1707944461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ogkN6LEaTSz/BYO4QwmYZ0SQAykq4f6RwEWzKx8qQ4=;
        b=YwNk1DoEIomWZl946QnCLe3jLKq8PKSJU69/gGytK9GnX8VD24rQ+z1TJX+DE/6bDD
         BEb/xfAlR/N5WdDsdiLLFn3VRxP1k3UiVkQvPbT423EC0FM09SKTAUCdH+3nQYxUKYlM
         DUBa/oXtw8IQBEvW9V3pd2ZwWq2JYknl1A1EQcA5bGMI72QngKGOMXPNAR/Dx6OJkNDf
         zqqAZqIF60wXFj4CizelTDVqkSc6ofHO+Z2W/7NOIeoWS1xpRSAbJpx78DoG7dGfrsBj
         b91ddFHtYAIH3UjYU/7X555dT/yBwr0m6rZB4IrO/fXKNPMk+L2KBtZj9FvKEc2ueQOm
         RtEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+CRCHqeNHJEfAAF43dD7avF4LO0R0HQkdIhtbJ5NQowfYNCtzz4COQHBK7SEtb12zypDjJciU7pQ3faE5J8OWq/pt+tCd
X-Gm-Message-State: AOJu0YyMRlakmA7ivFVYGPmKV1fEvehZpn0oNiSnNypudrpJrrLmA0XP
	Fh18RsTDBH3XocEaXjISAaUzvUeYn4s3XiozsbJ064IDmK1hjoTW
X-Google-Smtp-Source: AGHT+IGQGfnrr6DogjZWWIL77rEWuQwyWMU/D9t8X4sbHx/SQnvBXgsgOAEVdtlhaGlGgEjszjxSbg==
X-Received: by 2002:a05:6512:304e:b0:511:344a:fad5 with SMTP id b14-20020a056512304e00b00511344afad5mr203107lfb.31.1707339660586;
        Wed, 07 Feb 2024 13:01:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrexxqgIV8w8bZcjRUbgkUD6HrebOTZd8knRLKT+QZjOLHBrNP+Fsg12e22JnbYR4ZXsMvqgjFly/BeWLAQcXeY9WaQWEp
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id fc4-20020a056512138400b0051155926e0bsm313524lfb.139.2024.02.07.13.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:01:00 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] tc: Fix descriptor leak in get_qdisc_kind()
Date: Thu,  8 Feb 2024 00:00:06 +0300
Message-Id: <20240207210006.13706-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add closure of fd `dlh` and fix incorrect comparison of `dlh` with NULL.

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/tc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tc/tc.c b/tc/tc.c
index 575157a8..162700b2 100644
--- a/tc/tc.c
+++ b/tc/tc.c
@@ -112,7 +112,7 @@ struct qdisc_util *get_qdisc_kind(const char *str)
 
 	snprintf(buf, sizeof(buf), "%s/q_%s.so", get_tc_lib(), str);
 	dlh = dlopen(buf, RTLD_LAZY);
-	if (!dlh) {
+	if (dlh != NULL) {
 		/* look in current binary, only open once */
 		dlh = BODY;
 		if (dlh == NULL) {
@@ -124,6 +124,9 @@ struct qdisc_util *get_qdisc_kind(const char *str)
 
 	snprintf(buf, sizeof(buf), "%s_qdisc_util", str);
 	q = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (q == NULL)
 		goto noexist;
 
-- 
2.30.2


