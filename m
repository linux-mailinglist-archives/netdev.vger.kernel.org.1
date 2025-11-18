Return-Path: <netdev+bounces-239453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB2AC68845
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id CDC1B2A702
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DE6315D3B;
	Tue, 18 Nov 2025 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wSLoyHZj"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9230FC1C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457981; cv=none; b=XxGbGm9kv68zIZ4x19v9TJSmb67I74q86owDeBYlVcmrGlQvs/OAn6P1dgQh9UZxELahquQ1n4ig4i106Ak0WajFl0FbF66Bi9pPCthnpQb+p3fHhkBMHHWuFcCIHGj/xYYH+lZ9DA2/cpOtmr8sDJo2jcZxHC7tvdRYq1Iouyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457981; c=relaxed/simple;
	bh=WBmQq2XZwEZZyg7DllNSNIA7bqgyfnTxZKe1YOhh3IE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekUY+jGuphtzPKf5Mn7WbS94rud4//J91Hbnme6EhIaXu+01bJ1lTPd4QkUc9aCsjZGPuviw0HiidvPHeAv+57AefSP2FUoiIdVVd8THR0bLsdFTAtlM9arBag+yQU9BkW42F3J6/xfbpHv+HAGIqEql8s0deflnd6ZQzlYkXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wSLoyHZj; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 23CE320885;
	Tue, 18 Nov 2025 10:26:18 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdTmLZsIIPNo; Tue, 18 Nov 2025 10:26:16 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 507E22074B;
	Tue, 18 Nov 2025 10:26:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 507E22074B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1763457976;
	bh=x5/iutxgzI5WBViSaGmiPbfqWacCC7AqQDMXBgY6SaQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=wSLoyHZjNjG+xACizWIKB1hvxYbIcMd6m/HzZ8mYYfUcH3t+aGsn6dpW+nOopgjKw
	 PkvgS3R3Z9nnN5Hu3z2cg4HSapV5jsWoO2+Azt9bEgRz35tvVHnbrIXQh/H3PXU5nd
	 beF6u3zmpeYxE17pO07EfuzbfkMvbslipPClaPgVc+gzp8wAaI4ffutEoLNVlsD0kJ
	 3gzILea9Pfyk2jzPqplGkjpoi1+s1TDqc3fCXyh5JMQhPkLrrCaNdqQGT4+CL4lRyZ
	 UOKeA0b9P2oENg33c9XDzrMzuWFtLGy5PsxPgVKFQOJXcg3QyEIQZeZ9prGIZvrz+C
	 3tG6+ajUr3CoA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 18 Nov
 2025 10:26:15 +0100
Received: (nullmailer pid 2223991 invoked by uid 1000);
	Tue, 18 Nov 2025 09:26:12 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 10/12] Documentation: xfrm_sync: Number the fifth section
Date: Tue, 18 Nov 2025 10:25:47 +0100
Message-ID: <20251118092610.2223552-11-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118092610.2223552-1-steffen.klassert@secunet.com>
References: <20251118092610.2223552-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

From: Bagas Sanjaya <bagasdotme@gmail.com>

Number the fifth section ("Exception to threshold settings") to be
consistent with the rest of sections.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 Documentation/networking/xfrm_sync.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index de4da4707037..112f7c102ad0 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -179,8 +179,8 @@ happened) is set to inform the user what happened.
 Note the two flags are mutually exclusive.
 The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-Exceptions to threshold settings
---------------------------------
+5) Exceptions to threshold settings
+-----------------------------------
 
 If you have an SA that is getting hit by traffic in bursts such that
 there is a period where the timer threshold expires with no packets
-- 
2.43.0


