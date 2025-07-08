Return-Path: <netdev+bounces-205061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5895AAFD019
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD1C3A8AE2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158B2E5406;
	Tue,  8 Jul 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDvRgV30"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDFC2E5402
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990786; cv=none; b=iRSI/sM39PH3lpLODlcf/EHQ9ZrnN2MojHm/F9e6bYkveGxqQYBPiki4ONObv20WjNophdtTYAX11a5oXGug7YmyyyvRwx0Hy8YqHBMEk+IJ/uPYNytt3Yy6vFZ2grDauvZ+fMKgfGFPe6cCipDR63g/fYVQp5Wu3xxC/mODzMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990786; c=relaxed/simple;
	bh=HOHha4Z8m0CRNL4uN8Dz4HsFdtFRAYdpdL1sL+4Eivg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTUdBvmHv/6o9BEk5fJOdWbFVQGnHLMS96DpF1e9fiyy8oqI84n4jkj0Bpd2TbfBC0A9ldEKg6JSTh1JDTn1x4Xj6Cc3gVH764qd4G3f4ZHOjApQThMkRZtPOXlmEFKvay/pJ7SkvnnG/Hu81NJWEzXUMJOzvaIauD+fWVWhjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDvRgV30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981DEC4CEF0;
	Tue,  8 Jul 2025 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990786;
	bh=HOHha4Z8m0CRNL4uN8Dz4HsFdtFRAYdpdL1sL+4Eivg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hDvRgV30BugO6ftsOtknRstJ5jQA6c7PI7+E8hA+zXqAW7+WJbNJCa1EiFZjNusGO
	 adQ9YwxZOqN0iCfEjF63Yh8Px3TUWIPm7bKfCllHqzINP898gNi2SF2U+1bERhRTay
	 Tm3tEwtYsFfTttN9GwgE1w5V+vTNHyXO5OiX6wN9GeHMZ1GPz+RYvBjZI8I0NjBASE
	 5J4+khbNxtoetJ9yQQI36IpylpLnn1WHw9grB7eTsBbEP4wYpIIhoi1u2YKbfQW2kw
	 BHljpybZq7zVqecMmPKRvibthp8aCupn3N6wvr+cpIgTiKzuSfTt0883jN2ySRMEoR
	 bDP77CPxeBeew==
Date: Tue, 8 Jul 2025 09:06:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: William Liu <will@willsroot.io>
Cc: Simon Horman <horms@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>,
 netdev@vger.kernel.org, jhs@mojatatu.com, stephen@networkplumber.org,
 Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v2 net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <20250708090624.2e015913@kernel.org>
In-Reply-To: <3SdBpUCGSDH5s1aiYafxKcMPi9-g1hKh11zkNKSudHgduTFQn2w_2biBrtFijTuZgfZFAvx__KRdXywmsN6BYUkFg9AaaZXMlxTG0cwzBHA=@willsroot.io>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
	<20250707195015.823492-2-xiyou.wangcong@gmail.com>
	<20250708131822.GJ452973@horms.kernel.org>
	<3SdBpUCGSDH5s1aiYafxKcMPi9-g1hKh11zkNKSudHgduTFQn2w_2biBrtFijTuZgfZFAvx__KRdXywmsN6BYUkFg9AaaZXMlxTG0cwzBHA=@willsroot.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Jul 2025 15:56:29 +0000 William Liu wrote:
> From what Jakub and Jamal suggested, the patch for review is now https://patchwork.kernel.org/project/netdevbpf/list/?series=976473&state=*
> 
> It was marked for "Changes Requested" about a week ago but I don't recall any specific changes people wanted for v4 of that patch, other than the attempt at this alternative approach in this patchset thread.

Please repost to get it back into the review queue

