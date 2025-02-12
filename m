Return-Path: <netdev+bounces-165374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C622A31C3A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A917418844F1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085B6137932;
	Wed, 12 Feb 2025 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddn9QZtU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2D27183C
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328381; cv=none; b=HNxJ8VOhLMS26pahE67RuC0Dfz+rCsJmL+cT7MySBrER8M5iNX+7/PFwW363E9sIxodft2s8Peo4r29Jh/3wZx6ayIqU2x4LfKLeTj3s1AAqAGPrwb181l6E3nZqXHqpM/OnwgVxGcHQRXHcD58ZT+kwzfkf3Fcl9ZbZfJfIJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328381; c=relaxed/simple;
	bh=RusHc8Cv8X9pvhBIiUcphMB7CNIxsnoH7Sj7Eg20bzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TXeTeGkAmXFHDek8VYcblv9So1PSGHiKgeUyyziO/y3Xswhl3hmFGPfE//7GwyHW1RRMh88ytnZRjK+WnxYsSLmQglh2ua3QJK8g76w6onSYvlkjjS4UScm/URb042DSjpfQ8lYS2W+L+LnF5uFoIwr1CvlM0Xls9HWaS+LNNaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddn9QZtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A440AC4CEDD;
	Wed, 12 Feb 2025 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739328381;
	bh=RusHc8Cv8X9pvhBIiUcphMB7CNIxsnoH7Sj7Eg20bzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ddn9QZtUl7Xs6gJ+bcm2oJ6uLz5yfWxg7rI5HmalL+nh8/aNk2AYp0q5jqcZCrFaM
	 WOmHE3bn/cbOAPe25KXF6GoThA2tRw4yO/TuvBbB0xMZK9iBCd+K5YaPggt6T4GMRg
	 Y1YhDxeh4Rc55b8NAjNbPDYrrt8VgRJqAem2l5xA0rvDMNi+MuOay4WCXAOq+YRBLS
	 wfVjQvAi5vFxegt981o1fMBYtXQelVtEW4mw0knQgHv9Z9tu8Z4k2kcKRtzPzlllZ0
	 zRy/i5TEBzQQ0/X8LXAynCjM35al1gZ02XkKXjxG/kH2JgvmZzTh9wSiVZItAhcu5F
	 29OPSxD5zd/Xg==
Date: Tue, 11 Feb 2025 18:46:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1] page_pool: avoid infinite loop to schedule
 delayed worker
Message-ID: <20250211184619.7d69c99d@kernel.org>
In-Reply-To: <CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
References: <20250210130953.26831-1-kerneljasonxing@gmail.com>
	<CAHS8izMznEB7TWkc4zxBhFF+8JVmstFoRfqfsRLOOMbcuUoRRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 18:37:22 -0800 Mina Almasry wrote:
> Isn't it the condition in page_pool_release_retry() that you want. to
> modify? That is the one that handles whether the worker keeps spinning
> no?

+1

A code comment may be useful BTW.

> I also wonder also whether if the check in page_pool_release() itself
> needs to be:
> 
> if (inflight < 0)
>   __page_pool_destroy();
> 
> otherwise the pool will never be destroyed no?

It's probably safer to leak the memory than risk a crash if 
we undercounted and some page will try to return itself later?

