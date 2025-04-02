Return-Path: <netdev+bounces-178817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E923A7907B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC6A1693F6
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8953D23A9BE;
	Wed,  2 Apr 2025 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbEp56dS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F350367;
	Wed,  2 Apr 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602286; cv=none; b=Ub8OXA1tBfXvq38/9sCjfZP1LeNHxKAYJ12wQJFlN8BKoSqEO6Rdo5YmUQACXuhQD20bXYVXQSDNg6E2FbN4uumtPPyMWo9pMD2tjO1biQdrljSle7YY9gVRe2ucn0oqbH8JpIrkLm99LMKWvvvAWXWxUkvlOMdwmYu4zvveniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602286; c=relaxed/simple;
	bh=FIoYzeoXhyJBluw6YgOTmi9peTT/C0eQfJSSBMCpygE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRNo5dfqDxuMTWK1NA9v4CzGQOj4JD4AT3tunXWNj4GYai3B2R40G2cdcgEEUz/ZtkK3GwsL8FlzUCdUTgtruwD82H3gw2wAhj8GgGpR2HU7035Oweyg7zOeRrcg/qP4quk5VoymYRYoOQNTirvkux4IahhwEgcNO61UQpdpHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbEp56dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2AAC4CEDD;
	Wed,  2 Apr 2025 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743602285;
	bh=FIoYzeoXhyJBluw6YgOTmi9peTT/C0eQfJSSBMCpygE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qbEp56dS3gE0oTc0JYdfqXUjUqRk4BNpQf18IZbnse2s0Oh4izsJ6pZMlQmsErrvo
	 1Sf0WZK3vFgkesXS0htxd36LkCdcb45kSiZc69S/5yQ0ejxbvPCJywYDFhkdonOg3O
	 HCl4SY5cf4PQ81iCMs3e6oyz1PjEEsnxAav06gwgkbTplqSDtWU37DhKkMNEtmypXc
	 ppIbqe0hLeCvf9F/Mt+3Fs5HXzd0lh+J6VELaKJv+qLK4pJcyjAQo5H3Fl/Okbc93n
	 inrQV1XbIjL3KG2TmRQ88HgR7mNpQHtocPPLgmB5b08aFp/RqW2rFSu6hB7E0nQWD+
	 veu3pog8riARg==
Date: Wed, 2 Apr 2025 14:58:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/3] net: hns3: fix a use of uninitialized variable
 problem
Message-ID: <20250402135800.GP214849@horms.kernel.org>
References: <20250402121001.663431-1-shaojijie@huawei.com>
 <20250402121001.663431-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402121001.663431-2-shaojijie@huawei.com>

On Wed, Apr 02, 2025 at 08:09:59PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> In hclge_add_fd_entry(), if the flow type is FLOW_EXT, and the data of
> m_ext is all zero, then some members of the local variable "info" are
> not initialized.

Hi,

I am assuming that this occurs when hclge_fd_check_spec() returns early
like this:

        if (!(fs->flow_type & FLOW_EXT) || hclge_fd_is_user_def_all_masked(fs))
                return 0;

But if so, should the description be "flow type is not FLOW_EXT, ..."
(note the "not")? Or perhaps more clearly refer to the FLOW_EXT bit
not being set?

Also, I think it would be worth mentioning hclge_fd_check_spec()
in the patch description, perhaps something like this.

  In hclge_add_fd_entry(), if  hclge_fd_check_spec() returns early
  because the FLOW_EXT bit is not set in the flow type, and ...

Also, does this manifest in a user-visible problem? If so, I think
it would be good to describe it in the patch description.

If not, I think it would be good to mention how the problem was found.
E.g.: "flagged by static analysis" (and mention the tool if it is publicly
Available. Or, "found by inspection".

> 
> Fixes: 67b0e1428e2f ("net: hns3: add support for user-def data of flow director")
> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

