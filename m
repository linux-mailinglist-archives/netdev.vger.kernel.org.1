Return-Path: <netdev+bounces-199701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7FEAE1831
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0084716C05E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93623371B;
	Fri, 20 Jun 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLQOqLkH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD7229B1E
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750412975; cv=none; b=b3xx1BDPTv/WtlyfGfRpyeutauts3qj7nC0vzctbOWCvpt75cCTOB8GzOwvO4W5nDFyaqRUKVvrPEFHEgq0SWUinMn2PnhIkqX5+bbWQh0LEaQD3ZWEuFojYTZTjwVhdIf2UlZvw/cKy6v5bh/KnvuwaQHGltZ/cnKaMnDFLvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750412975; c=relaxed/simple;
	bh=VyZTEcFXL4K2nwJC23QYyWRnu9poeE/U/klTwNnRnVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmMaoye1QFsJOHdJyPojavmlpJn0z139WcSYICJ7mdwEOgZHk5ZfkgPqiYrnLLhgLDUQzCNAReHGlFYLkHW3Bcwumit1iSZg1+L49+FlSTfJD0BpDP2hQdbRMob3c4/JE2oQTUGRQqODTlw/GEA7az+1kgaBexvQ6YRjFvs4kO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLQOqLkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912C6C4CEE3;
	Fri, 20 Jun 2025 09:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750412975;
	bh=VyZTEcFXL4K2nwJC23QYyWRnu9poeE/U/klTwNnRnVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tLQOqLkHs0KEw3FuuuVqA5GD3HPOSDiSB2oY+6k4glse+VHvrPgF605arfDr/ir8p
	 GhX1zHMjFnGKi/PtKfQ1YWuDDm+SQZJX5IJXhSN2AVYz9NoSzezjI7RrAXsoJvs1/p
	 ZCV3/Y3sei1LRhCwJX2/rlXixcnljZ+0h4mPK1EJZeGsxgkX2EgkJrq0xcmE79v9Ys
	 ku6+Oylhi043hjtIpZaT9KqFOhbrmREy/RcQ6lkpgCQ/tIhwWuLlw/X/XqfGfgrAfp
	 s51XzhhQeEAYYYnl7A+GN88B09uiIzWWop2I35yUE5wgDdPKK0ZwCB6yeRhOjilP00
	 MBq4QleV8CyTw==
Date: Fri, 20 Jun 2025 10:49:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, shenjian15@huawei.com,
	salil.mehta@huawei.com, shaojijie@huawei.com, cai.huoqing@linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, louis.peens@corigine.com,
	mbloch@nvidia.com, manishc@marvell.com, ecree.xilinx@gmail.com,
	joe@dama.to
Subject: Re: [PATCH net-next 05/10] eth: qede: migrate to new RXFH callbacks
Message-ID: <20250620094929.GB194429@horms.kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618203823.1336156-6-kuba@kernel.org>

On Wed, Jun 18, 2025 at 01:38:18PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


