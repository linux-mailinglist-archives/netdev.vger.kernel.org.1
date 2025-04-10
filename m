Return-Path: <netdev+bounces-181085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9B6A83A57
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66087AC79A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE42B202C26;
	Thu, 10 Apr 2025 07:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgZBvtQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8E1204C1E
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268975; cv=none; b=W9iuc7W+1Y/kvrKK65pcVd0GcBMQeRs6vQsP3JZ4YM8M+qGx9/cJgV6TrFeVVN6xYYtpPsV8BLJTi74rf7GxG+okyxDPBB4/MgYmsg2FaCAE9WrOiIrUWM7QblxpIEy793JxNKYjRe3kh4cwSlI5p4lUVxiO74hidGaGdpotJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268975; c=relaxed/simple;
	bh=ZdRabb18Zu0sC4OY0YF4GbVOmmdmxft6odqkRX7ZvMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJy12NG453KYEpR67PzBXYxMGIpAt8hkptZaU71JTH3GQ36vtxLlAYUvIpgCHYQKx0/KdRoeVMKAArS07THRNQOc4su0XNbpTdGzAqzjZP0BaR7lboF63v81wm6kJFhx6IeM1v40+Ygg+hV7xU7+Ub/0pzHrlbJxGzo/lXKmZjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgZBvtQZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso3204535e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744268972; x=1744873772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTTpOJ0JhdYbtpWXm6RJBf4irZrdnE+cHphQPXX0dN8=;
        b=UgZBvtQZPagwVy7lbx0dhO3Uv+siVtHylegC2D7Z/p+L6TYONsDxEz3AdZWu3wEUDg
         2YtqXsYCXJ3Ta7RCg0B2adAbk/yWMUHQSXPmx6fhfPYv4ob43uGl0Sums1maFAdUwF0i
         ZgjwuIexSMNuQUOPuDp1GZQuhic7huizreRPuvRcUSckGX0DlEOTB4XMU0qNCtYS1Sul
         QHPF0LQxpVNwEhXCC/9Sesh1pwRBnKrTM8/Is9901Hs5OBxcvIECkUcL5hCpbxPnEjbS
         OSBmLASIrpqJ9fe4MQptLG+YNJ08I6L+SKOKJ0+7ke/68GYCW6OwQKSM5RBiwBPj42st
         gGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744268972; x=1744873772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTTpOJ0JhdYbtpWXm6RJBf4irZrdnE+cHphQPXX0dN8=;
        b=wpvQDWBiczaec4oPEXvKqMa++GMjNaceG11Kr+XPTnF/i9spbhWFRK2SEn8/CWqCC4
         EhDPKgJ45e//R3ci+Yfx8NJRXtD220KgT/4aTDba8bFqbBs05CG+zgrNGWHAYpCbAp6a
         BQi35MrcP1eZ06bmyb377UDQZoguM3A8RWXs8uyNYAnwmbjYMDWDNUi1MBYuDfRN6X13
         wGTY0CQ2gEQLWLuKaeGPlfc5EQosN0p126fetuVgbMDLm2WhuSb70anJfhIjVn8IKJBO
         6baZw7e+aX5IcGUUWc/xDyOV7Ac7TVr5bCa20M+fxKXKUmCPkN773HNnxGmMWyQf/qlh
         zT3A==
X-Gm-Message-State: AOJu0YwX0I0MkkuljrWhRE3V+26VPpqoWAxYiOKuFKEkANTFe8FYO9VD
	e1BXID6i1CGTYWK5QwACy+/Xk7vysFcyUZ0RkQcvewOlKY00c/orRfYkm8jq
X-Gm-Gg: ASbGncvEPGEcBpkdRKGDqo3vjXXgSwWlmOju0gGH3Gz4PJ5uhnkAyKNbDqXJ2ejQZEG
	Qg2MbnGljFOgFUuvwczFPjNkjp5vZkbjNSDoJJYdmkvd7ecFgLee0kRySHnU6NrBwk7LOhefBbD
	05/b2zPoJ/5UgFfX+lBeY4N8m9fJ5EDwpaiVYvxXVh733bJPHV1k35bvbP/2uILR+B/oq7/4pX9
	xItiaL6iEvhHXbZSoFFu4m4P5Yv4r9JrnbCb2wbjf2YeiULj5ZzDEzhET1aKDekO0+fcfHmF6UZ
	1n/p3j7KnPGkwv3GmUROG35nv/HQ1kC3y35lWsg=
X-Google-Smtp-Source: AGHT+IG+jlhHrf+5d8lGRA0eBSAkUQXXizElCUxr3HM352KIzxjzNZ9Pu+SS4vatJ5e2Cw4OxkDvfA==
X-Received: by 2002:a05:600c:b90:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-43f2d688b3cmr18947315e9.0.1744268971559;
        Thu, 10 Apr 2025 00:09:31 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:44::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2075fc99sm44959255e9.29.2025.04.10.00.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 00:09:30 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jdamato@fastly.com,
	kalesh-anakkur.purayil@broadcom.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	sanman.p211993@gmail.com,
	sdf@fomichev.me,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next 1/5 V2] eth: fbnic: add locking support for hw stats
Date: Thu, 10 Apr 2025 00:08:55 -0700
Message-ID: <20250410070859.4160768-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
References: <20250410070859.4160768-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds lock protection for the hardware statistics for fbnic.
The hardware statistics access via ndo_get_stats64 is not protected by
the rtnl_lock(). Since these stats can be accessed from different places
in the code such as service task, ethtool, Q-API, and net_device_ops, a
lock-less approach can lead to races.

Note that this patch is not a fix rather, just a prep for the subsequent
changes in this series.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h          |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c | 16 +++++++++++++---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c      |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index 4ca7b99ef131..80d54edaac55 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -81,6 +81,9 @@ struct fbnic_dev {
 
 	/* Local copy of hardware statistics */
 	struct fbnic_hw_stats hw_stats;
+
+	/* Lock protecting access to hw_stats */
+	spinlock_t hw_stats_lock;
 };
 
 /* Reserve entry 0 in the MSI-X "others" array until we have filled all
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 89ac6bc8c7fc..957138cb841e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -203,18 +203,28 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
+	spin_lock(&fbd->hw_stats_lock);
 	fbnic_reset_rpc_stats(fbd, &fbd->hw_stats.rpc);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
+	spin_unlock(&fbd->hw_stats_lock);
 }
 
-void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
+static void __fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
 	fbnic_get_rpc_stats32(fbd, &fbd->hw_stats.rpc);
 }
 
-void fbnic_get_hw_stats(struct fbnic_dev *fbd)
+void fbnic_get_hw_stats32(struct fbnic_dev *fbd)
 {
-	fbnic_get_hw_stats32(fbd);
+	spin_lock(&fbd->hw_stats_lock);
+	__fbnic_get_hw_stats32(fbd);
+	spin_unlock(&fbd->hw_stats_lock);
+}
 
+void fbnic_get_hw_stats(struct fbnic_dev *fbd)
+{
+	spin_lock(&fbd->hw_stats_lock);
+	__fbnic_get_hw_stats32(fbd);
 	fbnic_get_pcie_stats_asic64(fbd, &fbd->hw_stats.pcie);
+	spin_unlock(&fbd->hw_stats_lock);
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 6cbbc2ee3e1f..1f76ebdd6ad1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -292,6 +292,7 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	fbnic_devlink_register(fbd);
 	fbnic_dbg_fbd_init(fbd);
+	spin_lock_init(&fbd->hw_stats_lock);
 
 	/* Capture snapshot of hardware stats so netdev can calculate delta */
 	fbnic_reset_hw_stats(fbd);
-- 
2.47.1


