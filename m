Return-Path: <netdev+bounces-197665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 417F8AD9888
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF031BC013E
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04A28D85A;
	Fri, 13 Jun 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCYcsPTe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8132E11AE
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856600; cv=none; b=dolZOdc5l53GK4p8Y7IwC8A8ZZT5r2VzLE/AzFIZGPJXzpraVdl80UnJDmp8+fNn1jwS94mE5Tey2YBQLF/xXhsJW1ZbSy908bjQFbLziVizbY1dcaWJX7m2beoBX3vKES24wVG9WFB2cW37509btCPmPfUFIyIdRFqpsFdQ3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856600; c=relaxed/simple;
	bh=Ta6INm0qEY5/bEng2+yRJTVLuijpmUaksrrPY/2i7wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kz4GnCukFletCs97IlKafRv2vh9NJ5S4VSHtfmC/2QL66GjYniaMp99Fn6altWnOoMypTY2g415L6srzcaMhnxP+Nje0g75UOEO6cW1ZNsTJIlygq9KZWN3NoBmjFfkwUcWu7b8EOZbOPc6RHL/G2lu1w2rnL0duj4OY9nR7Jpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCYcsPTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B0BC4CEED;
	Fri, 13 Jun 2025 23:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749856597;
	bh=Ta6INm0qEY5/bEng2+yRJTVLuijpmUaksrrPY/2i7wI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UCYcsPTedRpatdvEvdspMMczTi5o4sU+cKyOCGbUO7A3Z6kUBInvo1z/XXzsnj1cP
	 owOs8h1SU8lJ9NcPhVOyxU84lqnKfliGrEdCr91qTiQXJTbp0twknAXb9xQoxBAOya
	 h2lxryUO+UFUo2v94jXur3mofhDbSNd5u2kNdr3sRbxPn7NEyQHJzyqqSXjkDehgtf
	 89GfRZnvUIvfJiLKev/sBIRmbYijXwN+MjVTKsZw7c1Hs/EYOWMR9Qt4iw6o7HTthU
	 q7rs2v9YaL596FjZeMmyq/ZIxn9n0PNx9WtI+c4FDZeHKS/YP31oOjYuLMh1CUzCmb
	 8D8u3iI38rioA==
Date: Fri, 13 Jun 2025 16:16:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <20250613161636.0626f4f3@kernel.org>
In-Reply-To: <zkf45dswziidctwloy7wqlpcu2grdykpvmmmytksyjwal3wd42@f5cleyttlcob>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-20-kuba@kernel.org>
	<5nar53qzx3oyphylkiv727rnny7cdu5qlvgyybl2smopa6krb4@jzdm3jr22zkc>
	<20250612071028.4f7c5756@kernel.org>
	<vuv4k5wzq7463di2zgsfxikgordsmygzgns7ay2pt7lpkcnupl@jme7vozdrjaq>
	<20250612153037.59335f8f@kernel.org>
	<zkf45dswziidctwloy7wqlpcu2grdykpvmmmytksyjwal3wd42@f5cleyttlcob>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 19:02:53 +0000 Dragos Tatulea wrote:
> > > There is a relationship between ring size, MTU and how much memory a queue
> > > would need for a full ring, right? Even if relationship is driver dependent.  
> > 
> > I see, yes, I think I did something along those lines in patch 16 here.
> > But the range of values for bnxt is pretty limited so a lot fewer
> > corner cases to deal with.
> 
> Indeed.
> 
> > Not sure about the calculation depending on MTU, tho. We're talking
> > about HW-GRO enabled traffic, they should be tightly packed into the
> > buffer, right? So MTU of chunks really doesn't matter from the buffer
> > sizing perspective. If they are not packet using larger buffers is
> > pointless.
> >  
> But it matters from the perspective of total memory allocatable by the
> queue (aka page pool size), right? A 1K ring size with 1500 MTU would
> need less total memory than for a 1K queue x 9000 MTU to cover the full
> queue.

True but that's only relevant to the "normal" buffers?
IIUC for bnxt and fbnic the ring size for rx-jumbo-pending
(which is where payloads go) is always in 4k buffer units.
Whether the MTU is 1k or 9k we'd GRO the packets together
into the 4k buffers. So I don't see why the MTU matters 
for the amount of memory held on the aggregation ring.

> Side note: We already have the disconnect between how much the driver
> *thinks* it needs (based on ring size, MTU and other stuff) and how much
> memory is given by a memory provider from the application side.

True, tho, I think ideally the drivers would accept starting
with a ring that's not completely filled. I think that's better
user experience.

