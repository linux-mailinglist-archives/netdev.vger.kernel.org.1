Return-Path: <netdev+bounces-254977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMiuJxoXfGk/KgIAu9opvQ
	(envelope-from <netdev+bounces-254977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69B9B6686
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D537300AB32
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591D32BF3A;
	Fri, 30 Jan 2026 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSDGU8D2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E092200110
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740055; cv=none; b=LPyMDlPUCbCrkfC+P0cq8BbFHiyGdL4zFfCk0OHrcyoSQmnhFkAFyJrR/sNaKU7ZQGRBGMj2+Y6amCUgIFfBlXQL9dIQJX5gPq7y0ItwQqnY4/mzMhYegylPDrx9eDn/kq9AYmZrYEyT6TseJb1JHH+86cblxjqtz4IYFhCMSV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740055; c=relaxed/simple;
	bh=RbmYS+GbmO5r9aIsVbkZb99LO5fpXfIwGvbgj9g6qUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9Qr4V/6/H6xSZjZB6WPiq2ZhMfVpF7BSF1UBlUSlFh/Q2O6/ZzSRNssQb2BAMI2WrIpfUa7L9mFMFI6GyjbekvixZYhHcXbwcVRBlgyhEdqFMF4h2O4J50KVPQ4AMhfKxApHYzlphZ0M851JEHOEhcm9L3zi8j40PWWwkX1khI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSDGU8D2; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b7c5db431cso995495eec.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769740053; x=1770344853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB8/RdUGEfLZjhmXdp52kQTD2QqD1w42DdvzuHTbkg0=;
        b=iSDGU8D2EVPBdBFCJ3z9rD0zVqLNBo3dfujIpWkUNHmilABq4xuauisaNnit3p6amT
         Uwys1DNRjPQDxmL0inbPkMXXF7Aaw2Qneqtr3rYtQXg9BcCHeAnQnFsWfiTkKMlfyHFK
         1YFaMipYN+4GrMDr+0Zf2nMzfyoMY+61HimBml0Uap8SBsC1G//8i6S7kmcOuSvKxTSp
         XMR1NN1YsEcotk+lJzoerRBGKs+nsMD6jVAaBZJfGIBvMjyaWvphSaSmdtnt1HKm6MiO
         y7udsPktt67p39lUu1H4lO59F/XTgpkN1dp5tAEAL7gjDMmSunF7CY7zCUiK2kj6v9CW
         tihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740053; x=1770344853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yB8/RdUGEfLZjhmXdp52kQTD2QqD1w42DdvzuHTbkg0=;
        b=UTJrN+jT7xGFvS8z22xkL4isRCXFB4xihDSU0aAHjPnmk4LpDWY+o1OoH36ZOorbb2
         QVjI1vZyzKxlWgG5pUvg1N4RgQczLLOfgPDE9eKEwmXAch/vy23eTo22FnJ94+RWY/ii
         tD0k+rbHlYJqRa1ooZDad2tK2r1FOTYzzR6+NMudP4cjSI97hePvmiBskrGjKDVp9bTH
         LQAkwPjvt4RdZFTpghLQE1JqTGJ2K/Okknhvzc6XC96Wo7NMfMelnOUVon+JKYVfPiU9
         BzVVXvnNjEFxNVuWdCbcisIp300dptEIxa3Tdgq60oXKOIw2KpuTz4hTY3WoGoY2G6Tc
         Jxrg==
X-Gm-Message-State: AOJu0YwcWSRKtpz7uO3KhdC9VIUpv9GGxN6fu5JmIOD6Pl5pDVq3p5Wo
	5rQHA9P9wbkxKF2k3cyZvNV4NLxg99Sxqq5Zz+snFZyyx/E4DqDIx9wg
X-Gm-Gg: AZuq6aLMwX+i2Mp767J2aPheo1l5Ez8pq+ZZnjUFfubytgU4mzBuAfm+i9e2tPWZQdN
	RYRwMpjuHyFW6PFnzpXDAioVHbIiuzmt1AbtdB8prsVHACwhttyisAbw6WJ6eLHOjc6zQGBIaaT
	RZTzepFxbzT8bcNli9GvfC7WeAHfp7AY3z56WN55gPzmqE1WJttO4rk6y95SC8DGEUo2PsZoXL+
	Cc/bZ2IN6ZSnx6JjhbAsT520uWvbMpVlhKYmPhqBx3JMtQNedWjN5L6hs04eDJbsqk4bBBdOaIp
	L2So8/VaLUNkMMb+DZMM9G8/FBKtmlyKNRgNnb6P02lXHRga7Q1xDd0tYU2IXW9WTwnyyp8os1q
	Q7CkVNE0eNcu3ICHAV5lOVPqxYWaH9+md3iECKba4dNwxSAulBlVufsTJXi6gdmMwiWZzjPZwrp
	VTbs37eMlofg==
X-Received: by 2002:a05:7301:3e18:b0:2b7:4118:88aa with SMTP id 5a478bee46e88-2b7c890c90emr706190eec.35.1769740053090;
        Thu, 29 Jan 2026 18:27:33 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfc73sm9365628eec.6.2026.01.29.18.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:27:32 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Yanteng Si <siyanteng@cqsoftware.com.cn>,
	Yao Zi <ziyao@disroot.org>,
	Inochi Amaoto <inochiama@gmail.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Shangjuan Wei <weishangjuan@eswincomputing.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Zhi Li <lizhi2@eswincomputing.com>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next v4 2/3] net: stmmac: platform: Add snps,dwmac-5.40a IP compatible string
Date: Fri, 30 Jan 2026 10:27:03 +0800
Message-ID: <20260130022705.1059214-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130022705.1059214-1-inochiama@gmail.com>
References: <20260130022705.1059214-1-inochiama@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254977-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gentoo.org,gmail.com,foss.st.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,armlinux.org.uk,cqsoftware.com.cn,disroot.org,bp.renesas.com,eswincomputing.com,bootlin.com,altera.com,cherry.de,st.com,synopsys.com];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E69B9B6686
X-Rspamd-Action: no action

Add compatible string for 5.40a version that can avoid to define some
platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 8979a50b5507..54c7b1537ab9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -396,6 +396,7 @@ static const char * const stmmac_gmac4_compats[] = {
 	"snps,dwmac-5.10a",
 	"snps,dwmac-5.20",
 	"snps,dwmac-5.30a",
+	"snps,dwmac-5.40a",
 	NULL
 };
 
-- 
2.52.0


