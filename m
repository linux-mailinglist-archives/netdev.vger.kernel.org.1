Return-Path: <netdev+bounces-220939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91685B49801
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 20:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96B5E443020
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402ED31579B;
	Mon,  8 Sep 2025 18:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvDMTEzV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FF314A7E;
	Mon,  8 Sep 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355149; cv=none; b=ZBvSvO/xq8nknqAIwVT9v8nZMVkMfrmWSspWRbrH9qijR+KOWsUHwlznE/RdtktvLHfYtJUotrUa9bX2L6iARrfhd0oyF+mN4P3kzMGFX77+HHGFCvUpqbkjNfpfiqcgJKOuIfULsZSqiUXnCODwNMHi7m/gPqMHj1MpKImmJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355149; c=relaxed/simple;
	bh=55uqEUrkSEH/g4S8O0Ls9N9ERmewReSvw0qIJ321yHU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XqD46iAUC7wRs4LIGNvAjyt7FnaH73H6BlPmuPGDH4oMxvsGP4Z5wVtDktPT/F+euEGqzt3it6trKrdPL92wsmJE9IsI43dVmLPhKm2i2sVoPyAfl9/oyuoOId8WcNnriJSXZ3EAl7fflptvmksK1+DQjtTwG6uju5BBFFqMyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvDMTEzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8F5C4CEF1;
	Mon,  8 Sep 2025 18:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757355148;
	bh=55uqEUrkSEH/g4S8O0Ls9N9ERmewReSvw0qIJ321yHU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YvDMTEzVGTF5aOsROaBtp3Tmo4Glys448tT3SXnuYhwcVCrj85Jj3u/+YXw2Tq5Fe
	 WWOSvpNdpbzhZKSvjC/LnOK2eO4EyFQ6DbvKqhXldkKzhHPXIYfRS00afuK39tfwok
	 zlK3iZYaW5S8XvN3V0Az2kAcmAsAz/hdTN9pxIH/UKONDyrn42iEor9GNYk0+Qqeno
	 uyNq1i3bwhij4DAY3MACsbXLq0wM8Ndn3opjNh6va2d1a+y1/7pNkrRqnAi+0+g1aj
	 XnR7YTot90CDo3xSLZiWSrP425GVBHaQ9mEpWy8S72iQnZtS7zT5hhYyERZhWyVNjK
	 9vUKysO8MOSBQ==
Date: Mon, 8 Sep 2025 20:12:21 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Reaver <me@davidreaver.com>
Message-ID: <01f13d40-93c4-4147-b10d-f86fd5f79fa5@kernel.org>
In-Reply-To: <aL8YwEx1dxa93lpR@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com> <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org> <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org> <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org> <aL8RoSniweGJgm3h@templeofstupid.com> <23a66a02-7de9-40c5-995d-e701cb192f8b@kernel.org> <aL8WNpl8ExODg20q@templeofstupid.com> <575893ce-11a8-492f-ac8c-5995b3e90c76@kernel.org> <aL8YwEx1dxa93lpR@templeofstupid.com>
Subject: Re: [PATCH mptcp] mptcp: sockopt: make sync_socket_options
 propagate SOCK_KEEPOPEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <01f13d40-93c4-4147-b10d-f86fd5f79fa5@kernel.org>

8 Sept 2025 19:56:23 Krister Johansen <kjlx@templeofstupid.com>:

> On Mon, Sep 08, 2025 at 07:51:10PM +0200, Matthieu Baerts wrote:
>> 8 Sept 2025 19:45:32 Krister Johansen <kjlx@templeofstupid.com>:
>>
>>> On Mon, Sep 08, 2025 at 07:31:43PM +0200, Matthieu Baerts wrote:
>>>> Hi Krister,
>>>>
>>>> On 08/09/2025 19:25, Krister Johansen wrote:
>>>>> On Mon, Sep 08, 2025 at 07:13:12PM +0200, Matthieu Baerts wrote:
>>>>>> =E2=80=A6
>>>>>
>>>>> Thanks for the reviews, Geliang and Matt.=C2=A0 If you'd like me to f=
ix the
>>>>> formatting up and send a v2, I'm happy to do that as well.=C2=A0 Just=
 let me
>>>>> know.
>>>>
>>>> I was going to apply this diff:
>>>>
>>>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>>>> index 13108e9f982b..2abe6f1e9940 100644
>>>>> --- a/net/mptcp/sockopt.c
>>>>> +++ b/net/mptcp/sockopt.c
>>>>> @@ -1532,11 +1532,12 @@ static void sync_socket_options(struct mptcp_=
sock *msk, struct sock *ssk)
>>>>> {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static const unsigned int =
tx_rx_locks =3D SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sock *sk =3D (struc=
t sock *)msk;
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int kaval =3D !!sock_flag(sk, S=
OCK_KEEPOPEN);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool keep_open;
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keep_open =3D sock_flag(sk, SOC=
K_KEEPOPEN);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ssk->sk_prot->keepaliv=
e)
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ssk->sk_prot->keepalive(ssk, kaval);
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_valbool_flag(ssk, SOCK_KEE=
POPEN, kaval);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ssk->sk_prot->keepalive(ssk, keep_open);
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_valbool_flag(ssk, SOCK_KEE=
POPEN, keep_open);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssk->sk_priority =3D sk->s=
k_priority;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssk->sk_bound_dev_if =3D s=
k->sk_bound_dev_if;
>>>>
>>>> (sock_flag() returns a bool, and 'keep_open' is maybe clearer)
>>>>
>>>> But up to you, I really don't mind if you prefer to send the v2 by
>>>> yourself, just let me know.
>>>
>>> Thanks, I'll go ahead and amend as you suggest and then send a v2.
>>
>> Great, thanks.
>>
>> While at it, please use [PATCH net] as prefix.
>
> Thanks, will do.=C2=A0 May I preserve the Reveiwed-By tags from the v1, o=
r
> would you like to review again?

You can preserve it.

Cheers,
Matt

