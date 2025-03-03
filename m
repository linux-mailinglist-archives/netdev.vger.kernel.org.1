Return-Path: <netdev+bounces-171089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA3A4B6C7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 04:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936DB188E375
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 03:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C61D517E;
	Mon,  3 Mar 2025 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="a3DJ9WE/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1h40us8"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0B013AD38;
	Mon,  3 Mar 2025 03:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740972910; cv=none; b=NC58suHDlbJJxrmSfEBo+looAzVT9oeBEp1dp2A8+X+c773DYa2XhKDzeRbvRALCIrcbNNCV6zg5jg73/pKmf9ryVSzpJdoe5CoDiadxqmJCIdMSizmrIb5h2dCtoCD5V/KYE99+kHdsZEotNcF+u9D3i9nTm2C4f633D1Nztwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740972910; c=relaxed/simple;
	bh=rlGUGItlRp+5PD4FB1ETCK12eyxr8Z6n8tj2rkGL+Z8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OzgfM7px7Or9RPQkuUunuliv86AOVmoCog3rhY1revzFhkDvSr0KBPiWT5r0jA6SgchBZ2CooPV2PScMijh9Vcq+2/W8Svh3gyA/j7QKGLk7MKhfc/FPnDNEL0Wl6QCrc8NL3VV50Blq5EXx4FeD2E6NMIa01N1fTO45zyjS1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=a3DJ9WE/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1h40us8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D758E1381126;
	Sun,  2 Mar 2025 22:35:06 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-06.internal (MEProxy); Sun, 02 Mar 2025 22:35:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740972906;
	 x=1741059306; bh=1tychua9l7n61svGEzWedtq6hJlc1nNUyScpoDj3Tlc=; b=
	a3DJ9WE//xCVQRrtKnbcfwCSPF2TfYgaTU2s7s9qFKbUuqwsRn/PIbveR3Hb3dD0
	8aG/1/nKZIxeeD1bTLfxsPJhamxNpnf/IXk7Y/0QbaiBnuzgx18VOHc83sak+4e9
	jRuS/pknfuMtpRIhDPVF/79q3YxFLioToIrBVVMuGTfA/GsPPBxZV84IWoNx4HjD
	ael/dN4qGHGF6gfAuy4u42V+gO3UsLafrNKqJiw2d6u/RS3/nvcwgLitbTCmiJ5m
	uaIW1ae9TOnsCe4puiqB2APPVqsZGxlTd7rJf0rmb3gbMcSrh/9ethkvh2iHHRG8
	NU/hifgzfcgGj3wXJJD6lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740972906; x=
	1741059306; bh=1tychua9l7n61svGEzWedtq6hJlc1nNUyScpoDj3Tlc=; b=Q
	1h40us8dhBb06vWJjCG34G0N4XhWgHytDRSS/BKdq+UnZXbZeUbW6w8wuqmcO+bk
	8A6LwzEi/wZOwrxG2zCRPyHTn/haLv7tp5RBtIU6eorPAuO5MPjHsk/dZW710zuS
	iHp5egI62Ls0NqaL2K4etj0Szmn3KRznOD208PV/Z1FcKC3ddn36SXAGsjwAbYFG
	9vZyEGcPL0FccA45X8O6zLL9k5/1IrC3jhF1x767lEUNtm21W2sh23PBTwRZA7+6
	kjjSK0fnclFOlAmHoGza3dwf19DOCM0tto866UxoMeIgX0GLK6ds9sDEYL6zvI/p
	4L6l8Pamup4f2ldD9Sb+g==
X-ME-Sender: <xms:aiPFZ7myAOmE0gEulOkpIwaqICnTrF_t58M4DERz9jRg3TahbVPmWw>
    <xme:aiPFZ-1qYE6pJhr3xUvjFecapA1QijiZWhaefK-IO7wuOEK5YFMtuN81EVnMAukZr
    qvKTlkoacnvxpdM1aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepudeltdevfedufeff
    gfeggeehtdeigefghedugefhleetvdfggffghfehhfefteffnecuffhomhgrihhnpehinh
    htvghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtg
    hpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegu
    rghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvg
    drtghomhdprhgtphhtthhopegrnhhthhhonhihrdhlrdhnghhuhigvnhesihhnthgvlhdr
    tghomhdprhgtphhtthhopehprhiivghmhihslhgrfidrkhhithhsiigvlhesihhnthgvlh
    drtghomhdprhgtphhtthhopehvihhtrghlhidrlhhifhhshhhithhssehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehinh
    htvghlqdifihhrvgguqdhlrghnsehlihhsthhsrdhoshhuohhslhdrohhrghdprhgtphht
    thhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheprghnug
    hrvgifsehluhhnnhdrtghh
X-ME-Proxy: <xmx:aiPFZxrN-g59kT3n0CvLos4BRh0MiFgLsgl2QQABIAF31OPO-A8OBQ>
    <xmx:aiPFZzkc6pmKJXZUGmH9lgYrHpcsexFHBWqzcDFbe1Lyxp8kmqmV_g>
    <xmx:aiPFZ53-2Iym6rEBS-s6cg0SYV-kPstBW5e55zZ4yMQmA1I6w1tK1w>
    <xmx:aiPFZysTyEySoADBpssay6uh68Z0cm553Js4lv937TgXLkqeypfxDw>
    <xmx:aiPFZ6tGBR39V9hiAeMDqs_rqggmzPFJdZLtLn3OUlVW7oFxUDOAHqty>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0C523C0066; Sun,  2 Mar 2025 22:35:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 02 Mar 2025 22:34:45 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Andrew Lunn" <andrew@lunn.ch>,
 "Vitaly Lifshits" <vitaly.lifshits@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <24740a7d-cc50-44af-99e2-21cb838e17e5@app.fastmail.com>
In-Reply-To: <698700ab-fd36-4a09-8457-a356d92f00ea@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
 <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
 <1a4ed373-9d27-4f4b-9e75-9434b4f5cad9@lunn.ch>
 <9f460418-99c6-49f9-ac2c-7a957f781e17@app.fastmail.com>
 <4b5b0f52-7ed8-7eef-2467-fa59ca5de937@intel.com>
 <698700ab-fd36-4a09-8457-a356d92f00ea@lunn.ch>
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Link flap workaround option for false
 IRP events
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, Mar 2, 2025, at 11:13 AM, Andrew Lunn wrote:
> On Sun, Mar 02, 2025 at 03:09:35PM +0200, Lifshits, Vitaly wrote:
>>=20
>>=20
>> Hi Mark,
>>=20
>> > Hi Andrew
>> >=20
>> > On Thu, Feb 27, 2025, at 11:07 AM, Andrew Lunn wrote:
>> > > > > > +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
>> > > > >=20
>> > > > > Please add some #define for these magic numbers, so we have s=
ome idea
>> > > > > what PHY register you are actually reading. That in itself mi=
ght help
>> > > > > explain how the workaround actually works.
>> > > > >=20
>> > > >=20
>> > > > I don't know what this register does I'm afraid - that's Intel =
knowledge and has not been shared.
>> > >=20
>> > > What PHY is it? Often it is just a COTS PHY, and the datasheet mi=
ght
>> > > be available.
>> > >=20
>> > > Given your setup description, pause seems like the obvious thing =
to
>> > > check. When trying to debug this, did you look at pause settings?
>> > > Knowing what this register is might also point towards pause, or
>> > > something totally different.
>> > >=20
>> > > 	Andrew
>> >=20
>> > For the PHY - do you know a way of determining this easily? I can r=
each out to the platform team but that will take some time. I'm not seei=
ng anything in the kernel logs, but if there's a recommended way of conf=
irming that would be appreciated.
>>=20
>> The PHY is I219 PHY.
>> The datasheet is indeed accessible to the public:
>> https://cdrdv2-public.intel.com/612523/ethernet-connection-i219-datas=
heet.pdf
>
> Thanks for the link.
>
> So it is reading page 772, register 26. Page 772 is all about LPI. So
> we can have a #define for that. Register 26 is Memories Power. So we
> can also have an #define for that.

Yep - I'll look to add this.

>
> However, that does not really help explain how this helps prevent an
> interrupt. I assume playing with EEE settings was also played
> with. Not that is register appears to have anything to do with EEE!
>
I don't think we did tried those - it was never suggested that I can rec=
all (the original debug started 6 months+ ago). I don't know fully what =
testing Intel did in their lab once the issue was reproduced there.

If you have any particular recommendations we can try that - with a note=
 that we have to run a soak for ~1 week to have confidence if a change m=
ade a difference (the issue can reproduce between 1 to 2 days).

>> Reading this register was suggested for debug purposes to understand =
if
>> there is some misconfiguration. We did not find any misconfiguration.
>> The issue as we discovered was a link status change interrupt caused =
the
>> CSME to reset the adapter causing the link flap.
>>=20
>> We were unable to determine what causes the link status change interr=
upt in
>> the first place. As stated in the comment, it was only ever observed =
on
>> Lenovo P5/P7systems and we couldn't ever reproduce on other systems. =
The
>> reproduction in our lab was on a P5 system as well.
>>=20
>>=20
>> Regarding the suggested workaround, there isn=E2=80=99t a clear under=
standing why it
>> works. We suspect that reading a PHY register is probably prevents th=
e CSME
>> from resetting the PHY when it handles the LSC interrupt it gets. How=
ever,
>> it can also be a matter of slight timing variations.
>
> I don't follow what you are saying here. As far as i can see, the
> interrupt handler will triggers a read of the BMCR to determine the
> link status. It should not matter if there is a spurious interrupt,
> the BMCR should report the truth. So does BMCR actually indicate the
> link did go down? I also see there is the usual misunderstanding with
> how BMCR is latching. It should not be read twice, processed once, it
> should be processed each time, otherwise you miss quick link down/up
> events.
>
>> We communicated that this solution is not likely to be accepted to the
>> kernel as is, and the initial responses on the mailing list demonstra=
te the
>> pushback.
>
> What it has done is start a discussion towards an acceptable
> solution. Which is a good thing. But at the moment, the discussion
> does not have sufficient details.
>
> Please could somebody describe the chain of events which results in
> the link down, and subsequent link up. Is the interrupt spurious, or
> does BMCR really indicate the link went down and up again?
>

I'm fairly certain there is no actual link bounce but I don't know the r=
eason for the interrupt or why it was triggered.

Vitaly, do you have a way of getting these answers from the Intel team t=
hat worked on this? I don't think I'll be able to get any answers, unfor=
tunately.

>> On a different topic, I suggest removing the part of the comment belo=
w:
>> * Intel unable to determine root cause.
>> The issue went through joint debug by Intel and Lenovo, and no obviou=
s spec
>> violations by either party were found. There doesn=E2=80=99t seem to =
be value in
>> including this information in the comments of upstream code.
>
> I partially agree. Assuming the root cause is not found, and a
> workaround is used, i expect a commit message with a detailed
> description of the chain of events which results in the link
> flap. Then a statement that the root cause is unknown, and lastly the
> commit message should say the introduced change, for unknown reasons,
> solves the issue, and is considered safe because.... Ideally the
> workaround should be safe for everybody, and can be just enabled.
>
Ack - I'll aim to do that, as best I can.

I think as Vitaly notes, the read should not be introduced for the gener=
al case, in case it misses link bounces in other situations?

Does that confirm that the module option, so it can be selectively enabl=
ed, is a reasonable workaround solution. Let me know if there are other =
ideas.

Thanks
Mark

