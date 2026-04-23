Return-Path: <netdev+bounces-280646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +A4/GZfN6WkKkgIAu9opvQ
	(envelope-from <netdev+bounces-280646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E63AB44E16E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 024323076C89
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FC431691C;
	Thu, 23 Apr 2026 07:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrboMypB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB6310785;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776930135; cv=none; b=ksaPklFycg+gu6Wsty63BnmCuXO16qeG5PWE3ZKu2bWoIAB/oQVbkmfq3PXrGFQr9xt1ZCylQmWIDrjdjUqWIA8iJQQmOFF3XR1vTPzyg4iqB+yKM7acPeKlUpj9RM+A9wxQk0b5n5eVrXi82Z5oBr3LBb/P11EEtZHQrplhOio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776930135; c=relaxed/simple;
	bh=Ojf2szpvgGjvfr/gigW/pG0LU6lpL971MAn0v2jqSP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYu6naOsCDBMPirmwtsM5SkYF0NjjXLwr1G7kEddoijWAj/eUhNgOIHvmyQAVHt9xMEpkNfNcEU+dAhA/dZAOjcxn/Aj/q53FN+7W3+0LFqY5kbWwrnsj1cq5s14JhUMVuOsVSl31mz0bq2Gf/jEtXmPUiPjaUQayu2PEwOAcRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrboMypB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6928AC2BCAF;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776930135;
	bh=Ojf2szpvgGjvfr/gigW/pG0LU6lpL971MAn0v2jqSP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UrboMypBEjrZTVEvd2UX6eupsf+UE1stak3mJNs5hz5zzEyyT+dCTFONAdIbKpbUo
	 F+LPm/RHEJCm9vZjdGr0vvUkYNGB7+7Ie1jf/B02Nlb6Fckj6Kyst9Bp4937JzvpIT
	 DFJgsGwzzISagym+2xLtcheiyYxvJwwAv3GnL1KqNGsgixYF7Yhxq3CDytq4b0nwIv
	 SkJuRbt8pJ6+0/zt7tAKfKV2JNa0nWYNdne0FTqynxzwp7i19J3NnE7o2CZCUy/ftn
	 chifZZ4t60SPMuUQB7K/WPXC1F1t+iRAy2+EEWL0+atSocMalPSGz2wOmbKSTbV2B2
	 7gjRYvqv1VluA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524C3F99340;
	Thu, 23 Apr 2026 07:42:15 +0000 (UTC)
From: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Date: Thu, 23 Apr 2026 01:42:14 -0600
Subject: [PATCH RFC net-next 1/4] net: pse-pd: scope pse_control regulator
 handle to kref lifetime
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-pse-notifier-decouple-v1-1-86ed750a9d62@leavitt.info>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776930134; l=2530;
 i=corey@leavitt.info; s=default; h=from:subject:message-id;
 bh=1SkINJ/nZBrraccoAmh/b7VGiZC9fvXohnssgn1M1aQ=;
 b=DJqNV0oJz/qT88y7/6+YzTfu6gTeAUnhGF+c3jLz9zwDFcRq+OmnIiibYstzqYB9CadmgTgCE
 +Q1xmsDzvqrD2FpJkevcaZ/yu17seQ/3wNEWPP8ky+WWP3nZYVoxkas
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
	TAGGED_FROM(0.00)[bounces-280646-lists,netdev=lfdr.de,corey.leavitt.info];
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
X-Rspamd-Queue-Id: E63AB44E16E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Corey Leavitt <corey@leavitt.info>

__pse_control_release() drops psec->ps via devm_regulator_put(), which
only succeeds if the devres entry added by the matching
devm_regulator_get_exclusive() is still present on pcdev->dev at the
time the pse_control's kref hits zero.

In practice that assumption does not hold when the controller is
unbound while any pse_control still has consumers: pcdev->dev's
devres list is released LIFO, so every per-attach regulator-GET
devres runs (and regulator_put()s the underlying regulator) before
pse_controller_unregister() itself is invoked. Any later
pse_control_put() from that unbind path then reads psec->ps as a
dangling pointer inside devm_regulator_put() and WARNs at
drivers/regulator/devres.c:232 (devres_release() fails to find the
already-released match).

The pse_control's consumer handle is logically scoped to the
pse_control's refcount, not to pcdev->dev's devres lifetime. Switch
to the plain regulator_get_exclusive() / regulator_put() pair so
__pse_control_release() does the right put regardless of whether
the controller's devres has already been unwound.

No change to the regulator-framework-visible refcount or lifetime of
the underlying regulator: a single get paired with a single put. The
existing devm_regulator_register() for the per-PI rails is unchanged
(those ARE correctly scoped to the controller's lifetime).

Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
Signed-off-by: Corey Leavitt <corey@leavitt.info>
---
 drivers/net/pse-pd/pse_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index f6b94ac7a68a..893ec2185947 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1362,7 +1362,7 @@ static void __pse_control_release(struct kref *kref)
 
 	if (psec->pcdev->pi[psec->id].admin_state_enabled)
 		regulator_disable(psec->ps);
-	devm_regulator_put(psec->ps);
+	regulator_put(psec->ps);
 
 	module_put(psec->pcdev->owner);
 
@@ -1431,8 +1431,8 @@ pse_control_get_internal(struct pse_controller_dev *pcdev, unsigned int index,
 		goto free_psec;
 
 	pcdev->pi[index].admin_state_enabled = ret;
-	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
-						rdev_get_name(pcdev->pi[index].rdev));
+	psec->ps = regulator_get_exclusive(pcdev->dev,
+					   rdev_get_name(pcdev->pi[index].rdev));
 	if (IS_ERR(psec->ps)) {
 		ret = PTR_ERR(psec->ps);
 		goto put_module;

-- 
2.53.0



