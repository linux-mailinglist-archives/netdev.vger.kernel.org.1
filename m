Return-Path: <netdev+bounces-243844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFBCA87E4
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 823DD300351A
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B9434574D;
	Fri,  5 Dec 2025 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWSqwp06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A2338599
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764954740; cv=none; b=Emzr6qdfLHMng7qGg579QsIDytjodJU2eMLrfnmf1lzRHwll2TbOyi7VJ5npy2PTwf+WoPk3yTGmMi/TfvNcrlXx0awNZ5eb/clPQ0U0PIkPqpsgRl8pUzW3jN3zZBr7h8FWL6LpPJEjwBIJVvAvJR/3XM27lav/8Z3OBqd1c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764954740; c=relaxed/simple;
	bh=3D8Jia7maxjOED0qB92SCnhCwD5om9jZB2vyXsShxiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyLg8bsJr8g6XFyl7ypRo5Ux7BAv4jzNDAGqd+r/W0ku3OdvvWI3Gh33Bhg0rHDhgzF4gbSvsT5vea2G0nJ0bZgeE7nBDNJMQfVV6v8SxdUw42t86TfgKOioFT1MlUP/HT4DeDuWy4bnwuY4XRJxUJJ/VOaXVdGv21Bb0ZZBqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWSqwp06; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29ba9249e9dso33026965ad.3
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764954731; x=1765559531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKtvRnZXXEkJadMcjlPO6UUmkCEVjlrlMZ1C1H0q9gg=;
        b=YWSqwp065wKnTjm7HpRnT2LAKeyuYHkp/dbEYH5qZZ2npmBtm8avAHLL64BZ/BlXnA
         kwKDJKwzntNGiGaiMVUWvaIxzFZboyFrm4jRvSRzgL5lWza83orLX+OX+N4RCNTiEat1
         14SHyYKQHJxOYqpIbfRMGiUFgWIh4blNZwhfDjWEMSUHPVd7n4EkgdaDrQT5uz7QqSZN
         pDVcv5kmWG24GPvoaFUgg1pokpZaY0mcaIhgdfbqg0ZCbZB3iThpW9bLqoXFUx4pAvzO
         SRWbSUGjgW5OuXB8libbn2jwx1903F6KcSFW7BSJBPjkcrYro6FO8negxTW69RMrX/cS
         q9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764954731; x=1765559531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKtvRnZXXEkJadMcjlPO6UUmkCEVjlrlMZ1C1H0q9gg=;
        b=Il6VEIG8w7eYpJQ7hEWSCgqyoVC0zbj99n5w/+9/McsffztetixiLLG0UIONoeIgs2
         uOWMWWTFDiREhSfSXWX0Ns0BOojZv2KgwvuJK5Vq56LVahA1BdOlJZDZRhbpeZ4A6jjk
         aOQjQZ3PQawff0xyavgnnlA3CMB8be579/4/3qz/8XCCRmU6FNUZFSe6uQjbpeNSyErT
         LkAZcJVmyibTgOe1MB2FzegoVfNBw2CV1Ex6PtnZq5IUSY0MbOkQYHdbQk6ABIQoB3iL
         UPb4BKatwSZdFAqJIzd74Yt+17rVWI7K9JHPzUmtzp/43F1wOt2HY9a7aVmvD0883Rut
         J6fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVymhFobDOCOhABXJzkIRtalNqhiA5X4fvcUtPR73cSs31MOU4kkFuN5s6ejEwBfyWQNuJ4ifQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8DWJlnhiFSpRf6F8iLM/x79tp6KzGOaJOskqiWXT84n9LVyCp
	cdl4GUAH59oxmKabH4UNgh9vWQFzjocgYyHCrrZ35g59zCbo0segndvf
X-Gm-Gg: ASbGnctOjMQey8JZqEVDZaGtLdj7MVyC8AWS19JKm60Cvuf6OS7Xbykrb9Dw4JQxBNP
	o0+NRN0oszb6IaIkTkdYT58HUnW41nxQBV5h8Vah79Y2V7d0lLKo8KUzUNpsRKLgWeyN6lGxtnQ
	SFGNFQLKkE0Qo1fQuqNVjStz4zRUSMwzxQsbQn0U79MtNhcos37/mmkP9uTWLHRQK+Ed12LPc0f
	fbrBdu2LJxcxNutJYfrDdFsxUVNDz2Wd79PgZu4HpF6tkkOm4RRD91TFirC+hI56k+KvY4UTQL/
	bRC4ChJloll91cNumG+VV07pgVkGSIVQVKS4p4mOcyycGMEUubXg0LLLNNnq3FDokmUaLB+EPud
	rra2xnbMzx7YWOlucDglLZgQMDu80r23/pgaggDRWnigkEnY3vC1sNpnUxiKdRPc2JhwnMjsp2z
	Wlkeh1UtjbRIhR5dssmAOrqsg=
X-Google-Smtp-Source: AGHT+IEr1nY1dhYbPFblTm+sfB+BT05pWYr0So+DnBf2OW6AgkQWCY6GZ40JgzwGeLxSF5IGH5l44w==
X-Received: by 2002:a05:7022:2218:b0:11b:9386:a3c0 with SMTP id a92af1059eb24-11df0c505admr7292285c88.43.1764954730772;
        Fri, 05 Dec 2025 09:12:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2eefsm19408192c88.6.2025.12.05.09.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:12:10 -0800 (PST)
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
	Guenter Roeck <linux@roeck-us.net>,
	Adrian Reber <areber@redhat.com>
Subject: [PATCH v2 01/13] clone3: clone3_cap_checkpoint_restore: Fix build warnings
Date: Fri,  5 Dec 2025 09:09:55 -0800
Message-ID: <20251205171010.515236-2-linux@roeck-us.net>
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

Fix:

clone3_cap_checkpoint_restore.c:56:7: warning: unused variable 'ret'
   56 |                 int ret;
      |                     ^~~
clone3_cap_checkpoint_restore.c:57:8: warning: unused variable 'tmp'
   57 |                 char tmp = 0;
      |                      ^~~
clone3_cap_checkpoint_restore.c:138:6: warning: unused variable 'ret'
  138 |         int ret = 0;

by removing the unused variables.

Fixes: 1d27a0be16d6 ("selftests: add clone3() CAP_CHECKPOINT_RESTORE test")
Cc: Adrian Reber <areber@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Update subject and description to reflect that the patch fixes build
    warnings 

 .../testing/selftests/clone3/clone3_cap_checkpoint_restore.c  | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 3c196fa86c99..976e92c259fc 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -53,9 +53,6 @@ static int call_clone3_set_tid(struct __test_metadata *_metadata,
 	}
 
 	if (pid == 0) {
-		int ret;
-		char tmp = 0;
-
 		TH_LOG("I am the child, my PID is %d (expected %d)", getpid(), set_tid[0]);
 
 		if (set_tid[0] != getpid())
@@ -135,7 +132,6 @@ TEST(clone3_cap_checkpoint_restore)
 {
 	pid_t pid;
 	int status;
-	int ret = 0;
 	pid_t set_tid[1];
 
 	test_clone3_supported();
-- 
2.45.2


