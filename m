Return-Path: <netdev+bounces-132613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A013A9926F5
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12D61C22254
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E97F17C203;
	Mon,  7 Oct 2024 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaHUJdbh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B8155392
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728289576; cv=none; b=fhgp4+dBv4b2MoE+PDh3RRwY+dvam5bLxBFRpSTm5LAxqc8PK9JRhcTJ3sHbkgu7FvHJ524ZqNwJY8vphqcLMSdsLtyrwd6OW3yoyxsmtu1c1CDtgaiftYNMzl04mYeUXwJSz5/ZZJcvTD6tEHB1uzQBloNeJ36UvzFdvfUzupQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728289576; c=relaxed/simple;
	bh=+1gEEwWpSZLcRjDa9jQ/mqn61WT0jH0j4G40yFkVl1k=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qZqybZostRO+Q1aRgWIaYavUHW0Exdw59CG8wAyd/cswXuEcYf6CpaXPuiRYnJiQ6vjC2MoM7ea7jlj8VEG42cX2IQDTSlnAh/ambqh0LlsJLtC7JDucEEbzHc1yfW+S1Gto0UhbnU2T+MGuRwEfJqh03FhKV4PnfG345x7nkZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaHUJdbh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20bc65aae97so1998955ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Oct 2024 01:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728289574; x=1728894374; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhkU6JK07Y6s+QkGwwgU/v0padACFdCeFBVqN+iQt7c=;
        b=GaHUJdbh+HCaFtiT5GFuzI++CLSCAP5W5ZckbFojqIRZKMFSZ5DU4ib7Hl8uTJWUie
         vZwhzAfuFTeIzZPnU1VbCACksPCq+Kke97TqYLyWuKpqHJgrU/YTW0q4Ny7n6xuHR6bh
         sAVzamVw1ScLHV35ImGcF4GFvEkkis2FkQB9oNymtmV5izxh8pNU3fqpNeJD8f3uTfBo
         lU9lm16kVGhzYJS1tP/sPu5rNduYMlfHb6zMc+XvbYbFQZ6u+9JZAYt2Gbq2Qljf18hD
         cjJ4iBF4Uwn9nCg5tjJ951BEF3kraTRu6EYAhr4mwa4CohETbtC8RNL7KmS/ZWteaFoj
         FeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728289574; x=1728894374;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhkU6JK07Y6s+QkGwwgU/v0padACFdCeFBVqN+iQt7c=;
        b=qbTj6oO82ZxUnN07fiPeeecjsNE8Ey7yNuA+vuyM0sRzIqjQnnvEN0HEC7OCyZGMeI
         JArElJl0C2IXLIOH2Yg1r28ybqsec9hOnchIx00hJo9m4dNk8OWXuVM04hgzOqYZgKXj
         NnwR7xmKDoyiqk4LdeLcYHTcv8Tq/j4NX6a92by0yvodjfiHmMa8NEs1sz1hpZSX6JTq
         ni8oKZJ2lSEAPerydkXObulshTIfLY5COzTi+KDToE37GjYn6gC8rp/DiqdnmWgKw7w7
         edlv3dlyjkJHai5TDIzb98CdPAXRFf27i0RRVL5L/E7u5vcClabf1RI5zFRQ8JmP1S9i
         RO9Q==
X-Gm-Message-State: AOJu0Yz17QcfaMDbu41PwlsjJCh9N192ZrFLNjyAD76jlbTPIFQRJP5X
	51keVH1HYoWeokWcKgGfVB5KuvhoV9XgvnSBqwZK0oSGlRDOip8=
X-Google-Smtp-Source: AGHT+IGHa06Ua0wYrYqj/GF7wy4fbInKZZNB+QgTNRyt0LescJtYBC5L4LmD8leJhyCUbxn+P8o/2g==
X-Received: by 2002:a17:903:41d0:b0:205:76f3:fc13 with SMTP id d9443c01a7336-20bfe495c2fmr68758445ad.7.1728289574063;
        Mon, 07 Oct 2024 01:26:14 -0700 (PDT)
Received: from VM-4-3-centos.localdomain ([43.128.101.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13968b54sm35056205ad.207.2024.10.07.01.26.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:26:13 -0700 (PDT)
From: "xin.guo" <guoxin0309@gmail.com>
To: edumazet@google.com,
	ncardwell@google.com
Cc: netdev@vger.kernel.org,
	"xin.guo" <guoxin0309@gmail.com>
Subject: [PATCH net-next v3] tcp: remove unnecessary update for tp->write_seq in tcp_connect()
Date: Mon,  7 Oct 2024 16:25:44 +0800
Message-Id: <1728289544-4611-1-git-send-email-guoxin0309@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: "xin.guo" <guoxin0309@gmail.com>

Commit 783237e8daf13 ("net-tcp: Fast Open client - sending SYN-data")
introduces tcp_connect_queue_skb() and it would overwrite tcp->write_seq,
so it is no need to update tp->write_seq before invoking
tcp_connect_queue_skb().

Signed-off-by: xin.guo <guoxin0309@gmail.com>
---
v3: Fix the style issue.
v2: Add comment to explain when to update write_seq.
---
 net/ipv4/tcp_output.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4fd746b..ab4e03a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4134,7 +4134,10 @@ int tcp_connect(struct sock *sk)
 	if (unlikely(!buff))
 		return -ENOBUFS;
 
-	tcp_init_nondata_skb(buff, tp->write_seq++, TCPHDR_SYN);
+	/* SYN eats a sequence byte, write_seq updated by
+	 * tcp_connect_queue_skb().
+	 */
+	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
-- 
1.8.3.1


