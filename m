Return-Path: <netdev+bounces-183576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3B0A9112E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADB81907296
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A6A1C3C18;
	Thu, 17 Apr 2025 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KEoOja1W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29AC19F13B
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744853589; cv=none; b=L+921TrrRutl6M0Z67QGZtird0W3zgjnEYrzUeW91vij0WGxr6Yy1zm8+GLGhK4yLsgjXtudmEkgHuyJsAmmvoDqOEnIR6/P+FVtnjkIDiCb9wmFxs4j2Yjdk/Ugp+GSSZFG31HRQSw+xOrRWq13Kvap4Hcez1wFtNEUqTvEGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744853589; c=relaxed/simple;
	bh=peXZjv91qcnXAES8N8mnCKfga6OZjhML/WpesH4NfKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGYtigEf0Lv1AjKwRaGOolLdVhuP3lF4mEvtLlCECir1ypXKuVOb06OttUT5fKNvXUCdO8F7EJUmLc1q+oo4zfygQ+2A5LB1NmXFCF3n9RJAMNmG55qf2ND+ElmekBYZGokfrlP2xv/3jw/HhVRGfRtqLjwdt7LWF3FbYlSIX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KEoOja1W; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22928d629faso2708655ad.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744853587; x=1745458387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6JaAma8wr++LnPs79mPGowXaCOiBb9Nd8NFNngwV7o=;
        b=KEoOja1WrHdGFy2G9Cy/x0JAFWGshQWF2ggKPEQUR/xQrAYvlq/SIZsWKrPmUNmNfI
         VqJau2ZF/rN8DNBr/ErheYuzu8wTi//IQxb5PeKIokmgVwNkqgkIbNxSw49UlhoUTYeS
         HzfABUJhxOvmrwe/6VET/0KJ662uMf+F7fBsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744853587; x=1745458387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6JaAma8wr++LnPs79mPGowXaCOiBb9Nd8NFNngwV7o=;
        b=gT5DGyxj5PuIlJiYE16uX9rQ5TEPLMmWnbYdeOLouNhFVPa0MmCWRzeBUK4luzHZbu
         ZulKjLvAQ/R7aBjlk1KWrAx90CvZ3nnYY+Ji8ETgZ1m48RxwmWa/Vk/xd12IO7VaUVdF
         er1ng/fbfl4oPvQvY1KmvSnlsBjNxrIzkRLj5txsIUqOZxaID1cqgyvLMrW/p4TAGB+6
         IxS7Yl/PPt9Ar6wib0CB7eyYxXtsFgsQz8KfU2auh601LdiXGmoEbostT6C5a5qhfCLR
         hWwD1BsF4OzW/U24vcRe1DLeO0ZNHOENfEqk7CbN+IXG9kEOhod8gtx3r33R5lmEpK90
         +cYA==
X-Gm-Message-State: AOJu0YwtPnFVyX8bqld/C5HpIBYkLdzZx1UNmmPBJkUrraWRpgX/km6Z
	7ADNlHLyCN7lWJUOmLomzdemSaBUfXqzUgXQVnzh4k8I61HXo7tzcS5ctyphWYr4+t9k0syE6Dm
	514jV1vB3BiwIJm9DEn2oKw3tyvOnyoMCGYii7wBtTeTe+F+vRUv6PMW0feKRZK9rtz0CQbYIoZ
	k3DbHecokqgn88gRLmSZpHv69+6wKE6q+AWPE=
X-Gm-Gg: ASbGncvLB+4a9xt8QCZBbr5N9eI6JoAgmx74bn9BUUoGl+0VHxqOQMj6t4+LKzhguNo
	+zZWDzzf5xEiJ4JTHVo8HW2sE4HfN+Cyhin+S631WYyWtQ8e2AwDLgyfMTqdjk85w/GOO6Zan5t
	KhpPFUWvr1zqCghw8/xs/mm/7PMZbAT1zSuFrYNczu9HWX2lDbXVdSwfVScO4G0jHU0zohkHlvE
	54v9eP3EWjKnoXeTYUBTw4PqoYWW8wv+9W2CIYifIOlR4n7XfiHEaXcxmr1ZxDp8gMuPJ+MtlRf
	zO/6MjcnyaZ025CnOss0swF5mbL/zK5TDClvCO+dgmyFLbbp
X-Google-Smtp-Source: AGHT+IHG7ipMCyI6c0/c97Gk3L/+AoJB9ydcVHy1jbC151MdKqezcYzCYtt+B9Ehn2HYIZfDsowUZw==
X-Received: by 2002:a17:903:1252:b0:225:b718:4dff with SMTP id d9443c01a7336-22c35983151mr69095555ad.53.1744853586637;
        Wed, 16 Apr 2025 18:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef11c7sm21349505ad.37.2025.04.16.18.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 18:33:06 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 1/4] netdevsim: Mark NAPI ID on skb in nsim_rcv
Date: Thu, 17 Apr 2025 01:32:39 +0000
Message-ID: <20250417013301.39228-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417013301.39228-1-jdamato@fastly.com>
References: <20250417013301.39228-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, nsim_rcv was not marking the NAPI ID on the skb, leading to
applications seeing a napi ID of 0 when using SO_INCOMING_NAPI_ID.

To add to the userland confusion, netlink appears to correctly report
the NAPI IDs for netdevsim queues but the resulting file descriptor from
a call to accept() was reporting a NAPI ID of 0.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/netdevsim/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 0e0321a7ddd7..2aa999345fe1 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,6 +29,7 @@
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
+#include <net/busy_poll.h>
 
 #include "netdevsim.h"
 
@@ -357,6 +358,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+		skb_mark_napi_id(skb, &rq->napi);
 		netif_receive_skb(skb);
 	}
 
-- 
2.43.0


