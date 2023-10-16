Return-Path: <netdev+bounces-41215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC747CA416
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8165B20C6B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076211C6A9;
	Mon, 16 Oct 2023 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVQMhtgQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13B1A29A
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485C2C433C8;
	Mon, 16 Oct 2023 09:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697448426;
	bh=K6N7taMNzX8fRSK+a4h5bAnL1ClZhYOHgnAw8kLuxgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVQMhtgQmEmd5OAjsfBAeqca4uAcYytlr0LvgAArGWkEeBIyQxupcpKwvSJ5y+cD2
	 gcAuDvyWNvjEoem4fP/PwlSsFromuX6NrjHd8I1xAQNtM6rPv+cDYd/p+Hk4SGqxSu
	 G+6odt9u2IAzgz0QHx69p64eosCwuLnxiE/kQaioCB6Vy2/JHJGuuvb0nZb88l8kv/
	 tek7Vr48wkbVNblS63Ts09cNXP3A4fxI3K/Rq9IXnxnJHKOW3M25HZkQxfxSUlomoM
	 Pb7E23H35Z0rRA+yG7YMedxdyt2HLBghpMX9Ozy3RiYqlCLlXG3CNHxhZXxyK35pio
	 DgR1J89bC++tw==
Date: Mon, 16 Oct 2023 11:27:00 +0200
From: Simon Horman <horms@kernel.org>
To: Takeru Hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231016092700.GH1501712@kernel.org>
References: <20231012060115.107183-1-hayatake396@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012060115.107183-1-hayatake396@gmail.com>

On Thu, Oct 12, 2023 at 06:01:15AM +0000, Takeru Hayasaka wrote:
> This is a patch that enables RSS functionality for GTP packets using
> ethtool.
> A user can include her TEID and make RSS work for GTP-U over IPv4 by
> doing the following:
> `ethtool -N ens3 rx-flow-hash gtpu4 sde`
> In addition to gtpu(4|6), we now support gtpc(4|6),gtpc(4|6)t,gtpu(4|6)e,
> gtpu(4|6)u, and gtpu(4|6)d.
> 
> GTP generates a flow that includes an ID called TEID to identify the
> tunnel. This tunnel is created for each UE (User Equipment).
> By performing RSS based on this flow, it is possible to apply RSS for
> each communication unit from the UE.
> Without this, RSS would only be effective within the range of IP
> addresses.
> For instance, the PGW can only perform RSS within the IP range of the
> SGW.
> problematic from a load distribution perspective, especially if there's
> a bias in the terminals connected to a particular base station.
> This case can be solved by using this patch
> 
> Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
> ---
> Added commit messages and options based on reviews

Thanks Hayasaka-san,

Overall this looks good to me. And I see that the review of v1
has been addressed - by adding information about the need for
this to the commit message.

Reviewed-by: Simon Horman <horms@kernel.org>

