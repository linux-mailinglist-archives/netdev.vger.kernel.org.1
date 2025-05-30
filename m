Return-Path: <netdev+bounces-194394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED4BAC92D1
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 17:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A064A5374
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B0A2367D2;
	Fri, 30 May 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV7ZuAiZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318D2367AB;
	Fri, 30 May 2025 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620588; cv=none; b=gT7VS4jaXg8hb/cXp6maZMp7jKgPiHygUvrkuEXbm5TJboe3RmUhdcqIFDtJiNwDwLbjFNFNQLHkFQv3qrBNdZs/jQJve+mfE9exdCrJtrblGoSJgvaFlCW7kMCmq+plCyGNewNBmCeutPKGasdSonFY8P+CCvuMsl/Uf7m6m0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620588; c=relaxed/simple;
	bh=Gov2ErTA4ltXD8t4g2SZjQfOt4pd1BQTNLKN8c2dfY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Id7ibazBO0Lv8/MFpvAj4eDGwLx8fy2iug6cVUztxsRFNRO9kFYrLbfEu0tHAj5ZTMZq4eWC9K3MSD+cuxwwIQNlygGLNTLQqz5R3Zxp7byFoz9AXp8hgu0JL1I1kUQEjpYh4EsLTAZCYvKZjhuqoF50QSdQS5okHUw7ZDy84Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV7ZuAiZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so23729995e9.3;
        Fri, 30 May 2025 08:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748620585; x=1749225385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp+E66Q6A7bA9dhY4T3RjzRvOC5Jv6nIHHeAykV6os4=;
        b=KV7ZuAiZKTZ4Xtw+NykbZV7inbqv9UWRruWFuAJc32eqLztwmDLC7CY68hJ6U+77ZQ
         3nnwme3LMXWBLu3G3bmXcSe0l4Hbz+s5J0AXuxgzgdstqA/040qofx+GAW/uGFZCFp4Y
         HIXT9PQVI46qMFe4z6263aZS5IaLlLGhN3vyeYoHMN5Qm3z8O6tsXxgoBGTTjys0c3CA
         yuK1fDgyEhbn8Uj+AM8ItP2txA9BMKEja/YQfofMw+FlpEYIexjWonQR/6iE6CA4myhT
         OnSsAFTBAm0bBo47FjaIn7sT8sBae0rnyHWatkIYLter89Yd9t4dFnu7YDlJl96ZkcGc
         1ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620585; x=1749225385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp+E66Q6A7bA9dhY4T3RjzRvOC5Jv6nIHHeAykV6os4=;
        b=NaYrxf5hPmDIBYCApi9mo7v32Oz5GVUaLfXKgAiOjeywNAhr1/XogxfuzOFYyh0jdD
         1PD8ZrSb2tefgzQOcCzcmnpTkSMXyYxJjIbLRc+CJhEPJUZswMJ1B5lDqEJ/6OYtbLxL
         F/KrZ27/XeeOQcFn1Ju26FyS7C/nw9dIAizkd6O6LCD2L+8QcOonjslC1bwC2M/ayXas
         F4SiQaasaKTpk4EizM2db5g3GCa5dmHPTD6wKAulDcv5XQ5AEzMxBFLByPDalwuk6hvA
         06SObn0EDbTC6/Z35p5W6jXw0laeRZlqjZpYTvhQTqWu3UAEqpKJ2OPBhDNs2DBPea/J
         ANrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs4Ifz2ZYOnzEMpdO37RfxjPpIBwDaDI3J/bKCSkryfkwL2wtIHGRg1hsfbucHMSysfUYZE5QDIbUYxiI=@vger.kernel.org, AJvYcCXK5c+tgWlLL5ORvTIj8AevZqtuXjLRbcWWi2WuwWTBTTH9/D+33M3IF5DAsWTYRqFjG6JU8z3a@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMU+mhkGHNvMyU5tMN+4YpPdAsOnQAi4Bej3zL2CN1M6afoBh
	rAVDcqQCwt+GvM1dLbhv6AzjC/oOIY5jC3Z4Uqw2F/QMQrTorOI8O0KR
X-Gm-Gg: ASbGncsCItrXkqOaZorsyc3QXo0zlJ4QJnlhIUXW8pnQmHOjKqFVTDh8ofaXIK/mYeQ
	VCxE9SRpAIrParDg27vnDNMSolfCHnwPnxDVoj7XV1XXVZo0g4KZaHB2LJaLy+cAa9bFP1EFbuR
	Z8taX3R5hSKER087h2w/sp1a/JDnSayTeDuDGjbaOIakJZ9XIE0y/vZOytWUeiTaQxbXlTdVeV4
	Mk5OKGRofz4lFYqCivyygmVc9M3jtl3AuV9q6m/Cuj+u4bDJDkH51F7eQtQRHE5TzjvkpYOQ4QY
	M9dnl48MCQ4RLbCAk2esnruTqROuXDPvFw5NhHWoE3OTOi5IGuZEY11Oeygz3hJC//T70j4GWdn
	oKNS8vp9ZjPXyW7kOM5ljSis34i21flpjkmaTBKqQyoFV00/qgvJE
X-Google-Smtp-Source: AGHT+IH1oW3m7z1i5Gu3ZApwun9ZAc56WPYxSGw5Ovt1K1bY+XPvoQAX814eDJcorxESWXgNifgNRA==
X-Received: by 2002:a05:600c:1c96:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-450d64e2a8amr40070295e9.4.1748620585157;
        Fri, 30 May 2025 08:56:25 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm5211620f8f.53.2025.05.30.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 08:56:24 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] net: dsa: b53: support legacy FCS tags
Date: Fri, 30 May 2025 17:56:18 +0200
Message-Id: <20250530155618.273567-4-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530155618.273567-1-noltari@gmail.com>
References: <20250530155618.273567-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 46c5176c586c ("net: dsa: b53: support legacy tags") introduced
support for legacy tags, but it turns out that BCM5325 and BCM5365
switches require the original FCS value and length, so they have to be
treated differently.

Fixes: 46c5176c586c ("net: dsa: b53: support legacy tags")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/Kconfig      | 1 +
 drivers/net/dsa/b53/b53_common.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/Kconfig b/drivers/net/dsa/b53/Kconfig
index ebaa4a80d5444..915008e8eff53 100644
--- a/drivers/net/dsa/b53/Kconfig
+++ b/drivers/net/dsa/b53/Kconfig
@@ -5,6 +5,7 @@ menuconfig B53
 	select NET_DSA_TAG_NONE
 	select NET_DSA_TAG_BRCM
 	select NET_DSA_TAG_BRCM_LEGACY
+	select NET_DSA_TAG_BRCM_LEGACY_FCS
 	select NET_DSA_TAG_BRCM_PREPEND
 	help
 	  This driver adds support for Broadcom managed switch chips. It supports
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 132683ed3abe6..28a20bf0c669e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2262,8 +2262,11 @@ enum dsa_tag_protocol b53_get_tag_protocol(struct dsa_switch *ds, int port,
 		goto out;
 	}
 
-	/* Older models require a different 6 byte tag */
-	if (is5325(dev) || is5365(dev) || is63xx(dev)) {
+	/* Older models require different 6 byte tags */
+	if (is5325(dev) || is5365(dev)) {
+		dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY_FCS;
+		goto out;
+	} else if (is63xx(dev)) {
 		dev->tag_protocol = DSA_TAG_PROTO_BRCM_LEGACY;
 		goto out;
 	}
-- 
2.39.5


