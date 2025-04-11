Return-Path: <netdev+bounces-181757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4EA865D9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D454177C70
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA4270EB4;
	Fri, 11 Apr 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZPRDVkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F61F2377;
	Fri, 11 Apr 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397972; cv=none; b=RQ+m/qjDUv2OVYpl55q0lK7VtysY4YJtU67YQ+fIY6KK78HcpZTR2cZuNbgyMw27w2L1PJvYfZ4PDwflh+ZZ8EtEDd1+gkoYNwvLTJ7OL+Ch3Pzpv8m2tXnjIUjo2sf9GgG966QrtRWanm3oF+LUQrvkkKEiBquWJmnKuoFJLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397972; c=relaxed/simple;
	bh=cevjr6NkY0oSnZTaaK/QxBTo40hQ3Z3qrdPAhXIzRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apbnYhsmF0fyG+j85qz636umKpkXmXWH3Eq6SB8PaXBfbs0R9cP5+1gqLrI/oQt1oDaxr+eMWPhcT2bD9Z3FgiC4dZHQ1Btw9vQhtBbb3PIXl6gSlk2SlRWW2fS88YgzX0L+SlbVMUh09ihNWJ0Y/rG0UGYiucxA+zi3Zk9repE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZPRDVkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A06C4CEE2;
	Fri, 11 Apr 2025 18:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744397971;
	bh=cevjr6NkY0oSnZTaaK/QxBTo40hQ3Z3qrdPAhXIzRjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZPRDVkcgisckSTl3Ooy1PrTb4ctHNPBZ5au6r/bVk1mtuKDvYa+kRLcDRRBJZEz7
	 lsxlQMhtUFJAXb1Hqitju+NYMTAi/yTDS20kYb1V9QUOu+oWhKHb1KaIVd5BubXDt4
	 sB1HMTRUHeELY67xt7TYTfrx8sgNczD8MVdJuSgouL+uVgu+0Ws+CRnXo9fjsNQHHr
	 v9lC8Dy/nc0yzqMF7FqQsTo4ubqsvqW/c1ecze5nQTWUJkpEQ7DFFdxuAjXhujntJA
	 1reXufOVZ8gvyczeitRlXk1Z/0P4Dmqui/+p/rB7eF0BkBZLku5q8iS1i3w178GQW2
	 53jGe13PJIyeA==
Date: Fri, 11 Apr 2025 19:59:23 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 net 1/5] pds_core: Prevent possible adminq
 overflow/stuck condition
Message-ID: <20250411185923.GP395307@horms.kernel.org>
References: <20250411003209.44053-1-shannon.nelson@amd.com>
 <20250411003209.44053-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411003209.44053-2-shannon.nelson@amd.com>

On Thu, Apr 10, 2025 at 05:32:05PM -0700, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> The pds_core's adminq is protected by the adminq_lock, which prevents
> more than 1 command to be posted onto it at any one time. This makes it
> so the client drivers cannot simultaneously post adminq commands.
> However, the completions happen in a different context, which means
> multiple adminq commands can be posted sequentially and all waiting
> on completion.
> 
> On the FW side, the backing adminq request queue is only 16 entries
> long and the retry mechanism and/or overflow/stuck prevention is
> lacking. This can cause the adminq to get stuck, so commands are no
> longer processed and completions are no longer sent by the FW.
> 
> As an initial fix, prevent more than 16 outstanding adminq commands so
> there's no way to cause the adminq from getting stuck. This works
> because the backing adminq request queue will never have more than 16
> pending adminq commands, so it will never overflow. This is done by
> reducing the adminq depth to 16.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


