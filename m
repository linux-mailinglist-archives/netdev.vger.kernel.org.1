Return-Path: <netdev+bounces-64278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68529831FBF
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA011C22B21
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D952E400;
	Thu, 18 Jan 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uPbGRJma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE932D047
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606236; cv=none; b=jf4bFy6nIlZ0W/Nu7CkjwGo+PaF2PhRtv/WfYq/dPX+7dqmCcVJHIapXdc8Co/X/jOKarjie/XFBaLur6j4gJXnO5L+KTJtTZmf+eDvnxc+Lo4d29D9YQh9S9LJRcK4giqrgdvfqfz3iYbW4mhmQgTNAzaccpkCVlXa2k3KRyWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606236; c=relaxed/simple;
	bh=/1EbAJakJnqbYZ0DLVndwfOnZd8DzUnFIfcVb7xatqU=;
	h=Subject:Date:From:To:CC:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DzOf4aQFmRqRvDHpRTxBm3KqzZF5JpjtfWfEOUkgMT7hFez9eN+/Cv8RCFwfW7qJOnQQtFn2JRqIX9aXXQFstkiq8wE+aXHnp+PNKnHy/bXEGRrSdueZo2RKTCEDjBA2pzWLFMQ55xwfek707zQxGafNxy/NH0OKjCkW55P6xSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uPbGRJma; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705606236; x=1737142236;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject;
  bh=kJpsFQ2BeUyUy4bTYU8CCiL04Hk+F/NpHSvgW4pG2HU=;
  b=uPbGRJmaQS9/YOieOWtZV/HuC5PMDO5cRvhYAm2KvzzjQahX2d/7c+nA
   9Mvac6BDG4qs4aMNbVrqBaugMuayBL6h1xdrslqgGbfzLfWgq0kE2bu/F
   QCHgv7njoXrgWTcnwQY7e4o4KTGlxosnXHui8swKxBR+C/p77AfSB/eQL
   M=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="266994477"
Subject: RE: [PATCH v3] tcp: Add memory barrier to tcp_push()
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 19:30:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id 580558482E;
	Thu, 18 Jan 2024 19:30:32 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:51400]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.5:2525] with esmtp (Farcaster)
 id 230e6ed1-e575-4341-8de6-c8de50997b47; Thu, 18 Jan 2024 19:30:31 +0000 (UTC)
X-Farcaster-Flow-ID: 230e6ed1-e575-4341-8de6-c8de50997b47
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:30:31 +0000
Received: from lhr51-en-hct-f1c0-r1-vl--298.amazon.com (10.252.141.22) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 19:30:29 +0000
Date: Thu, 18 Jan 2024 13:30:21 -0600
From: Geoff Blake <blakgeof@amazon.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Salvatore Dipietro <dipiets@amazon.com>, <edumazet@google.com>,
	<alisaidi@amazon.com>, <benh@amazon.com>, <davem@davemloft.net>,
	<dipietro.salvatore@gmail.com>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>
In-Reply-To: <82bba704bf0019cc551310c563623092bf01ef8d.camel@redhat.com>
Message-ID: <41792c55-6018-f331-315e-912438812df7@amazon.com>
References: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>   <20240117231646.22853-1-dipiets@amazon.com>  <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>  <1195cf45-9c73-3450-36de-df54224135b6@amazon.com>
 <82bba704bf0019cc551310c563623092bf01ef8d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
Precedence: Bulk



On Thu, 18 Jan 2024, Paolo Abeni wrote:

> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Thu, 2024-01-18 at 11:46 -0600, Geoff Blake wrote:
> >
> > On Thu, 18 Jan 2024, Paolo Abeni wrote:
> >
> > > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > >
> > >
> > >
> > > On Wed, 2024-01-17 at 15:16 -0800, Salvatore Dipietro wrote:
> > > > On CPUs with weak memory models, reads and updates performed by tcp_push to the
> > > > sk variables can get reordered leaving the socket throttled when it should not.
> > > > The tasklet running tcp_wfree() may also not observe the memory updates in time
> > > > and will skip flushing any packets throttled by tcp_push(), delaying the sending.
> > > > This can pathologically cause 40ms extra latency due to bad interactions with
> > > > delayed acks.
> > > >
> > > > Adding a memory barrier in tcp_push before the sk_wmem_alloc read removes the
> > > > bug, similarly to the previous commit bf06200e732d ("tcp: tsq: fix nonagle
> > > > handling"). smp_mb__after_atomic() is used to not incur in unnecessary overhead
> > > > on x86 since not affected.
> > > >
> > > > Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04 and
> > > > Apache Tomcat 9.0.83 running the basic servlet below:
> > > >
> > > > import java.io.IOException;
> > > > import java.io.OutputStreamWriter;
> > > > import java.io.PrintWriter;
> > > > import javax.servlet.ServletException;
> > > > import javax.servlet.http.HttpServlet;
> > > > import javax.servlet.http.HttpServletRequest;
> > > > import javax.servlet.http.HttpServletResponse;
> > > >
> > > > public class HelloWorldServlet extends HttpServlet {
> > > >     @Override
> > > >     protected void doGet(HttpServletRequest request, HttpServletResponse response)
> > > >       throws ServletException, IOException {
> > > >         response.setContentType("text/html;charset=utf-8");
> > > >         OutputStreamWriter osw = new OutputStreamWriter(response.getOutputStream(),"UTF-8");
> > > >         String s = "a".repeat(3096);
> > > >         osw.write(s,0,s.length());
> > > >         osw.flush();
> > > >     }
> > > > }
> > > >
> > > > Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an AWS
> > > > c6i.8xlarge instance. Before the patch an additional 40ms latency from P99.99+
> > > > values is observed while, with the patch, the extra latency disappears.
> > > >
> > > > # No patch and tcp_autocorking=1
> > > > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello/hello
> > > >   ...
> > > >  50.000%    0.91ms
> > > >  75.000%    1.13ms
> > > >  90.000%    1.46ms
> > > >  99.000%    1.74ms
> > > >  99.900%    1.89ms
> > > >  99.990%   41.95ms  <<< 40+ ms extra latency
> > > >  99.999%   48.32ms
> > > > 100.000%   48.96ms
> > > >
> > > > # With patch and tcp_autocorking=1
> > > > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello/hello
> > > >   ...
> > > >  50.000%    0.90ms
> > > >  75.000%    1.13ms
> > > >  90.000%    1.45ms
> > > >  99.000%    1.72ms
> > > >  99.900%    1.83ms
> > > >  99.990%    2.11ms  <<< no 40+ ms extra latency
> > > >  99.999%    2.53ms
> > > > 100.000%    2.62ms
> > > >
> > > > Patch has been also tested on x86 (m7i.2xlarge instance) which it is not
> > > > affected by this issue and the patch doesn't introduce any additional
> > > > delay.
> > > >
> > > > Fixes: a181ceb501b3 ("tcp: autocork should not hold first packet in write
> > > > queue")
> > >
> > > Please read carefully the process documentation under
> > > Documentation/process/ and specifically the netdev specific bits:
> > >
> > > no resubmissions within the 24h grace period.
> > >
> > > Please double-check your patch with checkpatch for formal errors: the
> > > fixes tag must not be split across multiple lines.
> > >
> > > And please do not sent new version in reply to a previous one: it will
> > > confuse the bot.
> > >
> > > > Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> > > > ---
> > > >  net/ipv4/tcp.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > index ff6838ca2e58..ab9e3922393c 100644
> > > > --- a/net/ipv4/tcp.c
> > > > +++ b/net/ipv4/tcp.c
> > > > @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
> > > >               /* It is possible TX completion already happened
> > > >                * before we set TSQ_THROTTLED.
> > > >                */
> > > > +             smp_mb__after_atomic();
> > >
> > > Out of sheer ignorance I'm wondering if moving such barrier inside the
> > > above 'if' just after 'set_bit' would suffice?
> >
> > According to the herd7 modeling tool, the answer is no for weak memory
> > models.  If we put the smp_mb inside the if, it allows the machine to
> > reorder the two reads to sk_wmem_alloc and we can get to the bad state
> > this patch is fixing.  Placing it outside the if ensures
> > the ordering between those two reads as well as ordering the write to the
> > flags variable.
> 
> For the records, I asked because reading the documentation  I assumed
> that smp_mb__after_atomic() enforces the ordering WRT the previous RMW
> operation (in this case 'set_bit'). Is this a wrong interpretation?
> 
> Now I wonder if the patch is enough. Specifically, would it work
> correctly when the TSQ_THROTTLED bit is already set and there is no RMW
> operation in between the two refcount_read()?
> 

I fat fingered the model in the previous reply, sorry for the confusion.  
It appears we can put the barrier inside the if check and be fine.  For 
the x86 case reads won't pass other reads according to my understanding 
of their memory model which makes this work as is without the barrier to
begin with for when TSQ_THROTTLED is already 
set or not set.
  
For arm64, we need to generate a dmb.ish instruction after the store.  Can 
run a test to make sure the model is correct and can move the barrier 
to inside the if after the atomic bitset.

Thanks,
Geoff

