Return-Path: <netdev+bounces-23330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD9276B923
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E01281B10
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A771ADE2;
	Tue,  1 Aug 2023 15:53:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA81ADCA
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 15:53:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D15C433C7;
	Tue,  1 Aug 2023 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690905182;
	bh=0VSHotX2jY3Yy+3qg4dJYBqil+o8owfxSaIzVR5cTXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oZ+DN56CsPLJtv24VA0f8gYFLV6SchzIA0UAxhtDXjzOGSgxCISUyhqgbT2JV6hlI
	 T/NHiT1BHqVM3lWnecC3bFdLVcYPbAyaCKKhAUUMCxClKO8/WCqQpZ2UE1uc7+ccpd
	 Y/zEB181zfhWYdqGU/6zBQlInqqZ6yQTT8WD5+/qD4SRE9DTbYgjsQGQc+hbxYMily
	 w9sWeejE3SzloKpmP0e5qEvxeRPrpKKiaaYsZPvzuFi6F/oVbKIOXPD3u66oZ7NOJZ
	 R9Ox5uELwI8xtRFNNadbrHISBUu4uhDDmSjvQKIFUDYbuehvrjQ0FxOkKhiFk7tkj5
	 oKWWJyMvBbX5Q==
Date: Tue, 1 Aug 2023 08:53:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 10/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <20230801085301.3501fbbb@kernel.org>
In-Reply-To: <ZMipQcNtycg6Zyaq@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-11-jiri@resnulli.us>
	<20230725114044.402450df@kernel.org>
	<ZMetTPCZ59rVLNyQ@nanopsycho>
	<20230731100341.4809a372@kernel.org>
	<ZMipQcNtycg6Zyaq@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 08:42:09 +0200 Jiri Pirko wrote:
> >> >Also - do you know of any userspace which would pass garbage attrs 
> >> >to the dumps? Do we really need to accept all attributes, or can
> >> >we trim the dump policies to what's actually supported?    
> >> 
> >> That's what this patch is doing. It only accepts what the kernel
> >> understands. It gives the object types (as for example health reporter)
> >> option to extend the attr set to accept them into selectors as well, if
> >> they know how to handle them.  
> >
> >I'm talking about the "outer" policy, the level at which
> >DEVLINK_ATTR_DUMP_SELECTOR is defined.  
> 
> I don't follow :/ Could you please describe what exactly do you mean and
> want to see? Thanks!

It's a bit obscured by the macros, but AFAICT you pass
devlink_nl_policy for the dumps, while the _only_ attribute
the kernel will interpret is DEVLINK_ATTR_DUMP_SELECTOR
and its insides.

