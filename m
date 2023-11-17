Return-Path: <netdev+bounces-48707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFA7EF52F
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22F51C208B7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642C73159B;
	Fri, 17 Nov 2023 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHQu+W+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8230344
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B2C433C7;
	Fri, 17 Nov 2023 15:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700234632;
	bh=8jymyTjlplZ9cSAQWeCDrroYFqyhGA4t0vs4Dt3RKTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hHQu+W+JB+1W5hq9FsixrF/13O1Brw15tjMvun6rZ35trYSF7B5BoElNwI1s03hS2
	 SUaGC6EBOOpbGRykpoP6fOK1kulQ3lbbmJRCGHItVo0ceShScvDEGe29ZeOjjCZU8x
	 4UxSeLID0NW21wrSD1hVWiiW82D5f11GwOXOFUYPtMNYFXb+AskV2ZI9mzNUd4O21H
	 0i0vyAsz40En4666HRZP8NC0bDBFePP9BWzP9G7sTzLPo+Bwjq+dXEgtE97G5GuuqC
	 sjO90p7dw+w6741ScgK51kLNpWrLABNLMXvubK4UrgGO6OiJM040+tov9OFSDQGwsF
	 xD7slIpXk0SDg==
Date: Fri, 17 Nov 2023 15:23:48 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 04/14] devlink: Allow taking device lock in
 pre_doit operations
Message-ID: <20231117152348.GD164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <ecb76739d85bb0cb2977520c17c9af31a6228abe.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecb76739d85bb0cb2977520c17c9af31a6228abe.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:13PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Introduce a new private flag ('DEVLINK_NL_FLAG_NEED_DEV_LOCK') to allow
> netlink commands to specify that they need to acquire the device lock in
> their pre_doit operation and release it in their post_doit operation.
> 
> The reload command will use this flag in the subsequent patch.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> @@ -93,11 +95,13 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs)
>  static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
>  				 u8 flags)
>  {
> +	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;

nit: I would have expressed the above as follows, to convert
     the integer to a bool. But I understand that it makes
     no difference in this case so there is no need to update the
     patch for this:

	bool dev_lock = !!(flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK);

...

