Return-Path: <netdev+bounces-126204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC316970038
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 07:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B836283DFC
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 05:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE2F61FDF;
	Sat,  7 Sep 2024 05:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SvCOeNwP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947042A9D;
	Sat,  7 Sep 2024 05:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725687609; cv=none; b=kecmn6VSStD7ZkslSC0HTIDFe+XVZEyaIguo4k4e5nOqGouo3o+2/TjxOB7Isb6SDjToeU5jRKmWXWfu4gfMGCus99OYqAdOzVP+F6f72G+FELHHMqCaVPgZvakq1syA/ci/p5OTHgzAuyfWDAfYFDTz2gohh50Wnc3vw/5xR4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725687609; c=relaxed/simple;
	bh=zOv4kk3/GWfBNo5nWcBcuX+02WHMxWYhahUqOM41r38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njkeH/ZqRjiaNg13IEP7Coz4E7CojJe0ZY8XWInGb8cHS/wwTO9Mf4cUwLVrkGH1pmOg8PYyyRK+1kqjo0o4qrK/JRmhRv0ISWwMfdTWgJFxdlBsspF9gg3+8q7a6sTi5JOkMI6L5zbpYZYDdx9MiT/ZmgkKsY8uNjtPtFP3UbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SvCOeNwP; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725687607; x=1757223607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V9SNpebcQe7ikkeP1XZfukxclx4L3BFjvRNWhNZfbzQ=;
  b=SvCOeNwPaAHQ2QBKEOpQ6BSLjQc1Gk8LpKqV/P5XgZhQyb6egd9spyLL
   sC1Yf6J0augsgHWDR5mw0lbG+WfdxFRFQhe3xJdsEj4Pcz6uDpNK1KOy4
   4aTsbNsPf5NlQhFpPV8UvyX9rS2a4CnNPgPxPwanPzcWZ7AaJ+iIxYEsH
   k=;
X-IronPort-AV: E=Sophos;i="6.10,210,1719878400"; 
   d="scan'208";a="123211391"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 05:40:06 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:2311]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.223:2525] with esmtp (Farcaster)
 id fb74dccc-b930-4b81-b784-ae01b38705de; Sat, 7 Sep 2024 05:40:05 +0000 (UTC)
X-Farcaster-Flow-ID: fb74dccc-b930-4b81-b784-ae01b38705de
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 7 Sep 2024 05:40:03 +0000
Received: from 88665a182662.ant.amazon.com (10.94.49.188) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 7 Sep 2024 05:40:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Fri, 6 Sep 2024 22:39:53 -0700
Message-ID: <20240907053953.60412-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2abf390b-91ff-4f37-a54d-0ceac3e0ee61@oracle.com>
References: <2abf390b-91ff-4f37-a54d-0ceac3e0ee61@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Shoaib Rao <rao.shoaib@oracle.com>
Date: Fri, 6 Sep 2024 22:06:27 -0700
> I have tried reproducing using the newly added tests but no luck. I will 
> keep trying but if there is another occurrence please let me know. I am 
> using an AMD system but that should not have any impact.
[...]
> +TEST_F(msg_oob, ex_oob_oob)
> +{
> +       sendpair("x", 1, MSG_OOB);
> +       epollpair(true);
> +       siocatmarkpair(true);
> +
> +       recvpair("x", 1, 1, MSG_OOB);
> +       epollpair(false);
> +       siocatmarkpair(true);
> +
> +       sendpair("y", 1, MSG_OOB);
> +       epollpair(true);
> +       siocatmarkpair(true);

The test fails on this line because SIOCATMARK has yet another bug
triggered by the same pattern, and my patch also fixes that.

If you remove this line, you'll see this failure on the following
recvpair("", -EAGAIN, 1, 0).

---8<---
# msg_oob.c:234:ex_oob_oob:AF_UNIX :y
# msg_oob.c:235:ex_oob_oob:Expected:Resource temporarily unavailable
# msg_oob.c:237:ex_oob_oob:Expected ret[0] (1) == expected_len (-1)
# ex_oob_oob: Test terminated by assertion
#          FAIL  msg_oob.peek.ex_oob_oob
not ok 31 msg_oob.peek.ex_oob_oob
---8<---

This failure means recv() without MSG_OOB expects -EAGAIN because
no data has been sent on the normal stream, but actually the recv()
returns 1 byte OOB data.

This is the same result triggered by the syzbot's repro.

I don't know why KASAN does not show a splat on your setup, but what
we need to do is not run the syz repro blindly and just wait a splat,
rather carefully analyse the sequence of syscalls and each consequence.

Sometimes I fixes bugs from the syzkaller's strace log without repro.

This time, the fact that recv() without MSG_OOB returns OOB data is
the clear sign that something went wrong.

You need not rely on KASAN.


> +
> +       recvpair("", -EAGAIN, 1, 0);
> +       epollpair(false);
> +       siocatmarkpair(false);
> +
> +       recvpair("", -EINVAL, 1, MSG_OOB);
> +       epollpair(false);
> +       siocatmarkpair(false);
> +}
[...]
> #  RUN           msg_oob.no_peek.ex_oob_oob ...
> # msg_oob.c:305:ex_oob_oob:Expected answ[0] (0) == oob_head (1)
> # ex_oob_oob: Test terminated by assertion
> #          FAIL  msg_oob.no_peek.ex_oob_oob

