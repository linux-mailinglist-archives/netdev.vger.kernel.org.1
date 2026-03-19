Return-Path: <netdev+bounces-269539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PReLgYovGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:44:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 383D42CF05C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0957E3177692
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46043E959C;
	Thu, 19 Mar 2026 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FLtO8zzh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D03ECBFA;
	Thu, 19 Mar 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937785; cv=none; b=n8v+LuIGpqB7DY/+PJkH21XBgE/HvFk+souXju4Q+SRoT3stpzoNh8va3kSyTQlG2b+XiM7LE5cDLpATXLDqAnvz32rlYTyJg4o+Of9aTqJZI6Ugqditf4kJsI4HQaqMXs+VarUWSxIk0B+Kvn8o4x5GCbpx+A12eWsYdjxoXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937785; c=relaxed/simple;
	bh=cLg1mxABsqTXm6/LqWoGIcU9uDV0pgkgZMVb0/SrzUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgRqGI+mS8zCPqhw/0W5D1MB9JxzfqA1D0dVTUF06T+5LFc3VMH+Qk5HpNzSDsUwDXenycQgLS2UXOU4F9Jlh4+p8DAsXpPh3D1CaP0kd1CBpaOApVSZRfPIHa2MnsgE+iSp2sn3G6f/Pv75KOmMZPF/9fhvMhP7RltwN8ziua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FLtO8zzh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3QDjeYDJRij/oqghj/n7hihwJOYcYJc8bDcHllbXJZQ=; b=FLtO8zzhTn8/B+JQZYL3JDjF6h
	MIQ1basL/BXn4A/E8AY7RsMGNvKjKUtKPJdaJpWAaHS8dfXv1FX+vvhcZFiLyIzZ9//5ze4Jltr/h
	2cz+9koa7qL/V2jAqo3LPr8R19dRVfsXoy81clzZr511I1LsYFpmHNBTN+ycDpGvly2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3GFU-00CPic-8E; Thu, 19 Mar 2026 17:29:28 +0100
Date: Thu, 19 Mar 2026 17:29:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Message-ID: <9efbf132-f367-487b-aa66-8a9610d91d2d@lunn.ch>
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	TAGGED_FROM(0.00)[bounces-269539-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 383D42CF05C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 07:07:14PM +0100, Birger Koblitz wrote:
> The RTL8157 supports 5GBit Link speeds. Add support for this speed
> in the setup and setting/getting through ethool. Also add 5GBit EEE.
> Add functionality for setup and ethtool get/set methods.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/r8152.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 3b6d4252d34c63ead8f11a120e212325a5f7d505..bab8e10e5f99afcb332e333c2739ed7509b03419 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -604,6 +604,7 @@ enum spd_duplex {
>  	FORCE_100M_FULL,
>  	FORCE_1000M_FULL,
>  	NWAY_2500M_FULL,
> +	NWAY_5000M_FULL,
>  };
>  
>  /* OCP_ALDPS_CONFIG */
> @@ -725,6 +726,7 @@ enum spd_duplex {
>  #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
>  
>  enum rtl_register_content {
> +	_5000bps	= BIT(12),
>  	_2500bps	= BIT(10),

Any idea what bit 11 is for? There is not normally any speed between
2.5G and 5G.

> @@ -9934,6 +9979,11 @@ static int rtl8152_probe_once(struct usb_interface *intf,
>  		} else {
>  			tp->speed = SPEED_1000;
>  		}
> +		if (tp->support_5000full &&
> +		    tp->udev->speed >= USB_SPEED_SUPER) {
> +			tp->speed = SPEED_5000;
> +			tp->advertising |= RTL_ADVERTISED_5000_FULL;
> +		}

Let me check i understand this.

ethtool supported will indicate 5G, independent of the USB speed? But
it will only advertise 5G if the USB bus is USB 3.0 or higher, which
can do 5G. The user can however use ethtool to advertise 5G, for USB
2.0?

I suppose the question is, are there any link partners which do 2.5G
and/or 5G, but not 1G? I guess not.

       Andrew

