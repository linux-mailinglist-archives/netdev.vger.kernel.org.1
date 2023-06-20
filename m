Return-Path: <netdev+bounces-12355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE21A73732C
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 19:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072522813B9
	for <lists+netdev@lfdr.de>; Tue, 20 Jun 2023 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45342A955;
	Tue, 20 Jun 2023 17:49:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D8F2AB3A
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 17:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E333C433C8;
	Tue, 20 Jun 2023 17:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687283352;
	bh=0wJcGBgyILE2XLRTPn33HEgQx2fkLPGoc11dr/UIKRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=idGL/fNeqoxiB/XTSAhnnZlTFkamLdLKzehlWT7JbQ4euLneryRlDFYsL0fTWikWb
	 gsqi/B1bCvO0csIbenUqI/jjVDKQgxN34JbxnHZkC6UhgEXP71CLe9qvqJZh4C7aAY
	 5OZurPcsajwd2pTl5RFiTI/pm45r4wHPhBYRldkl3gAoP766UTaM+ja37sSxuE77+p
	 RNVZuL9/OxjhTNbKNyJeZ/MPH9H/lVVaZYfCEjhGVPgy52dJcQK85Gvj5i9Y+vyLpB
	 1SKrXWsaDlYqV/8iYx+AWFDlGdfVkAfQNcphBKk7B+VhhypR3CbjxGf74Qu3qg61+c
	 2zjjsE/erpUgA==
Date: Tue, 20 Jun 2023 10:49:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
 <anthony.l.nguyen@intel.com>, <magnus.karlsson@intel.com>,
 <michal.swiatkowski@intel.com>
Subject: Re: [PATCH iwl-net] ice: add missing napi deletion
Message-ID: <20230620104911.001a7a4a@kernel.org>
In-Reply-To: <ZJHgOXXHFjsOjlnA@boxer>
References: <20230620082454.377001-1-maciej.fijalkowski@intel.com>
	<20230620095335.43504612@kernel.org>
	<ZJHgOXXHFjsOjlnA@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 19:22:01 +0200 Maciej Fijalkowski wrote:
> On Tue, Jun 20, 2023 at 09:53:35AM -0700, Jakub Kicinski wrote:
> > Is there user visible impact? I agree that it's a good habit, but
> > since unregister cleans up NAPI instances automatically the patch
> > is not necessarily a fix.  
> 
> It's rather free_netdev() not unregistering per se, no? I sent this patch
> as I found that cited commit didn't delete napis on ice_probe()'s error
> path - I just saw that as a regression. 
> 
> But as you're saying when getting rid of netdev we actually do
> netif_napi_del() - it seems redundant to do explicit napi delete on remove
> path as it is supposed do free the netdev. Does it mean that many drivers
> should be verified against that? Sorta tired so might be missing
> something, pardon. If not, I'll send a v2 that just removes
> ice_napi_del().

I personally prefer to keep track of my resources, so I avoid devm_*
and delete NAPI instances by hand. It's up to the author and/or
maintainer of the driver in question.

My only real ask is to no route this via net and drop the Fixes tag.
Whether you prefer to keep the patch as is or drop ice_napi_del() --
up to you.

