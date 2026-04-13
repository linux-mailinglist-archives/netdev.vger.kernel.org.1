Return-Path: <netdev+bounces-278031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LaJOynI3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B63EABD0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 12:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 867F33046E9E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B47D3370FF;
	Mon, 13 Apr 2026 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TLU6M7EZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3B1A08A3
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076529; cv=none; b=MW3MTkRuoo6F9JK+v1koHllFrq1VXeev+VB1FmuZ91/Y72jceXi9SEzABY753pWpXOTQm+OB7vppOcp7Qymw+pxfIGv9kk+rNYVfmQ25X3YVqMfkzrQw1jQxnM+AQrlKlC6FJru+92bmuhy9jGbPLWyT6KDyeNgowppp6vst9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076529; c=relaxed/simple;
	bh=pmjkMioukLW5g1txgrEEVf7hs/e4o+qCrWbxN4mexf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVeoUCZK/cimy82cOhTcZgtukEcCMcOOE0iDwRvf++8MitnVa3FySwAgsj3U5of7Cv7/6DflhOhz3l1sZ5gvzNUHBm+In6tL/Jxa4FKncHBiqhlXSbICT4fQY6pQ8yxiVF/Yhx1g+q+jCz9jYiFl7hIRQwoXFyB1qgzRZk/vaJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TLU6M7EZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776076525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2nx21UCgkelQfmsgGrpgYKaWUBt9g94q5n1ek11K60=;
	b=TLU6M7EZpEWENJXRYelDVIHtE8KK2ObLsd+xeoeGm8lx4jzQ7/EOZcSjl4g0KSDNjk2pIV
	Flpzl/P0csbJEiorNDXfCNbqZQdsNbSytf6prfkV0w4KllQuxvZL6HzKCgnjurs/hVYty9
	3NtsWDQ3EGOMSB5+agTeH8HmDo89swA=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	fmaurer@redhat.com,
	horms@kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v6 2/2] net: hsr: reject unresolved interlink ifindex
Date: Mon, 13 Apr 2026 12:34:49 +0200
Message-ID: <20260413103449.169913-3-luka.gejak@linux.dev>
In-Reply-To: <20260413103449.169913-1-luka.gejak@linux.dev>
References: <20260413103449.169913-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278031-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 361B63EABD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

In hsr_newlink(), a provided but invalid IFLA_HSR_INTERLINK attribute
was silently ignored if __dev_get_by_index() returned NULL. This leads
to incorrect RedBox topology creation without notifying the user.

Fix this by returning -EINVAL and an extack message when the
interlink attribute is present but cannot be resolved.

Assisted-by: Gemini:Gemini-3.1-flash
Reviewed-by: Felix Maurer <fmaurer@redhat.com>
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
---
 net/hsr/hsr_netlink.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index db0b0af7a692..f0ca23da3ab9 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -76,9 +76,14 @@ static int hsr_newlink(struct net_device *dev,
 		return -EINVAL;
 	}
 
-	if (data[IFLA_HSR_INTERLINK])
+	if (data[IFLA_HSR_INTERLINK]) {
 		interlink = __dev_get_by_index(link_net,
 					       nla_get_u32(data[IFLA_HSR_INTERLINK]));
+		if (!interlink) {
+			NL_SET_ERR_MSG_MOD(extack, "Interlink does not exist");
+			return -EINVAL;
+		}
+	}
 
 	if (interlink && interlink == link[0]) {
 		NL_SET_ERR_MSG_MOD(extack, "Interlink and Slave1 are the same");
-- 
2.53.0


