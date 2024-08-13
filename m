Return-Path: <netdev+bounces-118017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4BC950428
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9A1C22604
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE5C199250;
	Tue, 13 Aug 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd2naswZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEE1990BB;
	Tue, 13 Aug 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549759; cv=none; b=YAzERtSD1EPN/ByQ+1/xlND6J448qtgw/RtFIkzJCVFAnI93QNGGBkFjBart+LrlnAdLPoaGRFhUqE8GgY4tovZTcnDoyhP9VnkYNKPMiFhWKfXCeOmgoAxUKdHZUB4VhK7JfyilGpIUN/O1nwSjNSqMIrW2KDUPc1pwt8EPOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549759; c=relaxed/simple;
	bh=EIGbzcgwScE6AbghS653jf3cZ93S/GClvOAWlZuAcx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLi6tgvG8KDi8Fx80Eqpwa//F0HV2JYFHKDQrMPf557fFp33kKnTB+FbPU7V7o6jUFdCmPFZA3sVVlFrWBxwHxXrfkSN5la7UAWVzXJIa6yAmkl+xCfxQPSqFtFxqUGXeg5KxI45i36MV2IpA9h/W/PglM9p2hN2e5VfCL/9NGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd2naswZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3389617a12.1;
        Tue, 13 Aug 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723549757; x=1724154557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udk+s3Obbj80Cans5TjOJ2DULPf1NEhrOug0bVeCQAQ=;
        b=gd2naswZl5dRePyh7K3V7eGcA+nnO9WT/ouD4w6X62/7tiXYkChkxedIjR9nAioYSO
         kARrE10EGev6o2pfvamVwQTj2B94BE0CPa8uwJ31uDb28ekEApxK6KJW1lmIU4TpAVRi
         +egNQCr5Y5e9c3Cuiq9GEdVEQj858ryaWa3tnfagM/bXeVGdHGBVclQO1m7DEbqXQ8xv
         A2ilLRqhdBKOuM73r0CQijkGzXi2vXYIZU01tARhfbFaXhpqgiuyMryzMU4X0KPYdiSZ
         yBR6G14UMExMvwUu15qX/33+zw1WzPNgF9nSVyKtk9sRGcUKLNxuMjsIwpt4CohPfQek
         JbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549757; x=1724154557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udk+s3Obbj80Cans5TjOJ2DULPf1NEhrOug0bVeCQAQ=;
        b=BcI8WswAst6AKQRXvqXZLEa9KGwb4KHEH2T+PTrsxoO3jsMcrdfd3HMT2OmYJU9SNb
         oJzC4aP6OzaYk0L2iDKO5xHy7A6W5Y3gyfaMXuiEO6mU5fTN0ItnQpS1eXr1mUzxYTqB
         Bd7pS8WHATlt/+gL1yJ3mtOwqTzXgwcr9XDgQ/S9EyeRw5+qEjcZ0e1sYSSyCKcibVfh
         T1l8Qu0lt8bVQIeIEdLTRqkPRZ1aK3UKqV1wwjcyf85pqtP51fnKB65T53WAg6ibmKxm
         opz+aLoGNe19dLG9+N31T/+W4BSK2ICLzD+yPF/tzuB5mEv3fA3NFaKvREquLk95bMSB
         0l6A==
X-Forwarded-Encrypted: i=1; AJvYcCXv/l3MrHN4WiifM72c9gwyRjbsORBe6IyMWSqFGwTxcwhTaymi+0R0nMTVeMEU+eVJ8VldD4sIJuxRFkUUCOMjYbDSXy9vdX/C1Rmi
X-Gm-Message-State: AOJu0Yx/Afb69OCx7GF1zpXhnmI3ZgEr4yFjk8y2Bl5kNPMvnhugAqBP
	Oxjt1V9GOGtqKzN/ww1Bl4d2U/uPKgFCtyaAOctDvEsEF83enmmh
X-Google-Smtp-Source: AGHT+IFKROSujLrymeUcrrT4jAx0Zh7mXt92lrH7p0RVaXCHTQS+/rEiU4KU+PTGuOa6NaJsz1t0pQ==
X-Received: by 2002:a05:6a21:e8b:b0:1c4:98f8:9ccb with SMTP id adf61e73a8af0-1c8d75865d7mr4302526637.34.1723549757391;
        Tue, 13 Aug 2024 04:49:17 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5a562bbsm5548755b3a.111.2024.08.13.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:49:17 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 7/7] net: stmmac: silence FPE kernel logs
Date: Tue, 13 Aug 2024 19:47:33 +0800
Message-Id: <103f008b17dba3e1a0267e5dfb84075fc9c494fb.1723548320.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723548320.git.0x1207@gmail.com>
References: <cover.1723548320.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool --show-mm can get real-time state of FPE.
Those kernel logs should keep quiet.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac5.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
index b6114de34b31..733163c52f97 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
@@ -620,22 +620,22 @@ int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev)
 
 	if (value & TRSP) {
 		status |= FPE_EVENT_TRSP;
-		netdev_info(dev, "FPE: Respond mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is transmitted\n");
 	}
 
 	if (value & TVER) {
 		status |= FPE_EVENT_TVER;
-		netdev_info(dev, "FPE: Verify mPacket is transmitted\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is transmitted\n");
 	}
 
 	if (value & RRSP) {
 		status |= FPE_EVENT_RRSP;
-		netdev_info(dev, "FPE: Respond mPacket is received\n");
+		netdev_dbg(dev, "FPE: Respond mPacket is received\n");
 	}
 
 	if (value & RVER) {
 		status |= FPE_EVENT_RVER;
-		netdev_info(dev, "FPE: Verify mPacket is received\n");
+		netdev_dbg(dev, "FPE: Verify mPacket is received\n");
 	}
 
 	return status;
-- 
2.34.1


