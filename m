Return-Path: <netdev+bounces-143823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF39C4561
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F30C282E83
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B20F1BD9F5;
	Mon, 11 Nov 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaOWT1Jb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA91AB6E2
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731351186; cv=none; b=jcXAogvmHXxxgThOlDMYNkSjzWG0TgamnsAPza0yc5m9SrapLgphAuYyaAqzZEeL3DVrpUqwCpX9+SSWOmFfXFXgV+Rs4ohVOfDVayXNmBeQQDbBO9EBHfhFNSqaLBsbI2OUF4ge2uMz4Cgag2FejBHiX0usHLD33pRfoFRdCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731351186; c=relaxed/simple;
	bh=p/Yi94GOUwQu8cVz7eeVj0Mhs4oCfXnvTAYUjIFMTXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RAMWLPQmmiIDLRZKZR/cwPFPlLGw+mtPI+XCDAMdG11lkSsHVM6HIg/mNwp5B44RYXUnsj9nAj/PQAv6tu5rzh2hGYZ3EhT0sXNC/YP6rVnLHy2I9vA1f/gJbHn/wmHMQwPLzpO2unjRRx05FZwy4jIBDFmF2LzVPdFAk9ifPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaOWT1Jb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5F9C4CECF;
	Mon, 11 Nov 2024 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731351185;
	bh=p/Yi94GOUwQu8cVz7eeVj0Mhs4oCfXnvTAYUjIFMTXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LaOWT1JbPZpKVYC8456Cv8dUpt54UIneVmIEWxbgv5BdKTnwisEriBbdlc1CcsWGm
	 8HUhXDuESmg9KrZiqPB8iP6m5rAkPtjuygcLrRIRiVYIzXd4Yj1Lo/AtHJBTeOQmGR
	 fcVZiM8db+b1152RpwslFLHHgB7gv3+6zlUjTsiM/vDZiB8qFGHi3bT9IFgf9ZErt/
	 fwLp1dCWJHXIJieiozS5jyeOMguWGpgssBItCThmkLQBfuZYRyoVAkRZ3Cjyu/4pxw
	 vsH0/6IvcLBcXRr+INIunE1JCVlZFwHeNusJEMLQ7Aw9cUDdcTGEQFpgwYDkyb5U0Q
	 bBdEVeCD0+MdQ==
Date: Mon, 11 Nov 2024 10:53:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com
Subject: Re: [PATCH net-next] eth: bnxt: use page pool for head frags
Message-ID: <20241111105304.1d7db6d5@kernel.org>
In-Reply-To: <CAMArcTW4RHWvNa-82O9D-NoqWALVuki0TpHeAn_NeT99C6+=7w@mail.gmail.com>
References: <20241109035119.3391864-1-kuba@kernel.org>
	<CAMArcTW4RHWvNa-82O9D-NoqWALVuki0TpHeAn_NeT99C6+=7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 15:48:02 +0900 Taehee Yoo wrote:
> Thank you so much for considering my work!
> I'm waiting for Mina's patch because the v5 patch needs to change
> dma_sync_single_for_cpu to page_pool_dma_sync_for_cpu.
> So there is no problem!
> However, I may send v5 patch before Mina's patch and then send a
> separate patch for applying page_pool_dma_sync_for_cpu for bnxt_en
> after Mina's patch.

Another way to make progress would be to add the configuration for
rx-treshold and HDS threshold first as a separate series. That doesn't
have to wait for any devmem related work. And in general smaller series
are easier to get reviewed and merged.

