Return-Path: <netdev+bounces-203053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3EAF06CC
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F29017CD85
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407C028136B;
	Tue,  1 Jul 2025 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G960Ts+N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535672621
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411606; cv=none; b=Tp5HPJagF9Yq+SH84K7xFaZzwj1lyoeoTVmY5rCnllwe30+7EkVtSOSRirRTzIpHIcdEsMiJNEOm34MIZyAp6EaJaIvoBgfZvp2PhdGJfy85Bz2Vz1iMk1ORyD9/iCmq8vcp1YW+tf/2rVIRkIu0Jg0/iMWgaLrLsvceEpzRLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411606; c=relaxed/simple;
	bh=J3C/uQFAhMC5Eoy/S4Dp3NYiavuzhjk87eJBOWIyi48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rv0iC4Xxqhl7uaXKt/asEuzPsUUFTAU4O0LdD1f7LXNTSOilf9mp5oUBqI/q2iqZ3nD0XD/ahulj+7XjnudSEZJfTOjOXDQIPliOU+t/w+q0OM0JV0BGONFF28AEPgHDYRvzZrTjDTasrEbp+tdE2Tg2Km1Nt3K6JII0rqpkT64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G960Ts+N; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-879d2e419b9so4730736a12.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 16:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751411603; x=1752016403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTzkY70W1qhC8qRgej8mz+Muc7NhAwkLUauB4NRV+oo=;
        b=G960Ts+NAybgVjJKSdtJXjBqAVSgCaveHGO62Zams7mYa6ajiIMrsJXm1aD5cz+zD2
         5sZXZWUzlwIa5oV7SGNd4O5H7QQZSLX4e/Dkg2F9QhD3As17JMvU4Ae9Kqd8uzH4EEB+
         /dclNBQOZN/Ef0tdX2c/I8UjK971fvCfLKMkoiisYISiT8xq1bx8dxFcCgZJ0d/3vGFL
         /Oxuvd+BjHB8x1zowGCoPFG970E2bnYP+43LExtuz23FFM12EoVtI7oVHDwoGMJEE3wR
         CLl7oSF/GlG4XI8/cEQO44VPZkBAB20KgEHPi/P+JMKATot/upEo3MmsozBAAD3fDM95
         En3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751411603; x=1752016403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTzkY70W1qhC8qRgej8mz+Muc7NhAwkLUauB4NRV+oo=;
        b=J9atvDNaIrwNPUc8CVDMwOGRJSiYH5Cl/jXz6WMtEHTj/30K/JVQ4md3QB7n2FCZby
         4U72L9VzFwq7RRGhXzTJO1yPllskzeVGMtHoYuHtjELwnIDJhCe49IXip1snd8cQS+31
         C88DSgG1J9Ztc1sbAJ9yw9qU49q4WJaelxCFNDSaW5i9AAqdOIY3a50tJJ/tWQxJvkED
         HfDBkru9d96cLW5hDIJkDZDbjAbzkLTcM5tulqMc7H1XzjiUY/fcPpyz8qCTbJiaeERv
         D94OhdI7vZcqzmMmZF+ygRxYguR4EgHrJQ+7tLeGU+MtzEh57DH4kWKOesPbMCbXqgOp
         tdXA==
X-Gm-Message-State: AOJu0YwI+6gK1IUD8k5TFw5d/YYilQ+u6l9TcRNCvEkwqOQGaHt1DPXr
	Ur0vKGjf6e3F27pitWuLlRMDylajBg6Zbx+1Woo3eFHKEMn+asC0BnYE3a5nRA==
X-Gm-Gg: ASbGncuqpyPIPgWulQaRntIj4oAodKNRFjGvYvtQjSjZgS6g9RdlwUXMLIaNH0M/W32
	0OtGfpOJ8jkUIDPBjScYmgmO4qP0v3gNy4Z94KfTqGOrSFfWZYxEz8oiFCo5oYLd1OcHUA/Fpw8
	LjL+XcYHBX1l+nUnuzPTsAHiZuVcS+yCv0Msk1qTY4k3wmGbtrCWp/x8ZuW4fTvRb0kasUssoc/
	HDiNQxVV7RPezA7T49SjDwfItqj4KPwv//y573LSWtX1yFp+G4ZAFPwDXmOkPQtBMWfHwlcisnb
	kz+fgGXMpvfIrTp42QSXAyaw76lRVqv4e74rBOdLnNZRBnr/paQBOJdzygR0s901cYtn8jcI
X-Google-Smtp-Source: AGHT+IF6N+LTh05n1wlP9vEK1Pdkvq++PZJ+j9Sn3JF92+4/Woqx9QNr57ig0/fEWSqYArG2hMx+lw==
X-Received: by 2002:a17:90b:53d0:b0:319:bf4:c3e8 with SMTP id 98e67ed59e1d1-31a90c342b7mr1173013a91.18.1751411601709;
        Tue, 01 Jul 2025 16:13:21 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f542661asm16685564a91.26.2025.07.01.16.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:13:20 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 0/2] netem: Fix skb duplication logic to prevent infinite loops
Date: Tue,  1 Jul 2025 16:13:04 -0700
Message-Id: <20250701231306.376762-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes the infinite loops due to skb duplication in netem.

This replaces the patches from William, with much less code and without
any workaround. More importantly, this does not break any use case at
all.

---

Cong Wang (2):
  netem: Fix skb duplication logic to prevent infinite loops
  selftests/tc-testing: Add a nested netem duplicate test

 include/net/sch_generic.h                     |  1 +
 net/sched/sch_netem.c                         |  7 +++---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 25 +++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.34.1


