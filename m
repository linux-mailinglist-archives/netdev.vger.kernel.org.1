Return-Path: <netdev+bounces-288797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHmTCuRmCmq60wQAu9opvQ
	(envelope-from <netdev+bounces-288797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:09:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DD9564B32
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27AC30214C5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 01:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED61121ABBB;
	Mon, 18 May 2026 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LriZBVvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848031E32D6
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779066564; cv=none; b=FS5Gf3hDOevHpfTgKlUZUq9+tEj0GKLjKx9QD7Yx+aFjSnEi0WUBEf44DJVwv0w0k3nnmeZOa18Dtmouz4HkY8qsQcNv31/DxRPygMjzYS635vOfvxpWudtHxYrcRrOTGcAcMLZdMIj34xt/J8oiq0OYh6JV8QyN+o9CW78cmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779066564; c=relaxed/simple;
	bh=dSZgqHUCwiEcQbQO8mgR/k4hcvwgM6evPWbpjQ7esMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ML6KtF/kXTMhddA2iE5L4N5EBjMGmPyt3dTlPKcvH1tPmAo9W3toYP7uODA/qYghMpZMUJ6EOpCvrRgT/bXvlwxhADwlmV8iPyaXpxsUp+x/JAPqFvF/exHz7pUkr1cwC8H/yeIVonpV9pH5WTTWqNxSkUwNU8z8vHiBubiENOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LriZBVvr; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1993283eec.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 18:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779066563; x=1779671363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNohQLJ2KnFFjnxtZOvJckZJ/rWE1qh4MqDMJfs/8U8=;
        b=LriZBVvrvi7QQfgl1VY3GnTSs0HYDjHyHmMbZ42Ixo1hGmYj/YPpkF9YTcQx4RsodR
         72z5Vo5Boql3ZHnkW96gHHc4zoeXyibUuIXTk2F1cf+OwgSKW8Wlp9ycr+yhin3fL7BG
         jIpOFRlqxg26OnKMhfymSVn4OMKEgf9ffEB8AUIAgd7kw/2qbEhLv9+PWHy1yHv3N4Sn
         NCC39CUcmOx81MEggESWpbs11UxVfP6OD7lUTDG9KXGxUOO7cWOdLzv2llpi90cUCd15
         hhnmlNKl6y0fGeVWSKpwysXIkJUOB56lGbpv/9sW2el+B1m8ENmDwgLRs8Ypd/owZj9U
         bAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779066563; x=1779671363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNohQLJ2KnFFjnxtZOvJckZJ/rWE1qh4MqDMJfs/8U8=;
        b=Q4N0+4P26Wwg3pWtkyujT16HFS64x6MaihnveirGfeEgpGfkVS+ehZa28naR4+Ovkr
         ODmLv7695A1g3MoT0Dl/DV6UbEviXFxVH92sLBWi0RchgYtZfSc6oU5yrxsheMUk9qKD
         Wq4W1917BQfbHdO+sExXO61ooHZSo+eb2y0wzmnd1lcho6fE1E5q5fK9qi47UaPCpfgm
         IjcvqcfvOLNKSPuDCLyUTJmDwL6vcPBKC1ZsmlLG+FyBzObLlhgZ3HyAPlkrplA7sQco
         9Hwd2BPmAdZROktfQzhN+ki/9Xk5f185g8uTLLHOjZcwjr4LYF/mrE9haPbcnaTcrJN+
         1IhQ==
X-Gm-Message-State: AOJu0Yzrw7+FlMvD7p7M3KSVxDgTFpddAuCUrCz7ftrLgdlfFzvp2a7U
	E4LqA09T2gMfQlK5EUnI2mBxs2+1p7rzKD7i7m5F4axw8+aBUOJ3VMPrV+4z/+QMwJw=
X-Gm-Gg: Acq92OFYMMr6r9vOntHK/HE2/8RoW3gbdWsW5E+zEaMo/hqVHywfr2BqgB0tYeV+HqK
	opbaU9ekkpEHHyWYWWtQoVJLhV066KdbxhsTwiiCHmAsdEI/q7XjjUXp38lGPSrMoiQq4iPdm5u
	mrPnn/bNDMVFw1B7Ml/xNS+d2152Hqu5FtGsPGX74Evzzs8bXIYJNtZVR4jLJUgYLZF0uViKhQ1
	d80sxJwNkqAuLRcHVbcvMtRjy9UTNDRxZ7n5hdKcveOcW44uhNUUez59KC0jegDJTSqYr0y5hNt
	gX3icS6TCE9khpIwcqBnkaD2DKQhYJVIsK0sT6N7ftPUepoMW3bhUpOLQJoy8fH+suE75LOgBRA
	PHVjJUaEx6htfEHiwN8pkc3/mNjmnIkIqxSm2dQycVD8f1QkIA0FXp/ffF3MjykY866Jl+XlhuQ
	yl4HCzP+BBWJjqqVRLbt51zSLAhDo+aVzMR5LFLy5kLgaf6NKb1tNclWS9SEdRjvrzoD9zthxl/
	bzjxdTU8i4UWagbdQdyv5Q38exKE4oeKc4UNQEYKP6WHL/KFXiZEJpnCyn2K9+PPIrAjylEfg+3
	ay9Zb+oQGPG4UG3R2w==
X-Received: by 2002:a05:7022:f9a:b0:132:5d31:dcb4 with SMTP id a92af1059eb24-1350483cd3bmr5204788c88.23.1779066562578;
        Sun, 17 May 2026 18:09:22 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm18891372c88.0.2026.05.17.18.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 18:09:22 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 7/7] net: arcnet: com20020-pci: avoid -Wformat-truncation warning
Date: Sun, 17 May 2026 18:07:27 -0700
Message-ID: <20260518010739.80979-8-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518010739.80979-1-enelsonmoore@gmail.com>
References: <20260518010739.80979-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 70DD9564B32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288797-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


