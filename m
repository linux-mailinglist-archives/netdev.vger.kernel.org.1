Return-Path: <netdev+bounces-205118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7BAFD6EA
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CF01AA27B2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A492DEA82;
	Tue,  8 Jul 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dp45VwJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3BB21ADAE
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001888; cv=none; b=PoEzY1fSUoKiAVc9QTgEjMlO3Im0mNHv40EP8CWfvECe438BuzK1LvWjjF5X37D3+pw4kFbpsNiwtmU5aZyHBKwZk1naYXO748yVgwPXC7Xtsy7NuwnF5zmL+VZvWir3OXOZAWPLWKqXsXUELPCd7fPoDXlnIC0c/2AV5IcrTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001888; c=relaxed/simple;
	bh=6Ax5FR4C0XjcTONJy9AshCkwjE35HZHNkhwYFLw317c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaB24DCNV8Pitj/tgjM6D+iwK8EImBAoju4jsOnOfoFWPpca5oB2+avoJqcvlfVdK4vYacjHlRJFQ1zgj4/24hW5Km/hSA/PbbC4cJYOUCm6rS2bcsnol5b1Iwz0HHZLJByq66Yw5QKoOTKAvBQ3pCRpwAQ4nyRy/rmTphKEE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dp45VwJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB21C4CEED;
	Tue,  8 Jul 2025 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752001887;
	bh=6Ax5FR4C0XjcTONJy9AshCkwjE35HZHNkhwYFLw317c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dp45VwJ0S8gXiTSeBVK3g7q+q2shlO9uBpxH+Uf3exaKGzWkF+rK2bgvlBMJpFz2c
	 6xPGQLWdofLRn4bMkV8U/3GlLArNxYagsa71F0le/HFFx6X7yNaSwl56d929gJFj89
	 JmSwKdFIKlcNYCKj+qqFRHwkDf4pptn/KEraJmCQi5lNVfptSSu1sjv2AM5pLZKgj4
	 csU6CZLMQulr96T1oaPW7UKZVPmzNVYtDxl6aaWZrYqMCQJxLw1zHtRtQKJFYiP2nw
	 0f96vEdxD4tzNLA6/A8X8IsWHODUIzzg4xGNkhBy3hWWxHvtg08fJGAsgLngT0l4Pm
	 9KCs/FfPTnhJg==
Date: Tue, 8 Jul 2025 20:11:24 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	will@willsroot.io, stephen@networkplumber.org,
	Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v2 net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <20250708191124.GB452973@horms.kernel.org>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
 <20250707195015.823492-2-xiyou.wangcong@gmail.com>
 <20250708131822.GJ452973@horms.kernel.org>
 <CAM0EoMmToF2ihqsSGEDyG3NAcy4rjO5pzXjShD2ac7VrjDNwvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmToF2ihqsSGEDyG3NAcy4rjO5pzXjShD2ac7VrjDNwvA@mail.gmail.com>

On Tue, Jul 08, 2025 at 09:19:50AM -0400, Jamal Hadi Salim wrote:
> On Tue, Jul 8, 2025 at 9:18 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Mon, Jul 07, 2025 at 12:50:14PM -0700, Cong Wang wrote:
> > > This patch refines the packet duplication handling in netem_enqueue() to ensure
> > > that only newly cloned skbs are marked as duplicates. This prevents scenarios
> > > where nested netem qdiscs with 100% duplication could cause infinite loops of
> > > skb duplication.
> > >
> > > By ensuring the duplicate flag is properly managed, this patch maintains skb
> > > integrity and avoids excessive packet duplication in complex qdisc setups.
> > >
> > > Now we could also get rid of the ugly temporary overwrite of
> > > q->duplicate.
> > >
> > > Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> > > Reported-by: William Liu <will@willsroot.io>
> > > Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> > > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Simon,
> This patch wont work - see the sample config i presented.

Sorry, I convinced myself it would.
But it seems I was wrong.

