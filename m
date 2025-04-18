Return-Path: <netdev+bounces-184169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868BA938D7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21121B64F65
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1671A1D5174;
	Fri, 18 Apr 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeVwTiUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090C6BFC0;
	Fri, 18 Apr 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744987767; cv=none; b=m7qQDmOr0PcKLOZDfmSEXxPiHCRdiLu9izrwT/jDtZvcPed8RvxKjJ/n97fDzN0GvXUJ+qRRX5lqxiWHuHDqNqcQhO8eFmggzXMCtTeWhDva1hPOjNrWbsLd/7EaTRTqPU9lrJBAXfjrSposu+grGR71eMarZUhj8KIYl0/fP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744987767; c=relaxed/simple;
	bh=FaOJcILnicKDAigLqSzi5DkUputjov+2ox6SQq2QzYs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fU1nYD7TyTZmgQrZf76aE9/Hokqnqyy7DCc+4gqNhQCDVPQ72DbNSA6mnE6/mh9AQcYy2bas2D9hPNPnN4y8nwD3UMLoF5WZXLZcEzsK0tGKnlHe5Lwrpo+Np4f9tgGw73zpI3HyEfkAePi/cc//PS0ELzFYKCWRZ+DkzhhGDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeVwTiUn; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e39d1db2so100563585a.3;
        Fri, 18 Apr 2025 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744987764; x=1745592564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaOJcILnicKDAigLqSzi5DkUputjov+2ox6SQq2QzYs=;
        b=eeVwTiUnBZAAuEzCjjwOgWIWXAhTmlKt1/vLxZxBVNvr0+PFbhnIt2AGcAahSLoJFp
         gNjQgxvivBzK4S8ls66dmZeV9Gicy58aQ6EaciEQRQ6TVekjMcmCjX34iqA+YD5QGAXM
         V+DdAhWFtWZgP/du0b3oxTtTKmVmM/fpKscsQUDnbK6vRDMvIAXq3hrZhENXQW2aAukH
         WanGba4EXgSzDGur1khbZlFF/0CAHY3eA+3zs8kGGXjT95E+GC7M9dhjV0F2nSMA+qdT
         PUJ1VuESrmn4+ZMc37e6jqVtTHZhkLUELm2OdWG0JMcU01plh68rhoNmdL1i+vd3ZX87
         c2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744987764; x=1745592564;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FaOJcILnicKDAigLqSzi5DkUputjov+2ox6SQq2QzYs=;
        b=fq2Sd+pipDHfloe6Q5zMRWPGNwzSRPeirLSHP2zic/vDuW8LDyRwefD5kHtT27xddC
         6yDmQ9tSqAGzopB3fw38dAEzoRA7iEFPM0CzZ08opVlsGRnORDKepIpt5c4szcSAd1Nu
         t+9WCdcGFIbHNbSnpeadUl89qZ8fTW+pbY0QUoZ7UnXrwWH1goLFjpbDsuofaqshpZYK
         DfnvSOooPg+WSXlKRpnycpysIPnyORLIT8R+duUA0B3zNy3kLNOBOTyEZE3qnvXSKkVH
         72TuBXv2LmJ7f6KZLqZKSGlvOh5O284ggk9maT5p2jSi/du2j0rSV+i5dhwmTkNClZHa
         vj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiLgZ4C2G6hpP91WFJzXXygiLJYqrrBuzvaHHX7WfWIhva/K2do3Jlg3Mdhkt/63pxX8nDjDqzIrMQWOXOkUXdRl/v@vger.kernel.org, AJvYcCW+xXwB+35zuNuERlfwVKMZBi0FW9XTGCmMcQgU9iwVY5qYZi5qG2TFDorKwB5KhKAFrRvcno+Fcz/baeY=@vger.kernel.org, AJvYcCX6LQMczCH0zyqF7EVR7guw89dmrRvjKU23Asivjr50agQ4xYLBNWDS1gL2ICV9m4WwSBU/Wd01@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3zjl2RR4YmCc2gQcH1eF4BQrwHq0WikQTmS+CoFVUgMg83P5z
	1xyheLMZbKhWdtKxEQmyI4jcFFgMvpAkHaHZKqr80v2Syd8IG8Ub
X-Gm-Gg: ASbGncsRoQ7L97yWYV4mMPoJ0nka2M0LRdcXpJvwBFLVFvrPh6OZWjXOEzYYEVPM7MP
	Vbw6IhYFOfQ0zVnrx0qxjCRvK0LxrcrllpIQxMNq+lpqe5qGLCP7/r2aclAjK1L6clxsPopsvDM
	/6O9HbpumpnyMWMViNH0I8vCKE8MtYvzZH3eDlE3/PJyakkmj+0cRbeDWLXTvxxEv/BeAmJqfyJ
	tfomQSbQENCNQAKtdOfod6u1cLKLYex/M7ZKtp390koyBDp97BTR83zhFRaacM5A8eEVwGyV68Z
	pM4fss58yg/63gW0Et21K3uxtLdNtAcsLQmsVN93JlI6n2YKdYRBmpNQtuPOFgRt2jT63TH0vBT
	9BtuY6bdqyQJNjNveyxhp
X-Google-Smtp-Source: AGHT+IFRfBoS8vUxvewHn24Q3Q4yyEdscCT2aX9aSNU+lRYRMOA1xeo2dlIoqR7EJg+gvH6TnNs4ng==
X-Received: by 2002:a05:620a:1a08:b0:7c9:2612:32db with SMTP id af79cd13be357-7c928043431mr487499785a.49.1744987764205;
        Fri, 18 Apr 2025 07:49:24 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c925a8d484sm114376285a.31.2025.04.18.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:49:23 -0700 (PDT)
Date: Fri, 18 Apr 2025 10:49:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Song Liu <songliubraving@meta.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Song Liu <songliubraving@meta.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Breno Leitao <leitao@debian.org>, 
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
Message-ID: <68026672df030_1d380329421@willemb.c.googlers.com.notmuch>
In-Reply-To: <B5B46BE2-C4D8-4AB8-BEBC-E0887C9B175D@fb.com>
References: <20250416-udp_sendmsg-v1-1-1a886b8733c2@debian.org>
 <67a977bc-a4b9-4c8b-bf2f-9e9e6bb0811e@redhat.com>
 <aADnW6G4X2GScQIF@gmail.com>
 <0f67e414-d39a-4b71-9c9e-7dc027cc4ac3@redhat.com>
 <4D934267-EE73-49DB-BEAF-7550945A38C9@fb.com>
 <680122de92908_166f4f2942a@willemb.c.googlers.com.notmuch>
 <B5B46BE2-C4D8-4AB8-BEBC-E0887C9B175D@fb.com>
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
> =

> =

> > On Apr 17, 2025, at 8:48=E2=80=AFAM, Willem de Bruijn <willemdebruijn=
.kernel@gmail.com> wrote:
> > =

> > Song Liu wrote:
> >> Hi Paolo, =

> >> =

> >>> On Apr 17, 2025, at 6:17=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com=
> wrote:
> >>> =

> >>> On 4/17/25 1:34 PM, Breno Leitao wrote:
> >>>> On Thu, Apr 17, 2025 at 08:57:24AM +0200, Paolo Abeni wrote:
> >>>>> On 4/16/25 9:23 PM, Breno Leitao wrote:
> >>>>>> Add a lightweight tracepoint to monitor UDP send message operati=
ons,
> >>>>>> similar to the recently introduced tcp_sendmsg_locked() trace ev=
ent in
> >>>>>> commit 0f08335ade712 ("trace: tcp: Add tracepoint for
> >>>>>> tcp_sendmsg_locked()")
> >>>>> =

> >>>>> Why is it needed? what would add on top of a plain perf probe, wh=
ich
> >>>>> will be always available for such function with such argument, as=
 the
> >>>>> function can't be inlined?
> >>>> =

> >>>> Why this function can't be inlined?
> >>> =

> >>> Because the kernel need to be able find a pointer to it:
> >>> =

> >>> .sendmsg =3D udp_sendmsg,
> >>> =

> >>> I'll be really curious to learn how the compiler could inline that.=

> >> =

> >> It is true that functions that are only used via function pointers
> >> will not be inlined by compilers (at least for those we have tested)=
.
> >> For this reason, we do not worry about functions in various
> >> tcp_congestion_ops. However, udp_sendmsg is also called directly
> >> by udpv6_sendmsg, so it can still get inlined by LTO. =

> >> =

> >> Thanks,
> >> Song
> >> =

> > =

> > I would think that hitting this tracepoint for ipv6_addr_v4mapped
> > addresses is unintentional and surprising, as those would already
> > hit udpv6_sendmsg.
> =

> It is up to the user to decide how these tracepoints should be =

> used. For example, the user may only be interested in =

> udpv6_sendmsg =3D> udp_sendmsg case. Without a tracepoint, the user
> has to understand whether the compiler inlined this function. =

> =

> > =

> > On which note, any IPv4 change to UDP needs an equivalent IPv6 one.
> =

> Do you mean we need to also add tracepoints for udpv6_sendmsg?

If there is consensus that a tracepoint at this point is valuable,
then it should be supported equally for IPv4 and IPv6.

That holds true for all such hooks. No IPv4 only.=

