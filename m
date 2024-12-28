Return-Path: <netdev+bounces-154405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6723A9FD867
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011BC3A1E60
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE1BA3D;
	Sat, 28 Dec 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DlM/aJNu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67413FD1
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735346193; cv=none; b=Yy7Hj83Po7Peb7Z/W1GH4ytrYiYcJddNXt4Trzm8Zyzk6X+kAhx9iLDANa1EVz9byxeXXovQKrb6T1lxkmVthxb+Vv7SzFhOXPc5HmBhkNQl9II7IXVlprOSOHBNvEiNd55sPAbbNu2TDtayHJsW6hi55Mxb5mkrAfIa/JMDkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735346193; c=relaxed/simple;
	bh=fQHC/9sj9iiYtTu5S+djSBsdTTDlnEiiui8Kk6E8y1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knmDr+2MgIAKWmqF2aS+Tv0QPIAAB5SAeocNqqRmT4tb/ofDKtnMPLY+SGjMjJVUoaEuRic5CdysbX9NZMOEioWK8ZJ9R0Uu/KpcRFxSG9/Zitgb7GXhX+Tc/B2Ri6eGvHDWnm4OcRo9i7caAR/QPS+eTE0BnLBUC7ErhdBMfqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DlM/aJNu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ef7zz95gPjYNa92zEC+7MbyGEujjy28MrXXLtLjlUCk=; b=DlM/aJNu4yU0KaC6sTDIiFlqfU
	0EHljQNrZDAOjnMo6aZUvox53kckxERRM+og14fkbFKRqlqpz1iqvRwcbwjNAk5X3AndCIn4049HQ
	6nhT3Id/Ru/8QWXWkpmhfJoqfrZVfJDtKy+Lj0Xdvwkh5du/sNqW5W8N5ovtj27hCPKI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tRKoM-00GqxU-Jw; Sat, 28 Dec 2024 01:36:10 +0100
Date: Sat, 28 Dec 2024 01:36:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Nelson Escobar <neescoba@cisco.com>
Subject: Re: [PATCH net-next v3 6/6] enic: Obtain the Link speed only after
 the link comes up
Message-ID: <88dd7ff9-b8cc-448f-84c1-16abe58123b6@lunn.ch>
References: <20241228001055.12707-1-johndale@cisco.com>
 <20241228001055.12707-7-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228001055.12707-7-johndale@cisco.com>

On Fri, Dec 27, 2024 at 04:10:55PM -0800, John Daley wrote:
> The link speed was being checked before the link was actually up and so
> it was always set to 0. Change the adaptive RX coalescing setup function
> to run after the Link comes up so that it gets the correct link speed.
> 
> The link speed is used to index a table to get the minimum time for the
> range used for adaptive RX. Prior to this fix, the incorrect link speed
> would select 0us for the low end of the range regardless of actual link
> speed which could cause slightly more interrupts.

It still seems like there are two distinct changes here.

> diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
> index 21cbd7ed7bda..12678bcf96a6 100644
> --- a/drivers/net/ethernet/cisco/enic/enic_main.c
> +++ b/drivers/net/ethernet/cisco/enic/enic_main.c
> @@ -109,7 +109,7 @@ static struct enic_intr_mod_table mod_table[ENIC_MAX_COALESCE_TIMERS + 1] = {
>  static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
>  	{0,  0}, /* 0  - 4  Gbps */
>  	{0,  3}, /* 4  - 10 Gbps */
> -	{3,  6}, /* 10 - 40 Gbps */
> +	{3,  6}, /* 10+ Gbps */
>  };

1) This fixes a broken comment, but otherwise make no functional
change.

>  static void enic_init_affinity_hint(struct enic *enic)
> @@ -466,6 +466,7 @@ static void enic_link_check(struct enic *enic)
>  	if (link_status && !carrier_ok) {
>  		netdev_info(enic->netdev, "Link UP\n");
>  		netif_carrier_on(enic->netdev);
> +		enic_set_rx_coal_setting(enic);
>  	} else if (!link_status && carrier_ok) {
>  		netdev_info(enic->netdev, "Link DOWN\n");
>  		netif_carrier_off(enic->netdev);
> @@ -3016,7 +3017,6 @@ static int enic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	timer_setup(&enic->notify_timer, enic_notify_timer, 0);
>  
>  	enic_rfs_flw_tbl_init(enic);
> -	enic_set_rx_coal_setting(enic);

2) This sets coalescing after the link is up.

Two patches please.


    Andrew

---
pw-bot: cr

