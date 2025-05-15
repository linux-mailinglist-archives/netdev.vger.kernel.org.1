Return-Path: <netdev+bounces-190789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF064AB8CA8
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B5B4C1F7E
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C2821FF4A;
	Thu, 15 May 2025 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="mXHa/0sO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kg2V8KH6"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D141A23A0;
	Thu, 15 May 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327165; cv=none; b=pVdUKJBIy3P5zDqyWxY5JUayuQ+aV6iX45M0vA53yFbrNBy5tO+VIiA18Cuq5+OfHoscos4O/rsbDBbOdspwmW0VMG49xaj979G1mtwqaJdFMHaSds/PStLVCQ0JwCkLtiqk2tag4+mVNiwW/kIjEtYMbiiHap3Lt7KgBiCC/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327165; c=relaxed/simple;
	bh=bf/5eNWWqxpBTtP5CmsZ7uYW0SswgtURauqtQUncWYg=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=IfBMmyiZpzuDxIcy3c9Rw73oT6yesP/tnBDxMh7e05rGEBLFqk4AmlSbS1z83UGRGQAGs5Rv+Na3e7PjnIJ0+Vv4RBg1HzErz2zo5UqOjtExb2npiFWRI3n+hADaUIaRCJknVHbLcoonCIfLkq8EEdT5DB60W1JzDYJf+wCVhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=mXHa/0sO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kg2V8KH6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07B1411400D6;
	Thu, 15 May 2025 12:39:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 15 May 2025 12:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1747327161; x=1747413561; bh=9MZRsCtbfmSZvgu05QhQU
	f8J6+oYqfPBShdTaMmsLD8=; b=mXHa/0sO94qp7UlCzWCKd7lhj7w6pNZbbC1oB
	ahY7+bqdJtFVRFvSqbSljDXPWZ8/+npabHgjnQvQc/HwQYH72EZPXbGye3FujXFc
	sM8F/Ty3ZeG86AvZQgGVGNFlTmFqQIB5Fzk6j/EyI74vStJFPSS4j+vZL/TAspBl
	1ftSNHZkDfV1vAxbEMH8qCNU+6kwQQOz8NvWwDYLK31KLHBjahYWFKJVsFv3Egsm
	sAHDryFLtzgQuRE/9YWwh8ljUEup61yZG1pbxkR/zX0e02RdlgY3JlvozfN9QjDO
	ZML/Q2w8nHraZFJ81BrrOF+baTi1oBy6gl5MUIojbQfBWncvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747327161; x=1747413561; bh=9MZRsCtbfmSZvgu05QhQUf8J6+oYqfPBShd
	TaMmsLD8=; b=Kg2V8KH6f8hiS2JFZCLgqEDlo7WhLuPmfdrHA04gKqYN9Vm7epJ
	WjmMph8T7c7DonVxr7aHCJxVBclUA/LouJJK7CaqdJAKNg5ZEl9vRSoDOdytXVhb
	YrMGbYA/i09h9rvnhCaVdLkKnMmi9CFCVIHI+zo9Hbx7LaneIgO3FNBVEcIlRk3k
	Ds4g4adOHrYKAHNaX2o7fEXjL+jxtsJ6r4bVWzUJjmZEh6WIiKcnw4Vp7Q5XcdT2
	ypHRcOL2hEUccpi3sO0g6rzFooDRDv1TE1WnsQ6H01ynrxBSIJTeq84qhm+DuKoF
	ll1Q4DUTUEb1ZsiRhk6OOJ0dFc9h8W2prdQ==
X-ME-Sender: <xms:uBgmaFY0i-nk9-q0xEVguiWCEAIV7TPkGnZIIJgroG5WNhbbisEsAA>
    <xme:uBgmaMaoiJy5GAqXhjbe_nKTNjwYnlKJOKtaEsIIzrFgdy4fDRlMNzO6q5qKpesTl
    i8KbF50mmwzFUNfV8w>
X-ME-Received: <xmr:uBgmaH8Yuq-D0ac_fjI_WRDqx4HdvSpd7mXeOoqjIW55W51PK1h9Tb4gGegRFKydGGXLHmUr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghfofggtgfgfffksehtqhertder
    tddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcuoehjvhesjhhvohhssghurhhghh
    drnhgvtheqnecuggftrfgrthhtvghrnhepieefvdelfeeljeevtefhfeeiudeuiedvfeei
    veelffduvdevfedtheffffetfeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhnsggprhgtphht
    thhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvh
    gvmhhlohhfthdrnhgvthdprhgtphhtthhopehsughfsehfohhmihgthhgvvhdrmhgvpdhr
    tghpthhtohepshhtfhhomhhitghhvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhi
    rhhisehrvghsnhhulhhlihdruhhspdhrtghpthhtohepshihiigsohhtodehfeegkeehtd
    ekiegrgeduuggssgegfedvjedtrgesshihiihkrghllhgvrhdrrghpphhsphhothhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:uBgmaDr0NQDd5yW2BZ5BZopmH7_oMaygUn_Yr5XmV9DYf8_yXFaUTQ>
    <xmx:uBgmaArdID4fHb3R0zrjwFPVdIJej6hL1YVuP653z7nhYotTWgxPFw>
    <xmx:uBgmaJS1s-zeLB-Ea2vOpjoF7g1u5rBu98KfCLd5DJslghfrgTr6hg>
    <xmx:uBgmaIrZtGyoo3KrPqGVY0OW97QywT4x7BsBQuxyLpDt_43TEpQ63g>
    <xmx:uRgmaC3kBFt1JukR3LdbnTNTaV00I6G9YvIupMhTe7P5uxYS9lI-YNUe>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 12:39:19 -0400 (EDT)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id 74E2B1C038F; Thu, 15 May 2025 18:39:17 +0200 (CEST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id 72E531C0349;
	Thu, 15 May 2025 18:39:17 +0200 (CEST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Stanislav Fomichev <stfomichev@gmail.com>
cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
    davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
    jiri@resnulli.us, andrew+netdev@lunn.ch, sdf@fomichev.me,
    linux-kernel@vger.kernel.org,
    syzbot+53485086a41dbb43270a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: grab team lock during team_change_rx_flags
In-reply-to: <aCYUezCpbcadrQfu@mini-arch>
References: <20250514220319.3505158-1-stfomichev@gmail.com> <20250515075626.43fbd0e0@kernel.org> <aCYK_rVZ7Tl7uIbc@mini-arch> <aCYUezCpbcadrQfu@mini-arch>
Comments: In-reply-to Stanislav Fomichev <stfomichev@gmail.com>
   message dated "Thu, 15 May 2025 09:21:15 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47314.1747327157.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 May 2025 18:39:17 +0200
Message-ID: <47315.1747327157@vermin>

Stanislav Fomichev <stfomichev@gmail.com> wrote:

>On 05/15, Stanislav Fomichev wrote:
>> On 05/15, Jakub Kicinski wrote:
>> > On Wed, 14 May 2025 15:03:19 -0700 Stanislav Fomichev wrote:
>> > > --- a/drivers/net/team/team_core.c
>> > > +++ b/drivers/net/team/team_core.c
>> > > @@ -1778,8 +1778,8 @@ static void team_change_rx_flags(struct net_d=
evice *dev, int change)
>> > >  	struct team_port *port;
>> > >  	int inc;
>> > >  =

>> > > -	rcu_read_lock();
>> > > -	list_for_each_entry_rcu(port, &team->port_list, list) {
>> > > +	mutex_lock(&team->lock);
>> > > +	list_for_each_entry(port, &team->port_list, list) {
>> > =

>> > I'm not sure if change_rx_flags is allowed to sleep.
>> > Could you try to test it on a bond with a child without IFF_UNICAST_F=
LT,
>> > add an extra unicast address to the bond and remove it?
>> > That should flip promisc on and off IIUC.
>> =

>> I see, looks like you're concerned about addr_list_lock spin lock in
>> dev_set_rx_mode? (or other callers of __dev_set_rx_mode) Let me try
>> to reproduce with your example, but seems like it's an issue, yes
>> and we have a lot of ndo_change_rx_flags callbacks that are sleepable :=
-(
>
>Hmm, both bond and team set IFF_UNICAST_FLT, so it seems adding/removing =
uc
>address on the bonding device should not flip promisc. But still will
>verify for real.

	I think Jakub is saying that adding a unicast address to the
bond would change promisc on the underlying device that's part of the
bond (a not-IFF_UNICAST_FLT interface), not on the bond itself.  The
question is whether that change of promisc in turn generates a sleeping
function warning.

	FWIW, I think an easy way to add a unicast MAC to a bond is to
configure a VLAN above the bond, then change the MAC address of the VLAN
interface (so it doesn't match the bond's).

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

