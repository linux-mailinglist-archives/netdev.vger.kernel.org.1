Return-Path: <netdev+bounces-105274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF191053A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ADD1C211CB
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93061AE096;
	Thu, 20 Jun 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixB6Gs3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8921AE085;
	Thu, 20 Jun 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888213; cv=none; b=cBVzhxLUz8yumb8gv940YFHox6qogTcgsb9Cv7imXHRSh1nF32i7C/Ln9MYQeQ8sCJZUzw8VAT+bI5+54jU0b1PGVXYMKsF/eDGsphu80MfY4/olf1dJnKHdYxNrQi8DW8wSCgtDEYfK9bcv7iC+b70wHmEkDshSviEtkIwjLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888213; c=relaxed/simple;
	bh=tXLi4UuvBMYUCpzgxQI2lGUzyM4OT5p8d5BymnNHJug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZzkXXmNIwmvsz48uD8iS0CcN11iClpdpP3YEvDNSDZ4e1l912MGfgpaSVslV+YTEPZ9Bef8VeiltV0xTxHyLM7+a3PPYH7RCZs+/FG1xjTJoqFZJy0vj9+r7JB2LHw5AEuhrI2xEI7TOy7CNQecXIENkJ3YuChnnYwN7k3PNjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixB6Gs3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEE7C2BD10;
	Thu, 20 Jun 2024 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718888213;
	bh=tXLi4UuvBMYUCpzgxQI2lGUzyM4OT5p8d5BymnNHJug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixB6Gs3H7rCT40z5hmpzmamNul9oN+bAWUYivmCKWMPq+V5eZQ3tr3EYdozarEKWw
	 hHXCfByk4JqxFLOrmpAp4fy393vVHbvzN1bhGQIqfKdpPG52Wl1UJHTO/cpvWe8Gx7
	 damGPa+BCpPDQYOi4VbuqubgSOeCt3FURriwpk5oiXYJpJVzzJUTAJBbdyYhp8vo6M
	 ODp+dkUMBm+P677NtPVVVMXJ/40126OsEF/69JFdz1zQmSI9ai/xcIjUKBrvDnICur
	 RST+4jt4/qh8gYXiKY+XMz735zJKOtOyAbPxzwzGWk3l+rQ7POP7ccCDoLYtp8kqdd
	 Gw2T/JJmOYlQg==
Date: Thu, 20 Jun 2024 13:56:49 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v4 08/10] octeontx2-pf: Configure VF mtu via
 representor
Message-ID: <20240620125649.GI959333@kernel.org>
References: <20240611162213.22213-1-gakula@marvell.com>
 <20240611162213.22213-9-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611162213.22213-9-gakula@marvell.com>

On Tue, Jun 11, 2024 at 09:52:11PM +0530, Geetha sowjanya wrote:
> Add support to manage the mtu configuration for VF through representor.
> On update of representor mtu a mbox notification is send
> to VF to update its mtu.
> 
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


