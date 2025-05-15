Return-Path: <netdev+bounces-190838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5EAB90BF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6BA67B9038
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E411297A48;
	Thu, 15 May 2025 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="btcSmajs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E281F5827
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747340602; cv=none; b=SfdUavicCjfpkdAmPj0gU33hAI+g9dL8kiafQn+eYE8cChcmeXDaOqX9iAPXsz2Lrnn+9e/PBiigJDEVXN0bQM7x4SSwPeuMdOQmrTwoVrP/hBVXdyx8GW4LkcXPNJmwRH74OJVtOzaszRf0Q/XJgZnndjoSN2MQgOERHuqR9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747340602; c=relaxed/simple;
	bh=Tvl1iNUGoNbwalwLjgpcUBbpXAppxjHmnq/XKVQjV90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUqW47OQTTI5cikrCLgkeBUWfO4OL4keHs798xf1XAwr70gLd5vbMX+TRi8rCsV1R58S4q9zB5aXgvmPKpo8NHHhs3LnTd5QH9G1xkyRBAA0F0mE4LGA5meQK+rKRwQj1FjC2A9LTRAGeXZ5slbbz4drfVoEb+9JQJx1w3CddE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=btcSmajs; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747340600; x=1778876600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G7jgEodxGJ127OX2WRlI+Ltm9Hx+FvAecevXs1xAvFE=;
  b=btcSmajspS8NxjKKFr25+Ev/st2OQJiIX+R1NmFDyqAaqJnPK64h5PUR
   94gWwB3nI83qNgx4DGvFocmpHDaXNF5LSY/gp8To6H1GmGHHnfVTuJPYa
   zhp9y115LPjNHhr26l5YxQ8zpaqaQNuHg1au56H0vT8NBv+cKx+uiSIJh
   rvtNdxZENH99OeLJ1fJOY7ETRYt1qx6nZ2W7Ad54Up/tLSo/g9K6FOsiS
   G6P0Zr57Uqlzltj5KSVofNR2BPcn2spSs9wAD491ivc/4Z3Y71R3Kx6LM
   7PMIZgJQYwYGpwI4gLlON3p39Re7kHBGHICplz+xUiKl/quf9xPzv0MhF
   g==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="490455187"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 20:23:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:62048]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.83:2525] with esmtp (Farcaster)
 id 733e5be9-f112-4099-990e-845ffb5be8a2; Thu, 15 May 2025 20:23:15 +0000 (UTC)
X-Farcaster-Flow-ID: 733e5be9-f112-4099-990e-845ffb5be8a2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:23:15 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 20:23:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <willemdebruijn.kernel@gmail.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>
Subject: Re: [PATCH v3 net-next 1/9] af_unix: Factorise test_bit() for SOCK_PASSCRED and SOCK_PASSPIDFD.
Date: Thu, 15 May 2025 13:23:01 -0700
Message-ID: <20250515202304.82187-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <68262d4ab643_25ebe529488@willemb.c.googlers.com.notmuch>
References: <68262d4ab643_25ebe529488@willemb.c.googlers.com.notmuch>
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

From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 15 May 2025 14:07:06 -0400
> Kuniyuki Iwashima wrote:
> > Currently, the same checks for SOCK_PASSCRED and SOCK_PASSPIDFD
> > are scattered across many places.
> > 
> > Let's centralise the bit tests to make the following changes cleaner.
> > 
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/unix/af_unix.c | 37 +++++++++++++++----------------------
> >  1 file changed, 15 insertions(+), 22 deletions(-)
> > 
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 2ab20821d6bb..464e183ffdb8 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -765,6 +765,14 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
> >  	spin_unlock(&sk->sk_peer_lock);
> >  }
> >  
> > +static bool unix_may_passcred(const struct sock *sk)
> > +{
> > +	struct socket *sock = sk->sk_socket;
> 
> Also const?

yes, but this part is removed in patch 6, so I'd leave as is :)

