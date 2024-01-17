Return-Path: <netdev+bounces-64068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2002F830EEE
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AA4284EB0
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40DC2562D;
	Wed, 17 Jan 2024 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vu36NA5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0630E2562A
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528752; cv=none; b=fi30pggxf/YB8taY8/Vzb++HHK5piyESqh1nKuBbljOGV8gC+WN0rpPnyIOjxFOJZbxCZw9tff0C0nCmCmTwe7S6BU8CX9QLtRsRM/DM+pjcsKwmJqYO+MR6orCocs6g5g3nsw4CWH4V78CYzkH3Al5P7FFo9Ng5g5I2+2vxckw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528752; c=relaxed/simple;
	bh=ZkzBqrvoUatAN+k08+ULt1RS4f1tMAg1hCDBXm0XRjI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Rtnwxp5QsmoUUD0DwE9PRHQzw7eEb/SmPeaEoykYwqHRfUilwxzutV2C0uHIbE4j9OHoVoX+NtrbJklEuZcfAVrYS7fyJsfod70D1XGj9+YaTEBN2T8jhN0RSOwjMwTHGrzylM5Dr1eMjFfoDgmf59fg40QSR3HMfxGwMV7/V0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vu36NA5R; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-557bbcaa4c0so16870a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 13:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705528749; x=1706133549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHuG8n0Ni9Imi2nkIvdRSFfy2xsayGoyI3O8CMirzNY=;
        b=Vu36NA5Ru9+/1VQIXdF6dEBhrrLh99DaLNFmT+k7Z0oY5qnIT+Dz4TNttQ+a3Eyl9d
         PK81Ap6cVfqgB/6JL/7W5uDlpvQRFPe8mKGHmjf1aqxYCVKhkKtk8ywzpd/FnfCcxZXL
         s72GMp5/QNIKNxUH51IYPX7cOc8U565DSsJykoJ3J8Bcvpz8mViHE7zKzGxyyKVqzeK3
         HoYgLTZZECTBrYlXBZbBUUfkGdX6p/Wvt0QD+t7twfsYC1L53Lk23obh228p4FeSW+XB
         JhMBdXT9J4PcP7/FzzlDEQ7wgCCDxVQa+GJrsv0U5v/F/SV8yoIAQo3Wp7+AmMN1JIKz
         V9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528749; x=1706133549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHuG8n0Ni9Imi2nkIvdRSFfy2xsayGoyI3O8CMirzNY=;
        b=eDlDSVZikYu4lIOJNlvF02Q2GX/ctVuTZg9O07OXMNA9Gt120eua9gxI75YgL52nYr
         Lb77gHN4qDSVVAEcIe7nAOE5ArlKI+02AR1a6iKlk79X/2vjvsmmctY4Ydv79I7YhLBo
         PyFbBot5hH4wo55Vx1Esafy2trr8e1BcRVAn8n+DTwXD0Q9GRGW3uGfAHEGG6hk6Vs8T
         rqM4fAkxH5vPM4fCysOaVZNpzAPuV0rjWHBRNF3DkEo1HJhwQS/sKI5w0nZDi18ewZPI
         6qo8TQeu4M6Jw4y3NX79Nq59UHT7Fzkm9n+XP92V2zz0BCania+41DlM5IPffeSP8vWs
         ecyQ==
X-Gm-Message-State: AOJu0YwfA3RSmjYPb63dtMxtXCkkigytAFOrj3XfmVsTWh6Pk04yWPZU
	Z0RpLKuwTaNuj7Oz8eGdSzxh1Gzb/PveMEqEflGQsACn4Tc8btQokjTziwpn6P0euIOF7fRNcCe
	Wwp/zZU2he4phF7yriNYr9YIa+3tKHVY5NGqL
X-Google-Smtp-Source: AGHT+IGu8ujVqUE+FsTJt3rUPu7Q+VYMFZvl9LJ/5MR4hG79JYzT7DCVg/4HOAPtRhnDfTCCcMzgmgo4C6xHk8Ecscw=
X-Received: by 2002:a05:6402:5d86:b0:559:fde9:1b5c with SMTP id
 if6-20020a0564025d8600b00559fde91b5cmr37955edb.1.1705528748987; Wed, 17 Jan
 2024 13:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJwokqZC9P3Ycy4ZWpmT1QhC0qD79y1K1eg2UUAcAj-Lw@mail.gmail.com>
 <20240117212648.12572-1-dipiets@amazon.com>
In-Reply-To: <20240117212648.12572-1-dipiets@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Jan 2024 22:58:57 +0100
Message-ID: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: Add memory barrier to tcp_push()
To: Salvatore Dipietro <dipiets@amazon.com>
Cc: alisaidi@amazon.com, benh@amazon.com, blakgeof@amazon.com, 
	davem@davemloft.net, dipietro.salvatore@gmail.com, dsahern@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:29=E2=80=AFPM Salvatore Dipietro <dipiets@amazon=
.com> wrote:
>
> On CPUs with weak memory models, reads and updates performed by tcp_push =
to the
> sk variables can get reordered leaving the socket throttled when it shoul=
d not.
> The tasklet running tcp_wfree() may also not observe the memory updates i=
n time
> and will skip flushing any packets throttled by tcp_push(), delaying the =
sending.
> This can pathologically cause 40ms extra latency due to bad interactions =
with
> delayed acks.
>
> Modeling the memory access behavior of tcp_push() (P0) and tcp_wfree() (P=
1)
> using the herd7 simulator, proves this behavior can occur. Below is the l=
itmus
> model which describes the functions:
> ```
> C MP+tcp
> {
>   [flag] =3D 0;
>   [sk] =3D 5;
>   [corked] =3D 0;
> }
>
> P0(int *flag, int *sk, int *corked){
>     int r0;
>     int r1;
>     int r2;
>
>     r1 =3D READ_ONCE(*sk);
>     if (r1 =3D=3D 5) {
>
>         r0 =3D READ_ONCE(*flag);
>         if (r0 =3D=3D 0) {
>             WRITE_ONCE(*flag, 1);
>         }
>
>         // memory barrier added in this patch,
>         // original code does not order the reads/writes
>         smp_mb();
>
>         r2 =3D READ_ONCE(*sk);
>         if (r2 =3D=3D 5 ) {
>             WRITE_ONCE(*corked,1);
>         }
>     }
> }
>

Interesting.

Quite frankly I doubt this herd7 stuff needs to be in a changelog,
this is too verbose/pedantic.

What about instead referring to similar commit bf06200e732d
("tcp: tsq: fix nonagle handling")

This was exactly the same issue, but at that time tcp_push() was not
re-reading sk->sk_wmem_alloc




> P1(int *flag, int *sk, int *corked){
>     int r0;
>     int r1;
>
>     r1 =3D READ_ONCE(*sk);
>     smp_store_release(sk, 0);
>
>     r0 =3D smp_load_acquire(flag);
>     if (r0 =3D=3D 1) {
>         smp_store_release(flag, 0);
>     }
> }
> locations [0:r0; 0:r1; 0:r2; 1:r0; 1:r1; flag; sk; corked; ]
> exists ( flag=3D1 /\ corked=3D1 )
> ```
>
> Adding the memory barrier removes the positive witness from the memory mo=
del.
> smp_mb__after_atomic() is used to not incur in unnecessary overhead on x8=
6
> since not affected.
> Patch has been tested using an AWS c7g.2xlarge instance with Ubuntu 22.04=
 and
> Apache Tomcat 9.0.83 running the basic servlet below:
> ```
> import java.io.IOException;
> import java.io.OutputStreamWriter;
> import java.io.PrintWriter;
> import javax.servlet.ServletException;
> import javax.servlet.http.HttpServlet;
> import javax.servlet.http.HttpServletRequest;
> import javax.servlet.http.HttpServletResponse;
>
> public class HelloWorldServlet extends HttpServlet {
>     @Override
>     protected void doGet(HttpServletRequest request, HttpServletResponse =
response)
>       throws ServletException, IOException {
>         response.setContentType("text/html;charset=3Dutf-8");
>         OutputStreamWriter osw =3D new OutputStreamWriter(response.getOut=
putStream(),"UTF-8");
>         String s =3D "a".repeat(3096);
>         osw.write(s,0,s.length());
>         osw.flush();
>     }
> }
> ```
> Load was applied using wrk2 (https://github.com/kinvolk/wrk2) from an AWS
> c6i.8xlarge instance. Before the patch an additional 40ms latency from P9=
9.99+
> values is observed while, with the patch, the extra latency disappears.
>
> # No patch and tcp_autocorking=3D1
> ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello=
/hello
>   ...
>  50.000%    0.91ms
>  75.000%    1.13ms
>  90.000%    1.46ms
>  99.000%    1.74ms
>  99.900%    1.89ms
>  99.990%   41.95ms  <<< 40+ ms extra latency
>  99.999%   48.32ms
> 100.000%   48.96ms
>
> # With patch and tcp_autocorking=3D1
> ./wrk -t32 -c128 -d40s --latency -R10000  http://172.31.60.173:8080/hello=
/hello
>   ...
>  50.000%    0.90ms
>  75.000%    1.13ms
>  90.000%    1.45ms
>  99.000%    1.72ms
>  99.900%    1.83ms
>  99.990%    2.11ms  <<< no 40+ ms extra latency
>  99.999%    2.53ms
> 100.000%    2.62ms
>
> Patch has been also tested on x86 (m7i.2xlarge instance) which it is not
> affected by this issue and the patch doesn't introduce any additional
> delay.
>
> Fixes: f54b311142a9 ("tcp: auto corking")

Bug came with a181ceb501b3 ("tcp: autocork should not hold first
packet in write queue")



> Signed-off-by: Salvatore Dipietro <dipiets@amazon.com>
> ---
>  net/ipv4/tcp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index ff6838ca2e58..ab9e3922393c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now=
,
>                 /* It is possible TX completion already happened
>                  * before we set TSQ_THROTTLED.
>                  */
> +               smp_mb__after_atomic();
>                 if (refcount_read(&sk->sk_wmem_alloc) > skb->truesize)
>                         return;
>         }
> --
> 2.42.0
>

