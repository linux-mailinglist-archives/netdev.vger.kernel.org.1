Return-Path: <netdev+bounces-259100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFbyKr6YlGlOFwIAu9opvQ
	(envelope-from <netdev+bounces-259100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:35:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729DD14E43A
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D0F33015DAF
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 16:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781437106F;
	Tue, 17 Feb 2026 16:33:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9393D36EA95;
	Tue, 17 Feb 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346001; cv=none; b=qx/SvKxfwNCr4fKEEfFesNGP6eWf/TWOoE/C2HY+sbj5m7QZlky5oKYqA/aXq8T3QgVlTxSf/e0kCNAfVka7l0bxP7PzeJTM/JbW/ROBz8G+Ylpnda6mhXo3OC80RWqGoXzFIoyGL5/MWZxwFZSh5q7Xv+yVQtmqnw1IHIU9cQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346001; c=relaxed/simple;
	bh=fPkas7wFQs96+aNOpMbmbcM2fGDzBggtocSFqi/crUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VA/JPyE085PXgXyt4SZ+ryoF99jE6KzEkRLeKykjN0OpnYNJC7zm5vn64QK6t9b7zPi0TLAvR2nDILOlkmklDS+/Jq7U4K46AwN9pnFUEU5Ym6m8zRVM89rWN7OgyquUmZ/qPhlXlUwCTZQledJk2/f/1EvGhhWQDkWeLzDqoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2D50160CF9; Tue, 17 Feb 2026 17:33:19 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 09/10] net: remove WARN_ON_ONCE when accessing forward path array
Date: Tue, 17 Feb 2026 17:32:32 +0100
Message-ID: <20260217163233.31455-10-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260217163233.31455-1-fw@strlen.de>
References: <20260217163233.31455-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-259100-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,strlen.de:mid,strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 729DD14E43A
X-Rspamd-Action: no action

From: Pablo Neira Ayuso <pablo@netfilter.org>

Although unlikely, recent support for IPIP tunnels increases chances of
reaching this WARN_ON_ONCE if userspace manages to build a sufficiently
long forward path.

Remove it.

Fixes: ddb94eafab8b ("net: resolve forwarding path from virtual netdevice and HW destination address")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 96f89eb797e8..096b3ff13f6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -744,7 +744,7 @@ static struct net_device_path *dev_fwd_path(struct net_device_path_stack *stack)
 {
 	int k = stack->num_paths++;
 
-	if (WARN_ON_ONCE(k >= NET_DEVICE_PATH_STACK_MAX))
+	if (k >= NET_DEVICE_PATH_STACK_MAX)
 		return NULL;
 
 	return &stack->path[k];
-- 
2.52.0


