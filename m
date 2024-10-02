Return-Path: <netdev+bounces-131234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A9F98D67B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37991F2384A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A31D0941;
	Wed,  2 Oct 2024 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixKWpuqn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500991D0412;
	Wed,  2 Oct 2024 13:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876385; cv=none; b=FIICmCV1IIUNSr91lJdKJdN5PIlodknsGsppOlfeSIEbr3Ce8fpbSleyQCR+HwEFtEnpuIRIab53d/3RjZ2X0A23QNzm9+pxULZp0APBXr1KySATwOH5DJnivpbP1/7xyn6uUS08E9XS3dXc8/PjCwCKxbr5LFwGKxuFcJj/1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876385; c=relaxed/simple;
	bh=LoiiqwQuzZXfh7wt1EJ94uphV8ZuGJxi8mKamIG+c0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr1DO0iwGgGcV345OiJfHTt/9MYEliOVt8wqwvGAx4NUyaRJMaID8IIQcG50Gv/zE0r+4jP7ubM9zQEK77cpdtrpR2Y3/yKYxs71QY5Uz2gfWfGkUdKY/KT4+76VLQX1XC2FZxRwDUZWmXP1dbz7265ckY82lCeUd8MHISavA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixKWpuqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8342C4CEC5;
	Wed,  2 Oct 2024 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876384;
	bh=LoiiqwQuzZXfh7wt1EJ94uphV8ZuGJxi8mKamIG+c0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixKWpuqncU6QQyeQrq6hsF12I0ECZPvClOB84F8dvBjqatIc4GemjBOERMYfuClwl
	 yFeGyLr8Bm0YO8RFM6b5A6gSJ8JvssTJCy1KKsQ7Ton2kCGWNuWOAbNS5zv0BK0pmV
	 P3ajowmbefvZrWYmTGt16JDraNMJ/84VdjS3NIsab4peE7HPtzqRlvYAi6zFZqw8RW
	 RlEJU8UY4olHtmXq4yhk4x+NltGxlSxEjzkHdyIy2U4+c3gnw/o8MKgQZtLONw065R
	 PNIWhFcKIwb5KHdMXTfG+rsjY0LtQzafe6EbxhZT9xwBiZsHL+NPSAquyvJmIL4UOM
	 VuD/J2bcCtfpg==
Date: Wed, 2 Oct 2024 14:39:39 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 12/12] net: vxlan: use kfree_skb_reason() in
 encap_bypass_if_local()
Message-ID: <20241002133939.GH1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-13-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-13-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:25PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, and
> no new skb drop reason is added in this commit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


