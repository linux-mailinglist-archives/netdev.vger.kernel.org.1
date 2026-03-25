Return-Path: <netdev+bounces-271654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KFmEsUOxGk+vgQAu9opvQ
	(envelope-from <netdev+bounces-271654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:35:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7383291BA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73F053081ABA
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 16:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD83401A12;
	Wed, 25 Mar 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHn/zBJs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27734401498;
	Wed, 25 Mar 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456207; cv=none; b=tH0ceFubhmA5CDNVKNBns8sEyzIxQ3RYVJq2SRlIx5FsxpD7UXX+JkpNYPDamWHRf3dJxFxtM/ZJibUjPOQ8cJPk/+vnjDWPwZWaan8DlY2tp/qDgftfMG1VdJuG7OgXozHQm3EMPQTDOZ+/NKYLAMwXaxUrNrcVDVTfX5Lyxao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456207; c=relaxed/simple;
	bh=SI/nbinYmlv3ClOdOqznxnr/ym+iNX3LvdqOnIkrfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQ+cV+MdG16FikcNABzYWaY6v7gabOn+MJ2Q4F0pojRSiax3nKF7O2gPLfumPbLpHL3VEz1M9wn7bE2vjth8iGnPFmSHacbEXkbfcqFhl9zn2m6K085Eaj9gZf9gJD/Hx/LTU2kLLm8RWpPs/ushWSQamsouTGagcLHPvGJdsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHn/zBJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A28CC19423;
	Wed, 25 Mar 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456206;
	bh=SI/nbinYmlv3ClOdOqznxnr/ym+iNX3LvdqOnIkrfeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eHn/zBJs7vzQAN7B5DQNCZUjQ4lyOWZnuSCYnWAbKPdHuFIcLJ3vbjwIf/7fSyLk1
	 V+OSH3jweZ9DR1PetGAKSKtiUFdKcopIlN0UP7A+XUyA1nvLlWCNSete1rhs7BAN31
	 +ouqSX4OPTHEJZAub6aRwWV2RvBJ4wIcmotlNgB5QA97+HIW75iLW+c0eehdcWzD4t
	 q8+f09QY798P4VwHNcMZK6iXVlhijXLuDb16W56LNQkWN8oN6fd+/FCFJL98Sm0gTF
	 Xc8Gq3eAmpoa2X9tYyzU6iNkGiWyMgPtQQFJ5ZuyLxn2s6q0gGo7ycA5vFKL/7eEj7
	 Qsdiq/ROGL55g==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Ryan.Wanner@microchip.com,
	Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net-next v5 13/14] net: macb: set MACB_CAPS_USRIO_DISABLED if no usrio config is provided
Date: Wed, 25 Mar 2026 16:28:17 +0000
Message-ID: <20260325-husband-cape-ec4945b9184c@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-unsterile-flail-4c7729750dc4@spud>
References: <20260325-unsterile-flail-4c7729750dc4@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=wWQAgoUtn0mz+g0O0PGK24RiTXGyZCFOTNhrOE5r3kY=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJlHeM2/7rnyJl5+UuW/7c0d5bNDy2pbTimn/v8lffRxq ElFzrrEjlIWBjEuBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAEzk5TSGfyaCsw4yK9xgO7lF 8vnMh31Ll88waJEIsd/948iLm+v2ffBjZFg+SbI8dZrw0XP6pR8bfjKy3ZSU1d/R4VG6JN6aYd0 3U0YA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,microchip.com,lunn.ch,davemloft.net,google.com,redhat.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,tuxon.dev,gmail.com,sifive.com,vger.kernel.org,lists.infradead.org,raspberrypi.com,linux.dev,amd.com,bootlin.com];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 1B7383291BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Théo Lebrun <theo.lebrun@bootlin.com>

bp->usrio is copied directly from dt_conf->usrio in macb_probe().

If dt_conf->usrio is NULL, we do not want to land in USRIO write
codepaths which dereference bp->usrio. Inherit automatically
MACB_CAPS_USRIO_DISABLED to avoid those.

This means a macb_config that wants to disable usrio can simply drop
its .usrio field, rather than add the disabled capability explicitly.

Nit: drop the dt_conf NULL check because the pointer is always valid.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index b9791bbbec8bf..9befb268ed79e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4577,8 +4577,10 @@ static void macb_configure_caps(struct macb *bp,
 {
 	u32 dcfg;
 
-	if (dt_conf)
-		bp->caps = dt_conf->caps;
+	bp->caps = dt_conf->caps;
+
+	if (!dt_conf->usrio)
+		bp->caps |= MACB_CAPS_USRIO_DISABLED;
 
 	if (hw_is_gem(bp->regs, bp->native_io)) {
 		bp->caps |= MACB_CAPS_MACB_IS_GEM;
-- 
2.53.0


