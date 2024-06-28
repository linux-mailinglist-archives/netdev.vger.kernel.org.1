Return-Path: <netdev+bounces-107731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B81C91C2E6
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFEA1C21A1F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CD91C2329;
	Fri, 28 Jun 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndOC9QN2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F261DFFB;
	Fri, 28 Jun 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589649; cv=none; b=ktKNK0vv6FD+0MLv+TcnCZGGDop1bMqKGoPoiFlv70CNyYnk1oAQdN6T1Srf3U6QQWUrhlmk70IRuQw8VGWN2RMWW9zzTyytyl2Fmdgp9+/g66k9fP8S7dXhYH9dit8XMmGX8BHWQtOlZIcbW+r0fBR3Coo9Ga+/Jnd4nIERcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589649; c=relaxed/simple;
	bh=KbxG9woxasDlknjgS1B+YGJ+MgARRZPg7XNQoih444I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIjACPRWElnEsokPt1w0GrmqEufi4R981j4CSKw/POuwDS++oS3ezCZsVvIK0fSi1Ckc6xyB0/P4IFwFWjuk06Tsxix5tVXJU4qeO8nX/0k52DtCW5IkEsbzEzV/Xnyn7CEgEM/F6OkJZ7DxcMMvwMk0QgvjvFehIb7QfxGgPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndOC9QN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34036C116B1;
	Fri, 28 Jun 2024 15:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719589649;
	bh=KbxG9woxasDlknjgS1B+YGJ+MgARRZPg7XNQoih444I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndOC9QN2uTkhIO2OBDFw49MNzOI5NaFZY5RIY77D+rSuEiG9qdDoVLA8HOyqzMNmY
	 FzHWUnu0kN7M8ugVO+fpdIA9znZ0mZ/xHDM9QcHDN2AtwFL66F4HB+12z4+gz3+vGG
	 06kYO3zSIMO4Nv1Hgs0QSGH94LluAMsdT7lK+i4uByVYg3YUFFjGQ9QmFx8K8ISmbL
	 oZcKCAVfu4sDeY6HjpFxQOU+XIXD7yNO3dov7m7RnrCCR62xMd8LhKLRUY+K//RJL7
	 1m6gP0JAMv6/2r8YaPZxUOP6dYDgcoQ1Weh+IH5pXluUYDplnZpey+GIOTBDrybQ3H
	 iCLumA1dKvRBQ==
Date: Fri, 28 Jun 2024 08:47:28 -0700
From: Kees Cook <kees@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	jvoisin <julien.voisin@dustri.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 4/6] mm/slab: Introduce kmem_buckets_create() and
 family
Message-ID: <202406280846.205B57F@keescook>
References: <20240619192131.do.115-kees@kernel.org>
 <20240619193357.1333772-4-kees@kernel.org>
 <cc301463-da43-4991-b001-d92521384253@suse.cz>
 <202406201147.8152CECFF@keescook>
 <1917c5a5-62af-4017-8cd0-80446d9f35d3@suse.cz>
 <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn5LqMlnbuSMx7H3@Boquns-Mac-mini.home>

On Thu, Jun 27, 2024 at 10:35:36PM -0700, Boqun Feng wrote:
> On Thu, Jun 20, 2024 at 10:43:39PM +0200, Vlastimil Babka wrote:
> > Rust people were asking about kmalloc alignment (but I forgot the details)
> 
> It was me! The ask is whether we can specify the alignment for the
> allocation API, for example, requesting a size=96 and align=32 memory,
> or the allocation API could do a "best alignment", for example,
> allocating a size=96 will give a align=32 memory. As far as I
> understand, kmalloc() doesn't support this.

I can drop the "align" argument. Do we want to hard-code a
per-cache-size alignment for the caches in a kmem_buckets collection?

-- 
Kees Cook

