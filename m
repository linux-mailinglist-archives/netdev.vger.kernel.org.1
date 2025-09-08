Return-Path: <netdev+bounces-220924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E19B4978F
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 19:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7271BC0483
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA460310655;
	Mon,  8 Sep 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IT0pqtWZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2852FF645;
	Mon,  8 Sep 2025 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353877; cv=none; b=iAuIPt1QnsCksuoc5cdy8UAycpdch7vbdMnvrS2LxZgxug+xlZiLEC0YlQMyvMMCxMH1F1v5oZf5q1pExmBxXWMgfG1kUlA1gpOBb1C0dMcVlSHFEITTBwDWASCLnpjq8c2l+2W/h3UNFAD2dJnstfWJzutAp+wjGwV5DX1NAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353877; c=relaxed/simple;
	bh=/68Vf5FmSeABGxyVIZA6ZD2EBfHh21e0TSDOnBtrOIY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VGBKCQK8DJIp/ffkfs0RMuM2uorBefx1AWdPwo5DyvjXU99+qtOqtuJMvrW24E6e9G834ZHdB0B+rOuaANngQmqwRlPHuhN3FMsBzzoOJTToiYt6tenAqAFy12wYByPYLJLNSFLG+0+6cjF6tg+hzF5fF1rIn32W/SfkRlz93K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IT0pqtWZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8D2C4CEF1;
	Mon,  8 Sep 2025 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757353877;
	bh=/68Vf5FmSeABGxyVIZA6ZD2EBfHh21e0TSDOnBtrOIY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IT0pqtWZXZrHwPrx13d5+UfrPkFSEvmPcCAmcf1sXnHxp1UswCcmV/FPq0/kKBqi4
	 mY1r+i9/3dD7cGaJ5fXZrbO9oVQhXho3xjDb60xWpFES9s3W6fIfGzkY04XVM/Lciw
	 9xtbUoc7gxCKOLTCHzJdpXoRPJYdjgdhQ5bJsXHHTpZp+TU97ucBBXxGnPmH60Hsxo
	 RZYn3bWiFPsyx9MfIYvLSn4mMmX+O15ry4D6E+iJzfPxFgoLQGBFl11+6oDhIQEz72
	 GZmNmrQGRd3LIuILi+aiYWF0DTaCvsl9xFBav7eAjqjvuGeBpAABPWTqq4ntGSjzvL
	 y8MkFqg3mFizQ==
Date: Mon, 8 Sep 2025 19:51:10 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: Geliang Tang <geliang@kernel.org>, Mat Martineau <martineau@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Reaver <me@davidreaver.com>
Message-ID: <575893ce-11a8-492f-ac8c-5995b3e90c76@kernel.org>
In-Reply-To: <aL8WNpl8ExODg20q@templeofstupid.com>
References: <aLuDmBsgC7wVNV1J@templeofstupid.com> <ab6ff5d8-2ef1-44de-b6db-8174795028a1@kernel.org> <83191d507b7bc9b0693568c2848319932e6b974e.camel@kernel.org> <78d4a7b8-8025-493a-805c-a4c5d26836a8@kernel.org> <aL8RoSniweGJgm3h@templeofstupid.com> <23a66a02-7de9-40c5-995d-e701cb192f8b@kernel.org> <aL8WNpl8ExODg20q@templeofstupid.com>
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
X-Correlation-ID: <575893ce-11a8-492f-ac8c-5995b3e90c76@kernel.org>

8 Sept 2025 19:45:32 Krister Johansen <kjlx@templeofstupid.com>:

> On Mon, Sep 08, 2025 at 07:31:43PM +0200, Matthieu Baerts wrote:
>> Hi Krister,
>>
>> On 08/09/2025 19:25, Krister Johansen wrote:
>>> On Mon, Sep 08, 2025 at 07:13:12PM +0200, Matthieu Baerts wrote:
>>>> Hi Geliang,
>>>>
>>>> On 07/09/2025 02:51, Geliang Tang wrote:
>>>>> Hi Matt,
>>>>>
>>>>> On Sat, 2025-09-06 at 15:26 +0200, Matthieu Baerts wrote:
>>>>>> =E2=80=A6
>>>>>
>>>>> nit:
>>>>>
>>>>> I just noticed his patch breaks 'Reverse X-Mas Tree' order in
>>>>> sync_socket_options(). If you think any changes are needed, please
>>>>> update this when you re-send it.
>>>>
>>>> Sure, I can do the modification and send it with other fixes we have.
>>>
>>> Thanks for the reviews, Geliang and Matt.=C2=A0 If you'd like me to fix=
 the
>>> formatting up and send a v2, I'm happy to do that as well.=C2=A0 Just l=
et me
>>> know.
>>
>> I was going to apply this diff:
>>
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index 13108e9f982b..2abe6f1e9940 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -1532,11 +1532,12 @@ static void sync_socket_options(struct mptcp_so=
ck *msk, struct sock *ssk)
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static const unsigned int tx=
_rx_locks =3D SOCK_RCVBUF_LOCK | SOCK_SNDBUF_LOCK;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sock *sk =3D (struct =
sock *)msk;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int kaval =3D !!sock_flag(sk, SOC=
K_KEEPOPEN);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool keep_open;
>>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keep_open =3D sock_flag(sk, SOCK_=
KEEPOPEN);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ssk->sk_prot->keepalive)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ssk->sk_prot->keepalive(ssk, kaval);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_valbool_flag(ssk, SOCK_KEEPO=
PEN, kaval);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ssk->sk_prot->keepalive(ssk, keep_open);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sock_valbool_flag(ssk, SOCK_KEEPO=
PEN, keep_open);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssk->sk_priority =3D sk->sk_=
priority;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ssk->sk_bound_dev_if =3D sk-=
>sk_bound_dev_if;
>>
>> (sock_flag() returns a bool, and 'keep_open' is maybe clearer)
>>
>> But up to you, I really don't mind if you prefer to send the v2 by
>> yourself, just let me know.
>
> Thanks, I'll go ahead and amend as you suggest and then send a v2.

Great, thanks.

While at it, please use [PATCH net] as prefix.

Cheers,
Matt

