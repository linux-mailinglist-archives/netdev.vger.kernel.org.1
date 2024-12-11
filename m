Return-Path: <netdev+bounces-150974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84B9EC3AE
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 04:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0325C286263
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85BB22915F;
	Wed, 11 Dec 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="De8yOqZt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B7E22914B;
	Wed, 11 Dec 2024 03:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733888653; cv=none; b=O5xRB7NeylmGxuXEl1aH6F+tKvYx3bFp9/jXcHurd4KhmYzfegML6Nza0O5zpG1KyUYqYfM8P+De1kg464s7eL5tM/i81OIlb+RLrZN8NJ8io77jIltxJDw9YFllF7lzgHWZnL6aUYZWbaZc65cSTWOHAzZVYaxOO+ra1emKeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733888653; c=relaxed/simple;
	bh=97Q9KZPqtfr3u6MHwjc600BHQ9UHmgQQX4d8wB3oYIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qja8Kjspmu1XRpzm26RsuC0epTToRcn8PMEk5M+2RctVfxWFeDlJm01TtdjFStWfLBn+u1U9QtCRRw1NKlCf4j7w7miuyoFC8tRrX2a8siAfScn6OmRFcDtGU5L/n2wu+vR9a2mQLhCZox2UMNGwgphnIemfz1gepFGoKKpIBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=De8yOqZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649BAC4CED2;
	Wed, 11 Dec 2024 03:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733888653;
	bh=97Q9KZPqtfr3u6MHwjc600BHQ9UHmgQQX4d8wB3oYIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=De8yOqZtNLM3PkoX8NYyt4N7fB7i8wlpXEVCXyLQRz2ebgIYLHrw8h28y81u8jeGB
	 mNOCiOHhnA5lf41SzQI+gc4QJR4HcGW+lFYMOouJa37pyMiELGNlhh2LViR3ocSqZU
	 rYQM3dsOaJT0ujNTiGC7tLftA59RlzrmBnIvUaM8Nd/sHMsi66AB3kEH+ZYbPgc3G2
	 XKPfc7SvB8RDUhPXENs3QpkcXbvosEXJsZOcnf/Vd41TygTrJGEaeIfX5CqE9ANx1R
	 XSZCVSp3LZrl0BnzKOPS+dy5cCBh8MW5U0iyF7+FJ9kCx0rcKbQu/oZxOmx2zp7qPA
	 ROnaA/l4YifRw==
Date: Tue, 10 Dec 2024 19:44:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>, Kaiyuan
 Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v3 3/5] page_pool: Set `dma_sync` to false for
 devmem memory provider
Message-ID: <20241210194411.5c0a98ad@kernel.org>
In-Reply-To: <20241209172308.1212819-4-almasrymina@google.com>
References: <20241209172308.1212819-1-almasrymina@google.com>
	<20241209172308.1212819-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 17:23:06 +0000 Mina Almasry wrote:
> +	/* dma-buf dma addresses should not be used with

Sounds a bit scary, maybe let's say:
                                 vvvvvvvvvvvvvvv
	/* dma-buf DMA addresses do not need and should not be used with

? up to you.

