Return-Path: <netdev+bounces-184019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D01FA92F57
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DEE19E54E7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BE1DF271;
	Fri, 18 Apr 2025 01:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iiYxrwzC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B01D9346
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940266; cv=none; b=MD5qQb4LM+Kyo/rpQT0pkORFsLJ6OP9sFmmtdwxT3auQrUKY0D7xdPluKl0SHyOwYrS1CtC5mApjRUk7bnilFGSVTRpy0W3eUUVvxQvSLjAyjjyd0I+c2NH2yUyL7+VSk1JQOt1LOoWOztybQ9nnL0hDqMbYepr9BYF/O2TV4Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940266; c=relaxed/simple;
	bh=peXZjv91qcnXAES8N8mnCKfga6OZjhML/WpesH4NfKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UP8rd6OLIgAfdo5ndHvIsfN9VM5k++o6rt/nboLYBvgFl13mx73kGpOvkezrmuDoIfZfXynp46vaTITyKcaLfqd7ZZbeAPMqf1vRCHxz/5gBTEusHoiNSwP92m7jmhTMNpS3zTiylbgpwFuO9avmaVQ0c9k8Zjbeemu2YoJ95RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iiYxrwzC; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301e05b90caso1330136a91.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744940264; x=1745545064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6JaAma8wr++LnPs79mPGowXaCOiBb9Nd8NFNngwV7o=;
        b=iiYxrwzCPHVwNzNkHvmgdeMg6G1GiTcCalPzEXwQw7saq/wrt8NPZQd/lz6GDMMX+W
         XPPtdNFinGhlG+x2SEYp1KGVoq2FwGetSV0u0R5EXdEBOSHhJOclN55yfmR1IrBEyHzK
         pWrgy+snDTtxGUJHA1iRmoMSw9FdGpf3Fqgy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744940264; x=1745545064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6JaAma8wr++LnPs79mPGowXaCOiBb9Nd8NFNngwV7o=;
        b=AUd9PnTFLJr1WJvGSskE+W+jrTNKFIhERLC8rB09uJg+xXVIHgNnI1CIV/UAhnZ2oQ
         u+A6nIhWqlwlG0naaTmTKsRl+MdbC667gEwIsT8v1iOtRJ+6PznRNwGTUKsAgvFYWYGO
         SfmmkoRXo4siIirwmS3lJGxQ/SzqiTqTkd1NBNZLovEz3xcBYLlX6j1DZpaNlEsFKbQs
         xaKA8jlOCVmyTX6LNb4mzgUWuesJHZ5tiLrqmIKufYBBU6TlxHJANG5T1qdKUXZAtUyG
         8l+b5Rj+Kr8gOXq6Bu7ySgFpYRsY6j2RVf2OZeDDgsYrWp7XU5jEIMWnN7pID9rnIC1f
         Tybg==
X-Gm-Message-State: AOJu0YyZ92WvtTNm4nD7g7KJ3DXIIigaoJTN8CeIM0MU5hp5fLBwoS9u
	5VT4Z+b3cGNB9EtqPJy2vhPR3E92WGtr7BsIWtehG/c1iTMEsT2umrbKptcfQ+aw+EdNIZxRBPj
	ZL2+ZD/5cIlflsqlpmXeyzEs+2F0h+eCz/Sy6Y9DVbSI07ntvPxnGiprC00qGcjmVpt7wTENtrs
	4i8arep+6CmLOsIumnlBt6eHTFcYX/rAILFvw=
X-Gm-Gg: ASbGnctzpSxL0i2kyFis7ztuogL4Vq/tAzLLPxmBeXqFF4FOX9XojikujtPKLMqLBbl
	u+g9iZgxd8KCWxaBGEroUfQqVsfxAHOoZiOLF9r7w+Gp7c10X4+bz3LBHHY7woPnOTrmlZksoim
	B4CMGG12nZvPAN0GpMlbIQC4ZyZWZDqf5jO1GflVBNyS+o22OVYJdq6yNuMjFZxyoLdtM5QCQiV
	fVtOJjqcfSsDaVlDotab+i6NyZJbWT/69Jn3wmq8rFNp4WONPL/ok4tWIOum8nIKqaZD0H6oxur
	Iplem3JcsXydMSLfCbhdOH7LYYeqgl3orffCNOwe/UI5Dwe8
X-Google-Smtp-Source: AGHT+IGoyjXwixKtaT9nwokLFm7CjWprehonQ2SRJ8/gfnreftjHTIyWeFkj8zCAWIIkh7aMFJzOlg==
X-Received: by 2002:a17:90b:2744:b0:2ff:53a4:74f0 with SMTP id 98e67ed59e1d1-3087bbc925dmr1451743a91.29.1744940263562;
        Thu, 17 Apr 2025 18:37:43 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df21278sm131772a91.29.2025.04.17.18.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 18:37:42 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	shaw.leon@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 1/3] netdevsim: Mark NAPI ID on skb in nsim_rcv
Date: Fri, 18 Apr 2025 01:37:03 +0000
Message-ID: <20250418013719.12094-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418013719.12094-1-jdamato@fastly.com>
References: <20250418013719.12094-1-jdamato@fastly.com>
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


