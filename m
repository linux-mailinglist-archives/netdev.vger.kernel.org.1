Return-Path: <netdev+bounces-163702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944CA2B659
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8306B18844C3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223B2417C9;
	Thu,  6 Feb 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xe83hg5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB102417C0
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738883158; cv=none; b=FyTI/zU9t4QAaVBT/hNM1244BgPhIsM2zkO6305nVj7zKBXH3G6yATXmu9ouwcnG1xVDxxAN4zm/51U/uJWrMaizlIZMWifFhSG1Eke0djVkIF32OytON5aOLP2bonu2jGNE81xzrIEZy5HWfbWkROW99MLXUcmUX8B+Dd4qbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738883158; c=relaxed/simple;
	bh=z9t9HyCKufPDFoBBa4ype/jBwVa0S5cCWydB4oGnlZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sx7Xovc+NNQ3kevAz0AdiODYFKZ+BzPCqm6r7uHib3cp1NAY+C4vGX+30kweFZqaez1nt6nomknnWE7u7HHZ0NxAcKVJXb5EsX3A6NrLgkuA++M6MlPsOaSnAH0vXoKnOm4QkUzldLs1WXICQcInSED4Cn545U8goWaPA1mVpn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xe83hg5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BB0C4CEDD;
	Thu,  6 Feb 2025 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738883158;
	bh=z9t9HyCKufPDFoBBa4ype/jBwVa0S5cCWydB4oGnlZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xe83hg5koAaPzksfRTzUEGX0qVghiLHsYcLVK5fYsQgTsYJxTF57njh/UD2bJxLvi
	 Dz6tqLT/oROeN9RCNYrrAIdZ9nN+T2y3UR+SbS1xWZ4zDty2FMeLmusRCC4cYf7VOV
	 miDXmV5gmU/n5wBFzGZD92Q3fZnYj4q2KS6ZVdwU8KvbQqmpK/L6gS9Tf7a3B8/OC1
	 xcXjHK2DADE50ukkO6D3CsbMNP3FZM/NjEVjngRP2hfO+xsQlw9RjjB91Yh3xSKCii
	 x9hwqv2VYsyFd3pNGQGnrIDpl+voWQvSo7c3ZqWc38rHPuSyaHIa0UgCbydveu608N
	 8sPvDfCtR1Z8g==
Date: Thu, 6 Feb 2025 15:05:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
Subject: Re: [PATCH net-next 2/4] eth: mlx4: don't try to complete XDP
 frames in netpoll
Message-ID: <20250206150556.160a4cb3@kernel.org>
In-Reply-To: <d0f7e1e3-2e30-4d10-9535-cd264dcef5fc@gmail.com>
References: <20250205031213.358973-1-kuba@kernel.org>
	<20250205031213.358973-3-kuba@kernel.org>
	<d0f7e1e3-2e30-4d10-9535-cd264dcef5fc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 21:50:56 +0200 Tariq Toukan wrote:
> On 05/02/2025 5:12, Jakub Kicinski wrote:
> > mlx4 doesn't support xdp xmit  
> 
> Are you referring to xdp_redirect egress?
> 
> mlx4 supports XDP_TX ("bounce"), as well as XDP_DROP, XDP_PASS, and 
> XDP_REDIRECT.

Fair point, I probably worded it this way because I was thinking 
of .ndo_xdp_xmit

