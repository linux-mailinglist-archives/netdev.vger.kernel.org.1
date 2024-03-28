Return-Path: <netdev+bounces-82897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5744890209
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B021F24F97
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15D127B66;
	Thu, 28 Mar 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flsy+nfw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B64E1C9
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636699; cv=none; b=doJPVI/5xeN3GaA6HXLJEdkyrxRyx6HCIx4x/5cWmqP5sJTOEMULLQ0C5GEWkGyAyBlB4tqnDA8VBWy1egQUvsNx6fN2mbjhZlzB8zSLdU/PdpLqzks7k25RxyXDQx0cOacOU+PbboJ8P1K7//G51hp1+Ds+rvyrCZ55GzI2gBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636699; c=relaxed/simple;
	bh=Je2UAtEY68if5uMZucjTLmJZ569unNwJAEX8q4vFPRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHqgxrQGy/EEct9nDOe5froUBCnlOsBxYjFDJR4YPHOiFc0se76nYHvkzSajLBwEImte7/RhvOMpkp14ohuDUROisdufPCVuiaDBH0WgawGwXs/U/gNVLpHGU87egkoXIV+ZlzQxu4rup6WcGqloGOIROYoYvPdLM8uUFIKB62U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flsy+nfw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56c3689ad32so12313a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636695; x=1712241495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBDqCwUo0BszO/p4vM05OTn+yRfN49/fU9/chw4uLSk=;
        b=flsy+nfwkO1ZbK426PFd7YABXbLYkGaaW1V9v6akdpzEsaj61F1qk6RJlJbj1E3f/e
         pjpAxK7JGumtfzg9aiYogJEtRiIrpMhVEDFriaIPxplEfDmAH8YnOGo3ivqJUysWLsoT
         Yvipt4FUyeXFle4lCPKo4zyD0DAggUnhN5O7nEQKD6LF3d6BvY2O7ttL4g6LrMyWApJ1
         sCAZIJL4c5bx6b0ZKZt6J15IxX0o9Bi16uxl6P/5DXPuQ/PimBn+DiQpQBWfAhIRa/Sm
         N7bT6zSJ8qqZ6tOLedR/WHRz4Qv7VP5cvkvuK9efNsj2EtoH3k4aH5Yk8CNusCKnC4QA
         rmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636695; x=1712241495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBDqCwUo0BszO/p4vM05OTn+yRfN49/fU9/chw4uLSk=;
        b=XraOUT1yOS0zq4tewvyIuFFKJC5fJXcbx5MRiPesQByXE7GqH4Uj/CwJ0MyC/rJXvJ
         53Olwp78+WnnViIbqq8kkNgHhOFPmXu3s5N+KiN7iFxhBHJQ5r+d3dIiawKFJGmMY2Hv
         NrPm9IUVVpNm314MrinG2R2Wvf0DhS+i8PExaX7VHKt2SOY2R7a2UdYndBsDGYQ9+SVi
         jd1l9+aRHAuHT80FfRAhrORz8NG0X64oycToWeuZCVaMo5aRH+eygCIz2aAqp4h9bIt+
         Wdjr/IP2/HkWAjAU2NXr6AXtt6f3kGpa6vuOGDAIs3trF4VoibwZFCyyd/b4CH13BDql
         PUHw==
X-Forwarded-Encrypted: i=1; AJvYcCXCcphJD4zbOEkvZMb7leElhXmeLGGwLEB5/g/kWlsEceiNlS82xB6B5qok/oeDbV0ndTbW6WYTTOv9+kMN0mjMfoecvNlK
X-Gm-Message-State: AOJu0Yzft5uauy4IXEgSFcqbAnd+1MtbWyOAnS9VqwyKOcAUgbpKCoHb
	H6F1loWn3L9XzCt87E3hO2AJLbUX5Q1fPEYHNwXAqo8CYFH65zRdnTltHjlNHOPwxv2jrAuPONR
	E45A+i53oDxU1sSJZrfGdzUryQZN0onWNJkrg
X-Google-Smtp-Source: AGHT+IFpCb+hAEMXqJRx+znyNHc29XT0UrNVUxB6VWgzCxHc/S/gsBG3CXhdt+RzMQsIPrDbBmYFcfOf8JEENWeNtM0=
X-Received: by 2002:a50:bb21:0:b0:56c:18df:f9e1 with SMTP id
 y30-20020a50bb21000000b0056c18dff9e1mr142319ede.5.1711636695048; Thu, 28 Mar
 2024 07:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328143051.1069575-1-arnd@kernel.org> <20240328143051.1069575-6-arnd@kernel.org>
In-Reply-To: <20240328143051.1069575-6-arnd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 15:38:03 +0100
Message-ID: <CANn89i+3FuKc1RsYaciNe3uQMZuJBjSmvC_ueuQ=NaFVzEnyuA@mail.gmail.com>
Subject: Re: [PATCH 5/9] ipv4: tcp_output: avoid warning about NET_ADD_STATS
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, "mfreemon@cloudflare.com" <mfreemon@cloudflare.com>, 
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:31=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Clang warns about a range check in percpu_add_op() being impossible
> to hit for an u8 variable:
>
> net/ipv4/tcp_output.c:188:3: error: result of comparison of constant -1 w=
ith expression of type 'u8' (aka 'unsigned char') is always false [-Werror,=
-Wtautological-constant-out-of-range-compare]
>                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
>                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/net/ip.h:291:41: note: expanded from macro 'NET_ADD_STATS'
>  #define NET_ADD_STATS(net, field, adnd) SNMP_ADD_STATS((net)->mib.net_st=
atistics, field, adnd)
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~
> include/net/snmp.h:143:4: note: expanded from macro 'SNMP_ADD_STATS'
>                         this_cpu_add(mib->mibs[field], addend)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_a=
dd'
>  #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, =
pcp, val)
>                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=3D=
0 to see all)
> <scratch space>:187:1: note: expanded from here
> this_cpu_add_8
> ^
> arch/x86/include/asm/percpu.h:326:35: note: expanded from macro 'this_cpu=
_add_8'
>  #define this_cpu_add_8(pcp, val)                percpu_add_op(8, volatil=
e, (pcp), val)
>                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~
> arch/x86/include/asm/percpu.h:127:31: note: expanded from macro 'percpu_a=
dd_op'
>                               ((val) =3D=3D 1 || (val) =3D=3D -1)) ?     =
       \
>                                              ~~~~~ ^  ~~
>

This seems like a bug in the macro or the compiler, because val is not
a constant ?

__builtin_constant_p(val) should return false ???

+#define percpu_add_op(size, qual, var, val)                            \
+do {                                                                   \
+       const int pao_ID__ =3D (__builtin_constant_p(val) &&              \
+                             ((val) =3D=3D 1 || (val) =3D=3D -1)) ?       =
     \
+                               (int)(val) : 0;                         \
+       if (0) {                                                        \
+               typeof(var) pao_tmp__;                                  \
+               pao_tmp__ =3D (val);                                      \
+               (void)pao_tmp__;                                        \
+       }                                                               \
+       if (pao_ID__ =3D=3D 1)                                             =
 \
+               percpu_unary_op(size, qual, "inc", var);                \
+       else if (pao_ID__ =3D=3D -1)                                       =
 \
+               percpu_unary_op(size, qual, "dec", var);                \
+       else                                                            \
+               percpu_to_op(size, qual, "add", var, val);              \
+} while (0)
+



> Avoid this warning with a cast to a signed 'int'.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index e3167ad96567..dbe54fceee08 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -183,7 +183,7 @@ static inline void tcp_event_ack_sent(struct sock *sk=
, u32 rcv_nxt)
>
>         if (unlikely(tp->compressed_ack)) {
>                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
> -                             tp->compressed_ack);
> +                             (int)tp->compressed_ack);
>                 tp->compressed_ack =3D 0;
>                 if (hrtimer_try_to_cancel(&tp->compressed_ack_timer) =3D=
=3D 1)
>                         __sock_put(sk);
> --
> 2.39.2
>

