Return-Path: <netdev+bounces-175954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7651A680F6
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44C63B8F6B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA092135A9;
	Tue, 18 Mar 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg+dU+VL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCB520AF93;
	Tue, 18 Mar 2025 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342374; cv=none; b=KHPqkYf66OIOuCL/4B1TWoJMBBdi4DyJmLBD95Z6n4C3AdmsaUq57Z5OUM2pihzPq/QsE5Kn5A4uj7hTpmmgg4Vih/gjNVDo3ioJGkE5Si5gS3lLwwbKTZS+BYdI7YFTr83Hd/qX/mmYszeiS+mQLdtn6rKgds9pgeA1REJtJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342374; c=relaxed/simple;
	bh=RWb/W8VuVn25hby9ps1Xk4OHQMAZnkobWcCvlz0IwvU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2bkdQBFqW84ErpBlnCLf00ZvPpdcBAEFxqjtLOaWXK1ST0Sb3JvRFIXgVGRBW6DHs2LsYVSomf+uaeJGfl5bJr5EG0MDgTUO7dO7Sm3t5mqzNr6arQZPnhsiekBorTlwS2TH0loYBsOaderIf8QGI6MAqVb1v0KwHlYyc40pe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg+dU+VL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39130ee05b0so6087031f8f.3;
        Tue, 18 Mar 2025 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342371; x=1742947171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLEU5jH46w7Wx9XguV+RKd1pDpe/fOQ+mqohPTuFytc=;
        b=Mg+dU+VL1iKwGszB2wIcm1/jX4o9YUNPTfgv8E8gdtZnLZ8pbZhnnkYL6O/sBZt+7V
         WZCztM5UHuqxseewAmGh3IW5rXYmpRIBbiULDLPdvgYdOBGIrF9N0bK4DGJaC+h5xCIu
         Kgl56VM8NhnBCMbmmx4MElRn8EorhTPWUq+2SsfwS4GjvgQI2Zy0kyGULTTKt4v3lVYX
         Xk2adExBVCZfG/2CBMJiHq6h19HdNLTX3CAw3g1lznxc1wXqWT3xb56zSyVeoWwOpdtR
         ItTpQJ4JDMDHCZD3Xuh5Ml/SZEYTgDoQXOdw3CQyDf1StffC7DewBMvPi8GL3P92TXDD
         4IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342371; x=1742947171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLEU5jH46w7Wx9XguV+RKd1pDpe/fOQ+mqohPTuFytc=;
        b=VD7Xcd4Gmyd+jqaMjqWz41Ll45z2OIL3M5Ac7O6HNO5+tk9CZhbTwsjA5fACU2NykF
         B26C4xnf8SXLCC4XdlHHghrP7Ou4PnYM3QHrrs39cxJ9KmByR8PtA/eK7m+4JefVYna+
         Ca+nLt3T9y7bDauDrafVH1StjP2F4UQpzavqCWPQLY0fmHs1O39cudSyKZTkJsi+4wth
         sOHtFE6iXAtu0gXKJAs5aMvqLF7qRqazl24SQ4F2pefF7ljfK5+W3LQsPdYJ3+Og9Npn
         uwSo8LiCBnDHb6MGsYHTB0stK6b58CLkdW202vXMqhXkc7K2jRSycXMgXJLaQsDxtDbk
         drjg==
X-Forwarded-Encrypted: i=1; AJvYcCU6r5Qiwg3WSfSpDZ4JmRYdSYiWd6WKEEQIrzqzyItUyaVOVPXz3peRjaE60/7LdRnt5FjLsTz6@vger.kernel.org, AJvYcCUIcU4ntc+kEGfVbuL7T/paX+Um2VjgIPMtNC/J7QACqkxxEycFQ5i7M90D7KwhiXT8VIK97cudU1Aw@vger.kernel.org, AJvYcCV/adrV1q7Wx1sn97VwlzHzbJxEYGX1Upl7S59m89gGXhPhfiAnWsyZSpeic3J9hj8bzbfvwa0bFTL8G8O1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GuhNBDQsYpeRygqDGWrWemxRyql4Mi9at84Dh1aHU/yJfBo6
	+a9iJspJpWKKUYcBpctzQPApASf7+rxLeQLHI+5vxVXb6JZNNb3q
X-Gm-Gg: ASbGnctdvltEiKkGVMjaAWmykJ88lhDKORtOnyzajTZHPLnCpcA7PMC6WpvS65EKNQw
	BS3Q+X5L8xrG4a79T7nPMJUwcGDIbqdI4HO6XGkEqGceGgitVskqJfbhyzypf7lokPhsarW6Kzb
	nqZMEDyITJc4k5W3pGfKK8VDbcFLnOF+Yk01vyOyudyU9whgyKHjiquH3CDNVEWxhH3OM1k38mD
	MjvfZd6RrO+S0WMmwH4WviVm10Wx6tBVxqpCSGgKdkYSQmhF4Zyqw/xDV/0B8NhRBwacikcB2BB
	655brqIYw9C671YmDIMsgsj48qRD8X2NKespo/Lg/ZFPgEEVOAgks0DrRzfeFccVyFUav+fKJMf
	6helRfP8R1U13hope2wEHiPMc
X-Google-Smtp-Source: AGHT+IFYvUVldsBb/HBwtgzd6coaRncKEEC2J8JTVw6gQ1woqAR9qC/z4S476t2OMTHJqgXT7hVYIg==
X-Received: by 2002:a05:6000:4026:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-399739c4913mr582752f8f.15.1742342371453;
        Tue, 18 Mar 2025 16:59:31 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm19713268f8f.39.2025.03.18.16.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:59:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH 3/6] net: phylink: Correctly handle PCS probe defer from PCS provider
Date: Wed, 19 Mar 2025 00:58:39 +0100
Message-ID: <20250318235850.6411-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318235850.6411-1-ansuelsmth@gmail.com>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On using OF PCS implementation, it can happen that the PCS driver still
needs to be probed at the time the MAC driver calls .mac_select_pcs.

In such case, PCS provider will return probe defer as the PCS can't be
found in the global provider list. It's expected the MAC driver to
retry probing at a later time when the PCS driver is actually probed.

To handle this, check the return value of phylink_validate (that will
call mac_select_pcs to validate the interface) in phylink_create and
make phylink_create return -EPROBE_DEFER. The MAC driver will check this
return value and retry probing.

PCS can be removed unexpectedly at later time (driver gets removed) and
not available anymore. In such case, PCS provider will also return probe
defer as the PCS can't be found in the global provider list. (as the PCS
driver on removal will delete itself as PCS provider)

To communicate correct error message, in phylink_major_config() detect
this condition and treat -EPROBE_DEFER error from .mac_select_pcs as
-ENOENT as probe defer is only allowed at probe stage.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 7f71547e89fe..c6d9e4efed13 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1395,6 +1395,15 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 	if (pl->mac_ops->mac_select_pcs) {
 		pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
 		if (IS_ERR(pcs)) {
+			/* PCS can be removed unexpectedly and not available
+			 * anymore.
+			 * PCS provider will return probe defer as the PCS
+			 * can't be found in the global provider list.
+			 * In such case, return -ENOENT as a more symbolic name
+			 * for the error message.
+			 */
+			if (PTR_ERR(pcs) == -EPROBE_DEFER)
+				pcs = ERR_PTR(-ENOENT);
 			phylink_err(pl,
 				    "mac_select_pcs unexpectedly failed: %pe\n",
 				    pcs);
@@ -2004,7 +2013,18 @@ struct phylink *phylink_create(struct phylink_config *config,
 
 	linkmode_fill(pl->supported);
 	linkmode_copy(pl->link_config.advertising, pl->supported);
-	phylink_validate(pl, pl->supported, &pl->link_config);
+	ret = phylink_validate(pl, pl->supported, &pl->link_config);
+	/* The PCS might not available at the time phylink_create
+	 * is called. Check this and communicate to the MAC driver
+	 * that probe should be retried later.
+	 *
+	 * Notice that this can only happen in probe stage and PCS
+	 * is expected to be avaialble in phylink_major_config.
+	 */
+	if (ret == -EPROBE_DEFER) {
+		kfree(pl);
+		return ERR_PTR(ret);
+	}
 
 	ret = phylink_parse_mode(pl, fwnode);
 	if (ret < 0) {
-- 
2.48.1


