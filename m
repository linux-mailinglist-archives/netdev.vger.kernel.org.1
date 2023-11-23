Return-Path: <netdev+bounces-50592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE257F63E9
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF6552817D2
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFB3E483;
	Thu, 23 Nov 2023 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZ3njrX2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C43FB09;
	Thu, 23 Nov 2023 16:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EB7C433C7;
	Thu, 23 Nov 2023 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700756858;
	bh=wVpcKEukuhQXLMX9GwSa/WB7vbnjtJeSjgYXrT7QprQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZ3njrX2vdIERXA1O9SLwM8vaKmHgvRv/BcDebBRtBRvYUvcTJ6w4E/Jz4WCzl1NC
	 +pAzEdxmZbtrgiIN4jdKdkHqpYrfiajD4MPcMRcQVFZAwuxoj11x2Miqd5G7h2KzX3
	 /TMbssJ2arDIJbWxI/L0MnX/3Dw34KdgPUyBRJhy8OQqSuJDHHM/8ncrbKmxgzaisF
	 X9U64xNH8/akOJY38HkXP1NQcKDZ3VrYuByEuwyU2/kCmCvB49H0RhG95kC5/r8XKS
	 aIhfHONjU/HgDNo9VqkYOCciant6YcueLKjp6gbc1YOdFaJQ0LmvBVEyvfwZmRIH+d
	 /ImJYTTrucdNA==
Date: Thu, 23 Nov 2023 08:27:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com,
 alexander.duyck@gmail.com, linux-doc@vger.kernel.org, Wojciech Drewek
 <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: add support for
 symmetric-xor RSS hash
Message-ID: <20231123082737.471727c0@kernel.org>
In-Reply-To: <96d16597-12a7-4574-9c22-98a1b70bc21a@nvidia.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-3-ahmed.zaki@intel.com>
	<20231121153358.3a6a09de@kernel.org>
	<96d16597-12a7-4574-9c22-98a1b70bc21a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 15:33:04 +0200 Gal Pressman wrote:
> On 22/11/2023 1:33, Jakub Kicinski wrote:
> > Last but not least please keep the field check you moved to the drivers
> > in the core. Nobody will remember to check that other drivers added the
> > check as well.  
> 
> The wording of this sentence is a bit confusing, so I might be repeating
> what you already said, but this patchset needs to make sure that drivers
> that do not support the new symmetric flag return an error instead of
> silently ignoring it.

Ah, good point! That, too.

I was referring to what changed in v5, from the change long:

  v5: move sanity checks from ethtool/ioctl.c to ice's and iavf's rxfnc
      drivers entries (patches 5 and 6).

