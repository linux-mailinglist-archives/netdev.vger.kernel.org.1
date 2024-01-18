Return-Path: <netdev+bounces-64151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8019C8316C4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3224C285D64
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8429422613;
	Thu, 18 Jan 2024 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikMB7QWv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B042209C
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574575; cv=none; b=hSfKZp58A6K+WGk4lfOYc3JlcGvVz0O+DPC21vNPQqAjBvHBI6LDXmfWh/9DoZH7aUoPt5TZy4R1pP7H7NgNH1luMvQnBjlIO/BzAzka/jleLxhpCbDpHBQtZSFFQz/fKTYIwKaJGFapK8Alurm6ihtMGY4RPWlpqUHW3SDhXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574575; c=relaxed/simple;
	bh=32OwmRERePtddG5hUpyyf+toErAw0un9KBgr44+5uQs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=hTidEP9Zxc3Xs512Q8I3PyQm7SquO8J+uawbZ4Lnqe/Iw/p7OHNeUeEhbNpZabvRrG97fY94AQlCXVmltgQey+zP2hY+B/3PQBsQ4wfksgcewVCSSzl2CeUHdg0kb1Ry7rNBRRlA7fwZKmMxc95+5ceunVprBoApiYm/Q24qPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikMB7QWv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e865bccb4so24085e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 02:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705574572; x=1706179372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWAbA/TtutucwFYKS0UF7g4Yy2bYtQp423lCVc0ROVM=;
        b=ikMB7QWvhFzsdRdzlNyFms59l2eAJZW1Tcv37VlBsb3g7Tx8t+ca9jLN/6ll2d+YVz
         iPOyqhE9aEEv30MZdCz6MEgCkoIRUle2euyLCkA53ir9jGEbjthQxOfM7aptmEhglLQj
         q1G5Q51Gx6/aSHGgPNey//iq07CqB35cmOuKxtr3llOV/UK8jzVXXbSJF4996H8YBTDI
         cn09pb8eDNjNu+QfLVj3V4SZ1DHqBvw9GiH6nOOLfr/ReLwKi1KiF0gU+PcAEcGrA0UO
         K1fUgqPvfwr8srRk//VZhXLzyma22hpGG9AyKyn4Bb9bIwpvi5JUf1kgNSUoD88YDylD
         2OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705574572; x=1706179372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TWAbA/TtutucwFYKS0UF7g4Yy2bYtQp423lCVc0ROVM=;
        b=mnZdlQKv/6hZuTWpm3bgNvJJSIIyKoKEHiEXgR0X1MWWsc6rOGZ4FLk+RqtFrxQRgo
         kaP/L3svvW726E6pj/iPHrTiTXWYNrfqXG3fiU3CX5sFfpoRmBjI2IF74QUKWJnJz2qk
         dMDuPweiDiE3jmzFLaQLqJ70fXeSP8NuAgeKgDeeGTRnhdp+855P5l1C3QXBIhk3etGu
         YgnQDlflV3cWcjMwtpk9FThqta1GtrE0kQ6eoxN+onfh9V3dr+EN+DfF+NJBwyvKQWsd
         Q9rIVTbO9Wa1lRnlZ+GC/WN5LS03Vvr+H3dBgoJPrUyOyGjkbj1nmPqIH/8uKMH6wvmU
         BUZg==
X-Gm-Message-State: AOJu0YwVejh9ib61EHHN900Bpl8dl4Yj4S9+pRdSJ2alkvLX9J7emYqv
	KYw8QueiIV2hGWdoN+dhUdXGlo9wmsC8lM+sJ/2PWDwD9NQc7KY9HVJcUcgn9MkTplMh0gQrMzm
	13NC49YcvlgKdOSKj9EE86GzXn04jSAENwumy
X-Google-Smtp-Source: AGHT+IHb2P89u2ALjr3vNOdM8DMet0AVFC1zxe6t9fjpKPvaVRTO6rsB3UnSJRnC9ykSWUx6CL5+ATbkIWng3idrftw=
X-Received: by 2002:a05:600c:3ca0:b0:40e:6273:a5f8 with SMTP id
 bg32-20020a05600c3ca000b0040e6273a5f8mr50654wmb.6.1705574571775; Thu, 18 Jan
 2024 02:42:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
 <20240117231646.22853-1-dipiets@amazon.com> <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
In-Reply-To: <e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 18 Jan 2024 11:42:40 +0100
Message-ID: <CANn89iLmx=u9_==xr-2OfZRA-B3DQE11_Oz3uP-DNLH7k-HwxQ@mail.gmail.com>
Subject: Re: [PATCH v3] tcp: Add memory barrier to tcp_push()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Salvatore Dipietro <dipiets@amazon.com>, alisaidi@amazon.com, benh@amazon.com, 
	blakgeof@amazon.com, davem@davemloft.net, dipietro.salvatore@gmail.com, 
	dsahern@kernel.org, kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:38=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Wed, 2024-01-17 at 15:16 -0800, Salvatore Dipietro wrote:
> > On CPUs with weak memory models, reads and updates performed by tcp_pus=
h to the
> > sk variables can get reordered leaving the socket throttled when it sho=
uld not.
> > The tasklet running tcp_wfree() may also not observe the memory updates=
 in time
> > and will skip flushing any packets throttled by tcp_push(), delaying th=
e sending.
> > This can pathologically cause 40ms extra latency due to bad interaction=
s with
> > delayed acks.
> >
> > Adding a memory barrier in tcp_push before the sk_wmem_alloc read remov=
es the
> > bug, similarly to the previous commit bf06200e732d ("tcp: tsq: fix nona=
gle
> > handling"). smp_mb__after_atomic() is used to not incur in unnecessary =
overhead
> > on x86 since not affected.
> >
> > Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.=
04 and
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
> >     protected void doGet(HttpServletRequest request, HttpServletRespons=
e response)
> >       throws ServletException, IOException {
> >         response.setContentType("text/html;charset=3Dutf-8");
> >         OutputStreamWriter osw =3D new OutputStreamWriter(response.getO=
utputStream(),"UTF-8");
> >         String s =3D "a".repeat(3096);
> >         osw.write(s,0,s.length());
> >         osw.flush();
> >     }
> > }
> >
> > Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an A=
WS
> > c6i.8xlarge instance. Before the patch an additional 40ms latency from =
P99.99+
> > values is observed while, with the patch, the extra latency disappears.
> >
> > # No patch and tcp_autocorking=3D1
> > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hel=
lo/hello
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
> > # With patch and tcp_autocorking=3D1
> > ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hel=
lo/hello
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
> > Patch has been also tested on x86 (m7i.2xlarge instance) which it is no=
t
> > affected by this issue and the patch doesn't introduce any additional
> > delay.
> >
> > Fixes: a181ceb501b3 ("tcp: autocork should not hold first packet in wri=
te
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
> > @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_n=
ow,
> >               /* It is possible TX completion already happened
> >                * before we set TSQ_THROTTLED.
> >                */
> > +             smp_mb__after_atomic();
>
> Out of sheer ignorance I'm wondering if moving such barrier inside the
> above 'if' just after 'set_bit' would suffice?

I think this would work just fine.

>
> Thanks!
>
> Paolo
>

