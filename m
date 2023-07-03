Return-Path: <netdev+bounces-15226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7E07462DE
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 20:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61191C208E4
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B61100D3;
	Mon,  3 Jul 2023 18:53:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E922259D
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 18:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7DDC433C7;
	Mon,  3 Jul 2023 18:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688410407;
	bh=cFuH7KHphHtbkrf3yGRT3kVRp3RoED0KcNNoFXuTanI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l6M+nqAxgf5CYh723QNeHNFv44GVcl1/Sys/BpuvR27exTK9OMHPd7+Z7QY7i/z/2
	 zQSSO5dgyDmDo4RetY+RPYZ+q373rWVlxt7vIoywfYCCdLMbZVOSwWegPjRMptEfYs
	 s2hgxczfHJWucdU5eEwOR049QACqSJHevhItbwOT4Nk+WlbNUQCQl/8d79iIU0EwP2
	 QYkz4BF6je5KHdJhLiG8d0fU4Q33zYKWA/0cCnIZHHwozF6V7qqNUQdA4HNcwIvTO9
	 J1ntGcfLV3pA6LbngC0UPjdfV3nq5oLe6RZeNFnovSolCw1HD5pAvDGzfFDBsL6xgb
	 bu9YHCDP2GpjA==
Date: Mon, 3 Jul 2023 11:53:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Liang Chen <liangchen.linux@gmail.com>
Cc: ilias.apalodimas@linaro.org, hawk@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linyunsheng@huawei.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool
 case
Message-ID: <20230703115326.69f8953b@kernel.org>
In-Reply-To: <CAKhg4t+hoOiVWMbBiD7HCu_Z5pSdCsZrev2FMEKhbWvzgHCarw@mail.gmail.com>
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
	<20230630160709.45ea4faa@kernel.org>
	<CAKhg4t+hoOiVWMbBiD7HCu_Z5pSdCsZrev2FMEKhbWvzgHCarw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jul 2023 17:12:46 +0800 Liang Chen wrote:
> As for the "pp" reference, it has the test
> page_pool_is_pp_page_frag(head_page) there. So for a non-frag pp page,
> it will be a get_page call.

You don't understand - you can't put a page from a page pool in two
skbs with pp_recycle set, unless the page is frag'ed.

