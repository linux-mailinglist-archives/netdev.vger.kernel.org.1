Return-Path: <netdev+bounces-296057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O9fTDOe1I2phxQEAu9opvQ
	(envelope-from <netdev+bounces-296057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:53:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E8164CA77
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 07:53:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yc4pfBcr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296057-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296057-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EB0930086CE
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 05:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769DE2F531F;
	Sat,  6 Jun 2026 05:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE81A9F88
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 05:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725039; cv=none; b=Yx7G7ZOePFAmMyR9ktjcNkPXY0IzdHWazmkXJp0VIPuB5gorhQJWveW8fRG8OBZncpUKhFRhp2peBO4M7CucZdl6BrRNpaY16zjgO/UryzNjIUWH5CRH637QiPCzhsOOEicBODCZhNSTUgAF5gShTE2ZVMEucvyii2sOo+9h5/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725039; c=relaxed/simple;
	bh=z7SkIp9z+bRtbbNXb03wvDdYtpeVVyvfRF8vBgvn8nY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CrLwvU8BphpGXX+SJRDUj1qv05jUK9OLOfXXZEjaytCDoSTkwiDrOTiH0MUU2/j1w6sjbFh35rSTjMmk5q9WFzZH5/qiwU8nCXMCwZ0ZKWDD2TUXB3WcYj/QkB7z6YYoSc+YxEJO1iJZlpmcsb94IiiCJp5XIqiQ1zyd+JzhMhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yc4pfBcr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1A21F00893;
	Sat,  6 Jun 2026 05:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780725038;
	bh=Qd5esQLYkEp9qLYF3uDQurNkA79QQQMRr7j4ojvsKBA=;
	h=From:Date:Subject:To:Cc;
	b=Yc4pfBcr8gFeMuG0vq66p8dzpYN9BM+hwza4eVwJDCz1PwmKRHWTM7lvahzg5v7KT
	 RDBqACQW8/eUYCkoKaOfkXIXwiU4LVYkvPRYVVlWQib+JSPY5UoxTzsd/xh2KYQbhk
	 A4wOwSJ6i3mKIuGu0URERl3ePZcJbmtUhvWxcQ0epTP4G0QOH+ow62bu9mchPZrRAD
	 xdijExBBMS3kfET120DVOjbOaeQeZxFLDqaOZP3I5oXEUWo8nQf02a4w6eJhdjBlTl
	 JTXTQOesP1SdzBIfffPC18UsjJuwbozUl9uym1Ma+pryWMuVBMjiyuKcxNIRN+On/v
	 abdb6qcbI1FDg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 06 Jun 2026 07:49:59 +0200
Subject: [PATCH net-next] net: airoha: Use int instead of atomic_t for qdma
 users counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-airoha_qdma_users-no-atomic-v1-1-86e2d6a1bfaf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ77kIMtoJfkSJrXHUPbjRJiyD+v
 UuZ0xxmLsichDN01QWJv5Ilqkn9qCCspAujTObgnX85A0lSXGk4po2Gj8UZNSKVuElA1z5dCH5
 s/FyDHfbEs5z/ew/KBZXPAu/7/gGNKAtYdwAAAA==
X-Change-ID: 20260606-airoha_qdma_users-no-atomic-0750cc2b42f1
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296057-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74E8164CA77

QDMA users counter is always accessed holding RTNL lock so we do not
require atomic_t for it.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
 drivers/net/ethernet/airoha/airoha_eth.h | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..a5fe08864fa3 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1809,7 +1809,7 @@ static int airoha_dev_open(struct net_device *netdev)
 	airoha_qdma_set(qdma, REG_QDMA_GLOBAL_CFG,
 			GLOBAL_CFG_TX_DMA_EN_MASK |
 			GLOBAL_CFG_RX_DMA_EN_MASK);
-	atomic_inc(&qdma->users);
+	qdma->users++;
 
 	if (!airoha_is_lan_gdm_dev(dev) &&
 	    airoha_ppe_is_enabled(qdma->eth, 1))
@@ -1863,7 +1863,7 @@ static int airoha_dev_stop(struct net_device *netdev)
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
 
-	if (atomic_dec_and_test(&qdma->users)) {
+	if (!--qdma->users) {
 		airoha_qdma_clear(qdma, REG_QDMA_GLOBAL_CFG,
 				  GLOBAL_CFG_TX_DMA_EN_MASK |
 				  GLOBAL_CFG_RX_DMA_EN_MASK);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 8f42973f9cf5..e89c2dff411f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -525,8 +525,7 @@ struct airoha_irq_bank {
 struct airoha_qdma {
 	struct airoha_eth *eth;
 	void __iomem *regs;
-
-	atomic_t users;
+	int users;
 
 	struct airoha_irq_bank irq_banks[AIROHA_MAX_NUM_IRQ_BANKS];
 

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260606-airoha_qdma_users-no-atomic-0750cc2b42f1

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


