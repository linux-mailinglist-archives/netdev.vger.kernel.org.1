Return-Path: <netdev+bounces-155856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF9A040F9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88931188754B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ABD1DF75E;
	Tue,  7 Jan 2025 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q1B8dWpk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A81E3DE5
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257069; cv=none; b=U3rwrGwDbRM5u8i5Zvjusd8RIp4qyETnI018gZb2XZYhXhoVJ0BioQZuEBiSSPgAtOPVQC7gb7Lar6B0RIfMhES28GU/Yn3OCkV24Q3Z52zbWwUnAVNbL/3q2iaqsDa1kvjz6AWa3Gc6z8AFbE3bqCEoyIESXeiUY67DOnkBCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257069; c=relaxed/simple;
	bh=gGxz7ojXlR08VEyn1pPK6i10forrA1iqheFyguA/LuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njV996xAyTiIFKOLzklz8KKN3PsZ8uSJnABNAl84+UV4MgH/KYUUciGZ1I+/Ci8UF6Kb6QEzsWXC1zFkdbeLbYsJhT4NRSe3bkilwIta3pHw6V+1PQhwAeUoEoqkNynWyXFPb2FzY8Om2sKkeokln6w4EfxL5OTuvrowi7e5nEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q1B8dWpk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rpVm3X019L84uoYX71CodJY1YJbx09hJ4gSoQPIJsuk=; b=q1B8dWpkKroHcGjvGe0+hgODuw
	5cqfjNAxOAb/Mo5jCKbGMXe+wTFy/OAXqQO2g7dK7NxGzNgpviLfG/Lc4tgm8xNW9gQivzCiYCyGt
	zpdd6tYNihbuCpDoah71wcLVvWidfcjFx5U19wQ3SUC3g1DE6CWzV5jwEXwtVmj5p/Is=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tV9m7-002F5X-Tk; Tue, 07 Jan 2025 14:37:39 +0100
Date: Tue, 7 Jan 2025 14:37:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next 2/2] enic: Obtain the Link speed only after the
 link comes up
Message-ID: <5f143188-57e1-44ce-a70d-d8339af4f159@lunn.ch>
References: <20250107025135.15167-1-johndale@cisco.com>
 <20250107025135.15167-3-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107025135.15167-3-johndale@cisco.com>

On Mon, Jan 06, 2025 at 06:51:35PM -0800, John Daley wrote:
> The link speed is obtained in the RX adaptive coalescing function. It
> was being called at probe time when the link may not be up. Change the
> call to run after the Link comes up.
> 
> The impact of not getting the correct link speed was that the low end of
> the adaptive interrupt range was always being set to 0 which could have
> caused a slight increase in the number of RX interrupts.
> 
> Co-developed-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> ---
>  drivers/net/ethernet/cisco/enic/enic_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 957efe73e41a..49f6cab01ed5 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
>  static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
>  	{0,  0}, /* 0  - 4  Gbps */
>  	{0,  3}, /* 4  - 10 Gbps */
> -	{3,  6}, /* 10 - 40 Gbps */
> +	{3,  6}, /* 10+ Gbps */
>  };

So we still have this second change, which is not explained in the
commit message, and probably should be in a patch of its own.


    Andrew

---
pw-bot: cr

