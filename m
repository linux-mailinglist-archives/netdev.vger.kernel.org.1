Return-Path: <netdev+bounces-142136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7F79BDA01
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E141F22675
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88745216A22;
	Tue,  5 Nov 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNnHZWFN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD2621620A;
	Tue,  5 Nov 2024 23:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851050; cv=none; b=udJoswqB5uT+jJJ+/ePpgN6weme0PsKLcbI6S6yzShWZBY1bg0x9iWIdD4P71vGwW4WpPUZlqvGpnjPVcHW5ckhNkn9wwf2QL4iKik9EKYPVysWq0tqnxgJ5RqTVA9ilJazD1QPNE6EehYeQ+bzc5IfFo/3r7MisWB3dARB4xoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851050; c=relaxed/simple;
	bh=IzPB06sd1MA073J3DKr1e7Mn3aB9Ii2die2+p5FNfDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFZCX0Ge334xn91M2PK8ETMxXktt60SgJz4a7/+ekqKbdQET79F8hyr/ycMPXXqsChEWTq1WsCVH4szOZeDs0UTNhD7tCq/0sqBlhtszXcL0CRnyTzcj7uMxhCxGhndlPnbOrFaCGy7PaexaRpAFHLayhATFs8B0010pRUtE9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNnHZWFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80B9C4CECF;
	Tue,  5 Nov 2024 23:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730851050;
	bh=IzPB06sd1MA073J3DKr1e7Mn3aB9Ii2die2+p5FNfDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WNnHZWFNfxos9joo0nZLcNkoNDjSmNsOSux5ihe0HNWDQPoDxz4paBg0Wbtb9pP1U
	 YN0jdBZGHbna6tGV00zuCjQm5J2IKEoVAhsC1++WuoZ9lwNjTuj1CnCjm881jD4r8N
	 pIxpUig+ot++6/XebbXro+MvHc6zgI7SRhNOlIn4M3DL7EvwwBJ9L8PA2EnbOg660Z
	 naGv78Zx5Wu2RVJK9tqH7H3sdOP7nOZ8NSrSP/lBOWXSk4rNjX4ocjTKi65G7qgvXN
	 t+dQ+zq1tXiKb/4kLUvbOm63mfAuVygT8rGU2TKEw5RCd3UPjhadV37Ge4FlMNcU74
	 0zqGykFKm4O0w==
Date: Tue, 5 Nov 2024 15:57:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linux-MM <linux-mm@kvack.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Alexander Duyck
 <alexander.duyck@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next v23 0/7] Replace page_frag with page_frag_cache
 (Part-1)
Message-ID: <20241105155728.6f69e923@kernel.org>
In-Reply-To: <20241028115343.3405838-1-linyunsheng@huawei.com>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Oct 2024 19:53:35 +0800 Yunsheng Lin wrote:
> This is part 1 of "Replace page_frag with page_frag_cache",
> which mainly contain refactoring and optimization for the
> implementation of page_frag API before the replacing.

Looks like Alex is happy with all of these patches. Since
page_frag_cache is primarily used in networking I think it's
okay for us to apply it but I wanted to ask if anyone:
 - thinks this shouldn't go in;
 - needs more time to review;
 - prefers to take it via their own tree.

