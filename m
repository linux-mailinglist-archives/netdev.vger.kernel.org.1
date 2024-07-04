Return-Path: <netdev+bounces-109305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A93927CDF
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872452820BB
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07996F09C;
	Thu,  4 Jul 2024 18:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bKvUKcjk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A862171
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116731; cv=none; b=UP4dQSOgjtj2XPowdVLAhYqS04St05kNxvQazrhNK5wZGry6QlX70G3bEzK2DkpzynGeECNNxg9BKDuadLP9Oioy1eVtBrTntgYHxrjzYTmaQBwvue/timf9My5T0OfiQbndBWOfBnHPEMj2a5p4w/mGMTuRmzXe4X+ZhaGbW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116731; c=relaxed/simple;
	bh=oq/bjeBplEbisLQCZYUSUGyRnC67n1GU+YRliqgIluQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SFIziajI4DfBflj4LQjSsVGcrlBh22Zjm4fLSc39Z1BTsEUckkIRpghkGKdborRwLdfitTSjPd1ogNgzvnt9Fk1TwA3dmeUcBSCkQ6bPFOP7SqOG0A8brNMWCwVggdh7Tr6y/KU35IYnC5qaD9z1jFH3cHE5A3V9r3BcknYpw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bKvUKcjk; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720116731; x=1751652731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=US/d/aEoh/k8vL8tVAYsfMVwGWW1HtPM0p+o8ZiQm5Y=;
  b=bKvUKcjkfpcFz6XdYzg8aKU8Mi10ycP0P3/s6UtYVtgxIkf6jB5mpQhG
   gorecC/J7dHHQYX1dsLKJ4bHw2hlZHqh1oOl3LeFYirob+yOXrVe2rqIT
   Eu0jibg76fkhMCoW82/+O1sFjg9kZDL7FUcJEGtF4ZpvWmcTGzPprFbzL
   4=;
X-IronPort-AV: E=Sophos;i="6.09,183,1716249600"; 
   d="scan'208";a="738073152"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 18:12:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:34452]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.48:2525] with esmtp (Farcaster)
 id 1dbe3e34-cbd9-40ab-9a99-aa6729c71f47; Thu, 4 Jul 2024 18:12:04 +0000 (UTC)
X-Farcaster-Flow-ID: 1dbe3e34-cbd9-40ab-9a99-aa6729c71f47
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 18:12:04 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 4 Jul 2024 18:12:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <0x7f454c46@gmail.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for TCP AO.
Date: Thu, 4 Jul 2024 11:11:54 -0700
Message-ID: <20240704181154.5866-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <343d737fde9caa4aba549ed5eaa59c05965da927.camel@redhat.com>
References: <343d737fde9caa4aba549ed5eaa59c05965da927.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 04 Jul 2024 12:05:42 +0200
> On Tue, 2024-07-02 at 20:35 -0700, Kuniyuki Iwashima wrote:
> > When we process segments with TCP AO, we don't check it in
> > tcp_parse_options().  Thus, opt_rx->saw_unknown is set to 1,
> > which unconditionally triggers the BPF TCP option parser.
> > 
> > Let's avoid the unnecessary BPF invocation.
> > 
> > Fixes: 0a3a809089eb ("net/tcp: Verify inbound TCP-AO signed segments")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> >  net/ipv4/tcp_input.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index e67cbeeeb95b..77294fd5fd3e 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -4223,6 +4223,13 @@ void tcp_parse_options(const struct net *net,
> >  				 * checked (see tcp_v{4,6}_rcv()).
> >  				 */
> >  				break;
> > +#endif
> > +#ifdef CONFIG_TCP_AO
> > +			case TCPOPT_AO:
> > +				/* TCP AO has already been checked
> > +				 * (see tcp_inbound_ao_hash()).
> > +				 */
> > +				break;
> >  #endif
> >  			case TCPOPT_FASTOPEN:
> >  				tcp_parse_fastopen_option(
> 
> [not strictly related to this patch] possibly even MPTCP could benefit
> from a similar change, but I'm unsure if we want to add even more cases
> to this statement.

Exactly, it seem no one has tried to inject/parse a new option with MPTCP.

