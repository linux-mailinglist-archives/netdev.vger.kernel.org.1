Return-Path: <netdev+bounces-232643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261D5C07890
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF793AB5D9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429A341ADF;
	Fri, 24 Oct 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxDTzZAf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64F280A29;
	Fri, 24 Oct 2025 17:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326863; cv=none; b=XeYuydYiw8KKVRiSuxLT7O+5rjqRA/WoGxbfkPK3sYdO/Btn++gfTEV0FIXbt8Bx4oWFRY6H7nNxPZA1k6gkGnJZJJXAiinbEvhVpz5qwIBL6kP+a/diL27zXJoTWLFZKFiywFJDm/lqr747RuEw23bxEz5JeVZcbPvAEi3PH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326863; c=relaxed/simple;
	bh=oiQZJQaA9tzYYyWvZEkw5psXk/MzntRZD/uGjLvb8ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT5C7kzhKQNaqfqR+H0HIcnwnHv8VmUumy5nPJxUPjJDOiONxvvTKYu12uAJyIXT2SXH2ur4R9R9OHumZvi1XPQ9NsFOWj7X2W4PIg7d4zIge7WJTxBzJhLHo3BrLWDhB7JLn2ofUXhE3GWIXaRZdJCFPaGQG4wlUA7ev6dNl8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxDTzZAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367FAC4CEF1;
	Fri, 24 Oct 2025 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761326863;
	bh=oiQZJQaA9tzYYyWvZEkw5psXk/MzntRZD/uGjLvb8ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxDTzZAfDIirGYnlZUSBVjNxANm/UANrYdEA+RtKfhd0zGqaqOmRbkjsjfV3Tjwbe
	 EsJpkTngM1qhEUzPGaciyt17AAFGzR220uLscdbXGGKYdjtQ2aqNgovcEetAxAba3n
	 Tgb26y2t4r6H+pjj3Vpc+sSVMZAvYJWfqvXY7qxG5Xv/kbgALb1BIDeLrHX2K+GU3A
	 iUJonc/UsuiBQ52FijwCFsioN4gbIlS3AbMeUSW+lVyy2nTZxtRvqWahxI+Wy+cHvG
	 lMKEkw+LkFicg1e179U2Mj+JYb0bYwbwjVWRkK5meuIOf5uqbwMkb6FChOaQqhkAVU
	 i06emX40GiYtQ==
Date: Fri, 24 Oct 2025 18:27:39 +0100
From: Simon Horman <horms@kernel.org>
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 1/1] net: jme: migrate to dma_map_phys instead
 of map_page
Message-ID: <aPu3C8QUYLYE8ZpG@horms.kernel.org>
References: <20251024070734.34353-1-chuguangqing@inspur.com>
 <20251024070734.34353-2-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251024070734.34353-2-chuguangqing@inspur.com>

On Fri, Oct 24, 2025 at 03:07:34PM +0800, Chu Guangqing wrote:
> After introduction of dma_map_phys(), there is no need to convert
> from physical address to struct page in order to map page. So let's
> use it directly.
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>

Although there have been a number minor updates since, mainly for in-kernel
API changes, it seems to me that the last change of substance to this
driver - a feature or bug fix - was the following commit in 2016.

commit 81422e672f81 ("jme: Fix device PM wakeup API usage")

So, unless there is a tree-wide effort to move to the pattern you describe,
I am wondering if it would be better to just leave this code as-is.

Quoting documentation:

1.6.6. Clean-up patches¶

Netdev discourages patches which perform simple clean-ups, which are not in the context of other work. For example:

    Addressing checkpatch.pl, and other trivial coding style warnings

    Addressing Local variable ordering issues

    Conversions to device-managed APIs (devm_ helpers)

This is because it is felt that the churn that such changes produce comes at a greater cost than the value of such clean-ups.

Conversely, spelling and grammar fixes are not discouraged.

https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches

