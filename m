Return-Path: <netdev+bounces-219536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B3B41D23
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 13:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DAD1BA0D50
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 11:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826202D6E62;
	Wed,  3 Sep 2025 11:35:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32231DB375;
	Wed,  3 Sep 2025 11:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899305; cv=none; b=Is0OkGf7PWlinTEeGYjr6LnCjqW6Zt9W+0HxLaVflBbiYVmiWApn3+Ih1fGfU42zq+YIxmwXF1RamRf+L7maWvwzKEl9uSsbwe9Yd+g5dcxLfqc1Rlm5a/uwG3pBQpNpRa7zSDEFVXxSqFBr8W4RftGJDTgTaXVce66xeNQhGy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899305; c=relaxed/simple;
	bh=wvOtzFNmrvA+dobfEt6VB5+4BjHGZ2We8q8u1yIqpLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVVCAurkLwG2v9tGlO6IZrzvcvjsnC4tGiXF4UK8lX7gkmn8DD0kzIZHg2SF9WDcgLrqKhZCqWOOMQsdhaAz7VzjJ4fmopX3Vp/WxIErwMbCSdwR8Od5ly2lVu6HEGheo4hBd7tuAs/9asibQdvqGy/ETqiVQytwHtDNLTznAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cH0tH5tWLz2wB7b;
	Wed,  3 Sep 2025 19:36:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id EAF6B1A0188;
	Wed,  3 Sep 2025 19:34:59 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 3 Sep
 2025 19:34:59 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] ipv6: Add sanity checks on ipv6_devconf.seg6_enabled
Date: Wed, 3 Sep 2025 19:56:48 +0800
Message-ID: <20250903115648.3126719-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500002.china.huawei.com (7.185.36.57)

In ipv6_srh_rcv() we use min(net->ipv6.devconf_all->seg6_enabled,
idev->cnf.seg6_enabled) is intended to return 0 when either value is zero,
but if one of the values is negative it will in fact return non-zero.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: use proc_dointvec_minmax()
---
 net/ipv6/addrconf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 40e9c336f6c5..69ec9cb6031e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7192,7 +7192,9 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.seg6_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	{
-- 
2.34.1


