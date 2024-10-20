Return-Path: <netdev+bounces-137243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7019A51D9
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 03:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E0B283E8F
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 01:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E663D;
	Sun, 20 Oct 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ElWF2MRN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB44F632
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729387851; cv=none; b=jU43jvAT7bdYHwYupe373sPrc6XSBPAj0wBaK9xTahUgIpLyN12Pi6hsxe337KxFWbAa/Ptt9qX1FKr25fQQ15R1tgD7JnhWXY3rXE0q/8pP46V89G2LONIxAGTycmIwJKxAr0JsBkXLLSbAs2Kmt/ltTDa/2q88tiZ0DemrkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729387851; c=relaxed/simple;
	bh=4XeooztiNzkfqhJ3skDaux/N2pXhLH4tq7qI2HDBvsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXJo1hTnTF6PyUmSBYZ0v6zd/q4/2FiV6JYhPtLoepOUPmprLGhS0kWDc/ibKkHWwGS5XTp/f8vuaTI4TfQu7QeZ8i5dP4owHEwrL7ust9YUHw2wJxBGhwl2F6SvYMWC8rj20xsSmHKIWiEdVbr/Jz8D/C7uGgBGMtUjpD5Xm04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ElWF2MRN; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729387849; x=1760923849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JJdrUIZghZNBbo+uRvXzhKD0IqCirLlWHu/Uin2ax+A=;
  b=ElWF2MRNxnCQL/qG+ZI8k8uCmG9kv3F+2Dkulvj4nkRan0H6yDoVTwac
   Ys050woMVIjQD8YZf9MNNhQb3EcSX2FwFkIQBjQLM4WJi5SMNOkmv25FQ
   ESrmk06nw7FqPeSDZ3mTc+Phldxg7gMW7vpUBX4MTfrgvJq/6R6iPFuQS
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,217,1725321600"; 
   d="scan'208";a="442244920"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 01:30:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:12827]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id f38e3601-69d6-4ac5-b629-cdad9b3f13a3; Sun, 20 Oct 2024 01:30:45 +0000 (UTC)
X-Farcaster-Flow-ID: f38e3601-69d6-4ac5-b629-cdad9b3f13a3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 20 Oct 2024 01:30:43 +0000
Received: from 6c7e67c6786f.amazon.com (10.142.233.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 20 Oct 2024 01:30:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <remi@remlab.net>
CC: <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 5/9] phonet: Don't hold RTNL for getaddr_dumpit().
Date: Sat, 19 Oct 2024 18:30:39 -0700
Message-ID: <20241020013039.4151-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <12565887.O9o76ZdvQC@basile.remlab.net>
References: <12565887.O9o76ZdvQC@basile.remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Rémi Denis-Courmont" <remi@remlab.net>
Date: Sat, 19 Oct 2024 10:48:57 +0300
> > > >  	list_for_each_entry_rcu(pnd, &pndevs->list, list) {
> > > > 
> > > > +		DECLARE_BITMAP(addrs, 64);
> > > > 
> > > >  		u8 addr;
> > > >  		
> > > >  		if (dev_idx > dev_start_idx)
> > > > 
> > > > @@ -143,23 +146,26 @@ static int getaddr_dumpit(struct sk_buff *skb,
> > > > struct
> > > > netlink_callback *cb) continue;
> > > > 
> > > >  		addr_idx = 0;
> > > > 
> > > > -		for_each_set_bit(addr, pnd->addrs, 64) {
> > > > +		memcpy(addrs, pnd->addrs, sizeof(pnd->addrs));
> > > 
> > > Is that really safe? Are we sure that the bit-field writers are atomic
> > > w.r.t. memcpy() on all platforms? If READ_ONCE is needed for an integer,
> > > using memcpy() seems sketchy, TBH.
> > 
> > I think bit-field read/write need not be atomic here because even
> > if a data-race happens, for_each_set_bit() iterates each bit, which
> > is the real data, regardless of whether data-race happened or not.
> 
> Err, it looks to me that a corrupt bit would lead to the index getting corrupt 
> and addresses getting skipped or repeated. AFAICT, the RTNL lock is still 
> needed here.

Let's say pnd->addrs has 0b00010001 as the lowest in 8 bits
and addr_dumpit() and addr_doit() are executed concurrently,
and addr_doit() tries to change it to 0b00010011.

If we have a lock, there could be two results of dumpit().

  1.
  lock()
  dumpit() -> 0b00010001
  unlock()
                   lock()
                   doit()
                   unlock()

  2.
                   lock()
                   doit()
                   unlock()
  lock()
  dumpit() -> 0b00010011
  unlock()

If we don't have a lock and dumpit()'s read and doit()'s write
are split to upper 4 bits (0b0001) and lower 4 bits (0b0011),

there are 6 patterns of occurences, but the results are only
2 patterns and the same with the locked version.

If you get 0b00010001, you can think dumpit() completes earlier,
and the opposite if you get 0b00010011.

This is how we think with lockless algo.  In this case, we do
not require lock to iterate bitmaps.

  1.
  upper half read of dumpit()
  lower half read of dumpit()
                   upper half write of doit() -> 0b0001
                   lower half write of doit() -> 0b0011
  -> 0b00010001

  2.
  upper half read of dumpit()
                   upper half write of doit() -> 0b0001
  lower half read of dumpit()
                   lower half write of doit() -> 0b0011
  -> 0b00010001

  3.
                   upper half write of doit() -> 0b0001
  upper half read of dumpit()
  lower half read of dumpit()
                   lower half write of doit() -> 0b0011
  -> 0b00010001

  4.
                   upper half write of doit() -> 0b0001
                   lower half write of doit() -> 0b0011
  upper half read of dumpit()
  lower half read of dumpit()
  -> 0b00010011

  5.
                   upper half write of doit() -> 0b0001
  upper half read of dumpit()
                   lower half write of doit() -> 0b0011
  lower half read of dumpit()
  -> 0b00010011

  6.
  upper half read of dumpit()
                   upper half write of doit() -> 0b0001
                   lower half write of doit() -> 0b0011
  lower half read of dumpit()
  -> 0b00010011

