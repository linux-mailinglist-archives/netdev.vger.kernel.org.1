Return-Path: <netdev+bounces-299035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XteYFZ25LWp6jAQAu9opvQ
	(envelope-from <netdev+bounces-299035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:12:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C35F67F9A6
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=JcJfzkHk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299035-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299035-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF2473004422
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FB3A6EE5;
	Sat, 13 Jun 2026 20:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3C3033D6
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381449; cv=none; b=FQ9RXPg7IGUByq43MWPMAe3AXHnUb+ODHNWhUnIe6P60HtX9WVgct06NQSPUPcrTCphTRa8gtk1h4YVjKJyWGdZelOJLeD1XVjBNxU8FdgQK6YAaYoMgPgLGEzNDlncgY/f+EZl0zKtyd0tQGOxxxzcyWb52T46cRyseSRJsL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381449; c=relaxed/simple;
	bh=hIwZ98wdyz5Z3WynC8kedtzD3QGzK176gvhUplBf3c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp2hWVAwOzg27u3/gEFCqYg8560HQOuAYPsHYla2D3wXkyAKdWdfkZcpNNpRqnM7cpSRGwmooA8WwfW6x4w9ezD+UUwqr3Qan+q9shcNRQ5NMUFM0Mc/i5+adr0J+BwmOzxJYJGPhXSIDOLsY+wdx1BYW+JGakihjVDmuITihPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcJfzkHk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A431F00A3D;
	Sat, 13 Jun 2026 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381447;
	bh=KjUaeoCK4UcdkXyIGEv6ZVHLHgMJ8W+Juf6AeoDotNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcJfzkHkDAjlzJE5/hex2mqQtRLLNXgxWN268TVYQ0JDRoPusmMV6QaLxKRGtVFFC
	 bxS0VmAlE7nheVBEr4B9H+VUu2P3PmzJqCOTjLQ9Nn8XpE84WJeL3+LCfqVnpmzPLC
	 7RuxLRPSs7o7ttjStuZ7N5rdXljdI/XnwSxd460469+pAHUjaEJ2XeA014Nqvl9wot
	 pLfxlX0RbTnJQMmmY9Adxp9SaEYxuWSmZ6f3FsSbC6APmDkuPIFMXOIGaGrtvVKntM
	 Z8YFlzFzeJLdAtPNlhvHLZZ0EDqH8+bJDqUHaY8HowUYR3veeynMnWV0bed2Sfd33G
	 YWhPRZK5njjTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/9] atm: remove unused ATM PHY operations
Date: Sat, 13 Jun 2026 13:10:31 -0700
Message-ID: <20260613201032.77274-9-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299035-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C35F67F9A6

The PHY operations are vestiges of the SAR/framer split used by the
removed PCI/SBUS ATM adapters:

 - atmdev_ops::phy_put / ::phy_get (register accessors) are never called
   by the core and solos-pci only listed them as NULL
 - struct atmphy_ops and atm_dev::phy have no users at all - nothing
   assigns or dereferences them

Remove all of them. atm_dev::phy_data is kept: solos-pci repurposes it
to stash its per-port channel index.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atmdev.h  | 12 ------------
 drivers/atm/solos-pci.c |  2 --
 2 files changed, 14 deletions(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 96ce36e02247..fe21d2f547b5 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -107,8 +107,6 @@ static inline struct sock *sk_atm(struct atm_vcc *vcc)
 
 struct atm_dev {
 	const struct atmdev_ops *ops;	/* device operations; NULL if unused */
-	const struct atmphy_ops *phy;	/* PHY operations, may be undefined */
-					/* (NULL) */
 	const char	*type;		/* device type name */
 	int		number;		/* device index */
 	void		*dev_data;	/* per-device data */
@@ -138,20 +136,10 @@ struct atmdev_ops { /* only send is required */
 			    void __user *arg);
 #endif
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
-	void (*phy_put)(struct atm_dev *dev,unsigned char value,
-	    unsigned long addr);
-	unsigned char (*phy_get)(struct atm_dev *dev,unsigned long addr);
 	int (*proc_read)(struct atm_dev *dev,loff_t *pos,char *page);
 	struct module *owner;
 };
 
-struct atmphy_ops {
-	int (*start)(struct atm_dev *dev);
-	int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void __user *arg);
-	void (*interrupt)(struct atm_dev *dev);
-	int (*stop)(struct atm_dev *dev);
-};
-
 struct atm_skb_data {
 	struct atm_vcc	*vcc;		/* ATM VCC */
 	unsigned long	atm_options;	/* ATM layer options */
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 9c246b956c30..fc0e91a1029e 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1180,8 +1180,6 @@ static const struct atmdev_ops fpga_ops = {
 	.close =	pclose,
 	.ioctl =	NULL,
 	.send =		psend,
-	.phy_put =	NULL,
-	.phy_get =	NULL,
 	.proc_read =	NULL,
 	.owner =	THIS_MODULE
 };
-- 
2.54.0


