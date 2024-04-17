Return-Path: <netdev+bounces-88593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AE8A7D19
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 09:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03EBA2812BB
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 07:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D66A353;
	Wed, 17 Apr 2024 07:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4QtSR8GK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BDF516
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339234; cv=none; b=Kfd5W6rWEO2CmnYogcRLnwAOivY71+MRVMivfWzu/Pn7ofW+oY86juc2u2SfdwKuuc4VlqRPnwFThKxCII9k5c45Ojvl+6FJWwi7R9/7NpBE/LRXUCtQieGWCm7kWcFM2qnmzzblVat71+XU3CG6B0WQJA5O6WXgj10Z0t+at60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339234; c=relaxed/simple;
	bh=rIoHtUlnVwzuqfRAbClEqmJGrmsDqPNL1WtSRcZ8vso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPHVPRm6fcfTZjmVCKaMCxculgVHX4nxRYTET4NLZjBEb4I5uDpo7SaUHzoBa3MhIUbxccpUYuuH7nH1X5vPHJC5T8wNgvDgzQ8BcmBrQln/Zr2bLVdVm/3gMMS5djwG0Th2lQVOnc1dIZaKYMVnA699+9gq1hbiafzc5A0SUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4QtSR8GK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e2e851794so7430a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713339231; x=1713944031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp1wJFOfrxujFhElI7d0yYI8bxHL0Jh11q8UFVUWgCk=;
        b=4QtSR8GKgym4V73u9DqCOayH9dzVF0Mv7ctx4U7du9eXYcekEIpAxD8jfvxXLHa9fh
         PgbT+n5whKTLyxtVNiWe3e4+r0FcjyZnd9K/VSh7v20OWJPMmPHXz0oCv1s3xvDYrNl8
         vGoQFH+2gIwLECwDuc6pbPWmaj6+BUG7JARZiP2lnRFvPTcPeXYjRg6YLMGETaLTtcpI
         +L131/B/bMZr1cqKicTfFJdcyNqsj8Umg0FRhO+SPumsnH2K7/8REe1Sk6UqmvqIM7gt
         b0lEtHk4mk234v4BRDusIi9Vy05krCOGwCuGyIruZ1D0WA05DZopk6vROpgwKd4fTgbF
         QNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713339231; x=1713944031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp1wJFOfrxujFhElI7d0yYI8bxHL0Jh11q8UFVUWgCk=;
        b=ADyhlAyV4tnRlx0/bVcQS8mMfXYpA0SbdmSpZtXovcSjLWM3HY0l6LAYYwKZ+afe26
         E9oUNg+4Gijbhzm+l4ngzps+P3YvcplqbQj/XZN5XV2Ast3eQ0PKRiLA8IDZKUc3Maf4
         /YJueGE9DE2F6XZ6qgpEXOKTwFcQj0z6q1nhqtwUnBlw92f7kiT40irezDpuE424mGSz
         64ZIuvj9LaT0XyYTkM+XR8OJ4/6YTOyo8w5abo8cavMWHyUCVaHOSDNB6s5nIrjysffr
         MfMtHzTLoXDMabS8M/Hr55Os4tyEODx4tnTu/AWmWBTYP6q3G/pV2wQcGZInk8mnzk78
         Wwng==
X-Forwarded-Encrypted: i=1; AJvYcCXPw1/H2jfoxJVLlV9BthQL4Q6NOjrHo8ywDuluad6N+vy2CFLdn8IwS0A8TPSq2LxEFsxWlLUrM77Yooo8QUSdRKP1PAev
X-Gm-Message-State: AOJu0YzCZb1E6oiWE8l8qJC7/w8RPInRQbDu2HXk6+SerGZc3jD3xAtL
	WO4513m+8K5Bc/aAhmEgIG8kvyc9JWVoV7NEhXd2/bkoGNuMigEQAA9EeihuR44o93W1oa8XkIa
	xJdl4Rn+th47rk9WCvxJk7B0QTMbm1EupJYd7
X-Google-Smtp-Source: AGHT+IHnz9BAxSs/rKoQp/Q1NGk+bEVD0x8Wx1A67xUAgpw5fnKFCISqyTbJmoJsmO57MJuwRBNpxxB24ELZpiA5JJk=
X-Received: by 2002:aa7:c414:0:b0:570:2ec6:56b5 with SMTP id
 j20-20020aa7c414000000b005702ec656b5mr139975edq.4.1713339230776; Wed, 17 Apr
 2024 00:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
 <20240117231646.22853-1-dipiets@amazon.com> <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
 <1195cf45-9c73-3450-36de-df54224135b6@amazon.com> <82bba704bf0019cc551310c563623092bf01ef8d.camel@redhat.com>
 <41792c55-6018-f331-315e-912438812df7@amazon.com>
In-Reply-To: <41792c55-6018-f331-315e-912438812df7@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 09:33:37 +0200
Message-ID: <CANn89iK69pB9y5eZTNjV6rH-2y3B2iAT2dnu13WfUPyPTBkTkw@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: Add memory barrier to tcp_push()
To: Geoff Blake <blakgeof@amazon.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Salvatore Dipietro <dipiets@amazon.com>, alisaidi@amazon.com, 
	benh@amazon.com, davem@davemloft.net, dipietro.salvatore@gmail.com, 
	dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 8:30=E2=80=AFPM Geoff Blake <blakgeof@amazon.com> w=
rote:
>
>
>
> On Thu, 18 Jan 2024, Paolo Abeni wrote:
>
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you can confirm the sender and know=
 the content is safe.
> >
> >
> >
> > On Thu, 2024-01-18 at 11:46 -0600, Geoff Blake wrote:
> > >
> > > On Thu, 18 Jan 2024, Paolo Abeni wrote:
> > >
> > > > CAUTION: This email originated from outside of the organization. Do=
 not click links or open attachments unless you can confirm the sender and =
know the content is safe.
> > > >
> > > >
> > > >
> > > > On Wed, 2024-01-17 at 15:16 -0800, Salvatore Dipietro wrote:
> > > > > On CPUs with weak memory models, reads and updates performed by t=
cp_push to the
> > > > > sk variables can get reordered leaving the socket throttled when =
it should not.
> > > > > The tasklet running tcp_wfree() may also not observe the memory u=
pdates in time
> > > > > and will skip flushing any packets throttled by tcp_push(), delay=
ing the sending.
> > > > > This can pathologically cause 40ms extra latency due to bad inter=
actions with
> > > > > delayed acks.
> > > > >
> > > > > Adding a memory barrier in tcp_push before the sk_wmem_alloc read=
 removes the
> > > > > bug, similarly to the previous commit bf06200e732d ("tcp: tsq: fi=
x nonagle
> > > > > handling"). smp_mb__after_atomic() is used to not incur in unnece=
ssary overhead
> > > > > on x86 since not affected.
> > > > >
> > > > > Patch has been tested using an AWS c7g.2xlarge instance with Ubun=
tu 22.04 and
> > > > > Apache Tomcat 9.0.83 running the basic servlet below:
> > > > >
> > > > > import java.io.IOException;
> > > > > import java.io.OutputStreamWriter;
> > > > > import java.io.PrintWriter;
> > > > > import javax.servlet.ServletException;
> > > > > import javax.servlet.http.HttpServlet;
> > > > > import javax.servlet.http.HttpServletRequest;
> > > > > import javax.servlet.http.HttpServletResponse;
> > > > >
> > > > > public class HelloWorldServlet extends HttpServlet {
> > > > >     @Override
> > > > >     protected void doGet(HttpServletRequest request, HttpServletR=
esponse response)
> > > > >       throws ServletException, IOException {
> > > > >         response.setContentType("text/html;charset=3Dutf-8");
> > > > >         OutputStreamWriter osw =3D new OutputStreamWriter(respons=
e.getOutputStream(),"UTF-8");
> > > > >         String s =3D "a".repeat(3096);
> > > > >         osw.write(s,0,s.length());
> > > > >         osw.flush();
> > > > >     }
> > > > > }
> > > > >
> > > > > Load was applied using wrk2 (https://github.com/kinvolk/wrk2) fro=
m an AWS
> > > > > c6i.8xlarge instance. Before the patch an additional 40ms latency=
 from P99.99+
> > > > > values is observed while, with the patch, the extra latency disap=
pears.
> > > > >
> > > > > # No patch and tcp_autocorking=3D1
> > > > > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:80=
80/hello/hello
> > > > >   ...
> > > > >  50.000%    0.91ms
> > > > >  75.000%    1.13ms
> > > > >  90.000%    1.46ms
> > > > >  99.000%    1.74ms
> > > > >  99.900%    1.89ms
> > > > >  99.990%   41.95ms  <<< 40+ ms extra latency
> > > > >  99.999%   48.32ms
> > > > > 100.000%   48.96ms
> > > > >
> > > > > # With patch and tcp_autocorking=3D1
> > > > > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:80=
80/hello/hello
> > > > >   ...
> > > > >  50.000%    0.90ms
> > > > >  75.000%    1.13ms
> > > > >  90.000%    1.45ms
> > > > >  99.000%    1.72ms
> > > > >  99.900%    1.83ms
> > > > >  99.990%    2.11ms  <<< no 40+ ms extra latency
> > > > >  99.999%    2.53ms
> > > > > 100.000%    2.62ms
> > > > >
> > > > > Patch has been also tested on x86 (m7i.2xlarge instance) which it=
 is not
> > > > > affected by this issue and the patch doesn't introduce any additi=
onal
> > > > > delay.
> > > > >
> > > > > Fixes: a181ceb501b3 ("tcp: autocork should not hold first packet =
in write
> > > > > queue")
> > > >
> > > > Please read carefully the process documentation under
> > > > Documentation/process/ and specifically the netdev specific bits:
> > > >
> > > > no resubmissions within the 24h grace period.
> > > >
> > > > Please double-check your patch with checkpatch for formal errors: t=
he
> > > > fixes tag must not be split across multiple lines.
> > > >
> > > > And please do not sent new version in reply to a previous one: it w=
ill
> > > > confuse the bot.
> > > >
> > > > > Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> > > > > ---
> > > > >  net/ipv4/tcp.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > > > index ff6838ca2e58..ab9e3922393c 100644
> > > > > --- a/net/ipv4/tcp.c
> > > > > +++ b/net/ipv4/tcp.c
> > > > > @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int=
 mss_now,
> > > > >               /* It is possible TX completion already happened
> > > > >                * before we set TSQ_THROTTLED.
> > > > >                */
> > > > > +             smp_mb__after_atomic();
> > > >
> > > > Out of sheer ignorance I'm wondering if moving such barrier inside =
the
> > > > above 'if' just after 'set_bit' would suffice?
> > >
> > > According to the herd7 modeling tool, the answer is no for weak memor=
y
> > > models.  If we put the smp_mb inside the if, it allows the machine to
> > > reorder the two reads to sk_wmem_alloc and we can get to the bad stat=
e
> > > this patch is fixing.  Placing it outside the if ensures
> > > the ordering between those two reads as well as ordering the write to=
 the
> > > flags variable.
> >
> > For the records, I asked because reading the documentation  I assumed
> > that smp_mb__after_atomic() enforces the ordering WRT the previous RMW
> > operation (in this case 'set_bit'). Is this a wrong interpretation?
> >
> > Now I wonder if the patch is enough. Specifically, would it work
> > correctly when the TSQ_THROTTLED bit is already set and there is no RMW
> > operation in between the two refcount_read()?
> >
>
> I fat fingered the model in the previous reply, sorry for the confusion.
> It appears we can put the barrier inside the if check and be fine.  For
> the x86 case reads won't pass other reads according to my understanding
> of their memory model which makes this work as is without the barrier to
> begin with for when TSQ_THROTTLED is already
> set or not set.
>
> For arm64, we need to generate a dmb.ish instruction after the store.  Ca=
n
> run a test to make sure the model is correct and can move the barrier
> to inside the if after the atomic bitset.

I read again this code (in 'fixed' kernels) and could not convince
myself it is bug free/.

Without RMW with return value or barriers, this all boils to bare reads,
and all these reads could be ordered differently.

I am thinking of making the following change to be on the cautious side.

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f23b97777ea5e93fc860d3f225e464f9376cfe09..2e768aab39128cc8aebc2dbd654=
06f3bccf449f7
100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -722,12 +722,9 @@ void tcp_push(struct sock *sk, int flags, int mss_now,

        if (tcp_should_autocork(sk, skb, size_goal)) {

-               /* avoid atomic op if TSQ_THROTTLED bit is already set */
-               if (!test_bit(TSQ_THROTTLED, &sk->sk_tsq_flags)) {
+               if (!test_and_set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags))
                        NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAUTOCORKIN=
G);
-                       set_bit(TSQ_THROTTLED, &sk->sk_tsq_flags);
-                       smp_mb__after_atomic();
-               }
+
                /* It is possible TX completion already happened
                 * before we set TSQ_THROTTLED.
                 */

