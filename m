Return-Path: <netdev+bounces-128395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372997968E
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 14:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763551C20E6B
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 12:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B111C57A0;
	Sun, 15 Sep 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdlW7eLR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154751CF93;
	Sun, 15 Sep 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726402625; cv=none; b=lwcYmBkAfFPR4GGDwnI6v+RKJT5l8D4upEKjQC6V6QwTPoJ9dZgQCucENObbWCyEHK+G4+VYC18kWnZklxBnFnJPMNtaO6KahBJYOAsSjWZk5JfmxJCZMAISXpBTT+RUCKK3fDOdA7TqvkiNRWysQHOszz9zrIEVRfYusj1pTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726402625; c=relaxed/simple;
	bh=CKDC9Lw/yfPRpTNqrlbByAy2TCWasrEtgRvw0VNtGEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F/bxHR5RFlO+ZwRr1FS9hN/T+FgTokyPqXC/MgaE7LONvGOKBJey0jNiv3nWF8DZ6GYu+qWf981yd4hRebFPy3FV0BKAxtVcW/GWYAEY3zaSJOQZKoMisj2B3IcJxiIJsoC1S8vDDI5YbpSK4GRsZ4Q74eIvCsQalVMHMJEmNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdlW7eLR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so30876035e9.0;
        Sun, 15 Sep 2024 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726402622; x=1727007422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AGodTDCjjs+0Zb9OMbx63GT79MwQFWp1XiS4lscufsY=;
        b=RdlW7eLR3Cfy34ksCZMyU5z564rLIkunUuCNthftoc2x9mJE4ZacN3xDE1/gvUf0RS
         dwYkbOh908XfMtcR/SbReGExb9ErvAZEELlOHspt3BYNiq/YVlK6ivmR+vNcEiMVxzZS
         Qa58TKPaD2EasI7t5/swlS2mY3ao+8nAGYdhTPn5YdOGq8VUdUaOpXCq6tpdSdgUtcye
         i1J2wX6mqaubiv9fy0df7mN1hbnBoyJHD1003JPF4WmVKTF3SuBKj0uaVyh0zdb9xA39
         Y/LtOFDj2kKBm6BlnFFdg9Rqs7AlyPAWkUuSzXl4l6zFX2h8F8hsszmOMoVItQYrUvkU
         4s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726402622; x=1727007422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGodTDCjjs+0Zb9OMbx63GT79MwQFWp1XiS4lscufsY=;
        b=HlqVfMLKxiBLHbqo8yg/mOI++eh9wSwZ4JhNAWXpHkaza+tcl5+pKAIhP9Mniz2b+C
         eWu+UVee9f0Me3w47CnqJjr3q7Wr/BrJYi5BVtQibfAPf6mTBAT5ZkWPwhwzaiQmaXll
         b5ziylieSIOl4dEQR8nqp8SbqNrFg5+juwpfRCEhcjQkDVwfyl3wxJ0U+/vEg4lsB87Z
         LbmvWY3DEtXg6syWX4EP1U5H/tKNR3OEzdetO9ajOtsrvjGFTDMhI+wj/JVze9qwPFO2
         dUpO6Sy0I3Ws9tEgnI58MiZ8Ijf+NMBKkXMB+XbJ8AcqOVD+HP07W0qfia+s3OZTbjnt
         aAVw==
X-Forwarded-Encrypted: i=1; AJvYcCX6WmhIwjA00c/ZlMHJ8ZxaqeZlZw8wj9yHzyojHwDEiN7KS9CWP0ViMSrdy41D01VDvXTGDAmQjhNLGupHUW0=@vger.kernel.org, AJvYcCXYSsWA1M/BdWRrHiQlfFpzO4SwlGvn9LYXoQUIMru7AdJAgZ/KKmI+hqrcdB3nsHO2T2YB7pDxCs1LKUvM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw74aI2z1Mmsulisk2CEXf1J6Sq2D89S2dy1dCFpbf9630eE203
	UkuTMCyfNomWrEpnYCGU65RDZ2/RB5qrTVqwmlwAODS6uzs7rC2o
X-Google-Smtp-Source: AGHT+IEDfKRtGg7O1HzEcAqciCAseSwiRpjhkGx9UCf0hMMFEzMYMQeqKToQ1qEKx0qvj3OELEuvgA==
X-Received: by 2002:a05:600c:468a:b0:42c:b309:8d18 with SMTP id 5b1f17b1804b1-42cdb53be54mr81834505e9.19.1726402621452;
        Sun, 15 Sep 2024 05:17:01 -0700 (PDT)
Received: from void.void ([141.226.169.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81cbsm4533651f8f.28.2024.09.15.05.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 05:17:01 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Madalin Bucur <madalin.bucur@nxp.com>,
	Sean Anderson <sean.anderson@seco.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fsl/fman: Fix a typo
Date: Sun, 15 Sep 2024 15:16:55 +0300
Message-Id: <20240915121655.103316-1-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index f17a4e511510..e977389f7088 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -987,7 +987,7 @@ static int init_low_level_driver(struct fman_port *port)
 		return -ENODEV;
 	}
 
-	/* The code bellow is a trick so the FM will not release the buffer
+	/* The code below is a trick so the FM will not release the buffer
 	 * to BM nor will try to enqueue the frame to QM
 	 */
 	if (port->port_type == FMAN_PORT_TYPE_TX) {
-- 
2.39.5


