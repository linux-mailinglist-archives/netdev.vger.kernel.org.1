Return-Path: <netdev+bounces-193703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AEAC5256
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A618A009A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3127605C;
	Tue, 27 May 2025 15:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3487A27A900
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361058; cv=none; b=rHxGkSSULClrcCp3C4qFa1F0cbFnpkF2/fhXcS1d7it03S4ZUs4fWI+JJuoQ/dETgCON3+OoA3966t4mTpkeeD0cuZ/gO1Sxw3p44NNf84/TVOfqEvbJy3/CdPxg9yhSICbDUJcZFsq6SfWnLVdGEmts8xoROaW/4f5QbrC1OhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361058; c=relaxed/simple;
	bh=svLWGwtnrk4uTIapLdmYazY0GEwWdOHDqlaHXcaF7hg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=H87MJj+SBESwqwW+YrSKfgcyh3gSaLNWtR1oIVF1QVJcqhMMpJfcNSkKtJ0kK6N+sofiKACXZBUda9pb94Om5H/91biPqXS3KMoQLEycDn4sYUeCxImYetxnRf/29OzDJJfG+7h/xPKgg5uu3AG9XqT492o+Fd6SUgVxfqiR26U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz6t1748361025tbf4663a4
X-QQ-Originating-IP: OkawEGDu22bcBp+pmgv6q7pSue99Oojd8Y04FYIL9Bo=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 May 2025 23:50:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2160860764936470932
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH RESEND net-next v5 3/4] net: bonding: send peer notify
 when failure recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <68c3346d-98c4-409a-a772-4f8fe31be57b@redhat.com>
Date: Tue, 27 May 2025 23:50:12 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B4578A87-C93A-4F63-980A-E84E60F04CE8@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
 <20250522085516.16355-4-tonghao@bamaicloud.com>
 <8865be45-e3a8-479e-b98a-b06e5ed6ee65@redhat.com>
 <68c3346d-98c4-409a-a772-4f8fe31be57b@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NpzNf8JHXbEImE6TotZ42x3sJNPKKxUEhDoru/DLuWmYfLVWHILPJ2BA
	asSv7T9lNlsXWtbcpKn5BvPLSIRmbLVdOcL5eWTKD57UqEWIt68rHhiacf2dzh/qxbTF2Mq
	xEkF5krkBXNj52TCcFXWsXq68TK5GvZi70yav7h30JKVDOVsaKBmjGaVzu+s5XazDmDhGeC
	6mKTlO7dsF/ykSpsWZLWQPkYlty/2Y9t5mK58qx/xGD9s+cFW6z20A511oNmg+4Y7t5vAb2
	/LrUKzw/yUbbUTaBtkVkxYaJAh8ErH3+K/FTQqyV3lVsbEu2IL1SDYFfhqKcpb2zDZrAEoX
	AudecNiyJqSxMjgWTrIV5RNF0i4yrv4BHR0NXZb8bLGXab3TkRA0KgnS7u/0CTWpDFvd0YF
	MMMj5XxpH0AyFq0aXQE9wwagOYPjGTqcR6lX+FY//06WydYdvZVn68lHJAHQJflvIL+lJTX
	w2FH50dAVUYkBNRMa1/R8q/PYV+J8QQLUdApFOHCh9tC44LbH3Xi4VhR4iMsYyTw0L+uVEj
	rsRFBIbe4hRHrlMa0s4DXHf157ZUR1vz38qBMgUon4eZscFqEbkq4Sgg13mLwfDGGFFYhr7
	9Lj3QFJAea3UqaXDscKIrpQ7HeZgyrxZWiRpxCFNBeXBhGCy020xHTDOehh5F47JdbHAW3O
	+n6MiBDHwlL4ldC/N5R4dL/XHJI3/nEkFFtFzMjZ9YrfKo2UO2L3UhQfaCdsuAud1lvBEYj
	UUKdgF+sA6qVwQP1bzlEasAzdv7MIXifKOF/Jdgv5LdB8KdyrkIdIbQE0xP/w/BsxRMNrE3
	2I1YKH+ylm2P9V8Mv8z4hGrZsdL85G8XGVkdKP3uOu44nhfer+ZNCy8zx/63bQJsxs3hreD
	XqwFBiS4KbQ1LT2S0m9kth8ErtnE7qhjEiGrgieaRysQrVdqYEiEurqNz9+Ed4wid4/eX9s
	t8szVm9ooTAONQFW+pm3MXasJl4b8RXI5E0VVGu25IRJD4/vuceUbyHW6
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8827=E6=97=A5 22:13=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> 5/27/25 4:09 PM, Paolo Abeni wrote:
>> On 5/22/25 10:55 AM, Tonghao Zhang wrote:
>>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>>> index b5c34d7f126c..7f03ca9bcbba 100644
>>> --- a/drivers/net/bonding/bond_main.c
>>> +++ b/drivers/net/bonding/bond_main.c
>>> @@ -1242,17 +1242,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>>> /* must be called in RCU critical section or with RTNL held */
>>> static bool bond_should_notify_peers(struct bonding *bond)
>>> {
>>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>>> + struct bond_up_slave *usable;
>>> + struct slave *slave =3D NULL;
>>>=20
>>> - if (!slave || !bond->send_peer_notif ||
>>> + if (!bond->send_peer_notif ||
>>>     bond->send_peer_notif %
>>>     max(1, bond->params.peer_notif_delay) !=3D 0 ||
>>> -     !netif_carrier_ok(bond->dev) ||
>>> -     test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>>> +     !netif_carrier_ok(bond->dev))
>>> return false;
>>>=20
>>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>>> + usable =3D rcu_dereference_rtnl(bond->usable_slaves);
>>> + if (!usable || !READ_ONCE(usable->count))
>>> + return false;
>>=20
>> The above unconditionally changes the current behavior for
>> BOND_MODE_8023AD regardless of the `broadcast_neighbor` value. Why =
the
>> new behavior is not conditioned by broadcast_neighbor =3D=3D true?
>=20
> Not strictly related to this patch, but as a new feature this deserve =
an
> additional test-case.
Ok
>=20
> Note that the series is not threaded correctly in PW - the cover =
letter
> does not belong to this thread. Please adjust that, thanks!
Ok
>=20
> Paolo



