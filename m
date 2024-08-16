Return-Path: <netdev+bounces-119289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 182E795510E
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902201F22BF0
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF91C3796;
	Fri, 16 Aug 2024 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EFkiW7mh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE11BDAA0
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723834327; cv=none; b=p6FAV2O0N2IQOwWoNm/ZLkPnWvflu65sha8VuXFuMXT9V2/tG5yjZhs3DGRfUluln+kEwP1oTy+BRY3IoPf3sJ1CImY/qvQn4FrKKIiNPk0zgD+JTfB70A+RrHd0lowlpMvUhfp9N31M/DlvaZw3a1INP8lcsgKs7U8fHoqpph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723834327; c=relaxed/simple;
	bh=OHTdOyjpiJd+iiBxB5h1/2v5i1CidM6PHWh1MWFtZ2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=an49BDML6DwT8Wvw/kE1asgoMmW7Vss5ZpXVCNEwVBHuPx2fVHfODOLZbw06Azgu5WA4hXz0aZB9+7wxSNNDXcckguAkYQOEiu8vmDocm++D1p31xc48hO25/1/4vInihcDpRZeMeLRPOTWiEUz+y/xvmk52pFieV46gxEmWCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EFkiW7mh; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723834325; x=1755370325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ytYBHXGork5+G5GYaKPgtCz8xZRoYdGDZXl+L6c6A/E=;
  b=EFkiW7mhSxsHjsiqAT6ASFlz6rewNYuSPfWUR0N1USI5JYjMtMl9Swy/
   Wz9xbZfFZbhm1BaVeEKnnMQWmvgE3xzyEZmCkn5b3EMYldmT8Z1tYUriC
   oQjpNDwkumoufRsud8E/2IF0qUmdigpTDLnSSjPSr+ooBnw5YXyiuGFiM
   I=;
X-IronPort-AV: E=Sophos;i="6.10,152,1719878400"; 
   d="scan'208";a="417676721"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 18:52:02 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:62971]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with esmtp (Farcaster)
 id 9c4fbda2-a42c-4ddd-a1ca-5a4dda213f0f; Fri, 16 Aug 2024 18:52:02 +0000 (UTC)
X-Farcaster-Flow-ID: 9c4fbda2-a42c-4ddd-a1ca-5a4dda213f0f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 18:52:01 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 16 Aug 2024 18:51:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dan.carpenter@linaro.org>
CC: <netdev@vger.kernel.org>, <rao.shoaib@oracle.com>, <kuniyu@amazon.com>
Subject: Re: [bug report] af_unix: Add OOB support
Date: Fri, 16 Aug 2024 11:51:49 -0700
Message-ID: <20240816185149.31006-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <f2f90f1f-f231-42ad-b94e-6960ef248a20@stanley.mountain>
References: <f2f90f1f-f231-42ad-b94e-6960ef248a20@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Fri, 16 Aug 2024 21:00:38 +0300
> On Fri, Aug 16, 2024 at 10:28:14AM -0700, Rao Shoaib wrote:
> > 
> > 
> > On 8/16/24 10:10, Dan Carpenter wrote:
> > > On Fri, Aug 16, 2024 at 09:50:56AM -0700, Rao Shoaib wrote:
> > >>
> > >>
> > >> On 8/16/24 07:22, Dan Carpenter wrote:
> > >>> Hello Rao Shoaib,
> > >>>
> > >>> Commit 314001f0bf92 ("af_unix: Add OOB support") from Aug 1, 2021
> > >>> (linux-next), leads to the following Smatch static checker warning:
> > >>>
> > >>> 	net/unix/af_unix.c:2718 manage_oob()
> > >>> 	warn: 'skb' was already freed. (line 2699)
> > >>>
> > >>> net/unix/af_unix.c
> > >>>     2665 static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> > >>>     2666                                   int flags, int copied)
> > >>>     2667 {
> > >>>     2668         struct unix_sock *u = unix_sk(sk);
> > >>>     2669 
> > >>>     2670         if (!unix_skb_len(skb)) {
> > >>>     2671                 struct sk_buff *unlinked_skb = NULL;
> > >>>     2672 
> > >>>     2673                 spin_lock(&sk->sk_receive_queue.lock);
> > >>>     2674 
> > >>>     2675                 if (copied && (!u->oob_skb || skb == u->oob_skb)) {
> > >>>     2676                         skb = NULL;
> > >>>     2677                 } else if (flags & MSG_PEEK) {
> > >>>     2678                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
> > >>>     2679                 } else {
> > >>>     2680                         unlinked_skb = skb;
> > >>>     2681                         skb = skb_peek_next(skb, &sk->sk_receive_queue);
> > >>>     2682                         __skb_unlink(unlinked_skb, &sk->sk_receive_queue);
> > >>>     2683                 }
> > >>>     2684 
> > >>>     2685                 spin_unlock(&sk->sk_receive_queue.lock);
> > >>>     2686 
> > >>>     2687                 consume_skb(unlinked_skb);
> > >>>     2688         } else {
> > >>>     2689                 struct sk_buff *unlinked_skb = NULL;
> > >>>     2690 
> > >>>     2691                 spin_lock(&sk->sk_receive_queue.lock);
> > >>>     2692 
> > >>>     2693                 if (skb == u->oob_skb) {
> > >>>     2694                         if (copied) {
> > >>>     2695                                 skb = NULL;
> > >>>     2696                         } else if (!(flags & MSG_PEEK)) {
> > >>>     2697                                 if (sock_flag(sk, SOCK_URGINLINE)) {
> > >>>     2698                                         WRITE_ONCE(u->oob_skb, NULL);
> > >>>     2699                                         consume_skb(skb);
> > >>>
> > >>> Why are we returning this freed skb?  It feels like we should return NULL.
> > >>
> > >> Hi Dan,
> > >>
> > >> manage_oob is called from the following code segment
> > >>
> > >> #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> > >>                 if (skb) {
> > >>                         skb = manage_oob(skb, sk, flags, copied);
> > >>                         if (!skb && copied) {
> > >>                                 unix_state_unlock(sk);
> > >>                                 break;
> > >>                         }
> > >>                 }
> > >> #endif
> > >>
> > >> So skb can not be NULL when manage_oob is called. The code that you
> > >> pointed out may free the skb (if the refcnts were incorrect) but skb
> > >> would not be NULL. It seems to me that the checker is incorrect or maybe
> > >> there is a way that skb maybe NULL and I am just not seeing it.
> > >>
> > >> If you can explain to me how skb can be NULL, I will be happy to fix the
> > >> issue.
> > >>
> > > 
> > > No, I was suggesting maybe we *should* return NULL.  The question is why are we
> > > returning a freed skb pointer?
> > > 
> > > regards,
> > > dan carpenter
> > 
> > We are not returning a freed skb pointer. The refcnt's protect the skb
> > from being freed. Now if somehow the refcnts are wrong and the skb gets
> > freed, that is a different issue and is a bug.
> > 
> 
> Ah ok.  Thanks!

This reminds me of my local patch that removes the additinal refcnt for
the OOB skb.

I'll post it officially.

Thanks!

