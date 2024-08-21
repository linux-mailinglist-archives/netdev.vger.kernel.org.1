Return-Path: <netdev+bounces-120393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB299591F9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42C3FB20D62
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2863318E2A;
	Wed, 21 Aug 2024 00:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQYbwm9/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DBC8DF
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 00:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724201741; cv=none; b=QEsaKgPpNYpmIVuszPiI1SvHMhAGYlSDCpqjdRMxEB6xrqDlzRak19zPjxf8z3QqKvdlCoKEbCmK4xrY89bUc68gMRi+8pSLlJaPy2092rmyTgeRlg7Y/6WUbmSv1yNaoBQYqKmu9qj39BL4iHRHltU3cTaEFMDSZuO1AcFwsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724201741; c=relaxed/simple;
	bh=RruTJLnnwoas/6fTfRTK9701zQy9kxWvpxCazOc+UiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxH3Tk8c+loE0ZI3BB87nckhBS0EW73kAYvXWreMm+zWHomJYTDl6HHdXUTB2zJKIdxgvN2SV/0p2Zhs4p89JUM2iLqGBsU1BfcaNyfklAQuvQkRvPdEWjWl5qEyYKpcVcphW5txkrAo3tH3Fc61q/g/QRoq6zCJowJTq++E13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQYbwm9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2579DC4AF09;
	Wed, 21 Aug 2024 00:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724201740;
	bh=RruTJLnnwoas/6fTfRTK9701zQy9kxWvpxCazOc+UiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CQYbwm9/ho53Nr2AlZ5FFkhaI2kHyCE4sReC5NOwFUF+TzcPHQ0098K+4kdE9EJ8h
	 /c6OAsasNxMIvCYxxzqEHCgflqbFDuef6kAAUZ6cEQfBSouUstEOExZrf0LMXiCYDb
	 tgJcDInqMk6ueJu+3Do9QnVCcc75USg1SB3DMBx9VUKJQ/C0BN/iwG+bZhvItGG0QK
	 am4gGsjyVwZbZajh5GOqB/IjkwhQsJriaQNdN2tL4cOZVqLnTGj9D9P5QcWIxwJVVr
	 Ci+ZMiTV/pc+NcO6ZQcRjJCowoZUFrwOmKGpSaYoWG0tl8PaIW3xTJEJo81u8ZeX2h
	 OktVlCH+uazZA==
Date: Tue, 20 Aug 2024 17:55:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 przemyslaw.kitszel@intel.com, joshua.a.hay@intel.com,
 michal.kubiak@intel.com, nex.sw.ncis.osdt.itp.upstreaming@intel.com, "Jose
 E . Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [PATCH net-next v2 1/9] unroll: add generic loop unroll helpers
Message-ID: <20240820175539.6b1cec2b@kernel.org>
In-Reply-To: <20240819223442.48013-2-anthony.l.nguyen@intel.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
	<20240819223442.48013-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 15:34:33 -0700 Tony Nguyen wrote:
> There are cases when we need to explicitly unroll loops. For example,
> cache operations, filling DMA descriptors on very high speeds etc.
> Add compiler-specific attribute macros to give the compiler a hint
> that we'd like to unroll a loop.
> Example usage:
> 
>  #define UNROLL_BATCH 8
> 
> 	unrolled_count(UNROLL_BATCH)
> 	for (u32 i = 0; i < UNROLL_BATCH; i++)
> 		op(priv, i);
> 
> Note that sometimes the compilers won't unroll loops if they think this
> would have worse optimization and perf than without unrolling, and that
> unroll attributes are available only starting GCC 8. For older compiler
> versions, no hints/attributes will be applied.
> For better unrolling/parallelization, don't have any variables that
> interfere between iterations except for the iterator itself.

Please run the submissions thru get_maintainers

