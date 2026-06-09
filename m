Return-Path: <netdev+bounces-297246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sw0VLr9kKGrqDAMAu9opvQ
	(envelope-from <netdev+bounces-297246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F1663872
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="G4oofpY/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297246-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 967E8309C9C0
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5C94D8DA7;
	Tue,  9 Jun 2026 19:08:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCC4D2EF3
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:08:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032093; cv=none; b=mVULfuXBtqTXKA/b4VH1PES9FBiwdN/k19c3pW1ru1b/wutVteLW1W8fXXXpJt4nlQ+0EaCTQi4tXrDD+6TPlYHvIE13L9cXyR/3xn2h1i4zyPbmaX2/usVJl5ZV8eTUUSgtFiN3g+zyWgI1bVrPy344d+vlPvM35tKaGIv6GI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032093; c=relaxed/simple;
	bh=x1NwOU2N2pdU0syA2m2kuvNOsaWicJKJc6cO7rwl5jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XP4DBglrHq92Q1yIL2dp71Eh4+sp7z0KqSQNcVmGIHukh28iLc9VNf2w+JO7PyjWC/Qs5JxsgFRkLvtWSXap/OW2iqUl/+drNA6c8HaVbEdh178PVlcOg2PuWBZu96YH+ELnAjT14MBdt5ugINkTT9+TMm4fk18CN8hYkcpjldI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4oofpY/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FFC1F0089C;
	Tue,  9 Jun 2026 19:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032092;
	bh=7wOiIVEJvTrcnprZMoyo+F5xJjProJiCsE9kyJM4NBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4oofpY/J9cTPnDIpz5DyOiT38kMYYudK7HTmqhHgGfMwuFxdNaSfcSCJlmO6tBA9
	 iwlWO6e6mfa3W5Zp1louXWv4fZxww2dE8Fh9gOv0VVMt5vRzdqG/9jNnTgkQREY+ZN
	 QKTOM2OvTiFbp4R50AopboPdN7RZH2ZdP/THk7nfyVdA6jF8elOF+bvy4mLEtSE/nb
	 sHPOTYBoL7+sghn61MhhZ6yHoRCfR2nFN8ocwzoqbfb+Fvsgb1+IdjUuENwpj2xWV7
	 XzNfPqaoieOjgIHSM8z4t6ePPnHHbvZdOP6NCfq5dwaP3WgPb379AYV4xTbvQs879r
	 7bYUyWbkwgbKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	razor@blackwall.org,
	sdf@fomichev.me,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/4] netdev: don't use dev->flags for IFF_UP
Date: Tue,  9 Jun 2026 12:08:04 -0700
Message-ID: <20260609190804.1137085-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609190804.1137085-1-kuba@kernel.org>
References: <20260609190804.1137085-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297246-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 289F1663872

dev->flags are not technically ops lock protected. The IFF_UP flag
will not change when dev->lock is held, but other flags may change
so KCSAN would probably not be impressed. Because of this we added
a dedicated dev->up which is safe to read under dev->lock.

qstats want to make sure device is up, use dev->up.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev-genl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 18046ad0f883..745e2eb6c9af 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -773,7 +773,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 	const struct netdev_stat_ops *ops = netdev->stat_ops;
 	int i, err;
 
-	if (!(netdev->flags & IFF_UP))
+	if (!netdev->up)
 		return 0;
 
 	i = ctx->rxq_idx;
-- 
2.54.0


