Return-Path: <netdev+bounces-70003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9972984D397
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F2C1C21FF4
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 21:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B27612A178;
	Wed,  7 Feb 2024 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/IJMm4U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AE12A17D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340650; cv=none; b=NwzotwGga03xBsXBfexwIDeKsvNy738yg3VJqKejNj/6/izQJejexLPWZcmg+J8a4ZdT58OmIV5vp54Se/sT6eavIC/SPb/F5/Jb996R2KlOULR/iRF92OU2lpMElWQzlRb01rIfO/oRUTMsdvb8AMeReq/baDnH6/lEMwnuR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340650; c=relaxed/simple;
	bh=DhJqMZpycZIfu9MvC78R+2In+rk4fZyXpWixUJ/Tbg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/Fv04W5iVVXSo3R37s+HUpP73zZ+AwfvyeZWcvVbR38pwYh7qcW7XFAvW4T9BJ7cQjpDaNYBatfouZLCim4nuBFf6BPv8fYE++gYIr7S2xXShupEJ7YULy9EbQ/ye8/JUCc9QDL0gqAzeQngFhlVDjVm6X5B3ognBF+9dy1CwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/IJMm4U; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5101cd91017so1392141e87.2
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 13:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340646; x=1707945446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31Olk8glwTzC3fH7FgHuDdTWhaIrj6bTBNRWB7P7aDs=;
        b=Q/IJMm4USh18CyIflf537rQFzg7NjOebmejeXKT5iLNPN9Y+bvGEopDfjhVWEuuaBN
         07Q9Kz3XB+9ii3gf1wR5QFFrvLb37LNThlXaJ6iNk2o8p58DnXhL+1znKAe3wvLp3lGS
         Ep+adIg8vU9dTBNs3vU+8uRsyxKpmmRtp9rnLI5K6MNuL8klvG+a5Ob/sC35KkWw4WP4
         VmKggu8Qds4S6ShXkj+PSOg1kprC9vC+HKJkA1XwZuXn6MevDwAzg92Q+33V5qF/SHMI
         gT9vn7aM3jvpQ3l7vpmjKlrDXULcIbUulILPM6CGwe+PlF/HytcV45hrNdYeKpNpeTfq
         88EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340646; x=1707945446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31Olk8glwTzC3fH7FgHuDdTWhaIrj6bTBNRWB7P7aDs=;
        b=us/RLxgdaJWkUtHSiU1M64bwnT5gARv3j3vwhvi8ZJCCpc8LaSyFlVFM8AhzCjgkN1
         T9cDbA8KIIIjksThRSi04ulLEopJaggoSDpKsZstzVTKxMSDbnDqGylYHctt4P8b/uQB
         lxK4jkT9ygsA10gjIAnawC76Mg2HGZak6R+9q4/S564LZeH87VNBKK6/Tm3CRrC8STOm
         UObXqspr/OkLdaJ7VPcBfD0toGPayh21r5nuxV712NKrGP3R5HQb+utHNUGhnODadL6I
         0Z1hSsPFUQK6JUWI2sIRJXMWs8GOLZDE2OpVTPRT/hlkSmVEsApp3kYZGioI+P504OWn
         uRbA==
X-Forwarded-Encrypted: i=1; AJvYcCVQTSlqqp5c7luWC7qUo7632CWUnBuvp3huY2Tvd0V8e2mP5Z5fr8lQtsFJiIph/MOvG9eombF6lRfDyYBe7s4beJJfneMc
X-Gm-Message-State: AOJu0Yx1GZHFohEl8XfHblSfVqTDFxwKHG+OM814lE0ei/JiaPPT4jLR
	RHz8ES3dhAoptRTjgrmdRa+CvUt1YY7K7OXmflRIGMnZHawQ/6R5
X-Google-Smtp-Source: AGHT+IElKgvG4DEAuE3HH9s9SwKtLaJZazm6R/aKbpFBOuZORQZmQPjQ4fp1pM95nHYarrckMKQQ7w==
X-Received: by 2002:a05:6512:34ce:b0:511:4df9:1949 with SMTP id w14-20020a05651234ce00b005114df91949mr4743081lfr.41.1707340646231;
        Wed, 07 Feb 2024 13:17:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWDTwB/YPnOfNHFiDtvJLqIF4uG4EBh2pupOsL26fMAhR74vCI3aJFazeDEuBZfmwU+gl/AfMC6VDiTOH2KeGRTqt7eraXf
Received: from mishin.sarov.local (95-37-3-243.dynamic.mts-nn.ru. [95.37.3.243])
        by smtp.gmail.com with ESMTPSA id h13-20020a0565123c8d00b0051121bedf76sm322915lfv.34.2024.02.07.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:17:25 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] m_action: Fix descriptor leak in get_action_kind()
Date: Thu,  8 Feb 2024 00:16:32 +0300
Message-Id: <20240207211632.15660-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by RASU JSC

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tc/m_action.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tc/m_action.c b/tc/m_action.c
index 16474c56..7d18f7fa 100644
--- a/tc/m_action.c
+++ b/tc/m_action.c
@@ -111,6 +111,9 @@ restart_s:
 
 	snprintf(buf, sizeof(buf), "%s_action_util", str);
 	a = dlsym(dlh, buf);
+	if (dlh != NULL)
+		dlclose(dlh);
+
 	if (a == NULL)
 		goto noexist;
 
-- 
2.30.2


