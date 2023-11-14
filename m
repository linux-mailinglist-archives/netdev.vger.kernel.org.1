Return-Path: <netdev+bounces-47859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D827EB94C
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A9B1F25926
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05C2E841;
	Tue, 14 Nov 2023 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fURdyQnS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503012E83A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 22:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CFC433C7;
	Tue, 14 Nov 2023 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700000736;
	bh=CmbeBBJW6eNCnDWG7XFbzoz+Cww0cN4u7zfWKAxDRDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fURdyQnSVpbf5t99V71LcNGLgelOR6R2rlvm4Ps4Y94iRNSdGks4P+r39GuN8prsE
	 SnwMYYPOcrMFzpgeZv5zPIx0DGuPNU0m4yZsJZH7GJ/3OycmmbUSdySaqA5cQpDsf1
	 54YN7mHw2Ctl2/qxN2x6uury/PSVoI5x19U6FVTmQOnITzYzOfTAjI1MJiWNYaUNMx
	 9N65IAi9cn+VznLN7nGXUZ/T5Xc/ufmD18N7dZH/ZWpRsySs1vJ06WkrIbw+Ea+hXA
	 W2fV1SIKoKukwV8p6nFWFUwpDBuYf+L05OTkqLy9/75bseMChSyXwYbsZ51VS2y8Ra
	 8b2fSnaLiENmg==
Date: Tue, 14 Nov 2023 17:25:34 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric
 Dumazet <edumazet@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Matthew
 Wilcox <willy@infradead.org>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 3/8] memory-provider: dmabuf devmem memory provider
Message-ID: <20231114172534.124f544c@kernel.org>
In-Reply-To: <0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
	<20231113130041.58124-4-linyunsheng@huawei.com>
	<CAHS8izMjmj0DRT_vjzVq5HMQyXtZdVK=o4OP0gzbaN=aJdQ3ig@mail.gmail.com>
	<20231113180554.1d1c6b1a@kernel.org>
	<0c39bd57-5d67-3255-9da2-3f3194ee5a66@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 16:23:29 +0800 Yunsheng Lin wrote:
> I would expect net stack, page pool, driver still see the 'struct page',
> only memory provider see the specific struct for itself, for the above,
> devmem memory provider sees the 'struct page_pool_iov'.

You can't lie to the driver that an _iov is a page either.
The driver must explicitly "opt-in" to using the _iov variant,
by calling the _iov set of APIs.

Only drivers which can support header-data split can reasonably
use the _iov API, for data pages.

