Return-Path: <netdev+bounces-148907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB54B9E360D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F36165D19
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01069198A36;
	Wed,  4 Dec 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZsnAaJQP"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9712317D354;
	Wed,  4 Dec 2024 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302714; cv=none; b=jON/7zt/3mscD5J+HP8gOlfvIB2AJstxxCi24v58dy/mobRr8u/HLkPtY41gA6G3qVk3naIP010s040NFcANSurCq2NqRNyOqtWhEeDwFVYzhDvDIxiI2ZhIb+FCU2ADgW8bs4k8v5hdK7NSWyGcbnJpF3IJ8laiEHfXXQwuwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302714; c=relaxed/simple;
	bh=fLYACWwFucewfXjZr5YEb2nJPip67Lv2+g81QB2bxzc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yi9TLq9H/+WviJVBjq4yJoCdQSEjtPv6woSrJBgAHu/o8W/6KYdPHQSzMjQ1d9D5VDJi09jJM1ytbXvDpIzhxXO07pfoctAcgglEYwWD3U+J2ewSENrcsgBmgPKABfPZGbuFaovlGwSWEe1ZIItMORERNyuvnRCqXs94NK5tmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZsnAaJQP; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jnuZr
	+sMFHO3kQXK5Q3ZVgkSaE9cD/7A4wzl+1kx1sc=; b=ZsnAaJQPxL094Ua+B94ee
	yHTcHT8QGN5EsiGzgyTDAM0MMMKK+kjXjMjsJ8qZbU5PmhL9h7wFGH9HReaqnM6o
	3rnVe8oGrezjVDxJsKLTMpaBhzZ8gX9UeX1DYt8kJ41NZrLDPht0XbCSfMOYjrF8
	74n89sy+wiPUtUYRdRYLks=
Received: from localhost.localdomain (unknown [14.153.182.146])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnjwecGVBn5eCyGA--.965S2;
	Wed, 04 Dec 2024 16:58:06 +0800 (CST)
From: MoYuanhao <moyuanhao3676@163.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	MoYuanhao <moyuanhao3676@163.com>
Subject: [PATCH net-next] tcp: Check space before adding MPTCP options
Date: Wed,  4 Dec 2024 16:58:01 +0800
Message-Id: <20241204085801.11563-1-moyuanhao3676@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnjwecGVBn5eCyGA--.965S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1DJF13tr4kWr4rArW3GFg_yoWfXrb_Aw
	n7Kr4kGr4rZrn2yF4kCF45AFWIgrWa9a1vgr1Skasrt348ZF1qgr4kJr93J3Z7CF45Ary7
	Jwn8JrWfWry3ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUrHUPUUUUU==
X-CM-SenderInfo: 5pr13t5qkd0jqwxwqiywtou0bp/1tbiNhOrfmdP-9CkBAABsW

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


