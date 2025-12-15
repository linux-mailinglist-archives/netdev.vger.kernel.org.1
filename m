Return-Path: <netdev+bounces-244735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E647CBDC1C
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F40D83009565
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C50B314B93;
	Mon, 15 Dec 2025 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZIH88CQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BA2857EA
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800886; cv=none; b=suO+dPljqcQ0twfmjCHZ9nd9jbT6ERoJC+rkdpgg++sxIlf5nEP7l81KI+ETjjiBl6/+yOOmn6YtB7/CL/FyESsgdgUmU9jaeNU+KXlZ/RCDvbRyYD9NbEocYl/yvfNDCzbYGEDOrx+yXfnMt+iNTpygxO5NWhaM7+pNChZQTJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800886; c=relaxed/simple;
	bh=qzev6H1XEFsSXgdNdXoA6uKXhB+qml6NnknlVg8Mgf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rx84bsKiSl25M55xi/tIUqZ1nI+5esydhdyMvQozknbfA2yAyjMb/mh8tGOD4nLw9nHnQ5eUARnN2u7ehR+c0oE48/TId3Uq5DGxDrJuSFdhLnuprCHxhBsNaStIPXzFUXlck286l3QYxVCDwBHHUCfgpLO8Jq4KKQLtUys39fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZIH88CQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so35546905e9.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 04:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765800883; x=1766405683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QUzh3HRON4HuLqM3J/BiPzn56jwNwHP4ZMm17mHr9BY=;
        b=PZIH88CQS92Wf95/bTpIClI29Ut+0XPRy7iyclp+6bt4dPMZTI6OHcrqwF4mffEfms
         TmBSactjr3ixUpWpav6BDyZGxfnAgChmwcoTcvney9yW+JJBOxebeFD+bz2Qqcdq+tXj
         wNB9/SFXkHHwUj4ODsy8NgGeD32yOP8heYHmH9Vi793MDEvSURH/kYEwldkwWnrddl3s
         MDF/vYQGfpluZPrJF+YzsIUI625hxu5rlooA0+PrgqSm8AAzS7nwYyvnb+3xEXWTmItq
         yYUe0VzhWsdfhO9wg8wCaNL+oczHYAah1wICNJFNZvYrc0HNuiFboi6iqK1Mnrha8l/C
         mD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765800883; x=1766405683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUzh3HRON4HuLqM3J/BiPzn56jwNwHP4ZMm17mHr9BY=;
        b=HPDkDWI6pVi5il0fpVlwbCu0XApyAEtpIQMhAI83kRL0CfYh09rQe9YZ8aAASSNaLr
         lJcMNtJtmcTzknDtVqEVRKhXaDayCCT+N770gkGFRJ5bYYotityLxqkffk5r6Jl7bQ3x
         wZl3/RxCqHnonup4DDDaHWdWk2MudgMn7StLi7icNuXe2Gp36KacXmIGKsfyDlKJsJXD
         rUxMTfajQGsaWNhNOV9LOJJgalnjiC4AcB2wp6WcGWe+WMjpdP1j999e3ywqEzpRRM6i
         CJep7JfJU2VJJPj1K/SNvGfE188xGsoGN/QSIxhUUsxBcBKjEZFh8AzzYYMlJPvW9ZDS
         o5ww==
X-Forwarded-Encrypted: i=1; AJvYcCV28IawblTM+x/F0vB0ozD0XKiM2ITiC6jc2ViYQX7Jxn+i2j94tz6VAuT4aQ2eMu5a4eVttOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGsq6ueCgSGgO6SGME+wepl5VVw/HSFmDBhm3pBS3b1+aCRuT
	M95zQZ5Y9BYpFz3wg96DFDmaXkj+vnMoHO+qApZK+inzvsDSWyDHS4Lo
X-Gm-Gg: AY/fxX7Px9MdHFCO/L4Cp3LwBM9n8QXk8XeaHu5GsADBz+Co4CkHsJ7rJDRPWveor9c
	PbAgZMEVQ7ZZJiKl1T/93FXV1jGnVnsuRYUSmKfPvKHC1ywaHOLKDHQDqptKD6j0xaaQrafg6Bl
	5Yfwr7UxBd37kadZpUYSwXHelIij1b3moQIHct6yWSB430K8kVN+1cdyLwK2QoZhX5yGK5qToVK
	wwKChLggmrFqWhH26+BF4z+02CQzE+WWQXaZVMiskHS35ptSIr6rVaJt5LgMLYEZumVzUSu6QFe
	l/sThZWcVQ4JC40bBvzEsF+bDUMiR2l8SQngGIQSGKACTQrnuryXMc473StiZ44cxXEpIYyfFtT
	m79H1+1ZX+QH9bVX88eEDatbp+qdc6/RepkkGnWjJuv2e3XfXpP487vY3RYjOwjCk5GVjeDMv6Y
	jjfjqPnCty+MPS/lYKWz2tsXpPn3U7vg081Q6Xq1C3a3dw2ba3KZnwRsICMgjPxps=
X-Google-Smtp-Source: AGHT+IFkFI5Fed5WJZaom+Q22BnP7VYpBn2pZsMhlwsCKTPIWco3rZqhSM6jBupF7mLLbA3zdSm3Nw==
X-Received: by 2002:a05:6000:1acb:b0:42b:3e20:f1b0 with SMTP id ffacd0b85a97d-42fb44a39e3mr8300705f8f.7.1765800882550;
        Mon, 15 Dec 2025 04:14:42 -0800 (PST)
Received: from t14.labs.westermo.se (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f42a3290sm13465847f8f.17.2025.12.15.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:14:42 -0800 (PST)
From: Anders Grahn <anders.grahn@gmail.com>
X-Google-Original-From: Anders Grahn <anders.grahn@westermo.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anders Grahn <anders.grahn@westermo.com>,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: [PATCH] netfilter: nft_counter: Fix reset of counters on 32bit archs
Date: Mon, 15 Dec 2025 13:12:57 +0100
Message-ID: <20251215121258.843823-1-anders.grahn@westermo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nft_counter_reset() calls u64_stats_add() with a negative value to reset
the counter. This will work on 64bit archs, hence the negative value
added will wrap as a 64bit value which then can wrap the stat counter as
well.

On 32bit archs, the added negative value will wrap as a 32bit value and
_not_ wrapping the stat counter properly. In most cases, this would just
lead to a very large 32bit value being added to the stat counter.

Fix by introducing u64_stats_sub().

Fixes: 4a1d3acd6ea8 ("netfilter: nft_counter: Use u64_stats_t for statistic")
Signed-off-by: Anders Grahn <anders.grahn@westermo.com>
---
 include/linux/u64_stats_sync.h | 10 ++++++++++
 net/netfilter/nft_counter.c    |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index 457879938fc1..9942d29b17e5 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -89,6 +89,11 @@ static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 	local64_add(val, &p->v);
 }
 
+static inline void u64_stats_sub(u64_stats_t *p, unsigned long val)
+{
+	local64_sub(val, &p->v);
+}
+
 static inline void u64_stats_inc(u64_stats_t *p)
 {
 	local64_inc(&p->v);
@@ -130,6 +135,11 @@ static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 	p->v += val;
 }
 
+static inline void u64_stats_sub(u64_stats_t *p, unsigned long val)
+{
+	p->v -= val;
+}
+
 static inline void u64_stats_inc(u64_stats_t *p)
 {
 	p->v++;
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index cc7325329496..0d70325280cc 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -117,8 +117,8 @@ static void nft_counter_reset(struct nft_counter_percpu_priv *priv,
 	nft_sync = this_cpu_ptr(&nft_counter_sync);
 
 	u64_stats_update_begin(nft_sync);
-	u64_stats_add(&this_cpu->packets, -total->packets);
-	u64_stats_add(&this_cpu->bytes, -total->bytes);
+	u64_stats_sub(&this_cpu->packets, total->packets);
+	u64_stats_sub(&this_cpu->bytes, total->bytes);
 	u64_stats_update_end(nft_sync);
 
 	local_bh_enable();
-- 
2.43.0


