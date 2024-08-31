Return-Path: <netdev+bounces-123969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0663B96709A
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 11:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377A01C21972
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4240717A582;
	Sat, 31 Aug 2024 09:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1716A940;
	Sat, 31 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097830; cv=none; b=IBDclx1JakBmgsPFOw8vvlUEvPv8b3lgWjFKbtLICUJcoiXYCtDFX1KjHNY/DFONuSChe2vTySxQK7GzcZqH1aOOUIyi1bF1NqFv9ui1QYQ5kcS7haxuNKmHIJ0hyeqF0HSM7MSsLWYGhPYpIHXwrVwzMlOgOnDrau2yl8pOyhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097830; c=relaxed/simple;
	bh=NWu+3d+EFWxvZX2D3cz5F6KfdfVMO/Eefxcr/hop1bU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJW5OVR66qSdT0qrzylDXhDuIAChweWdvyPdzIM9twjbMzzSoVdHYmb7kAImHglAjKUSWGzCyaofHF48vZQ6a6RvRbF+fF6cFm1KBYtj4ggTUL+UQKGFL/KefnMXWb607LnFm+vl+gvbtGzw1P7qZN32/+MBmo6ZVeWFO88UlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wwqx95T0BzyQwv;
	Sat, 31 Aug 2024 17:49:33 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 23B7A18006C;
	Sat, 31 Aug 2024 17:50:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:50:25 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <akpm@linux-foundation.org>
CC: <linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 0/4] Introduce several opposite string choice helpers
Date: Sat, 31 Aug 2024 17:58:36 +0800
Message-ID: <20240831095840.4173362-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Similar to the exists helper: str_enable_disable/
str_enabled_disabled/str_on_off/str_yes_no helpers, we can
add the opposite helpers. That's str_disable_enable,
str_disabled_enabled, str_off_on and str_no_yes.

There are more than 10 cases currently (expect
str_disable_enable now has 3 use cases) exist in the code
can be replaced with these helper.

Patch 1: Introduce the string choice helpers
Patch 2~4: Give the relative use cases to use these helpers.

Hongbo Li (4):
  lib/string_choices: Introduce several opposite string choice helpers
  tun: Make use of str_disabled_enabled helper
  mm: page_alloc: Make use of str_off_on helper
  net: sock: Make use of str_no_yes() helper

 drivers/net/tun.c              | 2 +-
 include/linux/string_choices.h | 4 ++++
 mm/page_alloc.c                | 3 +--
 net/core/sock.c                | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1


