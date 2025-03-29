Return-Path: <netdev+bounces-178178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C27A75386
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 01:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8E116EA9F
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 00:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D61F417D;
	Sat, 29 Mar 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pp2NSedk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D7A4A02
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743206438; cv=none; b=CrO3SnWSUiccOn0TEYEdCBzNPeccuXWeXAnI5/fhePzSn71o3PO48FUKazF8/4W7srWJQfVhz5jfHxm6X+ptcgAs6OpWZE63AyWAjY7Oc+ostHiTkAQEIkpGhN/JuF6gLdhi0Hjo7KfVCzY3vh1+PdVe9V6KRa6wZJDzAePcb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743206438; c=relaxed/simple;
	bh=f3KSLRYztPZtU72e1oNCDVjGkG04iAkOXF18dQTDwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y01kCJSw3+k1ZKeEcSq+LmUOFBR7+dKT8QzSc22gUvdAsu0pFQBAF1urVxPjDGGM3sMRwZAANnQafxWWAVSZA2qaKlc1wPfYbk2BUX8CX9vXVSxYlOEEzltP1lpG66eFBOazndqAvjsGXoKhU9FpTG98xVZIgzSVHTRcBeGirZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pp2NSedk; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so6173075a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1743206436; x=1743811236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPU1V9zbGuhTRVdKEH46RBvue6zoABp4B3V2TgOPmvI=;
        b=pp2NSedkLSuzF1Yopb4MhjpcQ7J+jMgt0t2Rp4sfJoOPwXaudgj8M130kCw365X652
         eMjH5Iv/B4n3uepLW1xMjQKo0MaSwDi57RWx6KKt9YkjISBwCd8+rqnfyq9ugv31q6ux
         aUN47hqKNKatMClDxFcrJMwodz9wWj6PuK4pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743206436; x=1743811236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPU1V9zbGuhTRVdKEH46RBvue6zoABp4B3V2TgOPmvI=;
        b=l+38ywskInkxSNTr1Crvvh4EauDqiB7zeV8wzyFTCITkVmHCPVoJfok0IeXpG6jdig
         PMZEfuZtaAJyL4Ms3OgnNDpZyb8FRKNf+T6UzpkvHTHiyan5NSwVAvJOdEp/nD3/4Wv4
         J954FqjRke+XDEeCfiMM2T/iUftpONLxCttup7ExnRhUtx6TLA6RHJ9JmhuRqa1+048M
         k1EjVPPbIBkvCsNoPr9sRWzX0gqwLG2ABG2MQrVj13BqbWIJaMDWqO6BXiAVr1iMLpGG
         kvtcac5C0PUDJmT02KvXGy3Hv0EAhGtRiuSloCanZqs+/fzTS+Z09JD+W3hpmGEcc5cB
         C9ew==
X-Gm-Message-State: AOJu0Yz4Jhs7V9bifm6xSoW+p0agVdLo5rHiR0ZhAKV5Zp8K5g8tJSui
	i6HAIPGSGsRIxeVCq3ZxiMS2QFupQgnrHU/+OhboB0ZYRJ5yhC0No5qqVQcjJNcTSzOZSX6Qlqu
	uJ3KRlv8o4zoq9ogVxHkPyllt/BDyXS7FGJ7O5Gskdveoong2aIh5bNMBZg9pnu7MipMyJxEO8V
	fINa2w4UiObvTzxtr69z+97TKoAIhJVtz47F4=
X-Gm-Gg: ASbGnctzW5vZ0RFXetN+FXOJYTBVZAkwE3K2O9bTCpe/53Q+mADUH1ZZqb8N5xkzE4S
	xjq4DZlyl0cWTTAcaLiBNqPhFe1lg8ohLRJYBtioC4zV5gNV6cyXJ4nav8s9qMIw+LFADPdNAe8
	pgSuNpDSpVhjIU/b0mymwy16ZU1s6rcHun8sRzqgFroXXlTqHUe8eGuAryaVDftP7fP+sbBfdYX
	AXTcZmZkk0YbyeDeQAGJdOXzqgME5MsSw1guuGch6r5LeN6Grqiq4aaEf6yF5mLinFQbemHflRU
	uHnCLRga99FifMPwlVu/cQAm7DPz/4N8PpW1FgYjTI6kWZrXwtk2
X-Google-Smtp-Source: AGHT+IEiHctilbl5kXRUYriQQ4AJ9teIGPfWkfa8XK07O0x+MARn/bB66YVW99QeA5X5lwnZVkzjeA==
X-Received: by 2002:a17:90b:2dc2:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-30531f9fb9dmr1727941a91.9.1743206435615;
        Fri, 28 Mar 2025 17:00:35 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f1d4ba4sm4857139a91.31.2025.03.28.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 17:00:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net 1/1] netdevsim: Mark NAPI ID on skb in nsim_rcv
Date: Sat, 29 Mar 2025 00:00:29 +0000
Message-ID: <20250329000030.39543-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250329000030.39543-1-jdamato@fastly.com>
References: <20250329000030.39543-1-jdamato@fastly.com>
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

Fixes: 3762ec05a9fb ("netdevsim: add NAPI support")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/netdevsim/netdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index b67af4651185..1c67030fba6a 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -29,7 +29,7 @@
 #include <net/pkt_cls.h>
 #include <net/rtnetlink.h>
 #include <net/udp_tunnel.h>
-
+#include <net/busy_poll.h>
 #include "netdevsim.h"
 
 MODULE_IMPORT_NS("NETDEV_INTERNAL");
@@ -357,6 +357,7 @@ static int nsim_rcv(struct nsim_rq *rq, int budget)
 			break;
 
 		skb = skb_dequeue(&rq->skb_queue);
+		skb_mark_napi_id(skb, &rq->napi);
 		netif_receive_skb(skb);
 	}
 
-- 
2.43.0


