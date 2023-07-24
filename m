Return-Path: <netdev+bounces-20552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D8076011B
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0FA1C20C80
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A811188;
	Mon, 24 Jul 2023 21:21:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88566107B7
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:21:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DFDC433C7;
	Mon, 24 Jul 2023 21:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690233717;
	bh=KcmOvjdsIerNh9iSPOIWnJQYWkn+4DhLR22pWifJh68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wb0PN3QFq+FC5EzT5PMzMn8X3+hXurSz7N4oj71as22oZ5BheFT6FS7tYLQyIqwy0
	 FFtVf5qKLvDaIzk2hUrAC/PrgOAfrawHIgRoKeNiIoAGscZTYq1YgvfcWUjDV7FxBc
	 qrHZwJx2r0AFP3NldFG4SwYZPD6ryn72aV373L9iENvpkM9WnJ0A67xVCzbme8tsqJ
	 A0max3XRxjfoKurA51JQGiaZgb8pKH8Dc3JaKinewdlcORonMTipSfk6V/8nKTYcKx
	 5WNcGhpuU3jjItgdoNOO/fNQqTqvfjoUlv+7Ig2Es4zGrsYSR3yazkHm3Axs3Op8R4
	 PVkynMm2fhx2g==
Date: Mon, 24 Jul 2023 14:21:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>, Lin Ma <linma@zju.edu.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230724142155.13c83625@kernel.org>
In-Reply-To: <20230724174435.GA11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
	<20230724174435.GA11388@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 20:44:35 +0300 Leon Romanovsky wrote:
> > @@ -13186,6 +13186,9 @@ static int i40e_ndo_bridge_setlink(struct net_device *dev,
> >  		if (nla_type(attr) != IFLA_BRIDGE_MODE)
> >  			continue;
> >  
> > +		if (nla_len(attr) < sizeof(mode))
> > +			return -EINVAL;
> > +  
> 
> I see that you added this hunk to all users of nla_for_each_nested(), it
> will be great to make that iterator to skip such empty attributes.
> 
> However, i don't know nettlink good enough to say if your change is
> valid in first place.

Empty attributes are valid, we can't do that.

But there's a loop in rtnl_bridge_setlink() which checks the attributes.
We can add the check there instead of all users, as Leon points out.
(Please just double check that all ndo_bridge_setlink implementation
expect this value to be a u16, they should/)
-- 
pw-bot: cr

