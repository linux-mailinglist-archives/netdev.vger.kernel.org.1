Return-Path: <netdev+bounces-110999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3792F378
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EA41F23327
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA9320E6;
	Fri, 12 Jul 2024 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5q4Dxi2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A175228;
	Fri, 12 Jul 2024 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747944; cv=none; b=FiW5tjfpejdXg2zuHe4I8X14MfnTx7xAb8drzpxRlTk/Xut1Hpd7q/lS41BNc1NPLWmYWJeYEbHZ6HLrhqIdd0HNjvAI9B6KMPVFSKSyq+8maNg8s3en4o5iW4j08RVfBHFMwvaJA5ynODQpEGEbHT1qNh1u184b0oGNkctMuEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747944; c=relaxed/simple;
	bh=UXRfAsHHM5gL1/dqzXQEHNFkZnxFq/MrbIxYE+xyfns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMs+MBWeFux5/Ia+G7XUSmJF49BlEEiFqrwL/fo6BJR7bTY55sS2XvwjapwxUcdZ5bbBgWmIYw2eS2lKEYMMT0KlFnN80Yg20jOGZoNav0ItAFrchXJGJWEd8BTzof4/QCv/3NNYR7KbG2QJdOPyDTdGRg3d4EqVIgkuWH5rheI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5q4Dxi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1CC32782;
	Fri, 12 Jul 2024 01:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720747944;
	bh=UXRfAsHHM5gL1/dqzXQEHNFkZnxFq/MrbIxYE+xyfns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m5q4Dxi2iRREQ5BXoUJVwGrYUZFnxNDmzfeunf+TJ2dzNWiWyDmq0k4zXn/ME5q0s
	 ipAot0ISsn79fESHxsPrbIFsec1g+Xqs33V+xofPiS3qDAR1x/QjqTlEAtWAPQpp4y
	 5KWrqcf4PEfzR01ETDLxCOqFc/KsX7eU2Q3qLonEW4c9CBp9Zyqv1XrIQVIx2aJ0xI
	 0afuaV4KVK0bJ3SCILtbogFElwxp7y+0SQXZ3Xrlq3nSVdWd1M0+/7qiRIDiZEHQxU
	 rTABGNMDBE8TyOIIijlf1QaY5b60m4l5F9fGTuWN52x0haNQLUnPuGqvHH7sQY0vCw
	 jn4WP6vq8LfTA==
Date: Thu, 11 Jul 2024 18:32:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 thepacketgeek@gmail.com, riel@surriel.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: netconsole: Disable target before
 netpoll cleanup
Message-ID: <20240711183222.0d7e33fd@kernel.org>
In-Reply-To: <20240709144403.544099-4-leitao@debian.org>
References: <20240709144403.544099-1-leitao@debian.org>
	<20240709144403.544099-4-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 07:44:01 -0700 Breno Leitao wrote:
> Currently, netconsole cleans up the netpoll structure before disabling
> the target. This approach can lead to race conditions, as message
> senders (write_ext_msg() and write_msg()) check if the target is
> enabled before using netpoll.
> 
> This patch reverses the order of operations:
> 1. Disable the target
> 2. Clean up the netpoll structure
> 
> This change eliminates the potential race condition, ensuring that
> no messages are sent through a partially cleaned-up netpoll structure.

I think this is a legit fix, please add a Fixes tag and resend for net.

