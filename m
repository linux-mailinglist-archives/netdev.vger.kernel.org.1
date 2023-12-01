Return-Path: <netdev+bounces-52847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B478005EB
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAE31C20EA6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3B15AE6;
	Fri,  1 Dec 2023 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOftkOdj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035CD1717
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:39:40 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-58d12b53293so1063408eaf.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701419979; x=1702024779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HAD/BJOp3KfcAEwToEpZAFOpfcfSAx6mao3aBhe0GVs=;
        b=fOftkOdjSW3o0FXm6twOtVVAn04q2GIaFHpMitI+XsVqySe/WDltjjm4EpHmV6/6Vs
         MquYTSl8iG2kG5MJx119L/+ri8Lc1IlMUvfj4Aham58cEwbR/fwJREtIcl5GNf4VH+Vy
         rz1OEz9YYevRQ6pzDkWEi0G7eG/ffF7+SeTz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701419979; x=1702024779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HAD/BJOp3KfcAEwToEpZAFOpfcfSAx6mao3aBhe0GVs=;
        b=Q+uIxSri0S1xQWFmcM5XQ3NBayZJNc7pE4Xpj4GLlYSZDMN9e1IvOfYRMyT0QYT3jk
         M2/KDpaDbA1Ny7P6+00630jgHtV5GvtfR2+a3pOpHYrmtwZfOvn/NL12zGtGTxFbXobJ
         /9hUAn8TAuhvUa0j0RbXPvmkrrP33lez+Y8GvbDCNMwb6Zi8xGKpJZRpuEeeX2YZHT9B
         0KspEJ80RPClMQ0WSbmlst32fszKktJ6wme6lQcx4BfXWHHuzZdqNQOjo9HArVZ5AFR3
         3ynVRiohwlgvjLSOr4D8xgDFRKexNKzPIcZfA45mZmZMzL8R4OuJBQjePy5YwHoOyGHF
         Xtdg==
X-Gm-Message-State: AOJu0YxmiM3SZBQ9OqDXQ1eMTBudMuaqp3NRbao2mjqb+9oEUFUn1VWE
	WAFDmBg3TP0O27iJGmCJel3Skg==
X-Google-Smtp-Source: AGHT+IFRIZi1t3+6sB5l+ZFlRb5IEgTuJyz64lMyM/xKkArWyB7tZ0RcUsK3ZoDsk1o6uNy6C/voyA==
X-Received: by 2002:a05:6358:3a0e:b0:16d:d643:4800 with SMTP id g14-20020a0563583a0e00b0016dd6434800mr25665290rwe.21.1701419979280;
        Fri, 01 Dec 2023 00:39:39 -0800 (PST)
Received: from judyhsiao0523.c.googlers.com.com (148.175.199.104.bc.googleusercontent.com. [104.199.175.148])
        by smtp.gmail.com with ESMTPSA id hy7-20020a056a006a0700b0068790c41ca2sm2500089pfb.27.2023.12.01.00.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:39:38 -0800 (PST)
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
	Luis Chamberlain <mcgrof@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable preemption for long
Date: Fri,  1 Dec 2023 08:39:03 +0000
Message-ID: <20231201083926.1817394-1-judyhsiao@chromium.org>
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

 net/core/neighbour.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a570..f7a89c7a7673 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -256,6 +256,8 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
+	bool finish = true;
+	unsigned long timeout = jiffies + msecs_to_jiffies(1);        /* timeout in 1ms */
 
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
@@ -278,10 +280,14 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 				shrunk++;
 			if (shrunk >= max_clean)
 				break;
+			if (time_after(jiffies, timeout)) {
+				finish = false;
+				break;
+			}
 		}
 	}
-
-	WRITE_ONCE(tbl->last_flush, jiffies);
+	if (finish)
+		WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog


