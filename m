Return-Path: <netdev+bounces-64352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40A832A8E
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 14:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928CDB20F93
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C742053;
	Fri, 19 Jan 2024 13:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxJgQ/2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998D537E1
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705671247; cv=none; b=DLLG0dBPfFA0BgOj18Vf01ZMEFaMk3KjRquK0AoOasZrzrI+PtiqhIQ5LfKDA3g+7mdyv0JqBqq/tMCso//h59hUF01FWzECMVevBuhXxweefmi7DfNgiPR8qJkPN8uPbW0G3lqGEZ+nQ4kgjXGiQJ5pI98wKHp+54L/bZ58Axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705671247; c=relaxed/simple;
	bh=ksnPJTIvOvMVPQatgivt8Iyc1UPfTaVji9JC6Tm12cY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0Fnp8ifmg2gAvjugTSJ7qWcnyf9lLnc7xXh0i//8cuXcEV0ar3APt4eJrOTJJU3AcAuwpZJrfqIUPi0hPP46ZfTuxdkcY7BATt0HQ0jhr3CEe6ODkwwbrPkR+uahjyFOEXzwS8L6hDOF1G+6z8O/8xUgs0JsBH/9M9a4uxzXiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxJgQ/2V; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso12954a12.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 05:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705671244; x=1706276044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUpm+gaD413jbZ24jnAVcJNl3ll129InshsqRLo0sXI=;
        b=vxJgQ/2VUSh/+Nr2qk7U8LR8PJyzuNP31Nf2W0MZd2+5MteNDYTTzTPn0eMEEog2pV
         Bcfd579MzCwDOLoQNlH3BggycGNITsBEswBChlzUCst4cBzHDyYhR7YaCyOi7mcknnQn
         ceklep9AbVeWGbHIP8/yJp2jM02v47fKN98BOs2xDGjUBFF50lhxWufVdAMblfNyIC6D
         2Vmzy0X/gc9fDr+NwF1iIa6bqC2gu4WF3xrYZU07G5EY17RHSv/EKk1DqwurwJQ9Smd5
         1tKtxz3IUdXe9mSH/brsbeXXp6qx82er8ORWzPyXobQbeUr00AD4I7h4jciHjU34mBHX
         gpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705671244; x=1706276044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUpm+gaD413jbZ24jnAVcJNl3ll129InshsqRLo0sXI=;
        b=qMhwS3+mZ8UsL7N92btUW3P9FHACX8hc+EbqHvSyC+qM7j+9jCHlpRrtomDyrRCDtq
         ePE4fGQYmg1UGsGzYuKJ5KND2icp6hjzeqpnIhzrn5z6HMDE0Nw5Upng1Q5XE+pAOsMf
         zLRcw5xDpzRavvRRvkL/VR9lleyLnExtSZYpl5xeErtcOb3B9ScBJdZ0TsYrtrHszlgx
         Zu+gz6Efirr4EoMs02j82UkzJM9GZ80ppIsSXEXF4W97oziHf5vb6AYav0mgDCBXcGUo
         crRv8STqS8bURvI81KZA23sM3F1G+8ZlqfdbWLVAye52gXIDNX65pOTEAcw8tb7SMPSy
         lsmQ==
X-Gm-Message-State: AOJu0Yyfh0b0LXDkD6e9FrB+j3KYV9/LvH0B6Q2gU2ujH/5uRr5C/w4A
	v1/55A1cSffIy8tEHfYTji7xxTO2VFnHA1fUirSPGA5RcoQWxGTMaHpjr9Fu1JKZSUY6mtbMAqt
	4gV1/ndPoyuKnx+bDQ/FlM52Wg8MrLP26Y593
X-Google-Smtp-Source: AGHT+IEIDUIy7+Hic5aux+KWHFwAHWFhuYBwGcyhPZTrWe33z8ZfTQ8Q+i5/rZHz4By4PaUnU4nldVWIRUUa5cPDFsA=
X-Received: by 2002:a05:6402:3134:b0:55a:5fe0:87e4 with SMTP id
 dd20-20020a056402313400b0055a5fe087e4mr96310edb.0.1705671243817; Fri, 19 Jan
 2024 05:34:03 -0800 (PST)
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
Date: Fri, 19 Jan 2024 14:33:52 +0100
Message-ID: <CANn89i+kXoxQtq+YWLdNL1A2SXdGTENf=zrv9jZwhWYVp9jtww@mail.gmail.com>
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

Great, Salvatore can you send a v4, with the Fixes: tag properly formatted
and including Paolo suggestion ?

Thanks a lot.

