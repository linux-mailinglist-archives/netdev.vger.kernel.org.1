Return-Path: <netdev+bounces-279243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC/IA1bV4WnQyQAAu9opvQ
	(envelope-from <netdev+bounces-279243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:38:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA74177C3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AF6B3092655
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6F231065B;
	Fri, 17 Apr 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tad1VlVk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE41238D54
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407887; cv=none; b=PVvjXePCYU+YBCHR/NqjQZBjsaLhECvqut8aJO1ZMT7LGiggWa/l9tpSdJMjAmDgIx5RkheMNLwrSmBnf7+vOis+FUrIMwyR95UJmeufK6ToQuD2/0RrMmalGCyXXpscTXdsJw4sGy48NgQUuc0d7ENa2Qqe9aHuw90YubNC0bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407887; c=relaxed/simple;
	bh=lI3xvJe6ThPjr4HNj7xOObldlg5IYT0lT9jqYELwQFQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QoWsEeKT9vEo6vct6dOWI60eGKrEITwZ2RH48ME6e7HoBDqo2FCLT81dljJIjir5NLHB8OS4Y4NxPA2VMChq0sQK53QXz8J1W8duOaKAnQWverXOGO2KAOj8Ek3Lh4CEl31TiIzvNWPxbEIWTeOuZpnA4mUFKOMwgVYfYnyAjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tad1VlVk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9781BC19425;
	Fri, 17 Apr 2026 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776407887;
	bh=lI3xvJe6ThPjr4HNj7xOObldlg5IYT0lT9jqYELwQFQ=;
	h=From:Subject:Date:To:Cc:From;
	b=tad1VlVkoRGEzQywmie32odst/BZPKLRSay72O54fMwk98zJ2srDGKYAhb9tL02dG
	 oEgWhxnpAkD1+UQVvKNP8eYJK3HltPvzawKGOJx/yBJMbOsVAMJHmqcB0sh/vaTrOd
	 ju5llrriVELJKYmucXqQNiESQDPRnt3dNBlUq8QrlVLAYc7SWsQDceTmTvyD/T4gEJ
	 WygkjzgbI/+NbHy7y7YPLtZyXvG5mv8YjGCXwGWPfqrcuCY9xevwCrHCJ/0x1XYoQC
	 bPuvCuq512iov2CMFwNBmqQQP95Mq4krABHICfroN0FGWz+/8xb+g0f8sjb+rcMpDr
	 6IUg83Vgesr3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v4 0/2] net: airoha: Fix airoha_qdma_cleanup_tx_queue()
 processing
Date: Fri, 17 Apr 2026 08:36:30 +0200
Message-Id: <20260417-airoha_qdma_cleanup_tx_queue-fix-net-v4-0-e04bcc2c9642@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5XNTQ6CMBAF4KuYrh3TFkqrK+9hDKllCo1aoPwEQ
 7i7DSuNG1y+eZPvzaTD4LAjp91MAo6uc7WPId3viKm0LxFcETPhlGc0ZRS0C3Wl87Z46tw8UPu
 hyfspbwccEKybwGMPxySRwgpERS2JVBMwVuvMhcQHco3HynV9HV7r9MjW6r+VkQGDm2SSGWUZS
 nW+Y/D4ONShXBdG/qmmG1UeVSVFgUIaQzn/UZNPNduoJkCB37KjFVIpoeiXuizLG+VSRXuKAQA
 A
X-Change-ID: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279243-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4EA74177C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add missing bits in airoha_qdma_cleanup_tx_queue routine.
Fix airoha_qdma_cleanup_tx_queue processing errors intorduced in commit
'3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order
DMA tx descriptors")'.

---
Changes in v4:
- Drop patch 2/3 to move entries to queue head in case of DMA mapping
  failure in airoha_dev_xmit().
- Link to v3: https://lore.kernel.org/r/20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org

Changes in v3:
- Move ndesc initialization fix in a dedicated patch.
- Add patch 2/3 to move entries to queue head in case of DMA mapping
  failure in airoha_dev_xmit().
- Cosmetics.
- Link to v2: https://lore.kernel.org/r/20260414-airoha_qdma_cleanup_tx_queue-fix-net-v2-1-875de57cc022@kernel.org

Changes in v2:
- Move q->ndesc initialization at end of airoha_qdma_init_tx routine in
  order to avoid any possible NULL pointer dereference in
  airoha_qdma_cleanup_tx_queue()
- Check if q->tx_list is empty in airoha_qdma_cleanup_tx_queue()
- Link to v1: https://lore.kernel.org/r/20260410-airoha_qdma_cleanup_tx_queue-fix-net-v1-1-b7171c8f1e78@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Move ndesc initialization at end of airoha_qdma_init_tx()
      net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()

 drivers/net/ethernet/airoha/airoha_eth.c | 40 +++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)
---
base-commit: 82c21069028c5db3463f851ae8ac9cc2e38a3827
change-id: 20260410-airoha_qdma_cleanup_tx_queue-fix-net-93375f5ee80f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


