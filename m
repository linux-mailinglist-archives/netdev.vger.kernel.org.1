Return-Path: <netdev+bounces-57049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55331811C20
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 19:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FA51C20E44
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878485A117;
	Wed, 13 Dec 2023 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZyeq8Qf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADAF3;
	Wed, 13 Dec 2023 10:16:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3360ae1b937so3694112f8f.0;
        Wed, 13 Dec 2023 10:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702491361; x=1703096161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWFAx4kAF7hKrrXw5IZi1qHuzEkNqyvfaO25OJOU7sA=;
        b=dZyeq8QfVckkss0cDgsppzOC5CyNkvPCZgbub7jwwbBaGTHKlXOYChgbLNf2+QBLN0
         1+uPcWl9aKr2DvDU8jbmD8ZnMv2zW5IzGSY9Bvx3VrWIfu8k/3DsRZ1bMUdAMGCZ1gly
         EkDPWUPio+t1o755n7YKZZb8OX+oq/sO4DJY/aN2ItvHoAd8reKhgdQEYQGJa2LVeQ1t
         OSDKuuQn0z002xv1rulQjYOUEsIJaSiR39UPp4OUQQy/04GX1qHd0iv/8KIgpBUXEnTW
         nqDaHZ7VNh4dVIi/1qLGKil+NMaSZ43fGM8sAB5+5IZ4VOETdJWVD8Bp2DVbuBcaCcta
         d57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702491361; x=1703096161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWFAx4kAF7hKrrXw5IZi1qHuzEkNqyvfaO25OJOU7sA=;
        b=np6YiJy4Whs5sDbILvdaWeWKTiAyPol9nlnggGGhwqHjilMY9VGHAiai4grEoS30Xt
         eDg/WTasSpqvlSbsVgH6rULWqrHzLIvSm/kzZqT2Jvh3Px0+kN6sDHpsZELJUGxb+hag
         cYFPU/gvD5wrkjLjZ+2ths9msdz2uoF86i34YT8U1k0P+PmR8MLI/zaf+BVuN7hReAld
         xXpjqWP9BounwEQzGnyDhvw9iFR+tDnrVpNMZ4wTNPXvL2PLCxt2vLr3mj8PAEK2jRd6
         EQRMMp7OhPWev4TGNtpmkx8W25Hr53cKh3wt0q9iR5JCorJUVOzlnqN7KW4GW7V4+gRs
         qrrw==
X-Gm-Message-State: AOJu0YwM6cBqRie2f6sPZeQJZa43z5c1uXYy3KQcyINsE/iCHTgNoHOf
	xWKqI65p3kYGuJ5Atg8ACN8=
X-Google-Smtp-Source: AGHT+IF3VN4QIifOoqZDFbvLMgXXwW7fuo63SscdTRFZdEs59zHjEPp5uovEwoB5YbVV8qYnEGH0RQ==
X-Received: by 2002:adf:fb43:0:b0:334:b1f4:5d59 with SMTP id c3-20020adffb43000000b00334b1f45d59mr4781640wrs.40.1702491360826;
        Wed, 13 Dec 2023 10:16:00 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id e33-20020a5d5961000000b0033346fe9b9bsm13947762wri.83.2023.12.13.10.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 10:16:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/2] net: ethtool: add define for link speed mode number
Date: Wed, 13 Dec 2023 19:15:53 +0100
Message-Id: <20231213181554.4741-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231213181554.4741-1-ansuelsmth@gmail.com>
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add define to reference the number of link speed mode defined in the
system.

This can be handy for generic parsing of the different link speed mode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/uapi/linux/ethtool.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index f7fba0dc87e5..59f394a663ab 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1884,6 +1884,28 @@ enum ethtool_link_mode_bit_indices {
  * Update drivers/net/phy/phy.c:phy_speed_to_str() and
  * drivers/net/bonding/bond_3ad.c:__get_link_speed() when adding new values.
  */
+enum ethtool_link_speeds {
+	SPEED_10 = 0,
+	SPEED_100,
+	SPEED_1000,
+	SPEED_2500,
+	SPEED_5000,
+	SPEED_10000,
+	SPEED_14000,
+	SPEED_20000,
+	SPEED_25000,
+	SPEED_40000,
+	SPEED_50000,
+	SPEED_56000,
+	SPEED_100000,
+	SPEED_200000,
+	SPEED_400000,
+	SPEED_800000,
+
+	/* must be last entry */
+	__LINK_SPEEDS_NUM,
+};
+
 #define SPEED_10		10
 #define SPEED_100		100
 #define SPEED_1000		1000
-- 
2.40.1


