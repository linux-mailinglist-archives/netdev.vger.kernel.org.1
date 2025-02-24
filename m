Return-Path: <netdev+bounces-169180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33BA42D2D
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6854F178DD8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F977200138;
	Mon, 24 Feb 2025 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D30BMwIh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA470838;
	Mon, 24 Feb 2025 19:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427039; cv=none; b=CuonBRQL2Yw2FoEPPP36c7FnzqV5ELceoIgEKWWm/hdj5CGF0yFpGHH168RzV+SwoyKazTpf4vbxnCKEGGHgV9qZaWUda5svrso34nBF0KlSsoqBsrZW/zocv9cHpJmdSA3daSxyg6gdOTnxGFB/uD2hMpY15sQ731AyWnTsmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427039; c=relaxed/simple;
	bh=E6P1z8HuC+hJEgKpjMkGpsb5+onEhRP3Ewo4oxXLpOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMIXFoZTnPVXgr8mnXVOBR7tpZtDJpUyC1JzARPnaVd2FACp6lmiD792aIJFsHw7HLd0wshOgm11xk8IMFS5oU4wWA/7KdVAchuPX2iygrsgyy/0fF5DGdTvc/QBj/d/5e7Tdm2EVcak29AnZ8R/AjtOTgXoGB6xQIlWaJp7g6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D30BMwIh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5QVl9iy0l5UnFA6SQ8VJ9JGtMs/TG/0zOp+vPNzgOlQ=; b=D30BMwIh5uAVK85OGIK+vv6wqa
	HwTaGh1ozXQCKfX8l9l458ZM65bqiKbHNz5MpwzSWQQQanobmjVf6lIBlEMgoZz5YK2Yo2miH7WBE
	SiZi0pbWvjnZYAetzsbfLfS0+jOkHiirImQhYhDr9BLynFUpVhBAKMC34qT+Nz7qqbG8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tmeZd-00HHCL-F6; Mon, 24 Feb 2025 20:57:05 +0100
Date: Mon, 24 Feb 2025 20:57:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] stmmac: Replace deprecated PCI functions
Message-ID: <0cfca9c6-c2ff-49c1-8e87-51747640712e@lunn.ch>
References: <20250224135321.36603-2-phasta@kernel.org>
 <20250224135321.36603-6-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224135321.36603-6-phasta@kernel.org>

On Mon, Feb 24, 2025 at 02:53:22PM +0100, Philipp Stanner wrote:
> From: Philipp Stanner <pstanner@redhat.com>
> 
> The PCI functions
>   - pcim_iomap_regions() and
>   - pcim_iomap_table()
> have been deprecated.
> 
> Replace them with their successor function, pcim_iomap_region().
> 
> Make variable declaration order at closeby places comply with reverse
> christmas tree order.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

