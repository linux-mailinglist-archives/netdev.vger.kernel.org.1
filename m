Return-Path: <netdev+bounces-291912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD0RNN31FWqzfwcAu9opvQ
	(envelope-from <netdev+bounces-291912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC695DC073
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48AAA3015726
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC393A7F67;
	Tue, 26 May 2026 19:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sLy6HXoI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DC38C43F
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779824090; cv=none; b=Y+INUkk6QO9jF2wRCAcbffmRddl32LDTr9CyYs6f3UO5rL9NRtAftiD56sZd+xWFw/9tuHN5aPtJXn8WNulF7omuSgtPDMrQBaw2pvecJapg9BeqRNGcrlFoCaLO10ncYdRjqdqtSMyTpM2WgQ8Fin1RQiUJpC/tVAGLoY0n42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779824090; c=relaxed/simple;
	bh=gWTwLtD9AKxNV56btgzoCK0zDDUfxCrpRMaJ1Vc4T88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZ+P8UFKqqF5mQ0vNVLfighUGbYMP6T1yMhrveDYS1UErz5KHP5lo5ZwDUBU4RUpb7S463wIRx6vMgRpMG4glh5m1gs/Mc9Go+GE10zevfDSl7/bijKqe6V7OCeuDQAWCzOyrCygTe1rZ7Whj0SrkdpZYUR3IigLZqYTyqxWOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sLy6HXoI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Bjb0H3rwxizFyh7tBGMuiRLVkarQs6UmOXsga3km830=; b=sLy6HXoI696WY5B36ZRt2b9q3f
	8rMkvVKelbpBEwd4/tjpRwkP1oRUogbIAaJdqXz7vlQ1q7ly9g1gxWiPdYOPjMiGB0pKcNJXb4tP2
	PjtYrIZxtcvLrCbzX+6/9pto6kw6YbHdxVxnAiYBhvQSfl7/TYBH9uFzbefWi++MfERM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRxXx-004df1-MH; Tue, 26 May 2026 21:34:37 +0200
Date: Tue, 26 May 2026 21:34:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next 3/5] net: mdio: realtek-rtl9300: Prepare command
 runner for reads
Message-ID: <fd909957-63fa-47fb-a101-38246a18aae7@lunn.ch>
References: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
 <20260526174344.1186832-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526174344.1186832-4-markus.stockhausen@gmx.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291912-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 6DC695DC073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:43:42PM +0200, Markus Stockhausen wrote:
> The command runner can only be used for C22/C45 writes. Enhance it
> so it can be used for reading as well. For this.
> 
> - Enhance signature and add pointer to return value
> - If pointer is given, read back the return value from read operation
> - Hand over NULL pointer for current write consumers.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index a1870b16d8b9..6f4affe0696d 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -139,7 +139,7 @@ static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus)
>  }
>  
>  static int otto_emdio_run_cmd(struct mii_bus *bus, u32 cmd,
> -			      struct otto_emdio_cmd_regs *cmd_data)
> +			      struct otto_emdio_cmd_regs *cmd_data, u32 *value)


> +	if (!value)
> +		return 0;

> -	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_WRITE, &cmd_regs);
> +	return otto_emdio_run_cmd(bus, PHY_CTRL_TYPE_C22 | PHY_CTRL_WRITE, &cmd_regs, NULL);

Optional parameters like this which change the behaviour of a function
is not great.

It is better to have two functions, with a helper containing the
common code. So otto_emdio_write_cmd() and otto_emdio_read_cmd(). They
can then OR in the PHY_CTRL_WRITE or PHY_CTRL_READ.

	Andrew

