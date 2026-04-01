Return-Path: <netdev+bounces-273913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE0wHvbCzGkWWgYAu9opvQ
	(envelope-from <netdev+bounces-273913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:02:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AA3375850
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 09:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B41C13058723
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E4E32ED24;
	Wed,  1 Apr 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osy/yKBs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6319E32D438;
	Wed,  1 Apr 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775026809; cv=none; b=Kc8dADW3JGjf7nlqrpoCthH4uxxfqmv90G9X9fuZVd+ShhGlT/pfMrigkdbf4oyH+qLKyewueUcBrQ4gMsqIAsfgYyVvhQTgqVCn1KznP6Dy/RabZ1mRrtQih2eJr7YddpSzSFb/uYk2wayHxgeM2M276QbG7muwqtODS2hZiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775026809; c=relaxed/simple;
	bh=Ufsjv/haVPKt31hyUGGIbzUvEJxDwoiIsDyDNBKk42A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVDNVlmlZGDNedOLBvcdXqlnf0r2e0E6kArWfoQrG4Mhno1Tab4xxiz8q3NGzFTKnbnWb1hvfAJlLGTR0PQfDt3+YZl91KCj6+qJZJXxQIR8fiHsWXy0tQRUNejNZtRTipFklK/Kc+inE1fnO9x7JRqaArWmsb1cUKcb3Ip4wlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osy/yKBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E832BC2BCB3;
	Wed,  1 Apr 2026 07:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775026809;
	bh=Ufsjv/haVPKt31hyUGGIbzUvEJxDwoiIsDyDNBKk42A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=osy/yKBstyTF51AUvFlfiYXCVhY8I1Cm4W9yGecMQwv4TrbjKnuapSLAuuRDVKBj7
	 op5ZRfjR+CaVT0ZvcMv+IWs55irr3EM/bhZDXE19bAREGyrPfhboiQE8x8bqarM14x
	 z3UjBtrksvR/l4UfAus+cYybYBdUT0nBn0JMWqy+F1wVfHNSRj8OQBmXhiBj9rdHXr
	 Dsm1muJoOwdjOkxP9ShPcM4OuhPAHd/hL8PD7Okx3214o6vC/hHUFVBhTd9b5kHVwu
	 wCc05RTW3lqXgiVjT76pGNDRZGHLjVpUChiQ0Zdqb+E9a8pvDuAI2/NPr/vxAE+rHQ
	 11NI/hKNHze9w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 01 Apr 2026 08:59:21 +0200
Subject: [PATCH net-next v2 03/11] net: airoha: Rely on net_device pointer
 in airoha_dev_setup_tc_block signature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-airoha-eth-multi-serdes-v2-3-ac427ae4beeb@kernel.org>
References: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
In-Reply-To: <20260401-airoha-eth-multi-serdes-v2-0-ac427ae4beeb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273913-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org,airoha.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2AA3375850
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove airoha_gdm_port dependency in airoha_dev_setup_tc_block routine
signature and rely on net_device pointer instead. Please note this patch
does not introduce any logical change and it is a preliminary patch to
support multiple net_devices connected to the GDM3 or GDM4 ports via an
external hw arbiter.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index ff5fc852d7dc3960fdcf6ae7465896340c3f43a0..e1448e01dd69b7d46f0efd8ad4e8531bca0ae1eb 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2675,7 +2675,7 @@ static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
 	}
 }
 
-static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
+static int airoha_dev_setup_tc_block(struct net_device *dev,
 				     struct flow_block_offload *f)
 {
 	flow_setup_cb_t *cb = airoha_dev_setup_tc_block_cb;
@@ -2688,12 +2688,12 @@ static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
 	f->driver_block_list = &block_cb_list;
 	switch (f->command) {
 	case FLOW_BLOCK_BIND:
-		block_cb = flow_block_cb_lookup(f->block, cb, port->dev);
+		block_cb = flow_block_cb_lookup(f->block, cb, dev);
 		if (block_cb) {
 			flow_block_cb_incref(block_cb);
 			return 0;
 		}
-		block_cb = flow_block_cb_alloc(cb, port->dev, port->dev, NULL);
+		block_cb = flow_block_cb_alloc(cb, dev, dev, NULL);
 		if (IS_ERR(block_cb))
 			return PTR_ERR(block_cb);
 
@@ -2702,7 +2702,7 @@ static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
 		list_add_tail(&block_cb->driver_list, &block_cb_list);
 		return 0;
 	case FLOW_BLOCK_UNBIND:
-		block_cb = flow_block_cb_lookup(f->block, cb, port->dev);
+		block_cb = flow_block_cb_lookup(f->block, cb, dev);
 		if (!block_cb)
 			return -ENOENT;
 
@@ -2801,7 +2801,7 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
 		return airoha_tc_setup_qdisc_htb(port, type_data);
 	case TC_SETUP_BLOCK:
 	case TC_SETUP_FT:
-		return airoha_dev_setup_tc_block(port, type_data);
+		return airoha_dev_setup_tc_block(dev, type_data);
 	default:
 		return -EOPNOTSUPP;
 	}

-- 
2.53.0


