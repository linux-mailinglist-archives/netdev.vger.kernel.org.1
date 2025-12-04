Return-Path: <netdev+bounces-243611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB6CA47B6
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90FE8302DF26
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 16:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187830FC18;
	Thu,  4 Dec 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE+0E6SX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDDE314A7D
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865062; cv=none; b=VFQBbM3q1fstlcRfv7oPgtONeo6OWH+IZ4s9A1uq/SoiccnfvVbufW7IGjF3jtd1obAINwGZXc+4UUdj4opujo86pRKjKOd/LlwoJVA+4KVE7AreStlg8RKsSTRQKRcwFugPxYhDHWTksu75warNHsfxlIHtFS30Z59xObCB8IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865062; c=relaxed/simple;
	bh=gZJXV78gHZtRTjJ5rWeZmQz5j6YeAgfJSOukEvgm3/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIjlmy9/qOsERon9GVZzmC/wREY7i7eGDb14mIquQ4btfjYbYJxp32uqzbJx3mnxCcuNGNKRkG7U89Z9rqEp7LSPxOWMssxEkrsu0WvOq4Va7CHLkxYNBKU65hjbl1ZeAVFRuO9klcEJScupFYuL682i+NNmDl+j3tA/b6k1wAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE+0E6SX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-298145fe27eso16798175ad.1
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 08:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764865060; x=1765469860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwcxoNWnHgxgVsdrWFj6b2CCDVS/+W82Dey2vlOgJ9c=;
        b=AE+0E6SXDSYSrv/1pbglKIvB20rgVqo6Cj1jL07ptnrRcdXwDKMR8IysFUQYE8SW8q
         li4W0oKSxb7zk3xIfGadhkTRKeXOr6twXHAxhTv94Ekw4s+3hGizUN8KkGm7lZbD4mjd
         GIaAutHP8g8RFakgwYlOn1OnsWWemjPRCnBsD0DAVj/THN3Xloezh/yr8+Cqm4S4wnCj
         VgOkgYmPYlPIfnR+7avDaxvLk3QbXTQEEnSYv5JsPya1q1koJTD2vSiR/KkpESICuY+M
         ggRA8oTQhF3ybVZt659yzPI55aymGl/0HsEaq0NBJkv9fft1326YMrz9ueVY+3Xg1CZE
         OspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764865060; x=1765469860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwcxoNWnHgxgVsdrWFj6b2CCDVS/+W82Dey2vlOgJ9c=;
        b=OxAN0z4lOSWPCWNGaJ5rOMF4NQzbUj0TT6g0hnYgOqToDlxxuChg+f+GUGOx6xYvZi
         cnephD4T6RutrSMrdZh7Lcoa/VEX5v5UYCVdrYdMY1j0CVzlsKbwLcGOSLZttdkvSkff
         9pVHVhzFDlKFVAh32lBrMp6s/DW3cg9gGtt22AK1zsORh4f84bYSSrpIkLvlfZcqFHSo
         Q3lt6D4gJY316Zut4zjK1p5XZpQ4NVriSzKh1GcwNQ5OWcXB60smRE86rFu4hsFv0vfp
         I7FVB5eEsM/ojBDowr++mYJpTORMXQ4Fj1a620lWXOolYH4B9A/jdBX/RRdQFcRauRQh
         17Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUbR4+gU64wrqosMkvbSyH5SjLTlcJKFmub8bClnyXpHvr6uOhnvBqmXr37ACpvY1ujV7twkyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGtSY29CeK5i+/zDGWTiqjpRKI3Y0n8tPhHtmhLIkj9AZYQXtd
	KI6AVcHBnBTuXhk2LGJZP6GpckzYsHuwCDc0drqNRiVZwUTObEBKaK+x
X-Gm-Gg: ASbGnctxTgpvcQyzyegwJ4RhTeVR5kKqalTzzy4ErLmciPrpL2+Cnb0iGyn8fXcHbQz
	XAfbUfTqwsEGMAMrWDliiAomy1v4C/oVi9seRfWTKXCAjdCEgtES1BKIbrjeuHhzbRb7L+lA0VO
	dO3lS7GnZzsG53uDsYDlCNsb1J46WNpel6GQ6YR8KFvfa39eZyf4TZlLHYHCJLcydRY9ASQbc7x
	1iL/I35FFZmfRy3qgZ/q+aLbPpa6wjG0/FiiYzl+OuA1Gvq9FYOQduzcVcB8j3OW0fQiCl78Eda
	BqSO+UTJV6AGTyFdOq2ieYOoYHxpssAywaM/p9IcZYpPUwQ2yMuIb0iMq+G6Iekk68HhF1k92Vr
	RVQybnac4GzBGzeTxLRCsjyIlBfV7HfYkCM8burlRNUqTpehawp7LXShrUu4pWk+zczvu8zcRCU
	plkWVW8zplCYGDHllNXCLidTo=
X-Google-Smtp-Source: AGHT+IGzmB6v9ps/YSI3Qm3cpiKTiSzZ8l+4/hp/M5jJOLx8geHlmhJcVZldcne4oworAKr/lAMmiw==
X-Received: by 2002:a17:902:da85:b0:295:9e4e:4092 with SMTP id d9443c01a7336-29da227a59fmr40482655ad.56.1764865060170;
        Thu, 04 Dec 2025 08:17:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaabba6sm23744045ad.73.2025.12.04.08.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 08:17:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Elizabeth Figura <zfigura@codeweavers.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	wine-devel@winehq.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 05/13] selftests/filesystems: anon_inode_test: Fix build error seen with -Werror
Date: Thu,  4 Dec 2025 08:17:19 -0800
Message-ID: <20251204161729.2448052-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251204161729.2448052-1-linux@roeck-us.net>
References: <20251204161729.2448052-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix

anon_inode_test.c:45:12: error: call to undeclared function 'execveat'

by adding the missing include file.

Fixes: f8ca403ae77cb ("selftests/filesystems: add exec() test for anonymous inodes")
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch does not fix:

anon_inode_test.c: In function ‘anon_inode_no_exec’:
anon_inode_test.c:46:19: error: argument 3 null where non-null expected

because I have no idea how to do that.

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
2.43.0


