Return-Path: <netdev+bounces-67226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507C842681
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 14:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258A01F280B2
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497D6D1B3;
	Tue, 30 Jan 2024 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="gSlLWKsj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D326BB32
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622895; cv=none; b=ePVfGUWYtTJavvDhQBBQw/+O2YJ2fX9ENT4ldY+zW57zo6XwJcXIOuNVALTI1EUbE9CrUJYWmshHR1Ak8gpmXAF0ZBoQisbkWgsc8fvyUfPQCrQN6aV/rDOAIrelVaFbozgvrwbM62JYOumiPIxMBgOK1AP0dAFGGK0aPs+ICrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622895; c=relaxed/simple;
	bh=U10tuv+WPsklBb7335hr9jHD5g4neTwr06eiTA7jkdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sY+wtbOvkpZFVBgo2iH+iyZPG0lGePt6Jsx0LKwE0MZW4WD+iPAVl4wqed/CtnVKLgfHfOEL9xz0zBWPaas4GkZOZWxwuWvZmXim2hLyGQgL1lrGL7kU/eFhWrqtoBeH6t6aqhOTfD2k1+4/eEMRFByAZlM7a7UGK3Jn4+v/mRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=gSlLWKsj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55790581457so4704147a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 05:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1706622891; x=1707227691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb1um7FdYT71IUN7olrnp47vwYePafDXUwZ19SYtHl8=;
        b=gSlLWKsja2CFqjm25RqUS0DYoTa6SgfvwCeKi1M5WetskTlw7l/NvgI3SetfxAlqKO
         K5ijtNWftOAokBKyrU0Tjgvdn2gYaHFcv1bTEJwYs80mfFv9/jPCBlt/oMWhzCxBHv27
         XMF4pUSf6ToO3s31TrXFcB++MoZuOtTU6iIt6bMOjUiV1KD4rXRNmDVZhwqtGTkvOGm0
         Z/l/U2FJzFFJkRg2JgewN9uyTf2Z0YvYjNMVkIYJnUydLNNtm4V+ylRbm6nnINu0bYN1
         D4/blczxE3bLFv3TxYz3vYjlHDJRyRwzYZuty/+jfPyBtrsYau3BKXC8lIiTgRWEjrzw
         siiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622891; x=1707227691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb1um7FdYT71IUN7olrnp47vwYePafDXUwZ19SYtHl8=;
        b=EPgHwfYNlb8ZzSp7cMk5Y521VdZTAmdpVQAMu8v6pKpg/Zh0l4qofNZNsSFkCs/q5p
         eVypG+jnNkdvk/o0KPb+WTTnkHwN7wJvLPtvYSIrF1+AMaqQ9qqc/hS7Q9S8lQ4jikF8
         zXxYYWImsPBIatxN8COYyM4MVMnLW64ouEKUnj55OrmOmf21d78ONhkdaOam75PVzO2R
         DBPGz0VO34Be5d34hao3d0sVZTaTgjpkfAr0fds40Hg8OQeLEKo25D6U5jAITxES12iW
         dtq7uGeJbs7mS3eF8luULu2YOohzCQdDK4/Dcr1LhzX86BIhmNVbafn6KuDwiI9XOpWn
         54gw==
X-Gm-Message-State: AOJu0YwxOYCVKY8MMQ9Vb70WDXUO08Ns01fViLxJ681SWKKhn/Szb2uA
	7AiCbUSdnze9WX//cRaxmuWdeGx2eA8ANRdBJJskZugiMfvRtf3yzcdEUiSqTmM2on4zaVWiKWU
	rsVvjTUL1b6qkefrYFiu/yzmKor7NdVqauTvTc6DtnXDmnuRmPpg=
X-Google-Smtp-Source: AGHT+IGah0gwExmXOKJkiq+0usEeQAIxrgamsZLFpjV85eaECDz4pi1Fn7O2/v7SYtl2NQQsdyMOkZdI8mIqt5X+/2s=
X-Received: by 2002:a17:906:e52:b0:a35:8596:cdc7 with SMTP id
 q18-20020a1709060e5200b00a358596cdc7mr5317666eji.31.1706622891100; Tue, 30
 Jan 2024 05:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com>
 <87y1cb28tg.fsf@toke.dk> <CAJEV1igULtS-e0sBd3G=P1AHr8nqTd3kT+0xc8BL2vAfDM_TuA@mail.gmail.com>
 <20240126203916.1e5c2eee@kernel.org> <CAJEV1igqV-Yb3YvZEiMOBCGyZXRQ2KTS=yq483+xOVFehvgDAw@mail.gmail.com>
 <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
In-Reply-To: <CAJEV1ij=K5Xi5LtpH7SHXLxve+JqMWhimdF50Ddy99G0E9dj_Q@mail.gmail.com>
From: Pavel Vazharov <pavel@x3me.net>
Date: Tue, 30 Jan 2024 15:54:40 +0200
Message-ID: <CAJEV1igHVsqmk0ctxb-9gM2+PLs_gvpE1fyZwoASgv+jYXOcmg@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Sat, Jan 27, 2024 at 7:08=E2=80=AFAM Pavel Vazharov <pavel@x3me.net> w=
rote:
>>
>> On Sat, Jan 27, 2024 at 6:39=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
>> >
>> > On Sat, 27 Jan 2024 05:58:55 +0200 Pavel Vazharov wrote:
>> > > > Well, it will be up to your application to ensure that it is not. =
The
>> > > > XDP program will run before the stack sees the LACP management tra=
ffic,
>> > > > so you will have to take some measure to ensure that any such mana=
gement
>> > > > traffic gets routed to the stack instead of to the DPDK applicatio=
n. My
>> > > > immediate guess would be that this is the cause of those warnings?
>> > >
>> > > Thank you for the response.
>> > > I already checked the XDP program.
>> > > It redirects particular pools of IPv4 (TCP or UDP) traffic to the ap=
plication.
>> > > Everything else is passed to the Linux kernel.
>> > > However, I'll check it again. Just to be sure.
>> >
>> > What device driver are you using, if you don't mind sharing?
>> > The pass thru code path may be much less well tested in AF_XDP
>> > drivers.
>> These are the kernel version and the drivers for the 3 ports in the
>> above bonding.
>> ~# uname -a
>> Linux 6.3.2 #1 SMP Wed May 17 08:17:50 UTC 2023 x86_64 GNU/Linux
>> ~# lspci -v | grep -A 16 -e 1b:00.0 -e 3b:00.0 -e 5e:00.0
>> 1b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>> SFI/SFP+ Network Connection (rev 01)
>>        ...
>>         Kernel driver in use: ixgbe
>> --
>> 3b:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>> SFI/SFP+ Network Connection (rev 01)
>>         ...
>>         Kernel driver in use: ixgbe
>> --
>> 5e:00.0 Ethernet controller: Intel Corporation 82599ES 10-Gigabit
>> SFI/SFP+ Network Connection (rev 01)
>>         ...
>>         Kernel driver in use: ixgbe
>>
>> I think they should be well supported, right?
>> So far, it seems that the present usage scenario should work and the
>> problem is somewhere in my code.
>> I'll double check it again and try to simplify everything in order to
>> pinpoint the problem.
I've managed to pinpoint that forcing the copying of the packets
between the kernel and the user space
(XDP_COPY) fixes the issue with the malformed LACPDUs and the not
working bonding.

