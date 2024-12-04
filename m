Return-Path: <netdev+bounces-148792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C39E324C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A19828427C
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA741514CC;
	Wed,  4 Dec 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RN+42dGA"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C6A14A4FF;
	Wed,  4 Dec 2024 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284336; cv=none; b=HlIsvKdksYa6kb/nWnvhM1GQlOpJjQJ3M06cI75PLT/z6vLEdw/RLKcKCP7nAZQgwZrvsSAEaVU7mIma+2WrkVwle4oCDK+aJUUZoIR9MpoFx4qSKh3fuLdpAbF/R2se5lynSIqa7PxYyfnkOVgjbtwske2ArxBtEKkZt+ndFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284336; c=relaxed/simple;
	bh=fLYACWwFucewfXjZr5YEb2nJPip67Lv2+g81QB2bxzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ta/Zm1jCgWD8Yqdlc7ZLHaLjJQlMX8r1e4Fv6Yu8OZzQZDq6nCE8YALgTKhNWRqp4YCwL3/Osx9pq0kRKP/j4aaTqJor3jqUH02F5oXyAYvHZDIrpt5sbT0v7Hy3/Tvqv5sQxq1wlgYHo6S0KHL3ZWD+JJvEBsLVqDGMIsM41Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RN+42dGA; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jnuZr
	+sMFHO3kQXK5Q3ZVgkSaE9cD/7A4wzl+1kx1sc=; b=RN+42dGAMOqXyOOZFxQF3
	AYgGCCrl4MnabwV+A2l+ZnXjlOB3G2/NOYN8RDN8PdBdypf9djkTJVsx85wuTEKP
	EUAOHppbqmukufSC3xCsKUfottMauxd8ZYbfB662x5qKa5X1DJGQUbEANhlB/Ar3
	/aTzHqrvgDKSwOAwijIBFs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDHd1Zc0U9nHxKYBA--.64832S2;
	Wed, 04 Dec 2024 11:49:49 +0800 (CST)
From: MoYuanhao <moyuanhao3676@163.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	MoYuanhao <moyuanhao3676@163.com>
Subject: [PATCH net-next] tcp: Check space before adding MPTCP options
Date: Wed,  4 Dec 2024 11:49:46 +0800
Message-Id: <20241204034946.10794-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHd1Zc0U9nHxKYBA--.64832S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1DJF13tr4kWr4rArW3GFg_yoWfXrb_Aw
	n7Kr4kGr4rZrn2yF4kCF45AFWIgrWa9a1vgr1Skasrt348ZF1qgr4kJr93J3Z7CF45Ary7
	Jwn8JrWfWry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUxnY3UUUUU==
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/1tbiNhKrfmdPyhvF7AAAsh

Ensure enough space before adding MPTCP options in tcp_syn_options()
Added a check to verify sufficient remaining space
before inserting MPTCP options in SYN packets.
This prevents issues when space is insufficient.

Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
---
 net/ipv4/tcp_output.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 5485a70b5fe5..0e5b9a654254 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -883,8 +883,10 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		unsigned int size;
 
 		if (mptcp_syn_options(sk, skb, &size, &opts->mptcp)) {
-			opts->options |= OPTION_MPTCP;
-			remaining -= size;
+			if (remaining >= size) {
+				opts->options |= OPTION_MPTCP;
+				remaining -= size;
+			}
 		}
 	}
 
-- 
2.25.1


