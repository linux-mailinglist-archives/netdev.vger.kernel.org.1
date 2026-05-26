Return-Path: <netdev+bounces-291757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFo9KgLFFWqxawcAu9opvQ
	(envelope-from <netdev+bounces-291757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 028055D94CA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 853273112338
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF9377018;
	Tue, 26 May 2026 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdzijFiG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFC371D17
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809762; cv=none; b=LTXSsybyTAjpjTVb0cusb/BTLBJH/GFJ8Lgwu7rIwS1LKz+doHC3hqA0g9Akp+fcw0y7wGDvR/TxZcUUyzBt8mKq2Np/naZPg7IGunB7j4KpNbNPjsaGg2gTVLGCJi2enPlpGK6tZjX6cvsC2iRu2PTwKWMQ1tEBdNy/oEzj46g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809762; c=relaxed/simple;
	bh=3EhAbhkgcmk5382ypkBUbZ3XSu+54FLZWyI2yLnldWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjebZBzzGLAEGr2/i26v8gqm3GBcsiuetkFjSdLyvMROp0OeLZwABxImLXDYmMwmxxpYx+fki7xl732AjfKQhNQR7ZwQgJOgkZzyiyjxxycBbSAcS8g+H9BGhWavWGzexI2vdSADNlJenKGgiR4NeWQMvqT+OXfs6DyTZUrk1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdzijFiG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DAF1F00A3C;
	Tue, 26 May 2026 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809755;
	bh=18iR4P7xryhRqH+56uCBSVcaDxv3nz6Ko9WwPv276vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fdzijFiGBec2aWAi2RLlyL/ClIJddfi5VllIUe6DhAugLGmUI7OOiAbcm4mexjB7a
	 rWUEmXqNcbEjFn17Mwff0TX9AbbCa+0TKuTzLBM0lQEKcI5Xuyhdp/Zw7K+jGaqCMa
	 RdIKqzZVEkubXsFvcWiu14rLEw32WMsLTh+egw/qqJzPAM0CT984sb8x8i1ZSYiXHQ
	 T9lve4swXB6S3QD7OiN3bl7HZ60NPAHY3sJx3r7idGnRqhHeOTjR5LZOkglMplO4MW
	 m3z7+gJBM/XZeyv4+kvdKqoAUcR+PK4lTXtzUxWiVm0CUZO6FPAWu1Lekdf/I8R4x5
	 lcKCWXBIS7WdQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	haiyangz@microsoft.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch
Subject: [PATCH net 09/10] ethtool: eeprom: add missing ethnl_ops_begin() / _complete() during fallback
Date: Tue, 26 May 2026 08:35:32 -0700
Message-ID: <20260526153533.2779187-10-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526153533.2779187-1-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-291757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,page_data.data:url]
X-Rspamd-Queue-Id: 028055D94CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All ethtool driver op calls should be sandwiched between
ethnl_ops_begin() / ethnl_ops_complete(). In Netlink eeprom code,
if the paged access failed we fall back to old API, but we
first call _complete() and the fallback never does its own
ethnl_ops_begin(). Move the fallback into the _begin() / _complete()
section.

Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: andrew@lunn.ch
CC: maxime.chevallier@bootlin.com
---
 net/ethtool/eeprom.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index a557e3996c85..836316df3092 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -141,12 +141,11 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	return 0;
 
 err_ops:
+	if (ret == -EOPNOTSUPP)
+		ret = eeprom_fallback(request, reply);
 	ethnl_ops_complete(dev);
 err_free:
 	kfree(page_data.data);
-
-	if (ret == -EOPNOTSUPP)
-		return eeprom_fallback(request, reply);
 	return ret;
 }
 
-- 
2.54.0


