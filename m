Return-Path: <netdev+bounces-226151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DACAEB9D047
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFD0382D03
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DB29BD9E;
	Thu, 25 Sep 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh8JAHs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFB2580FF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763806; cv=none; b=WdUTT9OtkPvZTUpdGVfjSBncZxFlX6gqFke47JJBJJCbD6LTEM2xwzk26YIgCY3CAJzOfEaX8zOSzC33AfiI70bEHuA1G4oMjli/VEGC2sqYFUqywWCZCQI8MwVjmTSGI3K6m8n2iiE04dCfJkpu+lsu7qNVyFTZXt1yegT+gTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763806; c=relaxed/simple;
	bh=DNdQOFsZpTnkSwjIC1QkmFC06lcwhvPpOOJrDebWelM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSeHre3SZjTPt3JHg71ww2X1NGN46N5RAT9Cg5MWI4Y8qQrI+P7VuSC/M8/RxNECtgX3gpWSwb/ZMnO1ECHZMkkh1XvqxLsaSCHk8abKWvyV80WrvzpPhQPrkRfRbFPnTlELeK7TqisJdFlKRHeutCljuDnf0I+SSszwD+jW/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh8JAHs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAA5C4CEE7;
	Thu, 25 Sep 2025 01:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763803;
	bh=DNdQOFsZpTnkSwjIC1QkmFC06lcwhvPpOOJrDebWelM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kh8JAHs+DJFl3J2YWQ0AnNLKgtR/H5gcPnelCwfAO8sjhk+NWwbyceSnsNzHJEp0L
	 SQzlJNTaDwUbFHwxJeh89IpNs+cWd+UCgszGvS1YN1FVwqg8CXgSNAOzO2bOAKW0pR
	 AQzRMtOTueaBiiTapAoCBwHuvXmougKWVlY35p8yq/1QlD5qNkseWV9Xhkss0kUXr1
	 f9RQ8wlfXN+6k3VlACt3Nq78zZmTV/G6gDGPNHLj2dVdYG8o7nD/HeWup4ae7K3AgT
	 1JItzwmwHr/fD9BJ9V74QVYKt1+Fwc/Q814kf/wbDC3NbI4b4QUQoD2NjdrH4FCTIL
	 KHfRwySYaghkQ==
Date: Wed, 24 Sep 2025 18:30:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 1/4] net: libwx: support separate RSS
 configuration for every pool
Message-ID: <20250924183000.6c2559a8@kernel.org>
In-Reply-To: <20250922094327.26092-2-jiawenwu@trustnetic.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>
	<20250922094327.26092-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 17:43:24 +0800 Jiawen Wu wrote:
> +	if (features & NETIF_F_RXHASH)
>  		wx->rss_enabled = true;
> -	} else {
> -		wr32m(wx, WX_RDB_RA_CTL, WX_RDB_RA_CTL_RSS_EN, 0);
> +	else
>  		wx->rss_enabled = false;

this is just:

	wx->rss_enabled = !!(features & NETIF_F_RXHASH);

