Return-Path: <netdev+bounces-121504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2239695D7B6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14751F24DD6
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677581946B5;
	Fri, 23 Aug 2024 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="bVgPThgc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB57194147
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724444170; cv=none; b=TSI0ZeLjtny0CUu+3/SxYezH0LBH9hHc31LDUYaG2bKYcuLs5Bp+/sfUFKlQG/6LHL0pE5WZVXMZVnyYdU5eGJc3yYZsnVWgG5lMqFhDZWWZ7DEzhK+REXzms6TXiKcv6OmtM8E5wlXKbEcyP7VGhGZY/MS1lSoaVI/N6P9+A2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724444170; c=relaxed/simple;
	bh=eU0j3/8rJg2aPvh4RwRcGS6M4omz/kWqfL82UJkQcUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpUijhuBzGT6ImqQcBMnibNmqnTtFt325U1xoMrxwefqjTBD9kNi6uW1zIRnQrKi2HflnJbil5B/qrbE5JkQxaWS8ZYfBqae2PAHFhwVg4XTWlNVh+rWJTzYQcLI3P8yR/NvYadt0hPvfW1Zq3y3A2ZZ2GGKn5IR1xbTe1et7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=bVgPThgc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-713edc53429so1953516b3a.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724444168; x=1725048968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxoeXzU4BY+HKSmSR4ce1eIiQfaMzrOqErp0TccUqeA=;
        b=bVgPThgc2NRHZyeLkBsv55D/WY8a6h7uGTGL4SKhxH3Jvf1RtddQtMopTHZKcCOdur
         wucxP05gwyXKFaRCs5VX4oLERivCy0FE8hy3aK7dK5HCLENe3l1nbMmHPYQG+nVlyxyC
         6H1OUXMH6urIjLtjx7xKuAefPTFELfg5YDIRNhFRnehq6HPVvk8GWVV2yPx4Y/aAhONO
         u3LCqY3/u/1yYl4AY0P/8FMT5B/tTcrbyQZfLSS57q2eDt7YGz+3VBeGVv8LXuZd/Uxd
         gtZNBRCDOBDTkpFuW0drFEcrq5Fb8nPQkdXLGdXC1rYRKqltc3x3whrVxIr7XFVS44dD
         BM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724444168; x=1725048968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxoeXzU4BY+HKSmSR4ce1eIiQfaMzrOqErp0TccUqeA=;
        b=bpnKFKXIqbrGBYF39mF69gOZBK8S2jjc8/75Ewf6VwRLlBNZgVfwz5ynIe/4M94NsZ
         2VYtlrtlxisOPInBTfAYA6nMV6oNnrDjEwZrgWoR+FPLyffN/86rXbcCJCRtt7oA+Pct
         NVMjtIAvVbJuIed0B6Xp6I4cQb44PXPeGbPeHK2GWR37aQ2NXhauUHF/3CpDqsSJlSkm
         EI3vXcPl0514EarSXZhFcDuVucYztyU9DCAgtyh6mDWQz9uaBnDrFqZTU+P+xWCQef+D
         hbBtb0EE6Q2ruWB73E/8tsk09JNu15a00r8sEjdtjME6YC2WKIN7RTnjzgIkV9M3tM0J
         ZFsg==
X-Forwarded-Encrypted: i=1; AJvYcCW22mx3rm1GEzAbSdvfg87aUDK6XHa/zX744syIQs6sFzguZ9pNlfGv+vHxZgA793UNMkK4T7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11uTGN0Lh5Nc+ZYUpA55POArKkF04bdjs1ajCUPuWEajakdgD
	H9xWzwoUcMd4Z3doZebrQ5oNaFc7w/Ktg7LO9v61ahGlJQ32cFPOk9RBPS8xfg==
X-Google-Smtp-Source: AGHT+IGikXl2xCudNl0p/N806W2b5LcalpbKN7512RPrrAy+lWYw/SeeRngQWhHDV1nL754nOQY59w==
X-Received: by 2002:a05:6a00:2383:b0:706:3329:5533 with SMTP id d2e1a72fcca58-7144587f44fmr4665115b3a.24.1724444167996;
        Fri, 23 Aug 2024 13:16:07 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:9169:3766:b678:8be3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143422ec1csm3428525b3a.39.2024.08.23.13.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:16:06 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	felipe@sipanda.io,
	willemdebruijn.kernel@gmail.com,
	pablo@netfilter.org,
	laforge@gnumonks.org,
	xeb@mail.ru
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 01/13] ipv6: Add udp6_lib_lookup to IPv6 stubs
Date: Fri, 23 Aug 2024 13:15:45 -0700
Message-Id: <20240823201557.1794985-2-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823201557.1794985-1-tom@herbertland.com>
References: <20240823201557.1794985-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Want to do a UDP socket lookup from flow dissector so create a
stub for udp6_lib_lookup

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/net/ipv6_stubs.h | 5 +++++
 net/ipv6/af_inet6.c      | 1 +
 2 files changed, 6 insertions(+)

diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
index 8a3465c8c2c5..fc6111fe820a 100644
--- a/include/net/ipv6_stubs.h
+++ b/include/net/ipv6_stubs.h
@@ -75,6 +75,11 @@ struct ipv6_stub {
 					    struct net_device *dev);
 	int (*ip6_xmit)(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 			__u32 mark, struct ipv6_txoptions *opt, int tclass, u32 priority);
+	struct sock *(*udp6_lib_lookup)(const struct net *net,
+				     const struct in6_addr *saddr, __be16 sport,
+				     const struct in6_addr *daddr, __be16 dport,
+				     int dif, int sdif, struct udp_table *tbl,
+				     struct sk_buff *skb);
 };
 extern const struct ipv6_stub *ipv6_stub __read_mostly;
 
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 90d2c7e3f5e9..699f1e3efb91 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -1061,6 +1061,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
 	.ipv6_fragment = ip6_fragment,
 	.ipv6_dev_find = ipv6_dev_find,
 	.ip6_xmit = ip6_xmit,
+	.udp6_lib_lookup = __udp6_lib_lookup,
 };
 
 static const struct ipv6_bpf_stub ipv6_bpf_stub_impl = {
-- 
2.34.1


