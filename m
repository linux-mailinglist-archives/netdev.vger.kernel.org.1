Return-Path: <netdev+bounces-204974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3423AFCBAF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4383A95AC
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEA328935C;
	Tue,  8 Jul 2025 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQrB5h5x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29E1C6FF6
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980707; cv=none; b=O6jl4sjAS46j2aSj5v3eGBxzBeSRBDSYIiifFjSJ5WwE096R7YRABkYT/2lM5xThm8lTKdLZ9UoPqOGOfWPuGh/MqLVhs/uaFJqLc9IBTnccs3qKQOHQk+0gAuXGn0147pPJlBoV01VgvMVRhQZypexXJJSmvG0HjVX5ffvDjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980707; c=relaxed/simple;
	bh=PoST83ScfIFaIOmobYHreoCSN+3ugdkf7M6YNqpv1PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b03Gy/261rVKT9h2n2S6kZ9PgbVGsXITzMr/IpreLWvsP4hbpyAolXW3/wE454sg66j6Ek5GtO4rCVZV/4tnDC4NceVYKD8Tqffxwx+lD3sE78apiXD67OJE8SIs998wmmcG4taApTn7K4cngy9mGxPK0n5E0obZbk0uSdkW1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQrB5h5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12508C4CEEF;
	Tue,  8 Jul 2025 13:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980706;
	bh=PoST83ScfIFaIOmobYHreoCSN+3ugdkf7M6YNqpv1PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQrB5h5xb3kJNyYmhtJ2dXizswgko5rUFAD12P4mF3WAjEs3jJFqBDRAkd7vbY/EX
	 D/sM4EbB8hqU9ZIU+cn5Wn5NHVIjNirdvlwZUNIo2QdMJVHGGUrn7VOlY3FvCtOk1l
	 js2Tn1JG7bXC1kTLS9KYlnNebLhw0nmpitK21hXf+kruj4lqm+qfuiG5AvY6ChxLpf
	 u6AyfP9FSq3P+0C+MMh4TUHVvAuC2TDarWfql5holQMrEfEi+oLakAyHBZFbRpQz3o
	 Dvo3+BllVZMZGrUY6n8wzAu+hdrASJHhPy2vxKwC1WP0YdlEv2Jp+5qBxdzxKb/ddz
	 j6RXGmab9jjLQ==
Date: Tue, 8 Jul 2025 14:18:22 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, will@willsroot.io,
	stephen@networkplumber.org, Savino Dicanosa <savy@syst3mfailure.io>
Subject: Re: [Patch v2 net 1/2] netem: Fix skb duplication logic to prevent
 infinite loops
Message-ID: <20250708131822.GJ452973@horms.kernel.org>
References: <20250707195015.823492-1-xiyou.wangcong@gmail.com>
 <20250707195015.823492-2-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707195015.823492-2-xiyou.wangcong@gmail.com>

On Mon, Jul 07, 2025 at 12:50:14PM -0700, Cong Wang wrote:
> This patch refines the packet duplication handling in netem_enqueue() to ensure
> that only newly cloned skbs are marked as duplicates. This prevents scenarios
> where nested netem qdiscs with 100% duplication could cause infinite loops of
> skb duplication.
> 
> By ensuring the duplicate flag is properly managed, this patch maintains skb
> integrity and avoids excessive packet duplication in complex qdisc setups.
> 
> Now we could also get rid of the ugly temporary overwrite of
> q->duplicate.
> 
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


