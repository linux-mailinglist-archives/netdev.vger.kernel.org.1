Return-Path: <netdev+bounces-173570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B500CA5981A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF8C1889B46
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCEF22CBD3;
	Mon, 10 Mar 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YPU5opXU"
X-Original-To: netdev@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494122B8AF
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618226; cv=none; b=WgvZefkE/TXAEhiPiKqCt5K5fZE8EcLZqhSjlQMCUAkPP6jYCZKiet+hUzg2SDKbiMFys9/BqzJvRo7Z2xD+Vec8zNfmQs88/iQEyRTw8y4kGIVKCbKXBFhC/uOvsLSJxtqlRKb7nT/tXIAK372gTWZQed5D8+64+DqYm9AqGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618226; c=relaxed/simple;
	bh=goLVaP4UMeCWPEWJG7D5OhIfgqIbHSldorUA1nSZQ2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nj6bpapV2p2Qr7rAcBtks0UzV8WdyWiPxCY95R6eDf1dszrvFQC+Ig68D0x29zOuXhLS32fnRSRcS75emezAM1smM4nZ2255mUpbCSkDsGm+xG/HM5xLVMYJm5n15TuOmfmSxeX9H1OuA+Q8uuA2rCzzC4QHVFQG4LqY1xiVr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YPU5opXU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xdkQrPY81uDLTE9g/jDvPwdAJJChshBCGh5FBhoUlXU=; b=YPU5opXUOgRo6Vp0Lbjxlts67v
	slU0S1zgc3GMgD4Evk66SAkAKzcg38H9e6PGkrEeeNgEr6eHfcp7hKOKvhO9VqR5euCkdaP8z23bO
	TQK4gf5rOEToEbRfVUi8PJhoJ2IZM25kKFlR/SZQchmqFPmfct76oLVXDuMGsDjRcHzPg9a3Ix41d
	WhKRnLF4hqjdr7bpmkQrZw9Li43YQmvoDjUJmZ/2Hf6ZO6TxnRprv8PVtXxqmpkcgEIZ1f0ZE6c8a
	ul4FQoSOSNJcOUj3uXbFw5EYukh8o3iysVu3TriyTTgfhs8ZXZ+hEQ/yVk1NAZ4vilzjq9Zf4S44+
	ogxiwqNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1treSR-00000005BLY-3wxj;
	Mon, 10 Mar 2025 14:50:20 +0000
Date: Mon, 10 Mar 2025 14:50:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] mm: Decline to manipulate the refcount on a slab page
Message-ID: <Z878K7JQ93LqBdCB@casper.infradead.org>
References: <20250310143544.1216127-1-willy@infradead.org>
 <598912d1-0482-434c-b7bb-75e6fdc2e38e@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598912d1-0482-434c-b7bb-75e6fdc2e38e@suse.cz>

On Mon, Mar 10, 2025 at 03:37:51PM +0100, Vlastimil Babka wrote:
> Note it's a 6.14 hotfix for kernel oopses due to page refcount overflow.

Not actually overflow ... without VM_DEBUG enabled, networking increases
the refcount from 0 to 1, then decrements it from 1 to 0, causing the
slab to be freed.  So it's a UAF bug induced by a messed-up refcount.

