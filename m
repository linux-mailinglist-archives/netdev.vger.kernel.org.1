Return-Path: <netdev+bounces-301926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S65GFiABPWqlvggAu9opvQ
	(envelope-from <netdev+bounces-301926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:21:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F156C49CC
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:21:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j4otTKTn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301926-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301926-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07D403037993
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9293CF686;
	Thu, 25 Jun 2026 10:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF8373C0E
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 10:20:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382840; cv=none; b=LdSl3ST4JcePeOmnD6/4sWKkZxyomnEq5jqdCtq/VFn/kz72sDEZPLD7KsYhNeOga4jrZAC19PNV4bx1ZL4oyP5f4eat81LA7dJF7UBk/4ub6Q/OSzSOFZ9ViImRcDJgN55lw+/3SrGztr2j7yjm+ckFaMMs6ACfgajlSvMys/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382840; c=relaxed/simple;
	bh=hpdunQZeDol5jGOum6exlQkX5KKwm2jdFhKqGmcCsfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PxUS+Mckq14Nn8d8DaUlBnzIOctw50XQhtxmaWgZ0xCibrDAWseY5zAeFoqqi4IAUaelj0+vlliCP54yVqTVmVC+s3yNeV/5exb6x78eOVwA0Csds2YuAzopMxq6cmBTE3xKmGnUwRlAyxwU3kZdKGQMZUvLr329/gjGCRLCq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4otTKTn; arc=none smtp.client-ip=209.85.160.170
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-517dc520840so18694211cf.3
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782382838; x=1782987638; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cxR5cHIOGl4c9Qw3KbJRtqqizdF1jtJEz4y2CfGovZo=;
        b=j4otTKTnNwHdqp6GCQkIH8A2n/YRz7a1hMQ5mMzsseiR0RuI0nC4TB4yr8rudz6N9f
         RUXrhDpoHknEKuhaFJ9NVGUzCRLiEGVfUDIIkrOqrJ+pf16R0hD9hoq7mUo3yD5nd/XL
         FszrLmGWHlXo9wk9qz8kjiP8IS0pnVAv1y3rWElVZ+kRGfyCzSuP42z8MT/2gohBcNAY
         LIb3x+adYI2xFR5Gx+zgm4uUuyQOWGz8HO3hlDzjZoR+3V95+m70/sfRGxtwNleDVhi6
         SNlqpaAjyfo1VHSd+PufPFILIQOMU2Iq2/e/BGwu03KMpOrY34ip1tycT1I18P3QsnyH
         0kxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782382838; x=1782987638;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxR5cHIOGl4c9Qw3KbJRtqqizdF1jtJEz4y2CfGovZo=;
        b=eMUiOi0/ESxF2xEYcxgq7nXnLqnv+YKoxlpJDPZBJgugmrSqc8AUyinIaj4lFBSgQ2
         aWncSx2tWSWIu9PlbLHE5VFbX8AnaDhq0xGw6dJl5vaMDbjZh875rnfp9HemVe69zSfZ
         PMDWx9+WdHkN9Kf6Z8mgq0hSOmiJt8rwSSmS6OZC1LZJawZBwjrTVBUyUFO1I6YjF+TE
         wvn+AqHf+Se88qu0e737Q6f63d5GPVYa60+/nW2Nygg3N2Odj+L1tMXFworT4+NhuN/7
         vQ2t8+NLEN00BwMkdI4o1vA7gtvmRn11wGbfr1qBxV/PZmn9/zgcd0Qt5EYaBwSode/c
         hrnw==
X-Gm-Message-State: AOJu0Yy4YyGkonXY8FTAn8PXWD9uu/O25tbe8AxUJDrFLAirWgEqf1hT
	kQo1TDvwO+iFGOkR46966b49V4SXsNnFWqJ/5R9c1reKeyMavsFxAiItZZfwMctT
X-Gm-Gg: AfdE7cnrskHeBX2Ood528j0KxU8JjjEkVPZlxE5lX2mqZQiXiB48uz/28t2WnKiCW/5
	67MPkFDCYkW3LirFiD5m6pgx4rjLppkGOZazoLCet1C2St7XHKRIWpoXoU+z1Bt6PE8eXDfucbj
	wjL1bCTvF5CM2OJErMWgzd4swsrcOb4o8xuI4FBQVRRZowHkBsvOl9L7PpHwrj3CcEgmWHrCs0D
	UanBcswWzG5pejT55ZIsrtw23/LRbpU2xHpfR0koBiI8vdvqDGbnJA0BnltADW61ZUcvs478tp9
	e7R9drck9uRsI/ReW068lTRmpXISubRhGonshTRuiPFnwbQUU+GZgzQ6gVSZKDCO6CpORGZVf26
	SJdT+gO4Miymb2h4mkaEmwlQNetXxcG/1NjjboKQpdI+5edAysUGc3znBt+8FlwpyhVsO0evmeM
	kjs5Ssk+yuf1VubA3pyt58bmIyf5nSWA==
X-Received: by 2002:ac8:584c:0:b0:517:97f9:78f5 with SMTP id d75a77b69052e-51a726e28b6mr25158291cf.10.1782382838453;
        Thu, 25 Jun 2026 03:20:38 -0700 (PDT)
Received: from localhost.localdomain ([66.198.16.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7fbdd5f1sm179259076d6.21.2026.06.25.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 03:20:38 -0700 (PDT)
From: Vimal Agrawal <avimalin@gmail.com>
X-Google-Original-From: Vimal Agrawal <vimal.agrawal@sophos.com>
To: netdev@vger.kernel.org
Cc: kuniyu@google.com,
	edumazet@google.com,
	vimal.agrawal@sophos.com,
	avimalin@gmail.com
Subject: [PATCH net-next] net: neigh: avoid calling neigh_forced_gc on every alloc when table is full
Date: Thu, 25 Jun 2026 10:20:20 +0000
Message-Id: <20260625102020.92814-1-vimal.agrawal@sophos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com>
References: <CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuniyu@google.com,m:edumazet@google.com,m:vimal.agrawal@sophos.com,m:avimalin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301926-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,sophos.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avimalin@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sophos.com:mid,sophos.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1F156C49CC

Once the neighbour table exceeds gc_thresh3, neigh_forced_gc() is called
on every allocation attempt with no rate limiting. In workloads with mostly
active/reachable entries, the GC walk traverses a large portion of the
neighbour table without reclaiming entries, holding tbl->lock for an
extended period. This causes severe lock contention and allocation
latencies exceeding 16ms under sustained neighbour creation.

Add a pre-lock check in neigh_forced_gc() to skip the GC run if one was
performed within the last second, avoiding repeated full table scans and
lock acquisitions on the hot allocation path.

Profiling of neigh_create() shows ~3 orders of magnitude latency
improvement with this change.

Link:https://lore.kernel.org/netdev/CALkUMdSCpx_ywYCx_ePLdm6yioO1nQWx7sSM=AEgsq0kywHxTw@mail.gmail.com/
Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
---
 net/core/neighbour.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 1349c0eedb64..078842db3c5f 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -260,6 +260,9 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 	int shrunk = 0;
 	int loop = 0;
 
+	if (!time_after(jiffies, READ_ONCE(tbl->last_flush) + HZ))
+		return 0;
+
 	NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
 
 	spin_lock_bh(&tbl->lock);
-- 
2.17.1


