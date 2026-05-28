Return-Path: <netdev+bounces-292885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJYWEdjNGGpjnggAu9opvQ
	(envelope-from <netdev+bounces-292885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 772505FB5CE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 657AD3046F6D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008D36F911;
	Thu, 28 May 2026 23:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdXlMVnA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E387936F433
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010216; cv=none; b=usqS9W7IbqCIoDU57Kl/iil8tz13vTBsUM9aCHPIQTqT8o45X2QbBwJHkSjdQ2WE8y+FmY/3n5dqdQ/gYWbxkrjaVw/+EvrgG2fCm1k7jZZz37Ru0Rni0eAPqFZoD2btoI68pHnNF6NwD2XN7+Juj/bzPtTHcGsZC3LinJV/iXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010216; c=relaxed/simple;
	bh=UtvTEVsfr9OkLZBLGFDXv2XojfMAMJ/vV5HoCkCfEHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X57nYbQbegFXFQb+dqiNVuH5b0HbCEqHwN5t61kX8cuTRf5vx/xQ/7PkJdxQsI+wLRkDqRlFnItJaFl8oZsw1C0hYmKCBZqMDplzIDiL1hfV7T4N6MqE5jZ1A9UEQcd5GQu9mkG1co/rDv/YrolrxYBEPM0phdWJ3Mjv6pgB1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdXlMVnA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05EA41F00A3D;
	Thu, 28 May 2026 23:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780010215;
	bh=H2bxx/LxHkk/q8DJa0K5dR90mP/E2WaPjjgFxfSCXuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MdXlMVnA0OYAC8ZSMZqW4yEq77GLD4+WQEMtK7Eqj/7yJXh0mLEvrkD+VTrgh/kqh
	 T+XQtLi4QrbLFp6wMqWRI3oF6ZKUMUDPZ0ovsbJRblumw1PH1onEF8D0q4utbZEb57
	 XNlElnVXG0Ij64SlSjAIuS77k5wrrIP8mpf+5klXbJYgEXk7DT+0Ni2fNGVdHjtHc/
	 sD3H9BPEAaaiV3QVlSOsZsY3G2sec1tYRF/PkPKukfSb2vX3wNtitD12+10j+pabPD
	 sZHersDJ0sQb3KK0DQcS+JZX/NIKKBfeNXdQ0l6pq3SoCKTEr9F+jHCP/h1n/PGtPc
	 CxKR35Sm200Yw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	joshwash@google.com,
	tariqt@nvidia.com,
	haiyangz@microsoft.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	willemb@google.com,
	ernis@linux.microsoft.com,
	sdf.kernel@gmail.com,
	kory.maincent@bootlin.com,
	danieller@nvidia.com,
	idosch@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 08/14] net: ethtool: optionally skip rtnl_lock in cable test handlers
Date: Thu, 28 May 2026 16:16:31 -0700
Message-ID: <20260528231637.251822-9-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528231637.251822-1-kuba@kernel.org>
References: <20260528231637.251822-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,nvidia.com,microsoft.com,armlinux.org.uk,bootlin.com,linux.microsoft.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-292885-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 772505FB5CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Skip rtnl_lock in cable test handlers. This is really a noop since
no ops locked device supports these.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/ethtool/cabletest.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 8d375dac2a40..9c22d4c767c6 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -73,8 +73,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 
 	dev = req_info.dev;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 	phydev = ethnl_req_get_phydev(&req_info, tb,
 				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
@@ -101,8 +100,7 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 		ethnl_cable_test_started(phydev, ETHTOOL_MSG_CABLE_TEST_NTF);
 
 out_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
 }
@@ -342,8 +340,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	if (ret)
 		goto out_dev_put;
 
-	rtnl_lock();
-	netdev_lock_ops(dev);
+	netdev_lock_ops_compat(dev);
 	phydev = ethnl_req_get_phydev(&req_info, tb,
 				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
@@ -371,8 +368,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 					 ETHTOOL_MSG_CABLE_TEST_TDR_NTF);
 
 out_unlock:
-	netdev_unlock_ops(dev);
-	rtnl_unlock();
+	netdev_unlock_ops_compat(dev);
 out_dev_put:
 	ethnl_parse_header_dev_put(&req_info);
 	return ret;
-- 
2.54.0


