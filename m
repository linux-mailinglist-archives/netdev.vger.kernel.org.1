Return-Path: <netdev+bounces-207343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B25DEB06B48
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 03:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F9D189359C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E222676DF;
	Wed, 16 Jul 2025 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="BY4N73qG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+Uedxzu"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E95376F1
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752630250; cv=none; b=kA4MOg+yL6/8gAv8i4Hh9+PXPJSaph77dX4/SiKidrW250I5HuiMplh25W/ZZmUrQfGyytyiVTuXMW8F3GV6YfU/wUBSwLahwFxms6w/B5KAZY4MXJ3Zml9P1BL9TRA+URdxtKXWXdlfn9sVXc0/xFVH8ugvGWv/9Nu6CC4O8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752630250; c=relaxed/simple;
	bh=lsh0ZP8BFypEnpWnD1v+SD42g+eC8pgzK8dXSRLnQec=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=MRaHaUL47t5YJ6J6AdhSBNBPgKKncQ0mrXz+v4XdRw9dJPDSRhiSvEd6B3bDzr2Tf3epPxlzCjkZNAag9LCXCUfEv6l4R5ic+lWyN9N4pNdZWUBSOdM7GSQrKko98EFH1lT3HaF1bDCG4htyKpkNutWkqlIag078axOQ8Yuy/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=BY4N73qG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+Uedxzu; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 3900DEC00DB;
	Tue, 15 Jul 2025 21:44:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 21:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1752630246; x=1752716646; bh=iP3EyNriSPnBrtm15Q16hcuXGYp3sDVI
	+iVu+X1V7no=; b=BY4N73qG+Kvhg7kp9JhuwbCxGvuaxerIU/Bw87QRci+dg53N
	84L7W+aeHL5jUj0maMMm9wYhW00GnCtfObb6T4aUIN2k2aVkYJXNgJtbZP6M3q83
	sVLkoP50E2QigGhOsG695NwffahDcV5fcJQr5p0b3hKKiIgaw6SR5NUpg0F8x6MA
	xMMqk3cCogAnUJfW7GZdIT7qMKw3H/p9w/VYWbUjh5MAwnkT8GnVvqRr3o7whcA+
	HpeTP47TqJoTiXiR4ga0EMjIWRk3EOHmyuU5RP9XpO2Hj9dAowdye+pdAUDKReg9
	U2WB7DsVMbHuPOjq/WojCRMOSFF4q2z7wOu+EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752630246; x=
	1752716646; bh=iP3EyNriSPnBrtm15Q16hcuXGYp3sDVI+iVu+X1V7no=; b=c
	+UedxzulyU+SgVk/KUm+K55jAPI2TRVqODsa/Dt7gS9cgtNKdRzgs5DOz/5RBW6e
	D3BqmYsuc5Mv2pJPQ2sxEyIcmINulFEH8Sr7KonDQ6wfoIUB6yu8zMz9nD3RgaNN
	N7SUY28iuu1c0fCeMkywm7Wt0ZWkdbWFqFXKnZQl1zyHdnHS/imygU5kJng9eCfP
	EKZ4du7vdVwHLfWA92kBvi+fXwkcwweq+B7FYI2bxAKXlCKwZRcCYYAoaJHLrR+7
	jrDuZCBWj7Slb70Cusj7+x2+JCjx5TvZcaPX/kFAxrpyLDIhiU0zReDalk0/GAj1
	EjjXc8boOdzYL9e9AacoQ==
X-ME-Sender: <xms:5AN3aDyV7GIOVl8O1uG3i57onaCSU5DuTMFtvIQ-Tq_xjZL7uScwng>
    <xme:5AN3aPqrcBDHsmv2rOZ22M1Hcn9OmHfj-b-0Oc_O_gn5lxhBpFwOh9DiaD7JMRQ0Y
    31-QduU5DRNjLoPm0w>
X-ME-Received: <xmr:5AN3aLMSosOn_ad8VMikzG4ItM2gDYg9oJAVcGK1Z-5dAPQsuENMv8UMxpwROJXw8N2jvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehieegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtjeenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeegfefghffghffhjefgveekhfeukeevffethffgtddutdefffeuheelgeelieeuhfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehtohhnghhhrghosegsrghmrghitghlohhuugdrtghomhdprh
    gtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggr
    vhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehtuhiivghnghgsihhngh
    esughiughighhlohgsrghlrdgtohhmpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgs
    rgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslh
    hunhhnrdgthh
X-ME-Proxy: <xmx:5AN3aLdeXaYrGEu1_3I37uSt-Vlo_ZuFiCie5Je92A2wYClng74sRQ>
    <xmx:5AN3aJWPjOaj7m9Zjf0rkOX3k7y7t-VUaXC5pBD5TtGvk-IyHhUOiQ>
    <xmx:5AN3aEAOzs8qCJgnuBQvfJUXVmiksq_Xb6VF_tJq3YfR0B-nqirKSA>
    <xmx:5AN3aM4P9JCtwLRwOmEQqFCrXAufwtu1BRMyu7oXNSEiN0ErXcFgbA>
    <xmx:5gN3aNJEwp0mowhefDmc5k_jJE0r5Z_9J669twEWJYT4-q0_-2sfJeg8>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 21:44:04 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 38CAB9FC97; Tue, 15 Jul 2025 18:44:03 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 37A719FC54;
	Tue, 15 Jul 2025 18:44:03 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Paolo Abeni <pabeni@redhat.com>
cc: Tonghao Zhang <tonghao@bamaicloud.com>,
    Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
    Andrew Lunn <andrew+netdev@lunn.ch>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Zengbing Tu <tuzengbing@didiglobal.com>
Subject: Re: [PATCH net-next v2] net: bonding: add bond_is_icmpv6_nd() helper
In-reply-to: <3d2568b9-e275-490d-a412-2fe7a5b096a3@redhat.com>
References: <20250710091636.90641-1-tonghao@bamaicloud.com> <aHSt_BX4K4DK5CEz@fedora> <125F3BD1-1DC7-42AF-AAB4-167AD665D687@bamaicloud.com> <3d2568b9-e275-490d-a412-2fe7a5b096a3@redhat.com>
Comments: In-reply-to Paolo Abeni <pabeni@redhat.com>
   message dated "Tue, 15 Jul 2025 12:33:53 +0200."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jul 2025 18:44:03 -0700
Message-ID: <758111.1752630243@famine>

Paolo Abeni <pabeni@redhat.com> wrote:

>On 7/14/25 2:53 PM, Tonghao Zhang wrote:
>>> 2025=E5=B9=B47=E6=9C=8814=E6=97=A5 15:13=EF=BC=8CHangbin Liu <liuhangbi=
n@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>> Hmm, I don=E2=80=99t see much improvement with this patch compared to w=
ithout it.
>>> So I don=E2=80=99t think this update is necessary.
>>=20
>> This patch use the skb_header_pointer instead of pskb_network_may_pull. =
The skb_header_pointer is more efficient than pskb_network_may_pull.
>>  And use the comm helper can consolidate some duplicate code.
>
>I think the eventual cleanup here is very subjective, especially
>compared to the diffstat. Any eventual performance improvement should be
>supported by some figures, in relevant tests.
>
>In this specific case I don't think you will be able to measure any
>relevant gain; pskb_network_may_pull() could be slower than
>skb_header_pointer() only when the headers are not in the liner part,
>and that in turns could happen only if we are already on some kind of
>slow path.

	Does the ICMP6 header of a received packet end up in the linear
part, or in a frag?  That's what's being inspected by this code, and I
presumed that the linear area would be just the protocol headers
although thinking about it now, I suppose ICMPv6 is a protocol, but I
don't know how often the pull of the ICMPv6 message data would have to
copy to the linear area.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net


