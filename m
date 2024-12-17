Return-Path: <netdev+bounces-152550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A87179F48E3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22181188DA5A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102011E47DA;
	Tue, 17 Dec 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b="Tk7NbpK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EwCZeo6g"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D91E3791;
	Tue, 17 Dec 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431316; cv=none; b=TQAU6JdgbterpPIr8WdaDxr5GjxONvK0LyaMl9ua0Uju9b3sLZVmDT0E0RgtffNT+nuPqUk3Jc9zqPTTxvCCoNJ3qMgOeUHBSdsWfJihSoCvRdPrMjw6Znfbpdv5CWnL1yNjtyhbgGV7UgKetzxNPw8pI/VrmEDlbYkuflCXxcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431316; c=relaxed/simple;
	bh=OxjGx+UMF6/z8Y4nCVz/sgrcPVJgVdSjxh0oWd/YG1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=RckrF+2rfyHtgA7JAO1LjjJY7FBTZxDf8I+o9LBPwzxyRxFrPeu6TYpGU+F8xE8OOn5+/HmTA4KNY1OLcyrgwNY/PfJZoN5xYZxxpZDSut+q/ljXgbK4zqbAhRJLVBW25gwr0AzzVwYMe3/oXOuAvR2kgdCVEaZuJylaSOfEXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev; spf=pass smtp.mailfrom=getstate.dev; dkim=pass (2048-bit key) header.d=getstate.dev header.i=@getstate.dev header.b=Tk7NbpK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EwCZeo6g; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=getstate.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getstate.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 259141140111;
	Tue, 17 Dec 2024 05:28:31 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-08.internal (MEProxy); Tue, 17 Dec 2024 05:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getstate.dev; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734431310;
	 x=1734517710; bh=OxjGx+UMF6/z8Y4nCVz/sgrcPVJgVdSjxh0oWd/YG1s=; b=
	Tk7NbpK1gngz4+Mm8lbyoAzrMRn7x3lwsY1F/KoD7MiKTrLmMcvfeGXklc9a6CsK
	J5ZIy3BGPHUibQcMdibPVgCcuShYSnbeQFtL1LvbkJQ9zacjfB+tl8dD9882iK7t
	9qyCAcWcqclkD+aZXNVL7YIIvbVm+t7X0O17Rtwznx1tlgEXLGTiZqBh1r31d84n
	+UbEEd8lQp/oyq6W4Iqqm6X7+UoS8lbuZT/jbyzIXzA/2A3kMMRGu6pkdcz4J1Gi
	FkUMPoZVItT+sBhcOvXTPtpo/Do0vIcWauYH4YiqBzKYpr34nwKtBSt3hkNKfW0u
	kbfEU+wIfT0uK8cceUXgBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734431310; x=
	1734517710; bh=OxjGx+UMF6/z8Y4nCVz/sgrcPVJgVdSjxh0oWd/YG1s=; b=E
	wCZeo6g3qr3U2iJsWp2aFvlk0b2bc/Rx3WpaTMhbNpCKvTm4t0EX0A0kFV1z0WR9
	EyIt7PqBSWxyldPffznlPqHbqUhYprAfbcCfyui+DQ6mnMqRphKYqohUKNm2sr0g
	vlJPhTEejfs2/I/Udu0KHaw1m6Owe+e1ekdoprOs4zGNtZg3OUQfjIk7nl4hoXyL
	dPYAX9Tm0E8IJJnfUdOFxg3RzOs89caCIqorTHPhQJjwO+Y0BzIu8FvyMr4KINXl
	rhb8tWaEWIi7YSFOsEXnWWPJRXcQRqflJ5z4NV+QRBJ3DRDavrf3EsdJblJh8iVg
	/XxWpwziOxknLMOUxj4EA==
X-ME-Sender: <xms:TlJhZ3a24as6VZExOojptYukRNvkLAinWuGB0vKktX_hym4ZeARb9w>
    <xme:TlJhZ2bQxsmvbTveVIorSseCikKIVit3tuuvvn5wy20zRsb_Erl4h_Y2R350AgLW_
    q1dbJfOSPtlmviXAHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggfgtgffkffuhffvvefofhgjsehtqhertdertdej
    necuhfhrohhmpedfofgriihinhcutehluchhrgguuggrugdfuceomhgriihinhesghgvth
    hsthgrthgvrdguvghvqeenucggtffrrghtthgvrhhnpeejkeffudehteeivddujeetjeef
    lefgfeefgeekudejvdeukeffteeugfffuddvfeenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgiiihhnsehgvghtshhtrghtvgdruggvvhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvh
    gvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghho
    ohhglhgvrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepshihiigsohhtodeitddvfegvrgefvdgvvddtiegvvghfjeelvddt
    rgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghilhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TlJhZ5-3ShLhlMF9urb5P44BwUfYOR-nlkNz7mDanjDujTMRvrEntg>
    <xmx:TlJhZ9p0QFhGb_A2k8UevVmm6SIrBJ57RifkHeOWtj6B8Kz9dK9-0Q>
    <xmx:TlJhZyphqX08mvwI7o77ofBrfxCt0IDDyPkzKuFpU0agFFlcJbuhYQ>
    <xmx:TlJhZzS3CC6HwWEDIqPa_s48t8WQcX-f2NOyFVzk8IAzJGH2OASd2w>
    <xmx:TlJhZ-fFIkaO8ZKPpI_iwCo4EaPgvgeHQ8vRBw4atBuG8T6pea0OSvuJ>
Feedback-ID: i0ed1493d:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6DEA51C20066; Tue, 17 Dec 2024 05:28:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Dec 2024 13:28:20 +0300
Message-Id: <D6DWKZGXYA82.WD6TXB0E9P05@getstate.dev>
Subject: Re: [PATCH] ip6_tunnel: Fix uninit-value in ip6_tnl_xmit
From: "Mazin Al haddad" <mazin@getstate.dev>
To: "Eric Dumazet" <edumazet@google.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>,
 <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
X-Mailer: aerc 0.18.2
References: <20241217030751.11226-1-mazin@getstate.dev>
 <CANn89iJeh5wCRpiBBBucmJXRdTb=DbOjXTHtEm1rOpvq=dGgvQ@mail.gmail.com>
In-Reply-To: <CANn89iJeh5wCRpiBBBucmJXRdTb=DbOjXTHtEm1rOpvq=dGgvQ@mail.gmail.com>

Hi Eric,

On Tue Dec 17, 2024 at 8:42 AM +03, Eric Dumazet wrote:
> On Tue, Dec 17, 2024 at 4:09=E2=80=AFAM Mazin Al Haddad <mazin@getstate.d=
ev> wrote:
> >
> > When taking the branch with skb_realloc_headroom, pskb_expand_head is
> > called, as such, pointers referencing content within the new skb's head=
er
> > are invalid. Currently, the assignment of hop_limit accesses the now
> > invalid pointer in the network header of this "new" skb. Fix this by
> > moving the logic to assign hop_limit earlier so that the assignment
> > references the original un-resized skb instead.
>
> Unfortunately this is not fixing anything.
>
> If the IPv6 header was in the skb head before skb_realloc_headroom()
> and/or pskb_expand_head(),
> it would be copied in the new skb head.
>
> Note how the repro is sending a packet with vlan tag (88A8 : ETH_P_8021AD=
)
>
> endto$packet(r0, &(0x7f0000000180)=3D"a6bea8a120e5f8320c30ce5088a8",
> 0x12, 0x0, &(0x7f0000000140)=3D{0x11, 0x0, r3, 0x1, 0x0, 0x6, @local},
> 0x14)
>
> Current code, using pskb_inet_may_pull() is not ready yet.
>

I understand the issue better now. Thank you for taking the time
to explain, I appreciate your time and effort.

BR,
Mazin

