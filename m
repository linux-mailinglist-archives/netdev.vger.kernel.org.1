Return-Path: <netdev+bounces-176643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D647A6B2DD
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 03:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C619C3F14
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 02:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19FA1E3793;
	Fri, 21 Mar 2025 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqaQYAno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB817C210
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523327; cv=none; b=XTHnpTN4r+G0FQ8crc3YjQmJsPueA6E1WGsTD46hHziOlOyZy3Q1qyre0XeeGc4G6dpyyZ5MXFTurZJFkERx9Sp4EsM2BO3MEy4GbIDP1ye85m5esyNF38N35GmFj0GrMbVr/BjTsntI3hme45ERdmHTwcCTMKcHpddSgmUcMaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523327; c=relaxed/simple;
	bh=9qPUJFRvaH5NS0GNs2UTDlV7jvHnVvt/ZrTgZWe+dkE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t2EakS6oaJImGZB4pv/DvpkeHLYcO99Z3ZB+lxnBjHKSiR/Tx8gxkaZPs8ChIljaxbgHBb4hc11izQ0WeeXpau6GXyidqdwFZlv2eHqcxCA1ga5Vz2pRaE0vcVwGtdo5QJA0YLbU3A+fZMQa25efkqnqhHDAiQMD+Gtq7ZxA8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqaQYAno; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff7aecba07so2163788a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 19:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742523326; x=1743128126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=22bMFnkkTwP/skJs0EQa2ggter7V1QtPhV7+lY2l0oE=;
        b=VqaQYAnoxqPCpONnh4t+wrsx6ctDfE1LeSVRK9jo/uglYP4LsqzOHfqOyUC7BS4rzS
         Ax7uxui5MYJ+CMnHNxU3+HRfC8C6JsIAmOjyDJmpZMPDsSPtLSVWF+QnBx012HP2+Hc0
         +mKfIgdmXaiIntPNppeM5EVy6nsCBGnG/pJIK2rsPkV96zN6qR2V0zHtr+XG0eAYfY8v
         sd/RTQR3SbO6NcnwAM18D47GETQGf405Loa2fTX1NNy0ZWagCsRUQTtZjijPql6x2lqR
         Xb26OYdLM6Y5vNjPMjXxIWiKSPFs3/U6T8uJylv0oe3xh6nDJvgiBXifK/sBrdJR32FU
         BYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742523326; x=1743128126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22bMFnkkTwP/skJs0EQa2ggter7V1QtPhV7+lY2l0oE=;
        b=ZtVhzRZzng5KzqCFHm9RIHfB5zsXP+UqmZH7Kew8Jrk/FAa/lFtcJbbDnuidvy+++t
         J1hxxtm7l8UaQjMYJ4ROkIk0ZoqAnDrD974ISqKVXpSJSqChfv7iOd9R3vmbp3e5E2At
         3FU1K5a861tG1OZIzoJHOGoqHDBYY+z/Cb9NYOsJAQ+3rPlHP020nno+qYupNc0gSGVW
         l9kMYuopm0q+1XzCSA4FsUAzWnt+YssScVUSNlUDuIik3E1ektuyqwnw1FEKzbLa2Ol1
         NeUUx3WLylMwmuf/PuRNRA1csoYfJndhBiJspa/fnkZfSfHg2x2SNpaLM2W+LxVriHvS
         DhJg==
X-Gm-Message-State: AOJu0YzHOZCC4jXnBXQNRS5T1BWsxwm4IhZvjVR+E/nhrFu8hOcL8Nut
	TyZpF0XQHr+rWI1SUpc/bWHtopeEf2rHsQSwHJjMQffdPtLkdSYDqzf9qaoZTFyHh0+aZRjnXit
	AsUlBHNgSPg==
X-Google-Smtp-Source: AGHT+IEFwclUKmWUme/QFOMWJXlpeLM8vVN6SY5YeTxfm39KyshADzOaZhcIGFlW7C9qEyotmjG9ZtbCYkf7hQ==
X-Received: from pjbss11.prod.google.com ([2002:a17:90b:2ecb:b0:2ff:852c:ceb8])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3508:b0:301:1c29:a1d9 with SMTP id 98e67ed59e1d1-3030fe98a08mr2007500a91.21.1742523325693;
 Thu, 20 Mar 2025 19:15:25 -0700 (PDT)
Date: Fri, 21 Mar 2025 02:15:19 +0000
In-Reply-To: <20250321021521.849856-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321021521.849856-1-skhawaja@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321021521.849856-3-skhawaja@google.com>
Subject: [PATCH net-next v4 2/4] net: Create separate gro_flush helper function
From: Samiullah Khawaja <skhawaja@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	willemb@google.com, jdamato@fastly.com, mkarsten@uwaterloo.ca
Cc: netdev@vger.kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

Move multiple copies of same code snippet doing `gro_flush` and
`gro_normal_list` into a separate helper function.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 net/core/dev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b92e4e8890d1..cc746f223554 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6516,6 +6516,13 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
+static void __napi_gro_flush_helper(struct napi_struct *napi)
+{
+	/* Flush too old packets. If HZ < 1000, flush all packets */
+	gro_flush(&napi->gro, HZ >= 1000);
+	gro_normal_list(&napi->gro);
+}
+
 #if defined(CONFIG_NET_RX_BUSY_POLL)
 
 static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
@@ -6526,9 +6533,7 @@ static void __busy_poll_stop(struct napi_struct *napi, bool skip_schedule)
 		return;
 	}
 
-	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&napi->gro, HZ >= 1000);
-	gro_normal_list(&napi->gro);
+	__napi_gro_flush_helper(napi);
 
 	clear_bit(NAPI_STATE_SCHED, &napi->state);
 }
@@ -7360,9 +7365,7 @@ static int __napi_poll(struct napi_struct *n, bool *repoll)
 		return work;
 	}
 
-	/* Flush too old packets. If HZ < 1000, flush all packets */
-	gro_flush(&n->gro, HZ >= 1000);
-	gro_normal_list(&n->gro);
+	__napi_gro_flush_helper(n);
 
 	/* Some drivers may have called napi_schedule
 	 * prior to exhausting their budget.
-- 
2.49.0.395.g12beb8f557-goog


