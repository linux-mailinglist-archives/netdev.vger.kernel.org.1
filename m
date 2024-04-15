Return-Path: <netdev+bounces-88121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972F68A5D91
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5B9B21717
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 22:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50396157469;
	Mon, 15 Apr 2024 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQqGKOIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D411EF1A
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218498; cv=none; b=gWgfzQuEwYPuwMvENBJukioiwLBoHxiQvOtLES7IYDTURz7llUoTLmhMdsC1eUTo0Ly1UsmvpJ4Y8DqCeUEb5aQAE3L6HwkPs1Io4mppk6Mii9E/RFIi7C4dtQ9JJ/FP3/HnBdz9grdNmxh/4JMtUl5zAeGlmpm8ICxE/YtUXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218498; c=relaxed/simple;
	bh=bW9EzUyhI10jDFnEI2uldiJZ2Dvu5+J4hxKw5N3LNQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEgqQFRNXtQo6pjUc/Aa+1wo4MHPZDOmqCmjOqKMlwc8iwwHoP9IRZ2os6Mn2jOGiH0R4ToURV7RqrEX696bhvXVYl6Wh+Vi7QrzWrwLiDW4laRj/2LJdR/8IU/TfqhLPTG+wj2eaWG6KuvEaYsZg/faKOSfY9pmIYg9T9FtC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQqGKOIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C2C113CC;
	Mon, 15 Apr 2024 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713218497;
	bh=bW9EzUyhI10jDFnEI2uldiJZ2Dvu5+J4hxKw5N3LNQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aQqGKOIl/KyLK+lp1holmzO/cCNebY7/4D4zmxpOHQ4SWj4PDs54NZyOsLGdgB7AL
	 h240PlywQSJF6hI/7PHMo2gClcLrVQ6szbBGHUnhQr56muNboatdgSQ3jHJ/Grk5ut
	 lUpl6DymNp7HOadydJglYnzGSCi76pewsYcLjN09mvozxBkmHHULpCwsWidV5h5jAw
	 paXXcNi/RzTO+wqxXVSmLcEiquApB8kY4Q84TH3giG7cQ6b9hVUoMQrbDHCQavC8LO
	 8QmRhMfMhZmbNeXO2n1Wi2T7kzDOAl5A7rOwn9IxAYXMYVxJAef5C/eIy0svw3R6kU
	 Dzoxk9vyxg9oQ==
Date: Mon, 15 Apr 2024 15:01:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, Alexander
 Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
Message-ID: <20240415150136.337ada44@kernel.org>
In-Reply-To: <CAKgT0Ud366SsaLftQ6Gd4hg+MW9VixOhG9nA9pa4VKh0maozBg@mail.gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
	<171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
	<41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com>
	<CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
	<53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com>
	<CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
	<0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com>
	<CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
	<bf070035-ba9c-d028-1b11-72af8651f979@huawei.com>
	<CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
	<20240415101101.3dd207c4@kernel.org>
	<CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
	<20240415111918.340ebb98@kernel.org>
	<CAKgT0Ud366SsaLftQ6Gd4hg+MW9VixOhG9nA9pa4VKh0maozBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 11:55:37 -0700 Alexander Duyck wrote:
> It would take a few more changes to make it all work. Basically we
> would need to map the page into every descriptor entry since the worst
> case scenario would be that somehow we end up with things getting so
> tight that the page is only partially mapped and we are working
> through it as a subset of 4K slices with some at the beginning being
> unmapped from the descriptor ring while some are still waiting to be
> assigned to a descriptor and used. What I would probably have to look
> at doing is adding some sort of cache on the ring to hold onto it
> while we dole it out 4K at a time to the descriptors. Either that or
> enforce a hard 16 descriptor limit where we have to assign a full page
> with every allocation meaning we are at a higher risk for starving the
> device for memory.

Hm, that would be more work, indeed, but potentially beneficial. I was
thinking of separating the page allocation and draining logic a bit
from the fragment handling logic.

#define RXPAGE_IDX(idx)		((idx) >> PAGE_SHIFT - 12)

in fbnic_clean_bdq():

	while (RXPAGE_IDX(head) != RXPAGE_IDX(hw_head))

refer to rx_buf as:

	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx >> LOSE_BITS];

Refill always works in batches of multiple of PAGE_SIZE / 4k.

> The bigger issue would be how could we test it? This is an OCP NIC and
> as far as I am aware we don't have any systems available that would
> support a 64K page. I suppose I could rebuild the QEMU for an
> architecture that supports 64K pages and test it. It would just be
> painful to have to set up a virtual system to test code that would
> literally never be used again. I am not sure QEMU can generate enough
> stress to really test the page allocator and make sure all corner
> cases are covered.

The testing may be tricky. We could possibly test with hacking up the
driver to use compound pages (say always allocate 16k) and making sure
we don't refer to PAGE_SIZE directly in the test.

BTW I have a spreadsheet of "promises", I'd be fine if we set a
deadline for FBNIC to gain support for PAGE_SIZE != 4k and Kconfig 
to x86-only for now..

