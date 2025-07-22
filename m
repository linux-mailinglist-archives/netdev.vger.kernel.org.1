Return-Path: <netdev+bounces-208792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75281B0D260
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 09:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37E63A6E73
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 07:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB7228CA9;
	Tue, 22 Jul 2025 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5QyJmO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF821FF46;
	Tue, 22 Jul 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168520; cv=none; b=GSASsy5m9R7r884ispYNKjOq0nttMAULaPCVsk0c06R3mXLB3XG7MCCQLt4F0O8+ASmccg8lW58tQb0WU4d6vLmaeRblLAz/xywypmxKuHCCnM150mM5Ls7qvlGISkEsnVZfiPE4RYgT1pJNb4YpwrTa8EccNlG/mkc56T0Dk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168520; c=relaxed/simple;
	bh=akOILnwcc9pmGNevA3WX5BCXInqcsvZXjaatCCQKodE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4/cwfbO4xrd/3lR3yumNcq8nY6/4JvfidK7M0xEEN5B9zotqcwH5bKCfDpbJdQgDt26CrmlnTvEOLcyBFUNWm6T6hI02sCSkPcLCylfWqx/yARsalHUvdvcv+KzJSv5nZb0RTVWgoAkELIP8GcH8d0GvpO+rrzu5uhgIVXJwTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5QyJmO0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2353a2bc210so45921915ad.2;
        Tue, 22 Jul 2025 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753168519; x=1753773319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+VMjOAQQOuEXnxm/JTcqhzieaE2t0Z16ySCSWuJaF4=;
        b=F5QyJmO0Z5z5EnfcI6SpJtIUIR8TCEp6MgtQFmDicSTX2sHn7Nlb10fbHP+5rN39Ml
         JZSQKhWGUBPtNo6iDhRALMiu+qZ5a4cbpAVfkAZryHKxNkmIGOLm7irzLkkAPl3Emt71
         fAsRc7MtnU4g7FK6avHv/BTpSaArLBLfSdT8ebCwTZuGLulRxFAgqkbqUEScJRV6oC/h
         ct0IwH9YljbxhJTFlchVpdKwse6YxNPvqCt9hz+fbbQWnF9xjXtYDHFHytBo3c/augqe
         ejCqPqiWhFstwxtf0rtNcDh3kmRQFC6AeoyebFjiNm13fPb6ehT3+w2HDfzgSdnReUK5
         JAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168519; x=1753773319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+VMjOAQQOuEXnxm/JTcqhzieaE2t0Z16ySCSWuJaF4=;
        b=wZukFW8upVosOe7mmztf5k1eK2ixaoFFo/D3A7VZHUlGaZ1A8HPNRJ9uNEi8bo1f/F
         XeyzhBzJIRz6Z3udgJTvIIVM2SZHaRqigQTr527B8Tny2qBQhxTmeXi3qG2jXt9AuvSE
         8wug7nU/8eeFuBf1/Ym3hghUThDS9QBsbATfT1h9ybRgMMujHUJI8HNKkchnZ9bOtDjS
         pgLdFvrcbEkFM9gnGx/qg3WvAXrfUH3Fqc0HaUC3HcckL1hkyLLJS64Llx4YgYmv8e/N
         ML1Q8Owjrh1tt7MZkm5BR3t7FEXkDNqD/sMFL5M4+NWRjFfhv2u8D3E88XD5oZrJ6GVz
         /tyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSv2AHHoWvnUui3wR0oS/Kb1wj5apFHnRBmm6wj2DHp/CsKZ2w2+QrwT50tHQ4lax0/3Ws5gdT@vger.kernel.org, AJvYcCX8QhC6/eQGNBBNo+WHOt9AB06YAVjsX7U23CofWP7qqe5fqFzMEW014A8RU+7OT+HmCBbMZN6wAlNLtEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIRMoGX+QrpzvH9j0YyYS0qPK/O2TVMTNZOyBfhijxhodEiWl
	oxEy9zhP4yny5h6C1XmxWNFpkOeLldMhnOPEIQU7Ucti1KfNxOSjUdvF
X-Gm-Gg: ASbGnctioFjDpwT/ZLI+w/3dgrnqdwe6AV7M2hkF97exFPNczkLM9w1oSnCGs5jVH5R
	Px4/Cvz3qkp9x8jUje22hDojBy2KGPD/vpsSTMfQu4PyZsxpmA7YrUobURA1o9bJs7ZL7D17IkV
	MwfWwN6K1wWSCYr4K81XDLxmsq84FWvnpXMVe/IbChntFPuFcXXFTGZhuQeK/pwJu5Nn/XjzO0N
	WLBro316UeGK0OpyKSxUaG73RE4O4r1bUOpEunaP/0FHwhPD6jDxUdnz0BgFmDowRRfr1eRfNkQ
	OLJbpaHBHj2hc7VZP3xtOs6kEx5tnZ5q/rSXMcwX3ndcAJcKRngL2lgbmYu5Rmrg8Rxy3r9pQEW
	khRTvx3XM5SoMowHtmzliA5BdDWRJvQ==
X-Google-Smtp-Source: AGHT+IFFtyJvM2a2AEb7k9Jrp9kmCsiJqx3vXKdoGAMsFsONk/ZGr1SJZlzNLSxI6ryLGWuWN2M70w==
X-Received: by 2002:a17:902:ea01:b0:235:2403:77c7 with SMTP id d9443c01a7336-23e2576e462mr261559035ad.37.1753168518460;
        Tue, 22 Jul 2025 00:15:18 -0700 (PDT)
Received: from archlinux ([38.188.108.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3c3a5d15sm69056005ad.62.2025.07.22.00.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:15:18 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	sdf@fomichev.me,
	kuniyu@google.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] net: Revert tx queue length on partial failure in dev_qdisc_change_tx_queue_len()
Date: Tue, 22 Jul 2025 12:45:08 +0530
Message-ID: <20250722071508.12497-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When changing the tx queue length via dev_qdisc_change_tx_queue_len(),
if one of the updates fails, the function currently exits
without rolling back previously modified queues. This can leave the
device and its qdiscs in an inconsistent state. This patch adds rollback logic
that restores the original dev->tx_queue_len and re-applies it to each previously
updated queue's qdisc by invoking qdisc_change_tx_queue_len() again.
To support this, dev_qdisc_change_tx_queue_len() now takes an additional
parameter old_len to remember the original tx_queue_len value.

Note: I have built the kernel with these changes to ensure it compiles, but I
have not tested the runtime behavior, as I am currently unsure how to test this
change.

Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 include/net/sch_generic.h |  2 +-
 net/core/dev.c            |  2 +-
 net/sched/sch_generic.c   | 12 +++++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..a4f59df2982f 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -681,7 +681,7 @@ void qdisc_class_hash_remove(struct Qdisc_class_hash *,
 void qdisc_class_hash_grow(struct Qdisc *, struct Qdisc_class_hash *);
 void qdisc_class_hash_destroy(struct Qdisc_class_hash *);
 
-int dev_qdisc_change_tx_queue_len(struct net_device *dev);
+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int old_len);
 void dev_qdisc_change_real_num_tx(struct net_device *dev,
 				  unsigned int new_real_tx);
 void dev_init_scheduler(struct net_device *dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd5..afa3c5a9bba1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9630,7 +9630,7 @@ int netif_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 		res = notifier_to_errno(res);
 		if (res)
 			goto err_rollback;
-		res = dev_qdisc_change_tx_queue_len(dev);
+		res = dev_qdisc_change_tx_queue_len(dev, orig_len);
 		if (res)
 			goto err_rollback;
 	}
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 16afb834fe4a..701dfbe722ed 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1445,7 +1445,7 @@ void mq_change_real_num_tx(struct Qdisc *sch, unsigned int new_real_tx)
 }
 EXPORT_SYMBOL(mq_change_real_num_tx);
 
-int dev_qdisc_change_tx_queue_len(struct net_device *dev)
+int dev_qdisc_change_tx_queue_len(struct net_device *dev, unsigned int old_len)
 {
 	bool up = dev->flags & IFF_UP;
 	unsigned int i;
@@ -1456,12 +1456,18 @@ int dev_qdisc_change_tx_queue_len(struct net_device *dev)
 
 	for (i = 0; i < dev->num_tx_queues; i++) {
 		ret = qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
-
-		/* TODO: revert changes on a partial failure */
 		if (ret)
 			break;
 	}
 
+	if (ret) {
+		dev->tx_queue_len = old_len;
+		while (i >= 0) {
+			qdisc_change_tx_queue_len(dev, &dev->_tx[i]);
+			i--;
+		}
+	}
+
 	if (up)
 		dev_activate(dev);
 	return ret;
-- 
2.50.1


