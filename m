Return-Path: <netdev+bounces-252880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WABCFZqhc2lqxgAAu9opvQ
	(envelope-from <netdev+bounces-252880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0679787EB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F36843072D96
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C83090F5;
	Fri, 23 Jan 2026 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fksHFozl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F930FC37
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185356; cv=none; b=KMiND+AHxZiwK11d/lFryvUkBNTV116DNzPKaVUeYlWtEq5kGvqno7pm4HlljQls2mCSWLEMLQFlTmPhC6FAe5E7Hl3W3qLQJJKXH1+k5r5y/Y5tUacqw1LU6wBRn3cJVhEKs41LrXDPVOaFZ+ZQs9OBQps+yS8aCimGdPRbSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185356; c=relaxed/simple;
	bh=fuHJNs9q0jub17ekWOOL9sffjn3h+K2Q6gGWIFoNBxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhB0FBP0pFq55+IM/8nUFvEBkB5J3STj9+uuqBaijsfI4VBDrOxXWKSXv6mFGpnzd7YonTnE9POQ/w/vK8n4J1AmG/0BNhJ4ZRTDk3ZsMAIBn39463bv+b/t7cBYpD82D+e8grawYuR2OR943zojS0D5V8sfXwFN+l0aEPD13N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fksHFozl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8230d228372so1028336b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185355; x=1769790155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjJ7CPS5/DqUp4cokLUu32N2BVEoOZUcO8cPBS5b2w8=;
        b=fksHFozlNfCfYywy6LVPRLHO0gQoNXGqrZZSPj26UOncI5P3bL+ZoNLQuJhsqL7+sv
         2f+8yIYZKOt6GnG6EYfg3L6jHwYSsC7RiYyuazJyIqBUo1bVn/NhXz8zDHCSveaL4Y5r
         N2gVVAA1gJp88pqw7EFSNxZHDcROBvQjebxFYS6aOI9wijX8TDpWcwUBnNCIQyhuiwWe
         w7QrYDmvUkhcGNrxRZSi2vsgndUJ7z8Vjc0AgWzsyAGqrQHTCE4ydYwiOp/KYamUnT4Y
         rSpiXI6uLDPhjULIoi/x+P9gNZdSEZjHGnZgKujkprLvzZEu9FkVYgitBAkwxUFklaZF
         7a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185355; x=1769790155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZjJ7CPS5/DqUp4cokLUu32N2BVEoOZUcO8cPBS5b2w8=;
        b=toJn1UO0FFPzA3L7AdLmaJoEoZz5Q4EdxZBCFgna/qX4RngpBgX5tpXJdeYbadNjtN
         HHh5jJMuGdamdM9xGBqP27G+Ajq51CXzNY4DVxLqFIW+8NLe6zBr8nQRB5eCWcjJjWhH
         m00iuC1OHhzJN+huioPm+CV2HcXfBmcdfrfEdaCyBAwl8w3qw18LoohcNWXwLShox7WQ
         7kpdTmnDzkO1/eD7vL9RziUPiyUeGT7I47VZlV0v4ev1f6sraK243X1aEi3i94t+uPQc
         6Fz7cycspoCs7snA2RwjWioPy8lx1ozOM3WGeGOWzEqPOBpcgXeJgyl6PLcH2+h8SEDh
         qpKg==
X-Gm-Message-State: AOJu0YytDURL8UkZllv7k0pQIpwIjRU5S/q+tbEpZ1iDkQPnxMtG78j7
	+ZkfsN9/jh564djgBVjY3bRGRXostgVwQ9nUxhFqcw6og69UqFuDwqkiQ7jbjQ==
X-Gm-Gg: AZuq6aJmySELVYLbLJGYyJqJgxOborRIMioOgAVeXiU3SKWBuzc3nCTggkotOtyPntG
	qUmSNzcGv9zR754ydOkdq/5HMJd8WNJ1kCDgwDMdvF2IXaxIO3Kfm6l93np4k/Fpa9u9oox6PbI
	4IlxZgYVh/LuX+oax6g79VuJb4G8iek5p6xMtrkjOGhsipyMybd4wbhFW3dkS1eGGRxva5GRArq
	DDbNB39AzbEqSPaoxU5I2yNMyiW9QxHA9tHoOKSRm/awww9LgHxVLvzzDD7poWMEo1qzs2XXKJL
	6LFxJFSIHyYQzRFgdKU+xFKFIioqNSP+APfYs/1iEEZevcSrG86HIrgM3DFcKKzF8D9xqH42JHV
	sifH0uSvvm/qW8yfYLkmCnuAI9RPL3CO/TdhM27lp+FRsv7Ora9Hkx5ISJCLbyq284qgYSZno3A
	WptrATPbOdHrVTULAA50X+WkeyW5N/PMq/74Vsci8OCh1XMlSsxV/EsQ==
X-Received: by 2002:a17:90b:3c06:b0:353:49f2:1e7c with SMTP id 98e67ed59e1d1-3537b272a3cmr1132136a91.30.1769185354648;
        Fri, 23 Jan 2026 08:22:34 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536dc50882sm2496967a91.16.2026.01.23.08.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 08:22:34 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/7] net: bridge: mcast: fix memcpy with u64_stats
Date: Sat, 24 Jan 2026 00:21:35 +0800
Message-ID: <20260123162159.2877941-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123162159.2877941-1-mmyangfl@gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,blackwall.org,nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252880-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0679787EB
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. memcpy() should not be considered tear-free.
Use u64_stats_reads() instead.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index d55a4ab87837..0f8e15b4fa60 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -5201,7 +5201,7 @@ void br_multicast_get_stats(const struct net_bridge *br,
 
 		do {
 			start = u64_stats_fetch_begin(&cpu_stats->syncp);
-			memcpy(&temp, &cpu_stats->mstats, sizeof(temp));
+			u64_stats_reads(&temp, &cpu_stats->mstats, sizeof(temp));
 		} while (u64_stats_fetch_retry(&cpu_stats->syncp, start));
 
 		mcast_stats_add_dir(tdst.igmp_v1queries, temp.igmp_v1queries);
-- 
2.51.0


