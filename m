Return-Path: <netdev+bounces-281219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOe8M2zz7mko1wAAu9opvQ
	(envelope-from <netdev+bounces-281219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:26:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3769146D378
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3E63300A13C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E9361DBF;
	Mon, 27 Apr 2026 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS1lHm4w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B3A35F19B
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777267552; cv=none; b=XD09Egu4MyMdUUKYRcBrHU1+1Twj5z6O1J+btdDOSE343Z2rTYF6jnPyQy+x6qsRXrg6dS7nIStHxC1ewWJ6RGEMle1pvJk/6LJuH3sFxbuAa4dVU9sLQhgw6QM0avCDAzO96WIXQ+mrgw4+dIV5R/7dip2a4qjgMjNaDPdfLFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777267552; c=relaxed/simple;
	bh=99lSrF+1eYEkJlPXU8JHqpZIWsAt2opKY5Dz0oiRNlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4U1eRhnJjyVdjp+xqj09IxC5uR2ZKPhDgiseGcK91F2e7ydbVOlIEslDfwtFyMmpSBdSUzZYacFgR27W4jvo7cHWtYtvQNA2m2iJvlS6CMEU13uATgah+wHV6xjATswl1Ph66dOQJ6pXPqa9ipYrC54a6Em53TUXiecX3tfjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS1lHm4w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b461310af5so37999375ad.1
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777267550; x=1777872350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ycuIE4c7Iobrdl9AIMUx/zKbSJ3zPZucVgWEzp7FaVs=;
        b=TS1lHm4w7VbLBoPHDaTqOhbZKGn6HLXYoz0awQZ5DfvcyeoB0JC9Ya1GQLdVm5auwy
         qBAzEbzOh8nk7O5znaKRRp7sb5kp8JDMfTSrQfCj3PHcb+kSguv0KrOOKNlx6Una46or
         +ObE2NP5Q2Eg+szF6nhN4hAt/p6KPs9nXLxRwSpnErntsF78g5us/F5WlMnpY92ZkO/H
         dHDVQ7tnc/rnI0VFSGvFy04qW6bWGWpgrmyocMQq7sKEG8gq7d5HpAn7RpM88xZyEtNz
         crcwv0TeHbqOmgkHpt4GPOnrAl4MOhl42HSYZXfw1jQqTt30/2u/lQL+RLHiKJfrftjj
         erSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777267550; x=1777872350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycuIE4c7Iobrdl9AIMUx/zKbSJ3zPZucVgWEzp7FaVs=;
        b=AA9XZj4f9VoLyVLhGftAI5ZmkcbTzVUfX7ltuOtdDwZh3J4Uu2SNwyHpJeJmfPpuIh
         ZtqVbMq6Z4Dd9DD99RtQ4FVPc/boPJr4iwiCBfe0PB1UC8MxcVTJ0NN4WhhmezsuoxHj
         vpl7UdZJk0Ow5ff6DV5lYCysIObuAYUQ9bHQHZPBHO4I5vvKw6yTyqpNSYThYAMrH3LN
         u7FWpiyPC76D/IMzAd4x7MmmvQBbl9n2EpmGXJ0J73Rzan8eBj7y/vVqMo7JJ8yYDRNN
         7/FJfgTA7FEAQYE/cz5V1SXeZwrZp0DbyGKRlrQmFmWuVnOFvjCqvuhdV68Y3AqeaXaF
         +/rA==
X-Gm-Message-State: AOJu0YwmQtc+td8vwaF5zqh2rqVxxuPpK7zXTfSV+906h3Sq7OOJCLtV
	uJJmGGmPk/YJfJsIpiFwrE33lO+PduQoCtephpMvu2P9DWt18KsBek5YNtG53M21
X-Gm-Gg: AeBDiesEihbXue1Kpqh3zs+ZYqRqgjBmPp1oPyEZO9O/Uob3DMASs6lS10gTPoZLJfD
	EB/QX1heHOaOu1iB3FikeHwoTbZNBFXuHhkTXTRTaITlZeMF+L2Fuow1jRKnZ2XLWE+0JFcTF8j
	DVRa6GSiJ03ji9V+MTGQQvgEbvGqDdOk1NvurGrGeFAx6zeuXMJRagWCX+zGRDC5ZocaV1Ea9b/
	qSgL1/Sxjk0rx0xdvhJnlbvTupB+gHdb+Jn9753uQTDf/JZpIMv0k2JPASoygZQDBqQzp6oy5a7
	YIwPu2uHODAdfeSvQdb+kxmqiFgzEUlUU4a/o8h57Yhc68vPaQ9Fddqmya31XBoK6vo4e8RkOC2
	6CqmeFq/JX/vQRP2mX09QWZ8fRXYSJwjxRPLxuiIELXrEOwIjQxDgvvVzxFDyEnbcbqKNn90F46
	5PVeHPk0Nxeok68MTBzv6QiaO8Gk1YCDWyAcTENe0/pV5cWVW+hmiwCQS6LldHxGOug+KG3SjrW
	42GhC7xGtYtrtBNz57F0L0f2xaOQmB3oe8P
X-Received: by 2002:a17:902:ebca:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2b5f9df38c9mr341239655ad.9.1777267550109;
        Sun, 26 Apr 2026 22:25:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cf3bsm345516165ad.44.2026.04.26.22.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:25:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: enc28j60: use of_get_ethdev_address
Date: Sun, 26 Apr 2026 22:25:33 -0700
Message-ID: <20260427052533.960487-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3769146D378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281219-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Since this is an OF only driver, of_ instead of device_ allows nvmem to
be used to specify the MAC address.

Add EPROBE_DEFER handling for NVMEM.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/microchip/enc28j60.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/enc28j60.c b/drivers/net/ethernet/microchip/enc28j60.c
index d6c9491537e4..2b9b4163e419 100644
--- a/drivers/net/ethernet/microchip/enc28j60.c
+++ b/drivers/net/ethernet/microchip/enc28j60.c
@@ -24,6 +24,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
+#include <linux/of_net.h>
 
 #include "enc28j60_hw.h"
 
@@ -1554,7 +1555,10 @@ static int enc28j60_probe(struct spi_device *spi)
 		goto error_irq;
 	}
 
-	if (device_get_ethdev_address(&spi->dev, dev))
+	ret = of_get_ethdev_address(spi->dev.of_node, dev);
+	if (ret == -EPROBE_DEFER)
+		return ret;
+	if (ret)
 		eth_hw_addr_random(dev);
 	enc28j60_set_hw_macaddr(dev);
 
-- 
2.54.0


