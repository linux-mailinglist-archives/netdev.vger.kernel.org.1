Return-Path: <netdev+bounces-95421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389FE8C2359
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E82792812C5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5716F0C6;
	Fri, 10 May 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUZRXq4n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE8165FB6;
	Fri, 10 May 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340405; cv=none; b=axlhXD5HKN3u68SpeEcYdbEaCGfhHVKZovx+JtxAXzyBetqHh32YKGpY1UXIbsBddsNh2touqY33Bjnt1MF4fkQoyrd0iucyPDEgOvxdd1LJoGJmh2MCB6z6MoyoWh9xYVkLN0YuuUCjQKBJduv0lZc2o7jsMwLvuezZPUmRLjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340405; c=relaxed/simple;
	bh=JXW03WRU6z1mXtc+Z7yE/kyIm40/gmp1UYrc/DpS7LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDyEKOyVbCRrnRccj3CtrDfB9E8NHkODKBwpEXPMh1I6bbObfZ2UTJ1aySW0OX5jEuvlRDT60kdwBiuHeibPbrSnrAZJBPKtTx2YcJRSdARRvCJ9NXIVZV3QshXCmebBleMSFGhXoUroz3ScF69dEDhq8IIIQPnL/A9xqQZe6vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUZRXq4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A937C113CC;
	Fri, 10 May 2024 11:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340405;
	bh=JXW03WRU6z1mXtc+Z7yE/kyIm40/gmp1UYrc/DpS7LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUZRXq4n7GHCm0Qm/ZxRmmGVHb/vxC3POataZ0dLbh2hkldPeO75VuQ7q2nJY+E3I
	 95vBoWXVcYzjWGwkTPrk3IuP9GyUGEGXmmYrD11vt/g9EkGzg1Oc16Ok77fAlWokH+
	 T+5kTkHJ0VOjFesVN40hC2uUWoKM6MbK/XG4Ml3Di3aK/wJODBr1Ssi2eXeziVH26T
	 eqkYCNQJFSrCpXKyX1OF3nsJLr5uPHtJ2Q8ut8Jkbw/tXh6huDuYsDg3baeh2HLLhT
	 SWpn54s2exPO1nnyEqfF5IgV14geTmaABr+c7cXkp5g13L/znL/cDH5RotgpESallW
	 cBsSoeyVTjqwg==
Date: Fri, 10 May 2024 12:26:40 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 01/14] net: qede: use extack in
 qede_flow_parse_ports()
Message-ID: <20240510112640.GD2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-2-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-2-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:49PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_ports to use extack,
> and drop the edev argument.
> 
> Convert DP_NOTICE call to use NL_SET_ERR_MSG_MOD instead.
> 
> In calls to qede_flow_parse_ports(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


