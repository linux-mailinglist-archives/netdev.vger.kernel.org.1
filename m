Return-Path: <netdev+bounces-137155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C82D9A49CE
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7A11F21EB5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 23:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21FF18CC1E;
	Fri, 18 Oct 2024 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="Jhe3vEdt"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0545152E12
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729292689; cv=none; b=DCKukSWs2ltS7licXtDVLF5s3KmZo8y9SYVnqho0Tku3RzCl4+IHU+OeFatnAT+n3iQp0uvVLIMINbT5USLeNAADYK5b65l76DPcjd0YtSmjVseIocJYX/SbV6F7wxaixgndmeKVq9BIa3lsCMOIZLhNrS7RjxtThSOfH5K5+x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729292689; c=relaxed/simple;
	bh=EdpnDHndukPcLeOXddSCB6OzwJeSNEj8i1n0j3yKsCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvmgLOO6fmQYYS9j0ujFoiXwNiZIViGeRwdNzDj1SBTzsmozPOIrCOG2TRv79HA4dFshLRmKNAR8AR80QfVEUafXQr2aanzZhEHlh6Oa91Wo7OpJFdQtUjD5YeWuJUGGsaMpASteP2KP6YIqnoyas1fFpNy3If4b2h4FhxHP/Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=Jhe3vEdt; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 49IN1t0E3057856;
	Sat, 19 Oct 2024 01:01:56 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 49IN1t0E3057856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1729292516;
	bh=bnMKgi0g5n1FUstS/NaADCKId167roCBWXtWzTyKtsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jhe3vEdtw9i3su3w0Dhm/O0hLsq81qQL6waY9O3eVXjTyI6F7y4qoklUWc7obMLEI
	 tJ6sYSShIRAxSIYQQrfgydtc+R6qnrU76fIdQsIHTXj7zc6WgPSmihMDbJDJmFuRTj
	 BM/nsyVzKJDrvJNLMAq6vkBnp4oCFybLbFshna/0=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 49IN1t9h3057855;
	Sat, 19 Oct 2024 01:01:55 +0200
Date: Sat, 19 Oct 2024 01:01:54 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v2] r8169: avoid unsolicited interrupts
Message-ID: <20241018230154.GA3057800@electric-eye.fr.zoreil.com>
References: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>
X-Organisation: Land of Sunshine Inc.

Heiner Kallweit <hkallweit1@gmail.com> :
|...]
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 4166f1ab8..79e7b223b 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4749,7 +4749,9 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>  		return IRQ_NONE;
>  
> -	if (unlikely(status & SYSErr)) {
> +	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
> +	if (unlikely(status & SYSErr &&
> +	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
>  		rtl8169_pcierr_interrupt(tp->dev);
>  		goto out;
>  	}

Some paleolithic references:
a27993f3d9daca0dffa26577a83822db99c952e2
d03902b8864d7814c938f67befade5a3bba68708

First occurences were related to 32/64 bits PCI systems somewhere around
2004~2006 (IBM PPC, who cares now ?).

It also appeared sometimes when the receive frame length check misbehaved.

It mostly was a plain PCI devices behavior. I am not too sure about 8168b
but I don't remember anything above (including) 8168c needing it.

-- 
Ueimor

