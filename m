Return-Path: <netdev+bounces-289892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCBlMQWZDWrKzwUAu9opvQ
	(envelope-from <netdev+bounces-289892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:20:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2F758C43A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9E983047E87
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D3371063;
	Wed, 20 May 2026 11:18:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3F39C636;
	Wed, 20 May 2026 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275937; cv=none; b=ay53chJmYCF9m8sY+HBLjjVWN5aIlEueVpDnHqRJElF8VcPIMd0H+XhFeengLZVdJSXju3dhfAXV16l8dergfxnBNDCnjethKU9dmVaDhf8nku/7R5rxPzuocCv4QvWU0BVv/IvqPkPBR2kEMM9nS7HX17gb9taKJaKTU6YSCGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275937; c=relaxed/simple;
	bh=rhroXm6SCr/NQ8PxGDprYub37B17PaAS4WvIeJrIifg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yr6/6S+j+B1BtJeEAH6RypOlrIz1uSjeI2NIwlU0u0WSwourivIm+ZoOP9chqUVJ/Tm6CfbkyCsS3jToPmPP1uprBLyNLBkZ5eTBZz61siQrcPb7UdlPTXdT+ryPmP1SzbrIv4nyhjp9uU9vMk05PDi2AD/OcqtkXShwNTSBtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9985192009E; Wed, 20 May 2026 13:18:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 92B5692009B;
	Wed, 20 May 2026 12:18:53 +0100 (BST)
Date: Wed, 20 May 2026 12:18:53 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/5] ethernet: 3c509: Fix AUI transceiver type
 selection
In-Reply-To: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2605201205160.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
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
	TAGGED_FROM(0.00)[bounces-289892-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[angie.orcam.me.uk:mid,orcam.me.uk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3A2F758C43A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The transceiver type is held in bits 15:14 of the Address Configuration
Register, with the values of 0b00, 0b01, and 0b11 denoting TP, AUI, and
BNC types respectively.  Therefore switching from BNC to AUI requires
bits to be cleared before setting bit 14 or the setting won't change.

NB this has always been wrong ever since this code was added in 2.5.42.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/ethernet/3com/3c509.c |    1 +
 1 file changed, 1 insertion(+)

linux-3c509-aui.diff
Index: linux-3c509/drivers/net/ethernet/3com/3c509.c
===================================================================
--- linux-3c509.orig/drivers/net/ethernet/3com/3c509.c
+++ linux-3c509/drivers/net/ethernet/3com/3c509.c
@@ -1099,6 +1099,7 @@ el3_netdev_set_ecmd(struct net_device *d
 		dev->if_port = 0;
 		break;
 	case PORT_AUI:
+		tmp &= ~(3<<14);
 		tmp |= (1<<14);
 		dev->if_port = 1;
 		break;

