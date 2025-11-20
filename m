Return-Path: <netdev+bounces-240577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B49B5C7665A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 22:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18F4A4E610A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D779F33BBC3;
	Thu, 20 Nov 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSAxvQum"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853F2FF151
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674744; cv=none; b=msVwwd5pFMov1cVuxHQU3s7OKvLsoa/iAgbMpuZ27iqtER69gb3J8K0XqtuJnhy0MMgUZv0vHPPDxAPWc4clsjzO7yMKxjk89rVIHQEBqGHDnIM9d7kTg9zHQf0zKhVSGVxlZn6bcuFdm3nWLyqKrWeBzhcwbQIO9vWH5q9Ymfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674744; c=relaxed/simple;
	bh=jlXatnOOS0O+6oIGmGevkUtTMaMhk33D/tJLA8PWWcA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MVhDm/Zx9kkiRrNTJflftd2/HKWiPOEXhbw0xlA9pxeItC+RV7QGv/dOvC6EsYOjSbOwiK/F78h2JqM1vaoTEG1msirEkQBDXxIBA1Xnce28pGDSu8vHsE1hFidLbvoeywVAbUU77ubOTEooJXyaJV+OtRHoFOLoIb9EkrKser4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSAxvQum; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3438231df5fso1566510a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763674741; x=1764279541; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x7O/40bLxFz/ubc4QGbFz1RJXJpAvzSB31xunK5lGsY=;
        b=JSAxvQumM4eitYdCcfj17m3CuNI1tcYmJBEJNFgqXMtYAOQwpjNGthwlI/ud3j0bTk
         lJ2BbPWY85VFcilJVEXufDf7R0zzAtO7xyVZTde8m/ss1RGd9D9xUuwQ4eT6onhLQlHu
         ZRfN2WasdDsi4/5YqtxEe0hgEWMMrIXS3uFy3sRIe6RXlJyQzjRJ/YlYK4iRssxVtv6H
         cGeSZaPCQVqBaYgOEPrk/hfKnCb48qInHka9DZex317cGmLkP1vfvoxn7eZp3vO4BQoY
         8PrOPGdEwzwFIwlM6viYbBDDFlPj+pHdyNxK1kfiiD5PEU05/SDZ5z7VwMZICoQHSB0O
         zRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763674741; x=1764279541;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7O/40bLxFz/ubc4QGbFz1RJXJpAvzSB31xunK5lGsY=;
        b=BKxjOzBwnbc90BziTJ0UNc/pgsfiJxV5d5xpHy7Fq7cG0CuFahGwu6zcYdyhmgqJRM
         EyPRoauhQiaTw3tUu3t8VcA4mTbpZuB5UM0aQYtGb+Qpmamdig/57nOTJmLTy496RI/1
         QeDa7TfevxqdN+pOL308Vuy/JyyCJaELmnXQwrk+bzxT7vrbDk4gjGSXazTVj9PV+NjL
         Ov+kqPooS0L2MPnncuNuIBz4StgtaFq29oQIoTSedH/TFVUeHAfAGYuZW7aM8khDRzpi
         NFbbK1CSEKQNejAtZcNlQ8oL3JvpAv53Sj6sqIwo9C+JaWk8u0KuH1G6MLitYzk03Iq3
         y4Sg==
X-Forwarded-Encrypted: i=1; AJvYcCV7syw58hLbetPX5jKHrHCoynHryBrmLsCBXSeVpT23TqB6PwHJlMU3P7hGI/flQtEEAiFLNPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOyshn27eXPrXrjANkS5V5BQ6vZxMDRLVtapTD+C1BjlmcvEe4
	OJrh/1RJRhS5/+f2VjXJy32oT4z97T2pHv5F8Vl60mcBB4wDsumrwFrF
X-Gm-Gg: ASbGnctw9lC1kDMFWpaML4HBW6Q6i+EkPvuTU49Zq5eLy730qWJP2h0VYflvy+ZqSgZ
	Veg2xhVzVeaqg4qweUgSVVtxhdb6SpTuvPqv2ABN57Q06nS2SNyBr5iRdO+fb4VtngOFMAWjGwT
	xqMb6RVwDmsTRoLRJbQPVZxWF5zxCABJgPAtpWVcbFRrtBDPeH68EWLwIGY5ofA5Zm53YYyFx9Y
	OldFt8yfVa573L6/67TtfSXMHPh01hK0hFkXqrAe98yEaO/++4JhVcDOLfK786De0ZhlgMVIgzr
	hU1xTQ8EHStkOhrod2u2I+oA3WL71Yi3qxL94qvc0wKwJvOgzHi64OdxJ+AyORHNTS7b+IAmBlP
	EsEPlVnFXuV8/S0TUxckotEigNzIq24fXwRfkHU6dhyezmOcfabz9NIeMoCl77CPc4MsU2XJyhY
	ljwl+lZw==
X-Google-Smtp-Source: AGHT+IFk2zNyEwkfMF+EqHHJ2lA9JWu8koRD6/b0KgaWv3WfMDkuD91zEkWIPZNe5l/6fSMM5LpsOQ==
X-Received: by 2002:a17:90b:4c89:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-34727bedd4emr4929684a91.14.1763674741359;
        Thu, 20 Nov 2025 13:39:01 -0800 (PST)
Received: from SC-GAME.lan ([104.28.206.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727d6f48bsm3325479a91.17.2025.11.20.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:39:00 -0800 (PST)
From: Chen Minqiang <ptpt52@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	Chen Minqiang <ptpt52@gmail.com>
Subject: [PATCH v2 2/2] net: dsa: mt7530: fix active-low reset sequence
Date: Fri, 21 Nov 2025 05:38:05 +0800
Message-Id: <20251120213805.4135-2-ptpt52@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251120213805.4135-1-ptpt52@gmail.com>
References: <20251120213805.4135-1-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

With GPIO_ACTIVE_LOW configured in DTS, gpiod_set_value(1) asserts reset
(drives the line low), and gpiod_set_value(0) deasserts reset (drives high).

Update the reset sequence so that the driver:
 - asserts reset by driving the GPIO low first
 - waits for the required reset interval
 - deasserts reset by driving it high

This ensures MT7531 receives a correct low-to-high reset pulse.

Compatibility notes:

The previous implementation contained a polarity mismatch: the DTS
described the reset line as active-high, while the driver asserted reset
by driving the GPIO low. The two mistakes matched each other, so the
reset sequence accidentally worked.

This patch fixes both sides: the DTS is corrected to use
GPIO_ACTIVE_LOW, and the driver now asserts reset by driving the line
low (value = 1 for active-low) and then deasserts it by driving it high
(value = 0).

Because the old behaviour relied on a matched pair of bugs, this change
is not compatible with mixed combinations of old DTS and new kernel, or
new DTS and old kernel. Both sides must be updated together.

Upstream DTS and upstream kernels will remain fully compatible after
this patch. Out-of-tree DT blobs must update their reset-gpios flags to
match the correct hardware polarity, or the switch may remain stuck in
reset or fail to reset properly.

There is no practical way to maintain compatibility with the previous
incorrect behaviour without adding non-detectable heuristics, so fixing
the binding and the driver together is the correct approach.

Signed-off-by: Chen Minqiang <ptpt52@gmail.com>
---
 drivers/net/dsa/mt7530.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 548b85befbf4..24c9adff191d 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2405,9 +2405,9 @@ mt7530_setup(struct dsa_switch *ds)
 		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
-		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
+		usleep_range(5000, 5100);
+		gpiod_set_value_cansleep(priv->reset, 0);
 	}
 
 	/* Waiting for MT7530 got to stable */
@@ -2643,9 +2643,9 @@ mt7531_setup(struct dsa_switch *ds)
 		usleep_range(5000, 5100);
 		reset_control_deassert(priv->rstc);
 	} else {
-		gpiod_set_value_cansleep(priv->reset, 0);
-		usleep_range(5000, 5100);
 		gpiod_set_value_cansleep(priv->reset, 1);
+		usleep_range(5000, 5100);
+		gpiod_set_value_cansleep(priv->reset, 0);
 	}
 
 	/* Waiting for MT7530 got to stable */
-- 
2.17.1


