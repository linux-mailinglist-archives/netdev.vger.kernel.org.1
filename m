Return-Path: <netdev+bounces-175953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF485A680F5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C245C4244BA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124620A5F8;
	Tue, 18 Mar 2025 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMAZ3hLF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7D20967E;
	Tue, 18 Mar 2025 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342372; cv=none; b=VfScc0pr8J4Kjy3YHjlxiRLiiu86lTNr9RAhLM56JuV0O4cemFT0MjyduxYZ3I/Z3fUHCvRgzyfshG4arquOIT3j7joD56sLqiu3qvB0PaCpBK5Pswlkz2VqIWF+YMWVw85bJNO4TXiOrHEdIQbLb0QzUPDrRD6ZHVdnj0wEfAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342372; c=relaxed/simple;
	bh=hTifPPlQKm2WdPHJNGPglbLMy1DZJvDDRfNnU5GT/so=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4da9szi8qGQTVYzGxoh5Pvl+E9GSU573Ofbi4q94xrUpF3Jo254i268quS4zeeCiKXiFP5JtNor9HBzZ2wfSKDNTiZ7fM+L2HyFvdIGbtl1WsWJubmU748yLhcsX05QaE78HC5fdTsDhWs0twjGb1zZQ3osG4C7UA79y/5GHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMAZ3hLF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-399749152b4so32853f8f.3;
        Tue, 18 Mar 2025 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742342369; x=1742947169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uCllGBD+amkDxWsOywJFoq12/wp8Il5PeOW8b/6RHw=;
        b=lMAZ3hLF90ax8Xj6huW6G/KBUBdHVOES9aqPyaPUahWjM/qwyVriNFyf8XATZGFXga
         rOVpWRnFcfBs9OZd08HmftcwZUKws1megMbkd0gEncIUcJDvZlzuooW/CEpsEEMyxlsu
         kLkHAFm8L6yf+c6+fcfl19QgOO7nq5pfU05r91Yx44mKZrqovgEXfvuNa3xHGtI6gRff
         Kbxb8hEZ6im5qaopqJpu3Oqx+qsb09DdJwFwgKL+MXN6CyH+g13lbn3WPTsPZhRGDsoF
         OesFbtUmzdgTULDRGgt+X0kDaaOKHP8fxgNWLB4JAvH5fN9Ry30UMj4gIhf74tzPtLnG
         /Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742342369; x=1742947169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uCllGBD+amkDxWsOywJFoq12/wp8Il5PeOW8b/6RHw=;
        b=wQSJq/lw+h2Zomp8n80ey1JvtMtvqaw5H5c68sBqwUU35jmdXqycwvkfWcMa+BDVHe
         W9x/I0vgHYJvDl14co1ZSQMEahlmC0kE6jW0bL1SxkfL5nsWbkr3AxJB2UrN3AN26hND
         wsNDT0hJeqMpcYIqOPL5SIIbbb2e7pIBv/+/uCbSBjig/rNIiwgmQoFu7DLakrv1UrJc
         Kj1meQ8t/f47GV9UiCiDHQpOZck1W+myhPm+LNkEvOxd+gCaQA3XUWIT9i8ziQ+H9FR7
         yDs9iP8T2lkJQrwK+9pvuA2lyb1qK2GO07qVWfYMuLJlZFxx0ZFAakbDv5r/JuPopjbl
         ZinA==
X-Forwarded-Encrypted: i=1; AJvYcCX5mdq/VIXo2WUREfqn/BvKKSuyXIyn9oeGmmeulx+QTq+L0Iy6mtwqk86js9rbozMs6J5tentZKr+b@vger.kernel.org, AJvYcCXZjS480/OO1N5LaizGKRpUZ+a3+riRMZIIOcoMzreEVMFS+Ar+fCAG66/1FxChgptZ6xAeIXgslUx6kd/d@vger.kernel.org, AJvYcCXzaVXbC/mPr4RgDGWwQfI4NgsbqXZCTyRddkXXqADC5Rr53rvNX+ozEOVavplY1MrzCiRrw6YK@vger.kernel.org
X-Gm-Message-State: AOJu0YwFagIlCrE1cc4IVZKv/p3WTR/xFS57kZNSVdj+0+ygdAe51W/6
	nKOdPlQ0Pz8G7sZhHZ30TCMAeFLPlPYxc2zIP1qVXdp2aZnNga/d
X-Gm-Gg: ASbGncueldohMnItShoNCVYiNks3WJhqLxogz/ivPcN87yvWw0Ln9i5TnE16vzi/x6p
	mcnFQ5rX2tiGY4QX9+0a9SGHpRqX+t6ZndiRVoLC6iRTt/dzuR7VMhtaCIh2CI5t2DOUJMiqnlx
	6QDZxFFS+VNc+OZTipw8v8mNYBkFo74LEowcFFo5S/LvvYY+gdYafAVVzqOzYDYvpXWmZFGkI91
	kKS5DWrTOYjxeUL2a3ERrpzk9vAFPrCmZsC84qNb33GIU0HJc6ELK7cjaLY5HlgJre4Xc9Lf72L
	V7AagPdzruGgw/JWcgiGXmAQcYq2Jdu6bW2O9NveCEjgLKTVi3nABAo4hRnv+vxYza7J5pKe1qK
	ZtqGMTaqUpWQ8T5t5SNzo8+7Z
X-Google-Smtp-Source: AGHT+IHthQaWOjyZ9/XK5/O9h+NYJQnb1Hrdj2pr39SOaYj+gPSiHtN3rqVRxG7/5PaWL1ztpEfVHw==
X-Received: by 2002:a05:6000:2cf:b0:390:f400:2083 with SMTP id ffacd0b85a97d-39973833d3cmr432604f8f.0.1742342369159;
        Tue, 18 Mar 2025 16:59:29 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-395c83b748bsm19713268f8f.39.2025.03.18.16.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:59:28 -0700 (PDT)
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
Subject: [net-next PATCH 1/6] net: phylink: reset PCS-Phylink double reference on phylink_stop
Date: Wed, 19 Mar 2025 00:58:37 +0100
Message-ID: <20250318235850.6411-2-ansuelsmth@gmail.com>
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

On calling phylink_stop, the double reference between PCS and Phylink is
never reset. This is OK in the current rudimental implementation of PCS
as current PCS driver doesn't autonomously handle link termination (or
actually doesn't handle removal of the PCS driver at all)

But this immediately became problematic if the PCS driver makes use of
this double reference to track if the PCS have an actual user attached.
If a driver makes use of this and the double reference is not reset, the
driver might erroneously detect the PCS have a user and execute stop
operation even if not actually used. (causing unwanted link termination)

To permit PCS driver to detect this correctly, and to better handle this
similar to how it done with phylink_major_config, set to NULL the double
reference between PCS and Phylink on phylink_stop.

On phylink_major_config, PCS is always refreshed by calling
mac_select_pcs hence it's save to always reset it in phylink_stop.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 76b1a329607b..eef1712ec22c 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2589,6 +2589,9 @@ void phylink_stop(struct phylink *pl)
 	pl->pcs_state = PCS_STATE_DOWN;
 
 	phylink_pcs_disable(pl->pcs);
+	if (pl->pcs)
+		pl->pcs->phylink = NULL;
+	pl->pcs = NULL;
 }
 EXPORT_SYMBOL_GPL(phylink_stop);
 
-- 
2.48.1


