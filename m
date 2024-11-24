Return-Path: <netdev+bounces-146951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9DD9D6E0D
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 13:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995512812A9
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 12:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C757186E40;
	Sun, 24 Nov 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxrf1HQT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA4EADC;
	Sun, 24 Nov 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732449870; cv=none; b=sdZO2Rw6z0ZMOoOfObeyKdQhMarOtZ2QumW0Ko6JazVNip//YGpXMnTX1H3Yme4jiQvR7MLvW32XWxGXlsZOy4OQN46jkbiXFSWLCx8It94wg5mMcUbnvwkIVwy9Wymttf1SiabfT7zHOigs8UU8Sof/lVPbH8c9ksCJroLq0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732449870; c=relaxed/simple;
	bh=D42/6/6xAfuNj70obA+IRPyym+jsxGJCy0MSbAteUOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3ppjGmJuf9GwHOMs69mUsO/irt3TfvtBjeTsi7hjh4/kw2XhsOHCSWRUr9pcNQ36xQiwr63RfjblT/ghBg++5RKR+dYbAasqAxKU3JlvW61e+xFqOzobVyicPu99SeWF/1QPrF6IKOZei5gCd3ZaCavns3IrWVHinYLMSOSuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxrf1HQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE5C4CECC;
	Sun, 24 Nov 2024 12:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732449869;
	bh=D42/6/6xAfuNj70obA+IRPyym+jsxGJCy0MSbAteUOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxrf1HQTqbJHrmPXzEaFOGHgGMB90zvr9rzyojv481fp1wdAotB6/Jxf76dSVUmsS
	 ZPBRSNXU1Vi+JocLHdvy81oRnFqsehftXvPr+uvWgbmZKmw+DUXCLxSSXgxV2dUeTv
	 EyIKpyUSNyUMIIdzyHNhX+ntfQxm3kAlsogTrH6gibfq5sVZxLYqe5dDfmKu9vxcq1
	 Us+gHB57SBug4uWWpStPg9wx++Pu/eZT0xyLGmDdb/jVaVa8hvFrMa3Hfht1aQvQ/o
	 Uk6DBEtuGzBEp+Lq0IEkAJEliu9HsC88zRiMx8V/KfIw+hpd1xjRgNeyIHiR7N31Oa
	 10LYCqHYEOGTQ==
Date: Sun, 24 Nov 2024 14:04:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <20241124120424.GE160612@unreal>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124093531.3783434-1-ilia.lin@kernel.org>

On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> In packet offload mode the raw packets will be sent to the NiC,
> and will not return to the Network Stack. In event of crossing
> the MTU size after the encapsulation, the NiC HW may not be
> able to fragment the final packet.

Yes, HW doesn't know how to handle these packets.

> Adding mandatory pre-encapsulation fragmentation for both
> IPv4 and IPv6, if tunnel mode with packet offload is configured
> on the state.

I was under impression is that xfrm_dev_offload_ok() is responsible to
prevent fragmentation.
https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410

Thanks

