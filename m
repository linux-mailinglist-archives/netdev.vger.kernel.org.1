Return-Path: <netdev+bounces-204657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F92AAFBA3C
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C181E4A464B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35352261586;
	Mon,  7 Jul 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/n8Q7hj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167D22DF9E
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911115; cv=none; b=oVPQ4+YSQlxpI/+tHDgZ0EmoY0mMrmCsjHJt1QGDknAca1ymYtVEOu/ryZE0xCWfSwu+u4kqRnblREhU67YYWXKrb+8Vxnl2B49LB294ZhowBf8maHDCxyakpN+GGAd7hvJ2pmIe3washurhCPtdKvfLG3He343yymxmy86hp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911115; c=relaxed/simple;
	bh=XB0h2uw8UFT+SiV4zT7MfUA7NamBDVjm0a76vkt6v+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t+15RouxeHE7ic9uzE9S3RcBKxWEKp4FXDIePfuQpssJAlXY+DfNO+jiQZ5GBvVncXTN7vhr60CVO5XzSGS124RNUldJahmI5iH6I4iJ9H0qHpuDkcW4mt4gFhehtzqPxSWRVkrcoIHxQYnt773vMjYTxjXF16pSZrL4o5yR3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/n8Q7hj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726C3C4CEE3;
	Mon,  7 Jul 2025 17:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751911114;
	bh=XB0h2uw8UFT+SiV4zT7MfUA7NamBDVjm0a76vkt6v+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r/n8Q7hjwSPmBNpoDhhoSEmoSD3YkMTMvexawxvfIvD4XbDFyZnm7Pi8nhedPBMUA
	 3k/nuZh+QpweGwskkuSGSQN+hvVP+rv+WCxreFMndOQUFlYcqmLLjGwMG4ssKLZ/co
	 CalOijfyC8ISaZar7MFzPGj3hHJPfkNypk6gRc0mLPrG0V6RTU40cdJ5gMU6Dvigw4
	 WjopZO0jascBdxHpNFAXz9SH3yZDmcFi6wQKopZ5iDoJJumm7QnLckHIC9CHOYsHc5
	 RMbgNjic2jDo3oIVB7mFkurfTNjOHxpmv+VkjY1yNirQZGxkoZ7lLkTlazqFmBlwqW
	 RlgbXePfaOBEw==
Date: Mon, 7 Jul 2025 10:58:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
 security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <20250707105833.0c6926dc@kernel.org>
In-Reply-To: <20250705223958.4079242-1-xmei5@asu.edu>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
	<20250705223958.4079242-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Jul 2025 15:39:58 -0700 Xiang Mei wrote:
> A race condition can occur when 'agg' is modified in qfq_change_agg
> (called during qfq_enqueue) while other threads access it
> concurrently. For example, qfq_dump_class may trigger a NULL
> dereference, and qfq_delete_class may cause a use-after-free.

Please don't post patches in reply to threads.
Add a link to the thread using the Link: marker instead.
You're also missing a Fixes tag here.

