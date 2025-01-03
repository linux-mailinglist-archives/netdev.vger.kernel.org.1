Return-Path: <netdev+bounces-155061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B73A00E26
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92B5B18846EB
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6BA1FC114;
	Fri,  3 Jan 2025 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYyPyxsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74A1FBC97
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930800; cv=none; b=EJh3w0UnXli+nrhYsPp5uNORtCp1pCmAzOzgBESyF1fJIpGJrAWSUf5D5cfqSTWwQawsDT2i+fkgv7VV3Cl3pNLG8WjBixYHuw5WGccaZv0vMxYp75idsUyx6lvDolE8qtF1RXyUnq4kmSOOcAKpf/orhz7epKNFgaR5STQCOK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930800; c=relaxed/simple;
	bh=hu7EJAQ65piJvg4PzI7AJMlpKtDBcmVQhUaYx2F/CSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMTLS4WD+GfGkLtge6j6zCyuUks7LWlczeaCUrJ44SApmTtldp+HKcKQYxiRDfqcZ9U2BcgS4cHvBlaMWjCvDeHAy08GkbzbLqOZtaYEjx5xRg5JD14uYQoEB+fFJYNUlrXcxDZjbZMfZEAANB8w0iffE1DjAEwv+gI8KXK5nu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYyPyxsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2ACC4CEDC;
	Fri,  3 Jan 2025 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930799;
	bh=hu7EJAQ65piJvg4PzI7AJMlpKtDBcmVQhUaYx2F/CSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EYyPyxsug7xZvR3zC7UJcMyTU41wdcdekauDgPf70WMyBohrslCtsYntIBhUa8oj6
	 4n/I3UOlGR4oNtGJaVkIaz4Sb6eujBGNCCM2suZh7KmXXTiHTG4ytsDzUbZMe0bsTv
	 xqJY2V0v/jjK9tP0Wd3p+0LsuTrnbvnLpHf6wJZjE0Q6o0hT5eSfiZciCBWA9CFJFO
	 S2S0BcO1uXc4PMX54Zcrq9i9hZfHHsCXclHpyv1gz7ggCZzjgYLyhoC8pMIvpUmdBW
	 Z8chrvYGmkNH0OHWiaGr0+6ndVogjQolQ6v49nVllqRIv3h2jxZKjlTCWL6UyhB5tq
	 WRNls9CfT4GoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/8] net: make sure we retain NAPI ordering on netdev->napi_list
Date: Fri,  3 Jan 2025 10:59:46 -0800
Message-ID: <20250103185954.1236510-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Netlink code depends on NAPI instances being sorted by ID on
the netdev list for dump continuation. We need to be able to
find the position on the list where we left off if dump does
not fit in a single skb, and in the meantime NAPI instances
can come and go.

This was trivially true when we were assigning a new ID to every
new NAPI instance. Since we added the NAPI config API, we try
to retain the ID previously used for the same queue, but still
add the new NAPI instance at the start of the list.

This is fine if we reset the entire netdev and all NAPIs get
removed and added back. If driver replaces a NAPI instance
during an operation like DEVMEM queue reset, or recreates
a subset of NAPI instances in other ways we may end up with
broken ordering, and therefore Netlink dumps with either
missing or duplicated entries.

At this stage the problem is theoretical. Only two drivers
support queue API, bnxt and gve. gve recreates NAPIs during
queue reset, but it doesn't support NAPI config.
bnxt supports NAPI config but doesn't recreate instances
during reset.

We need to save the ID in the config as soon as it is assigned
because otherwise the new NAPI will not know what ID it will
get at enable time, at the time it is being added.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index faa23042df38..dffa8f71d5cc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6713,13 +6713,14 @@ static void napi_restore_config(struct napi_struct *n)
 	n->gro_flush_timeout = n->config->gro_flush_timeout;
 	n->irq_suspend_timeout = n->config->irq_suspend_timeout;
 	/* a NAPI ID might be stored in the config, if so use it. if not, use
-	 * napi_hash_add to generate one for us. It will be saved to the config
-	 * in napi_disable.
+	 * napi_hash_add to generate one for us.
 	 */
-	if (n->config->napi_id)
+	if (n->config->napi_id) {
 		napi_hash_add_with_id(n, n->config->napi_id);
-	else
+	} else {
 		napi_hash_add(n);
+		n->config->napi_id = n->napi_id;
+	}
 }
 
 static void napi_save_config(struct napi_struct *n)
@@ -6727,10 +6728,39 @@ static void napi_save_config(struct napi_struct *n)
 	n->config->defer_hard_irqs = n->defer_hard_irqs;
 	n->config->gro_flush_timeout = n->gro_flush_timeout;
 	n->config->irq_suspend_timeout = n->irq_suspend_timeout;
-	n->config->napi_id = n->napi_id;
 	napi_hash_del(n);
 }
 
+/* Netlink wants the NAPI list to be sorted by ID, if adding a NAPI which will
+ * inherit an existing ID try to insert it at the right position.
+ */
+static void
+netif_napi_dev_list_add(struct net_device *dev, struct napi_struct *napi)
+{
+	unsigned int new_id, pos_id;
+	struct list_head *higher;
+	struct napi_struct *pos;
+
+	new_id = UINT_MAX;
+	if (napi->config && napi->config->napi_id)
+		new_id = napi->config->napi_id;
+
+	higher = &dev->napi_list;
+	list_for_each_entry(pos, &dev->napi_list, dev_list) {
+		if (pos->napi_id >= MIN_NAPI_ID)
+			pos_id = pos->napi_id;
+		else if (pos->config)
+			pos_id = pos->config->napi_id;
+		else
+			pos_id = UINT_MAX;
+
+		if (pos_id <= new_id)
+			break;
+		higher = &pos->dev_list;
+	}
+	list_add_rcu(&napi->dev_list, higher); /* adds after higher */
+}
+
 void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 			   int (*poll)(struct napi_struct *, int), int weight)
 {
@@ -6757,7 +6787,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	napi->list_owner = -1;
 	set_bit(NAPI_STATE_SCHED, &napi->state);
 	set_bit(NAPI_STATE_NPSVC, &napi->state);
-	list_add_rcu(&napi->dev_list, &dev->napi_list);
+	netif_napi_dev_list_add(dev, napi);
 
 	/* default settings from sysfs are applied to all NAPIs. any per-NAPI
 	 * configuration will be loaded in napi_enable
-- 
2.47.1


