Return-Path: <netdev+bounces-172401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA62A54786
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546AB7A3360
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D7016088F;
	Thu,  6 Mar 2025 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qyxkpxqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A983619DF49
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256187; cv=none; b=jOzlLiJWx+aXeOZ0r12HrXALyKYtsDjnG5zxQfBCjjV5L9VWLPHAFgeRBvoiWNgPFtDxRg9TXRKntYAZUephMd6goo+qD6dVJSqYCnESDVsEzBZvXo7iK1Jplic/g4+5FEqY1mRUjH9A2mscMVGNV5ibUNdTzUst09+vyxYJvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256187; c=relaxed/simple;
	bh=zJOxIERmDv9lRPIRZxu/dcgTaemp0XEgJ4ApfDIrvI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSKT/bq6L/ERtatbzqZ+rmvbHPkVHiJYtkZOS8XBiw0zMatnZT+1chqpgPftpk8gD7QWjSwOvjDOy/ro1b3BZmvJf5h3yKObVqPkovKHaW2vqOxxLT1hG3lPPWs4SUERgTPJTskml6UsAy4Ftje2kYVmpI5ZrqNULnKwjOKFh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qyxkpxqo; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08fc20194so80190385a.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741256184; x=1741860984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQt/BfhTxYuS+EBnPleIhhn/3jC1g/esNWyydIaIFe8=;
        b=QyxkpxqoYynHIudiWnGj9BY4lgnq3aCPSbW/Y2LrEzeP2IoUkR3fyyylZFqi/+FDYL
         9O+l3NBlbpOz28pH9HTCeus7dDoNwPmaiOchHm+MM45D4c79aYRDrqY1EDZ71JZ7TfZP
         3j7t57ArR8d++9YSWShCiFS8tavmXhzcYw5bgm477lfKkv+CtMIlrKu5pRYi2/Lv9Vb2
         8P2YwP7OU3fsT6kSQDBNZ0ZKJlCJ1M19fK0/qag3aj9TxG//WSsVMgGgT8qB0vdLcznc
         p2dpnDH4qEw7LY5DmhnOzpcww6hVi2bu2EhAU4/gpKwwB/hoNZbXm26KsipwiVkT6QBy
         Bbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256184; x=1741860984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQt/BfhTxYuS+EBnPleIhhn/3jC1g/esNWyydIaIFe8=;
        b=hQrINfBdNE/MnfJyHHG1gt6kHL8cTtH/ipvBQiVycWxm1GZA2CZMV96m92omjHGH45
         UKlAsw53rSz9efhBA9t0IqoZv/MruORzrezlo5Aa3o3BIx20r05+f/tfMLpn7hnB/WCW
         +cFE0CoRngi0jAJs8+jzcu5ZUHVZTJTEX7dIG/qPSQJl6VnWd+3EDsxhVYfUoFPbAf1q
         btNfobuhoIT2PPS39Ho1mBC6VzKf5BIogZPahKFuVULpSLLt2W3clY83gjhZU/ytJBAz
         lw92UtORZbwpkoOFE2SxmiFRjojYZ39gtxa84qaRCxonXTOTpb8ToDBbZKInUP/NIeSL
         K/VA==
X-Forwarded-Encrypted: i=1; AJvYcCXdPL8sCJlmgInNggcJGh5pRS9/kt0Y+0IaAMAamrGNfyIPd+eZVfJMxLnY9gZpILpgobZ8RM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50k0qO8IRwVIuQcdlT6es2BfFgFe9o4uIEsnqLA7J8ktqPbGM
	yJChsNnAxn7FyngTywVnPYXqSojjaYgZyQU/dwgM0QGfa8R+ws4CTUCVUSsCyIJLeSFIHD6BZZF
	q7eUjUZEjn1rqxRp9kTgME4gdVZ1YRLQ3o+30
X-Gm-Gg: ASbGnctUR9OY91/4CmelTsO7RPTrZPKbo4jLe/a5xxeAvAQ/2dDGXyF8C18ozWQB9m9
	Ynn/2WV4xPv2E04kd43GUDkIpHgy6fCS8chbNbhgUMLkWs/TRjmQcARTiDhydQpfQd2IFAdUJFz
	IB/74bWFntiHKuZ2aJRBLo/tF+m7A=
X-Google-Smtp-Source: AGHT+IFIyxpUjrd9WxdFyirbhUezvLRXpmbvDGuaJZtrUstaXDaMXQa7ztzPLXzThpEXAVbrrXxOHf4f/xYzmK4dxMU=
X-Received: by 2002:ad4:5aae:0:b0:6e8:f60b:9396 with SMTP id
 6a1803df08f44-6e8f60b96cemr21205236d6.29.1741256184340; Thu, 06 Mar 2025
 02:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
 <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
 <281edb3a-4679-4c75-9192-a5f0ef6952ea@kernel.org> <CANn89iKVsDrL9YFx883wTfRSAe6tOR7x2U5zk=TcgHBMr+VtkQ@mail.gmail.com>
 <a3266974-d561-4e8f-a23a-9c0774ee2bbe@kernel.org>
In-Reply-To: <a3266974-d561-4e8f-a23a-9c0774ee2bbe@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 11:16:13 +0100
X-Gm-Features: AQ5f1Jqiuu0ZT24oat4cYsDxkIEWiPGyUJLvby7DpzG1svevab4S2cjJEd9IEXk
Message-ID: <CANn89iJ4DyC8OSEA2Qn3WhWHAUr9Bpo_ZmJdcx3ofM-qKvEU=g@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jason Xing <kerneljasonxing@gmail.com>, mptcp@lists.linux.dev, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:12=E2=80=AFAM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> On 06/03/2025 11:02, Eric Dumazet wrote:
> > On Thu, Mar 6, 2025 at 10:55=E2=80=AFAM Matthieu Baerts <matttbe@kernel=
.org> wrote:
> >>
> >> Hi Eric,
> >>
> >> On 06/03/2025 10:45, Eric Dumazet wrote:
> >>> On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> >>>>
> >>>> On Wed, Mar 5, 2025 at 10:49=E2=80=AFPM Matthieu Baerts (NGI0)
> >>>> <matttbe@kernel.org> wrote:
> >>>>>
> >>>>> A recent cleanup changed the behaviour of tcp_set_window_clamp(). T=
his
> >>>>> looks unintentional, and affects MPTCP selftests, e.g. some tests
> >>>>> re-establishing a connection after a disconnect are now unstable.
> >>>>>
> >>>>> Before the cleanup, this operation was done:
> >>>>>
> >>>>>   new_rcv_ssthresh =3D min(tp->rcv_wnd, new_window_clamp);
> >>>>>   tp->rcv_ssthresh =3D max(new_rcv_ssthresh, tp->rcv_ssthresh);
> >>>>>
> >>>>> The cleanup used the 'clamp' macro which takes 3 arguments -- value=
,
> >>>>> lowest, and highest -- and returns a value between the lowest and t=
he
> >>>>> highest allowable values. This then assumes ...
> >>>>>
> >>>>>   lowest (rcv_ssthresh) <=3D highest (rcv_wnd)
> >>>>>
> >>>>> ... which doesn't seem to be always the case here according to the =
MPTCP
> >>>>> selftests, even when running them without MPTCP, but only TCP.
> >>>>>
> >>>>> For example, when we have ...
> >>>>>
> >>>>>   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
> >>>>>
> >>>>> ... before the cleanup, the rcv_ssthresh was not changed, while aft=
er
> >>>>> the cleanup, it is lowered down to rcv_wnd (highest).
> >>>>>
> >>>>> During a simple test with TCP, here are the values I observed:
> >>>>>
> >>>>>   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
> >>>>>       117760   (out)         65495         <  65536
> >>>>>       128512   (out)         109595        >  80256  =3D> lo > hi
> >>>>>       1184975  (out)         328987        <  329088
> >>>>>
> >>>>>       113664   (out)         65483         <  65536
> >>>>>       117760   (out)         110968        <  110976
> >>>>>       129024   (out)         116527        >  109696 =3D> lo > hi
> >>>>>
> >>>>> Here, we can see that it is not that rare to have rcv_ssthresh (lo)
> >>>>> higher than rcv_wnd (hi), so having a different behaviour when the
> >>>>> clamp() macro is used, even without MPTCP.
> >>>>>
> >>>>> Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_w=
nd)
> >>>>> here, which seems to be generally the case in my tests with small
> >>>>> connections.
> >>>>>
> >>>>> I then suggests reverting this part, not to change the behaviour.
> >>>>>
> >>>>> Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
> >>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
> >>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >>>>
> >>>> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> >>>>
> >>>> Thanks for catching this. I should have done more tests :(
> >>>>
> >>>> Now I use netperf with TCP_CRR to test loopback and easily see the
> >>>> case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
> >>>> tp->rcv_wnd is not the upper bound as you said.
> >>>>
> >>>> Thanks,
> >>>> Jason
> >>>>
> >>>
> >>> Patch looks fine to me but all our tests are passing with the current=
 kernel,
> >>> and I was not able to trigger the condition.
> >>
> >> Thank you for having looked at this patch!
> >>
> >>
> >>> Can you share what precise test you did ?
> >>
> >> To be able to get a situation where "rcv_ssthresh > rcv_wnd", I simply
> >> executed MPTCP Connect selftest. You can also force creating TCP only
> >> connections with '-tt', e.g.
> >>
> >>   ./mptcp_connect.sh -tt
> >
> > I was asking Jason about TCP tests. He mentioned TCP_CRR
>
> Oops, I'm sorry, I didn't look at the "To:" field.
>
> > I made several of them, with temporary debug in the kernel that did
> > not show the issue.
> >
> >
> > I am wondering if this could hide an issue in MPTCP ?
> Indeed, I was wondering the same thing. I didn't see anything obvious
> when looking at this issue. The behaviours around the window clamping,
> with MPTCP single flow, and "plain" TCP were quite similar I think.

OK, let me run mptcp tests just in case I see something dubious.

