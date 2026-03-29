Return-Path: <netdev+bounces-272962-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMkxCmZqyWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272962-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:07:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD0353897
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D23933002D14
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314BE3859D3;
	Sun, 29 Mar 2026 18:07:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEABD2877DE;
	Sun, 29 Mar 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807648; cv=none; b=ckCJoe+sXBPaiYSc46P5PjgaXsNKSumkdgGpUbgA4qcGmun9F6KVlfmYmyR0fvMDzLFZ8OZ1davOoJIhVqEMQRQwBcyi9hgG5/3lQ6NlczdwiIoWnQyulhMbL5aAywFRAf3AToaocu7MyXdOB89LCtvqf/XfE8mJmzBLpOmlvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807648; c=relaxed/simple;
	bh=K2TUS5wPF64bHYLFmBfA6rSe0bvnHVuBKXQ/xFiyLQE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m0YQq6vIbG313A7oVTZ3lj603XtIeF1Ht24mtyWd+Gb4ue1EcRg/amC4HYl0mfDxVa4GkGSm2Wo1yDyUzwgYYdxNUaGK3bFLCokc149BW4Yx0YUa/zOG+91+b2FjuEcb/nLOCfVsJNYrvZrHo2RXogJii1uNz3pbPvmldeM+EIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id A1C8792009D; Sun, 29 Mar 2026 20:07:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9B4FB92009B;
	Sun, 29 Mar 2026 19:07:24 +0100 (BST)
Date: Sun, 29 Mar 2026 19:07:24 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] declance: Rate-limit DMA errors
In-Reply-To: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2603291838370.60268@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272962-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,orcam.me.uk:email]
X-Rspamd-Queue-Id: 77AD0353897
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prevent the system from becoming unusable due to a flood of DMA error
messages.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
No change from v1.
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
 

