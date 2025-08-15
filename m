Return-Path: <netdev+bounces-213922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B997B27563
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6563AED9E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD05F29A31A;
	Fri, 15 Aug 2025 01:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZFQcYZYN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329652777F9;
	Fri, 15 Aug 2025 01:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223168; cv=none; b=hQe2JssQHPGZETYQqqLTZaGhdEJvkeh1x//pAzr0/DA4JI1Uj6KQKrFIK0WEXxVbnrd61iM7wP+MTS5qaQLbYwgpOv7uJRXrEUICChPzEjsG51nKxeOu7cLVEwreqxZcRhWcHGqoEdFYnCKfrg0x5h8T9zYA92AJUs06v9KkNk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223168; c=relaxed/simple;
	bh=zSUUbOPSNIlO8oema4/AtenrMEjWQHo4i6YgosHvNn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMo0urc4Y2OG5itaqdjrhw5GXr2v0cn1I+28CRpimjC3Pu+91YoSqv/STXnyWfAMPmlaFdhR7evqlr38/uaBAwMQob7kT7QIQFtnUBv0JzfSOZP/BqDKjso4kvoSbVEAHdEipTOghnVcyHc6wbIKDdhusfTsQfXU6UkJSsu+Cqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZFQcYZYN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6UITZGCNKVQJuHjpAdvmMBezdHWOXUFmkpWZz90DmNg=; b=ZFQcYZYNoD8pmeYzItpfpqXp+q
	ufxxGqXVrWNxYI1GFUJ968wi+ZKXsaHYmAPjQaqjnc7Uzp84flMpnhOEyImn7Q82dfdKwdngwFkX0
	BQmg56at8A/M6YxJBuJEjdikuvGUJ4JeXk4TE+Vrkvl3sqjob4SD/OMkO4Zs3tRPUhM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umjiQ-004m6Z-JY; Fri, 15 Aug 2025 03:58:46 +0200
Date: Fri, 15 Aug 2025 03:58:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] net: rnpgbe: Add build support for rnpgbe
Message-ID: <00e2690c-3b26-46c3-9b27-1c1a73964326@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-2-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814073855.1060601-2-dong100@mucse.com>

> +static void rnpgbe_shutdown(struct pci_dev *pdev)
> +{
> +	bool wake;
> +
> +	rnpgbe_dev_shutdown(pdev, &wake);
> +
> +	if (system_state == SYSTEM_POWER_OFF) {
> +		pci_wake_from_d3(pdev, wake);
> +		pci_set_power_state(pdev, PCI_D3hot);
> +	}

I don't think you need this test of system state until you have added
WoL support.

    Andrew

---
pw-bot: cr

