Return-Path: <netdev+bounces-159339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E4A152B5
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108AB188B369
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085CE18A6BD;
	Fri, 17 Jan 2025 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A95jSaak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B24818B495
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127157; cv=none; b=bVHIBitowHSnRLfbw989i6pkN8cUmFT2aNaTsnKlq7HlAF3ePk3QDx94+M/RmXYIdWosDPO4eAOJYhTa9M/OmxP25AYtwyg2w1e6/RA5XjhGukuwaYNvHrYrPYXfeavKyXlBBz7VAOIQ9BC8pIQHlyxH5lGwY2f6FNp61Mt3qio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127157; c=relaxed/simple;
	bh=T/jTb+qgNEiS7HadM8rfU43d+/3SlKlJJpnFJPXWXQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGrMyddVg7Yf610li8C/hiD4gYCJx0mNUUnCiF6AxXZoHtrx5aI4qbTMpRcrmBa2M9+WCoc5CfM5IZCSpZUKSEqNa9NGhEqDbxfd5SdXnmmjPkvj4wi9J6zAYmaCI6e4Z3r/W71WmMmAKeYxgLNmYqchz6IQs9mPRedVap3Q7eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A95jSaak; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4678c9310afso223971cf.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737127155; x=1737731955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhoBIkKOhoYfmdi6JZxaNgKaAcxAfQDccoZIuvfZzxQ=;
        b=A95jSaakj3xXxKgECPbsGfr1AngIzuGUH7WUaYX+VQf8c74RLUn9aGsSuRLXknk0IA
         w6zz4YGm7qgOO5xiuRD8kpyB2qhHAYOJotBlw1353uEkIo94JrM7rt/dPk7ElCAs4puZ
         K8UqyTSELjKwoF6XM3v8r/aUkwqG+Smg8hA7W7nm4qmyudD3f+xvwjvQXf6f5Rw4RPxe
         9ewU5nvl7Yb8z1vddND0dLbUoC/L+Agwb/tjByb1gU8Zd9J+mY7jqkoofYfLMdFAFa+G
         7yeAXx9a+zr04VmNY5mzOnNDT0Jpe27dp4QwtBLLTZpc6QqgjcH6Br4iyTRtV7+AixIp
         zxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127155; x=1737731955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhoBIkKOhoYfmdi6JZxaNgKaAcxAfQDccoZIuvfZzxQ=;
        b=iV43leX44VZ8woiBxFqxpuaGHCMb9b75VuvlnvAAID6kKN9lJAfIoKog1B1g/U787g
         uw+XsJCxF8wKvY4CmoVuAC4iYZPg8OEixbqlPrmkJirUmu2UqWwVd9JGf9lWC83oqVcW
         M9Rv/nhV/qSKGM0w7i3w8PSxK0woK4QLW70wI53rAIDhiiRC4sZNFscSMHAYgkpJSMTF
         i1+zD0tryvbVZ40xR2vJCH7/e7mspIRPvnY9+GMPfV9YAhgPT4356LPFa+1QhxZnbA+7
         FG3NSmBWhteS929K8ZlwbuZ9eL5ZOvE0tqoHDx6iBxkgFDULzcvZ40oJTIWpHcAG28Q8
         7J/A==
X-Forwarded-Encrypted: i=1; AJvYcCXM0s4yR4B1RvHLmD5iVVXJFApFZOLrrU98bBLmb7uVr1XBCuGWnLa/khbh8TR+l8xQGiii8Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNmPXe1nPAMxYBA2quXWSq3FQNbmI7K+3NJmQjsLCURUsJFZus
	7BZ1ziMFscPWSTkiqo1G2BstpZ4yTe0ov/fuz7cReilYMVe5Kv7FxrhypnNdSp4VvDL4X7Rqq8H
	8l9+AQ3+gh3AdkTqsQT8FuGeKhr+jO3lmYOVG
X-Gm-Gg: ASbGncuD+2xkj2zxA87Cz2OYP3cNnKsg/DFEC48S/ezKjK+yofv+JBANexoH0uSPE1P
	UYWdRz7qPfOvRV7nDAYdS6zPQm/TTTiU4GiWuPb1HM5LrkjoazBaG3HEAjN9vdOwEd2l/yw==
X-Google-Smtp-Source: AGHT+IF/AT9f2+6ySPtpjnphdaZgu1f8T5/RwVNn/6TrQGroAetNMw5+d/6pJXhP1AVw7IgNOifchNGzLRfqQGJJGlg=
X-Received: by 2002:a05:622a:612:b0:460:491e:d2a2 with SMTP id
 d75a77b69052e-46e130af6cbmr2827401cf.17.1737127154633; Fri, 17 Jan 2025
 07:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
 <009e01db4620$f08f42e0$d1adc8a0$@samsung.com> <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
 <Z4nl0h1IZ5R/KDEc@perf>
In-Reply-To: <Z4nl0h1IZ5R/KDEc@perf>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 17 Jan 2025 10:18:58 -0500
X-Gm-Features: AbW1kvYA0q8_2KcZgEsEwVs6B5bKlc445mPvRK-RqcuhEo1dFHXWs5fjJyItqDw
Message-ID: <CADVnQykZYT+CTWD3Ss46aGHPp5KtKMYqKjLxEmd5DDgdG3gfDA@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joonki.min@samsung.com, hajun.sung@samsung.com, 
	d7271.choe@samsung.com, sw.ju@samsung.com, 
	"Dujeong.lee" <dujeong.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 12:04=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung=
.com> wrote:
>
> > Thanks for all the details! If the ramdump becomes available again at
> > some point, would it be possible to pull out the following values as
> > well:
> >
> > tp->mss_cache
> > inet_csk(sk)->icsk_pmtu_cookie
> > inet_csk(sk)->icsk_ca_state
> >
> > Thanks,
> > neal
> >
>
> Hi Neal. Happy new year.
>
> We are currently trying to capture a tcpdump during the problem situation
> to construct the Packetdrill script. However, this issue does not occur v=
ery often.
>
> By the way, we have a full ramdump, so we can provide the information you=
 requested.
>
> tp->packets_out =3D 0
> tp->sacked_out =3D 0
> tp->lost_out =3D 4
> tp->retrans_out =3D 1
> tcp_is_sack(tp) =3D 1
> tp->mss_cache =3D 1428
> inet_csk(sk)->icsk_ca_state =3D 4
> inet_csk(sk)->icsk_pmtu_cookie =3D 1500
>
> If you need any specific information from the ramdump, please let me know=
.

The icsk_ca_state =3D 4 is interesting, since that's TCP_CA_Loss,
indicating RTO recovery. Perhaps the socket suffered many recurring
timeouts and timed out with ETIMEDOUT,
causing the tcp_write_queue_purge() call that reset packets_out to
0... and then some race happened during the teardown process that
caused another incoming packet to be processed in this resulting
inconsistent state?

Do you have a way to use GDB or a similar tool to print all the fields
of the socket? Like:

  (gdb)  p *(struct tcp_sock*) some_hex_address_goes_here

?

If so, that could be useful in extracting further hints about what
state this socket is in.

If that's not possible, but a few extra fields are possible, would you
be able to pull out the following:

tp->retrans_stamp
tp->tcp_mstamp
icsk->icsk_retransmits
icsk->icsk_backoff
icsk->icsk_rto

thanks,
neal

