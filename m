Return-Path: <netdev+bounces-131232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDFF98D66C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0618F1F23126
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D51D096B;
	Wed,  2 Oct 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szwpCkBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B71D07B5;
	Wed,  2 Oct 2024 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876352; cv=none; b=AtGVFc1dZ79UYUhZIWyk4cKO9rrz0E+8FzK+axHb2ZkSuRphSoEH0tEFm5nUkLmN0KuYoVKyiaZ9U5gDxhuaSWJHT45wyUh3WYWWRPwM14TmWmKpRSiOBw+LFpE0sDOLdXLcAaGZSDSHok+X8i9gwpAe+RNt7KAR1Ni3QwMkXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876352; c=relaxed/simple;
	bh=Jmomiz1uTD2WDSSWz9CbQb3HDCn2lPFkFUWZIzGKyp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lB2/IvsJJiJQjNzkSxY5pOdYc9XiDxP/iLAX+hEnLdf6ZfYbRwGkg7cUNqn8z/nD/BV/eTeyiHzHDYCYJKnU/UNK4M/LgGGvABXjqtSTkWb29YYtl6CWVCSRPZg/CD0aM98CAXze1oPzAMG3f2Gyec5ngbHGCk6aj0/QrZ3zsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szwpCkBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACA0C4CEC5;
	Wed,  2 Oct 2024 13:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876352;
	bh=Jmomiz1uTD2WDSSWz9CbQb3HDCn2lPFkFUWZIzGKyp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szwpCkBL9D4fgvurFUIrPJYJyrhXoW2kxJc+mHEW7z8IsIlxpfkEhfUbcI+AXGtQz
	 P8z0JcoNVaSgQpMayLl3/tAtqIVOYunCz1H8MARyQA8N/gQr8qxbj/ZZj/7jY8A3w6
	 fl2p6AZcZVkVOp9Nj7rfFNz5EauLru+yssdBq+rXx84b4PZvvvt0Y4b3UY/Hgc4OEe
	 +JzAJdAQekFZXJF2Q8buDDa4LMRNB1yIsYOH4lLv6VM0/v+PD+CmkesIdTC6ZSlGyp
	 PtslJjc2tLoxcsLyafgYRLoAz4MlRT2Eqme1odowQwNkuzx67VLRbzSvUkq4r4eUiz
	 Z3TIA+dk32DVg==
Date: Wed, 2 Oct 2024 14:39:07 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 10/12] net: vxlan: use kfree_skb_reason() in
 vxlan_mdb_xmit()
Message-ID: <20241002133907.GF1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-11-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-11-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:23PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
> reasons are introduced in this commit.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


