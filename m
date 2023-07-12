Return-Path: <netdev+bounces-17303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE66751202
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F789280CCE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD16DF56;
	Wed, 12 Jul 2023 20:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2885DDC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A562FC433C7;
	Wed, 12 Jul 2023 20:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689195033;
	bh=3cGyB8/OccxEE6UIAgzhlRswaN6zKAPX36mGUHOu9PQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atwJnFTkkPJkAblh0d6Tjsqz2cmdpGCVQpxTg1ZV9W/dRYqQjlJ4X27sOw5UIPolr
	 p051Yy0SYmpkxwOw9GhO4BhSZM1dZ2qiPYv2NSTIP/6/pr3RJTjHStW73gh+Dbrlj9
	 t2cwJlgjhr75czuB5XRjZd4i5pCsx5zBZTQfRkNT+9jgengHw2ne1qYRiQPOUkPTha
	 YhxXK9ro64MzuBuZIik4gDcdfFaXIhh4B9AhmYFMQ2XIfHz9dUafi1u4s7peiNXYu6
	 cFvpyDqqGVIFqyIB/Qs/qixkLZlDDfhJBEVlZLLP4xAdfqrgSPwnzXxielUAheevMk
	 Z9VTMRanpeSWA==
Date: Wed, 12 Jul 2023 13:50:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 michael.chan@broadcom.com
Subject: Re: [PATCH net-next 3/3] eth: bnxt: handle invalid Tx completions
 more gracefully
Message-ID: <20230712135032.28011bc4@kernel.org>
In-Reply-To: <c3ad12394627fffc5a0d8e48e019e6ef61814597.camel@redhat.com>
References: <20230710205611.1198878-1-kuba@kernel.org>
	<20230710205611.1198878-4-kuba@kernel.org>
	<774e2719376723595425067ab3a6f59b72c50bc2.camel@redhat.com>
	<20230711181919.50f27180@kernel.org>
	<5b722084c6031009f845e6af8b438d49b9ea7dc1.camel@redhat.com>
	<20230712093418.5578c227@kernel.org>
	<c3ad12394627fffc5a0d8e48e019e6ef61814597.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 22:31:45 +0200 Paolo Abeni wrote:
> > Is there really any difference whether one changes a byte or ors
> > in a bit? Either way it's a partial update of a word.  
> 
> Really not a big deal, but 'or' fetches memory and then store it, while
> move [immediate] is a single store. In case of a cache miss, 'or'
> should stall, while 'mov' should not. In general with 'mov' there
> should be less pressure on the cache and/or bus.

You're right, if the store buffer can buffer 1B stores then we won't
stall the instruction pile line. But we most likely will for the bit
op. The setting is an extremely rare path, tho, so given your
"not a big deal" disclaimer I'm intending to keep the bitfield :)

