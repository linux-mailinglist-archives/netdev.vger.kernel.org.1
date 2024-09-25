Return-Path: <netdev+bounces-129808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A159864DC
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF341F2589D
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161D84037;
	Wed, 25 Sep 2024 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZHo7fk5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F036F305
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281862; cv=none; b=d7LL/UrIsHKcbJGfx7soNUhhnrHPWrMvEYoAMUt+ttwyfbW+v8VBQI8N4Hy/J0NsMkgvAsHMu/aOPhnaxgjdqGB14Fx7vJxKsHAlm+lGqK8ZMnb8qnwyEJ1409opO1Ialb5UGxcPpJ5PTTX4+0TDLUECOMK9gmqE0ONMn0EKH+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281862; c=relaxed/simple;
	bh=WLuLHgx2MT3+4N/TaNL5sHAmTNY9YxSr2tDwSWM1Wks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DiS2i4GQKT4h15tSnJvzt4xcAKQv7UMhESHqY4xXO7DTuTyQlNWNk2mWd1acqNRRG0lpLpPH7TNBx5Wh7K/Ysr4MIi/UF9qwL2Mtd9BSpOIh/KPWDUtKzT1Y1U4eZFFvBFfWawixt2wX4QI9D2mQiAzvB0CkP/YHumPQTAtdqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZHo7fk5B; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6b738acd5so10435a12.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727281860; x=1727886660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqS3WLQRtJuGZ7n5fqIngVYCyukIdr8Yi9XEikosZZs=;
        b=ZHo7fk5BBCCHxeLIzWbCsbVVRvT9Ogg3YO1U1LNcCts+dFwBxac64Wu3OfDCHoMAfQ
         0g0ehad/FU77j6okMhTn0m0jGcU1kLx4mNyAwbQAA7vT9LbWTGz1+0y6ewPQznyNtabj
         LC/3z8QrqLoHe1IY+HiJQuwkk2olcuLWP1PlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281860; x=1727886660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqS3WLQRtJuGZ7n5fqIngVYCyukIdr8Yi9XEikosZZs=;
        b=eHFI1V4v29cL51V074HUcGlyocpE1payuQNa3vOZFoKOJOmHP0336phrqpT4ooLjBr
         /YaS3yIE6SrVDRXshjabE1faNWrDoHgKJRe//br+JJ/ESC1JiYu2gb+1ynZrP3Kn5C0a
         5ehCOWX9evXEGSGGV8oABbqYQY1RI5uu8UAHxZSM2YRbChx/+Vi1bB1flInLBPRJk7kD
         eGXbX6J0ZM2PnCVm44weex3HtW+T6CIQ3cWuJZoETJmo2yKmqhdSDt0+U9lUU2Yt94NA
         la59+0IY2yGWItT4WczsRoYn6Lc97RvI1eI+N1qiBzBaMsstfnGMDbrsnmcUggmFKF2i
         5cEg==
X-Gm-Message-State: AOJu0YxcIG0tiC+oeSSZa5tio4X4lfzdeJxzMs2r015D8tdGVdJfoBNR
	7mA64Qg0Dwt6mtvrEf7H1TdfedOmvlO5nIKSrP/oRJ0KWxqRWJKJpmY28fpdrs3Cuj349hTnGlq
	U/9lXtDJxYm7OadiOgirU2WgYgvBCuxirvd9gBWCJhLIbZQlR0Fc3lmhj0ksjU5ueYucHa2YS3s
	snDRWSOp/D6TFBqHW0SriUPAyu9PzqqoYiQaE=
X-Google-Smtp-Source: AGHT+IHkq6o5Ld2ygnxmPUAmwe4I6gQIsnCBKwiUvvIUWibnJ6eGpMuDVKGGABQBnTR8IJWaW9URVQ==
X-Received: by 2002:a05:6a20:d526:b0:1c4:dfa7:d3b9 with SMTP id adf61e73a8af0-1d4d4b08946mr4079299637.28.1727281859597;
        Wed, 25 Sep 2024 09:30:59 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0702sm26345585ad.28.2024.09.25.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 09:30:59 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC v2 net-next 2/2] e1000: Link IRQs and queues to NAPIs
Date: Wed, 25 Sep 2024 16:29:37 +0000
Message-Id: <20240925162937.2218-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240925162937.2218-1-jdamato@fastly.com>
References: <20240925162937.2218-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for netdev-genl, allowing users to query IRQ, NAPI, and
queue information.

After this patch is applied, note the IRQ assigned to my NIC:

$ cat /proc/interrupts | grep enp0s8 | cut -f1 --delimiter=':'
 18

Note the output from the cli:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 2}'
[{'id': 513, 'ifindex': 2, 'irq': 18}]

This device supports only 1 rx and 1 tx queue, so querying that:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump queue-get --json='{"ifindex": 2}'
[{'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'rx'},
 {'id': 0, 'ifindex': 2, 'napi-id': 513, 'type': 'tx'}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index ab7ae418d294..4de9b156b2be 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -513,6 +513,8 @@ void e1000_down(struct e1000_adapter *adapter)
 	 */
 	netif_carrier_off(netdev);
 
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, NULL);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, NULL);
 	napi_disable(&adapter->napi);
 
 	e1000_irq_disable(adapter);
@@ -1392,7 +1394,10 @@ int e1000_open(struct net_device *netdev)
 	/* From here on the code is the same as e1000_up() */
 	clear_bit(__E1000_DOWN, &adapter->flags);
 
+	netif_napi_set_irq(&adapter->napi, adapter->pdev->irq);
 	napi_enable(&adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_RX, &adapter->napi);
+	netif_queue_set_napi(netdev, 0, NETDEV_QUEUE_TYPE_TX, &adapter->napi);
 
 	e1000_irq_enable(adapter);
 
-- 
2.34.1


