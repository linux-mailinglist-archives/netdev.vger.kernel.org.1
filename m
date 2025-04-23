Return-Path: <netdev+bounces-185318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309FFA99C2E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1C11B802FE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 23:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26D021FF24;
	Wed, 23 Apr 2025 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZJ8u/84"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0A2701BF;
	Wed, 23 Apr 2025 23:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745452016; cv=none; b=N/WBWiRd6MJnf7lttBha5Vd6qIezYDYPgOW2qXiJhLLK9PXvZLV4ly/MVuYJ5JrNlCI2TETZcrYmORbKTj51ENSUv8PiaMx2VNd9Y3aXt0i1YUU6T2ezVn80dp2353PSEtgcKvfUSZBdKxdai1LHfX0/8OFQ40HDiuw3bktx8VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745452016; c=relaxed/simple;
	bh=Av9q60C/8mDddQ+gZDyjx1Lly+8wTurMKem5qxUYBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHZh4VSelbLNFBxUMqnLHE21sPgeGCGMm7xO0Sirfl91l5NZ6ge9lz4M9LAqUWVCetJLQbcayut5BuhCspW7Eumv3SJ9iZ26HV9C1XfYMQHG8kLgCz9JBS2NoJ0KpJVvPCTGvWke6IeGBmNvsbnv4NDpYPqpGsaXqG0sB1srtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZJ8u/84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BA6C4CEE2;
	Wed, 23 Apr 2025 23:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745452016;
	bh=Av9q60C/8mDddQ+gZDyjx1Lly+8wTurMKem5qxUYBnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JZJ8u/84UgQBxWmODGXIF9w6EwgpbnudFLmCdxHLBoQTWQUGFGYvmooRxeTfUKMfn
	 KU2bEbKGe4DqXt4TxcjbGzoRcLXMazK8TVTUBR8ulAyJ7A6QVFjBNy9DkLOtIkgxmQ
	 m51w8z90BtSPFIaTvugeKRss/MkKsGaQ+bmQIpJdqz8LAQNsHLJqoTPN1/l2ZMWcYt
	 IpkY/H6GbgvgSgj8ayoeal0Ps2tMXX0kcS0K2xBHOlhoAegcTidKmD5HWiX9m5l83N
	 AxXkmErq7RRlvJmuyoS5heqlOdEH9Gx/oR1YUfoXC/YSoj3xd+Rl+mwvQ0/2CWuTjC
	 xj8w1eazHPKug==
Date: Wed, 23 Apr 2025 16:46:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v4 1/7] ref_tracker: don't use %pK in pr_ostream()
 output
Message-ID: <20250423164655.36e53244@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-1-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
	<20250418-reftrack-dbgfs-v4-1-5ca5c7899544@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Apr 2025 10:24:25 -0400 Jeff Layton wrote:
> -		pr_ostream(s, "%s@%pK: couldn't get stats, error %pe\n",
> +		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",

FTR I think this is counter productive. 

Reference tracking is a debug feature and you may want to find that
object with a debugger and inspect it. That's not the same as random
drivers printing kernel addresses into logs for not apparent reason.

Does kmemleak use the hashed address representation? It's a very
similar situation.

