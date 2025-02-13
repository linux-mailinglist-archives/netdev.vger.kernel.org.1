Return-Path: <netdev+bounces-166129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C753A34B5C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC63B8348
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B13128A2AA;
	Thu, 13 Feb 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJavzkpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A5E28A2AE
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465640; cv=none; b=VSwiy5V+o+l+geMJYacBPpRjHtojHOPHKKPG4Nuk29aLkomhEePc50sScMamzPjrkyrHkf7jRI7f/sanHSYvnercB6lW3JHAaE1UAU5+j3ym8ZyxzgQQZTmDIMHm/nkvh98OOjUe/lHJ/nO+fI2PE1o8RycoP5f8+pYMN8DcrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465640; c=relaxed/simple;
	bh=wuHvU41ei5NSkAq554xuHzXwKA8AD7PWILWrjLdhUU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iK+EwnBqA1HGaKfm8k8w3PzS1oLqc306nNSOtIsjdZeyfWJl8EeShPrmu3N6MM5nRpFA7jojyJ/9BwSIIbekiiPJeJYBMK+Y2HNhoyr4/h6J7Zne9HUnCSvQ9If8AZiTnq9jlYOkcDsv11OdDjLbKiuFtEDSxM33Tjqmd1zjBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJavzkpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478A3C4CED1;
	Thu, 13 Feb 2025 16:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465639;
	bh=wuHvU41ei5NSkAq554xuHzXwKA8AD7PWILWrjLdhUU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZJavzkpP/zG49t4F80bXA9L5U57PwSbbLChUKe5xASr7AzWggdDFFTLE+IQWi+mBo
	 il6DsdY5pUBIJ8Om6beASUTImNSqFRptl36jdLtawuO+HC8bqZZDzPjs7huP5j8/aa
	 BPalHWD/ObN9hUHt3jZEEHvFReWcCatOuMiAE2WAiyMxx3EoLB6iFnFssx0LAqzYNk
	 JS6ZZsls7iMQ1VdD1VB77qp5Zkwy1UNITzNt76yw+M+Kwq4YhdPfKPcGaYx8OjlBP+
	 z3BbdFxoz4nc4Dnc8T/aj/zfPDbAueulgs0pecV7Tr3rndJ8BvK05AAscC089SGRjU
	 XoEzti6Wg6OvQ==
Date: Thu, 13 Feb 2025 08:53:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
Message-ID: <20250213085358.5a08e4c3@kernel.org>
In-Reply-To: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 18:42:32 +0100 Paolo Abeni wrote:
> In such built, SKB_WITH_OVERHEAD(1024) is smaller than GRO_MAX_HEAD, and
> thus after commit 011b03359038 ("Revert "net: skb: introduce and use a
> single page frag cache"") napi_get_frags() ends up using the page frag
> allocator, triggering the splat.

FTR I'll drop the revert from today's PR as discussed off list.
We can re-apply together with necessary adjustments.

