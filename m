Return-Path: <netdev+bounces-128320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9E1978F82
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FF6EB2524D
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F061527B1;
	Sat, 14 Sep 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJV5qPSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFC143723;
	Sat, 14 Sep 2024 09:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726306250; cv=none; b=XPZrttg9w39+97KTBOr4+Y5+EsAej2cx7qvwQl1wJTnnbDmwERCT+kHjjV81tdnA3GYe3/a+ftamoa/a6KKVbZvUsFPMrqUy/0WVrx2OXoBKl2d/BnGmsr5OFOiclRoxlGrS4kuPIiWEpRIgy8gaLkXK2NmcH42A51DIi0nAe9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726306250; c=relaxed/simple;
	bh=zQdnVZ+pwfk/ta1l23Uis3dIPJki5tw4PvxHeFU9xRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSqKLEoX71AJSsXAu0YE/b5rkHZUS/GLODRJ82hZ95i4WPQu8IGt9iZhu9pG7sMAv3wfgggxxl1dV4fZ6AC0RtMWRhuKRbL7F4Hh7RAtn2EoDMUoelO+lICX8LDGHNze+TgmtIgBukf2ujzMyVmTfl0fZqqIaG0a+mvXbMKoqhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJV5qPSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17264C4CEC7;
	Sat, 14 Sep 2024 09:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726306250;
	bh=zQdnVZ+pwfk/ta1l23Uis3dIPJki5tw4PvxHeFU9xRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJV5qPSYa58zTfwOqnrXsZT+656CdQFn42OoG3m/7Kee4UnPj6DtFEcis0sIwgmn0
	 QlxwHcf7T3KvJzFEgga88Jwyiysg8ttodTjtoQ638I7QINJgJG5FDCJdHHUfLjpdX2
	 EwE7pE91lUrpRtShod4AOPbHKxEmkz5ZZSXhKzbdJCqSLJTYitJaGpgo8II02RmCib
	 Xy7WjLQeaOpgxHzBCOOvqpqy44aCbuP/eVXnBsTgmVOQa9Hcyfon/O+XKkGJR9k8Hl
	 q39cg6r2ciG+JjMMW3MnsKSu2FFUKmZ3LKUCfJIMFEz18L8fdT8VZbbrmxoOYQLcon
	 O8+UFQ2QftOWA==
Date: Sat, 14 Sep 2024 10:30:45 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 10/12] net: vxlan: use kfree_skb_reason() in
 vxlan_mdb_xmit()
Message-ID: <20240914093045.GE12935@kernel.org>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
 <20240909071652.3349294-11-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909071652.3349294-11-dongml2@chinatelecom.cn>

On Mon, Sep 09, 2024 at 03:16:50PM +0800, Menglong Dong wrote:
> Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
> reaons are introduced in this commit.

nit: reasons

...


