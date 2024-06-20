Return-Path: <netdev+bounces-105413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389FC911033
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36EB288FB5
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A2A1D0559;
	Thu, 20 Jun 2024 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEus66wz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9861BA899;
	Thu, 20 Jun 2024 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906338; cv=none; b=Dc8Tla66NiZShYo3jO94oDGiCBj2A3hJXkc5xoTNDKmtiFOxF0XmJi7ijagWXZXPCHyLanvidyqyY3MPakG7alFlrKPs8g2rWU+d67SQrvAZdihNEuQ/VRqtHTLo+xOdrVGam9ddn1QwE+NykdLrxJk5n9xXJ0M+bvp7W4QwJAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906338; c=relaxed/simple;
	bh=ywt5jQ7AnfZyxoNrW7FHAEolpYpDtzMcqsRhreJJnKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tbqe6TOxm5luTdJduiv/USd+K5Xgx82rsdD18ejVhPq/Bcv46EKRARJx/UvmLYvSmL1zZEs8YgH2JmTYeMAGp388MmejwXYhFz5wFHCTDFdyj/t5XeRGjz7MXx3jI73knoOLojCqdygsioErNz/HQXXO51bvzxp4P5a0keoEduw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEus66wz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f9de13d6baso4405965ad.2;
        Thu, 20 Jun 2024 10:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906336; x=1719511136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsYMR7W/oLrUdYReWrdeZFpoa0VAudVSEYOx4NZUcFc=;
        b=dEus66wzbWLc6RKjs0qC7OoUuC5V6/s/atRec+t6lUIXOFRzMd8T/eqcN81nPbsjDY
         mIRVwZiKVCaElOkuzU8ptFn1SLvpxrs0ld5rmZLAC5MfsT5CwPTpGqG2lzGaIYz0Q8HE
         WUMkBghlOH4JinHau8u7O0Ngoa8IGdJpFewZ4/zbT8ALhvW0K3bqkbKwB+AcOK3YTDnp
         rs+UmyxUkWpe+MS6WwWRlFa3N/wBsPtXJtcvVkLPvuEHE0pJke7YiTmHoLkBGQ5FT5pN
         buqbL9TILLHJWoTs2gCFkvfsXls4w/bnWvgN+DJWWkjflPUfQZ5yhI7cawuKCD27SQbn
         D+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906336; x=1719511136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsYMR7W/oLrUdYReWrdeZFpoa0VAudVSEYOx4NZUcFc=;
        b=XpLnJUFZ12lyS/evw3swl/z0EoaYLIAQe9Uq1uem/XrCFIcg2WzCkpYy0Hp+5WXRyC
         4H6nm+kuTu/F51C+WFjV7NTiU0/r9XFCbOoGya+WCDNhQtLm4OBREsPDYjSAGM6VEGNR
         WO5vqcEEYbAe8YjrWNvvjgVWvccs30hm/V/vk4w82G3Unbj1WV6Nj2LW6jP2o+kxe+H9
         MtUUOHtP5oA0LbixVUMwkjDPhAIxkA5XnZt8cqKoiNi4TMnN+yXcXkG26Hu3mYeQ453A
         hB4/tHlTTkJ72++CSONZZAXqpg0li0V4j9qzuY8oIwKQPw2RGCwXTH6I0GDxRz8gGOch
         tqAA==
X-Forwarded-Encrypted: i=1; AJvYcCW/SGolH4yNufbE03jgZV53WU708Czwqn5hgTBMZ0tzpmPZewSX7KlUGGzKJGaRuDdhVncbJBFvXFThEN0jgbj+g4MKQ+NC
X-Gm-Message-State: AOJu0YwOiPruEIGEnCX+at4LGQhwrmGAl9FiZhmKdE7TGmHEGi3+W5Qk
	bjt4sacaxVYxk6lOP+dSTYAE0QstB3Ml5GrNTnvPSqYOfO0XOcHmMd0dOQ5egyE=
X-Google-Smtp-Source: AGHT+IEcVgYYT890Ph3UgqxZ7WCGlaQv51dFbcwu7r/mkJrr17cMFG1OvZ8xQ71txPYDVC9RQU4wXg==
X-Received: by 2002:a17:902:f64c:b0:1f7:38a2:f1e6 with SMTP id d9443c01a7336-1f9aa473e72mr69121615ad.43.1718906336023;
        Thu, 20 Jun 2024 10:58:56 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b5b7a994sm35821215ad.177.2024.06.20.10.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:58:55 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 38/40] wifi: mac80211: drop locking around ntp_fltr_bmap
Date: Thu, 20 Jun 2024 10:57:01 -0700
Message-ID: <20240620175703.605111-39-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver operates on individual bits of the bitmap. Now that we have
atomic find_and_set_bit() helper, we can move the map manipulation out
of ntp_fltr_lock-protected area.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c437ca1c0fd3..5f4c3449570d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -51,6 +51,7 @@
 #include <linux/bitmap.h>
 #include <linux/cpu_rmap.h>
 #include <linux/cpumask.h>
+#include <linux/find_atomic.h>
 #include <net/pkt_cls.h>
 #include <net/page_pool/helpers.h>
 #include <linux/align.h>
@@ -5616,17 +5617,16 @@ static int bnxt_init_l2_filter(struct bnxt *bp, struct bnxt_l2_filter *fltr,
 			       struct bnxt_l2_key *key, u32 idx)
 {
 	struct hlist_head *head;
+	int bit_id;
 
 	ether_addr_copy(fltr->l2_key.dst_mac_addr, key->dst_mac_addr);
 	fltr->l2_key.vlan = key->vlan;
 	fltr->base.type = BNXT_FLTR_TYPE_L2;
 	if (fltr->base.flags) {
-		int bit_id;
-
-		bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap,
-						 bp->max_fltr, 0);
-		if (bit_id < 0)
+		bit_id = find_and_set_bit(bp->ntp_fltr_bmap, bp->max_fltr);
+		if (bit_id >= bp->max_fltr)
 			return -ENOMEM;
+
 		fltr->base.sw_id = (u16)bit_id;
 		bp->ntp_fltr_count++;
 	}
@@ -14396,13 +14396,11 @@ int bnxt_insert_ntp_filter(struct bnxt *bp, struct bnxt_ntuple_filter *fltr,
 	struct hlist_head *head;
 	int bit_id;
 
-	spin_lock_bh(&bp->ntp_fltr_lock);
-	bit_id = bitmap_find_free_region(bp->ntp_fltr_bmap, bp->max_fltr, 0);
-	if (bit_id < 0) {
-		spin_unlock_bh(&bp->ntp_fltr_lock);
+	bit_id = find_and_set_bit(bp->ntp_fltr_bmap, bp->max_fltr);
+	if (bit_id >= bp->max_fltr)
 		return -ENOMEM;
-	}
 
+	spin_lock_bh(&bp->ntp_fltr_lock);
 	fltr->base.sw_id = (u16)bit_id;
 	fltr->base.type = BNXT_FLTR_TYPE_NTUPLE;
 	fltr->base.flags |= BNXT_ACT_RING_DST;
-- 
2.43.0


