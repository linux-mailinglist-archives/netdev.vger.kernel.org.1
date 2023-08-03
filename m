Return-Path: <netdev+bounces-23832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B9476DD0B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1221C21220
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7EB1C3C;
	Thu,  3 Aug 2023 01:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052E47F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB84C433C7;
	Thu,  3 Aug 2023 01:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691025223;
	bh=jJx5NlEJLKyCLwr9/8OEo0e98eJF2aZClaXFa4XHZvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWVryhR3cegQIPZhi4pK8Wuh6eHGmQcVEeM4jHapXb9w7SxMPpJEu6Y20Ck183RUt
	 oxSG7VZi4zjgVgkLIxsybbtuZW1vGO5CQeDswiSGF3TBSg+VosYb6v6xncy471vtYO
	 pYxy4g0Bq8D7RNaBazOAxaiCxCaLNqXgE07blEzLW+jWqC5sIS/M/G96XAzJF4tVPP
	 d6ahZZfn635h7/qo3DoTQzFAcbfyr+/LGPkLRX0NwFQreRKW0OkviGcvydGxWTi0fT
	 dD9TQbAFfLdE8l1tgMsTAK9LDfMz5673bs7cvexCTG15Cug5AaIUa8Y84GdXujEKtv
	 AkJDIprE3G8VQ==
Date: Wed, 2 Aug 2023 18:13:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>,
 <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH net] octeontx2-pf: Set maximum queue size to 16K
Message-ID: <20230802181341.14cb2e4b@kernel.org>
In-Reply-To: <18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
References: <20230802105227.3691713-1-rkannoth@marvell.com>
	<18fec8cd-fc91-736e-7c01-453a18f4e9c5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Aug 2023 18:11:35 +0200 Alexander Lobakin wrote:
> > -	ring->rx_max_pending = Q_COUNT(Q_SIZE_MAX);
> > +	ring->rx_max_pending = 16384; /* Page pool support on RX */  
> 
> This is very hardcodish. Why not limit the Page Pool size when creating
> instead? It's perfectly fine to have a queue with 64k descriptors and a
> Page Pool with only ("only" :D) 16k elements.
> Page Pool size affects only the size of the embedded ptr_ring, which is
> used for indirect (locking) recycling. I would even recommend to not go
> past 2k for PP sizes, it makes no sense and only consumes memory.

Should we make the page pool cap the size at 32k then, instead of
having drivers do the gymnastics? I don't see what else the driver
can do, other than cap :S
-- 
pw-bot: cr

