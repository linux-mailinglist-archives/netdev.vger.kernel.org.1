Return-Path: <netdev+bounces-243849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5ACA8919
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98BCE305D7BE
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DA34B19A;
	Fri,  5 Dec 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPlv8YPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1124346792
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954747; cv=none; b=qnmJcnA0vAS8Rq5bXnWg8XBjda7dKZ3sSwOyJXYNqkWgPn4zX9VX4zPghiFjJRoD3S2lRbkpXTBks0J0r8Qjkt2VGYHiQ+xikyjgigREooRb6Nyj/hpdVdtyYIWqRKy5na6neFr3gJ2cLDQCkvfaf6O493ATTHGNj9oGQ7hTubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954747; c=relaxed/simple;
	bh=IxOhZQlEd/Qy+CepjX8AS60bi75DFljz0EePvluZ/lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftXHqnU2AfwiK7rl11tIPPv/ZSfgN/bRr0+3PSYhIb/Ci7EvP1AzgZh/vsUYFpsirkU3JkTDMEfs2gNqtqv1Qln8jlXnCQNeeD9QNCOXnmUcOS4A4ROggK/3MNbq7AL8YMJ0KyTwjF3uDg7kcszmyvpNVlXfiBoM+mXbGphJI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPlv8YPY; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11b6bc976d6so4344756c88.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954736; x=1765559536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4IdV8qLxCXpcZvIrzxwaz1yCq/7QPM0MNgJTT3yV/c=;
        b=VPlv8YPYEfO7w8MO9RAkz9CUM0VsJEckg/+CMpdCFwxKyk4QYo7JaR2dY9SRwvIsqH
         Oe0bdXebvMAi2Q6TKgcFa8sfg7zR8FLCuvTWH4EadyIuMHcWfDxEGwF7Maxc9fPjGb1Z
         KeKNJ/CbG9zRlmBpr0K62GFO3l9L2n6G5BYjk4BB6TBXRaD8ANhntTpvFBlDIcj29tNL
         wk9a+SrD5rHQ6r7QgT8srfuowJic48rHP26yFS7NoWGxTJQ6Tav8bndTFUnqfnM29OWj
         jSq4tN8MSf2clwr7crYZYD2VRcQfMKMDbKj1gELuwYBdWF9ATJCmzu2Qr/sfdA8FPXcM
         zuLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954736; x=1765559536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4IdV8qLxCXpcZvIrzxwaz1yCq/7QPM0MNgJTT3yV/c=;
        b=EF87Y+PxvqOcqcd+L226vn9vo87SRt50yg3fowGypGy51whWLTKt8NeDqabHAQrHBW
         DF9K6Sy1uLLctpCCC5cz7UA2Qm3JnJHKB0E2OoDqVFOzMnqUa/QxvUwocQhdHJxPgaB4
         uRoAXUkaGoJpILqOdgIG4+LR53RKYgGReHyUTewosAmSXoxJNW2l2Xdxp9iiMc/GJ1f8
         07DpcBie/bu+/Cf3Qkf8bA4f4zNBmUSzs2/F2GWGzycTJ+mPX5jqRJen19DZ5XLtqDnR
         xFzoAOfjZjznFxEgnXhJEzdU5dmgwaZJafqaxY3Zr8X+97ng1BXhPDIKBA6oGO/cmr6L
         wo4A==
X-Forwarded-Encrypted: i=1; AJvYcCUFP57ZQ5dI0ctaVtuKlSmRGaFsXju4NXyUNFiC6cjXOzBXVrFaEAhGE8bNUKfcTb97KqGBQ60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzINpiC6F+3VR662nJqtC1l8CSakW3sBG+WZNLr49bDasLIIFIG
	Z99xdD7JCWD71CUsNPLnN1gS9FeJN+dzV1fezFUp0QxpdSFSETbESQrO
X-Gm-Gg: ASbGncviUTC9ILwdpWXvZEVwmr8aZfuwVZM9jFXXeCDTiIJ2shvhs5dapix2xvfTWPJ
	zXpcgKx6NrDnsJ0wN8gOcD3hkaX5bshyRimisHoLeAOY9ZKwx2gI+pF22WNyLxfr75Q8Qatg31/
	M/+ePJV7t8leeZKksrWqbwmQ3yz1BjvdQxw1s+/pQmHX5LFtnIXR7HzbOUjwWOVxO3vwABrfmWs
	SLeqtr6CSECUBEpuISKqk6yoaXe/Kh1Zs873kSoVtdhPSYGHzCspFJO0KIVDLt1TqXFEJgNwpZF
	DWnYiwnIwOB37W1LSIHq5TswWkV88z0USJXEd7gJHeVuzqQvMiXUzGXgz0Uh6l5K1FCBNvXmOHe
	waQ9ByrmIskO1CCKjvwm44fjDWdd6LuKa2BjDYzkBLqYbYFO9Flk/5wZGPUgdzrhZcVo+/dgY92
	fpyC+8E6lmc1dEDBPL+idfjVEvFmQWEPoFVA==
X-Google-Smtp-Source: AGHT+IFIrrXmeRELseDoVSjhKR65g42A+CBh3uKmPIej8MyEU1H63Ol/p4iC5ibACsKwkEY6LwYTPQ==
X-Received: by 2002:a05:7022:43a4:b0:11b:ade6:45c7 with SMTP id a92af1059eb24-11df5fdadc6mr6650958c88.3.1764954736002;
        Fri, 05 Dec 2025 09:12:16 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm19408894c88.6.2025.12.05.09.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:15 -0800 (PST)
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
Subject: [PATCH v2 05/13] selftests/filesystems: anon_inode_test: Fix build warning
Date: Fri,  5 Dec 2025 09:09:59 -0800
Message-ID: <20251205171010.515236-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251205171010.515236-1-linux@roeck-us.net>
References: <20251205171010.515236-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

anon_inode_test.c:45:12: warning: call to undeclared function 'execveat'

by adding the missing include file.

Fixes: f8ca403ae77cb ("selftests/filesystems: add exec() test for anonymous inodes")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes a build
    warning.
    This patch does not fix:
	anon_inode_test.c: In function ‘anon_inode_no_exec’:
	anon_inode_test.c:46:19: warning: argument 3 null where non-null expected
    because I have no idea how to do avoid that warning.

 tools/testing/selftests/filesystems/anon_inode_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..5ddcfd2927f9 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -4,6 +4,7 @@
 
 #include <fcntl.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <sys/stat.h>
 
 #include "../kselftest_harness.h"
-- 
2.45.2


