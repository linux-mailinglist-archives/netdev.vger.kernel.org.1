Return-Path: <netdev+bounces-131226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE998D63B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286CD1C21BAA
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6EA1D0787;
	Wed,  2 Oct 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSwLeCdM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B481D0488;
	Wed,  2 Oct 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876259; cv=none; b=e2Gn1EBzOnVp9LEr7MA6zfUUhT0pvfhdfK4mLD4sQWw0oKmhLzGYBkS0g1DAM5KHqh+ld7fPbszK8h59zCCdW5b/9Cop7+D0HDsz39fbv8Ln3G0dSZ8sxMvn+o6BWPk8QGE7XnyWvtFLaiDgpzuW4aa6p3pzf21XbRRCzOtl6lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876259; c=relaxed/simple;
	bh=tFD7CRE7Cck5xgBY0cBEMYocwhZ23xHYDNDOfKT0SvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gypwd5ZI/B74jQPlRQsr0M63iL5PgEuchPCz3eHLgOkpCknyYfR7jAmv7pV3cn9qUpLKnvaDtvAcXPx2tjXF/dmiKs2DuzqdQ36WrAVLmC0BRpDl2okvZxttXkHvH7JeMTuuXJS+r1d7ne0zqylQALefHJZKqqMvrnANVBTbmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSwLeCdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44891C4CEC5;
	Wed,  2 Oct 2024 13:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876259;
	bh=tFD7CRE7Cck5xgBY0cBEMYocwhZ23xHYDNDOfKT0SvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSwLeCdMcq58Dt586aYWZ11eZ7QwmMDUJaGRsaFV4gzmEYA3jEPxSRLqjf15GJrvA
	 fM+yE5g5vUTdzkwazzo6MwJ+vEDo7+LjFgrDUWzx0TDzeNYqQ7pP+vy3QzyYLOBZQS
	 i7zjyS9BVM1Tyy3LXluy3n+MWkwhFbi/x82bG2LlUxRpNY2UrW6lkV+ljfZWayfYiQ
	 SkCgpxavpHv6EecjF7WTtf3EOdkhFW035QDqva+7fqNqjUKNY3rjO2iqaoNYMBFgq0
	 eINzNqzyYz/kKCWE2db84exYXyzgo3/P3LiSUMwiWTmtBctrYA6ZQQmiQa2cO9KGPP
	 fxAZyaDOTw7pQ==
Date: Wed, 2 Oct 2024 14:37:34 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/12] net: tunnel: add
 skb_vlan_inet_prepare_reason() helper
Message-ID: <20241002133734.GZ1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-4-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-4-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:16PM +0800, Menglong Dong wrote:
> Introduce the function skb_vlan_inet_prepare_reason() and make
> skb_vlan_inet_prepare an inline call to it. The drop reasons of it just
> come from pskb_may_pull_reason.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


