Return-Path: <netdev+bounces-267131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WL0eNbjesmncQQAAu9opvQ
	(envelope-from <netdev+bounces-267131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:41:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51658274BD8
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0994300C82C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CF3D1707;
	Thu, 12 Mar 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kiz7YYbC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033B3B3C02;
	Thu, 12 Mar 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329929; cv=none; b=TrfRzgVPUTlahe6UTsBPkBfbIgoyh7atT7ImpUJ5o0juyVFQUo3XsieAaemJADbpAaTrh3GvKDdfpl/QPHopnrH0ooW2gJiT+WyyXW7Pta15EVv22wrzKY2bw1NLejgnOR9c6QMUIg76WvRaAvViI/pV72bRF+p8okbcdVzsNGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329929; c=relaxed/simple;
	bh=nnj4y6hGvVik0TRJ6bjhq789KNvJEx/M7/Doj1S+VvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPZvu2bq3hT/3RfQVCopH8mavTEOLseV5qikhkKy/DqfnXxEqU1Ds3+bRdWUSpj9Yo3fRQ//5xzE6KO7oK9UYqMZMuGeOG5jvridWqKfdzZiFctLdN0EnXIyERk9O0PR56o1gLbGWhV3wajeLy3BRPF8P4wSgVEMuhipOGuzEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kiz7YYbC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=A3iW59Rq94iMJ0of46dXFu361mU75QK0Mi9ODqjR2rE=; b=kiz7YYbC8J/DCCvncsRKf4mUhS
	YnOhX1MP9MRh5bXbzFZTGuyZ3abw+P/61Opku+Wnh4WcK2hhCpHGjX+sCLYt7fCvc0yYIUor8BsWK
	FZlFQCmoryGsbc/+voxkq/L5nIVyOSKj5ZAAdJ5VeYCjeckbIeoLrXMRCFIbkZcacJ2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0i7O-00BLJS-M4; Thu, 12 Mar 2026 16:38:34 +0100
Date: Thu, 12 Mar 2026 16:38:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Handle PHY reset during initial PHY
 ID read
Message-ID: <eb4bb781-18a3-4d72-8118-1c86eba9997f@lunn.ch>
References: <20260302144458.3180702-1-wens@kernel.org>
 <5f8e32e1-c73c-4a3f-a1ff-21b78f764bfd@lunn.ch>
 <CAGb2v66MY02xvA_Mvt=6O001XEgz1AVH6ePorPvNtL0s8=W8rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v66MY02xvA_Mvt=6O001XEgz1AVH6ePorPvNtL0s8=W8rw@mail.gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-267131-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 51658274BD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> I agree it's not just a MDIO/PHY problem. I am looking into it for all
> the common enumerable bus types.

Great.

> We already have the power sequencing framework (drivers/power/sequencing).
> So instead of the open coded reset GPIO I did in this patch, it would
> just be calls to pwrseq_get() and pwrseq_power_on(). I would need to
> figure out how to actually work them into the MDIO subsystem, and also
> how to model a generic PHY power sequencing provider. But the recent
> M.2 slot work [1] provides some good examples.

You need to be careful with "generic PHY". That generally means
drivers/phy and the config symbol GENERIC_PHY. Ethernet PHYs have been
around a long time, so PHY generally means Ethernet PHY. But
"recently", devices with SERDES interfaces, PCIe, SATA, USB, Ethernet
PCS have a 'phy' which needs configuring, so we gained the Generic PHY
subsystem. And we gained the confusion of PHY vs Generic PHY.

> Does that sound more acceptable?

Yes it does.

Thanks
	Andrew

