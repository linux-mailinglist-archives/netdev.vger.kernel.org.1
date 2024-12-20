Return-Path: <netdev+bounces-153565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04079F8A87
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752E37A215F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644341EB5B;
	Fri, 20 Dec 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQ6BE0DW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A172AD2A;
	Fri, 20 Dec 2024 03:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734664918; cv=none; b=I+V6Aa/cNu9212eHTqdtDvEid4JL45okjvQ4UlyP6sDhfSWZxakyao+XES78iS/7qgywJfDE2cuCxZQMgyR2VRn8z2PJB1Ng+X5ChLWZU7ZaPpG8VYhN8ErpKBgZa/QjemgoZSMOofSLNrTvt9yoUInYBy20XvaNEQtTr0hRA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734664918; c=relaxed/simple;
	bh=4A5GC0CuS7vZrr7Mo4DGkX4xn6ZEr97Hk1JzoTAxqTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r95XRhanlqICXiYDb2fbEy+eSkAUa8r0h6BKc5cbuNtcJpDo35XYG2t5dlzwZ85tMChiVcPbqF2QGPfGI6qQcf1Z95I90MJFk9X51DI5nfyC5TMLD+k/SvNQ7B6fwwMhKr4n+gARDjOhYbwif5qJlPgjhW6RRVjoAPhc5Np3B6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQ6BE0DW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B69C4CECE;
	Fri, 20 Dec 2024 03:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734664917;
	bh=4A5GC0CuS7vZrr7Mo4DGkX4xn6ZEr97Hk1JzoTAxqTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lQ6BE0DW5UTwk6JXOPu05+gVBBd9NofcXk6JP/LWNYO5NyF0S92rqbEksvTmVEIKI
	 hA8TGp9O5upClSqrrTq3ixuej6KG8S+e0gnYSwj4z3Zln15UM59z0bNpzzotomhqCu
	 dlgZkbMsXvRyREkIsfS3EI0KY1VQXkMQXE1xYSE8DvfYEOi9+WEB51QsoOnyvogiUD
	 PF5Y8i1yk+fndI0ZEXOQHC989vke5Zfn/k9YwkU3/Pgc1ldpbMf/Mq+ntI88V5kMUg
	 c4RZW+GJIvq3AjFkudPNJcQgLhRdHA0CzpcdNQDNcM1rW0VjIH2WK12eZg1dZU0/KE
	 7UAS03G0ESWHg==
Date: Thu, 19 Dec 2024 19:21:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Satananda Burla
 <sburla@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v3 3/4] octeon_ep_vf: fix race conditions in
 ndo_get_stats64
Message-ID: <20241219192156.71b3075c@kernel.org>
In-Reply-To: <20241218115111.2407958-4-srasheed@marvell.com>
References: <20241218115111.2407958-1-srasheed@marvell.com>
	<20241218115111.2407958-4-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 03:51:10 -0800 Shinas Rasheed wrote:
> ndo_get_stats64() can race with ndo_stop(), which frees input and
> output queue resources. Call synchornize_net() in ndo_stop()

synchronize_net() here..

> +	synchronize_rcu();
>  	netdev_info(netdev, "Stopping the device ...\n");

.. but not in the code
-- 
pw-bot: cr

