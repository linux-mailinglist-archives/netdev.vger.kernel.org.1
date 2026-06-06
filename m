Return-Path: <netdev+bounces-296072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CQH+M8zGI2qlyAEAu9opvQ
	(envelope-from <netdev+bounces-296072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 09:05:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 176A164CCA0
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 09:05:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JGbMGLGK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296072-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B13300951C
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 07:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6C02E7F3A;
	Sat,  6 Jun 2026 07:05:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978C13A3ED
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 07:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780729546; cv=none; b=IrEKcC6urvthRg/W2XAGPx+hJgRUumGVQUhbxFpCkI1LzB1Pj8dTOIa7bYZlc/SCggU9OLJsOLesXLrF2oSYm4fvcr/sEeozHTjXeI75dnwqkA59DMugDUmUjtf4hdn6naLhJnh8QxHLEIdFp0li+pDVrZ1c99Urir0kRqUtQ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780729546; c=relaxed/simple;
	bh=/lf38YXSMSIYNB+i13lAcVZtU1MxrKusBPkFAbH2Kzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hsprd3jD+YlEv2ufUWI6e2OYwus5B3TBn8HnSoJHr+1Sa/IfJIGOzePIe95W73zS0URf+MJqQdfaSpDlxBckwh0sjNjWKuqZz4YIxU+L3PdzMtcYp3t6N0ZdLFJlJU70r8VlgTMdZZm+CWaQFEEA5vVgVW/d70saeOb7OiwJ4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGbMGLGK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16ED11F00893;
	Sat,  6 Jun 2026 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780729544;
	bh=7Hi26MYjuAXv+lAIB99rWxPcRNW1nP+Lo1MKB1YaTkU=;
	h=From:Date:Subject:To:Cc;
	b=JGbMGLGKIMpgpJuVJQoRvYr2BQs2XnS+wGt2NBV5McjAmRdKsv7nMt4SORrRDJpgj
	 6ZSToCUcsnGbADr13PgKubnSXjlW3vYHC6pGLB6H/tor1G1JZhIBm+kGNcPLIBWnRK
	 1QhbrBSkA8DjlLgWAo5XMos59sSxZ3pOdPodA6yXcTUqLZs0l6Pxcdv3dxokgGqwWs
	 nPMDbY56RxT29KjoQD6QwePPjU6H6PFiVc4bOSj2GVPw0f7ODiScfVfqDg8vxq0P71
	 VUz1zE+EfYSzYSbN+pTLWT6rBNflcdig9gsZM6FxYIxJfiryhF7NylC8FxxZIlY3a8
	 Ovo9F+CLHCTCw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 06 Jun 2026 09:05:24 +0200
Subject: [PATCH net-next] net: airoha: simplify WAN device check in
 airoha_dev_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-airoha-eth-simplify-dev-init-v1-1-f08f8e404049@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQrCMBBF0V8ps3YgVqvgr4iLkLyaBzotSSgtp
 f9ukLs6m7tLQSaKPLpdMhYWTtZwPnUSkrc3lLFZetffXEs985S8oiYt/M4fjptGLEpj1SEOl3A
 PwbkrpC3mjJHrf/8UQ1XDWuV1HD/FReFHeAAAAA==
X-Change-ID: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e
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
	TAGGED_FROM(0.00)[bounces-296072-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 176A164CCA0

airoha_register_gdm_devices() iterates eth->ports[] in order, so GDM2's
netdev is always registered before GDM3/GDM4. This means the explicit
check for eth->ports[1] && eth->ports[1]->devs[0] is a redundant
special-case of what airoha_get_wan_gdm_dev() already covers, since
GDM2 is always marked as WAN during its own ndo_init.
Remove the redundant check and rely solely on airoha_get_wan_gdm_dev()
which handles both the GDM2-present and GDM2-absent cases.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 5a8e84fa9918..b333a7b309c2 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2004,18 +2004,10 @@ static int airoha_dev_init(struct net_device *netdev)
 
 	switch (port->id) {
 	case AIROHA_GDM3_IDX:
-	case AIROHA_GDM4_IDX: {
-		struct airoha_eth *eth = dev->eth;
-
-		/* GDM2 supports a single net_device */
-		if (eth->ports[1] && eth->ports[1]->devs[0])
-			break;
-
-		if (airoha_get_wan_gdm_dev(eth))
+	case AIROHA_GDM4_IDX:
+		if (airoha_get_wan_gdm_dev(dev->eth))
 			break;
-
 		fallthrough;
-	}
 	case AIROHA_GDM2_IDX:
 		/* GDM2 is always used as wan */
 		dev->flags |= AIROHA_PRIV_F_WAN;

---
base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
change-id: 20260606-airoha-eth-simplify-dev-init-5d53c7cc004e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


