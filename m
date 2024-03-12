Return-Path: <netdev+bounces-79576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EB879F1F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE57B21CFC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F45F339AC;
	Tue, 12 Mar 2024 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="rR9fH4kK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2529D1841
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 22:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284109; cv=none; b=rKKb8jPRb1xEra2odLHU1/EwLIPGAShXVe66wnr5CgJ67JE+eEel38bLO70TDeX/KBmjgdOOayEM5plCgRosC08dwd1sfpPcR+4mUTL2fNQg3dyIVi2FTyDqC5+pJsPY82WuVHuA4GQbh2xtuwryPo/g3qznSjQoZLA1BGIACj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284109; c=relaxed/simple;
	bh=dmbD0TXxk1ZgAYwO5Vh6SlYMxAGd8sCkxoklobD/E4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QaJ0PD7GHrYDxCy+dUFz+iTPejToMjPac2I3f04YlXvDLR1wYNRnJ8MbdcwfFkbrOu43qUZpwd9xkxxeQftflHZ7HNCdB6FOTn3Fan0KvMMoCfGRqGwXWZtOkhaA1d/3DVKddRLWzl6KF3ScINl2VlXPecKhV09NUrb6mRrQAAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=rR9fH4kK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso3107098a12.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710284106; x=1710888906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NP4Yj6/nyo7THsZC+F2dCIRXIoMNjp8gjz3RiK1nqCQ=;
        b=rR9fH4kK127YQNK3Gu4MVNYPAqBztE0xPOz+np29WYgiAMqIsygEL0RhzUeAfTD1+2
         U9+rdjCvBvFAHSzTJlAdnGOt+L7rqdQlHSUEY9ENzh2S5Xd1CVN3xpZpY2u6Uz7eBlpk
         tgQ6W6cdAVViRetgErRjHsW4se4+/ah4rGU15NCPTPJpRMsXElxy8qc9lDpeoaKiaqKC
         SVPWrSuhQndoq4Q81g0JL+DNEzsNoeRfVc7NqtE0kdsZAyCSXL/WOi4g7yTZHKgqaLAT
         1SnGQTrcqf3zraWrYRYYC0CAhmH6mPmfcaY52SDNt1Od++EXH0e9f9DQ08qZjZSc6cic
         rbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284106; x=1710888906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NP4Yj6/nyo7THsZC+F2dCIRXIoMNjp8gjz3RiK1nqCQ=;
        b=CIT+d00F/xk6GufGoMGBjrAtafQZPtpNcZ2ATpAl4wlluAA/OXdZlSPJmm0gyj5Imn
         Z8Lja9lpuIAr29ZAVnfEQljICBK9F6IWi/LF1sV6+QkGwGpBa9vUey5Yu94G0YWB49HZ
         fUlxQy0LEXpkIlu8w/Hu3q9zj7LEWM4Vwkv3MRvjkd+cSi26Dk7rGPgSYmWOepWj5You
         rQXO3oFjT3/brH4XEURM6PqQABAmMSEK/lvd3sZSRWYYU5XlDh1x8q4VHTrHJlO0ePVk
         8CJLuMfkw4fwXMBJD1ereLvnfWhQ7T2aHqSZaL/aDwrRhFZzWLgN9gb0g6Z9NirJH+1d
         iNIw==
X-Gm-Message-State: AOJu0YxoO9OjJbF/35k8ZEFQZILfQLdDL8w/krd0TU74KdmvUG9xYMo5
	WIHiKgJeVWTPIA2/0+o/vZTGkVzAdmp+DWYWE3G6HlPYcVJoJJoglgfLd9XtZbGwGeSLgM+c8Sr
	b
X-Google-Smtp-Source: AGHT+IEbpvu/RGpNhswG68Yz4yyvTMj0A1NQXBdgaIyn+Duu+ThrTUUn1lL1q0eQegRTkLMThT5tlw==
X-Received: by 2002:a17:90a:f417:b0:299:a69:1f8b with SMTP id ch23-20020a17090af41700b002990a691f8bmr9166885pjb.23.1710284106304;
        Tue, 12 Mar 2024 15:55:06 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a8b0800b0029bb8ebdc23sm98947pjn.37.2024.03.12.15.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:55:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/5] tc: more JSON fixes
Date: Tue, 12 Mar 2024 15:53:27 -0700
Message-ID: <20240312225456.87937-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some more places in TC where JSON output is missing or could
be corrupted. And some things found while reviewing tc-simple
man page.

Stephen Hemminger (5):
  tc: support JSON for legacy stats
  pedit: log errors to stderr
  skbmod: support json in print
  simple: support json output
  tc-simple.8: take Jamal's prompt off examples

 man/man8/tc-simple.8 | 12 ++++++------
 tc/m_pedit.c         |  6 +++---
 tc/m_simple.c        |  8 +++++---
 tc/m_skbmod.c        | 37 +++++++++++++++++++++----------------
 tc/tc_util.c         | 28 +++++++++++++++-------------
 5 files changed, 50 insertions(+), 41 deletions(-)

-- 
2.43.0


