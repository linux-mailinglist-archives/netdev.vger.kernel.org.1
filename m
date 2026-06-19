Return-Path: <netdev+bounces-300688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DDA3KjQqNWo4nwYAu9opvQ
	(envelope-from <netdev+bounces-300688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:38:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE56A5746
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 13:38:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b7bGjU+U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300688-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300688-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A8830534DE
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC53803DA;
	Fri, 19 Jun 2026 11:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576603793A9
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:37:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869062; cv=none; b=bvhjor6rr2OmKY0+HHxcGf8TIrT9jIlnayCe6IEVN7AAevNY8Y0/5SlZsthSPBTR56kjU4SWWrkMCdktjUvZJev6kaK663Z+4sx7SjiH8DAgC/QHWav/6pZmv6HMTg4gm+vR8pyIq61HBpanRzojgscE+0lrSNu50aUBc2wqwak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869062; c=relaxed/simple;
	bh=WpVSKU5AYUdlGh/JmWIkDRS+XWke55vTL36de5TGti4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OboI7iGwQQhJ1fxWmg3drGfAq+lshX02/C+g9p7HWgc9Cgy+6kx9JXmYCCg0fVdbgrTC7WwWSxlgaUzkWCoGmKGksSXeTKBhjIT75+IMu+ZQp5DHLxwdCSRf0y95cG5SOdh4INhncGpcg0e7HWVmsYxR0Y17GVVdwPIO6nMC4/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7bGjU+U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0261F00A3D;
	Fri, 19 Jun 2026 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869061;
	bh=5YSFkwBdwIZvGA3XLMEJv/9BLBx9P14qbmrv7iQoAww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b7bGjU+U38EIWEfujwNOg+vifivWQzXRPCkAvvF+6b+SHVBYhnFkc16N7UucBuwzW
	 Fe0ijn4s/ibPDBOAZdRvnjG/t/LJ2wSnPTybsR/OElf8k9TpqHUj8MB6q3/gqOybPA
	 HRJgOhxhGWkiRHFKw9ts6k3h3RDBJ7hJCsk4qvRYEnj8DqlkRzFmBMSSeoZmvKBDfG
	 qFJwGTSZ6T/BzSAbLBY/vFHP4+0m4sMVeHYHqK5G7p9QroKW6rMzgwcnd2d0cjKzwI
	 MLLe8p1YGJE40jqcGNn3DlTb/eOIIaiA/YWYH1mTGHPk8eekZdWXhqJgfEg+QPiMQ2
	 zEcBp6goQaFaA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 19 Jun 2026 13:37:13 +0200
Subject: [PATCH net v2 1/2] net: airoha: Fix off-by-one in
 airoha_tc_remove_htb_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-airoha-qos-fixes-v2-1-5c43485038f9@kernel.org>
References: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
In-Reply-To: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Wayen Yan <win847@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300688-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:horms@kernel.org,m:win847@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EECE56A5746

airoha_tc_htb_alloc_leaf_queue() computes the HTB QoS channel index
as opt->classid % AIROHA_NUM_QOS_CHANNELS and stores it in qos_sq_bmap.
However, airoha_tc_remove_htb_queue() clears the HTB configuration
using queue + 1 as the channel index, causing an off-by-one error.
Use queue directly as the QoS channel index to match the allocation
logic.

Fixes: ef1ca9271313b ("net: airoha: Add sched HTB offload support")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64dde6464f3f..aa98d1823ab6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3006,7 +3006,7 @@ static void airoha_tc_remove_htb_queue(struct net_device *netdev, int queue)
 	struct airoha_qdma *qdma = dev->qdma;
 
 	netif_set_real_num_tx_queues(netdev, netdev->real_num_tx_queues - 1);
-	airoha_qdma_set_tx_rate_limit(netdev, queue + 1, 0, 0);
+	airoha_qdma_set_tx_rate_limit(netdev, queue, 0, 0);
 
 	clear_bit(queue, qdma->qos_channel_map);
 	clear_bit(queue, dev->qos_sq_bmap);

-- 
2.54.0


