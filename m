Return-Path: <netdev+bounces-196640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811AAD59FD
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5AD163C04
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0621E25E8;
	Wed, 11 Jun 2025 15:11:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92CF1DE4C5;
	Wed, 11 Jun 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654680; cv=none; b=ugxwzG/KnspItLRKZ15WUrLQhfcnegSwb0Bwor+WcTZjA2jGQxdxBZuoWe/kFc/CMkoteBkXQWcPhHpwjyWPh+R/W7YRX6aT+z3yAz34jBoMaOUfSYjWDeKLtoP7KkYxEUl/CBX151InjTi9usXCPmM+WLYfbJGr2BrY45RZR00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654680; c=relaxed/simple;
	bh=iXwuaJziruMBD8hH71+MxDpo/qpQid2pIXQ49Opdlbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SANbdOSw5QOpqnF277CIC4lwHCmSCjqwPmx40wdfP3LiUZbx5eNFh+M3iX8j1IDHQNpj5MuNnymT/vbG4lAuImTGBk9S/nYGICRdKYA9f59PFVbToTSlyLilyfFDAO4ya7fe55qsIyQq8WmyraWy/aHb6vKMwegdCJ/wsSxI8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso11944692a12.3;
        Wed, 11 Jun 2025 08:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749654677; x=1750259477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cK7i3MrkzXyfeq++IoaxWfQU0vjfU+V91LzS9evvOHI=;
        b=S6fOx6IVqI1xiUj/+r6PGPGcB6Vd19oY/GNJ+GdEsQUDq0PIkB+sIezMeqHRBlyb+p
         QzM3qBkRebvGDwRqG0jSr7mRXU5ADpOurJ0IlK4SwRqs4IbfUqGr37RBJ8dtv/4VTumu
         tU31aHV3QYDK9vwdTSbSSBOwuZMPRiI9XjIk+MfJ8EAqfzk4R2KwWpiluGxRXQBNPMQ+
         4sRsjDysAd2pjNE9zF4DRnHjGIlch7zo+VkNQsV2Sh+nIPq01zfVW98JrGAgNbbvkuNQ
         9VQXCRsUTsB7b5wrSVr7q+M95k4TlqCX4RZlqXrELKGoSi+uzvXtzt45YJlUrqS68F6I
         B49g==
X-Forwarded-Encrypted: i=1; AJvYcCWSMzMv4Q9k6YHE3w8NJ+SIur5UXHeXZ9UX8hGJJEjTKx5F71AYHP+GYB8wJWC9HMfqTocqsVQLhVBEonA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPMPQuTj73ObwkuhstEvjqP+bvODtEbn+qICihjVCWsx0QTUWE
	N5GuE7Dl44H+IKjccjMcn2Ysdj97fuspr+Uvrs5XOrUgtGNjN7hv7naQ
X-Gm-Gg: ASbGncssu5y1+Kr+7aGRrJga0URcaMrGQvXQa4LUObVTPlld/6KzJ7MLkddr+GgFHYs
	ZoUUiRX59s9XYnjNweBD2Hf5xaOT3qBdC/ExBmN9QIzzPeaS4u+DyKTwVfXe+g0S4COEiuvZoO1
	gTIUOeoL3qd2H1yCxgDI+qWzQ94WwAkG4WO5fQhJJETsCrQrIDxJ4NgF49eyENHiMigwAF4HrP4
	SJQE1FhQMZSj3B4wtmCKMGCw4ZDNKbWEGvA3l1r/lsPOMRhKvii2t3+FrE4kGMt+QLmcrpWt5eR
	ebiINNAB7EdHIsFM25JlrXk/dzcQEnPTFC5vlCo2xczm00Gvt7iM
X-Google-Smtp-Source: AGHT+IE8tCK4+befdr8xutY92sqMP6GffHLBtnlsqMWXRmN5HhDYZ7Th/K7ZTKqzWKNI3TOLwoJPFw==
X-Received: by 2002:a05:6402:42d6:b0:608:3b9d:a1b with SMTP id 4fb4d7f45d1cf-60863ae566emr196180a12.19.1749654676627;
        Wed, 11 Jun 2025 08:11:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783dcd63sm7535362a12.53.2025.06.11.08.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:11:16 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 11 Jun 2025 08:06:20 -0700
Subject: [PATCH net-next 2/2] netdevsim: collect statistics at RX side
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-netdevsim_stat-v1-2-c11b657d96bf@debian.org>
References: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
In-Reply-To: <20250611-netdevsim_stat-v1-0-c11b657d96bf@debian.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, 
 Breno Leitao <Leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=leitao@debian.org;
 h=from:subject:message-id; bh=iXwuaJziruMBD8hH71+MxDpo/qpQid2pIXQ49Opdlbw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoSZyQiku65t6XjbatcRMxz6b9rKZYEo6yj3YuH
 Rp/QTqPhouJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaEmckAAKCRA1o5Of/Hh3
 baa4D/0ZdKbnJeXTIe8gzkIjRifIuiPoxNs0ASOKfwoTLCP4DWLYzllSt96IYlCCZgRIkg83YJe
 nmWEsYfIaLAxxwRBkMXNI68iEi2X0OFOBHJF8BuN+7MB+4vvpBFUYG2vdqxJgdkU5viT/MC0n26
 j/Xi0cR3lQ0slN9CYY9yid9Z9Btx9RSjyefZwqy3crppqseTUFn9Pm44zd43CRb4uTWYLTEPm22
 0wDrngNB+iDstIcqyYOvrHb7Z0tRzBKELtm5TpGYovvz6tWvt//5P8TD7GTzGU8kmajsJ8LjA//
 AzMWpVMRXutzL4T/4fxy19ee8Z2La4sMkHzmkXs/IbSdBGrGagM+5qBRfDSQwwlsFkxQnu/UvXv
 4pSyj9SHALf+NfX8YbnqyoCL7lzjvByhTiYqT8DPPqevW2OZahMWDRdD3EG4O5rKESj1PFhcP95
 r9xD9wJHaaqtG2MYm1yWwjexUED012GGtlnn8wCsXSyYyr4ZhwWLn6SlUPG5aSLDlw25jVDaqcg
 Slarmwzqf7TSLR+mPGCIroIhuONfs78AsTUCt/WSt0LgpkuPaE62hB84jVxnEt8RMqLBHUdN79o
 pJZRPhZ0mcRtYhZk/KmVWD9oqfDz8ews30r35IO+h7FdpStTzIKQuUQhRfgI7aB4lNuxsV7ZWuY
 aVP0QBNIddnCBhw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When the RX side of netdevsim was added, the RX statistics were missing,
making the driver unusable for GenerateTraffic() test framework.

This patch adds proper statistics tracking on RX side, complementing the
TX path.

Signed-off-by: Breno Leitao <Leitao@debian.org>
---
 drivers/net/netdevsim/netdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 67871d31252fe..590cb5bb0d20b 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -39,12 +39,16 @@ MODULE_IMPORT_NS("NETDEV_INTERNAL");
 
 static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
 {
+	struct net_device *dev = rq->napi.dev;
+
 	if (skb_queue_len(&rq->skb_queue) > NSIM_RING_SIZE) {
 		dev_kfree_skb_any(skb);
+		dev_dstats_rx_dropped(dev);
 		return NET_RX_DROP;
 	}
 
 	skb_queue_tail(&rq->skb_queue, skb);
+	dev_dstats_rx_add(dev, skb->len);
 	return NET_RX_SUCCESS;
 }
 

-- 
2.47.1


