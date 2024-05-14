Return-Path: <netdev+bounces-96246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730F38C4B42
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38C61C212CF
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 02:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA18AD48;
	Tue, 14 May 2024 02:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="riuR2R3I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE30AD2C
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715654539; cv=none; b=ivC2T2UqDEURhIvitWb7FmhR0akigJ5Z2z/3hRBPnfeq+kVeitGjXJc5dW6t0R0c22nWXrUmA1e6x50XI8Qu5pYFG7twdmefE4FlsQn2nSXDtStP8cJ7gtT7Stj8qxtVBwS5xehCZfQaHCutyOdJr7Pe9qGNzuxvFApNU5ygY+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715654539; c=relaxed/simple;
	bh=td8c6It5hj+uCP6+zImTMaaBrNjETg5EepsjyHX3zao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFUW1wN0hFqGcth2PmORwqlKhlDKw9ekkYprzKt4TgzPtkApp51N61jjYRnJl3d1lkf8pq7qeF5veRs9dtadY1bZhWrNBV4uumrfu6Ne3tYPxgJkxQ7OD5F/qorw9I7aSPeOuWm8JbrE/rZeNjhxkskXCCed/2qt8/k7Z2aTXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=riuR2R3I; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715654537; x=1747190537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+88Lxof3ZLN1swkWfngGcIz7Js7Vef0fYSdDqIGxrLI=;
  b=riuR2R3IF4HwxukEFBlSbOjn6/3cJWlcWBfEgh1DPXSprhf5hQmpXcqo
   +OltYnl5U4WYOoZtLaigGYRJlDQmiAn0+r0uZ/+4LmcvJLoAAOV5h9Esk
   VDtAZghNhonFNSkToGFNNNwPI7aI0V4KiAc1MtPW0oBfXMtyCgGG6p89l
   o=;
X-IronPort-AV: E=Sophos;i="6.08,159,1712620800"; 
   d="scan'208";a="88937110"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 02:42:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:1843]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.62:2525] with esmtp (Farcaster)
 id adf642e2-8738-4cd3-a982-71b99db410b9; Tue, 14 May 2024 02:42:15 +0000 (UTC)
X-Farcaster-Flow-ID: adf642e2-8738-4cd3-a982-71b99db410b9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 May 2024 02:42:15 +0000
Received: from 88665a182662.ant.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 14 May 2024 02:42:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <billy@starlabs.sg>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>, <mhal@rbox.co>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net] af_unix: Update unix_sk(sk)->oob_skb under sk_receive_queue lock.
Date: Tue, 14 May 2024 11:42:02 +0900
Message-ID: <20240514024202.10366-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240513165747.GT2787@kernel.org>
References: <20240513165747.GT2787@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Mon, 13 May 2024 17:57:47 +0100
> On Mon, May 13, 2024 at 10:06:28PM +0900, Kuniyuki Iwashima wrote:
> 
> ...
> 
> > @@ -2666,13 +2681,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  			} else if (flags & MSG_PEEK) {
> >  				skb = NULL;
> >  			} else {
> > -				skb_unlink(skb, &sk->sk_receive_queue);
> > +				__skb_unlink(skb, &sk->sk_receive_queue);
> >  				WRITE_ONCE(u->oob_skb, NULL);
> > -				if (!WARN_ON_ONCE(skb_unref(skb)))
> > -					kfree_skb(skb);
> > +				unlinked_skb = skb;
> >  				skb = skb_peek(&sk->sk_receive_queue);
> >  			}
> >  		}
> > +
> > +		spin_unlock(&sk->sk_receive_queue.lock);
> > +
> > +		if (unlinked_skb) {
> > +			WARN_ON_ONCE(skb_unref(skb));
> > +			kfree_skb(skb);
> 
> Hi Iwashima-san,
> 
> Here skb is kfree'd.

Ah, I apparently made a typo...

Will fix in v4, thanks!

