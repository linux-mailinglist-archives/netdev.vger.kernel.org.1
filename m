Return-Path: <netdev+bounces-202124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16231AEC5AE
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 09:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA8701889748
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 07:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC121D587;
	Sat, 28 Jun 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NPumxxan"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E061A0BD0;
	Sat, 28 Jun 2025 07:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751096731; cv=none; b=M3mV6j4fL9mvhjr7O2AN3ooPPXgUtjkWhSl+ig0mVOa/8gHY7kDCE4pJc4nMc4tmh+cf4JZ1E/2TMkuquFAiQLwUlfrAsPBBh/ciTGGRbpprxYhJd5QUl1XTXGNlXC3V5we+JpGD5VNBGBTMIXur3EalV4Ndkp2TPrWMxr/gAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751096731; c=relaxed/simple;
	bh=eIm6t1VQextXYf6myjmOZ+FySxhXPWUhGP4mR12YK6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tANM9ZhtPWzfyJryEC+K1ilzwmjeJrPlLXynwSfjzEqlDsYecBk4/eTxJAAz3ifUBSweOKUrD5Ng+Shkk92t+xdRMSLYEKLO3wmOA+CugneONacJBeUC+BhotNCkS9MBsbTZZcvndJJvntRJibWYIJqIfeTO5YBHMZ7OBYSsvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NPumxxan; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OttYEYSGsa6fmMgQuQ6ACm+QP5p6Nu/umyUb7AyO7Eg=; b=NPumxxan5JbLaOahIw2KDrjgix
	JWPttDRwbstlKJlN02rVvomyp+59v5OvcuihXU3uK3n8zOB57RxZ3Jq2GSeFHzKa5wTXge4XrnIT4
	3RWNMmlu/RbP0sIceNo/14C9KvUd7MetTrSJPssjZO2gY0bGv36dMDxE0OJN3KtFZBzQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVQF8-00HDmt-S5; Sat, 28 Jun 2025 09:44:58 +0200
Date: Sat, 28 Jun 2025 09:44:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>,
	Frank Wunderlich <frank-w@public-files.de>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Sky Huang <skylake.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net/next 1/3] net: ethernet: mtk_eth_soc: improve support
 for named interrupts
Message-ID: <02a89062-456f-41de-a89b-c4963aae2d7f@lunn.ch>
References: <cover.1751072868.git.daniel@makrotopia.org>
 <d1b744685a464c5cd353107555faca6cd965d158.1751072868.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1b744685a464c5cd353107555faca6cd965d158.1751072868.git.daniel@makrotopia.org>

On Sat, Jun 28, 2025 at 02:30:23AM +0100, Daniel Golle wrote:
> Use platform_get_irq_byname_optional() to avoid outputting error
> messages when using legacy device trees which rely identifying
> interrupts only by index. Instead, output a warning notifying the user
> to update their device tree.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

