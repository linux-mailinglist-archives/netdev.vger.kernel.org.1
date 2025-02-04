Return-Path: <netdev+bounces-162581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CEBA2747F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33B61885E29
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E92139C7;
	Tue,  4 Feb 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vzg/txQ4"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364C213E60
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679909; cv=none; b=W7t4G67mCiyAU3xH2w61NkD2yLasEtgLTFqLJFKk8m5xd7psB91p4Gl2opu058lyXdY26wGyVweAuIf6DbtnzUcgvxsbRhZbJA+6/v6e+NfeDMrisH8pSo5VfTFGNaOEomg7mzuqCdFbwpcFaj6HSy7uFhJWudrvmxtE8ARdB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679909; c=relaxed/simple;
	bh=vfX8+mFcQ4UC2Df2hYwgNUEPhP70RqTr+bN6o6OeM0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU0AZihVQD6rU0IMgPNguhLW/K15gakVLbJxU10yiojCPK0FTxXEW7Ccw+nRo85IlnrWPu10R7E23X3CW6ZY5FgnjjWPj7XE/2q5RlIUipp8RmgMquX+QQdTtpplYXoIc6UIorNG6u23yvZWh/ICnPHWl6k9Jb/7Ux4iRSfVjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vzg/txQ4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A25BF254016F;
	Tue,  4 Feb 2025 09:38:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 09:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738679906; x=1738766306; bh=vfX8+mFcQ4UC2Df2hYwgNUEPhP70RqTr+bN
	6o6OeM0A=; b=Vzg/txQ49t3OEf8OXmQMvvFRmnwCByeuqpvFxUJVIgVAN9YqQe2
	aNIHsyG9p4AlUa5FvDTAXUPEo4ISuITqsg17Va8f3C1YhsyCsc18xxXOVeMMHSMk
	ExeQuvM837Xv5hSaizllQdahvwHiMbxNtQh1qUUHWf4PxtgbfUR6DbRPXnYusYe6
	lk+Qwir1HUgLKYazrs52m+7UDE7CU60NUsyZMuzpJDfWVMq7xSwrhW9DJt04pZLJ
	839ncrLBVQgTbfjo1vPsR4pDVmKdR6BDxQo+Dh0t4xz5oXENzzeUvu5w/quNSAQb
	GPM1O5nKdNB1YO1JETSoj0u7e/QX1hVPe8w==
X-ME-Sender: <xms:YiaiZwYskJums9Pm3JPNa256foTT262dk3U3OS8g4DTw2b46H98O_g>
    <xme:YiaiZ7Y-btXa5BuS6voEFIOfcy14PJB6asU-1lNoIIUYFx70iIkQ7ptJCs6jEiLrK
    YH0TVcv11iiwq4>
X-ME-Received: <xmr:YiaiZ6-PcIeW8w678n5MbF5FszyUekpPL3Hs_D7bnMYAc-SiuEiaN8rGHaWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiinhhstghntghhvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YiaiZ6rTO0iY_U8XBiUzlFEPwJlq0eYb0oMREDEhcyzTDrzPx95hkg>
    <xmx:YiaiZ7qfn0r9d3Nf29Yr87dYHGMDdNLh78M2HfYtnB4ke6SnmVpN8g>
    <xmx:YiaiZ4S61jvF8cMhRzeSDQl4-h_xxW2vdqy0Y_QAN5T-p4iXWH-_VA>
    <xmx:YiaiZ7qTTUI9S6Jh_frBEIQcH1GSJ7YwmDYpszuo1oTiHdgYTiS1Sw>
    <xmx:YiaiZ8eeGH4VXXYNjUkGUEmbAogm2aiat7vKnfh3dDKuRsqp_7jZC3xH>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 09:38:25 -0500 (EST)
Date: Tue, 4 Feb 2025 16:38:23 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] vxlan: vxlan_rcv(): Update comment to
 inlucde ipv6
Message-ID: <Z6ImX7hAB44uUrI0@shredder>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113422.107849-1-znscnchen@gmail.com>
 <Z59gc6--yjT6nLCE@shredder>
 <Z6ISkVTHtknDTPGn@t-dallas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ISkVTHtknDTPGn@t-dallas>

On Tue, Feb 04, 2025 at 09:13:53PM +0800, Ted Chen wrote:
> I'm ok with either way.
> Please let me know if I need to send a separate one or the current one
> is fine.

Yes, need to resend as a standalone patch.

> > Regardless, please submit this patch separately as it's not related to
> > the other patches in the series.
> I came across this comment when I wrote this series as I found vxlan_rcv()
> is called for both IPV4 and IPV6. Besides, I saw vxlan_err_lookup() has a
> similar comment.

OK, so it makes sense to adjust the comment like you did.

