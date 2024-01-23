Return-Path: <netdev+bounces-65157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE91839603
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBA9289D59
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A368C80020;
	Tue, 23 Jan 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HE4e4BMw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96E67FBDA
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029783; cv=none; b=KNZ8CCanqKym0WeY783jbNA403pW69ZQnGLmWZVYyNhc30zdqHXb0ssjjYOZRPhp4gmUACSr73x8dY1BG0UOycCXqNQO7nu3Y8JO7BjPNmLYzC4MBMEUgmK1Ry/tXAViMGHU1dFNQQrHNxEOOBg1DqGNzzQ/Vvs/rqkCHSjfAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029783; c=relaxed/simple;
	bh=HXK0M/w2B4+CLja5IUX6VxwZM2TQ4S0WrRzAccUTuLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OeTfWe1WY40TDxRITE+bX3VTxr1bNVjTf0quBFLPGtRemN30X8SSeCz0f2U45kE3Tq8jFpP9nsMxdU1dAnw3ol/YazKhL4XY8FuFq1x8NssI64zhQewKDmHv2wboGXHJ6/sBCXoBsx39PSwO3O7jUvFjUTZOcP+sJDSGix2FmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HE4e4BMw; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706029779; x=1737565779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7AJkRj9WSeNfXWg4wE+tGT43tfZryDxOs94iHLsARho=;
  b=HE4e4BMw/kZkX2gUKHfNPodhG4tEj4bAqL5IXj2qPZm215LA4Vidbu/7
   jCe4RlPh6OffHezSb5XRiJZvKZHo3abSyJOdTNpHyMUGg7xi9kWQaVbCj
   yVvCDSuU9///KnVj0FfiUCWIL3Uq7X32RvzaloGXuGyeJpbrBB5hf/6fq
   g=;
X-IronPort-AV: E=Sophos;i="6.05,214,1701129600"; 
   d="scan'208";a="179949686"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:09:36 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 388DC80E50;
	Tue, 23 Jan 2024 17:09:35 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:59506]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.126:2525] with esmtp (Farcaster)
 id 15629721-24bb-4c0f-b9ad-d169feca0496; Tue, 23 Jan 2024 17:09:34 +0000 (UTC)
X-Farcaster-Flow-ID: 15629721-24bb-4c0f-b9ad-d169feca0496
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:09:34 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 23 Jan 2024 17:09:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 1/5] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Tue, 23 Jan 2024 09:08:52 -0800
Message-ID: <20240123170856.41348-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240123170856.41348-1-kuniyu@amazon.com>
References: <20240123170856.41348-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

gc_in_progress is changed under spin_lock(&unix_gc_lock),
but wait_for_unix_gc() reads it locklessly.

Let's use READ_ONCE().

Fixes: 5f23b734963e ("net: Fix soft lockups/OOM issues w/ unix garbage collector")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2405f0f9af31..af3d2221cf6a 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -198,7 +198,7 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
 }
 
 /* The external entry point: unix_gc() */
-- 
2.30.2


