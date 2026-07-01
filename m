Return-Path: <netdev+bounces-303710-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C16mCUEqRWpv8AoAu9opvQ
	(envelope-from <netdev+bounces-303710-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0306EF06D
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:54:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.com header.s=fm1 header.b=GzAidCKZ;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=Xr7RvzgK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303710-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303710-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A242B31281AC
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 14:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99AD35E1B6;
	Wed,  1 Jul 2026 14:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22C35677B;
	Wed,  1 Jul 2026 14:47:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917274; cv=none; b=geDCYzYNqPU+vKisFAzEA/Z43w9dvLJ7u9cLAUV3qvQ1lpHXkng3rvkB6fGZYFYPRb1gzWqKmM8zSBFEyFtxTqySXPY5nq1/Xc4alf5IhmZex2a6l4noX20tIlx3LW4542Su8uX0eH3dH+NruZy74vkLEijRirMU8nDKJ/x2RwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917274; c=relaxed/simple;
	bh=chwqUtFfoaH+phiZDhb4n4xB87S5XJuIQlDuEXO9TR8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=trD3Fy69skeumFo5IYS3lMfvuTTmN0d2sBMRWtt820fHQkkmhcTaIZhoq9fXLh2vPk226QEIP1xd0hfIlwXMkqst7001BSDlasglq7yJbrn3mAYQ+AIZHZ1qo8C2ub30elEotR4bgcCemqWcuhRzSqKhYPRA+sIvWn+Z7Ob0HEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=GzAidCKZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xr7RvzgK; arc=none smtp.client-ip=103.168.172.143
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 78F3113801A5;
	Wed,  1 Jul 2026 10:47:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 10:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1782917272; x=1782920872; bh=nR83Y66O6HcybvxGSiG+a
	2C9qoPvKTT4HMsoPirDD6U=; b=GzAidCKZCBlhexEVkXMBzVzY3+TcCAtA4EV8E
	FxFsy3n9c6Vxinfe+c8WVe3/HC7ay0QTKHQpm+m4yDU6Oq63kT2bSq04RrjNX2I7
	dbWRcwwKvELN9s+fs+7kQ2OJ1Lp8E/qXfIEC8MmX/8Nwin0Kb0oU5T8d4HRd3FTB
	co6IceuBWbt9vJ3OIdv0d4x2CDhl8/7gqNmQ4X8zjxBiBSO9S7OeVkvmTeCjV3yl
	DHDwXvOzunO1hH5fFOt1BeHyRo2ZYwyg3edMXcnz+MbpWK09R0XguWOv5YKEhRCP
	IMDOBMccgz6kTY5QFYp473KR/alR4fM4OCU6MalRVvmVkydlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782917272; x=1782920872; bh=nR83Y66O6HcybvxGSiG+a2C9qoPvKTT4HMs
	oPirDD6U=; b=Xr7RvzgKgbll7nVkeoMAjbm0+sa5aKtxYzWAntWKFKneQsiBRCW
	XfK5013HWwgNWp5+xsNmuy7szhJGkSeE4fNMjjA5SkT3fCwQxB4DKPsPDJsCkuao
	dliYeO6Bs1LFtdA7FNjthQbxIH1KHX2Fhay0H+oJ8EDiJLLiFw+ZB94wekQWnAHU
	geHiiE8vABDiXGC7b4fAmnh7gUTEzq1acMWp/QnuzrPlQqtxEe4WqfoRR7Ua4EIO
	5xYxlT+g4/9tFKzxzgg6VZSVyCGnFYQNwNqy0AJfh+UtnsU+fNexKf4LAY9BG8DH
	UMGcocCSxMu25mm750+t6JMEliCTGqzmT/g==
X-ME-Sender: <xms:mChFar6ZuMqh6OdHkzt51zuK5NTAyIVEC9r8__7yFdc4WkSLHbmyFw>
    <xme:mChFal3fbrcoh2YoB2itR4lkABOESLvktwMv0bjy7qK3kpnQgt2yZKj5os8Srfuz3
    65OHIZKZxDdGFL5ctOhwhX2iQkM27veszyPQacjTXcl3EIPiyUwqrE>
X-ME-Received: <xmr:mChFamvYHsiP-jOjsUQkfPSOZ24UQTsF0eIXCXv1AnT_b-qzWt7ERtSW>
X-ME-Proxy-Cause: dmFkZTFI1//L2IKbO8J3DS5he9OqHSuFZVu6lUEe7oIeWMlq3I43UQy8Y8u542SuhZD90a
    4iefhJnApC1J1Xc/mA2G3r6OF04wDQknPtnvcikb2TToKrArH4CRHNTg9PzrhMCssso/YV
    zTqhzpC7EFJLymeqbR1JxyP7npHa2rXzwVPAweZmpYhFuQfNvU5yr6mVMnkkT0TvjMNNLN
    f0H5h4sCtlPzlY/9IoQ3n4bkqKz4Nju8a83uJJxSySCNZXlNqrcRdtDBeL/lkcJA0vzcDJ
    4BlgH3B+PA98n00Y9LMOGCuo3bjQHJ8q4xZhEsjgmVe9BkPL8icVk+N+3FRpf2PiCjEgNt
    wFLlAGPG5PV20FT8lw91+NNdEVacwNAH5hVvEJvCE17GTJ+3K/eARhlIXmS+Tl1eG7oQEU
    a0ZR8PONPkzzg5cnEyKP7/bfQqrEvjPlU95pYJcOhZl+BbvvNDeXIuWQvI4K+g4Px5bMEa
    uAl8num9RrwqGk67AGLDEUEyBudu9H3xnhsLkCcg/cQHfK3k6QEJZmSeFlo8YJJ54YWnQ2
    7ode12Znb9HLgbS+DlxqdJ4s5qaP8BYS7r48JDkLuVmKiFaCVA8TqrxN0XBaKXU8d5Mtq+
    rer++IHjgcGTsZ7jBLUbZT9y8w7CcUerCInoomKq3hJ6VfeIfVNQ6XCbn3Rw
X-ME-Proxy: <xmx:mChFar7910mAWApSS4YrAJgfF5uByBWAV_WqBR0dnj_ms_gQeSwmaQ>
    <xmx:mChFaie6HvePn6B3eccTAJp6t1KZnrSUmxzvZxvq53RFQG6WoC_Iyg>
    <xmx:mChFaowzFLmkgNU7x_oTx0OXocqpXo7J2SaYgpwUZZGgx9gzw9wVPQ>
    <xmx:mChFan_zn1SXcG9tumdmKcL7P9kbps0aLMSnNlpcekH5U8u0GKwzbw>
    <xmx:mChFalOMFB7XUo_TxrwjcErQGdpdu3JXGy5vtnnIf1y_o8TQMZsIxg1x>
Feedback-ID: i9dce4b48:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 10:47:50 -0400 (EDT)
From: Baran Tuna <barant@fastmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Baran Tuna <barant@fastmail.com>,
	Breno Leitao <leitao@debian.org>,
	netdev@vger.kernel.org (open list:QLOGIC QL4xxx ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] qede: Prevent possible snprintf() truncation by bounding %s string format
Date: Wed,  1 Jul 2026 17:47:11 +0300
Message-ID: <20260701144713.197557-1-barant@fastmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303710-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,fastmail.com,debian.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:barant@fastmail.com,m:leitao@debian.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[barant@fastmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barant@fastmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fastmail.com:dkim,fastmail.com:email,fastmail.com:mid,fastmail.com:from_mime,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E0306EF06D

GCC warning shows that formatted strings may
exceed the fixed-size destination buffers.

Bounding the %s string format
so the maximum formatted output always fits.

This eliminates the -Wformat-truncation warning.

Signed-off-by: Baran Tuna <barant@fastmail.com>
---
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 647f30a16a94..5428f53150a0 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -618,10 +618,10 @@ static void qede_get_drvinfo(struct net_device *ndev,
 	if ((strlen(storm) + strlen("[storm]")) <
 	    sizeof(info->version))
 		snprintf(info->version, sizeof(info->version),
-			 "[storm %s]", storm);
+			 "[storm %.16s]", storm);
 	else
 		snprintf(info->version, sizeof(info->version),
-			 "%s", storm);
+			 "%.16s", storm);
 
 	if (edev->dev_info.common.mbi_version) {
 		snprintf(mbi, ETHTOOL_FWVERS_LEN, "%d.%d.%d",
@@ -632,10 +632,10 @@ static void qede_get_drvinfo(struct net_device *ndev,
 			 (edev->dev_info.common.mbi_version &
 			  QED_MBI_VERSION_0_MASK) >> QED_MBI_VERSION_0_OFFSET);
 		snprintf(info->fw_version, sizeof(info->fw_version),
-			 "mbi %s [mfw %s]", mbi, mfw);
+			 "mbi %.10s [mfw %.10s]", mbi, mfw);
 	} else {
 		snprintf(info->fw_version, sizeof(info->fw_version),
-			 "mfw %s", mfw);
+			 "mfw %.16s", mfw);
 	}
 
 	strscpy(info->bus_info, pci_name(edev->pdev), sizeof(info->bus_info));
-- 
2.54.0


