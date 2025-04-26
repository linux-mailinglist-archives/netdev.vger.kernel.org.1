Return-Path: <netdev+bounces-186242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B11A9DACD
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 14:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E435A780D
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315C7946F;
	Sat, 26 Apr 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=brownhat.org header.i=@brownhat.org header.b="ifFJmfEc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B732F5E
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 12:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745671822; cv=none; b=TpzbQLTBJYqEGO6qYS63xpAWgnZXyOvK1X1iTE9CDculq7oDrc+RRaFb4N8pZeWgXyzLVJdeq4mbPba2Cv+7w81klUVHF/YzWl4YguQ9oA17KiLZbuqxiVTS7RIqTHC37n6s1s6l0o8vNTDiL1nkQL87eyeBHintb6nJJRnHc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745671822; c=relaxed/simple;
	bh=pPjkIvAb973JIjC0KrnU484B3+Q0+y9rM7H88YyWnGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0jyZ5327qSs/vKkvSFILVIg9EYQs6qmaFPk4XWt4+lymeeoA/GRh4ZFNop9vNnT2QstHYCOubJvI47GaE7WT/er9IfjJ/fc7Mdrl7HwMC8PISC/BjwZTXsOXwlW6kX3sKIGiR3allgN3kwLD0aj0Us4Pjs2Ct282xWsR4jAL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brownhat.org; spf=pass smtp.mailfrom=brownhat.org; dkim=pass (1024-bit key) header.d=brownhat.org header.i=@brownhat.org header.b=ifFJmfEc; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brownhat.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brownhat.org
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zl8Rg0h1yzYwb;
	Sat, 26 Apr 2025 14:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brownhat.org;
	s=20191113; t=1745671182;
	bh=Olfu3brFWDS51/0/ryjEK1Ts5wIML5vHhBtSBjeGn1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ifFJmfEc1FOCIgKpJS3CmV/oFxLwNtEOuu3N1PglAJNIrXe4ppOjcGxlb++vl9DyK
	 JbAw7/MiqXxys6UudQhbbmx9ZSnasJ8LrtZ+CBS0ghmiydCm9NiL/Ec2r0vl+5PFha
	 SDEvQRap2v9uEdv6aOxSN5DtOwovM7031rbBrtN8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zl8Rc499kzDBB;
	Sat, 26 Apr 2025 14:39:40 +0200 (CEST)
Message-ID: <559370be-a366-4754-8baf-3a4b332be025@brownhat.org>
Date: Sat, 26 Apr 2025 14:39:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] net: ethernet: sis900: Use pure PCI devres API
To: Philipp Stanner <phasta@kernel.org>, Sunil Goutham
 <sgoutham@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Geetha sowjanya <gakula@marvell.com>, Subbaraya Sundeep
 <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Helge Deller <deller@gmx.de>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Shannon Nelson <shannon.nelson@amd.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20250425085740.65304-2-phasta@kernel.org>
 <20250425085740.65304-7-phasta@kernel.org>
Content-Language: en-US
From: Daniele Venzano <venza@brownhat.org>
In-Reply-To: <20250425085740.65304-7-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha

On 25/04/2025 10:57, Philipp Stanner wrote:
> The currently used function pci_request_regions() is one of the
> problematic "hybrid devres" PCI functions, which are sometimes managed
> through devres, and sometimes not (depending on whether
> pci_enable_device() or pcim_enable_device() has been called before).
>
> The PCI subsystem wants to remove this behavior and, therefore, needs to
> port all users to functions that don't have this problem.
>
> Replace pci_request_regions() with pcim_request_all_regions().
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Daniele Venzano <venza@brownhat.org>
> ---
>   drivers/net/ethernet/sis/sis900.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/sis/sis900.c b/drivers/net/ethernet/sis/sis900.c
> index 332cbd725900..df869f82cae8 100644
> --- a/drivers/net/ethernet/sis/sis900.c
> +++ b/drivers/net/ethernet/sis/sis900.c
> @@ -468,7 +468,7 @@ static int sis900_probe(struct pci_dev *pci_dev,
>   	SET_NETDEV_DEV(net_dev, &pci_dev->dev);
>   
>   	/* We do a request_region() to register /proc/ioports info. */
> -	ret = pci_request_regions(pci_dev, "sis900");
> +	ret = pcim_request_all_regions(pci_dev, "sis900");
>   	if (ret)
>   		goto err_out;
>   

