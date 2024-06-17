Return-Path: <netdev+bounces-104185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76990B73D
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C1D28125A
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EBE166306;
	Mon, 17 Jun 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djttx0PR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B8161B6A;
	Mon, 17 Jun 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643534; cv=none; b=BPrPES3pSQC2ttlG3ACSdPiNwoADt+QsE5APeW8Tyc7LhlGie0vKIO06M3tAH17rU82jOogAVKcfIbOzFFSvQb+zimtbGenquSgj04hmt2Kcl7uYoPWqW8hhNxtg63/hzkM/Oa+tQRgJukNs0yzWV8k7njpkumjB082rBl/7COE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643534; c=relaxed/simple;
	bh=dpdVP1VDv8kFRM0EqSc1BHPLy5nCZCtoPOXrRCz7Db0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHccduKR86KFf5JRyPgLlFVdoklFYi1hiyVHxOau0tBVokhGMhdOr1yWOgWT5NUqteQrmS/pz/rYjR11k8u6IHy3s+wh3tEEAm31UoERPzPweaizGXoeLEDvBQ3PWRj92/2cK0dOGARSEQeditWJQhegPcBPK1iM0xP5pMwk8Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djttx0PR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C86AC2BD10;
	Mon, 17 Jun 2024 16:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718643533;
	bh=dpdVP1VDv8kFRM0EqSc1BHPLy5nCZCtoPOXrRCz7Db0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=djttx0PRC8yBOwLGknH4Jf64hsQKYt3iWpc7lnf+cmYDTi9QR6bAljomlKRIgyLoU
	 AVBhGb2HRR8nIwb6/l+sF6FV6PKgoeMdDsIeoCQ2pmXDcly4BTms6rnbz87Oac1DVg
	 H+YHXP4DwesJ68s9HWUXqOzqDVXUmcL0KUB2pix2crXdJ8e9kSTEOSzYccBqYAGsMA
	 9x4mhBVQZjzwB2yyFMOt9YxzvSL2pG2nrGDcxNqw5heNfpurw21TNz33UG3uXuwFB6
	 A9DP54TEYSATYnPNuX7sU7F6dGG6shdNhbfef+Nn3TZOe2GatA0Ohf5EF0lRl8nesZ
	 Olik7aORC1MLg==
Date: Mon, 17 Jun 2024 09:58:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Matthew Wilcox <willy@infradead.org>, kernel test robot
 <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com,
 netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, David Howells
 <dhowells@redhat.com>
Subject: Re: [PATCH] net: micro-optimize skb_datagram_iter
Message-ID: <20240617095852.66c96be9@kernel.org>
In-Reply-To: <033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
	<4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
	<Zm9fju2J6vBvl-E0@casper.infradead.org>
	<033294ee-e6e6-4dca-b60c-019cb72a6857@grimberg.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 09:29:53 +0300 Sagi Grimberg wrote:
> > Probably because kmap() returns page_address() for non-highmem pages
> > while kmap_local_page() actually returns a kmap address:
> >
> >          if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
> >                  return page_address(page);
> >          return __kmap_local_pfn_prot(page_to_pfn(page), prot);
> >
> > so if skb frags are always lowmem (are they?) this is a false positive.  
> 
> AFAIR these buffers are coming from the RX ring, so they should be 
> coming from a page_frag_cache,
> so I want to say always low memory?
> 
> > if they can be highmem, then you've uncovered a bug that nobody's
> > noticed because nobody's testing on 32-bit any more.  
> 
> Not sure, Jakub? Eric?

My uneducated guess would be that until recent(ish) sendpage rework
from David Howells all high mem pages would have been single pages.

