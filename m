Return-Path: <netdev+bounces-256409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKjIA1k4gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:03:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E89BEDD436
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C07303017273
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C03624BC;
	Tue,  3 Feb 2026 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="NoMtxIpK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hJ9OFM/H"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B928134C
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141331; cv=none; b=fxeEsqTQri264t0S9Rkt0ON7Pty2SgnPMMkZX3oT1InV7z8gjFubNOa8kwuqIu85tZ0hxwK6zMEwMZ0tswZ4iivvI/mYkVDatPBB6Gp2wrBa9OJMh1IV+/rVaEXIDhQA0TmnHj95dJSdOddENrGwzPJLisuwxY8GspXYXAniRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141331; c=relaxed/simple;
	bh=0YmPDh/LChShwwhwAamad7/d0A2oT5Ksa0cHRjr/tF4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=c/nHqaQgIKeoNmyYuDK9ZUaeZajDebZCEK82WhBz+Omez7Gw1FCikp7GMvJtMRTfnUcu6PbhADu+3LxCDY05CaQ7c9WMlwsA/z6kn3Z5IH2Xhz86Iou2QrvFCMlLohdOaSCQ56JONuy32u8HhQtTJQm4mVE+FHmd1/tUogD1XWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=NoMtxIpK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hJ9OFM/H; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0D4A7A01B3;
	Tue,  3 Feb 2026 12:55:26 -0500 (EST)
Received: from phl-imap-13 ([10.202.2.103])
  by phl-compute-10.internal (MEProxy); Tue, 03 Feb 2026 12:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770141326;
	 x=1770227726; bh=/ItY5gmimiv11sh+7nWpQoJ4dWDev+mDb54ktANl96w=; b=
	NoMtxIpKJYn652/uyYLn3RcQFTFD03VhFLJ0pBJoeXZcIVTnX5lB9VHxcI9dLnjV
	zWXMMPqhlduJAcHOsV5UIo+nR67Ek6SHl+huOfMedGVQw0Fj1Je8VmorUuyGXRwj
	m+voHfgHWnp7FFU2KUdbawy+X4PYJLurwJV2kbVonYZdghWiR12Sv+wENCD6jqaa
	kvUlqqyvLauEhJHD45Q2J3AeEL+GwINIrgcjkP3gPayotitF5iaFiDg2QNF2fpxE
	MOPf5wPUJO5PI+TkVE42H/frRuxxNiD5Ja5egUmpv3iGP76pnuuBcHkWIyHYCaEy
	7pLzAC3ddzo9vMYs7Of5Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770141326; x=
	1770227726; bh=/ItY5gmimiv11sh+7nWpQoJ4dWDev+mDb54ktANl96w=; b=h
	J9OFM/HZub7xW97PPJYjbHCAQoPhpEUfsbT+wT/u0EHTjoExAhuk+aUOHNNeP8j/
	Jz7a3h2lvrVZyPSQxGSKqIV0j2CvTtM5Nhgf8dmITm2d5SISK7pi9FXGq2ypE1Oj
	Tz2eSZug+j/EmRL7aTuufp5BLyI6v+wWhMYPeFHXZkyhlE+oRC+qCru7KMjSZKdK
	1Hc6woisVr2nshPPAOMf9rP28+dzkLKWsNNijwfSLPXG2eZmDOeRbH3UXoM5ocJ5
	w1nd4wJbnN/3ZQch7g0TtjvsABGzQPr9DumnubqFNyo8EF6Ypg8OA05c51rirCcv
	hnY15JfeqUcm4c4ZBwf/g==
X-ME-Sender: <xms:jTaCafO-ixy2btwPKszwt11OntgtETVpHcYlTSzxlstTC7IAgB_0-g>
    <xme:jTaCaUxzoVL0mQS3EOID1gkKw3crnERT4p2Jl1_foQU5YE88_8seVlBr_U4GQf_sC
    h2HQs_Z113N0EVM8kU7ESv3NWw20KUmnMJ37W__UZMgXpLW9wJTkmI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtjedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:jTaCaYiJViiCf411FJ37FUHbcEgOMU7T51GCkPM-zNcE05GqjKtqRA>
    <xmx:jTaCabDcsRqE7PDLiVEedKOD7fQLnF2xO6l_8kKW2yMQHvpHmDi9Cg>
    <xmx:jTaCaWulf2QaCXLc6_AQz0sya-_070m3NSuLqW5pcOl0nO36jgIYkA>
    <xmx:jTaCaXeOU6IfzxS6NWciU8cBROdgsZHSOUcoFd2_cu2VdUA7pB2bpA>
    <xmx:jjaCaYVYYpU0NjomptCSUyKzKlr7CgcIDGuwX07ncrhZaILx3YRqfomB>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C2E0E33E0099; Tue,  3 Feb 2026 12:55:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: At9sFCvdeaDg
Date: Tue, 03 Feb 2026 19:54:31 +0200
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "Tariq Toukan" <ttoukan.linux@gmail.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: "William Tu" <witu@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "David Wei" <dw@davidwei.uk>, "Jakub Kicinski" <kuba@kernel.org>,
 "Gal Pressman" <gal@nvidia.com>
Message-Id: <cb1fc819-f761-4d25-8c49-674d72462f95@app.fastmail.com>
In-Reply-To: <aa78345a-bdb6-4dd9-9db2-3599585f1553@gmail.com>
References: <20260123223916.361295-1-daniel@iogearbox.net>
 <85776531-d5fa-4762-90aa-74c8397dc09b@gmail.com>
 <6188b9f5-ce38-4de9-80b7-c7b1cab48595@iogearbox.net>
 <421d9b09-a157-4f95-8775-7883ea097038@gmail.com>
 <2a3bd098-0d88-4c11-8ac3-7b13f8bbbd9f@iogearbox.net>
 <ae18245c-e4f6-414a-b8d2-de18824c3861@app.fastmail.com>
 <aa78345a-bdb6-4dd9-9db2-3599585f1553@gmail.com>
Subject: Re: [PATCH net-next] net/mlx5e: Undo saving per-channel async ICOSQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-256409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,iogearbox.net,vger.kernel.org];
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
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fastmail.im:dkim]
X-Rspamd-Queue-Id: E89BEDD436
X-Rspamd-Action: no action

On Tue, Feb 3, 2026, at 16:58, Tariq Toukan wrote:
> On 03/02/2026 11:20, Alice Mikityanska wrote:
>> On Mon, Feb 2, 2026, at 18:13, Daniel Borkmann wrote:
>>> Hi Tariq,
>>>
>>> On 2/1/26 1:50 PM, Tariq Toukan wrote:
>>>> On 26/01/2026 11:23, Daniel Borkmann wrote:
>>>>> On 1/25/26 9:33 AM, Tariq Toukan wrote:
>>>>>> On 24/01/2026 0:39, Daniel Borkmann wrote:
>>>>>>> This reverts the following commits:
>>>>>>>
>>>>>>>  =C2=A0=C2=A0 - ea945f4f3991 ("net/mlx5e: Move async ICOSQ lock =
into ICOSQ struct")
>>>>>>>  =C2=A0=C2=A0 - 56aca3e0f730 ("net/mlx5e: Use regular ICOSQ for =
triggering NAPI")
>>>>>>>  =C2=A0=C2=A0 - 1b080bd74840 ("net/mlx5e: Move async ICOSQ to dy=
namic allocation")
>>>>>>>  =C2=A0=C2=A0 - abed42f9cd80 ("net/mlx5e: Conditionally create a=
sync ICOSQ")
>>>>>>>
>>>>>>> There are a couple of regressions on the xsk side I ran into:
>>>>>>>
>>>>>>> Commit 56aca3e0f730 triggers an illegal synchronize_rcu() in an =
RCU read-
>>>>>>> side critical section via mlx5e_xsk_wakeup() -> mlx5e_trigger_na=
pi_icosq()
>>>>>>> -> synchronize_net(). The stack holds RCU read-lock in xsk_poll(=
).
>>>>>>>
>>>>>>> Additionally, this also hits a NULL pointer dereference in mlx5e=
_xsk_wakeup():
>>>>>>>
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963735] BUG: kernel NULL pointer deref=
erence, address: 0000000000000240
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963743] #PF: supervisor read access in=
 kernel mode
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963746] #PF: error_code(0x0000) - not-=
present page
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963749] PGD 0 P4D 0
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963752] Oops: Oops: 0000 [#1] SMP
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963756] CPU: 0 UID: 0 PID: 2255 Comm: =
qemu-system-x86 Not tainted 6.19.0-rc5+ #229 PREEMPT(none)
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963761] Hardware name: [...]
>>>>>>>  =C2=A0=C2=A0 [=C2=A0 103.963765] RIP: 0010:mlx5e_xsk_wakeup+0x5=
3/0x90 [mlx5_core]
>>>>>>>
>>>>>>> What happens is that c->async_icosq is NULL when in mlx5e_xsk_wa=
keup()
>>>>>>> and therefore access to c->async_icosq->state triggers it. (On t=
he NIC
>>>>>>> there is an XDP program installed by the control plane where tra=
ffic
>>>>>>> gets redirected into an xsk map - there was no xsk pool set up y=
et.
>>>>>>> At some later time a xsk pool is set up and the related xsk sock=
et is
>>>>>>> added to the xsk map of the XDP program.)
>>>>>>
>>>>>> Thanks for your report.
>>>>>>
>>>>>>> Reverting the series fixes the problems again.
>>>>>>
>>>>>> Revert is too aggressive here. A fix is preferable.
>>>>>> We're investigating the issue in order to fix it.
>>>>>> We'll update.
>>>>> Ok, sounds good. Certainly the kTLS fixes seem independent, from t=
he cause
>>>>> of the issues I've hit it just seemed to me that they were quite f=
undamental
>>>>> and that perhaps a different approach would be needed (or alternat=
ively only
>>>>> kTLS would need fixing, and the xsk optimization left as it was or=
iginally).
>>>>> Anyway, I'll keep the revert locally for now, and happy to test pa=
tches.
>>>>
>>>> Please check attached patch.
>>=20
>> Hi Tariq,
>>=20
>> I also took a glance at the patch: that seems to be correct in XSK pa=
rts, and mlx5e_trigger_napi_icosq now makes sense to me after your expla=
nation.=20
>
> Great.
>
>> Two small comments though:
>>=20
>> 1. I'd prefer DEBUG_NET_WARN_ON_ONCE instead of WARN_ON. At least XSK=
 wakeup is a hot path, called frequently, so we don't want to flood dmes=
g with the same error, and it would be better to compile out the check i=
n non-debug builds, hence DEBUG_NET_WARN_ON_ONCE.
>>=20
>
> I tend to totally drop this check.
>
>> 2. I see you changed the condition of creating async_icosq to be crea=
ted when any xdp_prog is attached, even when there are no XSK pools. Is =
there a case where async_icosq is useful with plain XDP without XSK? If =
not, I believe this condition should be XDP && XSK.
>>=20
>
> You're right.
> As you know, the channels are not re-opened on XSK pool events.
> They are re-opened on XDP program attach/detach.

Ah, that's right, I see. I didn't pay attention to where the check is
located. If you reorganize the code a little bit, it's possible to
implement the perfect check (XDP && XSK) || kTLS_RX, to avoid creating
the unneeded async_icosq with plain XDP.

(BTW, I see that ktls_rx_was_enabled is never reset to false: is it
because we can't reliably fence the moment when the driver stops using
it?)

Anyway, it's up to you if you'd like to do it or not, but here is my
suggestion. We don't have to create async_icosq in mlx5e_open_queues.
Similar to how we separated mlx5e_open_xsk, we can separate
mlx5e_open_async_icosq, which is where we can check (XDP && XSK) ||
kTLS_RX.

Then mlx5e_open_channel will look like:

mlx5e_open_queues();
mlx5e_open_async_icosq(); // Checks the condition internally
if (xsk_pool)
        mlx5e_open_xsk();

mlx5e_xsk_enable_locked will also call mlx5e_open_async_icosq just
before mlx5e_open_xsk.

mlx5e_close_async_icosq will close it if it exists.

With this design, all cases are covered: every mlx5e_open_xsk is paired
with mlx5e_open_async_icosq; and kTLS RX enable flow reopens channels,
which also triggers mlx5e_open_async_icosq. The conditional is DRYed in
mlx5e_open_async_icosq itself, so no code repetition either.

> Hence, as a simple and quick fix, we will check for XDP program and=20
> create the async ICOSQ accordingly.
> Currently we won't have create/destroy async ICOSQ when XSK pool is=20
> activated/deactivated. I will mention this in the commit message.
>
> This still prevents the async ICOSQ creation in default.
>
>> Thanks,
>> Alice
>>=20
>
>
>>>> We were able to repro the issues internally and verify the fix.
>>>> We're finalizing it before submission.
>>>>
>>>> I'd be glad if you can confirm it solves the issues for you.
>>> That seems to work for me, yes. Feel free to add my Tested-by.
>>>
>>> Thanks,
>>> Daniel

