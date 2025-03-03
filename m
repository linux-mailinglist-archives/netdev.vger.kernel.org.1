Return-Path: <netdev+bounces-171407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646FDA4CE10
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB5172F51
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 22:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442581EDA22;
	Mon,  3 Mar 2025 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOYvBbfj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059C1DDA3C
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741040239; cv=none; b=QP+uqWi3xgY74nZBLHaPFFc5Mw1b1idQCHWj3b52tOUswaEerYJtRWboPP/D8Coa9zS30cHhoZaAEleUSHVUZP6AkSvWvFogvFKi1yQenYbohn9TKPQDaYrdKD9PUa7qC8Y0usrDVtsulAZtr7B4epB8umTsPBpMuL09HJjyTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741040239; c=relaxed/simple;
	bh=857rP6cCy3uLBXAeR6Y5n6qquX+BYF5VTV3f0WUcckQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cx3DacMhSASZ01tuS5lwUuSoBAAW+t08zFbqhiLiicYaka1giq4JoLTlHk9m/I+umtfg20YdswISMjcZ+92bIYu+17ex8TAUyzazQLUldAIWtr6sqmjKdes8jLsYk9MHlZLWBhfLVj3uaYgNWBJVH1jZejP6NasyZV4YwIagthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOYvBbfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAB0C4CED6;
	Mon,  3 Mar 2025 22:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741040238;
	bh=857rP6cCy3uLBXAeR6Y5n6qquX+BYF5VTV3f0WUcckQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iOYvBbfjNwnqa+IWMxpkQTzu7iwlWVt4piFrm5NT52F5KpKVxVTv/zCjrCm3Q559D
	 RVKg9+T5vIxn3H5SH51mcN6aLelY8WniF4GCb6oFWs/e0McQumHSZnSvRKkVyVOiOn
	 8AtMp9xyqr7GBQ/2W26nx/5IBh0o23BURFOMNzzbYey5+JtBkO0OBQ8D2+TUCUgHiP
	 heIg3M9SE4/58rfDCQymTyGbF2wdigt+AYyYrmsIwSTm6P98X+nNTHqneJaE+D7hdw
	 UmkYDKepRZ5Om0pFblUvY8IxqPVCI+3J6i2BnxrGt1h7x65o+YVtnruNdM96KPRC21
	 UE7BqiMrCIxwA==
Date: Mon, 3 Mar 2025 14:17:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250303141717.67f6d417@kernel.org>
In-Reply-To: <f5bf9ab4-bc65-45fe-804d-9c84d8b7bf1f@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
	<20250225170128.590baea1@kernel.org>
	<8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
	<20250226182717.0bead94b@kernel.org>
	<f5bf9ab4-bc65-45fe-804d-9c84d8b7bf1f@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Mar 2025 11:55:34 +0200 Gal Pressman wrote:
> >> I can think of something like redirecting all TCP traffic to context 1,
> >> and then a specific TCP 5-tuple to the default context.  
> > 
> > The ordering guarantees of ntuple filters are a bit unclear.
> > My understanding was that first match terminates the search,
> > actually, so your example wouldn't work :S  
> 
> The ordering should be done according to the rule location.
>  * @location: Location of rule in the table.  Locations must be
>  *	numbered such that a flow matching multiple rules will be
>  *	classified according to the first (lowest numbered) rule.

I'm aware, Gal, but the question is whether every driver developer 
is aware of this, not just me and perhaps you.

> The cited patch is a regression from user's perspective. Surely, not an
> intended one?

I believe this message should already answer you questions:
https://lore.kernel.org/all/20250226204503.77010912@kernel.org/
Fix the commit message, add test, repost.

