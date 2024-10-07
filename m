Return-Path: <netdev+bounces-132911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F032993B70
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B5CBB20A1A
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC64518CBEC;
	Mon,  7 Oct 2024 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dSXvOwVO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA77318DF65
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345186; cv=none; b=mCDMECIPxpAEqmCUGxolCkvbamlRRhXwXr+yezkT4xL3kwCmxUETdR5BLzuEUtkRobD7vRCgk977i6jDnhG/jthpIedOprAqTVsaW2Gc60M4fe7PhzXXmNX7j4L1xdEoIUTZTqQGdqh1wv3KC8u+YcRx3Jlj9TtxdvqoLEFbbs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345186; c=relaxed/simple;
	bh=VCl7JuhCHxHOZ+i4Hzq+Hnbj/jOqSNfruBfSOqBtCFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0+B4GxyaMME2GMGsYOfSFM3AQc43q0Kb3O7cbAuzvdVRNW54noRg3L+kCC5G6a+LOIT4fGloks9xcFm1hQ3/492NLtvGpMVlLTnQcaf5E6BShGoiYlhzbEkAD2jEnpu6S7ZOOWfRwzTIwj939psZO4tMKCokEfh72NZwyu9uBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dSXvOwVO; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728345185; x=1759881185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=238ZUvSCN3gC+rsoZbIRxGfxraBoqOi2W47FBbIYySI=;
  b=dSXvOwVO+q0dk9YbvQE8rfQ1KeDgEkj6WS8eXxwcDEVs7OSpNM8HN4PS
   +qVdXvyd/V/PN+B5YCw71aMcc17vY7KZm7ND8oQKlvLdGIG+boT+cxj4r
   X0CDoQuan7/tK+fOOvjonvKKjfmbSB9fgWoShKQsVumNg0DTIUl171/uk
   4=;
X-IronPort-AV: E=Sophos;i="6.11,185,1725321600"; 
   d="scan'208";a="31366295"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 23:53:02 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:24180]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id fa961d58-4d84-454e-b1a0-4e0d26f4a8f0; Mon, 7 Oct 2024 23:53:02 +0000 (UTC)
X-Farcaster-Flow-ID: fa961d58-4d84-454e-b1a0-4e0d26f4a8f0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 7 Oct 2024 23:53:01 +0000
Received: from 88665a182662.ant.amazon.com (10.119.221.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 7 Oct 2024 23:52:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <martin.lau@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Mon, 7 Oct 2024 16:52:51 -0700
Message-ID: <20241007235251.84189-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241007162610.7d9482dc@kernel.org>
References: <20241007162610.7d9482dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 7 Oct 2024 16:26:10 -0700
> On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
> > Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> > 
> >   """
> >   We are seeing a use-after-free from a bpf prog attached to
> >   trace_tcp_retransmit_synack. The program passes the req->sk to the
> >   bpf_sk_storage_get_tracing kernel helper which does check for null
> >   before using it.
> >   """
> 
> I think this crashes a bunch of selftests, example:
> 
> https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-queue-sh/stderr

Oops, sorry, I copy-and-pasted __inet_csk_reqsk_queue_drop()
for different reqsk.  I'll squash the diff below.

---8<---
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 36f03d51356e..433c80dc57d5 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1188,7 +1190,7 @@ static void reqsk_timer_handler(struct timer_list *t)
 	}
 
 drop:
-	__inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
+	__inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
 	reqsk_put(req);
 }
 
---8<---

Thanks!

