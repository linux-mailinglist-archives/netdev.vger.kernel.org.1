Return-Path: <netdev+bounces-183814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F19A921F1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F711895B39
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E09253929;
	Thu, 17 Apr 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAzE6QCM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4061253B4E;
	Thu, 17 Apr 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904930; cv=none; b=jXDzA53St8R/ufOAG9FsDpJPezwDODye2x0HZhM1+ComDwjnLFbdnV5d/vUPTAMbe/40p5Kj4Ienw5zSHFJq1EXG6U91Cg6SJ3iONUVjVmPy5aXZVlV3ZABElRwNGicU4e3dgbYntcB+a1Eljbom7BjF1JmynQfEInr7hXbtI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904930; c=relaxed/simple;
	bh=ClRmIN+7tcZ09syy4bcP8WJEVYYf/AZpRlc74JwrGSQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eUz5fP4rm+npAdnFY6m8VaZ2V1lOnQzDd3rjGWqYbV0qiC6Rwh7TSSB03P0P3gYx9yzEiXF/z40ctkX4Y29ZHeCkiqFkZHYBSyPHX6GkIzKhaK+uSQa4xSyq5HRvdqpZTSDCIpqyT5AzAz37S8ok7sYGzwQVOieT/KvFvK1zFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAzE6QCM; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c56a3def84so79573385a.0;
        Thu, 17 Apr 2025 08:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744904928; x=1745509728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClRmIN+7tcZ09syy4bcP8WJEVYYf/AZpRlc74JwrGSQ=;
        b=aAzE6QCMP/GKADwXGHt6g8QlQxalaeZaeYcNUwpOQt+hE1pcj88ShNwx+mO+YP8aw+
         lv29Vz3IGbQecmZMHS0Em6k//Mfiq80i9cAMxv4AFdtJPz0ccJEIgbOtDSPrhF2OFvHk
         2ikdPI0WZGWeX/sfVTcAzMl2raMkad93IEuCA/csuOHd33jLAKeGRQnl3wpsJwCACnqG
         3MN1V/rbIfW7ldB8BFO4ON0wHEfYN35Xh71Q/BXKhnCElr2D7dNdT7+0s3dmwBvofpg8
         UK9TbwW99s21tKQcX3rhx7kOtGlnQpqmXQ1LAOrlE2a+mbittz7WW8OMIt5pojLNdT3N
         Fe7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744904928; x=1745509728;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ClRmIN+7tcZ09syy4bcP8WJEVYYf/AZpRlc74JwrGSQ=;
        b=MFVnfXOF8FZUbTV+P6iguGP8k6WtXwWe86pFSbvZdjyc30XRygI1cfqRFVKT2KmC7c
         UU5e0MItqs9G2ZnveCNsbr3IdtWP+X+lYa/KVG+jANr8a/Pin9kYttBo+K95XH6FUWHw
         7+8adKBAWFsL6ATlO6HAwPUlZdMCuOpb0TmPDd4yiE2dMKpDnqAQ341zk+fk8G0xSmGH
         cN0VRvQSh+zJi3shjctqpFnD2rEBr40sTCJlY5sTioHqTW5wCXL6gsswXeo1jroZSHnK
         igQPv1tzhlShJOxHvwTOAOPkD+EGBwg6HqglludXCi+do1qdX07d3haefYwXXOxxwIe0
         AE4A==
X-Forwarded-Encrypted: i=1; AJvYcCWctkgWYEiFB4PDdQYpEZisLgKHTGVcGJB2kVKJxrbciBOIYmjYJ8hWEwyaC1J8+XlViP5fyyn1@vger.kernel.org, AJvYcCXNlpYe+tSnWxwtrHJFngbZARA2+Mg/XeudCB3u1hpkFHiqqHhkLImmUW8u897rT7lY3GliXMXuB+41iEk=@vger.kernel.org, AJvYcCXzLQZA54cnUAJB3Ahi+7IYTtRYgi+JSo3G89G3k4ZtpHwvF5g/owIWVKATTl9n07fRuPRzx7x35K0WxQiPvIsRd0PB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0xEPAkCtqTF4MG149LePH4WuIY1UAGEAyLUNRAMC4kvgw+Fz
	0KfdnKmCY7acQpJBUp717++bLBG+28Dil+JvH2pl9iiPA1p8UipQ
X-Gm-Gg: ASbGnctR+Btan2MsYJxm03W+xjmDXoqJ3spXHNSXlfh0LOlCEtthjenNxxunJJc0QWn
	6MAhQQmIHuBVoBw3l6TJ9FAVkIYqx5K5QOeq78+6fRIee2lLhtCepOxA7n9k8ci0/rAQfMdgHES
	zn32v578QO6e7+8SIGlrxz924dLJXwuW5aOoK6Qtv+b5JJVzv0p1WKiWlXJuhGhZy0ycsBTainR
	7ak7JjdYAJtlWx/L55W2sbgi7yumhr02g1PEcqcYq7Q9HPWlhYw0kYLR/0ck/Q3nrfbqKoMCCqm
	Kcy9fr48GJqNSiuAM4/XYTtGyJAcMdCOQ/t27CO3ued7iYfdgu3HHnIkQXSj4Y1HK49he3EIiWS
	1vASJA4iyzPwHqft+pmiwqBOft6yTdFE=
X-Google-Smtp-Source: AGHT+IE/aYtEG63OWyM3ZH1aDT8SuS8Yu39bABKue/8b/gskEjEF3y1AdYeFUZ4n7FVaw5313LSsbQ==
X-Received: by 2002:a05:620a:1926:b0:7c5:a29e:3477 with SMTP id af79cd13be357-7c919084009mr1000641185a.53.1744904927677;
        Thu, 17 Apr 2025 08:48:47 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925b4eb32sm4099385a.77.2025.04.17.08.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:48:46 -0700 (PDT)
Date: Thu, 17 Apr 2025 11:48:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Song Liu <songliubraving@meta.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 "kuniyu@amazon.com" <kuniyu@amazon.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
 "song@kernel.org" <song@kernel.org>, 
 Kernel Team <kernel-team@meta.com>
Message-ID: <680122de92908_166f4f2942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <4D934267-EE73-49DB-BEAF-7550945A38C9@fb.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
 <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
 <4D934267-EE73-49DB-BEAF-7550945A38C9@fb.com>
Subject: Re: [PATCH net-next] udp: Add tracepoint for udp_sendmsg()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu wrote:
> Hi Paolo, =

> =

> > On Apr 17, 2025, at 6:17=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> =
wrote:
> > =

> > On 4/17/25 1:34 PM, Breno Leitao wrote:
> >> On Thu, Apr 17, 2025 at 08:57:24AM +0200, Paolo Abeni wrote:
> >>> On 4/16/25 9:23 PM, Breno Leitao wrote:
> >>>> Add a lightweight tracepoint to monitor UDP send message operation=
s,
> >>>> similar to the recently introduced tcp_sendmsg_locked() trace even=
t in
> >>>> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> >>>> tcp_sendmsg_locked()")
> >>> =

> >>> Why is it needed? what would add on top of a plain perf probe, whic=
h
> >>> will be always available for such function with such argument, as t=
he
> >>> function can't be inlined?
> >> =

> >> Why this function can't be inlined?
> > =

> > Because the kernel need to be able find a pointer to it:
> > =

> > .sendmsg =3D udp_sendmsg,
> > =

> > I'll be really curious to learn how the compiler could inline that.
> =

> It is true that functions that are only used via function pointers
> will not be inlined by compilers (at least for those we have tested).
> For this reason, we do not worry about functions in various
> tcp_congestion_ops. However, udp_sendmsg is also called directly
> by udpv6_sendmsg, so it can still get inlined by LTO. =

> =

> Thanks,
> Song
> =


I would think that hitting this tracepoint for ipv6_addr_v4mapped
addresses is unintentional and surprising, as those would already
hit udpv6_sendmsg.

On which note, any IPv4 change to UDP needs an equivalent IPv6 one.

