Return-Path: <netdev+bounces-159492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4CA159DF
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 00:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D84997A1FF0
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F141D5CCF;
	Fri, 17 Jan 2025 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBKC5pPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20C195811
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737156079; cv=none; b=qQuYa6c7eDyReF+2nmc37Zy9ahh3Z7Hi/sqrJPpJc9Z5SeReiY1A8uIZ6bgWwSrezsPWPYa9TAHnxrqvp0sEtba6C/laIXNyy88SAx5vp6F28lPDo5ZQYAnad9CpKSVN3yOT9DOCgSCILj7+YfYdjX7HnHkEimzqGfXEmOcC3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737156079; c=relaxed/simple;
	bh=+CjgwEnVKFs2rfMYQbntWFwEhLgTXScYBH39Q9295aw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IlMJpOPySKux59ZDXHIBoK00R+79ktCH94WeGP5QspZps70AQrLLHd6YVmdppy7lABAc2IAfXd3hyoKoSjz/O4Cq6OyMUh2p7qcDLZCqxYTcqbalEPVOO2wMoMbOtCKIE3ZJ827jAqLc2kMF158IaERMyRGE9LHJvzkygv2qAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBKC5pPG; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6d88ccf14aeso45951466d6.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737156075; x=1737760875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mm9+wSDaDbX2e04QhfXPQEtYAf6g+cTEQQPcsHrHNEs=;
        b=WBKC5pPG1eENe5TEoUOGP3VrG6RttcJhOcfK2sreLkWL0bOW+bSHQA5aEKqSwB0ooe
         PucvlrrXtglSzDJxTYnecF0cWRnB4R6Ngh+8EC6vfUR87bp+IIXqpryALb5gi+vXzko8
         +2jb9dtEsdKubWsu9D5wNOxCYkrShrGuOZ92AZk+tQ7x1Ifz+PdUAsrADUOXWTQryJJT
         DU2AbJZUsQ2/ec6E1b9fx/aEFE6DTbyXMnoMmGFwVN0hVJ4vaAcmkYfuRulE9Q9iV3oZ
         X2HjBaBxwq07rGboSO6BKwU7RswH+0P3vWzDNjgQ3AS5ybXM+z9sFhbJMLCHMMEa1Y9y
         bGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737156075; x=1737760875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mm9+wSDaDbX2e04QhfXPQEtYAf6g+cTEQQPcsHrHNEs=;
        b=q6elmmV19Pu3ZNMGV/XXUNVrw0sbWY/QKJpFAfbhp37faDzNVzX7B/l9by2+cAGvR7
         1DZGKH7tNU04Qxst14EKfGtIWKRi6tjqYzV82XEaXmqpxV8adw4ALuwaBqagAnr7ajuA
         AAnawYf7GpQNbKsaXFSwQVBxw5uVO/mUrFHXJs04IHhxduL+PRpekhabGhO1vJEeyk6P
         pWSbVJ0sPDDGFd96Bdu+2WxCn9gRgfSnZ9z6Eys9ng4trXWDGpdXJx6tzzIDQtLYlOZa
         9jXm8hOZF06u/+U8EwIieV4Klr0A44nxbN9bkS2k0krN8R6fQ7AUpt1m3rGHTNmtga1O
         GO0Q==
X-Gm-Message-State: AOJu0YzHeU2rhrNT3kV/j8xaLjr4CkVzK/jZ9MYHVhzxfRVZlM6TNxRj
	KrYT8c1pzTOU1PRPa3c010s6cz5Gg8gNb6Nnt+TJ7CNRN7tWhUswPh4UovbJIOcKgD4MZL/8OdF
	UrW/Ky4JUPg==
X-Google-Smtp-Source: AGHT+IEI4gr6DOTLwAaFp3hkCwytuO5yXcoQ5wdAORZ/A5+BnXazCqhOPO5jHFQeK9EJiq5LBDFWMzw32hr2wA==
X-Received: from qvbme8.prod.google.com ([2002:a05:6214:5d08:b0:6d8:ad87:b23])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:226a:b0:6d8:a148:9ac9 with SMTP id 6a1803df08f44-6e1b220e57dmr69743536d6.30.1737156074794;
 Fri, 17 Jan 2025 15:21:14 -0800 (PST)
Date: Fri, 17 Jan 2025 23:21:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117232113.1612899-1-edumazet@google.com>
Subject: [PATCH net-next] net: introduce netdev_napi_exit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

After 1b23cdbd2bbc ("net: protect netdev->napi_list with netdev_lock()")
it makes sense to iterate through dev->napi_list while holding
the device lock.

Also call synchronize_net() at most one time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fab4899b83f745a3c13c982775e287b1ff2f547d..d7cbe6ff5249a5c22dd7e0e4c929a535e1f28612 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11568,6 +11568,22 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 }
 EXPORT_SYMBOL(alloc_netdev_mqs);
 
+static void netdev_napi_exit(struct net_device *dev)
+{
+	if (!list_empty(&dev->napi_list)) {
+		struct napi_struct *p, *n;
+
+		netdev_lock(dev);
+		list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
+			__netif_napi_del_locked(p);
+		netdev_unlock(dev);
+
+		synchronize_net();
+	}
+
+	kvfree(dev->napi_config);
+}
+
 /**
  * free_netdev - free network device
  * @dev: device
@@ -11579,8 +11595,6 @@ EXPORT_SYMBOL(alloc_netdev_mqs);
  */
 void free_netdev(struct net_device *dev)
 {
-	struct napi_struct *p, *n;
-
 	might_sleep();
 
 	/* When called immediately after register_netdevice() failed the unwind
@@ -11602,10 +11616,7 @@ void free_netdev(struct net_device *dev)
 	/* Flush device addresses */
 	dev_addr_flush(dev);
 
-	list_for_each_entry_safe(p, n, &dev->napi_list, dev_list)
-		netif_napi_del(p);
-
-	kvfree(dev->napi_config);
+	netdev_napi_exit(dev);
 
 	ref_tracker_dir_exit(&dev->refcnt_tracker);
 #ifdef CONFIG_PCPU_DEV_REFCNT
-- 
2.48.0.rc2.279.g1de40edade-goog


