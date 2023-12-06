Return-Path: <netdev+bounces-54240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A388065B5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA0D281E77
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C23D282;
	Wed,  6 Dec 2023 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BuN9/3Pd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33831B9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 19:39:22 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d99c3a3a32so1939206a34.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 19:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701833962; x=1702438762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3sE9AMuF5Cpcz2r27jKfNNhaZ7KU7EZsUTmYqK/6Ww=;
        b=BuN9/3Pdku7aKoLTQFi6OllEfhpmuwClWyND6ZxD26rXszmIK3lum1ZjSCBrnXnYlm
         mtcdp6wMYNBkta09uioYQPbPh0ncrE4oELfF5hCWj4CgHTjdQyWs01X/3dJR7ZAqpm7z
         8XnHuvms8zMkdAFcGR4MOax31jalprP2OaYyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701833962; x=1702438762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3sE9AMuF5Cpcz2r27jKfNNhaZ7KU7EZsUTmYqK/6Ww=;
        b=sOFDeoU/wRwr/0KIEB1h7kMf3EJLhIbcZ6tWm6X9pKkfodV6rFp7RKMOQKCpc17KfX
         elLADn/pTEAXIEEb9LidOLQ8xuiQTXtnMnY8hkNbKK0gQACP7GGpiEvTw2ynSJU5zHay
         /UE3HFvk49QcSllBpHFIng2vaGHhOmIk6cI6GGkaVy9ngpZEgpsbNtVv3ryqjqH5uUFX
         6Ti/HimqD/ATPl+z/8tgXILkPYadFbKgxrnZDfOgCZd5sX4SJGNHr1Qb3QosDTM2pqtY
         mrcqhb4cyb41oHgDnIYIQ18tkm/lvXqO5v32ZnK32nGMnwY6mvc1r9LCQSYrpGOzYlWC
         z2tA==
X-Gm-Message-State: AOJu0Yz3QNhRLl12Qp1IQ4PBpNQCn5E9uaVjs9UXMBfZbdwIMoozMLcX
	JbdrNViklPhQ0YoMkC/CgegH/g==
X-Google-Smtp-Source: AGHT+IEtFlNImFsK/ttpZ11z7F7eXCOIhz+TBaFImOqS82wKsVg8xHnrKbMV8+ikLOdwwH689z351Q==
X-Received: by 2002:a9d:6ace:0:b0:6d8:74e2:6351 with SMTP id m14-20020a9d6ace000000b006d874e26351mr380949otq.43.1701833962233;
        Tue, 05 Dec 2023 19:39:22 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (198.180.199.104.bc.googleusercontent.com. [104.199.180.198])
        by smtp.gmail.com with ESMTPSA id r8-20020aa78b88000000b006889511ab14sm10132447pfd.37.2023.12.05.19.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 19:39:21 -0800 (PST)
From: Judy Hsiao <judyhsiao@chromium.org>
To: Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Judy Hsiao <judyhsiao@chromium.org>,
	Brian Haley <haleyb.dev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Joel Granados <joel.granados@gmail.com>,
	Julian Anastasov <ja@ssi.bg>,
	Leon Romanovsky <leon@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date: Wed,  6 Dec 2023 03:38:33 +0000
Message-ID: <20231206033913.1290566-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are seeing cases where neigh_cleanup_and_release() is called by
neigh_forced_gc() many times in a row with preemption turned off.
When running on a low powered CPU at a low CPU frequency, this has
been measured to keep preemption off for ~10 ms. That's not great on a
system with HZ=1000 which expects tasks to be able to schedule in
with ~1ms latency.

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>

---

Changes in v2:
- Use ktime_get_ns() for timeout calculation instead of jiffies.

 net/core/neighbour.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..552719c3bbc3 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
 	int max_clean = atomic_read(&tbl->gc_entries) -
 			READ_ONCE(tbl->gc_thresh2);
+	u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	int loop = 0;
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (++loop == 16) {
+				if (ktime_get_ns() > tmax)
+					goto unlock;
+				loop = 0;
+			}
 		}
 	}
 
 	WRITE_ONCE(tbl->last_flush, jiffies);
-
+unlock:
 	write_unlock_bh(&tbl->lock);
 
 	return shrunk;
-- 
2.43.0.rc2.451.g8631bc7472-goog


