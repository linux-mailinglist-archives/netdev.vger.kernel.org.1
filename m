Return-Path: <netdev+bounces-149819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F19E7A1A
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DD01649C5
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B211DA31D;
	Fri,  6 Dec 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYhPOr45"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FA1C5490
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517737; cv=none; b=UmH6P7O+SlAShB8iQDL/PQDT/hUixLSNyRBbMk0193FZ4B6dY3N2iM3lMmFAhY+1jpWdQyWdYkjGLKzXddW0XK3/z7cQY4a6QIYxeGKYgTR1PYIkDMWdr294l9dSVZ0ZspNBSsw6jvrHCjIFSqSn7UARnS2bR6mS/hLoPDxB8Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517737; c=relaxed/simple;
	bh=LOEyhS/zjCu3L7Eg8M0Kw99okKdGsioK8et7GPJo0Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ck9E5hA6byQL80lHnqDZDX2h7GO+7i+M4zOypxmlEwP8kJgm4JjXEyzdovgeJR41y9pyuQ3K2nqed5EJs2hNGR8SAFZ0DIdFxEF0aBni/F82lQGL5eLBJh/FOGxd9jzwFv1GBDmNXM1wF4dyTE8Yb+Lpfrwqz+h2IVAHjU66pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYhPOr45; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-432d86a3085so16770765e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 12:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733517734; x=1734122534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mm6psef4SnBhtrajdIia1L7dedJrpYcJHFECTKa6Qno=;
        b=cYhPOr45rpl4gpR+exNkRbfJUX4xiZCJZJnryAWAm7MF4NzYPNQSi75FsLWCPdJLyI
         r5Pnbv/j/iAAhO5krtmlSqleWKY/wVQBM2dL4qiWYw8JOmCW8tTgycVJsSNXh/qowzvd
         CYiWmny5eyY25G9NdPo5ugafisbJeGrelEwSVVi2z5LoYYemqCwKDtfk1UZpLqw6FGVr
         /ZlmRqBIyTd7RNT7xigRzUZNmGHPb9uXS+uXPabF0TasZ8wOlGiqeWa3C2ucZG/G/bJc
         Ixf2w18d2NvEwaa1C9AHj2caIiZzFW8NuTFYWOR+NtfSFZxSHx7gJ7Zu1Gl5CJ4EaCNl
         pClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517734; x=1734122534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mm6psef4SnBhtrajdIia1L7dedJrpYcJHFECTKa6Qno=;
        b=sMVZm+IfOsVAJPz1x0y1N8VhA9oKgqmLC9XUDJGRHDIXOcc49M+O6I55zz+jmq/Nzo
         gqZyoFM4X0FrXQaIfkyBr+YLEGNO5dhfxKR5n+gJbrKPJrU+VtGYvtcUw/OkOxOa/oE2
         2FMg6GD1M1ZvXMCc6pT0GABDaZqbFs/Lmpv1lG5gV2xcrbe3GacU/xHsvhDlRXjR7sSE
         AKxMgpfyuS4ySXMKsM72wH27XRiWiRciVbO19bISrMeC6yNwmoyRvh9y9Fp9Bq6ldgh7
         ljX9dpJgvb3kK8CD9MXvaFsQ0Dm1MHs/MMvx5Fhki2FPbMM7+y5uM6uuvW0N0pDNma0b
         hvhg==
X-Gm-Message-State: AOJu0YwH3qU/gdoAlq3zCQg9BGTwzWImaPXOQNN9H6YUjX6m2HnVQ+Tx
	L9ovXIFl4Qd+2d4wUvLCgd+kTRjRgBhS5OS6dXcoV6wNmDATYrB/zdg/aNhc6BE=
X-Gm-Gg: ASbGncvxlMcfKjQ9edA/nyrE9dTUgAOaDyML21aR2dxzm/VAgJ6834qU/P6v2w1QoIC
	pnl9yeirLlmzAqGAPEc0sn+DeDXxqqquv8GphlL2QJr8Dt0Utnd0h7oILFTPSKmBiepPqGAxCd0
	Oq3PXobyA0CI4OV89yEn3HD4hEocUSxrvUM1KyuZctSOffFcRV2B2SVS2snn2xxhedvPUcpMawg
	nIYFQ++m86/MLlJmvww+0D0GmnrexK7RsnFBjUWmTVJcJL+sDT/k/qB6ZLPx8VWGZcwmoZj7jsB
	L91YPMowQgXqMGrgJwVFKEZIzVGWcsmrS+SEiZziemyX2g==
X-Google-Smtp-Source: AGHT+IFxF+pEJq3xOEvE2tSh0+xDK6kcjicK/iELLXm/DSBCSmn3pzQB0jL2KvNfSlAiQld9PcAnwg==
X-Received: by 2002:a05:600c:1d1b:b0:434:a5e6:64f6 with SMTP id 5b1f17b1804b1-434ddeabcf0mr36592845e9.11.1733517733281;
        Fri, 06 Dec 2024 12:42:13 -0800 (PST)
Received: from KJKCLT3928.esterline.net (192.234-180-91.adsl-dyn.isp.belgacom.be. [91.180.234.192])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6a07sm65508785e9.13.2024.12.06.12.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:42:12 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: netdev@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH net-next v3] net: dsa: microchip: Make MDIO bus name unique
Date: Fri,  6 Dec 2024 21:42:02 +0100
Message-Id: <20241206204202.649912-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In configurations with 2 or more DSA clusters it will fail to allocate
unique MDIO bus names as only the switch ID is used, fix this by using
a combination of the tree ID and switch ID when needed

Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
Changes v2: target net-next, probably an improvement rather than a true bug
Changes v3: to maintain ABI, only do the two part name when the cluster index
is not 0

 drivers/net/dsa/microchip/ksz_common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 920443ee8ffd..f5822c57be32 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2550,7 +2550,11 @@ static int ksz_mdio_register(struct ksz_device *dev)
 		bus->read = ksz_sw_mdio_read;
 		bus->write = ksz_sw_mdio_write;
 		bus->name = "ksz user smi";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+		if (ds->dst->index != 0) {
+			snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d-%d", ds->dst->index, ds->index);
+		} else {
+			snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+		}
 	}
 
 	ret = ksz_parse_dt_phy_config(dev, bus, mdio_np);
-- 
2.34.1


