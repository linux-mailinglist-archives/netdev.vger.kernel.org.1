Return-Path: <netdev+bounces-179615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E2A7DD78
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B16F618943A7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731D23C8A2;
	Mon,  7 Apr 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzvkzjW1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4339223BD16
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028118; cv=none; b=FAJnj2vJkrdAR9IEcDqkf21ns154AmPHbAKC+sGOv68OoQkEr28wzz5RUpVxCo67fUOGHNVV0MiwlASSKgqZEKOou8Huagc5n/XM9+xNJ4RFDIw35pvuLJ+UXxKDPyE318r7hBJqZyg2sbftB8P8FxU/ct2a5ocl3P60FqnSWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028118; c=relaxed/simple;
	bh=LEQvbISieLuk4CM4wg7qns1JdLHqYoURyYf44GR+/yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow3AqCQolxtFSgeMJy9z1O5/uE94YD4so4ocofdm7MG4VKBdoyQU21xAI+Wk7hlzNdBMCbAIHUBE5Au5DQ/PgwRHkFXGQAMn5gBJFzPCxEKzT1LcU43aC89+zooieSPabjIw/4xR9GVMGA8bRTJ0l/sEiYNpo59NnEBSeFRfdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzvkzjW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65D8C4CEDD;
	Mon,  7 Apr 2025 12:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028118;
	bh=LEQvbISieLuk4CM4wg7qns1JdLHqYoURyYf44GR+/yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzvkzjW11x5hrXsjH8dKUP0xgWsNBmKhKtFYNcxBBTc3SfxX+8XN6LQyEw/CDBROw
	 LKw5vIHzE8TCClmNcD88BnSk+DeMVujiPoxzhQtHp0UDbA6C0YFIRyeo/dCMbMrOZk
	 4nHrJ6m3hyN1FkG4+eJPYEBArFtgzfvORrwoiw12T73oSOAMpadBecLgp35vfAPB0g
	 G7nMa1WgEDyVmtU1a5h6fdNlmkElLsObvysHwzxjP/s8lLfw+3kQC/DZ6VDuQjrdbx
	 uiJQ+CqLNysTuADvZ0NdqY/PIPqnr2dO73OjWMM7LFHYP0L9bVL1YYO++9p4r1X6f+
	 GFRvpOvOCMktw==
Date: Mon, 7 Apr 2025 13:15:14 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	victor@mojatatu.com, Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: Re: [Patch net v2 02/11] sch_drr: make drr_qlen_notify() idempotent
Message-ID: <20250407121514.GE395307@horms.kernel.org>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211033.166059-3-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403211033.166059-3-xiyou.wangcong@gmail.com>

On Thu, Apr 03, 2025 at 02:10:24PM -0700, Cong Wang wrote:
> drr_qlen_notify() always deletes the DRR class from its active list
> with list_del(), therefore, it is not idempotent and not friendly
> to its callers, like fq_codel_dequeue().
> 
> Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
> life. Also change other list_del()'s to list_del_init() just to be
> extra safe.
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


