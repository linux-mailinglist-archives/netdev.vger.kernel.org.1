Return-Path: <netdev+bounces-148648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3DF9E2CE3
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633B21642E8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980211FDE2C;
	Tue,  3 Dec 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpcv6Tbd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC871FBEAB;
	Tue,  3 Dec 2024 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256986; cv=none; b=THhMs0X+/ect80VJPaB9jgEkkbRSvvnJDjAGnR2802f+zvECRdMTtnk4SnAD+o/gz8/MhuiWFaj4EIGuVTyoMTOoMOLoopAcEG3ZTTico6XHL0vEfAtnp7U9ZqHs8yq4eDYNk7kC9+EFkWZ4gDEN4ILxdw+5WGCfvI/+TSprSUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256986; c=relaxed/simple;
	bh=iUjDkYBI+2a5FDDfq+d0kJqea8wogi+YDcF/o4E/VNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDS7A4mT8G8nLz4vHJf0Wdsj4nXiV8gONi3dTbLP7iUV7KlcXlbYfDf/hbSuwjnwJK+hVUVziQnIL5mLTxT5UAUhhsR8ehTmtGrdLOd2mGinLLjmpFSdfaWOl7JNAYbpVktCo3GFwGkpCVJtJ4Cvbea0mmWMMA/fytdKt6qp+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpcv6Tbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA840C4CECF;
	Tue,  3 Dec 2024 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733256985;
	bh=iUjDkYBI+2a5FDDfq+d0kJqea8wogi+YDcF/o4E/VNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kpcv6TbdV0Q/VfCNwct/grUWd/Uo1UMbk/t9JsyCLXJ0OIkreptVa7t194GDl7zXt
	 HpHT+Sb2NwhQzTGAMnyVeU20NU3O5tdrSBom/locVuRO6aLFTjcKveZQy/cNmGj0Ni
	 sEEh9+j1l83xfQyf/7Phb96raOf84/j/Xe3NZR4iHWwn0nhdSneFA7x5GcY3wQlksr
	 XIARNGRPfYhBBIP8xKRCodcJzMuElkl9lv8Mi7dfCPbBLV9FeW7bVHFI+UmMa5A5Tx
	 NatwMolI38ZsBDM/Dy7v3YbngxGcG72Ofe/U6MZWJdmBjCfuDVP9Gd2O4Onz082Wvf
	 CFWeiPf7z7XBA==
Date: Tue, 3 Dec 2024 10:16:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Hao Luo <haoluo@google.com>, Josh Don <joshdon@google.com>,
	Barret Rhoden <brho@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z09nGHvk5YJABZ1d@slm.duckdns.org>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>

On Thu, Nov 28, 2024 at 04:16:25AM -0800, Breno Leitao wrote:
> Move the hash table growth check and work scheduling outside the
> rht lock to prevent a possible circular locking dependency.
> 
> The original implementation could trigger a lockdep warning due to
> a potential deadlock scenario involving nested locks between
> rhashtable bucket, rq lock, and dsq lock. By relocating the
> growth check and work scheduling after releasing the rth lock, we break
> this potential deadlock chain.
> 
> This change expands the flexibility of rhashtable by removing
> restrictive locking that previously limited its use in scheduler
> and workqueue contexts.
> 
> Import to say that this calls rht_grow_above_75(), which reads from
> struct rhashtable without holding the lock, if this is a problem, we can
> move the check to the lock, and schedule the workqueue after the lock.
> 
> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

  Acked-by: Tejun Heo <tj@kernel.org>

This solves a possible deadlock for sched_ext and makes rhashtable more
useful and I don't see any downsides.

Andrew, can you please pick up this one?

Thanks.

-- 
tejun

