Return-Path: <netdev+bounces-132386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE3199178D
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FBA282F2A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F82156C74;
	Sat,  5 Oct 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DpSz7gUq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50626156256
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728140249; cv=none; b=shB42FgsxK9qBPOBWbd8GW4CzfJvnB/3q5RvKJLUK32kVP9qbVYzEdHCZomjt79H5bjzjmWasW+FlVZEnJu8a72bQ5Vd8yGsayPFcarAy9/xhS8NbhkgsYIYy+I3Cp+A/teNE+uUwfPUYllp71sob4RqvgMkveR4Jwhl4HIhCgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728140249; c=relaxed/simple;
	bh=ysbX5l1vLBzimCzPDgAViVv+ZxYYBsLYzrBE1+8ybHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHTKFwS3rzUkEYUourYnen3WVumWCLbJSkJ/UDVzQEc4xcXRWv2qzq5/zDwZzxyrh16VKHI7utWE3OxVkq5kZkq3STGv+ep3VbqwMtvh+CMgScflY3M9BnoP+uBXktIavV0xb7SEUja/2l7eufbcawPQUv0Xg/zcCtsKp27y7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DpSz7gUq; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e9ff6fb4c6so377110a12.3
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728140247; x=1728745047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIZerHGyKKkDkl5U8HwNES4+6GKUJadKoubjuPnUQug=;
        b=DpSz7gUqNylgUxdP9uUfImzXxW9zxYUYTacoYO55ZtSOxfaPOczx2m2YveO7yqMd6C
         d26Rpx0VOQxPLlcE/N/T9TVROgiYalO7CcTDs/+Jip3yX4lqnoCLHIaQws8/+mhoIgQX
         eveTdKYSH1z6zuCQB6HQu/OcKN5tqJuZc5a7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728140247; x=1728745047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zIZerHGyKKkDkl5U8HwNES4+6GKUJadKoubjuPnUQug=;
        b=nXe0fTwJ7tmzNNCB4An1jHr92H/8kfpPdh6ssWXMj0VE4ZAbnm/Lrnh+aKIpYG/coA
         3fmFAANz31YJpsDxeawDzh4EV5WLq4DTnP0U+rDW7snk7MWajXdqA9QNh0LnEyWe7wQs
         AAthUYVAt7+JWTgWnHY6rU6jcvA/qfsKLR8FeWnnRo4qUZ4jowyHA9xKExqvlXvSfHWh
         PwBXiWqYzPCZBjUrolljtSle940Qf7mB/yCsL9cP8+W3xRBrLEH6+yMzSQQzYKboHPQX
         YRIqmssZESGUqnXFgYsL/t1770LfPv5IYEjItX0UXF5rMd9LRl7SsP2UkhbjvAxYAD8N
         Pnfw==
X-Gm-Message-State: AOJu0Yw1i+FznDK6eYUZQ4l21174MLBtDP1gS6I1NsjQXK2Dp9eo3l4r
	dqAqgjzxVg2EmMpMH210tcLMxu0CmEXaog7tC5nyUFevIcq23oImQ5iw/KDxZzXOcvLBGodUPLr
	xhpj86OcCX3RCABntbTu5gMtPOvvBsETHf0JhcDdIcx5rBeS2JpYuK/CO4bfwfz6FkuMjmf5cMr
	FCl0RUTzSId7J1p8xwbFBJn5R/TCWmvJ2xK2M=
X-Google-Smtp-Source: AGHT+IEiERjQcTgt7RF6P0SsPQ0UjCg+IJotQMwFZzgz0muvxhy1nyS1UI6dlzjI4j/sBinrRL+JlA==
X-Received: by 2002:a05:6a21:3983:b0:1d6:236f:bd6b with SMTP id adf61e73a8af0-1d6df72467cmr11886207637.0.1728140247287;
        Sat, 05 Oct 2024 07:57:27 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7d3b5sm1569273b3a.215.2024.10.05.07.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 07:57:26 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [net-next v3 1/2] tg3: Link IRQs to NAPI instances
Date: Sat,  5 Oct 2024 14:57:16 +0000
Message-Id: <20241005145717.302575-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241005145717.302575-1-jdamato@fastly.com>
References: <20241005145717.302575-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link IRQs to NAPI instances with netif_napi_set_irq. This information
can be queried with the netdev-genl API.

Compare the output of /proc/interrupts for my tg3 device with the output of
netdev-genl after applying this patch:

$ cat /proc/interrupts | grep eth0 | cut -f1 --delimiter=':'
 343
 344
 345
 346
 347

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
			 --dump napi-get --json='{"ifindex": 2}'

[{'id': 8197, 'ifindex': 2, 'irq': 347},
 {'id': 8196, 'ifindex': 2, 'irq': 346},
 {'id': 8195, 'ifindex': 2, 'irq': 345},
 {'id': 8194, 'ifindex': 2, 'irq': 344},
 {'id': 8193, 'ifindex': 2, 'irq': 343}]

Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 rfcv3:
   - wrapped the netif_napi_add call to 80 characters

 drivers/net/ethernet/broadcom/tg3.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 378815917741..6564072b47ba 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7413,9 +7413,11 @@ static void tg3_napi_init(struct tg3 *tp)
 {
 	int i;
 
-	netif_napi_add(tp->dev, &tp->napi[0].napi, tg3_poll);
-	for (i = 1; i < tp->irq_cnt; i++)
-		netif_napi_add(tp->dev, &tp->napi[i].napi, tg3_poll_msix);
+	for (i = 0; i < tp->irq_cnt; i++) {
+		netif_napi_add(tp->dev, &tp->napi[i].napi,
+			       i ? tg3_poll_msix : tg3_poll);
+		netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
+	}
 }
 
 static void tg3_napi_fini(struct tg3 *tp)
-- 
2.25.1


