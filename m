Return-Path: <netdev+bounces-286335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLnwIDS2AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:45:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D65052C0
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39423027130
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669423B3886;
	Sun, 10 May 2026 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="RRl8BJi4"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEC3B27DD;
	Sun, 10 May 2026 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431452; cv=none; b=r6GpYUHiJ2/G2rji6MzVTWGQViFpuO0bdS/zkGnybYfTF2c1qitPz13iHIoBeWK2Va8/kRWF63GgGBMCxVfAWgDhc2ZHPI56NQwJrt+PnIkwmxN7I3lJefTkVZvHuWgp4uOBcpTXfguVtIN6YP+qkwVSgqwlqFc6KgWj6Tznlvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431452; c=relaxed/simple;
	bh=FKLE7ejqghDYJ/w85WEZJrDaGoQqUHvNQ24XD2b+mFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNe2TkcInGwIUJn6ojT6cH7CF+Q+DrdHNVWpqzIZ8kKP08+bRYpwxPBkzUNHCU9RlkjxnXWc8MwEoDov75ApTwEcnKdjyBna9ApjZmXOCdNeTl1Eum0g4IvtSL1l/ofsi3vP5YNsiQlpLqfhg9K6MXFagltt3LTMkttbAYJ6E70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=RRl8BJi4; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4gD7wh5cplzDqLl;
	Sun, 10 May 2026 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=riseup.net; s=squak;
	t=1778431445; bh=cDBCDSiXpvET2XJyOFjfqyw5G0DnmnMMUfuclS7LHK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RRl8BJi4QTvXaTxsdADxVR4HogdBZYieU5H3FlSHu8cVlfxxLbPh/MYXUZ3gT3RT/
	 SxKV5ZpbzAuIqJMoF0mqO31BEoj8gg4aTAG2lMFUtBMm66Ze0hpTg9jdPQ1DmAeh8g
	 NaABhZanX2moCYpWfbiVX6Dbozp/YIicf9pPY11g=
X-Riseup-User-ID: 998381A68B107694913F38E59B8B9B4AB69066767B0BD33FE9FF442520EA5DCF
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4gD7wd0ZGSz1yZk;
	Sun, 10 May 2026 16:44:00 +0000 (UTC)
From: =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Filip Pokryvka <fpokryvk@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	=?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@riseup.net>
Subject: [PATCH net-next 1/5] netdevsim: Add ethtool get_link support
Date: Sun, 10 May 2026 18:43:33 +0200
Message-ID: <20260510164337.7611-2-ihuguet@riseup.net>
In-Reply-To: <20260510164337.7611-1-ihuguet@riseup.net>
References: <20260510164337.7611-1-ihuguet@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 084D65052C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.61 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.77)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[riseup.net,none];
	R_DKIM_ALLOW(-0.20)[riseup.net:s=squak];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286335-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[riseup.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@riseup.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:mid,riseup.net:dkim]
X-Rspamd-Action: no action

From: Filip Pokryvka <fpokryvk@redhat.com>

Add ethtool get_link callback to netdevsim. They are devices that have
the concept of a carrier, so it makes sense that it can be queried via
ethtool too, like ethernet devices.

Signed-off-by: Filip Pokryvka <fpokryvk@redhat.com>
---
 drivers/net/netdevsim/ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 36a201533aae..4d47eb989c24 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -209,6 +209,7 @@ static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
 	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
 					  ETHTOOL_RING_USE_HDS_THRS,
+	.get_link			= ethtool_op_get_link,
 	.get_pause_stats	        = nsim_get_pause_stats,
 	.get_pauseparam		        = nsim_get_pauseparam,
 	.set_pauseparam		        = nsim_set_pauseparam,
-- 
2.53.0


