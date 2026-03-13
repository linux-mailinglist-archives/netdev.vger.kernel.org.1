Return-Path: <netdev+bounces-267417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCLPNJn0s2nYdgAAu9opvQ
	(envelope-from <netdev+bounces-267417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:27:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE328236E
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 12:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A2B9302AF25
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6197352C39;
	Fri, 13 Mar 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkuFG7Cq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCA2D5C83
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773401238; cv=none; b=VH6nleDeoAC/YsBB9fB09EoavREFUw4eYQhVDY65bHMyWyJ9F74l8N3BIlcANxeWFCTxmT8lwxDZLIqV/o054CSurF6ECSUMM29/vrgh85cORgXAPQkX23EJbbJexxvPLfqvdFMujsE4HUaM/9G/PuUTJQilJoQfsm34wuqbhQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773401238; c=relaxed/simple;
	bh=yu3FkG+te6lxyT/bb+2rXQeEoH7RigJXJoMuJhFsNTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jkVIzPcGe2+cQxcPCIXI64Stx9I9Tdvrn42IvwI8rR8lfhZWvHDO58IGznr8emXewTfiuytSk+EVPt5n9yH6d+0G1+vOiSDB3BucDqJKtARxm/8kGD4n+eTlt3sRxnL+L9+Q1X9CQzA+n1L1zRmM13KAx0tX68USA+6YDXLWCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkuFG7Cq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18212C2BC87;
	Fri, 13 Mar 2026 11:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773401238;
	bh=yu3FkG+te6lxyT/bb+2rXQeEoH7RigJXJoMuJhFsNTo=;
	h=From:Date:Subject:To:Cc:From;
	b=VkuFG7CqgnngorKkNP8EVkcvw8KHppTq1S8ym9pdykjO6+Dx/sXPY9uPMZnGitYMA
	 kN+q0FVrXimGMmJcoZynErulWon5i0aIgpQpHfbbp6Pegs9VCiFtNuaajaVY8TD+c0
	 PhQfm10nWEj7eXyY4HK/4QxoOY1kIz+hR8vvRZqzjz7+UZtMli7Mn/AFRccrN/7day
	 PIrmU5/+swJMtprhE/CW6bF/vPxKWrfcOlks2wHiou1lQxRvD0WrwOPMyZzxhEnwl6
	 LVtgPbqm8M28mnMYn4wAeqcLM5U5ZvKPt/EtQ/pViqjN0UlpztAwCf4ZP+VuD5EFk8
	 25Lu6REBCtozQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Mar 2026 12:27:00 +0100
Subject: [PATCH net v2] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-airoha-remove-ndo_stop-remove-net-v2-1-67542c3ceeca@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z3NQQqDMBCF4avIrDsQI1rpVUqRNJmYWZiRiUhBv
 HuDC5cf/Lx3QCFlKvBqDlDaubDkCvtowCeXZ0IO1WCNHUzXduhYJTlUWmQnzEGmssl6mzYMg2/
 915nx2UeoO6tS5N/18YYawOc8/6J8JGJ4AAAA
X-Change-ID: 20260313-airoha-remove-ndo_stop-remove-net-d6c1cba0875f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267417-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DEE328236E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Do not run airoha_dev_stop routine explicitly in airoha_remove()
since ndo_stop() callback is already executed by unregister_netdev() in
__dev_close_many routine if necessary and, doing so, we will end up causing
an underflow in the qdma users atomic counters. Rely on networking subsystem
to stop the device removing the airoha_eth module.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Target net tree instead of net-next
- Add missing Fixes tag and improve commit log.
- Link to v1: https://lore.kernel.org/netdev/20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org/
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 62bcbbbe2a95651ac1f7f30c3752ccbc7bc5662f..56cf9a926a83da38bb03373ced9728f1fecdbce7 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3083,7 +3083,6 @@ static void airoha_remove(struct platform_device *pdev)
 		if (!port)
 			continue;
 
-		airoha_dev_stop(port->dev);
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}

---
base-commit: 99600f79b28c83c68bae199a3d8e95049a758308
change-id: 20260313-airoha-remove-ndo_stop-remove-net-d6c1cba0875f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


