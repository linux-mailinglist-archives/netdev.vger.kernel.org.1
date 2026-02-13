Return-Path: <netdev+bounces-258562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDooKNeujmkUDwEAu9opvQ
	(envelope-from <netdev+bounces-258562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 05:55:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C06132EA3
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 05:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32466305D1C8
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 04:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFBC2505AA;
	Fri, 13 Feb 2026 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0xSIcyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F067E0FF
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770958548; cv=none; b=gkD6mOSGeB2eSrW7TP9TqyTrluuWfIUo4zohjxQiItl1ceNRhWy87Rfk+26xR2fAEaCfJ0HFjCMye8x/IRYrfM2l+N/vgLW+CPBKs4e16N8V6TKgbm/efu6yZMPlgvqAELD7vrg8D80eaO2fkoVb1Tq0esYZPeMEgD4SxtrUc3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770958548; c=relaxed/simple;
	bh=S3UQ0I6GAAFw2ZrsUNcDfOuA6jQgRQzkcE2bZIN6tC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEzrsy2lcSUMCdZzN+lYpJ/wPccWCtCfwQMR9NfvmskB+mfHlA7V+h4FpAxEzIMHp9/CjsFoMrk8wCPxEg6udwqby34HFrAP7tQ6KC3B8iB8N5ZB/BowZpAmJJB2022IuD4zI7ya4ftFAcIxDW2RiuZ0va0Oj8bxoVMPhL9GHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0xSIcyk; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso540966eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 20:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770958546; x=1771563346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=En+pLxpA/9SkcB4JG3FQxxc277chmMll4kOR/JIga7g=;
        b=b0xSIcyk8H6bz3AohA4TczmD+8bP0JUPSGEWFU2cWUv2D/+Ci0iktzYmC8dR593u2i
         DsltwxON5k2f6LxOxEh2sZqiIY+6l7RY9+r1FrvwDkTqCCnuZsVcu0dEiGknwjilpVVw
         8d104roK2G5Wqv+/ek3JgAdcCJQ8uV09ClZ1EtQbTRWtvw9vP4Ok/745wh7eaAS2QZRP
         rlZxXAoSjicZJ5kG5DZxs4fL3zengxuL9uvHAapYUOtw1HUADtzbuoWBFPDXRu2EcPNJ
         hoxq4gCJhsUY+YEuFOASMyuMfuvxXHcEzF+BYWCbyvnPwmKs9D7HTrTicnFUSdKzQaNI
         RPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770958546; x=1771563346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En+pLxpA/9SkcB4JG3FQxxc277chmMll4kOR/JIga7g=;
        b=JpAThuX1ap5pVOOxBCjRDVLr8mNMA0LDb6jmNMlvSFI9HGjRDWVSSUj+atQByNb3mR
         iiHfg8FP0JcJuiVtWmkMIQLDcAtC03eRVfE9POmH2grYaINuQLr9Oz2sSXI+l5lJjfup
         k67h84M/nPuhNOzJZvDj/FlZUOdhhuGN/wkjSMI2G8c6yxqBTmgCn23JaKrtg/d3BRJT
         egFUD2RDQCY8gxKVqDTLMOZeQRaTAYOBBWqmlQk/TyzNBoSaOJ0KVDGCXeVyNGAGOWXB
         WNJXBwmnS82SfKtax6tyA20ew/fwNR4ZrjkOfGhLw3qch3oIAJrvKVLCKxGTXb2AW/e0
         Ll9w==
X-Gm-Message-State: AOJu0YzAxU2cUEo0ipc4xpPyglGy+m/ycEoXVQ3n9R5ooNKvGvgM0DqE
	s6VmGc3Bngx1uF9BWPqC7v6sBhA2XgTraT7jqjjWewH1/K5amC3esB3V836O9SJJ
X-Gm-Gg: AZuq6aLvd6a0SQyOj7Ifspq++xP4OAVazXGGt1fYzawto3NVgLdgNZaUW9XrA+9GgJD
	vvYL0Sy5olCcU35M8FXyIIZAR42os4FPjg5QYVkQU7omQnx/9DZ4pM4C3+H31imEIPDFAcUTZfj
	ZogGa6mf64MUqX738f+oEez+VHVPArt3TOP02nXfX6sdExHF5aPu6tPhNDMJPGn5GF1TI1YGBeX
	M0BmnCvTyHXWvGLv5YUUueNibjPhMMhPFS4BYx375YchjD+x7ouGq83Vrm49EccrHBUoZl37E2l
	LEa6vGqdXXIytz2+/ZD4GkK/afk5BX5ZroH3/SCr0gWAMGHe1AuKQaN153WWUsaGSVpBqoeU9N6
	W3wjikmcN2vXs0IbSQe58REV0VQ7EdTUsDWXxAbW09x8+oD8+r5IzBNdAwqHfQx+O2uUGj2qUt1
	2IDlTARHPGLgM88jRNGPsJzk2HZRN24gDJcKKl2EPkQm6dqRD1QA9zNszS1ww1rtKZOndbZ4dvf
	ZsWIos396NA3dc0WvuA6ZyVnTyngWMcdJ8Rv9P59o6SPK7/jM+1K6Ez3SPAWq4DLza/seapd3jI
	uCz1drbi+BU/PJfbrA==
X-Received: by 2002:a05:7300:80d6:b0:2ba:14a6:c96f with SMTP id 5a478bee46e88-2babc47c424mr211119eec.36.1770958546131;
        Thu, 12 Feb 2026 20:55:46 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd03d8sm4846139eec.21.2026.02.12.20.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 20:55:45 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v3] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
Date: Thu, 12 Feb 2026 20:55:09 -0800
Message-ID: <20260213045510.32368-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258562-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0C06132EA3
X-Rspamd-Action: no action

Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
converted the com20020-pci driver to use a card info structure instead
of a single flag mask in driver_data. However, it failed to take into
account that in the original code, driver_data of 0 indicates a card
with no special flags, not a card that should not have any card info
structure. This introduced a null pointer dereference when cards with
no flags were probed.

Commit bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in
com20020pci_probe()") then papered over this issue by rejecting cards
with no driver_data instead of resolving the problem at its source.

Fix the original issue by introducing a new card info structure for
2.5Mbit cards that does not set any flags and using it if no
driver_data is present.

Fixes: 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
Fixes: bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1:
Rebase on latest mainline instead of net-next
Add received tag
Changes from v2:
Use card_info_2p5mbit if driver_data is NULL (see rationale above)
Remove modification of driver_data fields for each device because the
above makes it unnecessary
Rebase on latest mainline

I know the forward declaration of card_info_2p5mbit is not ideal, but
the alternative is moving all the card_info struct definitions earlier
in the file, which is too invasive for a bug fix that will be
backported to stable versions.

 drivers/net/arcnet/com20020-pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 19e411b2e3a7..dbadda08dce2 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -115,6 +115,8 @@ static const struct attribute_group com20020_state_group = {
 	.attrs = com20020_state_attrs,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit;
+
 static void com20020pci_remove(struct pci_dev *pdev);
 
 static int com20020pci_probe(struct pci_dev *pdev,
@@ -140,7 +142,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 	ci = (struct com20020_pci_card_info *)id->driver_data;
 	if (!ci)
-		return -EINVAL;
+		ci = &card_info_2p5mbit;
 
 	priv->ci = ci;
 	mm = &ci->misc_map;
@@ -347,6 +349,18 @@ static struct com20020_pci_card_info card_info_5mbit = {
 	.flags = ARC_IS_5MBIT,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit = {
+	.name = "ARC-PCI",
+	.devcount = 1,
+	.chan_map_tbl = {
+		{
+			.bar = 2,
+			.offset = 0x00,
+			.size = 0x08,
+		},
+	},
+};
+
 static struct com20020_pci_card_info card_info_sohard = {
 	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
-- 
2.43.0


