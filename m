Return-Path: <netdev+bounces-256216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGQwKC++gWm7JAMAu9opvQ
	(envelope-from <netdev+bounces-256216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B98FBD6BC4
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA6BD3007B1F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2499396D2A;
	Tue,  3 Feb 2026 09:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="JZuToZBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h9WuaJSc"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9428285C91
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110499; cv=none; b=ZQV6NrCYzFqHL8h5lMfw8jseH2ig91i+rB/hBPJzCbdOR+lLq0F/anXdv8NS+9C1ASgZwafzhAVmaebHD4rV+gJPsJjxO1dfntMOTSho/bxSwsLrSZZxZliwLRuVKjgJpyTSZU/OchGK7GzBczzw3zU35ODIeGFIe7SH/LS8LCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110499; c=relaxed/simple;
	bh=0jde5CFghNAu7uERR/9qGvtypksjazu8lZO8WvnobzE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cWnLqvPKGPzxksQ+dK+Xo/hAr6tCQkbTUgqpEJdUUeXeDBe4G/RSDpjTPrt/qNTFyfuf8L2x6UZqpcBZLOhMKbQ1i6MJ5S4PLU1FaqmiHpS+KKAj+P4sJOzmGnrdAwK2nzKblATur1ApKHRx6u3eoFn8NDg3qe3QDorDSntnWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=JZuToZBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h9WuaJSc; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 95AC91D00010;
	Tue,  3 Feb 2026 04:21:36 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-10.internal (MEProxy); Tue, 03 Feb 2026 04:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770110496;
	 x=1770196896; bh=0jde5CFghNAu7uERR/9qGvtypksjazu8lZO8WvnobzE=; b=
	JZuToZBJ24x6lagHRxZm1K66WJRzPBSUul/pgci25vJmMOr7c8Qd78RgE7eTzhJV
	ijuIAv3kja5zjKLg1AimKgtzNZq86x9P7yM/KLNiPSXr0FlwjlcJTgoIGUjBeOhd
	ogI8etbfS6kiZYrrBjSToXzilZ45RP2rSDQCyQDvaxho5JiFYgw9dCPjzD0IoONW
	WII1cRP3gKcpL6DlcLIlxGbqxb5JDaD1B69eriJsI+ud09BbFiC0k4AGkEmyo3Ou
	6jOHBaZWeA1UPiQiMmUxwKN+2VXWdJMmuskBkP1i3YY6vRzk9FbKxaz0/7kW80o0
	fbZ0pNUp5PV+LPVpXSA1Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770110496; x=
	1770196896; bh=0jde5CFghNAu7uERR/9qGvtypksjazu8lZO8WvnobzE=; b=h
	9WuaJScfgfLA6RTu1sTySoyvHpDFjV85Cy8pjvpyf9iRhEdcqL3jsR9s8ndLvoPt
	hCoG7NBy7EXgZYoo2G1QJfG6uTAzRsudzfiP61JNKAF5LeGhfFPIX0e5WRJ+fOLE
	xW/captOVG9P2gDOMK4mj3KauznqDinregqox+Ql8GmR2nMre3rOuhovp4K5g+9V
	50ZfcnszEoaUdqrqJDigLGzoGS9mdBq5uIdV7UFNqRE4MnLGfJHX55hHG4jmZ3uw
	M4qZEt0lvUuqEzWrhlUbEZ6IuctPwCy7uEADNpEB9LnaX8k/X0tX0VFuVIazsTHF
	NgzVKtHkSaiPv6PeO8m2Q==
X-ME-Sender: <xms:H76Baa6UWfki9sFa2EHANuK4qUMn-2pC3F5TogbDuS4yYQchTS7NtQ>
    <xme:H76Baet1r3a5a7EqxrHNV0TIpdbKPS0Rdo0sIERDmv7bzt3qxpJl7qycVGMhTzVlN
    3lGj_okk2Zbb2mfJU6zrA_4jDPjdCehes7sG8G-vFueOGtUaHr4z7YC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeelleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehlihgt
    vgcuofhikhhithihrghnshhkrgdfuceorghlihgtvgdrkhgvrhhnvghlsehfrghsthhmrg
    hilhdrihhmqeenucggtffrrghtthgvrhhnpedvieevheffudffhfefvdfhfeekveelueet
    gfelgfeigefhheegfeeifeehteevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrlhhitggvrdhkvghrnhgvlhesfhgrshhtmhgrihhlrdhi
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    ifsegurghvihgufigvihdruhhkpdhrtghpthhtohepthhtohhukhgrnhdrlhhinhhugies
    ghhmrghilhdrtghomhdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnh
    gvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgr
    lhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepthgrrhhiqhhtsehnvhhiughirgdrtg
    homhdprhgtphhtthhopeifihhtuhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepnhgv
    thguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H76BaTOCZi10p8xAe1_x67H0qgINSAHF9rs3gLq6BWW7ZLb_zfqWmg>
    <xmx:H76BaX9fjCPdumDGS_Vis9jPuCNwJEQNIDLQoR9H1QpNcZuI56ACUw>
    <xmx:H76BaY5R45MtC4rsGJpqvCDgItVbe6Z9gORdr2qP8TUshFdUsOwZiA>
    <xmx:H76BaV5Lr2YvLtZvXMH4Dbs2kfJoK-PbM5C0V3GSDE7_RFGLw389-Q>
    <xmx:IL6BafSdFTehsL_H_11xIqlfQIEbnMiHmnG9M6XXOFFqjeJXa6wJ44Xz>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CFD9A33E0099; Tue,  3 Feb 2026 04:21:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: At9sFCvdeaDg
Date: Tue, 03 Feb 2026 11:20:30 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Daniel Borkmann" <daniel@iogearbox.net>,
 "Tariq Toukan" <ttoukan.linux@gmail.com>, netdev@vger.kernel.org
Cc: "William Tu" <witu@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "David Wei" <dw@davidwei.uk>, "Jakub Kicinski" <kuba@kernel.org>,
 "Gal Pressman" <gal@nvidia.com>
Message-Id: <ae18245c-e4f6-414a-b8d2-de18824c3861@app.fastmail.com>
In-Reply-To: <2a3bd098-0d88-4c11-8ac3-7b13f8bbbd9f@iogearbox.net>
References: <20260123223916.361295-1-daniel@iogearbox.net>
 <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
 <6188b9f5-ce38-4de9-80b7-c7b1cab48595@iogearbox.net>
 <421d9b09-a157-4f95-8775-7883ea097038@gmail.com>
 <2a3bd098-0d88-4c11-8ac3-7b13f8bbbd9f@iogearbox.net>
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-256216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[iogearbox.net,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fastmail.im:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: B98FBD6BC4
X-Rspamd-Action: no action

On Mon, Feb 2, 2026, at 18:13, Daniel Borkmann wrote:
> Hi Tariq,
>
> On 2/1/26 1:50 PM, Tariq Toukan wrote:
>> On 26/01/2026 11:23, Daniel Borkmann wrote:
>>> On 1/25/26 9:33 AM, Tariq Toukan wrote:
>>>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>>>> This reverts the following commits:
>>>>>
>>>>> =C2=A0=C2=A0 - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock int=
o ICOSQ struct")
>>>>> =C2=A0=C2=A0 - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for tri=
ggering NAPI")
>>>>> =C2=A0=C2=A0 - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dynam=
ic allocation")
>>>>> =C2=A0=C2=A0 - abed42f9cd80 ("net/mlx5e: Conditionally create asyn=
c ICOSQ")
>>>>>
>>>>> There are a couple of regressions on the xsk side I ran into:
>>>>>
>>>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an RC=
U read-
>>>>> side critical section via mlx5e_xsk_wakeup() -> mlx5e_trigger_napi=
_icosq()
>>>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll().
>>>>>
>>>>> Additionally, this also hits a NULL pointer dereference in mlx5e_x=
sk_wakeup():
>>>>>
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963735] BUG: kernel NULL pointer derefere=
nce, address: 0000000000000240
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963743] #PF: supervisor read access in ke=
rnel mode
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963746] #PF: error_code(0x0000) - not-pre=
sent page
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963749] PGD 0 P4D 0
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963752] Oops: Oops: 0000 [#1] SMP
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963756] CPU: 0 UID: 0 PID: 2255 Comm: qem=
u-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963761] Hardware name: [...]
>>>>> =C2=A0=C2=A0 [=C2=A0 103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x53/0=
x90 [mlx5_core]
>>>>>
>>>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wake=
up()
>>>>> and therefore access to c->async_icosq->state triggers it. (On the=
 NIC
>>>>> there is an XDP program installed by the control plane where traff=
ic
>>>>> gets redirected into an xsk map - there was no xsk pool set up yet.
>>>>> At some later time a xsk pool is set up and the related xsk socket=
 is
>>>>> added to the xsk map of the XDP program.)
>>>>
>>>> Thanks for your report.
>>>>
>>>>> Reverting the series fixes the problems again.
>>>>
>>>> Revert is too aggressive here. A fix is preferable.
>>>> We're investigating the issue in order to fix it.
>>>> We'll update.
>>> Ok, sounds good. Certainly the kTLS fixes seem independent, from the=
 cause
>>> of the issues I've hit it just seemed to me that they were quite fun=
damental
>>> and that perhaps a different approach would be needed (or alternativ=
ely only
>>> kTLS would need fixing, and the xsk optimization left as it was orig=
inally).
>>> Anyway, I'll keep the revert locally for now, and happy to test patc=
hes.
>>=20
>> Please check attached patch.

Hi Tariq,

I also took a glance at the patch: that seems to be correct in XSK parts=
, and mlx5e_trigger_napi_icosq now makes sense to me after your explanat=
ion. Two small comments though:

1. I'd prefer DEBUG_NET_WARN_ON_ONCE instead of WARN_ON. At least XSK wa=
keup is a hot path, called frequently, so we don't want to flood dmesg w=
ith the same error, and it would be better to compile out the check in n=
on-debug builds, hence DEBUG_NET_WARN_ON_ONCE.

2. I see you changed the condition of creating async_icosq to be created=
 when any xdp_prog is attached, even when there are no XSK pools. Is the=
re a case where async_icosq is useful with plain XDP without XSK? If not=
, I believe this condition should be XDP && XSK.

Thanks,
Alice

>> We were able to repro the issues internally and verify the fix.
>> We're finalizing it before submission.
>>=20
>> I'd be glad if you can confirm it solves the issues for you.
> That seems to work for me, yes. Feel free to add my Tested-by.
>
> Thanks,
> Daniel

