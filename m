Return-Path: <netdev+bounces-243847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA70CA8804
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 422323016FB2
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7D346FBD;
	Fri,  5 Dec 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qx3s/rzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FF345CB2
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954744; cv=none; b=USdSGxM7R1dcO48blGvX3YgWPhXKrzbF/yr/Q0NcDiAA7tvuikAWyf9oJus9hqztfTl9jkfLmL4brtF66k8mR3GLVGKA8SeZNTcvhAMKRnkXs5n8VKYtMZt+G9oUXY/5WUzYtIzkLo/CxaNgpGV7vSC9C+ZNT+xsThdVOOfppj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954744; c=relaxed/simple;
	bh=pgJ6ff8paldt7V+cFG947O9X9Ylktw6h4GCVRLqVB2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGDNgIqvDjX8TNX3jqpgByRpx0g33bm6ctCCYCctlJMZd/Tn6uIOGhaHObRKSJJgKWFyNAAL5Iefp/6zWHjCy/kiDO5klfJ5hoO6In1FQ0NcZXmJ3b6n677o2UWIN1QPcPOP4/cswcBtt3yUtb3L9Y3U1CZwTGwikSl6mtrMAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qx3s/rzO; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-11beb0a7bd6so4118772c88.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954735; x=1765559535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvo6P+4Y0aHWjG3Dbxy/Vth64KyTxoqjK/aQ5O3LvqQ=;
        b=Qx3s/rzOxetlefVCd/9b0e6fuf9Fxcyhf4+Un+8WtZbK3GehiKSpqlVaskjOGKoh24
         wHwCCa6SGkX88GU3x0ydtAcq8CyMECYfCUPwW6TJVZQp2tsSAHGaUCnICmM+qOXmfpk1
         uwN7IcFLC5587uRO6q79Qm6CF184uWBz7SzZKFwi4KAIrlnwbLeLAzW2GzlPIHxPmoVL
         Mcaz0CBx+iYDUDGdZd1bM+9DtOSWYzSayQdbswTFCtI86ifHelQnBh6SHPeb35b9cT6K
         MZfYEZakBTlHh0P68RNSk1209SP631YXS2Ik2jeaaY9tNuErPKzvd6THNdLe0eZRf7gB
         RvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954735; x=1765559535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvo6P+4Y0aHWjG3Dbxy/Vth64KyTxoqjK/aQ5O3LvqQ=;
        b=Dpqb97kWWOkuXsghoXPslWHk9nXCpNM//Q03LYsCgEljJWWdk4fIU1uOkM3kUqPKxB
         vPADi4T5JXZEh+TV485z89cMWKFX/yohLucSZJrWyPy5ABdKpdjvU2Sj6NRmKCLEDZYY
         qQlcApybkA+D4yDWn3Q44KfMj4kUx79kAvw/IB2gUJwGS8KNR8yR6/9ZgtPtu1AyZ+CX
         XHI6PdBYPra0qFKCwgacuO0Z/9DKz++G2ewiLO/PoXnlRQZEnaCi4sjl3Vf7PhJKbhzT
         zPObFdEoA9y4EWyUAAOD6Es6pG6nRcJxHtvDJZK2PwtVzviZCcfmwyHTtKRlyaXNtxU9
         NPSA==
X-Forwarded-Encrypted: i=1; AJvYcCXEjR47IHU4oG43I868M3EJDCyjAFoh+9jtmfp7VD+CaBSj1QEuPUe90wLdxnh0wu0dpD01pf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/Q1V3s/FZbAGjXG31epZ3B9dy3swL6RgCJu30ul3uRT9stjy
	k0moF1SKkrajSAL2WLlOF+v2EyYyrhyDlBMQWrsx04DI8B/23CQ/Q06j
X-Gm-Gg: ASbGncvyochHI/9ooC/khVxpzA9NUSPVAu0rQ5jErxEsIj+HC3b4b5VAl+714LbPUBG
	JO6azCSwAktsWevdQ1GUodCnX6N/7GT9Rz0+yxHCiopY/02MbknhqHzEoBZxJQGBaTWiRHzsHnN
	knOdsCfrzfHRf+Ni8Mw9rLIsfWah48s4eJceZnIniAwRuG38aBBBHOGSHBaPaiTfts3iae7Fy+W
	ZuvlDlhEK2mXSlfRu+q/JPdHsnbvp4iVPHvUdHVmymEiwlpWRC257isubC3pryslozxDBQtXCDL
	2SfFIo/ICxf//vz+Qkysm0K4KdqXGqg+9gWntMSmT/gh3bDOMoWLL4oR4QJ8Kt7WVYTq1T9rIWd
	u9x+JySbX964PzihYNPz4JdKlXtV7mcbgWR15jK3o3HuvqiQ0gE//NO6lFK0swyBPCz2z1/zjVS
	LuF9QPHR5Up7OiKpjsFkb+kK8=
X-Google-Smtp-Source: AGHT+IFCC9u36dpszL8LHl6yuqSwEshH6IcGGz8u5zeSSUuddfN+n2v1mO2/tmCjMeVOnHnvUljNXg==
X-Received: by 2002:a05:7022:249a:b0:11b:ca88:c4f1 with SMTP id a92af1059eb24-11df600e305mr6401788c88.20.1764954734841;
        Fri, 05 Dec 2025 09:12:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ff44asm20698013c88.9.2025.12.05.09.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 04/13] selftests/filesystems: file_stressor: Fix build warning
Date: Fri,  5 Dec 2025 09:09:58 -0800
Message-ID: <20251205171010.515236-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix

file_stressor.c:112:9: warning: unused variable 'pid_self'

by dropping the unused variable.

Fixes: aab154a442f9b ("selftests: add file SLAB_TYPESAFE_BY_RCU recycling stressor")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning. 

 tools/testing/selftests/filesystems/file_stressor.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/file_stressor.c b/tools/testing/selftests/filesystems/file_stressor.c
index 01dd89f8e52f..4f314270298d 100644
--- a/tools/testing/selftests/filesystems/file_stressor.c
+++ b/tools/testing/selftests/filesystems/file_stressor.c
@@ -109,8 +109,6 @@ FIXTURE_TEARDOWN(file_stressor)
 TEST_F_TIMEOUT(file_stressor, slab_typesafe_by_rcu, 900 * 2)
 {
 	for (int i = 0; i < self->nr_procs; i++) {
-		pid_t pid_self;
-
 		self->pids_openers[i] = fork();
 		ASSERT_GE(self->pids_openers[i], 0);
 
-- 
2.45.2


