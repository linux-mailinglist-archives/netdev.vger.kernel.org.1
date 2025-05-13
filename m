Return-Path: <netdev+bounces-189967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB19AB4A0F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 05:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D180E865A79
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613DE45038;
	Tue, 13 May 2025 03:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MjX1FF5L"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132B1548C;
	Tue, 13 May 2025 03:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106355; cv=none; b=atpcbCuRkhaPPaWEUnfHZTUDsUMMGWeqJPfu6qOnOSFbBU1yjIHwk2EdtR5L71+Mgm2dGM/KpWipb65Nl7QjzHe1UlcZn3x6vfJ9z51+DUOFKFpClaIhYnSm3rqSW+BGBuWIKVxIUmGfVIaZXbIdShXLCFM0oR6vvY1AxoWDprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106355; c=relaxed/simple;
	bh=cewvoZrkJRWzz9sOFmqGO8qc4hsNBY8nqx/F6G+sYAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVMMU1yVhnYYFrp5gqFBvTXpYk1Q2RBxXaxqfYIzuTM+eLgmBqSYFE3Mkud3X6R3S3QZEL/Jv93vSmBG81Iy3fsfJENKv1T0zK5HGDFpKUMW3JgXwPLX5G6Ko/mfd4jFVgobg+kZqgcNolJHjXa573gcXOA3zUQzyh1tHnx2mAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MjX1FF5L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0M9epOa8EtgjN2hW41pzy7m/2PgNBY8TSfcb2WsZvPU=; b=MjX1FF5LbtkTgftofXkp6yM9P+
	xouhn+xC60S5db9RZdilVzmmsNVs+qNMVOp3Tbwoko5X4EVP4Gge1OMUb/kgC2iemlSUJo3cQVUyq
	wcg0y8K4WPElB9b9uX/+6Xe/PcaXCZf9j3jMtu45Hb8JRsOA7PKnYVoO/RQtY84xG4X5dJMLS+eA6
	9XgyWUZIP+Zg+7gcv8REaSMgAqRvgqrNxPaCI+4O4NPSMRPNTaL1AeaCoIt4qw1IuDk3LVm6COX+g
	ucxrpxpf/CrHaMuGsIMKiP1nA60nCFq800uEFgltjtyLlsH+9XTVv7mVSX5xiNbvAJLIv8F/1rBKs
	PWLtIbzg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEgAZ-0000000AU2i-4AqK;
	Tue, 13 May 2025 03:19:04 +0000
Date: Tue, 13 May 2025 04:19:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Byungchul Park <byungchul@sk.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
	almasrymina@google.com, ilias.apalodimas@linaro.org,
	harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	john.fastabend@gmail.com, andrew+netdev@lunn.ch,
	edumazet@google.com, pabeni@redhat.com, vishal.moola@gmail.com
Subject: Re: [RFC 19/19] mm, netmem: remove the page pool members in struct
 page
Message-ID: <aCK6J2YtA7vi1Kjz@casper.infradead.org>
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-20-byungchul@sk.com>
 <aB5DNqwP_LFV_ULL@casper.infradead.org>
 <20250512125103.GC45370@system.software.com>
 <aCII7vd3C2gB0oi_@casper.infradead.org>
 <20250513014200.GA577@system.software.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513014200.GA577@system.software.com>

On Tue, May 13, 2025 at 10:42:00AM +0900, Byungchul Park wrote:
> Just in case, lemme explain what I meant, for *example*:

I understood what you meant.

> In here, operating on struct netmem_desc can smash _mapcount and
> _refcount in struct page unexpectedly, even though sizeof(struct
> netmem_desc) <= sizeof(struct page).  That's why I think the place holder
> is necessary until it completely gets separated so as to have its own
> instance.

We could tighten up the assert a bit.  eg

static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));

We _can't_ shrink struct page until struct folio is dynamically
allocated.  The same patch series that dynamically allocates folio will
do the same for netmem and slab and ptdesc and ...

