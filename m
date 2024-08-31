Return-Path: <netdev+bounces-123973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B0596709E
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 11:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F31AE1C2120A
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865A517E473;
	Sat, 31 Aug 2024 09:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F9176AD0;
	Sat, 31 Aug 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097833; cv=none; b=rELqUa+9Azys7dFYWdk5lBq4tl2oABXev1f+Lw5ee84Uso0YhF3Tj4JDBew89jKDXBe72GhcxgIr/fSj3wjeyvx/9Z6Rqa8cslOWj4QzaZY4bvhrdRe2/9gy1ORhmEJanRkW2GOGL3VSjbTrgaQIOcx70SFZ1zUGbHJr9IDYMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097833; c=relaxed/simple;
	bh=zU+OpwBs8xhHjPAevDr+3dwi/iy2BW9P6RL91Jj4ua8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plUqU2gGd6H+pRT1eA95HyTkrSx2ymzB71IcMrAaPWeAkZMVwN8NW/LfRKoynDYAgif1+CJCx2P8B5N7MGxTxIzY68oWohulPlnDbP5dlhMV2+ojCESTAzaObwbsuQvePYAyDUq5KfCbicXkdrndNMm+pjjiAS7w0xocftylr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wwqxv6JD6z1S8Kb;
	Sat, 31 Aug 2024 17:50:11 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 98D901A016C;
	Sat, 31 Aug 2024 17:50:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 17:50:27 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <kees@kernel.org>, <andy@kernel.org>, <willemdebruijn.kernel@gmail.com>,
	<jasowang@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <akpm@linux-foundation.org>
CC: <linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-mm@kvack.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next 4/4] net: sock: Make use of str_no_yes() helper
Date: Sat, 31 Aug 2024 17:58:40 +0800
Message-ID: <20240831095840.4173362-5-lihongbo22@huawei.com>
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

The helper str_no_yes is introduced to reback "no/yes"
string literal. We can use str_no_yes() helper instead
of open coding the same.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 542bc5462cb5..f976bb4a402f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4086,7 +4086,7 @@ static void proto_seq_printf(struct seq_file *seq, struct proto *proto)
 		   sock_prot_memory_allocated(proto),
 		   sock_prot_memory_pressure(proto),
 		   proto->max_header,
-		   proto->slab == NULL ? "no" : "yes",
+		   str_no_yes(proto->slab == NULL),
 		   module_name(proto->owner),
 		   proto_method_implemented(proto->close),
 		   proto_method_implemented(proto->connect),
-- 
2.34.1


