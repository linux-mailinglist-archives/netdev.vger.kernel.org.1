Return-Path: <netdev+bounces-280644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN9AHpLN6WkKkgIAu9opvQ
	(envelope-from <netdev+bounces-280644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317AE44E167
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A1E73074F6F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354C315D58;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGxc5/nF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C3E31079B;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930135; cv=none; b=rSxR+4N0TzaUPL53Fk0ZNmaTBSXwNRSz6aLbsyrl7Z/TLARE36IkpzXi2DWbhd66H0wZVhsfXg0B93e1F/Il+0uGY+ayP/2lLrzchfp6IumhHEIjSKn2ASgRs+0o94NOL2/gH/qKkOgZrUZbGfWGogL+i11lgH+/PNuDW6v6xaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930135; c=relaxed/simple;
	bh=z7L1y/lceWNcGtWDS9MvRXoRJYU0HgYaw9u3PFvDJok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVbXqEbQodaU34C20ZMAUjLW/gP2jKTTt04LNH1kfOeVU4n1H+hUpvr4/4IEzdvnHWCJLnGioC5GJmr/H4e1qawJ/W66sogF1hkm/kP0mEqNL4Y4op/QQBfwdzBBXoe+pWqmHsbQohdaS/XDW4aMf3xw+YSMsDYg5vjxO929Pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGxc5/nF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 862D8C2BCB7;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930135;
	bh=z7L1y/lceWNcGtWDS9MvRXoRJYU0HgYaw9u3PFvDJok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NGxc5/nFW8lNyT/dv2GXpRR2KxHjXt6MtTrjgIvoV4VOqQaSI0onUoW2SMJ7nvYMY
	 QnpRKIHwR+8p5s65Dx7mDrNbXd7HgnblzgGvqiQALPapc7kk/8uyAQwmuD13+aCNEs
	 nlcsigzRyIWgQ/6VkSa8jwOhPhcHSmkYpwjE9fSw+ppXMc12283FP1lT2zmbtl+OrU
	 756LK96NYFFgMewVMk4ifFMIsUS4HL7DaMcoOIHhxb8sjK177F84lstKIDV7AeRdQ5
	 yexvgAEXgJLFA5g60cMcUTanaT9cAlGQtp1hAQgxMjku2dg914CBWXg+VCVjK0Bfzv
	 AiCP2V0/7znlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77472F9934F;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
From: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Date: Thu, 23 Apr 2026 01:42:16 -0600
Subject: [PATCH RFC net-next 3/4] net: pse-pd: fire lifecycle events on
 controller register/unregister
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-pse-notifier-decouple-v1-3-86ed750a9d62@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Corey Leavitt <corey@leavitt.info>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776930134; l=1536;
 i=corey@leavitt.info; s=default; h=from:subject:message-id;
 bh=MOnFN08SYHgfOekYGnbnF8wDziGnDMovMc1cNiCo+D8=;
 b=IUOXxGgqd7R2ArRe+iXdztqayIZwufjmynyMcSsq84IiA15zdQNGk7q1KjJ6DOKNsF8p6Hor/
 OLbqnLpd4jXAqXRcQvoPT0J9acMSe3u1Q4Fqwvs5NjOjo49vTHcvUc7
X-Developer-Key: i=corey@leavitt.info; a=ed25519;
 pk=Q3mmZT+4CRYT8qp8RWvab30X2v2JnLdhHuK7YIHKzpI=
X-Endpoint-Received: by B4 Relay for corey@leavitt.info/default with
 auth_id=748
X-Original-From: Corey Leavitt <corey@leavitt.info>
Reply-To: corey@leavitt.info
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280644-lists,netdev=lfdr.de,corey.leavitt.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[corey@leavitt.info];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[leavitt.info:email,leavitt.info:replyto,leavitt.info:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 317AE44E167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Corey Leavitt <corey@leavitt.info>

Hook the newly-introduced pse_controller_notifier chain so that
pse_controller_register() fires PSE_REGISTERED after the controller
has been added to pse_controller_list (i.e. is now resolvable by
of_pse_control_get()), and pse_controller_unregister() fires
PSE_UNREGISTERED before the controller is removed from the list
(while it is still valid to dereference from a subscriber's
pse_control pointer targeting it).

With no subscribers yet, this is observably a no-op. A later change
wires the phy subsystem in as the first subscriber.

Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
 drivers/net/pse-pd/pse_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 80c5c6c1758c..82125502a8e3 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1138,6 +1138,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
 	list_add(&pcdev->list, &pse_controller_list);
 	mutex_unlock(&pse_list_mutex);
 
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_REGISTERED, pcdev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pse_controller_register);
@@ -1148,6 +1151,9 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
  */
 void pse_controller_unregister(struct pse_controller_dev *pcdev)
 {
+	blocking_notifier_call_chain(&pse_controller_notifier,
+				     PSE_UNREGISTERED, pcdev);
+
 	pse_flush_pw_ds(pcdev);
 	pse_release_pis(pcdev);
 	if (pcdev->irq)

-- 
2.53.0



