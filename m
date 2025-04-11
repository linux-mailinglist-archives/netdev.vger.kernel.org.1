Return-Path: <netdev+bounces-181660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1082A86031
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0419A7894
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0CE1F30AD;
	Fri, 11 Apr 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyJYnF/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF8C1F2377
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380656; cv=none; b=i9iidXyQPDiLKCOi34Mq0HFnU90zGjjw0dIP3QDRyVBTAFDvuDjP9c9Bp7vOogDp4dXey305rwqYipLT5bWEUa2DRguDzPbDPvpsY8mGR3q1EmRBaUvN/cMCc6oyp87hyzwGd7bsde8y4rzFjhU/7h2WPSqHR4k+zI5uy88fla4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380656; c=relaxed/simple;
	bh=LOZVICoDpVRUGMiPGNo9j09ggtn/7RVKBLctzLaQ18c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ugA+Zfk3yRDymcl6IE4nDuODg32e8g7jfwVGe3qBVfO8jdBMBBHFEVISdje5pT/eWlJ/AYSyyFEn9jPpgNw44v1TtdcoZ+CZLVgqKaUAgtD6AwQyq/ZTT/GvYy/zSJO6PemZjpm3lpTWCylq/vEZ1sEY3EL8xqR4BMMnTEw3lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyJYnF/t; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2963dc379so332589366b.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380651; x=1744985451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QvbQBGoVupZutbGHyp/6EiFt+ARmDpJwhBTl8DJtS0o=;
        b=UyJYnF/tknpYzwNUVsGCA1TYRpgWW4S7cDmrPmNq1tpMDfLUNHmxPJc3doahGYUiMZ
         I8OYP7IYRNolbYooMLxfLE0ZfdVtwoMHGGj3w4BSy96QX9xhtAifPwhdwvBKGRxVOSFX
         9A7n2HWJFWuujf+1FEy4BsGhiRFLF/xlSGrAeuMlF8U1MykBBQ0WaRuzLYcxg2IBeh9F
         PZqN8QIlOjpeGFmZnBorhf8J9TCELFeoLyI9HSEzCobHMNbu6hnZmCx9HIP67WWhEdel
         4xJygoOdA0OPcXUEQiqkWyMkcvguTPnRCzwXP4SOrksKcz4vhp8zpn46qZQnWLnKdmvH
         IqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380651; x=1744985451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvbQBGoVupZutbGHyp/6EiFt+ARmDpJwhBTl8DJtS0o=;
        b=UfjLK5JOmN9Yq3krOaZ+TX8lfJFTmc9YlE7shA+DuBsmOd4wpB7YWTCQ2KdpP/w975
         kSVRCfyjYvCeCAYQqa/zAuBXNhIu/rnOzKF87/hbK2Bm5H/Ox2/COv4wfeb4WFE+lkto
         rs6FG9v0ZD+F4eId8nVg2M7Qgvo0yztFzIp2vv03gvN13jgQ2TR26k13+/ksqTKanew+
         SwlbdGn3pe2mGZVObuXK3ssJ660bOjBoKx7tohu2SDigJqfZjjeJ+N8zmkQBEsOk9t0W
         X46a5PeruMPnDAUTc4bxGFckdg6JkS1MeOfAfodhA9VdtfNWTQZdKOd8n3aPfgMKZdk1
         slvQ==
X-Gm-Message-State: AOJu0Yy4nmToWs4JnqL0b/wl8U7mIvTUBzHR4m+z/7KzNCJ19URaSde3
	cjq53CgFDYe84XZK32O0D0T68dc9hQ6aiKnr5i/Y1HNQaDSq6Hr8
X-Gm-Gg: ASbGncsUtGSVqnMgyOLF5/4ja7ZumGKXGr11AXXr7bzBT7p8deQiI4gl3hFKcXyB22q
	Z4Oj2lIfgLUvAPYceC9czXRIAq61xhW18kdqZGjOh7sEvCHsU7l/SEaRJOKDrVm7NlFv/rE+ews
	C1k5YjFl6J0LsueW4ZAIsi1EVdspFnkXX0FrOKSjB4iFr/QSRz4ZLZXPrwNOJBIfbzfmIVofN8W
	cuFuSFIYohemDuaITf21oinBH9R/xhHr9TuMDIyWvuH4XJ4sWGrdhP3qB81qLpvBCShWfG+snev
	xAWukHhWkEHoNBz59dB7sUH/75b/8xS67ZMKApPc588CGTPyS6WXh+AyVp9GKWvudj1SODttRHL
	n27b/vr02
X-Google-Smtp-Source: AGHT+IHwQQGfG4/Eyleo0ti89GOUGJ4Y1AsBO3UwXiMg1vY7jcee14CklzbA2pZ3qyKYPU8SOb7rKA==
X-Received: by 2002:a17:907:97cd:b0:ac7:391b:e684 with SMTP id a640c23a62f3a-acad36d9208mr245114966b.58.1744380650239;
        Fri, 11 Apr 2025 07:10:50 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3d8fsm444248266b.22.2025.04.11.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:10:49 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id AA3F1BE2DE0; Fri, 11 Apr 2025 16:10:48 +0200 (CEST)
From: Salvatore Bonaccorso <carnil@debian.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org,
	Salvatore Bonaccorso <carnil@debian.org>,
	asciiwolf@seznam.cz,
	Petter Reinholdtsen <pere@hungry.com>
Subject: [PATCH ethtool] Set type property to console-application for provided AppStream metainfo XML
Date: Fri, 11 Apr 2025 16:10:24 +0200
Message-ID: <20250411141023.14356-2-carnil@debian.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As pointed out in the Debian downstream report, as ethtool is a
command-line tool the XML root myst have the type property set to
console-application.

Additionally with the type propety set to desktop, ethtool is user
uninstallable via GUI (such as GNOME Software or KDE Discover).

Fixes: 02d505bba6fe ("Add AppStream metainfo XML with modalias documented supported hardware.")
Reported-by: asciiwolf@seznam.cz
Cc: Petter Reinholdtsen <pere@hungry.com>
Link: https://bugs.debian.org/1102647
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2359069
Link: https://freedesktop.org/software/appstream/docs/sect-Metadata-ConsoleApplication.html
Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 org.kernel.software.network.ethtool.metainfo.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/org.kernel.software.network.ethtool.metainfo.xml b/org.kernel.software.network.ethtool.metainfo.xml
index efe84c17e4cd..c31cae4bede6 100644
--- a/org.kernel.software.network.ethtool.metainfo.xml
+++ b/org.kernel.software.network.ethtool.metainfo.xml
@@ -1,5 +1,5 @@
 <?xml version="1.0" encoding="UTF-8"?>
-<component type="desktop">
+<component type="console-application">
   <id>org.kernel.software.network.ethtool</id>
   <metadata_license>MIT</metadata_license>
   <name>ethtool</name>
-- 
2.49.0


