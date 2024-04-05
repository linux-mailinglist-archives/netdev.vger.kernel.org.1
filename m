Return-Path: <netdev+bounces-85369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDDF89A782
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 01:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B584F1C2149E
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BAF19BA3;
	Fri,  5 Apr 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c/6a2QMh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D8376F5
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 23:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712358111; cv=none; b=sWIWJmyCBovs1K6AuqFe1ovc2dUun2bZCKEN0GZxdBnVs080jjOOtdnCetGxZZ4fE/11q/V4UKeB/fugCMZi4wgo7CQVfiHFUp0Xtb6bETA9c5FyV9ZpU4qG7zGVF8a2MieA59uDxRMbiH3/KfVNd0Ei0FJrTNYedeeRQu+c4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712358111; c=relaxed/simple;
	bh=k5H/yR6arJ5NCDBLrEA1syYMZtBuNnIlwL28T5C/GGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR1TDLMQ/rdHDTSmjqSf5LmlBFe/k0TzGZ0MOYMpnUqUwVSW6NbEDbq+2FzyGLlKk4eo+kqHdRzcmukA9ru9agzA/Qwzb94346MMKGWRrJsFTxkQlruBR7KP0akBiEqosIaklN6Px9gNmWsMHIdmL6CIQQ415AwdW47JqpFtPtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c/6a2QMh; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712358109; x=1743894109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MSGQ6SrB+9md96cWcpxzV78UODUiAf/XfmVBiplB5ZM=;
  b=c/6a2QMhvHLHw6F1Jb/RR5ywQM/LZipwfFpQIWyBAegWRjXpenCevJ6D
   CLLukTNqfkPMvzVu9TxPYbwz940m/KrtnxhgDlc9Qd577fXrqZeGQcFfk
   7Y2ZBjxuZ/eLTZSAagx8a26oAzOTZJBgl1yx/b2wlsZOZs7PUfESP77cX
   U=;
X-IronPort-AV: E=Sophos;i="6.07,182,1708387200"; 
   d="scan'208";a="392972921"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 23:01:46 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:16661]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.13:2525] with esmtp (Farcaster)
 id af5c5586-db44-40f1-bb59-23e4ef79e78d; Fri, 5 Apr 2024 23:01:45 +0000 (UTC)
X-Farcaster-Flow-ID: af5c5586-db44-40f1-bb59-23e4ef79e78d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 23:01:40 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 23:01:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <kuniyu@amazon.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2 net] af_unix: Clear stale u->oob_skb.
Date: Fri, 5 Apr 2024 16:01:29 -0700
Message-ID: <20240405230129.7543-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ae5def68-6cc0-4cfe-a031-fefb103e854c@oracle.com>
References: <ae5def68-6cc0-4cfe-a031-fefb103e854c@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Fri, 5 Apr 2024 15:43:26 -0700
[...]
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 5b41e2321209..d032eb5fa6df 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2665,7 +2665,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
> >  				}
> >  			} else if (!(flags & MSG_PEEK)) {
> >  				skb_unlink(skb, &sk->sk_receive_queue);
> > -				consume_skb(skb);
> > +				WRITE_ONCE(u->oob_skb, NULL);
> > +				if (!WARN_ON_ONCE(skb_unref(skb)))
> > +					kfree_skb(skb);
> >  				skb = skb_peek(&sk->sk_receive_queue);
> >  			}
> >  		}
> 
> Isn't  consume_skb doing the same thing() ? .

Only if you disable CONFIG_TRACEPOINTS, otherwise each function
uses different tracepoints, trace_consume_skb() vs trace_kfree_skb().

Here, we clearly drop the skb that's not received by user, so
kfree_skb() should be used.


> The only action needed is to clear out u->oob_skb -- No?

Also, queue_oob() now calls skb_get() and holds another refcnt,
so skb_unref() is needed.

BTW, do you know if MSG_OOB is actually used in production ?
I don't know any real user other than syzbot.

P.S.
Please send mail in plain text format as mailing list drops HTML.

