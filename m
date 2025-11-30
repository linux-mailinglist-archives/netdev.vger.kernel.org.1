Return-Path: <netdev+bounces-242758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D6C949EA
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 02:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A6174E12D0
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E915B0EC;
	Sun, 30 Nov 2025 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oTtLbLlX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C754B16F288;
	Sun, 30 Nov 2025 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764464469; cv=none; b=uWgGbJ5SJrH+uEDQ5p8GKVCkK4cGvd3wIgH/SeCdISxCYjjZRrX718vAMruFasMZxATSh439nCZncsQs7gVS+tMMIe8AcMs4CWVRLlP37vBiGmssqhR6p12xacRSVQEvySKjRbeQRjk1wo7SDBtjE/Qg8I6k9jJ451gB848ZYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764464469; c=relaxed/simple;
	bh=Zd+lPD1f4F7VHMfzU1tVWtWhNWzq7NReD6CbhM9yW6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQJ6Uiw2fBzKwPfcIWrV/pDtDHyBEIqvMt3mcUgGvtBA06fhVFSHnlgfwWDzzo3jlM3jVCM/W9rEAAB/OFYNc1mS6BbDxqlVeLs/XzO6u/pY1PgYjKep+u54aA5+QHhBVBA9iuOcPWXQOR9WrhUIxilnwfKVqvHgr8SJ6etqtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oTtLbLlX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zHwQhTg+NJLJ1+sYXBy6n63aHK8fWvhoGfYfXbbgar8=; b=oTtLbLlXpRq7v516IlJUaNTd/s
	VfZ6j+kCuEH1joUxulIPJ1FGlKFTyj9CT7KYCcepiyRtut0UwsuQXAFV8TssNHrdM202+bgM47o7/
	vEZddvydzVkp6rCqNsRGhNF3M2wQxWMD52hMisgqLzpPurpKR8rhg2r2sxwsU48PuCZo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPVnt-00FR64-Oh; Sun, 30 Nov 2025 02:00:41 +0100
Date: Sun, 30 Nov 2025 02:00:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen Minqiang <ptpt52@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ARM64: dts: mediatek: fix MT7531 reset GPIO
 polarity on multiple boards
Message-ID: <893308f9-18c0-4489-81be-e233d50d16da@lunn.ch>
References: <20251129234603.2544-1-ptpt52@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129234603.2544-1-ptpt52@gmail.com>

On Sun, Nov 30, 2025 at 07:46:02AM +0800, Chen Minqiang wrote:
> The MT7531 reset pin is active-low, but several DTS files configured the
> reset-gpios property without GPIO_ACTIVE_LOW. This causes the reset GPIO
> to behave as active-high and prevents the switch from being properly reset.
> 
> Update all affected DTS files to correctly use GPIO_ACTIVE_LOW so that
> the reset polarity matches the hardware design.
> 
> Boards fixed:
>  - mt7622-bananapi-bpi-r64
>  - mt7622-rfb1
>  - mt7986a-bananapi-bpi-r3
>  - mt7986a-rfb
>  - mt7986b-rfb
> 
> Note: the previous DTS description used the wrong polarity but the
> driver also assumed the opposite polarity, resulting in a matched pair
> of bugs that worked together. Updating the DTS requires updating the
> driver at the same time; old kernels will not reset the switch correctly
> when used with this DTS.
> 
> Compatibility
> -------------
> 
> Correcting the polarity creates intentional incompatibility:
> 
>  * New kernel + old DTS:
>    The driver now expects active-low, but out-of-tree DTS still marks
>    active-high, causing the reset sequence to invert.
> 
>  * Old kernel + new DTS:
>    The old driver toggles reset assuming active-high, which now
>    conflicts with the corrected active-low DTS.
> 
> This was unavoidable because the original DTS was factually wrong.

So, the real question is, are the regressions you are going to cause
by breaking backwards compatibility worth it? 

What happens if we don't fix this? Does anything break if we leave it
as it is?

I personally think it be better to just document the issue in the
device tree binding.

	Andrew

