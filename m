Return-Path: <netdev+bounces-145590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784F39D0047
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 19:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDF11F20F71
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68824191484;
	Sat, 16 Nov 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HsKRaCyI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F518E35D
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 18:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731780191; cv=none; b=gKAv4scZaDOpjAP2MTgfHbaY883EZ+4KffHp5KfaxBWx2miFuHi8h4wrZth7Cl6Q9rUbvqEJZhStzHpghJ7vb/buiHCnethkWOGUUOMWBGiuN32CG2EHWR1XgdF/1J0NbfZ/aZolEKQOSvxEFjcko5AaiBEUm1k5e/i3KHaHCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731780191; c=relaxed/simple;
	bh=6yVXQABDgHQ3YoFzFBc688YaHlYOrV8PMSvT0DmVF0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGhTFXBq1226qa8l75oglZHgwauh39NSYxtbYysF+F7vFIDWGEB5Q0oEkWwxvxbujcS/6Lj1JSxOSEIVl1dhh2jO96T27gkCDGxhU+p2MtzKnuhS5m40IJDPR/UvDR5S5cWgCoOa3OLwW5pLfus7DnRahy7oz3k4JFMRaR/CJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HsKRaCyI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so2026182a12.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1731780188; x=1732384988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGnFcahEd0eVvjCCPAmskcKVoLg3YmWfRrAxcNnhTVM=;
        b=HsKRaCyI871iY1l5Qeyc6UDUSwcuGhGMCDevYQ2NGytn58BAQNcVs2Wqyv6d8Il4ZN
         imRPyozRk+2ElitXM/VyaorxyO4j3/yIH/qXBD6JyvbRKYMHCzd2mOPzq4ttVt3Uzt7t
         Mhqui6sOmmnYRMuweXVRqMKh/Qo3jn1h+qKek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731780188; x=1732384988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGnFcahEd0eVvjCCPAmskcKVoLg3YmWfRrAxcNnhTVM=;
        b=NuXQjA4LBkT1xHpMSFhsy3vzKrZDOgNN4vnJmgP8AT7hKcqhDwTjfBL/A63HlWktXC
         yfz34P+to6kpna6kuum3BLPcS+6YXzcnZnh9p39x2qFNCdMjbVIMxbPIqL7dwk3OQFs+
         F+4NdijDgXQMvVsRQHyfFfUsAzVtL/YMHXMlAFaCsXcPTIhsulYDrqaYhZ86QUDS3XlI
         EQFfYLju0AUqBnKbOpnVKXw75EhruajwaeW6Qy3/sq0w+6fAoBUZJ3M97/9Ml7RgIwwN
         8W+4/i/qD3W/7E41H424MTtORsyNC8rJ1NQ1i05b7v2t6FUT/P0yln6nxZL8wB7rz0UV
         uurg==
X-Forwarded-Encrypted: i=1; AJvYcCXfv6ave3Iyq7Gu0TElDp6IMs0PFgjzTlK+QegN+lNvZMfaBXCLvfLuV7w/Q5iTRr/z9ZBjEDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ/ZkTTmzTIhXkdberCltuYUnoMPi1KqDM2A99qOwY7W6VVrI
	2p8gjxf8ZXIEnWB8SCBe5FtZNkrUjtqx7Qz313IOC8GvpHeM/b8N1UQx8af5I5Y=
X-Google-Smtp-Source: AGHT+IEY6i5r17rHD7AA4pDo0eewtwkaRGniz3NbwzmDUylo6DVU+CLQMsuSqXx2AB1hMg+lZtDO9Q==
X-Received: by 2002:a17:907:1c9d:b0:a9e:670f:9485 with SMTP id a640c23a62f3a-aa481a5cecfmr569044566b.30.1731780188249;
        Sat, 16 Nov 2024 10:03:08 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dc6d364sm329549066b.0.2024.11.16.10.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:03:07 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dong Aisheng <b29396@freescale.com>,
	Eric Dumazet <edumazet@google.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/7] can: m_can: fix {rx,tx}_errors statistics
Date: Sat, 16 Nov 2024 19:02:30 +0100
Message-ID: <20241116180301.3935879-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
References: <20241116180301.3935879-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The m_can_handle_lec_err() function was incorrectly incrementing only the
receive error counter, even in cases of bit or acknowledgment errors that
occur during transmission. The patch fixes the issue by incrementing the
appropriate counter based on the type of error.

Fixes: e0d1f4816f2a ("can: m_can: add Bosch M_CAN controller support")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/m_can/m_can.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 16e9e7d7527d..337ccfae34fd 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -695,7 +695,6 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	u32 timestamp = 0;
 
 	cdev->can.can_stats.bus_error++;
-	stats->rx_errors++;
 
 	/* propagate the error condition to the CAN stack */
 	skb = alloc_can_err_skb(dev, &cf);
@@ -711,26 +710,32 @@ static int m_can_handle_lec_err(struct net_device *dev,
 	case LEC_STUFF_ERROR:
 		netdev_dbg(dev, "stuff error\n");
 		cf->data[2] |= CAN_ERR_PROT_STUFF;
+		stats->rx_errors++;
 		break;
 	case LEC_FORM_ERROR:
 		netdev_dbg(dev, "form error\n");
 		cf->data[2] |= CAN_ERR_PROT_FORM;
+		stats->rx_errors++;
 		break;
 	case LEC_ACK_ERROR:
 		netdev_dbg(dev, "ack error\n");
 		cf->data[3] = CAN_ERR_PROT_LOC_ACK;
+		stats->tx_errors++;
 		break;
 	case LEC_BIT1_ERROR:
 		netdev_dbg(dev, "bit1 error\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT1;
+		stats->tx_errors++;
 		break;
 	case LEC_BIT0_ERROR:
 		netdev_dbg(dev, "bit0 error\n");
 		cf->data[2] |= CAN_ERR_PROT_BIT0;
+		stats->tx_errors++;
 		break;
 	case LEC_CRC_ERROR:
 		netdev_dbg(dev, "CRC error\n");
 		cf->data[3] = CAN_ERR_PROT_LOC_CRC_SEQ;
+		stats->rx_errors++;
 		break;
 	default:
 		break;
-- 
2.43.0


