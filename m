Return-Path: <netdev+bounces-199924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D6EAE234B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 22:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8457ABEE4
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00590226CE1;
	Fri, 20 Jun 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsGqfWUB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8F01FBEA6;
	Fri, 20 Jun 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750450352; cv=none; b=u50XeCBIUJzRc5FWspezvdy0S/wf4Q3sEp5YhdBIdyWx3Q8LyhjLX+1J1D36CoE1Q0dJmrKDVk49aQ7Kf+aHFwZAu2uB9dLa/MnoPesA8LU3megXoEgkWng7JDEzp1awAsP2rNiAQPHpza63lKTByC85Skp8NEXroRkBCo2neOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750450352; c=relaxed/simple;
	bh=YYSRaHlyrbAaccJjfWsT2+6At5/W7em9BngvMnpBJ7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBYVsYa8yMjOIUoQVb7sgtJzevpMycKi/jrqi7jKuGJjtJ1yYgpDxGXLiuW9xRxxJHK5wCeCf8kkv5laUK4nX494DMjeQTigogIpKP7mNwSPAYL8zpr7yr82DUiwdiY4FHLAxJIUpmcX8wd+1T70+eIUDmtAHlMe6u3uLjb5rIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsGqfWUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27238C4CEE3;
	Fri, 20 Jun 2025 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750450352;
	bh=YYSRaHlyrbAaccJjfWsT2+6At5/W7em9BngvMnpBJ7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsGqfWUBMxMbTb06I0yd5YGUxXNtIqY9C2qg9XBKc0LFsUBYSLoOZ3Edes/2KQfkW
	 vEe7G/RNEy3Izz7DzbdSWjv1k3kKZXO2EztDEvNAEA7odHtl5DES3cCNV3kZsOV3fX
	 0Bp92mmvwpdDScPjVqplz58xvHba3974/MMnECQSh3SNiIOmOh8r/HY2DZaJewleg/
	 M4kpJClZ2Qib3cnbZ6nhC+B7qTjySx46eT0XG0UvUYVlBgR+VHqZ5UDfSlhV0n3ndl
	 P7dMAKWYXSzgOyZn7nkffk2BtyMMyUbT4axml4XWX9jHbc6Oa5LrWHdlAUgLNoWG+z
	 +79zW+MBAyRCQ==
Date: Fri, 20 Jun 2025 21:12:26 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>, arinc.unal@arinc9.com
Subject: Re: [net-next v6 1/4] net: ethernet: mtk_eth_soc: support named IRQs
Message-ID: <20250620201226.GF9190@horms.kernel.org>
References: <20250619132125.78368-1-linux@fw-web.de>
 <20250619132125.78368-2-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619132125.78368-2-linux@fw-web.de>

On Thu, Jun 19, 2025 at 03:21:21PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add named interrupts and keep index based fallback for existing
> devicetrees.
> 
> Currently only rx and tx IRQs are defined to be used with mt7988, but
> later extended with RSS/LRO support.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Simon Horman <horms@kernel.org>


