Return-Path: <netdev+bounces-127168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D797472F
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 02:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E702846F0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 00:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E551388;
	Wed, 11 Sep 2024 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a3eZSySl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D7EBE;
	Wed, 11 Sep 2024 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726013837; cv=none; b=hxfpgVx0QLTpCo8ANfa9XrIkTdwS4DZTPP2EO+n7YEwaKl1Ob/BJTaj9fuc+pnL7ezBNDswzg6AlCHDaFqEtZbbyUuL3SMHQb5JMKbNhjNpcKx7wbTRTSAUzK05Gx/gsSq8eKv04gNkiy9e6CavvDrsZTQGsJ+oQzmeJyyEGzIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726013837; c=relaxed/simple;
	bh=BYzWPhWbZ5AJad5Uxdm18cFl6WCX0WmPKaMV6WUroww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4MCWuRlZVJswTE/Zoq/K+RldAclKTckjQdIuVWidF0HJP4r8WYYcpfl7LwEECNMwqbaRC+PH3CQj6txraSHWLIWDnKFwTK5KTPhMoWdA9YYm0KJ0liMih7jRQ+tEqAgZtgV87V53Dt12lIO5Z7N4McCOZDiFkywKmxe1y2IURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a3eZSySl; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726013836; x=1757549836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I76F7c150W4LR2B0J953rkue5lkGVCE1RnkJN1D2pZk=;
  b=a3eZSySlqud0NaWSyUdJVdcvESqDskOXeKbbT+uvXc+7+jKhGDrUfq0B
   mo6suIc3K5zR/O/M+rTwjbxO1htaQQcMnnw/3Lcs/fYSxMBACRYANrea1
   murow5r888HGAAgN4nEGdcU4SvP1+jUtwh4R/SbBZWyL/g/7lIOWy9hrU
   k=;
X-IronPort-AV: E=Sophos;i="6.10,218,1719878400"; 
   d="scan'208";a="452721937"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 00:17:10 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:8428]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.152:2525] with esmtp (Farcaster)
 id a6c5571e-3fa2-4822-ab9e-52f5220bb29a; Wed, 11 Sep 2024 00:17:09 +0000 (UTC)
X-Farcaster-Flow-ID: a6c5571e-3fa2-4822-ab9e-52f5220bb29a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 11 Sep 2024 00:17:08 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 11 Sep 2024 00:17:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Tue, 10 Sep 2024 17:16:58 -0700
Message-ID: <20240911001658.27733-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <1b494cee-560c-48f0-99d7-60561c91b4f1@oracle.com>
References: <1b494cee-560c-48f0-99d7-60561c91b4f1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Tue, 10 Sep 2024 16:42:33 -0700
> On 9/10/2024 3:59 PM, Kuniyuki Iwashima wrote:
> > From: Shoaib Rao <rao.shoaib@oracle.com>
> > Date: Tue, 10 Sep 2024 15:30:08 -0700
> >> My fellow engineer let's first take a breath and calm down. We both are
> >> trying to do the right thing. Now read my comments below and if I still
> >> don't get it, please be patient, maybe I am not as smart as you are.
> >>
> >> On 9/10/2024 2:53 PM, Kuniyuki Iwashima wrote:
> >>> From: Shoaib Rao <rao.shoaib@oracle.com>
> >>> Date: Tue, 10 Sep 2024 13:57:04 -0700
> >>>> The commit Message:
> >>>>
> >>>> syzbot reported use-after-free in unix_stream_recv_urg(). [0]
> >>>>
> >>>> The scenario is
> >>>>
> >>>>      1. send(MSG_OOB)
> >>>>      2. recv(MSG_OOB)
> >>>>         -> The consumed OOB remains in recv queue
> >>>>      3. send(MSG_OOB)
> >>>>      4. recv()
> >>>>         -> manage_oob() returns the next skb of the consumed OOB
> >>>>         -> This is also OOB, but unix_sk(sk)->oob_skb is not cleared
> >>>>      5. recv(MSG_OOB)
> >>>>         -> unix_sk(sk)->oob_skb is used but already freed
> >>>
> >>> How did you miss this ?
> >>>
> >>> Again, please read my patch and mails **carefully**.
> >>>
> >>> unix_sk(sk)->oob_sk wasn't cleared properly and illegal access happens
> >>> in unix_stream_recv_urg(), where ->oob_skb is dereferenced.
> >>>
> >>> Here's _technical_ thing that you want.
> >>
> >> This is exactly what I am trying to point out to you.
> >> The skb has proper references and is NOT de-referenced because
> >> __skb_datagram_iter() detects that the length is zero and returns EFAULT.
> > 
> > It's dereferenced as UNIXCB(skb).consumed first in
> > unix_stream_read_actor().
> > 
> 
> That does not matter as the skb still has a refernce. That is why I 
> asked you to print the reference count.

It does matter.  Please read carefully again...


> > Then, 1 byte of data is copied without -EFAULT because
> > unix_stream_recv_urg() always passes 1 as chunk (size) to
> > recv_actor().
> 
> Can you verify this because IIRC it is not de-refernced. AFAIK, KASAN 
> does nothing that would cause returning EFAULT and if KASAN does spot 
> this illegal access why is it not pancing the system or producing a report.
> 
> This is where we disagree.

The returned value from recv_actor() was exact 1 when KASAN was off.
It was -EFAULT only when KASAN was on.

Anyway, -EFAULT is not that important and I'm not so interested in how
KASAN triggers that.  What's important is the fact that the first UAF
is UNIXCB() and the bug happens before that.

[...]
> > Note this is on top of net-next where no additional refcnt is taken
> > for OOB

Also in my patch:

  The recent commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB
  skb.") uncovered the issue.

