Return-Path: <netdev+bounces-97195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B518C9DD2
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216B62853E9
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B0135A5A;
	Mon, 20 May 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R2Ea1JSc"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C471FC0E;
	Mon, 20 May 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210393; cv=none; b=diUSLvUMu6jFc5bwW4r5ko7/D6C/4LhhcuxxoNKDTm2Ro8NcDxRtX3KNISFltwUGaimCBi/Nb7YHA//3DCkcxI99Rj+0VbaCp0kdxctvD6psfdkV85IukMAgDXQwm8M9BfudSv+/oNTTrJIF39gTJn9WmTiVSM58e3E5x3+SufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210393; c=relaxed/simple;
	bh=4+7CddW5We0wU9iMakq2yje3RrOQvVyLh/AcczxCx+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgHD/CH5PyS5tnlqIFu2B2OERLQ3QuZhN/qI99I3qFOqPF4GkOrYHJWEhlVlmFkFtPeFv9tnr5xIUgwjFX7m+3vIKip1YjvQpMbE6rI5Z5ZOHFkMChP4GCfGdMaMqKm/VyNDQdrYk5Pbiq905ItrOmJCFKdhe8NakIMA2wH+TD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R2Ea1JSc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GVH3hd6GTpYUkd0MY/d50j19yuf6w01ci9ep2ahCSAo=; b=R2Ea1JScnnU0BdrEbQd+F4498S
	ygj9NGUqj58arOvsoKndxyCcd/jBizW5dFkNtI/7zYtyuReuMoacQezcV9qS0u/WHrlqNlTRyJUnL
	sfBfRXL5FQELA+o4febjKFzHG4gD0tII+AeTa8BJD57MoULVoI/1ay/tQfPnJNR7B7Uw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s92ib-00FhHS-Ei; Mon, 20 May 2024 15:06:21 +0200
Date: Mon, 20 May 2024 15:06:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v3 0/5] net: phy: mediatek: Introduce
 mtk-phy-lib and add 2.5Gphy support
Message-ID: <7f99f50b-b5c4-4a90-b32e-f2f7f5ce8e9b@lunn.ch>
References: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520113456.21675-1-SkyLake.Huang@mediatek.com>

On Mon, May 20, 2024 at 07:34:51PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> Re-organize MTK ethernet phy drivers and integrate common manipulations
> into mtk-phy-lib. Also, add support for build-in 2.5Gphy on MT7988.
> 
> v2:
> - Apply correct PATCH tag.
> - Break LED/Token ring/Extend-link-pulse-time features into 3 patches.
> - Fix contents according to v1 comments.
> 
> v3:
> - Fix patch 4/5 & 5/5 according to v2 comments.

Ideally state what you actually changed. The purpose of this history
is to remind reviewers what they said, so they can

1) Check if anything has been missed
2) Check if the changes made fit to the review comments.

So please include a one line summary per change made.

> - Rebase code and now this patch series can apply to net-next tree.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

	Andrew

