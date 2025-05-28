Return-Path: <netdev+bounces-194034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4386AC6F3D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5D4503807
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB328C2A9;
	Wed, 28 May 2025 17:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DD91DE881;
	Wed, 28 May 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452836; cv=none; b=c8LMTf8Esa9n/vAgXnzQ9kna2leZvAXvnzdPtQRkhesfaVO3Qvj8zZrA94/DVtA58CFfQqXQnbrbfhoPYa6i/u5Sh989h6oK/gw0XVG2THB5OVTmEyqFAFdbF8zhhpqA7jDvs/9b/OYAU/RovoO/kuRJJtGCbhnktmMW/S/LVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452836; c=relaxed/simple;
	bh=Nc/nMZeliRv4e8jKOEEg08tp355xW3KIhShYLVQJYh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z6+WZBirNmeXCy7flqpXFhAijtNP/mjwzY/A9XaW3xGswjSk4b/f+gjcVlMXPjqhZK35rwRWxB0Ga9eQbc5ZwdF/ElOSK4yhNJcFvd2a4US1wRq43EhiwLqDgto89CUIYd8CQADaAxVoYbQ1go7K7d9a70UzWXccJFVocQSlwng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so791715266b.0;
        Wed, 28 May 2025 10:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748452832; x=1749057632;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gD88t2eyCZO/5777P2Z9x2ty4BaqKSaCKMsGFXhbCbg=;
        b=jfLYKGxvq1ZtTAkOAnjIyUsa/B7JMUoYisSHSlx3KhksEfMTB4vLfIuY/X/c7xGAsq
         nfF3SxI9DWT/+13cUX7b6F8JpboNyesMEH2XBl7HFC8GNdn6BRDIvBpVma1klSA22/ZF
         SFeIv+5r2rxgyW267f8UpkVC0m9S7zUyV5j31j90xLEP8X1fOR+XRrocdSvXQLgssoXC
         8myj5BoMKFqWRasfjShi919h83St0A59DSDy2CBjWBj9s3itncOXWOYRFOPdDIqGTuHT
         /lMDX0UfN5rH+bX5SArLzlaaipyd8a7/QGPKgA0M2PpcY8MahWDGgpGs2dF9ZHXTV609
         y50w==
X-Forwarded-Encrypted: i=1; AJvYcCXMB/cLd5x3ZCB4j6M0zP/+XmQBifRQuSHz0aBovuG8CGdWOcX1KwZ326Ofn0bQ9G0di0CheIOL4q/OFLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPAQI2+mnd5tV+n2sh55G01DmKPEqCKpGCWQkewaRUFGVtuIwI
	9V1jMytobQHfwosdaxRfOFDI8Jh2s6bSEqoGKY1lbKlsPgfQbRCjqi5I
X-Gm-Gg: ASbGncsZdFmkQjWL1iJWgy0FW9Yo8dcxGSppzc2/hf5eUH3Y05xLHzwtdWvXItVdFMU
	VqIZfl+EZ8PTzZCNcvUkcZW973E2A9/PE6ph64fCz1su5NSDiDEIgBjaLglhasu1aoRhBw9qxC1
	S+1lfpcgV+dkcLOwk96MVFS2zjOXMMSpT8ya91+2mezsGrpA4ModVEdAQYbb/e/XL7zEJYj1Snr
	WKQkfFgAxgdLkcYu2b2xi7d6gJe7MhijYi9yzMaVONtWjUgeE8uyoS4mxdp29hZHqG2U7xvV1JD
	vQ/jUnoGvpiKYNIU1sD3nN+wzOO/bugYHtqbnv+LEnQ=
X-Google-Smtp-Source: AGHT+IH1tkNhloKTswvNP9DznVd3mozAf84F0gu9cP+flXKpKwwxdMdXhMPeKnfVoe/0jGfVPsY4Hw==
X-Received: by 2002:a17:907:80b:b0:ac6:fc40:c996 with SMTP id a640c23a62f3a-ad85b1844eemr1504769566b.23.1748452832051;
        Wed, 28 May 2025 10:20:32 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:45::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a19ca429sm141030066b.64.2025.05.28.10.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:20:31 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 28 May 2025 10:20:19 -0700
Subject: [PATCH net] netconsole: Only register console drivers when targets
 are configured
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-netcons_ext-v1-1-69f71e404e00@debian.org>
X-B4-Tracking: v=1; b=H4sIANNFN2gC/x3MQQqDMBAF0KsMf21AB9JqrlJKUfursxlLEoog3
 r3gO8A7UJiNBUkOZP6s2OZI0jWCeR19YbA3kkBbjW3UPjjrvHl5ca8h3nXo9dYNE0c0gm/mx/Z
 re8BZ8TzPP0Dcx8NiAAAA
X-Change-ID: 20250528-netcons_ext-572982619bea
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4911; i=leitao@debian.org;
 h=from:subject:message-id; bh=Nc/nMZeliRv4e8jKOEEg08tp355xW3KIhShYLVQJYh0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoN0XeUHRF9BbXK9TkDn+MghzEG8ir18PoMRFF0
 WtMaqyu5CmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaDdF3gAKCRA1o5Of/Hh3
 bSlCD/9OW/IgYOGk0zptuLACY8gb/eF9pcglRbFEdqa5ANhZs6mVEo5uu45h7r572e3BR70K1Le
 SHhxmsBO/XXNbwLYlrcoR9Q3yBUZxxFHOJ0ZYqQU6doBYbFg0JRAO5qSXc6wART8YvQHtiVwZEI
 sw2PjyaSpSmPEfdGJf2h9ZbleLPGpzL6hDLRWt4nfP+rF6w8KNs9k12120jPFw2Iyohn/OuyyFv
 i+AmUFYkFPljMs5wF9Z7hDm7vcZyT9hEtoewMtMUBUYlE7Xilb5l2mCfALgoMs4ggawGggWj/ks
 8BHRcIHSK4Bi83jqZAyG04j/vj/7svS1Czd3EhIKLgPM2dH2TVJHHAjxoM/Yh7/n3uDq4Ad2omf
 VK8/F+vlAC5FLPaIYYJBhhSJ6kd237hY6YADGYd4l0fVsChglCVBr6KgwzM93KSG/J51qDnIEEH
 JJR3492yJqgDjPKnaOHqtEKY7BA5RcAe+iWG/MB3kBLMvuFvnHnVPCRZRj2TcvMNJ/2ZGIbA3Zx
 NsrNUfunO/GkaVz/Jly2AiOX0X0wsRtuiOJh3IU96WhP7ZTYnnfYakUMRMOkltUoMg1QbK1TxoO
 Pr1mkK+rbir+io+6jJq7M93KnAkqACg3saIw/+t6UrzyYKod1QYxsgtlyMNhflYmcyXiWm4oHJf
 KejWOSURJ0jRUqg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The netconsole driver currently registers the basic console driver
unconditionally during initialization, even when only extended targets
are configured. This results in unnecessary console registration and
performance overhead, as the write_msg() callback is invoked for every
log message only to return early when no matching targets are found.

Optimize the driver by conditionally registering console drivers based
on the actual target configuration. The basic console driver is now
registered only when non-extended targets exist, same as the extended
console. The implementation also handles dynamic target creation through
the configfs interface.

This change eliminates unnecessary console driver registrations,
redundant write_msg() callbacks for unused console types, and associated
lock contention and target list iterations. The optimization is
particularly beneficial for systems using only the most common extended
console type.

Fixes: e2f15f9a79201 ("netconsole: implement extended console support")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
I also have two other associated changes that will following this change, but,
I will keep them for net-next, keeping this patch simple and more
suitable for 'net'. These are the patches that I will be be proposing
once/if this one gets accepted:

1) Expanding selftest to test basic and extended targets. This is
   a simple test, but, it requires some rework in the netconsole
   framework, which is more suitable for net-next I _think_.

2) Disable console if all targets of the same type are disabled
---
 drivers/net/netconsole.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4289ccd3e41bf..01baa45221b4b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -86,10 +86,10 @@ static DEFINE_SPINLOCK(target_list_lock);
 static DEFINE_MUTEX(target_cleanup_list_lock);
 
 /*
- * Console driver for extended netconsoles.  Registered on the first use to
- * avoid unnecessarily enabling ext message formatting.
+ * Console driver for netconsoles.  Register only consoles that have
+ * an associated target of the same type.
  */
-static struct console netconsole_ext;
+static struct console netconsole_ext, netconsole;
 
 struct netconsole_target_stats  {
 	u64_stats_t xmit_drop_count;
@@ -97,6 +97,11 @@ struct netconsole_target_stats  {
 	struct u64_stats_sync syncp;
 };
 
+enum console_type {
+	CONS_BASIC = BIT(0),
+	CONS_EXTENDED = BIT(1),
+};
+
 /* Features enabled in sysdata. Contrary to userdata, this data is populated by
  * the kernel. The fields are designed as bitwise flags, allowing multiple
  * features to be set in sysdata_fields.
@@ -491,6 +496,12 @@ static ssize_t enabled_store(struct config_item *item,
 		if (nt->extended && !console_is_registered(&netconsole_ext))
 			register_console(&netconsole_ext);
 
+		/* User might be enabling the basic format target for the very
+		 * first time, make sure the console is registered.
+		 */
+		if (!nt->extended && !console_is_registered(&netconsole))
+			register_console(&netconsole);
+
 		/*
 		 * Skip netpoll_parse_options() -- all the attributes are
 		 * already configured via configfs. Just print them out.
@@ -1691,8 +1702,8 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	u32 console_type_needed = 0;
 	unsigned int count = 0;
-	bool extended = false;
 	unsigned long flags;
 	char *target_config;
 	char *input = config;
@@ -1708,9 +1719,10 @@ static int __init init_netconsole(void)
 			}
 			/* Dump existing printks when we register */
 			if (nt->extended) {
-				extended = true;
+				console_type_needed |= CONS_EXTENDED;
 				netconsole_ext.flags |= CON_PRINTBUFFER;
 			} else {
+				console_type_needed |= CONS_BASIC;
 				netconsole.flags |= CON_PRINTBUFFER;
 			}
 
@@ -1729,9 +1741,10 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (extended)
+	if (console_type_needed & CONS_EXTENDED)
 		register_console(&netconsole_ext);
-	register_console(&netconsole);
+	if (console_type_needed & CONS_BASIC)
+		register_console(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;
@@ -1761,7 +1774,8 @@ static void __exit cleanup_netconsole(void)
 
 	if (console_is_registered(&netconsole_ext))
 		unregister_console(&netconsole_ext);
-	unregister_console(&netconsole);
+	if (console_is_registered(&netconsole))
+		unregister_console(&netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
 

---
base-commit: 09f3b8c9790e29e70c9c3e0d4a9a4bc70a625b60
change-id: 20250528-netcons_ext-572982619bea

Best regards,
-- 
Breno Leitao <leitao@debian.org>


