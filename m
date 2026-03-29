Return-Path: <netdev+bounces-272889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAEyBP4byWnHugUAu9opvQ
	(envelope-from <netdev+bounces-272889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D75351EB9
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3742F3005157
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D59364EA7;
	Sun, 29 Mar 2026 12:32:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECC9F9D9;
	Sun, 29 Mar 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787573; cv=none; b=Osf7si/fCuR1sP7/L9bX7vvFnEHUc2Xts0cj+0EbyogErIpmPQnrM/GSODfMmRzYsTh0i2RtMrRycM7YU6hZGQ1k1whSaF6sMMF8M/cnzK58VB+7nTqzFCdfHpllGJLrdbqHA1AYb1qU7DLPsKo+B8dNOrQhyRY+VdWGndx86DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787573; c=relaxed/simple;
	bh=sukW0mVRC0HkGydmkMxneEH0cG5b+882rL4crifTwl4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aVlnnN5mZAveyjRceDpafzDEL6Ru7VSlTmxOKSCSoEIijgk6bqmXD48J9BGSDPCajJqWK8dRYAxUJvUy0p48b7aRt5fmMc55MSATP0JrkrhqAEwyukaRiGuMurWtOeHXXZ+ecwLvoQZ0e+JCOzeCPDamoM7vn7XcBu0pUMxP++c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8EB519200B4; Sun, 29 Mar 2026 14:32:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 87BEF9200B3;
	Sun, 29 Mar 2026 13:32:51 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:51 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] declance: Rate-limit DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291303190.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.953];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orcam.me.uk:email]
X-Rspamd-Queue-Id: 53D75351EB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prevent the system from becoming unusable due to a flood of DMA error
messages.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/amd/declance.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-declance-ratelimit.diff
Index: linux-macro/drivers/net/ethernet/amd/declance.c
===================================================================
--- linux-macro.orig/drivers/net/ethernet/amd/declance.c
+++ linux-macro/drivers/net/ethernet/amd/declance.c
@@ -727,7 +727,7 @@ static irqreturn_t lance_dma_merr_int(in
 {
 	struct net_device *dev = dev_id;
 
-	printk(KERN_ERR "%s: DMA error\n", dev->name);
+	pr_err_ratelimited("%s: DMA error\n", dev->name);
 	return IRQ_HANDLED;
 }
 

