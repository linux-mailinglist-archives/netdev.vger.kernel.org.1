Return-Path: <netdev+bounces-249664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACEBD1BFAC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 101493006733
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D2A2E9749;
	Wed, 14 Jan 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvBYNROQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDD32E8B74
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768355058; cv=none; b=iMTOKgHQAACKcaHg1HC/lwS4MuWF8lRXH9pxy5xUKZhz2DnbXVT0O07lZWEjbbBVrHEA2IM1AGm7jRyHw4RpLaNwrXJCe45+pCzTwFfbDRIpen6epIGBcdAenkx3SOvk9evXQLcpzrHpnlDr92ccebkq7PpBQftUvwla2MGBEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768355058; c=relaxed/simple;
	bh=mRMrVTLaOg8ePa3U3lrUGHHePSswyc5c9tAr7YjqQHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0X5j432LWwsU9XomwlkoCwgdvcAMkb+++15Pn7Oos6SZ7eusg7VEcp7KTI5WYacRF3LwU5rqDD+LNVK7oZhjNLTxGrNvtYIjyRXr4uUOqaSgN7phvgJriK8m2hd33IFQ5giB7SPCwA9CKnd6h5DDKuftxi9JuVP8blbWNCccxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvBYNROQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0614AC19421;
	Wed, 14 Jan 2026 01:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768355058;
	bh=mRMrVTLaOg8ePa3U3lrUGHHePSswyc5c9tAr7YjqQHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvBYNROQ+tR1gRxtLni0s+aeRiFedPQgr4z9W5YSyAQ++VxcaWVq/2FQOB/snMiik
	 s3aeQIwgd0xnDPdP9jsCEiEtUKR13UygJ5lcmazxD39ZMgkc9r2UuPF4/TkQav28YS
	 0h/2ruEb+eQm5GEdo6Lpl+U99/Yf8RVIK0+XMlawJGJSS+H925hXscQSu2sBbhNhc2
	 jzpcxb1mLyEP4TcwH4a/3MH5jVEBimkIAFKqnPh73jQIirs03uC0UOokT5GNYhcLvd
	 HH116f98y7vhqGdkKvwzQPi/9q5qUJW16fQ3FzZS28enGklFVdYYOrb8MKa9/se1Az
	 EhMzV6OEMHqVg==
Date: Tue, 13 Jan 2026 17:44:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: minor __alloc_skb() optimization
Message-ID: <20260113174417.32b13cc1@kernel.org>
In-Reply-To: <20260113131017.2310584-1-edumazet@google.com>
References: <20260113131017.2310584-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 13:10:17 +0000 Eric Dumazet wrote:
> We can directly call __finalize_skb_around()
> instead of __build_skb_around() because @size is not zero.

FWIW I've been tempted to delete the zero check from
__build_skb_around() completely recently..
It's been a few years since we added slab_build_skb()
surely any buggy driver that's actually used would have
already hit that WARN_ONCE() and gotten reported?

