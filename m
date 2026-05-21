Return-Path: <netdev+bounces-290165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF1zFa5PDmrL9gUAu9opvQ
	(envelope-from <netdev+bounces-290165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:19:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB67F59D409
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BD463109440
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E820D4E9;
	Thu, 21 May 2026 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSKp6RlE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E961215F42
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779322675; cv=none; b=eJCo0z+9wc8DDlgdJuTiGYpYBQ/QKWQ/oKVZNEJakpAIxAmwSvl699bTk3Zngx34jB89728f9IFZm9S3oofsuXEhHWGpXd5NGi5WYB5b5LEpHShYTx7aInj91jAUglIYPejBtPREUPkSmrDjfJevDqE7ci2W/WYkLOPCpy/M148=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779322675; c=relaxed/simple;
	bh=dSZgqHUCwiEcQbQO8mgR/k4hcvwgM6evPWbpjQ7esMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfGNVKvKMyeE4DuxphmNUH9cc/VhgZqcueBfBsJLI+m5rVOlqMwd0RbA6d6OBx+dOnfR757niG0M9/n0Cr0FicBKo0hT2BwDYdAXgWxX13P0ECfFjXQAN5zvCoAuWAHRk4WaPVmVsZwGGCpGUITmOm1/eF6Jm7r9g1PVSIlXHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSKp6RlE; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-1309f4ee97fso6376155c88.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 17:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779322674; x=1779927474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNohQLJ2KnFFjnxtZOvJckZJ/rWE1qh4MqDMJfs/8U8=;
        b=NSKp6RlEjNvZFwRI2/PErDOF96VkuP8qubikaqHVDZlwK0Q+OX6wY3Iy875P+3+ygS
         9u/0OpGpG7jxG+uOO/FDi1d16NlafQhkgpiUhKgBgudZ6+kf2sXuwbNL8YIFskmbTZMO
         C4BiVqrEPduTmhuQzOukihQYFJ7Bb56Gz7FPbbohun69mNlDxAwEsNx8XO716UCS3Pxt
         U17n5uifmv9LxvJgdcChZZK9omyRwB6Gv7M29QTmDGliJbSKJArhlCMeWnc/r989Azra
         3m0PJ9dFHJs8/A/MwX8FHWMY3OsnCWopHL5uY+3yUuQlfIrThnycl6cyoS2mgElUYBIC
         g2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779322674; x=1779927474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNohQLJ2KnFFjnxtZOvJckZJ/rWE1qh4MqDMJfs/8U8=;
        b=QCB6XOkPHlS9UEukCy7b/oSetatvlVQ9eKNpLRU9HBJLG8sz/7UP0H0viqS73eQCDQ
         McBFAGtwntBDBsr2nR0f8gn09uCVE3BtizBIkjmUFBypjRd+UKO3ph3YidyS7Op95OQj
         3Z0bIHeF6Abtsskir4GsMRvhuNs9SxHhRTqbZne/3hXwXi53nHAgr+a4WBvf6wjQdAm7
         elNSjhSfZ+vr1EGnhuaDcI8qAJLhgj1POL6k54iYUnbbJJLLUNFztzWPXEoyY8U/AUU5
         0SQ9v87NMwhE7q7BTmJzkBjArrQ29yCXhRgDcfdatwnkdXTdNfBwvwjkdifQP7xwp/JI
         XdAQ==
X-Gm-Message-State: AOJu0Yxtv3s4P7KaU3xMrCNRF0LapIriZ8O08u+QfSxT6aG9czKiRMdK
	9GT+Ua+JW/VqGRDE/1LI6gcrhWpjH9BJcyRFlxWRtSk/bgfoGgoCcvXZP71mmV3TPDI=
X-Gm-Gg: Acq92OH5WOqARZH3a6U8RrQ2Zrcy01v5fcwDCXsGWSqR0zDiswmYvZM4fMr18zZxCZ8
	uWmWIeb8DE5cs7Ib9AJ6+2NQFa6XHq7c4oVjLGKsg7Iq6XYpMfuI2L34CinqF6bKlPE5LdbfaGC
	Uk1eceWhnqfZKarpOqW+CKj239hwR2hPMw87W4dlCQpe+hdKqz0gWauAeBJwT6/1kNoc9DN7/iQ
	ritbGCMyDx+KZ+QL5GCOV57L5YtyPLzlPYuxH2TfpHGRmL1nZVPYxvio541QXdWcbI7G7vxJaES
	WCiY3sBjg2foOt2G/Tpo52UWLPLIobb5EHJF1R1P+MSad4j5EKEEQZ9CbpAWv51A0FpDsQ2DSKe
	n0DptWhlGwv4VmymPztr+rQM4yZclrSBJJKzouvebsU/nYdtKZGP2lXexF6q2LH+/YOrFYoPtpn
	90F+UiEAyRsSHhdSyEKOlOtbvX9DvnLWIEebB7g60ZTdVtex2ToQA4dQZyZHbhqzEb7YMhPNa1K
	8jvcuWFfDHLf33LXmZWaahC7/SecdyWNBhmy2GnZ8o/5o3aEU0xVdxuoKapxFRwENnKV4z3Awtw
	GCYKhZHQECkYPOrmjQirt4ZZ4kMB
X-Received: by 2002:a05:7022:61a1:b0:135:5b10:ead7 with SMTP id a92af1059eb24-136329fe5f9mr455118c88.4.1779322673802;
        Wed, 20 May 2026 17:17:53 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm28444410c88.1.2026.05.20.17.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 17:17:53 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH v2 7/7] net: arcnet: com20020-pci: avoid -Wformat-truncation warning
Date: Wed, 20 May 2026 17:16:19 -0700
Message-ID: <20260521001631.45434-8-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521001631.45434-1-enelsonmoore@gmail.com>
References: <20260521001631.45434-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CB67F59D409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When compiling the com20020-pci driver with W=1, I received the
following warning:

drivers/net/arcnet/com20020-pci.c:224:71: warning: ‘%d’ directive
output may be truncated writing between 1 and 11 bytes into a region of
size between 10 and 11 [-Wformat-truncation=]
 224 | snprintf(dev->name, sizeof(dev->name), "arc%d-%d", dev->dev_id, i);

In reality, this does not represent a problem, because i is bounded by
the .devcount field in struct com20020_pci_card_info, which is
statically defined for each card and very small. Quiet the invalid
warning by changing the type of i and the .devcount field to be
narrower.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020-pci.c | 3 ++-
 drivers/net/arcnet/com20020.h     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 98f68cb13a52..f6b5371fcdcf 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -127,7 +127,8 @@ static int com20020pci_probe(struct pci_dev *pdev,
 	struct net_device *dev;
 	struct arcnet_local *lp;
 	struct com20020_priv *priv;
-	int i, ioaddr, ret;
+	int ioaddr, ret;
+	u8 i;
 	struct resource *r;
 
 	ret = 0;
diff --git a/drivers/net/arcnet/com20020.h b/drivers/net/arcnet/com20020.h
index e7aac0e81a13..68f49fdc2c28 100644
--- a/drivers/net/arcnet/com20020.h
+++ b/drivers/net/arcnet/com20020.h
@@ -50,7 +50,7 @@ struct com20020_pci_channel_map {
 
 struct com20020_pci_card_info {
 	const char *name;
-	int devcount;
+	u8 devcount;
 
 	struct com20020_pci_channel_map chan_map_tbl[PLX_PCI_MAX_CARDS];
 	struct com20020_pci_channel_map misc_map;
-- 
2.43.0


