Return-Path: <netdev+bounces-175230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0039A64746
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 10:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269113A91D1
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB82236F7;
	Mon, 17 Mar 2025 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqzXzOEN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FCF2222B2
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203651; cv=none; b=Uvvjperb1EhtpPzuHMI36OmfAJBPyoVE+7ujy78i983Sl/7dbp3z+JYhwKylNxvtptLB0HmUE3V3/gGXXMlgJgGAMntjquubUzco2VucU2n9Pr72t8Vbu4PAP3RCGfIMAGVVZYbhGa2jLsplW733/8VnfbcM9lrVlkBzAFAuTGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203651; c=relaxed/simple;
	bh=wc8ZUJs4juXlpOzJC3dYvkAmWROYc3NkYrmr2+p4WQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eZJvhDMTGDQPXMf/SD4KE8jS1BzNXDDoW0PfgSatTvum6xK3zf/iWu6WNT7O0Siwi3i0FMEIjXXxgmnv9ZSkTifyC/ncNSMwBRouD+2Zg4lD+D42RENYEpUKn1K1JRcRvncBQkIxFQk6G81zJuRBcShbg4wU+Ubc2lQgzCqQELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqzXzOEN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742203649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ELVb8/TgPP99S2US6QOwfM5yFjDUVc6XvoMzilxTm90=;
	b=JqzXzOENl/divQG6HdzNRe7hqNPkqFSTmE9VLeCGBdu99M20gdyvVylDgV9Y/d7yOeeqB6
	+Rr3xECxp+dTFDojgqShkjhfbqEa2/0RL1dS9IA8ISBATAe7pFZjAW0BAPeIMHzkY3Iwse
	KAay0we3Mz7kJHSo91eXrzQOzyKy3ZQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509--IL5thkrMeOse2GMKAsU9A-1; Mon, 17 Mar 2025 05:27:27 -0400
X-MC-Unique: -IL5thkrMeOse2GMKAsU9A-1
X-Mimecast-MFC-AGG-ID: -IL5thkrMeOse2GMKAsU9A_1742203647
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3914bc0cc4aso2438051f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 02:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742203646; x=1742808446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ELVb8/TgPP99S2US6QOwfM5yFjDUVc6XvoMzilxTm90=;
        b=CkOQ+4sspOoyz6HJIdGvDR8beJqJEEFxF7slMxeK8pnu4J55Hrn95W93nc8gNfyK6X
         LuLjlhx+Vf7uB4msDS11t/5Ah1q3IYYG6YQ9TVR2c4GxzPJn3j56HYO6qkBzV04uL13j
         iQwjSEZeyI/d8vnCM01YC5gGk2i2Q55iUdyKSkZoW7yXC/XzkbwyQ59xEGIzLrREkTlY
         FiL610XlcFd8PE7qAgWRIu5HFMdNyj0tys/L0BSPF74dRLeMAB9aXSFYa221jMm1mh+2
         tQZqPp73E0xxBpPaxf9WH4uCkQgN5FMGoAEZx3MEKmwreZ8St7zHhTXH7+Pf1eZEG9Zo
         e94g==
X-Forwarded-Encrypted: i=1; AJvYcCVJ27QvxCexVmJciQPMgUyXiB6beTqB1f42CHYaONGuthObc2ppv/JPBoHSgpyb+PvKTPm3Vwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYC2NtG7Qw3YkBRqOnKnrtL5Pa0sdD6u9V9zStbRjdvrLsLmO
	1HIIAh4vKzaxMCOHdAHRZRp3ekbAMVl2koqWxqMqoWmIig9EKULQL211sJJFcR2BjUyo9YusaTx
	Jslano00VVqzREmoVTodsU3Yy7o2LoNcqQLm4ICrWBKLYCGb2kiQmMQ==
X-Gm-Gg: ASbGncv9BkeBr8dTkMVwrfI8dc2wF0n+a2c/NitOPMtzqe09LhweMkp2gLY3/EEvx2W
	/2fnnW1ihOpC1rzcbAkULn0pZBEFLYRWliqYj1dfeGSlb6jGeILkXCOSss0iYFygfiFnM/ZetJY
	YHYfjeKx2DzH9XX4srJJusnxmeB+X6xgC40+W7HNCmynhzE4axZMt9hbgZ40s3OhMCKiD1VCneQ
	jBJ+ZgssU3sK/R+q4AWFUEnBnjJN9wcpIt6d/Szw3uJc3K95bN2K7UsC034Kxw7g8NW5V5CCAlQ
	99cVrhREhKnSfESZ807Wn8f2Uhjdfjkn+srUVc6xT9RNW6Tjc7nUlnso7YZRt5Q=
X-Received: by 2002:a5d:5f84:0:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-3971e3a54cbmr14547804f8f.31.1742203646495;
        Mon, 17 Mar 2025 02:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRgjJ/x/oVlKZKHU7TipAkeP19C9rZyh+PBBydQPPRm8QgqfVoTWGnhCYtv13jfPOOqNUncg==
X-Received: by 2002:a5d:5f84:0:b0:391:3fa7:bf77 with SMTP id ffacd0b85a97d-3971e3a54cbmr14547775f8f.31.1742203646117;
        Mon, 17 Mar 2025 02:27:26 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm14795571f8f.11.2025.03.17.02.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 02:27:25 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Chao Qin <chao.qin@intel.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH net-next] MAINTAINERS: adjust the file entry in INTEL PMC CORE DRIVER
Date: Mon, 17 Mar 2025 10:27:17 +0100
Message-ID: <20250317092717.322862-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 7e2f7e25f6ff ("arch: x86: add IPC mailbox accessor function and add
SoC register access") adds a new file entry referring to the non-existent
file linux/platform_data/x86/intel_pmc_ipc.h in section INTEL PMC CORE
DRIVER rather than referring to the file
include/linux/platform_data/x86/intel_pmc_ipc.h added with this commit.
Note that it was missing 'include' in the beginning.

Adjust the file reference to the intended file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
I think the commit above is in net-next, this patch is to be applied
on the tree where the commit has been added.

Jakub, please pick this minor non-urgent fix. Thanks.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ae7f628da4..9544a4e84f99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12069,7 +12069,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
 F:	drivers/platform/x86/intel/pmc/
-F:	linux/platform_data/x86/intel_pmc_ipc.h
+F:	include/linux/platform_data/x86/intel_pmc_ipc.h
 
 INTEL PMIC GPIO DRIVERS
 M:	Andy Shevchenko <andy@kernel.org>
-- 
2.48.1


