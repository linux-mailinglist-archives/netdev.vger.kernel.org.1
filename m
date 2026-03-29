Return-Path: <netdev+bounces-272894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDNCMAslyWm/vAUAu9opvQ
	(envelope-from <netdev+bounces-272894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:11:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880C35218F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C983028031
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5F236EAAD;
	Sun, 29 Mar 2026 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H58wW6It"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20B433AD;
	Sun, 29 Mar 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774789701; cv=none; b=KVhxwM6WGkODOJH772v89W7xWhTULSRizTpdCmZw35qbgCBIESBxPHFkxJtxf8A73LZaJuqEO4vEkmhc9xubedqrPtA5SI2UR2ZF0b/E/E6QpY4yKJov/oyQWwGAAUz3xl6V4Iq2ebnKEb9X5rkaggscArOlXKDV8dLPKXQa4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774789701; c=relaxed/simple;
	bh=4EhZThLH7oO/aeN4dZc7bHt9j7nfkfQrYsBvUetgK48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hp/zE/K4VYQloYIWMN4ChPNOgiAheT0Tjot1tMhctxe4FfNtxK7pHubRjCN+mvQGnGYVGtrYm7V7kmBapJNEWln9tKBqwB8+XiRZs4Ns9t4T5JJa62du4MIuNQZ/VpT9gXUm/H1IvW5knDsOa4s+ml0NZOmAbaIqSLOOtbQlYew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H58wW6It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86001C19423;
	Sun, 29 Mar 2026 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774789700;
	bh=4EhZThLH7oO/aeN4dZc7bHt9j7nfkfQrYsBvUetgK48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H58wW6ItX9MBfojrR0xjlUdD3KnMeTSkBWPW95ulvBn9jtgdtdzS3zsHhjapFH1Fb
	 pL0nKhSS5UMZRCup4AiQn9vttyMZFOOSy+Y42Iox6gWUjWjuiOX/KME4y83A647dQC
	 qKHrNA6nbWapc4yLekKrDi/QTGiYvYNLHppRJC5+ThuDpUy14oCYFVbpDrPahLxG+3
	 4Euk2Hxqo+yAPTezhxEpuLGurqW+i28Nt75piIi3FI15/w6x7zDspDCm3KThC3fEtU
	 7G/VlAjnNb/KWebtZdVcrgvS5rFMzU2n2Ao4kGSsnc2Jn+j819ERlVf5BAwqJdBHLA
	 3/XZ2kurDshDQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 29 Mar 2026 15:07:52 +0200
Subject: [PATCH net-next 02/10] net: airoha: Rely on net_device pointer in
 airoha_dev_setup_tc_block signature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-airoha-eth-multi-serdes-v1-2-00f52dc360ca@kernel.org>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Xuegang Lu <xuegang.lu@airoha.com>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272894-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,airoha.com:email]
X-Rspamd-Queue-Id: 2880C35218F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove airoha_gdm_port dependency in airoha_dev_setup_tc_block routine
signature and rely on net_device pointer instead. Please note this patch
does not introduce any logical change and it is a preliminary patch to
support multiple net_devices connected to the GDM3 or GDM4 ports via an
external hw multiplexer.

Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 743ef0db30980ce74059dfb63553030ef3bf735f..421a154ee7189eb7919382b6cd893ae5d4e03766 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2671,7 +2671,7 @@ static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
 	}
 }
 
-static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
+static int airoha_dev_setup_tc_block(struct net_device *dev,
 				     struct flow_block_offload *f)
 {
 	flow_setup_cb_t *cb = airoha_dev_setup_tc_block_cb;
@@ -2684,12 +2684,12 @@ static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
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
 
@@ -2698,7 +2698,7 @@ static int airoha_dev_setup_tc_block(struct airoha_gdm_port *port,
 		list_add_tail(&block_cb->driver_list, &block_cb_list);
 		return 0;
 	case FLOW_BLOCK_UNBIND:
-		block_cb = flow_block_cb_lookup(f->block, cb, port->dev);
+		block_cb = flow_block_cb_lookup(f->block, cb, dev);
 		if (!block_cb)
 			return -ENOENT;
 
@@ -2797,7 +2797,7 @@ static int airoha_dev_tc_setup(struct net_device *dev, enum tc_setup_type type,
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


