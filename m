Return-Path: <netdev+bounces-134848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5099B50C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 15:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61EE31C20885
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA1153BE4;
	Sat, 12 Oct 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwxpQuRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580211F5FA;
	Sat, 12 Oct 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728739380; cv=none; b=AtNAgUxkmhuUrJcKIk551EWVgoPo/rGkv6fH9KhRzjtMKrl1Vvu0383RvJhdiy3UmnlJVUIbpJsNfhmstnfQ/707o0TwBr7patuIalreFebdeX8bd38wWSBrxweZ8M9uIzWOh6IZ6FRPxppaUbgHPDyGmooGIQQ4n0ACMV1gOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728739380; c=relaxed/simple;
	bh=Rr4fmrWNgZ3NMrkM5VB72BmETLyXOWlUaleylyzjSTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyDqR2W4QI/FTVaNFehdpejUVEwVKv2kG171++ITGXMxafeFWH7v7+NtxUehMVf3UEeY1pqmlF/8G5oGoh89eNK110NVQAu++IR+ZK95km5cHAes+EetDuAgnnY+OBLfVPpsaSbCJOiP4bY84ymRceyF3jaGuJfTfCp2F1kBvVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwxpQuRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B5AC4CEC6;
	Sat, 12 Oct 2024 13:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728739380;
	bh=Rr4fmrWNgZ3NMrkM5VB72BmETLyXOWlUaleylyzjSTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WwxpQuREDocFGCl7x8B83IC/yBtjCQPc2ucLMyQnqKhzeJ4cRYCDFKEFH1Qzbinoh
	 VZwFWmmZYK89W9fr+zb4WeD+Nsd5D5CBNGUeColpw/kQSTTTbgEYt5NXfzXigcJXC/
	 lT87hsFRQl++YCe02Wcjt7Gdl26XL+JfSexFv8SzFDWXlwLd/dih5VFc8lVcQ1YSRy
	 /Y2gu7/7N1R9knP0u+yOFy58SSqYDcZFVJD9S88d5+2hmXS48ehSApX8Fglo3o0kwV
	 ROFUMnFQSF1Tf2hRkXhFoBzb11sYVNkepCPMFcMjI2iwuyW3TYSEq+Dysa0/S3CRPT
	 duYZMKs8gL8Fg==
Date: Sat, 12 Oct 2024 14:22:55 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv6 net-next 1/7] net: ibm: emac: use netif_receive_skb_list
Message-ID: <20241012132255.GG77519@kernel.org>
References: <20241011195622.6349-1-rosenp@gmail.com>
 <20241011195622.6349-2-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011195622.6349-2-rosenp@gmail.com>

On Fri, Oct 11, 2024 at 12:56:16PM -0700, Rosen Penev wrote:
> Small rx improvement. Would use napi_gro_receive instead but that's a
> lot more involved than netif_receive_skb_list because of how the
> function is implemented.

...

> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


