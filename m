Return-Path: <netdev+bounces-38448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF5E7BAF6A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 01:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E6956281FDE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE844460;
	Thu,  5 Oct 2023 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPdr5II4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146741E57
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 23:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9277C433C8;
	Thu,  5 Oct 2023 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696550026;
	bh=DIWyQWrAkNg7CQ5He+VSWxNbQiFeyvAaYawNY3QvPvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lPdr5II4nR2CThAcQDHU3ukc/wCxHthoT2/gf4+Z9wzHsHZqXkdqYc5unEPM/mC5/
	 N5JDl5LWcFo6MgY8GpHP9R6nUYeX1fIBEMSVPkmv4TtMphQY9xEM5rP/kzUihxHyD0
	 Q0t0QolX3UZrSep/g2h2sieliegYyJbzsilFOJTR9/Kvyo1ISAVKxBZFmt09WpqcJt
	 DCiSJ+hBRwdg3lBOgYU/jMxoaOuxTvfrYXmpYDMe05Yv05p2wwETLeEVdjwFMHIeN8
	 +od0aGBFJ6s6smyFS3s8hxoP5IBWFg510XaWYi7djOV8dJxA0b4FEx0GELXOUnBBv7
	 AcBBkbyWXVbNg==
Date: Thu, 5 Oct 2023 16:53:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: edward.cree@amd.com, linux-net-drivers@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 habetsm.xilinx@gmail.com, sudheer.mogilappagari@intel.com,
 jdamato@fastly.com, andrew@lunn.ch, mw@semihalf.com, linux@armlinux.org.uk,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, saeedm@nvidia.com, leon@kernel.org
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of
 custom RSS contexts to a netdevice
Message-ID: <20231005165344.50228a06@kernel.org>
In-Reply-To: <3e82593a-f083-8061-5ff3-3e04c70afee6@gmail.com>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
	<4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
	<20231004161041.027b2d80@kernel.org>
	<3e82593a-f083-8061-5ff3-3e04c70afee6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 19:43:36 +0100 Edward Cree wrote:
> > Is this one set by the driver? How would it be set?  
> 
> I was thinking drivers would just assign this directly in their
>  probe routine.
> 
> > It'd be good if drivers didn't access ethtool state directly.
> > Makes core easier to refactor if the API is constrained.  
> 
> Would you prefer it as a getter in the ethtool ops?  The core
>  would call it every time a new context is being allocated.

If ops work that'd be simplest. I was worried that the exact limit 
may need to be established at runtime based on FW/HW gen, and that's
why you place it here. But that's a more general problem with the
current simplistic approach of sticking all the capabilities into ops.
If you only need a static cofing we can go with ops and add runtime
corrections for all caps later on.

