Return-Path: <netdev+bounces-95392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB48C2250
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F43B2346C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF25150992;
	Fri, 10 May 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrQteGSi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275B1292F2;
	Fri, 10 May 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337547; cv=none; b=hyJKdvkJK0qZCP/TME4GC34yXHMwixOza+MZcmPXj2b3QJqMcPxw+ALNEreZYF447tUXQMYwTyitvztcVj+a/1AzeDecobmjyT6zIqBNGL4K1O35tsbxVNz7B9+SVF9oHlCCnBls7xHAfsFB69/uA2wPLekn3M+J4xgxx3Qa5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337547; c=relaxed/simple;
	bh=uJpdu9yk6rcXm4O9JLoTWaWJh3y6edVSb8yRWlDyuos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNxkx7ohgYVsrCjFAGCYkoemZvbj1fCf/BjCoux7jliw0M/o5cuj04Ow0gYg7nHO0mYQhmtwXO8pmpFo4PEO/lJmGmXipRaZg4YaVVLs5gU/pjTv3Mr9nusPAWf+j7edZuTIuKyAcePVpngpABcYbXObrKNnbvxQHGSFjv6NiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrQteGSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE29C113CC;
	Fri, 10 May 2024 10:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715337547;
	bh=uJpdu9yk6rcXm4O9JLoTWaWJh3y6edVSb8yRWlDyuos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrQteGSigTk0Gtws2jATaUQiKMfipg55fkb5bLuGAzDS5YQgO1gBpdufBuC/Pybmp
	 BpUdHz1BBgR9PqhXTgP7zkQpa042Tz5TpzmgCIQkTPLj1htw1iGgzD6hYVcDXr98S9
	 5ApSbXfrvv5cBJZsBUelGmgopNS4HN/sUzErd7witbcwTGVmS3rqAWxroF5nu2IvDM
	 oL6d+EFm216fs+CYwjCy33kuY3aytdMJOIcNPp4o88rOtBNu5pf6PRhRbg2R1F7Mce
	 txiQPXHR0XDvNkIp4hSYktd1gh9VlYs8XTdeyXdmuiVzw3ch3Mp9L8rN6BwrmU2Fll
	 63T76EevrosDg==
Date: Fri, 10 May 2024 11:39:01 +0100
From: Simon Horman <horms@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
	naveenm@marvell.com
Subject: Re: [net-next Patch] octeontx2-pf: Reuse Transmit queue/Send queue
 index of HTB class
Message-ID: <20240510103901.GC1736038@kernel.org>
References: <20240508070935.11501-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508070935.11501-1-hkelam@marvell.com>

On Wed, May 08, 2024 at 12:39:35PM +0530, Hariprasad Kelam wrote:
> Real number of Transmit queues are incremented when user enables HTB
> class and vice versa. Depending on SKB priority driver returns transmit
> queue (Txq). Transmit queues and Send queues are one-to-one mapped.
> 
> In few scenarios, Driver is returning transmit queue value which is
> greater than real number of transmit queue and Stack detects this as
> error and overwrites transmit queue value.
> 
> For example
> user has added two classes and real number of queues are incremented
> accordingly
> - tc class add dev eth1 parent 1: classid 1:1 htb
>       rate 100Mbit ceil 100Mbit prio 1 quantum 1024
> - tc class add dev eth1 parent 1: classid 1:2 htb
>       rate 100Mbit ceil 200Mbit prio 7 quantum 1024
> 
> now if user deletes the class with id 1:1, driver decrements the real
> number of queues
> - tc class del dev eth1 classid 1:1
> 
> But for the class with id 1:2, driver is returning transmit queue
> value which is higher than real number of transmit queue leading
> to below error
> 
> eth1 selects TX queue x, but real number of TX queues is x
> 
> This patch solves the problem by assigning deleted class transmit
> queue/send queue to active class.
> 
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


