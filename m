Return-Path: <netdev+bounces-155666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7F9A0351B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AB418863F1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E45618EAB;
	Tue,  7 Jan 2025 02:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="MpHcOrot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s5lqRCUq"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D32594A5
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216816; cv=none; b=htyv5/jsB0/Xiez18kQq8VYf50cE8rTsNX2vT1+/g9YOirR6Kt6cGaOeQqhFPLHwRX3R08kUrHPWjC1hX0UjIrgnxX+hJFuPY73oGXHGS8IWPWOlFuzYX8lhWL8bgi/4uB8bZ5DyWvnjrDsjEPEsr9FldgUq950/cRtopRpCfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216816; c=relaxed/simple;
	bh=bQbQMWK0aUkiik62aEGXlaIGG4RDgYF2EI9bVDLoWm4=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=d1Z4ONYMR7b6ZWREpdoUVIUkgE4P28VU4zIHqblOlXepcwF/sI15Q2I6neunFEes1IXVZ/4dkXCPNsGorvjWvnWw7ogpNtfSb3P17gqve/2HwxSKtU+fYIQZvIKY4IhROfXlYCLN70Wg5wqeLWj4ntLCjuc2p/vvyGxZZCO3oZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=MpHcOrot; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s5lqRCUq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8078113801A5;
	Mon,  6 Jan 2025 21:26:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jan 2025 21:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1736216812; x=
	1736303212; bh=QA2y5iyi5Wyx4fYvh027GtCGGf2e01dOWfLv0jVIM7U=; b=M
	pHcOrotSqFU0aDS49j696IeZIaR1aLbROu23VngWJbtUD/HVuKjGSDP3TtRA44Vh
	ixxWDPGsDEf1nYHMooTxrkuc8UETxYrHSV0ekKXSLwGIDElXfiGOzkLiUjCV9lHH
	SvVcXF4I3MMeZZGjUOns3RvjSyVoiqp2nJHE/kCSzM17Tq+YzNnmiN4SCO8C7Xfs
	EmGYsivsig88TR7K816CysFVdfwdUEe3emct26bET/AlENITFtyNIbRgF+e30vgG
	we1kMBx3hoBDvUZoVgjRAaIfeNTuJ5bUd1x/E5e//dsxzgo8muWisGYkgQtSHaJf
	3N/4tlr4AOHw3Yr+5VyMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1736216812; x=1736303212; bh=Q
	A2y5iyi5Wyx4fYvh027GtCGGf2e01dOWfLv0jVIM7U=; b=s5lqRCUq6hbddIMt9
	DogrPspr1OHp2roxh0Kx76fzWjHjdQymDdEfhcQO2b1bt2pYeLMcKQKcO06fGGZN
	FAxYpO49UevyHDi565JYM3ApojK3/s3hfjMNE8cK/1adkIi7hJ9OyGzws84oVFlg
	skfE44iMfUosvv9ctCaAigcfxQV+MeoacZWNNnnT52fgVZW8UFWhPfSfGszGwaq6
	TaibjwkjnQDseydRd8FwDWK3JsphQPxiTYyouD2dfVPTwC7aADc9AXBYQtATwFEe
	VGedyMHlhWcIA/pQ/NBcL3y/kIxA4WBIEedF/kf2S0uU5TzsOrgHoWSU2K0g+DPY
	6vN/A==
X-ME-Sender: <xms:65B8Z2bPa3xHl8KA6NrML_TK6Hv3bCW01Lc76Ign1RgwXlqCWgE_ug>
    <xme:65B8Z5YOO8RaI3sqEON7YVOOasErLjUKOWD3kBcT39VLW69xZyK6JURQkc-vY9WDd
    53fClweZVGbZ8dN07Q>
X-ME-Received: <xmr:65B8Zw9S6Bn_oTs7lPyCiz7JzK_VnNBGUW4-K7ggFdCX79QjC6Xpeu0vx-WdUMNE12jy2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeguddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhfogggtfffksehttdertdertddvnecuhfhrohhmpeflrgihucggohhssghurhhghhcu
    oehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnhepjedvgffhte
    evvddufedvjeegleetveekveegtdfhudekveeijeeuheekgeffjedunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrgh
    hhrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheprghnugihsehgrhgvhihhohhushgvrdhnvghtpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfido
    nhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:65B8Z4rWW66deaRb05bTjoIHSzTcrKNFL4pa_CpJ2cDYKUyOIAB7Qw>
    <xmx:65B8ZxoZVm9plVKgl8NCUwONc3rnVlsM3CmBIscwhMu3ce5cjeAFnQ>
    <xmx:65B8Z2SoFPPcXXCG41t0iA0WtDxb9V1rWglU37ySsyuSVWlwOa5Ctg>
    <xmx:65B8Zxoc43WfLL-AN3zF9XEp1PkcQbSfSotN2EeIpH1KWv8z2KRXsA>
    <xmx:7JB8Z1fcG2vjtbGp3-EL6aacIKcqnphLjS5n8lMIJ23DvV3umdVkVqja>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 21:26:51 -0500 (EST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 6D8849FCAE; Mon,  6 Jan 2025 18:26:50 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 6C9639FC8D;
	Mon,  6 Jan 2025 18:26:50 -0800 (PST)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Jakub Kicinski <kuba@kernel.org>
cc: Nikolay Aleksandrov <razor@blackwall.org>, andy@greyhouse.net,
    davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
    pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net 3/8] MAINTAINERS: remove Andy Gospodarek from bonding
In-reply-to: <20250106153441.4feed7c2@kernel.org>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-4-kuba@kernel.org>
 <2fda5a09-64da-40a4-a986-070fe512345c@blackwall.org>
 <2982753.1736197288@famine> <20250106153441.4feed7c2@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Mon, 06 Jan 2025 15:34:41 -0800."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2998734.1736216810.1@famine>
Date: Mon, 06 Jan 2025 18:26:50 -0800
Message-ID: <2998735.1736216810@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Mon, 06 Jan 2025 13:01:28 -0800 Jay Vosburgh wrote:
>> >>  BONDING DRIVER
>> >>  M:	Jay Vosburgh <jv@jvosburgh.net>
>> >> -M:	Andy Gospodarek <andy@greyhouse.net>
>> >>  L:	netdev@vger.kernel.org
>> >>  S:	Maintained
>> >>  F:	Documentation/networking/bonding.rst  
>> >
>> >I think Andy should be moved to CREDITS, he has been a bonding
>> >maintainer for a very long time and has contributed to it a lot.  
>> 
>> 	Agreed.
>
>Sorry about that! Does the text below sound good?
>
>N: Andy Gospodarek
>E: andy@greyhouse.net
>D: Maintenance and contributions to the network interface bonding driver.

	Looks good to me.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

