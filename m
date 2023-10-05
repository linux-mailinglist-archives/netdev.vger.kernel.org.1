Return-Path: <netdev+bounces-38314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86F67BA5F0
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 93989281A70
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0443134CE3;
	Thu,  5 Oct 2023 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2hqIjnc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6FE34CD9
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28B8C433C9;
	Thu,  5 Oct 2023 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696522907;
	bh=vVI8ELd2bANGUqh/pj5lOKnspn0ZKfxuLxlqRTq3km0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2hqIjnc2FRu4Q4idwN+YjRvKFcC97MMcraMtaMDZf3lvHIRCJjYn0wnCQZ+bnVVz
	 V4DMWSj18apzV2yEMRX+NVOAvtpIqohsBSNClYUJRYqSpxgb5QSiMT9xt+WxjGW4M1
	 8giFd9Gz5cuOxDBGHoNDidTSienNMLgoYDWiYuSmdzfFhc9JZPTJgV8pw2v8s3im1e
	 h1EDzp9LOdXueKHmxo6I+gyGLHBUNLa/JJUhphxZPLmeP8lGDYHKXl0lP3efp4/aSS
	 uceFuTUPqW944M/fj4E1sK9kdcmyTwI7C/6To2vK+zzBJ7Vujs6WKx9gklogyhSkmH
	 TccYTOwWomhdg==
Date: Thu, 5 Oct 2023 09:21:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <hawk@kernel.org>, <alexander.duyck@gmail.com>,
 <ilias.apalodimas@linaro.org>, <linyunsheng@huawei.com>,
 <bigeasy@linutronix.de>
Subject: Re: [PATCH net v1] octeontx2-pf: Fix page pool frag allocation
 failure.
Message-ID: <20231005092145.08cc84fb@kernel.org>
In-Reply-To: <20231005021434.3427404-1-rkannoth@marvell.com>
References: <20231005021434.3427404-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 07:44:34 +0530 Ratheesh Kannoth wrote:
> +	sz = PAGE_ALIGN(ALIGN(SKB_DATA_ALIGN(buf_size), OTX2_ALIGN));
> +	pp_params.order = get_order(sz);

Surely get_order() rounds up by itself otherwise all callers would
have to do the PAGE_ALIGN()...
-- 
pw-bot: cr

