Return-Path: <netdev+bounces-151063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F279ECA07
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AFE162B28
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434651E9B25;
	Wed, 11 Dec 2024 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mfhrjnpv"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E358489
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733911968; cv=none; b=GrVQ+Nj36xv0BeAoMHD3f63Ff38NhukLK0rKURskBhrkR3AqwQWbnr7tlKWSpvNtOq+VJzJlvhE46eJ92Nv2mGojMksBvprEDyN19bnhXGHEPMXs3ZncTlCi+K2v2EUIOsQsUIm0edsclgpCXBYyefzMf6urnSqJSknc2f31wHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733911968; c=relaxed/simple;
	bh=dr8iBEbaI684PB7Mp8Jjom83CO+SQU0tUYbFBDrxXWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C//5IVzOp0fDisCUXePwGaufaEXVujxJrf3S7hcEXyyI7eVs9egN+M5FQXDRi7z94UUQszo4yhMYNkuA/rLj1xdeBVxUjt+d7qwSsWLDerAlfbIVTMP8cxjQEQYpmnbNalXj+fWPYLYTYxl2tCJJ5CMmok3EH9Agc/SpAzojv3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mfhrjnpv; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1639E254024C;
	Wed, 11 Dec 2024 05:12:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 11 Dec 2024 05:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733911964; x=1733998364; bh=C8Q8UaP4IXaEC7oamd0Xeac4e9uQ4/t+t2T
	mCFb2+00=; b=mfhrjnpvwLdxskBLyb9C95XyOMA/3u2qvsJ5G3SAc+SVjPECShM
	gFoQnnP/hCK0+BbNJn47WjkVYmL1R7r1S/gC5rXQeyWiEJbkTSSy4/1zzCf9eVwi
	rS6LjfSYdeUKwM1qA8l42GvZMTkO/XrpzKpdEe1HZAxGlCqUAnu5JWgeeK3Yj7hn
	G3dSoqss0WLRtuOhdbfgbSTTMLflWx5I04w6jK/nD+4AIxo+kpsIABcATBkz8a+s
	JFpKF/szFOJA5/OR++MIA0fnJmcDnXx3ob1DM+wHOjoS2PNxWroyrxWeRpt4DtXa
	Ty22eCwdj/96C6h6TYoNcauQ8GMlDmpAidQ==
X-ME-Sender: <xms:nGVZZ-53p7IxeMJMf1N3pTpLglwVEqGw2M8P-V0IfHKA9fmrvqBnEQ>
    <xme:nGVZZ34AbMJW_k1HlIZzUHGIrOTwEQYxJ7FvEugKsiEW_QdomLkvCghh59WpVUuNl
    7dALFPml5bRQ5M>
X-ME-Received: <xmr:nGVZZ9fB9X-qHnAKzxV-2D1NYECxrbq_76Y2WqwUMlZR6280q4H8eFcqdh_4xPKc0AngjIvlzq9uCODy7-eVgzqD3Tk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkedtgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgrnhhnohhnrdhnvghlsh
    honhesrghmugdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigv
    thesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghp
    thhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtoh
    epsghrvghtthdrtghrvggvlhgvhiesrghmugdrtghomh
X-ME-Proxy: <xmx:nGVZZ7Ie4rCAOJ7CXpLhlSGrKv9lJwdSbnSgRkBp9QZ65Xv3rq3kYA>
    <xmx:nGVZZyLCNlwoPvVK_HTimPzN1CFHt3fsmGBOJG8NKLhKpSX8YXxiSw>
    <xmx:nGVZZ8zQ-Wntbi5oNJTcKbAM3eSrfikyya2OpfhXVlY6KxM1YJ82Kg>
    <xmx:nGVZZ2LAome1WY9aInAg2pYr8UPenqzQl6VwOXiYe3CEs6WcpcV3xQ>
    <xmx:nGVZZx_OBBaZpVh_QawQOh25NnolfFILucoRobBuJeDFqChEWqY2IbYl>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Dec 2024 05:12:43 -0500 (EST)
Date: Wed, 11 Dec 2024 12:12:40 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	jacob.e.keller@intel.com, brett.creeley@amd.com
Subject: Re: [PATCH net-next 5/5] ionic: add support for QSFP_PLUS_CMIS
Message-ID: <Z1llmJmTWBrCwjTK@shredder>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
 <20241210183045.67878-6-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210183045.67878-6-shannon.nelson@amd.com>

On Tue, Dec 10, 2024 at 10:30:45AM -0800, Shannon Nelson wrote:
> Teach the driver to recognize and decode the sfp pid
> SFF8024_ID_QSFP_PLUS_CMIS correctly.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> index 272317048cb9..720092b1633a 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
> @@ -968,6 +968,7 @@ static int ionic_get_module_info(struct net_device *netdev,
>  		break;
>  	case SFF8024_ID_QSFP_8436_8636:
>  	case SFF8024_ID_QSFP28_8636:
> +	case SFF8024_ID_QSFP_PLUS_CMIS:
>  		modinfo->type = ETH_MODULE_SFF_8436;
>  		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;

Patch looks fine, but this will only allow user space to decode page
00h. I suggest adding support for the get_module_eeprom_by_page()
ethtool operation in a follow-up patch, so that user space will be able
to query and decode more pages from the CMIS memory map.

