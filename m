Return-Path: <netdev+bounces-57537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C1781354B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49071F21858
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0BF5D90F;
	Thu, 14 Dec 2023 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JDwFefI3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C67E8
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702569176; x=1734105176;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject;
  bh=cdf8DTGn0madXkupaFpmveiXLIUFsPGFH1v3+vgl57o=;
  b=JDwFefI3CtDffgzoC5oP9TpWz9Ilwn29FcvLP0ZZOkxkonLCze6KukVN
   BeccxHmNVcx7+B4t+04aOYhOCPyvez5PBGEwxYdjgxhHsPmq0gEuU0twm
   xdmi3XVIBSywu54hrUby0RsiojpOwzL9P3sjn74Qt6PPR6AZmAMuH8zIl
   o=;
X-IronPort-AV: E=Sophos;i="6.04,275,1695686400"; 
   d="scan'208";a="259755918"
Subject: RE: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is
 set
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 15:52:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 65719895AA;
	Thu, 14 Dec 2023 15:52:55 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:65105]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.109:2525] with esmtp (Farcaster)
 id cb21cb25-0d9e-40aa-a1cd-d980d5a785b9; Thu, 14 Dec 2023 15:52:54 +0000 (UTC)
X-Farcaster-Flow-ID: cb21cb25-0d9e-40aa-a1cd-d980d5a785b9
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:52:46 +0000
Received: from edge-bw-112.e-lhr50.amazon.com (10.106.178.9) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 15:52:45 +0000
Date: Thu, 14 Dec 2023 09:52:21 -0600
From: Geoff Blake <blakgeof@amazon.com>
To: Eric Dumazet <edumazet@google.com>
CC: Salvatore Dipietro <dipiets@amazon.com>, <alisaidi@amazon.com>,
	<benh@amazon.com>, <davem@davemloft.net>, <dipietro.salvatore@gmail.com>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
In-Reply-To: <CANn89i+xtQe9d6YJH7useqY+v31kpHkeg-MxCqtWD90nLrYNXQ@mail.gmail.com>
Message-ID: <3baf5407-34b1-d616-9552-19696933e0c2@amazon.com>
References: <CANn89i+98ifRj9SJQbK+QJrCde2UJvWr1h31gAZSuxt4i_U=iw@mail.gmail.com> <20231213213006.89142-1-dipiets@amazon.com> <CANn89i+xtQe9d6YJH7useqY+v31kpHkeg-MxCqtWD90nLrYNXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-940578139-1702569166=:82855"
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
Precedence: Bulk

--0-940578139-1702569166=:82855
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT

Thanks for helping dig in here Eric, but what is supposed to happen on TX 
completion? We're unfamiliar with TCP small queues beside finding your old 
LKML listing that states a tasklet is supposed to run if there is pending 
data.  So need a bit more guidance if you could.

I think its supposed to call tcp_free() when the skb is destructed and 
that invokes the tasklet?  There is also sock_wfree(), it does not appear 
to have the linkage to the tasklet by design.

We did attach probes at one point to look at whether there was a chance an 
interrupt went missing (but don't have them on-hand anymore), but we 
always saw the TX completion happen. When the 40ms latency happened 
we'd see that the completion had happened just after the other packet decided to 
be corked.  But it certainly doesn't hurt to double check.  

- Geoff Blake

On Thu, 14 Dec 2023, Eric Dumazet wrote:

> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, Dec 13, 2023 at 10:30 PM Salvatore Dipietro <dipiets@amazon.com> wrote:
> >
> > > It looks like the above disables autocorking even after the userspace
> > > sets TCP_CORK. Am I reading it correctly? Is that expected?
> >
> > I have tested a new version of the patch which can target only TCP_NODELAY.
> > Results using previous benchmark are identical. I will submit it in a new
> > patch version.
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -716,7 +716,8 @@
> >
> >         tcp_mark_urg(tp, flags);
> >
> > -       if (tcp_should_autocork(sk, skb, size_goal)) {
> > +       if (!(nonagle & TCP_NAGLE_OFF) &&
> > +           tcp_should_autocork(sk, skb, size_goal)) {
> >
> >                 /* avoid atomic op if TSQ_THROTTLED bit is already set */
> >                 if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
> >
> >
> >
> > > Also I wonder about these 40ms delays, TCP small queue handler should
> > > kick when the prior skb is TX completed.
> > >
> > > It seems the issue is on the driver side ?
> > >
> > > Salvatore, which driver are you using ?
> >
> > I am using ENA driver.
> >
> > Eric can you please clarify where do you think the problem is?
> >
> 
> Following bpftrace program could double check if ena driver is
> possibly holding TCP skbs too long:
> 
> bpftrace -e 'k:dev_hard_start_xmit {
>  $skb = (struct sk_buff *)arg0;
>  if ($skb->fclone == 2) {
>   @start[$skb] = nsecs;
>  }
> }
> k:__kfree_skb {
>  $skb = (struct sk_buff *)arg0;
>  if ($skb->fclone == 2 && @start[$skb]) {
>   @tx_compl_usecs = hist((nsecs - @start[$skb])/1000);
>   delete(@start[$skb]);
> }
> } END { clear(@start); }'
> 
> iroa21:/home/edumazet# ./trace-tx-completion.sh
> Attaching 3 probes...
> ^C
> 
> 
> @tx_compl_usecs:
> [2, 4)                13 |                                                    |
> [4, 8)               182 |                                                    |
> [8, 16)          2379007 |@@@@@@@@@@@@@@@                                     |
> [16, 32)         7865369 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32, 64)         6040939 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             |
> [64, 128)         199255 |@                                                   |
> [128, 256)          9235 |                                                    |
> [256, 512)            89 |                                                    |
> [512, 1K)             37 |                                                    |
> [1K, 2K)              19 |                                                    |
> [2K, 4K)              56 |                                                    |
> 
--0-940578139-1702569166=:82855--

