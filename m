Return-Path: <netdev+bounces-88085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4598A59A3
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923E1B2198D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0713A864;
	Mon, 15 Apr 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsCOzZCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE071B50
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 18:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205159; cv=none; b=moQ3vNvFl7TpJd+xKai+EM/xxoK1CRJSBMKmaZNJevCijf42QXA0Wzh5pS+KlnIU5yD7aFXTw9Mq0imq53jM/ItIRDacqatA/OuStdfbdgXloXbgGs4kDK7+9i/4ZX83jxQRvz8gNn15QQuF4UCyyuZj8dIcXN1vXFPX0CU7xOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205159; c=relaxed/simple;
	bh=QWYDehBueQOLYSaw9dTN6swpTnSS11JptaLV+QpKdNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JC/EjYFme8VLNjNYdxeAElwH48MrinpdBo7KVRAuOy14gn5k27auLSkS+BlNTT9TD0OJewUzqiVI0jhfIUj0hILI066A8sOkFAjfiXcF0S7JaZfHzBv2avJGhJhriSFZMSyoVXlaSxSwHQr+x6+gOQOLfiZhK8Of45QyePWBqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsCOzZCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2600C113CC;
	Mon, 15 Apr 2024 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713205159;
	bh=QWYDehBueQOLYSaw9dTN6swpTnSS11JptaLV+QpKdNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rsCOzZCnNlCr3A7Ay1kkP21afWsj/W2U8lC0/PbbcHSkqcKcZ/U26URz46c/7sm/o
	 nb8AOGa52Bpra+1tLaMq23h5nVmLArJYRMLFh+4Z0dpJfMgUpxlQKe4Ajg+sBdnSpe
	 g9D5cUGlSXJdvONElkIO8ehrfLLXbNe8EEwvzyzz3SnHRhARDaYzZq47oFPbOV5vJq
	 +cN4/W838gVAhwrG2mZxFPB/9uBxkZkt3gWEU6cQqPnWLIswu5L5J4592IJ20FhQhj
	 RyWORnG/kqFhHfsny5nLLtbXciNHqwo5YKQQbCB0ifO90/bkBChWedOsnsL0+OXPzn
	 rljPrnWbqtwhg==
Date: Mon, 15 Apr 2024 11:19:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, Alexander
 Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
Message-ID: <20240415111918.340ebb98@kernel.org>
In-Reply-To: <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 11:03:13 -0700 Alexander Duyck wrote:
> This wasn't my full argument. You truncated the part where I
> specifically called out that it is hard to justify us pushing a
> proprietary API that is only used by our driver.

I see. Please be careful when making such arguments, tho.

> The "we know best" is more of an "I know best" as someone who has
> worked with page pool and the page fragment API since well before it
> existed. My push back is based on the fact that we don't want to
> allocate fragments, we want to allocate pages and fragment them
> ourselves after the fact. As such it doesn't make much sense to add an
> API that will have us trying to use the page fragment API which holds
> onto the page when the expectation is that we will take the whole
> thing and just fragment it ourselves.

To be clear I'm not arguing for the exact use of the API as suggested.
Or even that we should support this in the shared API. One would
probably have to take a stab at coding it up to find out what works
best. My first try FWIW would be to mask off the low bits of the
page index, eg. for 64k page making entries 0-15 all use rx_buf 
index 0...

