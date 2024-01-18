Return-Path: <netdev+bounces-64253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E011D831EB6
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 18:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A47528581C
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206C52D052;
	Thu, 18 Jan 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vVO1lHil"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0802C848
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600000; cv=none; b=VHWd/+lI8KIgTWv/LfJNhPwrkKI4sQVft/oOAyS0IC4bR7EEK21nwFu9PDyfGnn/UEheMBcZINiw1pzoWLnNeErvoxW7Ub/SzeK15tIpXeJoHcofTOaXfba2rwFPiGX+p9DtRhan8S0KBQ7h/YIdKQ5UFjLpohQJXGfARpeoJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600000; c=relaxed/simple;
	bh=TuSzzUMGtcolMkPRnJNo7RIo+b6y/9t6KbjGyRRzc90=;
	h=Subject:Date:From:To:CC:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u9XpXJBUszlHCIcu9l5YlZD9uEFqlMq0o4l58Bk/xmIwoUIHanhdUuYexPCgLBC0GHVU0+ZmrsOqFMAb2IMkV3xxr0ImzgBkb4RMzrxL8A2PCPD+LQVdMEI7CZoZI1hIb/py8LAsaaxUskYx4+sG++vf994hdeUeSR2R6Cc2fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vVO1lHil; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705599998; x=1737135998;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject;
  bh=AcbDdkJsAyI8g8bG3lHG/IWqtnWkjJBVY0ODfwOm4Ao=;
  b=vVO1lHilrjjJqpRJamu6TDu+Ndo1f/b7CswYkgu37WPuJX9zM1PVrGPD
   tOLKFiorzcw83meIHgdcapNcwPASBhEwCbFgRvGla+/xY6RRbOnJh5EhP
   38Qek6Gw52wNNZA8mXHmm4iP9y9k0MRZopVyCFVccCzI7oVAtlng7XgiZ
   0=;
X-IronPort-AV: E=Sophos;i="6.05,203,1701129600"; 
   d="scan'208";a="59302448"
Subject: RE: [PATCH v3] tcp: Add memory barrier to tcp_push()
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 17:46:37 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id 806FEA0137;
	Thu, 18 Jan 2024 17:46:37 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30697]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id 1f451131-02fe-4d8d-9706-a53d82aac51c; Thu, 18 Jan 2024 17:46:37 +0000 (UTC)
X-Farcaster-Flow-ID: 1f451131-02fe-4d8d-9706-a53d82aac51c
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 17:46:37 +0000
Received: from lhr51-en-hct-f1c0-r1-vl--298.amazon.com (10.252.141.22) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jan 2024 17:46:35 +0000
Date: Thu, 18 Jan 2024 11:46:27 -0600
From: Geoff Blake <blakgeof@amazon.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Salvatore Dipietro <dipiets@amazon.com>, <edumazet@google.com>,
	<alisaidi@amazon.com>, <benh@amazon.com>, <davem@davemloft.net>,
	<dipietro.salvatore@gmail.com>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>
In-Reply-To: <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
Message-ID: <1195cf45-9c73-3450-36de-df54224135b6@amazon.com>
References: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>  <20240117231646.22853-1-dipiets@amazon.com> <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
Precedence: Bulk



On Thu, 18 Jan 2024, Paolo Abeni wrote:

> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On Wed, 2024-01-17 at 15:16 -0800, Salvatore Dipietro wrote:
> > On CPUs with weak memory models, reads and updates performed by tcp_push to the
> > sk variables can get reordered leaving the socket throttled when it should not.
> > The tasklet running tcp_wfree() may also not observe the memory updates in time
> > and will skip flushing any packets throttled by tcp_push(), delaying the sending.
> > This can pathologically cause 40ms extra latency due to bad interactions with
> > delayed acks.
> >
> > Adding a memory barrier in tcp_push before the sk_wmem_alloc read removes the
> > bug, similarly to the previous commit bf06200e732d ("tcp: tsq: fix nonagle
> > handling"). smp_mb__after_atomic() is used to not incur in unnecessary overhead
> > on x86 since not affected.
> >
> > Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04 and
> > Apache Tomcat 9.0.83 running the basic servlet below:
> >
> > import java.io.IOException;
> > import java.io.OutputStreamWriter;
> > import java.io.PrintWriter;
> > import javax.servlet.ServletException;
> > import javax.servlet.http.HttpServlet;
> > import javax.servlet.http.HttpServletRequest;
> > import javax.servlet.http.HttpServletResponse;
> >
> > public class HelloWorldServlet extends HttpServlet {
> >     @Override
> >     protected void doGet(HttpServletRequest request, HttpServletResponse response)
> >       throws ServletException, IOException {
> >         response.setContentType("text/html;charset=utf-8");
> >         OutputStreamWriter osw = new OutputStreamWriter(response.getOutputStream(),"UTF-8");
> >         String s = "a".repeat(3096);
> >         osw.write(s,0,s.length());
> >         osw.flush();
> >     }
> > }
> >
> > Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an AWS
> > c6i.8xlarge instance. Before the patch an additional 40ms latency from P99.99+
> > values is observed while, with the patch, the extra latency disappears.
> >
> > # No patch and tcp_autocorking=1
> > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello/hello
> >   ...
> >  50.000%    0.91ms
> >  75.000%    1.13ms
> >  90.000%    1.46ms
> >  99.000%    1.74ms
> >  99.900%    1.89ms
> >  99.990%   41.95ms  <<< 40+ ms extra latency
> >  99.999%   48.32ms
> > 100.000%   48.96ms
> >
> > # With patch and tcp_autocorking=1
> > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello/hello
> >   ...
> >  50.000%    0.90ms
> >  75.000%    1.13ms
> >  90.000%    1.45ms
> >  99.000%    1.72ms
> >  99.900%    1.83ms
> >  99.990%    2.11ms  <<< no 40+ ms extra latency
> >  99.999%    2.53ms
> > 100.000%    2.62ms
> >
> > Patch has been also tested on x86 (m7i.2xlarge instance) which it is not
> > affected by this issue and the patch doesn't introduce any additional
> > delay.
> >
> > Fixes: a181ceb501b3 ("tcp: autocork should not hold first packet in write
> > queue")
> 
> Please read carefully the process documentation under
> Documentation/process/ and specifically the netdev specific bits:
> 
> no resubmissions within the 24h grace period.
> 
> Please double-check your patch with checkpatch for formal errors: the
> fixes tag must not be split across multiple lines.
> 
> And please do not sent new version in reply to a previous one: it will
> confuse the bot.
> 
> > Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> > ---
> >  net/ipv4/tcp.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index ff6838ca2e58..ab9e3922393c 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
> >               /* It is possible TX completion already happened
> >                * before we set TSQ_THROTTLED.
> >                */
> > +             smp_mb__after_atomic();
> 
> Out of sheer ignorance I'm wondering if moving such barrier inside the
> above 'if' just after 'set_bit' would suffice?

According to the herd7 modeling tool, the answer is no for weak memory 
models.  If we put the smp_mb inside the if, it allows the machine to 
reorder the two reads to sk_wmem_alloc and we can get to the bad state 
this patch is fixing.  Placing it outside the if ensures 
the ordering between those two reads as well as ordering the write to the 
flags variable.



