Return-Path: <netdev+bounces-170328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B679A4829D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC6D16C353
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DB926AA82;
	Thu, 27 Feb 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="UKh8opMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKGJDuEL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4B26A1A6;
	Thu, 27 Feb 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668767; cv=none; b=bMhMzm2AaBaC8w2Q6RPLfa/vAVme1nqWDQXN6njGVmqJVfEINg3vtTB/2lZOJq+9e6CzQYfYOBEhOOArmb7/6BJu0WIQ31ylOFpTT4CJV9Bi2LwnzVmoNFiNNM0ReeC8tV2Q/PmPzsqK9Nc3kNws8/KozjN3H8b17TLnuq6rCPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668767; c=relaxed/simple;
	bh=FsSkkWVRE5A+K0oLEhRfxK1WyJt0oRV08EFDZyOUJoY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=eLxBwWkefEap6BvmcePeXctl4bbtDIPa83jisN5PhLFyLnxXfkNV2SOq6L7TCsnjclPE4+5o8M46cYuuqDCnZI7kUI45a4gpVtPN3nXAyjjOBZN1a0yAA6SaDvcp7DThUWIdO/FIp1gcM0w7oZBncjcJ/XuM5aaomMkjQbPkrk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=UKh8opMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKGJDuEL; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF8E11140B90;
	Thu, 27 Feb 2025 10:06:02 -0500 (EST)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Thu, 27 Feb 2025 10:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1740668762;
	 x=1740755162; bh=mBJu1LUBZD7huyP2Fqh3L6NWg2IhYufGL+1Vn+2FDk4=; b=
	UKh8opMsCwvAVZdE00m1mCO5tFu68JmUTlO0gTbA33y00UtodSnMMEt7WGwJ44O4
	SR+kFARoU8QFWeg8YXSY2/x9udGOXve9NsZUN5MQmL/Wk+mCbho8Ssw2WeIYTgSQ
	pAgcw4903ZTkDaI9883t8Isgp1YLIMQH4oRvRSG2lsnBs+K6a5Ur1A7ODJlnLeUK
	I/ovzifLAo5Gq/0iKHBwPuSEh5Jv+TQmKGGTf4EG7kM6mWGHLDZxe/UeMohwlvoP
	TrFEp6Jgk0aQWDg8mZP1vU+lQFg6y29KhZFYtr5xMXi/EMnx2xaASfwfw17wv6NT
	xABk6kXkJzIjkFQcKNC5Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740668762; x=
	1740755162; bh=mBJu1LUBZD7huyP2Fqh3L6NWg2IhYufGL+1Vn+2FDk4=; b=I
	KGJDuELaDLLWtOxASLb+GUKGdORsAJsgXY52yQP0rK4INpJaj2/uMjLp3daRJLgT
	BM/JY+yKKYT9Bb72pRHzWT50f6Za06DrnIRrnYPkjUJfEWT5HTtFTdIW7n945EE6
	xaz3RHkNZenXRy3XlWedPmjwQZX8tcVhxPdRsXQ1jOfcNxg+weq8lJkDFX7yRB/k
	E096z1Cv6i3zHICJFIFJyuLYfR8UecxFczEOfG7OeMrAB5c/btvYM0QXEgklmzDR
	rhs80k3bse5SuoodFrLS2aEkUSORA5YolqD0GZhl5B4C3DFNjOHFTYf95A2BpgAI
	96BvzMzf5pTxyJXnhFyXg==
X-ME-Sender: <xms:Wn_AZx5xjrGS-Pyj_DdZ4huDDCN0ciJlj4rcJXU0UUDHxEPt52Ijrw>
    <xme:Wn_AZ-455SZniSlolirpV4t1_Wy88EaC46caDzPl_DJOtaSTQ58YxwMdRoI1qp1K6
    5LtZ2GtouLf6nLSvDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdforghrkhcurfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhephfeuvdehteeghedt
    hedtveehuddvjeejgffgieejvdegkefhfeelheekhedvffehnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhhthhhonh
    ihrdhlrdhnghhuhigvnhesihhnthgvlhdrtghomhdprhgtphhtthhopehprhiivghmhihs
    lhgrfidrkhhithhsiigvlhesihhnthgvlhdrtghomhdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhi
    shhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvh
    eslhhunhhnrdgthhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphht
    thhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:Wn_AZ4fWbUQBZ8lV40EH9Gxs753wjQ1Xguvqbbg-2LHGtZW53_My4A>
    <xmx:Wn_AZ6IN2ewPNHK4QfsbqiPc_DQuKCPFGBJy50WPtE96F-W2_S69uQ>
    <xmx:Wn_AZ1IeRiRkBG7KrUGTBdzzstEMpDHnmqQ2R12fB4gd5gL354FpMw>
    <xmx:Wn_AZzwxlwHNgv9SlJYs-9moKXo_z3nxzU8WgNmuVHVdA6e8ntQRkQ>
    <xmx:Wn_AZyDpmM_1D89-dk9jtROtXpAUY-bH0vuomWAWb6YCMIgDk4fNRspZ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 088FB3C0066; Thu, 27 Feb 2025 10:06:02 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Feb 2025 10:05:41 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Andrew Lunn" <andrew@lunn.ch>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <50d86329-98b1-4579-9cf1-d974cf7a748d@app.fastmail.com>
In-Reply-To: <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
References: <mpearson-lenovo@squebb.ca>
 <20250226194422.1030419-1-mpearson-lenovo@squebb.ca>
 <36ae9886-8696-4f8a-a1e4-b93a9bd47b2f@lunn.ch>
Subject: Re: [PATCH] e1000e: Link flap workaround option for false IRP events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

On Wed, Feb 26, 2025, at 5:52 PM, Andrew Lunn wrote:
> On Wed, Feb 26, 2025 at 02:44:12PM -0500, Mark Pearson wrote:
>> Issue is seen on some Lenovo desktop workstations where there
>> is a false IRP event which triggers a link flap.
>> Condition is rare and only seen on networks where link speed
>> may differ along the path between nodes (e.g 10M/100M)
>> 
>> Intel are not able to determine root cause but provided a
>> workaround that does fix the issue. Tested extensively at Lenovo.
>> 
>> Adding a module option to enable this workaround for users
>> who are impacted by this issue.
>
> Why is a module option needed? Does the workaround itself introduce
> issues? Please describe those issues?
>
> In general, module options are not liked. So please include in the
> commit message why a module option is the only option.
> 

Understood. 

The reason for the module option is I'm playing it safe, as Intel couldn't determine root cause.
The aim of the patch is to keep the effect to a minimum whilst allowing users who are impacted to turn on the workaround, if they are encountering the issue.

Issue details:
We have seen the issue when running high level traffic on a network involving at least two nodes and also having two different network speeds are need. For example:
[Lenovo WS] <---1G link---> Network switch <---100M link--->[traffic source]
The link flap can take a day or two to reproduce - it's rare.

We worked for a long time with the Intel networking team to try and root cause the issue but unfortunately, despite being able to reproduce the issue in their lab, they decided to not pursue the investigation. They suggested the register read as a workaround and we confirmed it fixes the problem (setup ran for weeks without issue - we haven't seen any side issues). Unfortunately nobody can explain why the fix works.

I don't think the workaround should be implemented as a general case without support from Intel. 
I considered a DMI quirk, but without root cause I do worry about unknown side effects.
There is also the possibility of the issue showing up on other platforms we don't know of yet - and I wanted a way to be able to easily enable it if needed (e.g be able to tell a customer - try enabling this and see if it fixes it).

A module option seemed like a good compromise, but I'm happy to consider alternatives if there are any recommendations.

>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>>  drivers/net/ethernet/intel/e1000e/netdev.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>> 
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 286155efcedf..06774fb4b2dd 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -37,6 +37,10 @@ static int debug = -1;
>>  module_param(debug, int, 0);
>>  MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
>>  
>> +static int false_irp_workaround;
>> +module_param(false_irp_workaround, int, 0);
>> +MODULE_PARM_DESC(false_irp_workaround, "Enable workaround for rare false IRP event causing link flap");
>> +
>>  static const struct e1000_info *e1000_info_tbl[] = {
>>  	[board_82571]		= &e1000_82571_info,
>>  	[board_82572]		= &e1000_82572_info,
>> @@ -1757,6 +1761,21 @@ static irqreturn_t e1000_intr_msi(int __always_unused irq, void *data)
>>  	/* read ICR disables interrupts using IAM */
>>  	if (icr & E1000_ICR_LSC) {
>>  		hw->mac.get_link_status = true;
>> +
>> +		/*
>> +		 * False IRP workaround
>> +		 * Issue seen on Lenovo P5 and P7 workstations where if there
>> +		 * are different link speeds in the network a false IRP event
>> +		 * is received, leading to a link flap.
>> +		 * Intel unable to determine root cause. This read prevents
>> +		 * the issue occurring
>> +		 */
>> +		if (false_irp_workaround) {
>> +			u16 phy_data;
>> +
>> +			e1e_rphy(hw, PHY_REG(772, 26), &phy_data);
>
> Please add some #define for these magic numbers, so we have some idea
> what PHY register you are actually reading. That in itself might help
> explain how the workaround actually works.
>

I don't know what this register does I'm afraid - that's Intel knowledge and has not been shared.

This approach, with magic numbers, is used all over the place in the driver and related modules, presumably contributed previously by Intel engineers. Can I push back on this request with a note that Intel would need to provide the register definitions for their components first.

Thanks for the review. I'll give it a couple of days to see if any other feedback, and push a v2 with updated commit description.

Mark

