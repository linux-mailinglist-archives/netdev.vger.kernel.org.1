Return-Path: <netdev+bounces-176912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8764FA6CAFB
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06C9880F2A
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A52232368;
	Sat, 22 Mar 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="JF+kS3VD"
X-Original-To: netdev@vger.kernel.org
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD8231C8D;
	Sat, 22 Mar 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654635; cv=none; b=ccefot5xj+APOyMXy/T+5z1xV+xndFrHYYIOjYdGcNG//wbTqX7EEytk+/llaLdaxVSeB+Cj9otJ+pFIgdOi8zi7FcoMdIT9GgPXeSIoVNJ0qQUZa4U0z06h213lA8k94lwvycs4IAi5KED1hTIMKut7ggO06djPoyxIb5IAcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654635; c=relaxed/simple;
	bh=qggIEZsshtzk5ZqyregSXIeCr9NJqLi9YiDh3SH/0fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/R/Mg3E2PvAF/jL8PsX/r57Cd+r1dABPlysXf0gH8bN42vaLqaIAhP7HQbyJH2ysFJrNGCJvh4+1AiZYHcJiyFaV1w5LVeNbRS8uvCQ2BJW4AdI70XRL8paL1FuzpDBObpzCu9A3gNs/cRmte/3tPSEOslZcg7RU22wG8Ir1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=JF+kS3VD; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ba8:0:640:2318:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 40D86608EF;
	Sat, 22 Mar 2025 17:43:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id ohNNUcKLguQ0-TIhrrKo6;
	Sat, 22 Mar 2025 17:43:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654632; bh=KWg8Xww8mrp7hhj55os237fAZ/UsT/lyer+cXtfBqZ0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=JF+kS3VD7W3+CHQmxkargs/h275aNoIoGFlFU1fFXSbshy89+ITbHObkcsbEmkQ3R
	 Q4UNssahbAyCCRPtEyR4F9pei+kQtraRk3RnCQubaoZ7vC5tdrLGoUTa9c/hdrHIi8
	 g7QDKKtHj6/cxIaOrSM3Tr0/+7Kth1fWO636mFH8=
Authentication-Results: mail-nwsmtp-smtp-production-main-59.iva.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 48/51] default_device: Call dev_change_net_namespace() under nd_lock
Date: Sat, 22 Mar 2025 17:43:50 +0300
Message-ID: <174265463028.356712.15016385543007330124.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

We want to provide "nd_lock is locked" context during
NETDEV_REGISTER (and later for NETDEV_UNREGISTER)
events. When calling from __register_netdevice(),
notifiers are already in that context, and we do the
same for dev_change_net_namespace() here.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/dev.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index f0f93b5a2819..c477b39d08b9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12357,6 +12357,7 @@ static void __net_exit default_device_exit_net(struct net *net)
 {
 	struct netdev_name_node *name_node, *tmp;
 	struct net_device *dev, *aux;
+	struct nd_lock *nd_lock;
 	/*
 	 * Push all migratable network devices back to the
 	 * initial network namespace
@@ -12383,7 +12384,9 @@ static void __net_exit default_device_exit_net(struct net *net)
 			if (netdev_name_in_use(&init_net, name_node->name))
 				__netdev_name_node_alt_destroy(name_node);
 
+		lock_netdev(dev, &nd_lock);
 		err = dev_change_net_namespace(dev, &init_net, fb_name);
+		unlock_netdev(nd_lock);
 		if (err) {
 			pr_emerg("%s: failed to move %s to init_net: %d\n",
 				 __func__, dev->name, err);


