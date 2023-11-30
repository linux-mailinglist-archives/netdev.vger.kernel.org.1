Return-Path: <netdev+bounces-52595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39FE7FF4F5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCCFB1C20F0A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751954F94;
	Thu, 30 Nov 2023 16:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtG7pF0s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC5495C2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8430C433C9;
	Thu, 30 Nov 2023 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701361489;
	bh=kV8tizWIsmyBHYG9QWSQvffaJTYnRvbTCWtHtmex8xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtG7pF0sEbDdJ4m61zETde9fq5BFMpnnDQdsN2uCKwftC9YAjJHcX6r1p5DktsaRz
	 SPgjvw8+Mgxr3s0QwQ6L/kSTZv6nnGBWWt2u/sjWZs/OQGy7qA5odpK9M5vpzzj/Oa
	 /OmIJ2+d9biow5Lp66RGEOEu8/iZciy2wKszVdWrFv9MKrsYe+yFspQN2it4sBGnb8
	 3kq3TWzZ9oBSR8nDS4gEBQO/zm3zhauXAYCkeinDw5ZAJq0Odq6yokaKMiq51JOKZc
	 GsDevNLvPHe8ddXdhVRmqUilyX7GS1QuSYRvghRQxad6qLt1AmJGRZLziOW/ZQySvz
	 smPa0+Y2AK+Tg==
Date: Thu, 30 Nov 2023 16:24:44 +0000
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Subject: Re: [EXT] Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
 otx2_get_pauseparam
Message-ID: <20231130162444.GA32077@kernel.org>
References: <1701235422-22488-1-git-send-email-sbhatta@marvell.com>
 <20231129172633.GG43811@kernel.org>
 <CO1PR18MB466634805050CE390447F811A182A@CO1PR18MB4666.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR18MB466634805050CE390447F811A182A@CO1PR18MB4666.namprd18.prod.outlook.com>

On Thu, Nov 30, 2023 at 04:36:22AM +0000, Subbaraya Sundeep Bhatta wrote:
> Hi Simon,
> 
> >-----Original Message-----
> >From: Simon Horman <horms@kernel.org>
> >Sent: Wednesday, November 29, 2023 10:57 PM
> >To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
> >Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org;
> >davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> >Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> ><gakula@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>; Linu
> >Cherian <lcherian@marvell.com>; Jerin Jacob Kollanukkaran
> ><jerinj@marvell.com>
> >Subject: [EXT] Re: [PATCH v2 net] octeontx2-pf: Add missing mutex lock in
> >otx2_get_pauseparam
> >
> >External Email
> >
> >----------------------------------------------------------------------
> >On Wed, Nov 29, 2023 at 10:53:42AM +0530, Subbaraya Sundeep wrote:
> >> All the mailbox messages sent to AF needs to be guarded by mutex lock.
> >> Add the missing lock in otx2_get_pauseparam function.
> >>
> >> Fixes: 75f36270990c ("octeontx2-pf: Support to enable/disable pause
> >> frames via ethtool")
> >> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >> ---
> >> v2 changes:
> >>  Added maintainers of AF driver too
> >
> >Hi Subbaraya,
> >
> >I was expecting an update to locking in otx2_dcbnl_ieee_setpfc() Am I missing
> >something here?
> >
> I will send it as separate patch since both are unrelated and I have to write two Fixes
> in commit description.

Understood.

In that case I am happy with this patch.

Reviewed-by: Simon Horman <horms@kernel.org>


