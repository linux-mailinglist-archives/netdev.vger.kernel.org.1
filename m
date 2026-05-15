Return-Path: <netdev+bounces-288403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CMxI0VkB2q90wIAu9opvQ
	(envelope-from <netdev+bounces-288403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:21:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BE555616D
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 20:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50B1D3019FF4
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47D3403143;
	Fri, 15 May 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="DjlXtmj6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HPZPl8sy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C64A40314A;
	Fri, 15 May 2026 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866681; cv=none; b=dlFno9ysAqpG+jRkc11SJxmMup8LzxtfcbzOcEK/6WCU5bBDAiencUH+F18vKz9u0L8l3nutPs0fiTacTlNsKka3/QRXD4IGs9kfbPyJR+YQE27bUVVEsKEx0gjHLkgDVByCUcsT24rkFgyzOPlF3wc/SN4LSfkVxWrGFqEl/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866681; c=relaxed/simple;
	bh=JQKrV7isrK75BFljm1+ouV8UWgZWKi19E4IQ741cSEE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fnsP1dLXhqD5mXtT7kyKBbOXxODDap3RH3LuDlexPOsOjED+3JPs8Aa0wwSsET8A9JRpoSJYDD+dRlO4TTyV6VxIHtagOyHqm7A7LNPp7fOmdC0PRkVzLnEp/k0/IIhFUmPF13zJt9A3Dl8iZi7XiUkvtNJD0JSmE1pd4B6gJNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=DjlXtmj6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HPZPl8sy; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A27B17A0067;
	Fri, 15 May 2026 13:37:58 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 15 May 2026 13:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778866678;
	 x=1778953078; bh=DaJeHYAfiwY5vAMBlHHL1NmEK9ZrHLFcpUdf/1Qqzxc=; b=
	DjlXtmj69I3MDLEEprLfb3l9QhrAhuCHAhERSt90bEF4IO9lWJguZCG3IdkyqzfG
	y39I9+VF6A6B57bi/8gGL8tL9r5yxL+wbsz42KH4m8HExIlwP5AOFoJmYAbMLDT0
	zySu3bKBZhjTgghPculztw/SlZvxVgTxygfPDTk4bl0+Nm9RM/0dgqyXM8hOsrir
	Sj5UQd+z8Dug30rAzS2jhvAFck7D1sem9o4mITmz+Wly01dvudLIUCJ+Ri3H7ZIZ
	oYEyWgFWvCzTZBnOJnrwZIYUhG/BkgLhmjZiFmRicSiSvUXc3/LUy14ThPUrXZAX
	/+KFg7CAbNz10csIwzJt+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778866678; x=
	1778953078; bh=DaJeHYAfiwY5vAMBlHHL1NmEK9ZrHLFcpUdf/1Qqzxc=; b=H
	PZPl8sydMpf/4sTMP+21FvGnNz8kbkaGXL4Gdxv36H8CQvdDqYOuf54Zey8ilIuF
	h37TMfJdKyFw1YTY1W/6oMgg/5c7rqlunCYrJ2JBLm09I74LUz1SF/Gq+FKl+yG3
	OWoU2M+fmrHTXVogeViRoZK6wM41kokJn9b/7LwcnSHA9841kOfKyTlD4HBnlweG
	G5cRhHXzoIUl0JAKcrWiFKablsZUgs6RwN3LdrBJDKroBU8p1KvgJIksN6rg6bUl
	bL5RqwyaqfpCoclN6K1ONT71ip6ZEhL1zNSpIP6U2yFzuKF5AcrUsSDMgjLmuQVv
	D3Yj05WycRGEC8DVdHByw==
X-ME-Sender: <xms:9lkHasl_847wbHWD1krSVoKYtX1SfRA7ty1ibxLh4XsDgCD9IQDCgQ>
    <xme:9lkHamrSVpnx7cR61yAiBBXkixrbq6ZGDPMKYWe5rbGthEJ-Dbm9kt0m5BEatbDuk
    vPiMBV5YFY02smiioW9sPegVJ0-MHs5F18ZJbyCGoSFEVUwMurXyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepieeftefggfdvuefhkedufeelhfelhfegieehuddthffhheekhfevteeg
    veehieejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhesshhquhgvsggs
    rdgtrgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eptggrrhhlrdhlvggvsegrmhgurdgtohhmpdhrtghpthhtoheptgholhhinhdrhhhurghn
    ghdvsegrmhgurdgtohhmpdhrtghpthhtohepphgvthgvrhdrshhhvghnsegrmhgurdgtoh
    hmpdhrtghpthhtoheplhhutggrrdhsthgvfhgrnhhirdhgvgdusehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepqhhquddugeehtdelleesghhmrghilhdrtghomhdprhgtphhtthhope
    gsrhhglheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9lkHak3N2NXn7A91k33yiB17KyA0SSOo1CevNUCJBhmKoIKQPEuc6g>
    <xmx:9lkHavhNYPD2aqk2FojDE_WMXc5rLMWSTlX5SAYOClL-KuaEAC9heA>
    <xmx:9lkHatn-tJi6URAcPfTqwtc83azNdlZQRrLStyzBTttYeYVBy1--1w>
    <xmx:9lkHalZf3zcqDS6eVeKfmtko-6gsIjhjfxSbQlnpH6to0C1Yet7ZMg>
    <xmx:9lkHanXuNH4-pYQBEvqsrShIHT0weKlgDnlkpUQ2A3EXY25_UPsL6JF6>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35DC22CE0072; Fri, 15 May 2026 13:37:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhbOKArEPXX-
Date: Fri, 15 May 2026 13:37:37 -0400
From: "Mark Pearson" <mpearson@squebb.ca>
To: "Bartosz Golaszewski" <brgl@kernel.org>, "Carl Lee" <qq1145099@gmail.com>
Cc: "Luca Stefani" <luca.stefani.ge1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com,
 colin.huang2@amd.com, "Carl Lee" <carl.lee@amd.com>
Message-Id: <c1f80da1-9bf8-41c3-b645-3ae95e116add@app.fastmail.com>
In-Reply-To: 
 <CAMRc=MfADC2ncuUQiSW7TnUwBUWCJn9i=wZ9dqYMZNo2h6qOxw@mail.gmail.com>
References: 
 <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
 <ca967f7e-d671-4be5-bcc2-30d75fa919aa@gmail.com> <abE6yxLHNqvq2Imz@carl-amd>
 <CAMRc=MfADC2ncuUQiSW7TnUwBUWCJn9i=wZ9dqYMZNo2h6qOxw@mail.gmail.com>
Subject: Re: [PATCH v2] nfc: nxp-nci: remove interrupt trigger type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 05BE555616D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[squebb.ca,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[squebb.ca:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-288403-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,amd.com];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mpearson@squebb.ca,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[squebb.ca:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,squebb.ca:dkim,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Mon, May 4, 2026, at 5:33 AM, Bartosz Golaszewski wrote:
> On Wed, Mar 11, 2026 at 11:01=E2=80=AFAM Carl Lee <qq1145099@gmail.com=
> wrote:
>>
>> On Mon, Mar 09, 2026 at 07:13:18PM +0100, Luca Stefani wrote:
>> >
>> > On 05/02/2026 12:11, Carl Lee wrote:
>> > > For NXP NCI devices (e.g. PN7150), the interrupt is level-trigger=
ed and
>> > > active high, not edge-triggered.
>> > >
>> > > Using IRQF_TRIGGER_RISING in the driver can cause interrupts to f=
ail
>> > > to trigger correctly.
>> > >
>> > > Remove IRQF_TRIGGER_RISING and rely on the IRQ trigger type confi=
gured
>> > > via Device Tree.
>> > >
>> > > Signed-off-by: Carl Lee <carl.lee@amd.com>
>> > > ---
>> > > This v2 of the series includes Krzysztof Kozlowski in the review =
list
>> > > for NXP-NCI NFC.
>> > >
>> > > This series removes IRQF_TRIGGER_RISING in nxp-nci driver,
>> > > relying on the IRQ trigger type specified via Device Tree.
>> > > ---
>> > > Changes in v2:
>> > > - Include Krzysztof Kozlowski in the review list for NXP-NCI NFC.
>> > > - Link to v1: https://lore.kernel.org/r/20260204-fc-nxp-nci-remov=
e-interrupt-trigger-type-v1-1-3bde91593173@amd.com
>> > > ---
>> > >   drivers/nfc/nxp-nci/i2c.c | 2 +-
>> > >   1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
>> > > index 049662ffdf97..6a5ce8ff91f0 100644
>> > > --- a/drivers/nfc/nxp-nci/i2c.c
>> > > +++ b/drivers/nfc/nxp-nci/i2c.c
>> > > @@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_clien=
t *client)
>> > >     r =3D request_threaded_irq(client->irq, NULL,
>> > >                              nxp_nci_i2c_irq_thread_fn,
>> > > -                            IRQF_TRIGGER_RISING | IRQF_ONESHOT,
>> > > +                            IRQF_ONESHOT,
>> >
>> > This is causing an IRQ storm on my ACPI device that eats away a cor=
e of my
>> > cpu...
>> >
>> > I'm not sure how this should be fixed but by looking at other drive=
rs they
>> > all use irq_get_trigger_type() and then apply extra bits on top.
>> >
>> > If there's no clear path that handles both ACPI+DT I'll upload a re=
vert.
>> >
>>
>> Thanks for the report.
>>
>> I=E2=80=99ve sent a follow-up patch series that restores a fallback t=
o the
>> historically used rising-edge trigger when the firmware does not prov=
ide
>> a trigger type. This should prevent the IRQ storm on ACPI platforms
>> while keeping proper behavior on DT-based systems.
>>
>> Patch series link: https://lore.kernel.org/all/20260311-nfc-nxp-nci-i=
2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com/
>>
>
> Hi!
>
> I'm experiencing the same issue since v6.19.5 (still present on
> v7.0.3) and the linked patch *does not* fix the problem - only
> reverting the offending commit
> (57be33f85e369ce9f69f61eaa34734e0d3bd47a7 in mainline) does. I'm
> running a T14s laptop with AMD Ryzen 7 PRO 6850U.
>
Hi all

Just to confirm that I'm seeing the same on a number of Lenovo platforms=
 with NFC devices on them (so far AMD platforms only, though I don't kno=
w if that is always true). I think it's going to be  common unfortunatel=
y.

I've been discussing with Carl, but reverting the patch for now would be=
 my preference while we figure out how to not break things on the x86 pl=
atforms.

The patch from Carl where it checks for a not configured irqtype doesn't=
 work unfortunately. On my test systems it returns with the irq set as I=
RQF_TRIGGER_HIGH, which triggers the IRQ storm (which breaks things).

I do have a question in to the platform team to determine how the IRQ sh=
ould be configured on our platforms (is HIGH correct and we're not servi=
cing it correctly, or is it wrong and in which case how do we fix it).

Unfortunately the NFC device hasn't been part of our Linux certification=
 program (I get a question about it about once every 2 years). I'd love =
to get it working properly - but that will take some time to figure out =
the options.

If this is lenovo specific we could put a dmi quirk in for the short ter=
m? I suspect it might hit other vendors too though - so maybe remove it =
for non device tree platforms?

Let me know what I can do to help

Mark

