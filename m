Return-Path: <netdev+bounces-247449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FDECFACEF
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E882230693C9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C284134D931;
	Tue,  6 Jan 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAL2DBx7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5F634D92A
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728426; cv=none; b=c3Q4mk5U+nuycy4U41R7AQSZtS0+5X3Fqu6hYYsuVMfQZHuHVxktSRed87Hg2vajHXZBSoGUEn42FlrYw2sU8OAATDQ3+7xeF0BR/bkzc7UXAC1Iz3isQRh1ETkxc1hvU7DKc+vKZehffv5AJmeu4SOndaATwwB1X94H7PIPciM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728426; c=relaxed/simple;
	bh=Bpj+kUXGLjy/1Cab0G2vytp5HKKFW17JhaMlcsKJ4Wo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pzoPMbYNsSE+vx+ZsNysvO6eonDM37ORMU9Kn/PtpLMGgrKV5pf+5/5vRXTjZyGRBzVqr6mFzLXtvSms+g8Mcc0LUP+n2jmyyyNfGrP9rPQBi3xTFEwMFBluGDuawS9gBSlb5Fdm5W9c0D/jB9IeROyGSGKYag7ebChUshY2BkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAL2DBx7; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8b2e2342803so343385885a.3
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767728424; x=1768333224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BVyPkON0tFRX0Umd+GljmhhfNpEnkxl+zS2SbzJZQAc=;
        b=NAL2DBx7pTbZL/HZ6DgCNnWA/mQRRj+WLPzJ7oepfKAI/1Qr5Po4p28ddIWMSCUojV
         il4ay7RDpY0nmvjpL4CTfJ3vf0HnexkUqyU3heW//BIv58lZk9mdfxgACupQm6KhnzV0
         PoiVQwXJtorV6LInrjeFG9VG9j+4BL+DTaID936w213mkwQ1GYkxbn3eFngpp4Sihw2N
         iVgFgc7YiImyGng9ZZE3BEn+tAdvX7ocb9tyM8JRQOBis8cP5cEOLBPZrRIRX8aGiGx9
         h8qolNYREnaqrPH/6xhOTI83s1I5r5ZSgAaGT3u8bcaDZPP/u9lCuNW7OOIHUtUZ3gtX
         cAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728424; x=1768333224;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVyPkON0tFRX0Umd+GljmhhfNpEnkxl+zS2SbzJZQAc=;
        b=DjHI9ExWUGFj2IpUrIYJGxgCYlwe2iNNw1sQK//t2Gcis7Ivss5D+LWiNXZMj37Sxo
         xKOhZ1oQcfxTa0AsXYwOjjTGbpBz3k48cLC0uXv+lqtLFaoAZbPDCKaRJnvcAgdAsseE
         qpP9cI1Y8NgrlzY0mInAfqKnif62rWYVR5BFhZALFGUoso8PrNOseWbxWVzb1TximwfY
         yNQI0burwegme5VJdEf0/EWHPSQ5avvhGC5k8BNLJ++okQoUvoUH3rvhk/0POSP2ecxb
         xiotsSJPZVQ69UAwUHwiaRlu59ZSKGA5gM3lw1Rl5Zg/N7gmxA6IZFclW+HOTgjvV05l
         p57A==
X-Forwarded-Encrypted: i=1; AJvYcCX2N0rWD7c7Myj+2j1ZhCx4ZOkJXgzzW71V32tJEyWcAhxclWsCKj0HqmnxuALcjNH/hrP8E+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zfDOTRenfDhCF3iWXNc2JZMMskQP6NwRPacMDf2lH1wnKWUV
	+pFKeDNNKWRyPS9QSyRui9+mT/j9OI9b1nGKVk5ByQDlAcSdKkUzKQ6+V0/EZVHAW9DGteobynd
	jOHAP04jVAQcsng==
X-Google-Smtp-Source: AGHT+IFQrCYY+hgWUNsrMD4V+SFlwwJhPmxMuz9JmSAjBrhC9ZHia5CBr9ucTz/NbZ5bafTgoQ2BuPcPjsTfLg==
X-Received: from qvbpj13.prod.google.com ([2002:a05:6214:4b0d:b0:888:b3a0:2c9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3947:b0:8a3:9bb4:9e4f with SMTP id af79cd13be357-8c37eb4c558mr551466885a.30.1767728424020;
 Tue, 06 Jan 2026 11:40:24 -0800 (PST)
Date: Tue,  6 Jan 2026 19:40:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260106194022.2133543-1-edumazet@google.com>
Subject: [PATCH net] net: bridge: annotate data-race in br_fdb_update()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Nikolay Aleksandrov <razor@blackwall.org>
Content-Type: text/plain; charset="UTF-8"

fdb->updated is read and written locklessly.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 31cbc39b6344 ("net: bridge: add option to allow activity notifications for any fdb entries")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_fdb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index 58d22e2b85fc3551bd5aec9c20296ddfcecaa040..e7bd20f0e8d6b7b24aef43d7bed34adf171c34a8 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1002,8 +1002,8 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 			unsigned long now = jiffies;
 			bool fdb_modified = false;
 
-			if (now != fdb->updated) {
-				fdb->updated = now;
+			if (now != READ_ONCE(fdb->updated)) {
+				WRITE_ONCE(fdb->updated, now);
 				fdb_modified = __fdb_mark_active(fdb);
 			}
 
-- 
2.52.0.351.gbe84eed79e-goog


