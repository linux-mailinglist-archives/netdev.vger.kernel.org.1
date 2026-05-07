Return-Path: <netdev+bounces-285323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BwnH/+Q/Gn3RQAAu9opvQ
	(envelope-from <netdev+bounces-285323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802794E918E
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFB243087F46
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9693F7AA4;
	Thu,  7 May 2026 13:04:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB63FE361
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778159099; cv=none; b=AuNFvCuCeMEM5ccjav0jv8i4OJOBQxWCdsKdr9FgMZvO0e5m/oI5PZIXsB+8L04d3YtKPO/2u0FtpRBPuGnmqcVzYnUYUTCb6zTowiCpbJmdzCS6vgaqHYLNTRgmxBVOwpgMOw4MnW3DdXnzz414ovaFKMktSDl4ZwCh7qW71qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778159099; c=relaxed/simple;
	bh=12g3QsZLhXc7VKjxdjXJI547ZYjfnKDMrMTDgWBdsUU=;
	h=Message-Id:From:Date:Subject:To:Cc; b=ZLxKpxw1kk2lMMRgJkbQ2MOx11OUzpSfobfG0CsLHjxOjdDfjdyegxK9EnxiTDuixUN00ZRYO7qLP8NzVf/S5a/tLqbA4A4P1T05fEOuQQcXLysxlP37CmhvMYXizzIxJzEGXuO9dgqr1ahP85FyE2A5+ImiS1eD9PK4CKTNYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 4C59FC1E;
	Thu, 07 May 2026 15:04:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1B8E06029989; Thu,  7 May 2026 15:04:53 +0200 (CEST)
Message-Id: <39de1b025928d9a457976010b2324e7e99baa92a.1778158755.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Thu, 7 May 2026 15:04:59 +0200
Subject: [PATCH net-next] bnxt_en: Drop pci_save_state() after pci_restore_state()
To: Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc: netdev@vger.kernel.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 802794E918E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285323-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.916];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Commit 383d89699c50 ("treewide: Drop pci_save_state() after
pci_restore_state()") sought to purge all superfluous invocations of
pci_save_state() from the tree.

Unfortunately the commit missed one invocation in the Broadcom
NetXtreme-C/E driver.  Drop it.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8c55874..10196f9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17386,7 +17386,6 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
 				pci_write_config_dword(bp->pdev, off, 0);
 		}
 		pci_restore_state(pdev);
-		pci_save_state(pdev);
 
 		bnxt_inv_fw_health_reg(bp);
 		bnxt_try_map_fw_health_reg(bp);
-- 
2.51.0


