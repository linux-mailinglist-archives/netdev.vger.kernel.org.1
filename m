Return-Path: <netdev+bounces-243228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E78C9BF28
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 16:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D351F4E4163
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 15:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965F30BB8F;
	Tue,  2 Dec 2025 15:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D3A2690D9
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764689366; cv=none; b=VOzZUv8C6F2dqPGrvR10ZyE/7EvWazpNVRId6wF7fLdQzNktwhmOHw3c9kTtEKDaAXk7zF3ydRGrkV7qd6AGPZE+QPj3IgNo3wZXGnsQsFLzIWdcYNx9esL5efLhUYSzkGVtQbEKV9GiChJw6xlR8ktQtNQuIWf0oCyivCCdHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764689366; c=relaxed/simple;
	bh=eyYtZnjgmSj7N6JyucblyUpRgv9xinjZ9fEmb5Ogg7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=roONfYbn3g5gJ7lvOL4ot8r2Jdvi83c/by4zIp3+fgik2wX/Az7UTWubfpmisAsfJQh1QEzmpOLVqr6C3baiqDpmneKxrWOIggT8nq9j5ptY0UUECSp62MCVh78K//1Xnk9KbAre1Rq+pNbZpvYC3fl9cWQG2k50tDswzLx9CdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c76607b968so1796685a34.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 07:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764689363; x=1765294163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ugK9BzfdKEv5MeXevEgE8TqgctuA+qOiYTiah6FP+Do=;
        b=qkY/+5CabqWPaVgaQlEZ9DzL0Bd4yc0s/fLClXdc4Tfh1YGrtvrHNbjTj/cj/kM/WD
         a1HKY/WxjnOKBdHOy8qI9cGajDC8G5Uh+GkwqWvXp80kMH5x4zibuPpTBS4L25zMeyqE
         Zzpcf5Gaqu3M3oLVCeikgJzTYsJH9SmeXlHYX38mP+vyI3MEZDhi/WNWdvLbL02rsolF
         8s69F7pzKIPoIA7hXxEmB8u35EVAaprj3fIEYmAwsEE+NxsKiHxcGjIB47Db65UjCjC0
         YmisQ0APk2VIdgqek1LpiUKTXjIoGyjxZLPO+Sr4N4JNhTSghTbEAlBZaIMQglafajq1
         DWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOk9C7d/35Lh45YpH+tWNQemfZkQ0ykizFw88vfecJnhBR9a/lI+jxiVyghxJS7DBMzyK1UFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg7RuU2aaZCCr72+usmtUZUMkXj/cceQvVKi3a3H/ZWE4YxAsz
	o8BHoZ7Rw21Nb+uqoBA9FNO0JMHQ4XDPYooN892iHXQb/HMa+vNrY1a0
X-Gm-Gg: ASbGncuo62ejmA3J68Ac+Dnd2G+/YrWd7qIagJlpSAjXKQyi2FLNKw/xTy7HIv7ibDN
	MQk6yL+xUoBYVA9KoOWXN/7K+XHVBnUwAMxUU4RD2tn6s7G71YRkBIRXrAswXwKMaGs9PK5k6hf
	b1188vwKhPIfBbo6057RHYLbeeuYTGtoU/YQlhIPWbrLW3vnq9suRaE4BgPWh1kQ5JLX1Un5XWP
	YbzaChSMml9GdMemHO2zl8cXTrsc1QLUX19EjCWPwTOlkUqRA/ntACvHJmlu4Plr5NxmoZDsilI
	3oOpaURh4JXPHUKFvZNwmXYJ4I64aEPjEaXNWXibQxKBIi4r2G+wR0fT1WYTIvsIlUHzowBsdbf
	ixRW7smIbZOU/cIPAFCeOWuPUJlA6cfrvOWUIzcjBhvP8Hcv7r2TqGTA4E+dbMJuyIW3l1sSwcx
	SF+rYPqTYV6inw2Q==
X-Google-Smtp-Source: AGHT+IErDABErrz8eCfGq5kVn5Kh7bP3XcLtMbb4d6/GE178cI+lptwmXUf80rsCHF5p4DJECTSpvw==
X-Received: by 2002:a05:6830:2707:b0:7c7:6cc3:c3f2 with SMTP id 46e09a7af769-7c7990754a2mr22586092a34.18.1764689363417;
        Tue, 02 Dec 2025 07:29:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:44::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc2b36sm4259177eaf.12.2025.12.02.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 07:29:23 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Dec 2025 07:29:02 -0800
Subject: [PATCH RFC 2/2] netconsole: Plug to dynamic configfs item
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-configfs_netcon-v1-2-b4738ead8ee8@debian.org>
References: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
In-Reply-To: <20251202-configfs_netcon-v1-0-b4738ead8ee8@debian.org>
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org, 
 hch@infradead.org, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, gustavold@gmail.com, asantostc@gmail.com, 
 calvin@wbinvd.org, kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5215; i=leitao@debian.org;
 h=from:subject:message-id; bh=eyYtZnjgmSj7N6JyucblyUpRgv9xinjZ9fEmb5Ogg7E=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpLwXQ3amUSE+HhXNp0GO31IVPZZ+8x+ktGazRa
 D+XVOIxXu6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaS8F0AAKCRA1o5Of/Hh3
 bc5HEACRuXykG8FbGOoj3HGZt9DAr2MUb9t3kLnZdPKAfjAYgsdp7cLV9M6LiRHm5q2w3GdAOaN
 OfefGSTflmDd0anPvxBziInSd3MAESRFoUtC26/deD3EoYL6n3T4xTrVCLMOUljNrmZ5k0geVJj
 8u2yEZkrSw+twT8Ck+d45YsyivPmnguZWpOJ3dF5u86fjSqOV5KcNDgs0rz3RaaruryLkCwIXGU
 +dyyH06fTJ+/L9aTBGwrRllN/KIsXNOZThXoBZvAbrgw0dTNwUxp6PrjqyTiuYaIQGodTZrkdCQ
 zS2SUSfvjrRU99As4PL5k+F1iPUpl52P4MhCHiI4d7jtLEJ9QZ9FRHGxaUvLOcxwsnur4eL6KXz
 Gbh7A0C/C8n7xEAeNJAxa3CvW0qK6LaAjIpquF2Ed9tZJtFSjBaCkswLgPPwGVJKOFoQx012ZPn
 9cQlkV41sJ5ry6rllTmVkYpQbfBPu5DfLyY4NkT//YhCpJaJen3PVOPsTuKCyO2oIJH740xTaHH
 7u7TQ0mOvEoN5qEJ+MI6dlKLoAxezqY6P0WowbXFGANzTw+vNcIJKNSf5dgC6enD3Pt+Bl3dL8D
 xuFD7RWUSH/aGaLfOmc/N2A4q+3ZI7sNeZuuIs2DuOTUab1IXggte8dUIFoEPLxOm8CE2fAPTU7
 s870h6Uat1ccKXg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert netconsole to use the new configfs kernel-space item
registration API for command-line configured targets.

Previously, netconsole created boot-time targets by searching for them
when userspace tried to create an item with the a special name. This
approach was fragile and hard for users to deal with.

This change refactors netconsole to:
  - Call configfs_register_item() directly from populate_configfs_item()
    to properly register boot/module parameter targets.

  - Remove the find_cmdline_target() logic and the special handling in
    make_netconsole_target() that intercepted userspace operations (aka
    the ugly workaround)

This makes the management of netconsole easier, simplifies the code
(removing ~40 lines) and properly separates kernel-created items from
userspace-created items, making the code more maintainable and robust.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 63 +++++++++++++++++++++------------------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index bb6e03a92956..d3c720a2f9ef 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -225,8 +225,8 @@ static void netconsole_target_put(struct netconsole_target *nt)
 {
 }
 
-static void populate_configfs_item(struct netconsole_target *nt,
-				   int cmdline_count)
+static int populate_configfs_item(struct netconsole_target *nt,
+				  int cmdline_count)
 {
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
@@ -1256,23 +1256,6 @@ static void init_target_config_group(struct netconsole_target *nt,
 	configfs_add_default_group(&nt->userdata_group, &nt->group);
 }
 
-static struct netconsole_target *find_cmdline_target(const char *name)
-{
-	struct netconsole_target *nt, *ret = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&target_list_lock, flags);
-	list_for_each_entry(nt, &target_list, list) {
-		if (!strcmp(nt->group.cg_item.ci_name, name)) {
-			ret = nt;
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&target_list_lock, flags);
-
-	return ret;
-}
-
 /*
  * Group operations and type for netconsole_subsys.
  */
@@ -1283,19 +1266,6 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 	struct netconsole_target *nt;
 	unsigned long flags;
 
-	/* Checking if a target by this name was created at boot time.  If so,
-	 * attach a configfs entry to that target.  This enables dynamic
-	 * control.
-	 */
-	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
-		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
-		nt = find_cmdline_target(name);
-		if (nt) {
-			init_target_config_group(nt, name);
-			return &nt->group;
-		}
-	}
-
 	nt = alloc_and_init();
 	if (!nt)
 		return ERR_PTR(-ENOMEM);
@@ -1351,14 +1321,20 @@ static struct configfs_subsystem netconsole_subsys = {
 	},
 };
 
-static void populate_configfs_item(struct netconsole_target *nt,
-				   int cmdline_count)
+static int populate_configfs_item(struct netconsole_target *nt,
+				  int cmdline_count)
 {
 	char target_name[16];
+	int ret;
 
 	snprintf(target_name, sizeof(target_name), "%s%d",
 		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
+
 	init_target_config_group(nt, target_name);
+
+	ret = configfs_register_item(&netconsole_subsys.su_group,
+				     &nt->group.cg_item);
+	return ret;
 }
 
 static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
@@ -1899,7 +1875,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 	} else {
 		nt->enabled = true;
 	}
-	populate_configfs_item(nt, cmdline_count);
+	err = populate_configfs_item(nt, cmdline_count);
+	if (err)
+		goto fail;
 
 	return nt;
 
@@ -1911,6 +1889,8 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	if (nt->group.cg_item.ci_dentry)
+		configfs_unregister_item(&nt->group.cg_item);
 	netpoll_cleanup(&nt->np);
 	kfree(nt);
 }
@@ -1937,6 +1917,10 @@ static int __init init_netconsole(void)
 	char *target_config;
 	char *input = config;
 
+	err = dynamic_netconsole_init();
+	if (err)
+		goto exit;
+
 	if (strnlen(input, MAX_PARAM_LENGTH)) {
 		while ((target_config = strsep(&input, ";"))) {
 			nt = alloc_param_target(target_config, count);
@@ -1966,10 +1950,6 @@ static int __init init_netconsole(void)
 	if (err)
 		goto fail;
 
-	err = dynamic_netconsole_init();
-	if (err)
-		goto undonotifier;
-
 	if (console_type_needed & CONS_EXTENDED)
 		register_console(&netconsole_ext);
 	if (console_type_needed & CONS_BASIC)
@@ -1978,10 +1958,8 @@ static int __init init_netconsole(void)
 
 	return err;
 
-undonotifier:
-	unregister_netdevice_notifier(&netconsole_netdev_notifier);
-
 fail:
+	dynamic_netconsole_exit();
 	pr_err("cleaning up\n");
 
 	/*
@@ -1993,6 +1971,7 @@ static int __init init_netconsole(void)
 		list_del(&nt->list);
 		free_param_target(nt);
 	}
+exit:
 
 	return err;
 }

-- 
2.47.3


