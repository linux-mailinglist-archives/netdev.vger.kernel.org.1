Return-Path: <netdev+bounces-123971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BB96709C
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 11:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 376C7B22B65
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0B717DFF5;
	Sat, 31 Aug 2024 09:50:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35217175D2D;
	Sat, 31 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097830; cv=none; b=jzBqOPCBUo7nUqgQ82DS672e+67prN/AcyAWejdWWgacEXQVYEiKLJqDeHD0zt8xZELAuxivGjJyGIXC3Fce44BCuHQCGJZN/LE/wt7WyzuJ3xry+nOsbhB+9aK1JGKHpjIusshCIYxbZLaElz/tmV/JKIjNV6G3rbGEi3Q+9ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097830; c=relaxed/simple;
	bh=yXFV9kxjDtuf8D75RcUN9npkhbqNaK2uQv+W214LqnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7EyopWs5kRXNMTSn6K3be1d6bfhvd3GAa4kTe2QlclBBv2ydJS3oXRADCO4uEou6SSIAaA9xwB1+XU4+FvcA0cyB4EMY3AeKsGSjZ9IDraDAKp5NgwXdLK8AAgIE6OVwphHW8HME8pjl+kijgVkmRPPsmozyufiyIe18xitI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WwqxY3TBzzyRJF;
	Sat, 31 Aug 2024 17:49:53 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 19283180100;
	Sat, 31 Aug 2024 17:50:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:50:26 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <akpm@linux-foundation.org>
CC: <linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>, <lihongbo22@huawei.com>
Subject: [PATCH -next 1/4] lib/string_choices: Introduce several opposite string choice helpers
Date: Sat, 31 Aug 2024 17:58:37 +0800
Message-ID: <20240831095840.4173362-2-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240831095840.4173362-1-lihongbo22@huawei.com>
References: <20240831095840.4173362-1-lihongbo22@huawei.com>
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

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 include/linux/string_choices.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index f3670dbd1169..c2134eeda1fd 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -8,11 +8,13 @@ static inline const char *str_enable_disable(bool v)
 {
 	return v ? "enable" : "disable";
 }
+#define str_disable_enable(v)		str_enable_disable(!(v))
 
 static inline const char *str_enabled_disabled(bool v)
 {
 	return v ? "enabled" : "disabled";
 }
+#define str_disabled_enabled(v)		str_enabled_disabled(!(v))
 
 static inline const char *str_hi_lo(bool v)
 {
@@ -36,11 +38,13 @@ static inline const char *str_on_off(bool v)
 {
 	return v ? "on" : "off";
 }
+#define str_off_on(v)		str_on_off(!(v))
 
 static inline const char *str_yes_no(bool v)
 {
 	return v ? "yes" : "no";
 }
+#define str_no_yes(v)		str_yes_no(!(v))
 
 static inline const char *str_true_false(bool v)
 {
-- 
2.34.1


