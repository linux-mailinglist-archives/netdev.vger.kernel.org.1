Return-Path: <netdev+bounces-233191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A641CC0E368
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6C1A4F6730
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186133054D9;
	Mon, 27 Oct 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEpQ7g6W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553930506D;
	Mon, 27 Oct 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573152; cv=none; b=Hdy1ERVpKA6L5LrzArY3JtByB2ZtNAbc7V1za/z2KzxdVFT83vJOB0cRE7UnqeEd+r8WY0PzOwPNX9QdIbtevDfzCHSvq0JjmSZSyveEUxTwChEZa3bA8kmcmLc31lMHHujB+7qK1aFy1p2pHsQ8AZApZV/RTaJ6xGP6cX6Pb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573152; c=relaxed/simple;
	bh=AcftJ/Eo+9lrMqF7rL0ZXJFQF9B3tiEbWDD0YyEHcVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCVAFtSNtqRmS2ORRR79clOsprBMHwZi7eb3tn+AH0qrzIHjIcgOv1yUMs8qEcf1tZ1df91esYIuPPjwRizkTcrmYPd/c2cGf2AChLkNmv/8GcVLHuKkSMEOfGzsITX06b5QOZrTk1WsI6vR+2JxxzRGr4TUQ7INVghN6V9e0WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEpQ7g6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB22AC4CEF1;
	Mon, 27 Oct 2025 13:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573151;
	bh=AcftJ/Eo+9lrMqF7rL0ZXJFQF9B3tiEbWDD0YyEHcVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEpQ7g6WjbL7+cyNM7SD8cCRkO0qoKvDd8EKAT7V0jdyLtLKX996BnHt199yqHaxD
	 gNmDqUpwHGhzT7Jcs/5MLYz0c1WiTcp8KbMQnmq0fpTv56tLdYIeB4xSgTxQlJ/0Mn
	 FmlYzNAiDxMZutoI1ZsmonyYzCrT5y66xSQY/nOXYhZFtCKLbTkOMgZ56fEHNwSBr4
	 dXlL87Odl1AahAQ/wePKgQhWORtasS5O29GJicGFp01V0FLrx1nOnapl82r38VYamu
	 wQhIj+Q33BWqlyIL/jDtQqNQgg+6hQQBxZLPXt60UEcnCFYZtgsScGfC0paiHmPeUA
	 zB+cBTR246QBg==
Date: Mon, 27 Oct 2025 15:52:27 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.xn--org-o16s, pabeni@redhat.com,
	linux-acenic@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: alteon: migrate to dma_map_phys instead of map_page
Message-ID: <20251027135227.GM12554@unreal>
References: <20251021020939.1121-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021020939.1121-1-chuguangqing@inspur.com>

On Tue, Oct 21, 2025 at 10:09:39AM +0800, Chu Guangqing wrote:
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/ethernet/alteon/acenic.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)

I don't see dma_unmap_phys() in this patch.

Thanks

