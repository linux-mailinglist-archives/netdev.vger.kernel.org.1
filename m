Return-Path: <netdev+bounces-135364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ECE99D9DD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4DE28228F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E744D1D0F61;
	Mon, 14 Oct 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ToUZL1zr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874614D439
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945823; cv=none; b=rmEGrRcip4O6ue+yKRuec3H7UKt7dc9TxzIwJA3BFajjxVlRNJgxiLJQ5pXqOVc9volFf4BZ4PVQ+WWPq4dTnhoC290LrOTI3tvqX71FIVFOM9vV83Q0cuDcThC5+cGaM079b+p207P0bgFXTtgmjAi72yTAtG1TbyEftmIWjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945823; c=relaxed/simple;
	bh=xEz9ekkSg87yBeMAROCegHNDfFf3oQvX128VxUMW2lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAYoPwLWuZ+KMomjeWGv8ReidM9ZNSW+3RNYzgDL6rScQNQaAs4IIoVYg96SEMzB0pGXg/kgn5IaM5Y/QyuYpp+awGsvHd0GdriClCTSanqpxhfkFDvIxFZXzjdzAhAOHbVHOorVCMtGiUSyneA8a3wrt8kwLx1brga8LZLDuS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ToUZL1zr; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728945823; x=1760481823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lch8UcCeQEZ3qggxdDl9Ee591IdCexyhfRiBAQo1UXQ=;
  b=ToUZL1zrHRkQVopLEblIqK2UXZeX2Ufp8EXMYH09X0pubvKOrug49WUm
   wp+Si9eS+hJd/Ht4Q3Ge7am/xZ/m1Cp1SdPys+WSS23ZyNp28M902I9pR
   AgY84+3bP6SngaJST95onWsgdrsdaX2+is90ofqwIfeyregyWsJK/p298
   s=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="239265503"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 22:43:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:16042]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id b77555b3-6888-4d4f-bc4e-f2aadd78bd88; Mon, 14 Oct 2024 22:43:38 +0000 (UTC)
X-Farcaster-Flow-ID: b77555b3-6888-4d4f-bc4e-f2aadd78bd88
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 22:43:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 22:43:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 1/2] Convert neighbour-table to use hlist
Date: Mon, 14 Oct 2024 15:43:32 -0700
Message-ID: <20241014224332.5038-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241013104521.3844432-1-gnaaman@drivenets.com>
References: <20241013104521.3844432-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Sun, 13 Oct 2024 10:45:21 +0000
> > The current neigh_for_each() is only used in spectrum_router.c
> > and can be moved to mlxsw_sp_neigh_rif_made_sync_each() with
> > the new macro used.
> 
> Oh, I completely missed that it exists, sorry.
> 
> > Let's split this patch for ease of review.
> > 
> >   1. Add hlist_node and link/unlink by hlist_add() / hlist_del()
> >   2. Define neigh_for_each() macro and move the current
> >      neigh_for_each() to mlxsw_sp_neigh_rif_made_sync_each()
> >   3. Rewrite the seq_file part with macro
> >   4. Convert the rest of while()/for() with macro
> >   5. Remove ->next
> 
> Just making sure, you mean that in (1.) I should add hlist_node *alongside*
> the current `struct neighbour __rcu *next`, and only remove this duplication in
> (5.)?

Right, it will allow part-by-part changes that are easier to review.

