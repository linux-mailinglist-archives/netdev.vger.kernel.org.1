Return-Path: <netdev+bounces-115914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53F594861E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7031E281A0E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95B17278D;
	Mon,  5 Aug 2024 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNK68lsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8C16F0D2
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900749; cv=none; b=c8U13/gl0NjUIqS67RzmQFHPsQxIKhMnV2KAHN7hKPXs9pA40CN29uxrLQH1RVaKkbrRHDJbd/peDA6My2xKKwKBob00bzDc7IEAwLffLHe+cXy8tL9iuPjk35P4JETfD6qgIio8uXDzIZ2F5DvfYkDoqd6UHqpSk0IUTVFY2n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900749; c=relaxed/simple;
	bh=S75KKTJFpLT0HDPsOjwDXaDIq5d6qUG2IWEf46QlNTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWE6RD+buPZYM0vxx9gl1L3UKuQgLc9EbxqbSrLxmqKani6C944H91nHA0TlqEnO1KyeCKQmVfbSaugR2r+/DYQDEPaitgvlZsd00VkNsj/aAYNsDlyy/f+pY0U5vOkKmfmZk+6qNqj+toYYGQaqu9RidTqNgu5ZVy+Vw8rjLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNK68lsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7612DC32782;
	Mon,  5 Aug 2024 23:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722900749;
	bh=S75KKTJFpLT0HDPsOjwDXaDIq5d6qUG2IWEf46QlNTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PNK68lsnbpZ0loO0x/ooylDd7qjQbCm2W3T4hASYpSYgrwbgvyWeeRRShLPd6NEK3
	 +VdT7zYIXQA3OH4rScxAEOEOsz7DEsVOOx5XwccFM2TBt5A1cyZAPrHd5V7vFu/VzG
	 wkCn92boe+jCo+n9La9SGsBGjj+qOHv1jjwa2QTzicc2/8Ad74pODUQb4mzVcATl14
	 JD0geuyC7r8AW4mFvm3RnnaTO5pHGYKd+diAq2OX/VN0A+/zxgf4Py7D6BMVTdMpPj
	 SwLg3ilgUh2r5L3er+CHVUy6ThS9xMbDp/8S0wWkEHrqNkqx0cPT9vIqZ70B9Fi5T/
	 VA1huwZMuAN6w==
Date: Mon, 5 Aug 2024 16:32:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH] net: dsa: bcm_sf2: Fix a possible memory leak in
 bcm_sf2_mdio_register()
Message-ID: <20240805163228.16956875@kernel.org>
In-Reply-To: <20240802085411.3549034-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20240802085411.3549034-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Aug 2024 17:54:11 +0900 Joe Hattori wrote:
> bcm_sf2_mdio_register() calls of_phy_find_device() and then
> phy_device_remove() in a loop to remove existing PHY devices.
> of_phy_find_device() eventually calls bus_find_device(), which calls
> get_device() on the returned struct device * to increment the refcount.
> The current implementation does not decrement the refcount, which causes
> memory leak.
> 
> This commit adds the missing phy_device_free() call to decrement the
> refcount via put_device() to balance the refcount.

Please add a Fixes tag pointing to the commit where the problem was
introduced and make sure you CC the maintainer of the driver.
-- 
pw-bot: cr

