Return-Path: <netdev+bounces-117691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D994ED37
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CAABB22AD2
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0317B4E9;
	Mon, 12 Aug 2024 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gc86JsYQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A718017B43F;
	Mon, 12 Aug 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723466408; cv=none; b=lZ+Xx+ZkcqoNmJPZTyoEYB8qiiyWMECOnmPgAZLmIyYFsF4/HEGbbb8ToloEDweBmVPzHkQoyCqT2b1AHlWS2KvN0+okWPnpupm9T7WunGjGnzVRT02uWUMGjRnFPuVpamJEeq/LUb8I/L3i39GZud/OenOAYfnZEje9WmDYxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723466408; c=relaxed/simple;
	bh=GYcraVypOLisjZeWJ3sO1urnXNyhut57Xjr4bCt1Z88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GKbS7ei61OXAFSsXwyyadbgOlRhNiFPq6qOk4JsJK3EK0sOZgi7xjh6OeeJtGgqH9dtDq0EAenl+TXOFZua1uSlqESiGeAJ29eEDBbdPibZIjGTygm/ZqM6X0CoDNdYOqxCrHoGLsKBHkXpDilQYg7umCEfuW0ScrnYxXqwD9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gc86JsYQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h1PU2E4EjujWFn2Z/iRFgAc3JYxyafoWRcQhlBSIDIo=; b=gc86JsYQsoX85aWqDXT86zSpdj
	TeUG7rjLxOQl3/tlU33aRJYyqPo7JPoLp7PnRPIFCgYcQFLr3VG69m582y3LOAI5Ext2bmR1gOCUo
	i6dYcmCkx8/VFUPF02wzuD8KF5gUYi5Qi+/59SgPN0TKF+D4+xbO6QinaTGk4mUMD6bE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdUKz-004Zmv-Lu; Mon, 12 Aug 2024 14:39:49 +0200
Date: Mon, 12 Aug 2024 14:39:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 3/3] net: hns3: Use
 ipv6_addr_{cpu_to_be32,be32_to_cpu} helpers
Message-ID: <cd5d4314-c75d-4647-8a12-3a15a90f5552@lunn.ch>
References: <20240812-ipv6_addr-helpers-v1-0-aab5d1f35c40@kernel.org>
 <20240812-ipv6_addr-helpers-v1-3-aab5d1f35c40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812-ipv6_addr-helpers-v1-3-aab5d1f35c40@kernel.org>

On Mon, Aug 12, 2024 at 01:11:57PM +0100, Simon Horman wrote:
> Use new ipv6_addr_cpu_to_be32 and ipv6_addr_be32_to_cpu helper,
> and IPV6_ADDR_WORDS. This is arguably slightly nicer.
> 
> No functional change intended.
> Compile tested only.
> 
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Link: https://lore.kernel.org/netdev/c7684349-535c-45a4-9a74-d47479a50020@lunn.ch/
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

