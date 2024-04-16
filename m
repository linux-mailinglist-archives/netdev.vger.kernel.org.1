Return-Path: <netdev+bounces-88140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70588A5F2C
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 02:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D6DB217B7
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 00:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A2C36E;
	Tue, 16 Apr 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/ppAFvl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EAA3F
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713227062; cv=none; b=cBtILucOa2bGgOFM2FU0CHyS5VAcBw76yzeHoTY0mMr/qno9SoNDxE7BiE04jS7a8dgDCRufNaiB11onfgboEQGHdSZONk34LU3ICTBdfEcd9F+wF9BQ9snUXVFakRmM2IAt0bRwvBwPoFQqm1cvmwlx70Uca+RFvnqa93WYBzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713227062; c=relaxed/simple;
	bh=7NneDENfzfwZVV+UlVl2c+lO/XTbTS8AXH/t0a9ORBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR3Dw900v7kHNYthrpwH1Ri8YwW5v2zLDD/X3NspjaEJWdbml4Qg8GEELlTBbBxx7tOQguEcDF/PFlKY1OSw8+QttoA66zOQz3hVZ+hjaOLEjnfpuiUw6ndj+GAoc+lQPKdP763YpqHZ+wN3WH1MqzYJqwISPl02PJzJh090TTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/ppAFvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38779C3277B;
	Tue, 16 Apr 2024 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713227062;
	bh=7NneDENfzfwZVV+UlVl2c+lO/XTbTS8AXH/t0a9ORBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s/ppAFvlvXxEJb3/NVXz9k8uKPxy6/mU6T+h83eoGPXPoQfMIDxvpELsF3EyU16Pa
	 2AHqvKuAKQ9II8DXD6DpankE/nO2hoZ/GvnM0DiJPjulh0umAHnNau6OWlgpSfrijT
	 3BcnggOK/94hQGutTWlOHQo2qCDnRNeZYEPoAYJMCIWFaVkg0uuUMG8NwDA2y95PVa
	 2hJM7MFvYGQsvSYqOqoQsF6j+rr0R555+D4PiN2qK0md+iDqUuRlOkPCVR6/ox/eP1
	 4tOH5tNIROq/GYuQhTpr0Nstxei47a45rncJvf6nfD52pIasNf5+6/mXLct8KPrVDe
	 ViM+8ExCD6GYg==
Date: Mon, 15 Apr 2024 17:24:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, Alexander
 Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
Message-ID: <20240415172421.22d13a9d@kernel.org>
In-Reply-To: <CAKgT0UcNPBE17T7g4y0XSkEZN89C69TfjWurAap5Yx_8XWLk1w@mail.gmail.com>
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
	<20240415150136.337ada44@kernel.org>
	<CAKgT0UcNPBE17T7g4y0XSkEZN89C69TfjWurAap5Yx_8XWLk1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 16:57:54 -0700 Alexander Duyck wrote:
> > The testing may be tricky. We could possibly test with hacking up the
> > driver to use compound pages (say always allocate 16k) and making sure
> > we don't refer to PAGE_SIZE directly in the test.
> >
> > BTW I have a spreadsheet of "promises", I'd be fine if we set a
> > deadline for FBNIC to gain support for PAGE_SIZE != 4k and Kconfig
> > to x86-only for now..  
> 
> Why set a deadline? It doesn't make sense to add as a feature for now.

Okay, maybe I'm trying to be too nice. Please have all the feedback
addressed in v2. 

