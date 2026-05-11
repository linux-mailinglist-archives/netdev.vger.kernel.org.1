Return-Path: <netdev+bounces-286808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBQTLKovAmq/ogEAu9opvQ
	(envelope-from <netdev+bounces-286808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:36:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD7D5152A7
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8B6430091C2
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EC421F07;
	Mon, 11 May 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bejZMFl6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BA2BDC0F;
	Mon, 11 May 2026 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778528165; cv=none; b=L/LlkoUjKUyu1pqIP1UOfSsEKCFVTIxHe/oqc2IywTrYr7PBMn0DUnzCCGnK3ySK8ratT9CfqU0mYnEdT380kDvakr41HPcGH4dlG1EvEWKDGVcHKQtsjNmS/HcQ6cerm+LdXgy9Qxv4r2hH/c0hiw4VdgkTWjQmZc6JMy/eYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778528165; c=relaxed/simple;
	bh=hQSkkwzCfNAMH7kHFwKb+83wyG31MR6NQcbvr3vjYcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxE0oR6f+8FLECI2ZT2Rz305u+/cSi3fDQo7jNw+wlPy4jWzCw+tGPoCKLYT/3Thm2a+2B22Fv4X7MbSBV0Eq2WIg3o82leWtkBeYkkCuL7haDNQXe7InItL1EPXNSDY7a+K87tVC8SblCbaqtTY7qjtisOuE580TLw7pup228k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bejZMFl6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uIRZJaArygQNCwI5RvJVEGiNfdj9XU/Z8WSYLhucm0M=; b=bejZMFl6Ym2oiLPE8NVoK9dtBj
	cYhtKlLG6snwxJQKoIshbnI27paLNIg/WkehXeia+loAPoIbLj6w8rzL8mJEpQs5ShJILW7yjViLN
	4l5pfzKhg3PGorG0WF/DTGpRjtcQcg+itaJ47F8/NC8HZdgypaAihsajvo5Bop+MnbY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMWPx-002QjL-KU; Mon, 11 May 2026 21:35:53 +0200
Date: Mon, 11 May 2026 21:35:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"parthiban.veerasooran@microchip.com" <parthiban.veerasooran@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/9] net: ethernet: oa_tc6: Adding vendor
 specific MMS
Message-ID: <066bf036-715c-45d3-a817-f2719eb5d9d6@lunn.ch>
References: <CY8PR02MB924967FCDC5FE1A541D4DDC683382@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB924967FCDC5FE1A541D4DDC683382@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: ABD7D5152A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286808-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> -static int oa_tc6_get_phy_c45_mms(int devnum)
> +static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
>  {
>  	switch (devnum) {
>  	case MDIO_MMD_PCS:
> @@ -456,6 +470,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
>  		return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
>  	case MDIO_MMD_POWER_UNIT:
>  		return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
> +	case MDIO_MMD_VEND1:
> +		return tc6->vend1_mms;

MMS 0 would be against the specification. So i would do

	case MDIO_MMD_VEND1:
		if (!tc6->vend1_mms)
			return -EOPNOTSUPP;
		return tc6->vend1_mms;

That should catch uses of VEND1 without first defining the mapping to
the MMS.

	Andrew

