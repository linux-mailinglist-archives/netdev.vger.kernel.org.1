Return-Path: <netdev+bounces-163350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994BA29FA2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B5C3A556C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E7170A37;
	Thu,  6 Feb 2025 04:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRdpF9k4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDEC165F1E;
	Thu,  6 Feb 2025 04:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816291; cv=none; b=bjFKT0A6+J95gWeqmJVG7Ept4+ZJSa3q/klGjFzt64q9DGbtpV0GFkrtT055RgnyOzJTs518ArwkkJTidv2dBXgs+W7UsVw4eBiYvNKwXz5GirjhQfsPVl/mEZro0/mN9VJrcspEmevGSgiprR5EShHR/PiFxJ4pYnzp78G+vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816291; c=relaxed/simple;
	bh=s/p50GMdkJD/uK8tT7seihpuPufOSshH1O9kS0ZIigI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/nZUNPgmmaxsgwKo//LuO9EGgmQAH7al/elwsU4WjQi3hkb9Qf2wbmeX8aw/h+QMls56I1GaBttLvH3Q+gRZ25KWPiJK9+CEBzqCd9x2Ts3zJwF6NAmI/0sguakI356tJ58dWd5RDgVz6iWuD7HqLmFl37n1NaOtb2XZcZVdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRdpF9k4; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f9f5caa37cso1552056a91.0;
        Wed, 05 Feb 2025 20:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738816289; x=1739421089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0SAvsOTRWQXRI9Em9YHS8hKkjTqRpY3I22VfT0ZvIM=;
        b=gRdpF9k4WRfDbq3+PlugwATm8Rgyn+tiijYz/OFE96KAFlbgGcMUW7xLUZOaxvfahb
         HTeWcrhGBLP1jXFICkMqY9BHnOoMBSEMOzOnyfTh9eN+ON7l7PRKX3WRPDFLGZktopVb
         lfUnjYBJCvcUAfXVH5VOzz3Rl6RxuNJgop3v1KnxfHJdLMmIaXsAEu7W88a0r8K09R2l
         7KseSqSdGwBz8att5JFcxYkxzWVFFrETocJsWcJSUBcB/MuUY2ec/FTEQCgsqY+ya5ty
         YMkJJacA5aOVFJ2vEW80hydR9bWvZmHughL8Wu+HhHpdNAsqexkdWTA2nApnWZK93GKE
         1pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738816289; x=1739421089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0SAvsOTRWQXRI9Em9YHS8hKkjTqRpY3I22VfT0ZvIM=;
        b=g6LrLt+6MJl0V/8LYXcaltdpPkJBkF64AhlCQ/XDQnjSm9Ocoio82tLLDu9IyVUA87
         SzZn4FuXPJRUVDtQrfrpRFzmB11kz5soawFYQL6v6kR+zdiFUdZvdnQ4LXWxddrGbRyZ
         ZR3K8CvFNv5ldjLfjnavgjHatd7pCkHLYSJl6YbdxdS5KF17ItAts+6FRz2zFIa6x2Gq
         eYG9VSzl+6EVPZZiwwAdWTWh9vR/5vTXXMoERgcXHlVupVEWDWnMnDjeve8sRfhruIoF
         9pBRatBKPtrjhBVwJK3xZLXdYLpKl1iSyQLjHL9AR4noaE1s6Mv/I8a84YRm555PnniV
         SpYw==
X-Forwarded-Encrypted: i=1; AJvYcCUM9K58bPXbOUYPHLagvB9eOjE0oG1dNBjhkapv58PzUePmiBOdgLzrKZp7h5IoMUCop+2IIiLe@vger.kernel.org, AJvYcCV3/A9YTFZ36bK5iDgS7zadpGK7NxPt909jdjyVtikbR9SOiJ1RmU+erBGIJ2VvogBj+V3aTtMqkq/7MPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHQkvupOYfh0tvljWhTqV8NKtUykymtkFMeDElvwqXCEItwlI
	Gsvg6qo8g4JYiZS678PIdfb1FLSVVJuAMxAAFEgn4jC73ASHserm
X-Gm-Gg: ASbGncvWh9jQVZWAEyzD+jXMNjHyDCooQHI+q+9OZVTU3L0NeWwnd7okaSpj0p0z5Vc
	Dw7DyzhHQgt6cseCfY8dGy/WEb7auBXVGV3cNyiT7RATJ59ZpatJH2kIpT3QD/tWCZFwrbAWwhV
	SS//JcdDNqDsiJ4jHSoLbVx1B4Cz98MDGLD2hCm6Jolc3y9KgjaSXEZu0gsaMIAK/vQw/OYBZaZ
	iplMpSODySkH8ChYMx0HM94vYDM82itd8OOwYJ9U2AM8grlb0uCjCnowiqfjKbNlRAd6xmqwgfi
	NOHbpWrDfbTKUU2Eb+5WRl+YhSNZksL7WJc=
X-Google-Smtp-Source: AGHT+IFUUoWJFIWRIXusIa1oi7pVPGN40EKshfRy08gExMPI9Mo0nnrJY1V/K1BSAZ+kq2+F7+B9JA==
X-Received: by 2002:a05:6a00:4c81:b0:725:de58:b2ea with SMTP id d2e1a72fcca58-73042a6ee1dmr3855687b3a.6.1738816289103;
        Wed, 05 Feb 2025 20:31:29 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c162f6sm305013b3a.143.2025.02.05.20.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:31:28 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] net: dsa: b53: Indicate which BCM63268 port is GPHY
Date: Wed,  5 Feb 2025 20:30:45 -0800
Message-ID: <20250206043055.177004-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206043055.177004-1-kylehendrydev@gmail.com>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a gphy mask member and initialize for BCM63268.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 3 +++
 drivers/net/dsa/b53/b53_priv.h   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 79dc77835681..06739aea328d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2319,6 +2319,7 @@ struct b53_chip_data {
 	const char *dev_name;
 	u16 vlans;
 	u16 enabled_ports;
+	u16 internal_gphy_mask;
 	u8 imp_port;
 	u8 cpu_port;
 	u8 vta_regs[3];
@@ -2466,6 +2467,7 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.dev_name = "BCM63268",
 		.vlans = 4096,
 		.enabled_ports = 0, /* pdata must provide them */
+		.internal_gphy_mask = BIT(3),
 		.arl_bins = 4,
 		.arl_buckets = 1024,
 		.imp_port = 8,
@@ -2642,6 +2644,7 @@ static int b53_switch_init(struct b53_device *dev)
 			dev->num_vlans = chip->vlans;
 			dev->num_arl_bins = chip->arl_bins;
 			dev->num_arl_buckets = chip->arl_buckets;
+			dev->internal_gphy_mask = chip->internal_gphy_mask;
 			break;
 		}
 	}
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 9e9b5bc0c5d6..cd565efbdec2 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -128,6 +128,7 @@ struct b53_device {
 
 	/* used ports mask */
 	u16 enabled_ports;
+	u16 internal_gphy_mask;
 	unsigned int imp_port;
 
 	/* connect specific data */
-- 
2.43.0


