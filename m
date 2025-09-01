Return-Path: <netdev+bounces-218854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F981B3EDB0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD26200904
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 18:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F74324B35;
	Mon,  1 Sep 2025 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="l4Ns5wZ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EB324B26
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756750604; cv=none; b=WeDRhoYLDvI+o6TKIMfq/n1VvRiKCLvGrb4OfujikgpycTvmoI8oPmTQl7/Xs8HdiLLoaNLmW7Z2SuOHi28Yqrj6c3dpFS+sGvpeThxz/zTt9VjqBRx0QqHKybch0D/x6vUb4h0PLH46RYLqOZ7+BnXMEMoP6Bfu2TfuV1ioen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756750604; c=relaxed/simple;
	bh=L0EpMOC7JHB9ppIV3z0p36rRmOm/BPmO29eODkrmRag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPwOZA1w06AIViPlwLcGdi7U1X0FhMYKgeo7ytyICudh3n74DDJo+MrhCyv0kldAKbNNP/LgNLddWaQ3Rq/uVvLKIfKn+mbOXyyQsQ4rDAO6Cy/jS5dTGiUJWrzOhu0MvNV/APppWmm0igPBOrgRsAvxejFFQPOm1zqp2AoreFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=l4Ns5wZ6; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MZZHtsQ01S+47U5PX6o5d1sMXwLDonsmKvPHa8vz3UU=; t=1756750603; x=1757614603; 
	b=l4Ns5wZ67GHdb4+dkjesuW4DMCLPWPkBMko136MJllPXrvQMaTFLhp8lAlxnc4I0mD241v9ntXz
	jnSXKjMTdQq9U4jhejbS2zd5cpFPvl02L+jvn5gtw9lm7qMclPx7e+VLkTt9XZVNJ3hJ8JIwLiRCT
	L6xuMSojcIw5uiF0zoB7aBZyYRxCJXy+u4C8k7STilH053vVNgn9u00tb1qgAKOoRu3kvqY+1cGtb
	72DIENDhTXgdsb3vrGCx+JckOTMJDAZ0oDu279uKzBMop811Wonh5jUq6CyvtCId+BhFVV2Oji2Ez
	VHa65SbSkkzqefuR5luLdB0kNmW6VT8N1taw==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:63765 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1ut957-0004PB-NC; Mon, 01 Sep 2025 11:16:42 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH] net: export symnbol for skb_attempt_defer_free
Date: Mon,  1 Sep 2025 11:16:23 -0700
Message-ID: <20250901181623.5571-1-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: acf3039aa8d32d1ac60a71149e52b94c

This function is useful for modules such as Homa but is not
currently visible.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>
---
 net/core/skbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9153a6ba0fcb..4aaebff26f50 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7255,6 +7255,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	if (unlikely(kick))
 		kick_defer_list_purge(sd, cpu);
 }
+EXPORT_SYMBOL(skb_attempt_defer_free);
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
 				 size_t offset, size_t len)
-- 
2.43.0


