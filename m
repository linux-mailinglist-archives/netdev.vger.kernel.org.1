Return-Path: <netdev+bounces-163941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10AA2C23F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBC2169DA1
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 12:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ABF1DF725;
	Fri,  7 Feb 2025 12:11:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EE2417C7;
	Fri,  7 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930318; cv=none; b=YdvDfiBP91Vfr4sdINB7ok56Uyi3cZADqp4NCg2B6DL3ht2iQj2nscX83cPdluyKjLRgLAgdTtqItzjLLAvWtKV8oGVaF9nfjdQK6zHF7YbFjza9Wm3bNMn8tSSnGkKmqvgaKXZDdVvvohhh1CgOVVoM6iK8b5LbF0J/r/qcQf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930318; c=relaxed/simple;
	bh=Ll3dxUML4y6ZQQh2Iv6OscNZv5RDJ+EQkHjfe/iByKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k0Zgh2JIhoH2fW72+N4nPUG85BopAuHVl/s4vQOw+SxkCRAyK0F6zHR2pWAMmkJCBgxcs6Y7M3C+EIfYrDNWABjhueAxcsLp7M2o6h+JKqOozKlCGvA34I/Tf/iEFa50jEm+KiL2LZIMPDJQvvyvpOWwhgN9Z6bp0gcIATdcwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaeef97ff02so348603766b.1;
        Fri, 07 Feb 2025 04:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738930315; x=1739535115;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsxP7EqkW7P33SSUxO3dtpPHBiQBsrqgjhAIX/9EzSE=;
        b=JKhLcwHuWoyfMObFvVPzQJBsYvoeDNB9H/iNmayyD0bbCigf4SrgiZnNwxKCPFMf7m
         2zB9fYpPsV5ixi0DcQQ1ZR4VkuY+pcytvxKncsTMP1HN2cQO82zyCELYLQOlqmv5eatH
         od6c+aPI/cSFFuLZKK/Eo4NIZLTKQ22c/HcavgFzEYjwEM9x25qppmjANCHQhBc7S8xo
         aPYj5FbiPfMZ4Exdu+umAmSBZWKROmu1DtbXgsCQgRzG0SLeJIRmnYbUwQnO8qach34E
         aPk3ystH+sPxZGBym6BBzIHAjH2WiqVDsuhGn9Xumte3zkFzi9TkfZeCFEKtZPWbUm1u
         quVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAeojqGg7MgIuWL4nXvVZbPaa0zXfIeCS2o26OoXWiLkxBhjmCIbeCi4lrQ3JBnW5sf1zFPjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybsj9ad6X4+A4fA65rqhqNiEmhdxuaj9z83fSvL020PIqqmDDi
	lfUVptDihqUAFas5eVB/gSi9ZrtTbe8FC1Gc51xcmOdxI/ZAkH3O
X-Gm-Gg: ASbGncv/gaiKkXd7XX9B2JtPD3Tm71UW3jZEInd7fBJqFKIZRhrpQPa5PbmLucbd0BO
	TdBZjObTsbiUEHuqPGSYmhzavMytrM2BFArvId1bgXhT6b/Fd1RKulfqPcdJwH+ik6DlfEERRt1
	Tu2XEZzq53cqcWSHm9tnYVIlPXwx8NFo6CGr3KvUoYUvqeVkNvuOM4AfsXqcnskWiyoKFpfUs4b
	qFhS9dCLJtECwlXkmV9zSgXRk5eEQ1MneaqsD9s17cY3Pgd7En5fIqxSgvXBojyp07WPrN8FACI
	wS8y4w==
X-Google-Smtp-Source: AGHT+IGyMvm4QZSm5TwWC03zC7HkVHovRxMnBlWjI3qW3nbEII4YZeP6KXA8u5PoBBhGkYMHQbENPw==
X-Received: by 2002:a17:907:c285:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-ab789b22c86mr314357066b.30.1738930314423;
        Fri, 07 Feb 2025 04:11:54 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab773339349sm256408266b.146.2025.02.07.04.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 04:11:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 07 Feb 2025 04:11:34 -0800
Subject: [PATCH RFC net-next] net: Add dev_getbyhwaddr_rtnl() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-arm_fix_selftest-v1-1-487518d2fd1c@debian.org>
X-B4-Tracking: v=1; b=H4sIAHX4pWcC/3WN0QqCMBhGX2X81y62WYZeBUEP0G2ITPepP9SMb
 YghvnvkfbeHwzkrRQRGpEqsFDBz5MlTJXQmqButHyDZUSXIKHNSRp2lDa+m56WJePYJMUnAlK7
 t8tyqgjJB74Celz35oPvt+mMeSXosiepM0MgxTeGzL2e9a//rs5ZaKlcArTqassTFoWXrD1MYq
 N627Qv+PS2rwgAAAA==
X-Change-ID: 20250207-arm_fix_selftest-ee29dbc33a06
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 kernel-team@meta.com, kuniyu@amazon.com, ushankar@purestorage.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ll3dxUML4y6ZQQh2Iv6OscNZv5RDJ+EQkHjfe/iByKM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpfiI69v/HRwhpN0AMwEJZerttK0/+ReZL4Q2u
 ZDknJTcXNGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6X4iAAKCRA1o5Of/Hh3
 bf1AD/9wZX9vQauQG+h2D83v98qMs/1n0I1k/5sd8AVcpjAjitRLt+hHA060Sn7Rf01HyZCzcBG
 D73BMG8JFA9Qa3oy+CcHTbsq89hZtyMogbw7npLr5N8Of/SnkI2sZ/yh09w9HARol6r3aXbKmAE
 3QK7vXQUYdeveASRcaAJwWCAowzzI/1JmMpnh+bgEoD0ZCbw64q7pb4j6ZkbJo3foR5RXp4mH1E
 rCZw45zCMk65Lnn+jFTn/kPC2cpFzsLxJwVX0N3CTv1yfzyEfe1sI3Wubxg5r2tvHX/s6HNPegZ
 UpE7jos07Deq7VVp9g+tRYMGesjD1nn1i4l6lSWFruY+OgvxLeqMs8mrQtze8lofSKm+LKnthi0
 mx2Bp9wRMKywBbSWIRSvs4DhnJseT1iIqLgqQnqzGvjnH5/qB8zlFQCz6ulu4o9q0lCVqG3Ld2m
 FeOYmgP2tlGgA03eGIitv9JoZya9/CusjVoE/68OcLEQOXOONcu+5HzOqx6Afh3fOZssxTDz0nK
 5XY5+RpMbo6ZbhnPifBaOPDed06E8Wy7cnLOr4mGSLnjqczJ+upblOiy98biik3MoQ5SRhfo1bW
 9CB/TJAIaeomU8/A0T0JZ72pzw1MkllhP5T6ivh6EWwQq8Y8iY3YNYpXk0PQt6r+OWUJCGoIdvo
 f1O133/JJDNTo+g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add dedicated helper for finding devices by hardware address when
holding RTNL, similar to existing dev_getbyhwaddr_rcu(). This prevents
PROVE_LOCKING warnings when RTNL is held but RCU read lock is not.

Extract common address comparison logic into dev_comp_addr().

The context about this change could be found in the following
discussion:

Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/

Cc: kuniyu@amazon.com
Cc: ushankar@purestorage.com
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/dev.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c41d1e1cbf62e0c5778c472cdb947b6f140f6064..75f0c533ff10e7188aa55345cd8140b88a7d09ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1121,6 +1121,16 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_comp_addr(struct net_device *dev,
+			  unsigned short type,
+			  const char *ha)
+{
+	if (dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len))
+		return true;
+
+	return false;
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -1129,7 +1139,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1141,14 +1151,37 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_comp_addr(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ *	dev_getbyhwaddr_rtnl - find a device by its hardware address
+ *	@net: the applicable net namespace
+ *	@type: media type of device
+ *	@ha: hardware address
+ *
+ *	Similar to dev_getbyhwaddr_rcu(), but, the owner needs to hold
+ *	RTNL.
+ *
+ */
+struct net_device *dev_getbyhwaddr_rtnl(struct net *net, unsigned short type,
+					const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_comp_addr(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr_rtnl);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;

---
base-commit: 0d5248724ed8bc68c867c4c65dda625277f68fbc
change-id: 20250207-arm_fix_selftest-ee29dbc33a06

Best regards,
-- 
Breno Leitao <leitao@debian.org>


