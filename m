Return-Path: <netdev+bounces-131612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E264C98F074
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A2F1C211CC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26A1990AA;
	Thu,  3 Oct 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5PajwNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90EC1386BF
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962369; cv=none; b=UK6/Upo/aHf+8LxNiyaOWmoEHcpnHHFCxNebaUZKcdFs5NWIU5RYK2u48FL4O2YWcMqxn0EBxJlMtffFYhXDwrzj8fc6kAl2MLUoxREKpcdZS8h26A/ZWe/87zBh2tPyrcsknG9lCdru7GArXZeow3EOiQdP2i4rPAcixSYEvPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962369; c=relaxed/simple;
	bh=FnTp2W0cXmJ0iD9IERZ29oSVrpqc6zM9mw1FTTcKnwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r148damy2jb5aX5/5lXEKoBuH9obF5TJsyr3K3NlmVPJPWDgsgJzSg748NiU7XPYE8MSmL8AWmS3N+opsWe+t41qQ12DO827VF+jk01wbUZR3Px8RUSqmX5lwLcz954ggRg7a+yOOvL8C/H90RSAUXYt8rVlMtKm1N8xt9QDLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5PajwNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D074C4CEE5;
	Thu,  3 Oct 2024 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727962369;
	bh=FnTp2W0cXmJ0iD9IERZ29oSVrpqc6zM9mw1FTTcKnwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5PajwNivVsaK4hPcBjgxnYoz2Su3NkG0BVUIIo5oFoqQVirm4mDHmhRJDjM3A/d8
	 E/erglJCzMN8kUkgOp4x/eJhj8M3hlPMxjEPmA25/Tgrem1cIU/RK3og5lVieO0yDd
	 Ht0lPelTWAXNoiLuutajTvrZhXTWtaTPkOu2joMZJ1MqG8wZkwXjwNL6hyQDkD5FL8
	 63vEjf4ep358pkmxnE7RcNjsQmhLYmdDrz8iyaaz9kTa68M8zEyruSf0ey8mIw+ZGb
	 g0yzObkSrMB7Th/7N94VulbIpnOzgznYYcXH2WAOe2Kd/AYPZyQkFIi2qx+xgijF/z
	 LSVY8897Go6Dw==
Date: Thu, 3 Oct 2024 14:32:43 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [PATCH net-next v2 2/2] net: airoha: fix PSE memory
 configuration in airoha_fe_pse_ports_init()
Message-ID: <20241003133243.GN1310185@kernel.org>
References: <20241001-airoha-eth-pse-fix-v2-0-9a56cdffd074@kernel.org>
 <20241001-airoha-eth-pse-fix-v2-2-9a56cdffd074@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001-airoha-eth-pse-fix-v2-2-9a56cdffd074@kernel.org>

On Tue, Oct 01, 2024 at 12:10:25PM +0200, Lorenzo Bianconi wrote:
> Align PSE memory configuration to vendor SDK. In particular, increase
> initial value of PSE reserved memory in airoha_fe_pse_ports_init()
> routine by the value used for the second Packet Processor Engine (PPE2)
> and do not overwrite the default value.
> 
> Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
> for EN7581 SoC")
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


