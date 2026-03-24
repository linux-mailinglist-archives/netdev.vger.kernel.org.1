Return-Path: <netdev+bounces-271103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHxQNCGiwmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:39:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F030A4F4
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 076B33005A98
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA13FFADD;
	Tue, 24 Mar 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hHchKIP8"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156633FF8B8
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362936; cv=none; b=i0jFo4iASfAvVscHSqF27AcLzeocpNoG58xHZ7UyEQIB0oF09UC9XWZI5SEO1Ql4uoEOX/zwXvH6m/icZitku4lomuF7GEWy+la222OeYzlYSAK23n4VPuPldQhe9iXlDxsk1U9Bgrayeuo56JXvmCM92Xt1didQI82XlFgs2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362936; c=relaxed/simple;
	bh=UXQRM9wPy6fMaUJanJ7vYy07rD58WnCTEhEDvqmvetg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNtfeBVGm5cuRvG+3+mYLMKHu0oyxLHYD/9//1+ffR02N6IHLh//9apcAU3q6DNOqCBuvdRC86M/TPwefpeluvFL9bmAHUIY1MoSKsEGo/tUQMAuLAnSAksmBRVpeDrxQGP++xYy9l3u/Z651EgFmgzljSWn8CYe2IVctsA3KDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hHchKIP8; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774362933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SQUW0t/0hMtrnhu+SjPyBSdGN05qqOMq7wnGBco7zp8=;
	b=hHchKIP8mrngisfgAgSyAJ26DObVNiyz3Z9gz3N8kVLPW6MhgUThZFx4fh1Ozz3MewXEw5
	gP+6gWMj+CuUDM9EGsVknhGUxDCXD4DzmJ6Rj73PKF8sLDX5niIMwP/s7GpfffUVRLlkDY
	/Y37GDC6NkoDyy7x5gUcKbjRiEUR+MY=
From: luka.gejak@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	fmaurer@redhat.com,
	liuhangbin@gmail.com,
	bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org,
	Luka Gejak <luka.gejak@linux.dev>
Subject: [PATCH net-next v1 4/4] net: hsr: reject unresolved interlink ifindex
Date: Tue, 24 Mar 2026 15:35:03 +0100
Message-ID: <20260324143503.187642-5-luka.gejak@linux.dev>
In-Reply-To: <20260324143503.187642-1-luka.gejak@linux.dev>
References: <20260324143503.187642-1-luka.gejak@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linutronix.de,vger.kernel.org,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271103-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 713F030A4F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luka Gejak <luka.gejak@linux.dev>

In hsr_newlink(), a provided but invalid IFLA_HSR_INTERLINK attribute
was silently ignored if __dev_get_by_index() returned NULL. This leads
to incorrect RedBox topology creation without notifying the user.

Fix this by returning -EINVAL and an extack message when the
interlink attribute is present but cannot be resolved.

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


