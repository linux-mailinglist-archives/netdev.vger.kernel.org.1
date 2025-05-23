Return-Path: <netdev+bounces-193180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43BFAC2BFA
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4EEA40441
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 23:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4721ADA2;
	Fri, 23 May 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1237oP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2521770B
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748041534; cv=none; b=OpaG4i5CTmNBz/BBogC2lqnrU/UvKT2k181gxAKPKv+pVNHpUdQMLkWoOQrcwri5b7IEaH89LbsGNeYgdKPD6h6GCvMUvoHmLcRRPQwTNd/gPvTUjTuoQvHk9cUkMPKlAMN4mm2ridxUsLVeDTEmXfTkY1MpAw6C+3xqLzaKD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748041534; c=relaxed/simple;
	bh=XtpGf08mk62B/n49TMdckE7eT2mByGhUn/6TICm/3tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oic9fwnMhDuOVPxQg4Q3GALyeuhccJbM4/6EMWu44G9XcE3t83pBUqfMfN3nd+lpL8qNVxYOqEDpaTrHk2SIhASwOmeOCfgAb+3v382GoqcKjjV1QFTuBo8TVMpjWdR0Ecxccm3ilq3fNTQ+9dKLoihzvy4v9QpNCp5Z7mufN0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1237oP2; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so334210a12.3
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748041532; x=1748646332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jo8oX10ObykGsTsR/s0quAt1NvrEp0Zt6nav8gqqDes=;
        b=S1237oP2fGB8BGwvycGvidqRwF7caLEZhno4g/sGIAzWEhERoOrwkywBkX/aVjo9go
         CR0aSPy8LbxaNs/AAVJkfVqTLLhl4LJHpAvo9lY13tXTjmVfSBpTSXflmka2EZvT3l0+
         8ylq4qoJyNMZq9K32QqwcVSukaewJuklLv1k8AAunfhZ+iJZlvk/CHRa3TgHf7yeme1j
         VZ3GMLqbjqSLmDtIobg2XjdQWVNuWNTuOp1UTCVaMemgOurEwwCsx0ORI4bd2APkZDCe
         +x5+IHhp/tgnmeQXCXhLp89mYcx2JKz86+baKlvK9fEUdWUFN475C9yBFF04zIL1RdIR
         ORzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748041532; x=1748646332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jo8oX10ObykGsTsR/s0quAt1NvrEp0Zt6nav8gqqDes=;
        b=FSwzxpugA1uHFmQb6qCorZYf2bz7FRe57Eq0ViDm52QqnhMQcvvNdo8lMlI5VQ83O2
         dZVVkeX64ckqJwDpxGx8xIngm4QEXn55Xs3uLLjDyZIhHq2kjsX2DX9my1LHhWiPPG77
         /p4hP6glNLdRxSQytZaj64w69X6kR26kbqCRIpFJ3j8u0VjHHWgzy3Az/8kOjUQ/iEHW
         jOZ72eXepsHlBr04GcoIn4IsaSXjTUhJ5Mg0nIW34DC7nNBPHvXsQFyFSKwZu2isWsp+
         Lr2lhX2SRCx1aS6fDwQvd87yeXxTB3Vw9iFofCvwFrbESPjTkx2ndsBmnpcdTSrrh+TD
         7lAw==
X-Gm-Message-State: AOJu0Yzf5/sqZD6q3CgTz3nt54bCV8+2P71zZV/9JQQ7SWGSmQbmae5b
	5PhTfTpmEQ6Tyb2V6IqO+J5apnJgwPh3oq9TfZqutFoCkeWbFqOuKtgD+yWFlljv1Y1d9k93XMd
	kZ0saLk7FcFQWB95QVN7ZkI02rS3EcgXO30QAuyVnmy09u/7pjGPXty2L161A7jlzIGihu7FmE5
	RPsj25CnhbgkCmNv8FiH2qnasSxknb99ZON+0qT54d9K00H4Cj1IK0f6Shaocc6Cc=
X-Google-Smtp-Source: AGHT+IFoBkGFwgLLGT5f3w3RDig2i1nIBH1FsoeWWmCb4h+IXnB8/EK5ds7LLf2qaCyDmHPMD3Aak1+RlQqHMg3FlQ==
X-Received: from pliy11.prod.google.com ([2002:a17:903:3d0b:b0:232:4eb:e2c6])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f609:b0:223:f408:c3e2 with SMTP id d9443c01a7336-23414f4b44fmr16343555ad.14.1748041532044;
 Fri, 23 May 2025 16:05:32 -0700 (PDT)
Date: Fri, 23 May 2025 23:05:18 +0000
In-Reply-To: <20250523230524.1107879-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523230524.1107879-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523230524.1107879-3-almasrymina@google.com>
Subject: [PATCH net-next v2 2/8] page_pool: fix ugly page_pool formatting
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	ap420073@gmail.com, praan@google.com, shivajikant@google.com
Content-Type: text/plain; charset="UTF-8"

Minor cleanup; this line is badly formatted.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/core/page_pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 974f3eef2efa..4011eb305cee 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -867,8 +867,8 @@ void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref netmem,
 	if (!allow_direct)
 		allow_direct = page_pool_napi_local(pool);
 
-	netmem =
-		__page_pool_put_page(pool, netmem, dma_sync_size, allow_direct);
+	netmem = __page_pool_put_page(pool, netmem, dma_sync_size,
+				      allow_direct);
 	if (netmem && !page_pool_recycle_in_ring(pool, netmem)) {
 		/* Cache full, fallback to free pages */
 		recycle_stat_inc(pool, ring_full);
-- 
2.49.0.1151.ga128411c76-goog


