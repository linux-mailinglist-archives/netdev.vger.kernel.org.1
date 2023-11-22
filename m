Return-Path: <netdev+bounces-50156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5077F4BC7
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6839280FD1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE1F4C3A4;
	Wed, 22 Nov 2023 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZtVa17n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630B156B74
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8403EC433C8;
	Wed, 22 Nov 2023 16:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700668844;
	bh=ZPZXQ5avVgm1XAP+0BjWQPnB7LJ4UKtB7r4klOc6QeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JZtVa17nEITXjpIPGevjBvtwZZ/Hkl7BZzgW8vboduFDGcnyWeAr6k4Nd0CWmtruW
	 +ImsNqKMWTXkFj1V1x2zOOY70Qe/keWWo4A8e+xlTkKRJaXXGON2cvbsjf2Wn+ZtOc
	 21zJTwChJyiKhqqWLq0Yo4ruZRMNGqBQpNHb2obOFx8YQ/Yk4gpFeKZSzDz1siJSAF
	 AF0HgisaTOTpue3o0f+GAfq2NjbtoiRl9pQ8+CPchl5Jdc6gTLPMazYBuDPG7ojxNo
	 r/t3LUTl+Wxmzb0I+jN8R4wHr1GieyCQW6BXYEMzG+eRK3yJpr5R23ePo6RUhuw/SG
	 LLAmRgYKW8VDw==
Date: Wed, 22 Nov 2023 08:00:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, almasrymina@google.com, ilias.apalodimas@linaro.org,
 dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Subject: Re: [PATCH net-next v3 07/13] net: page_pool: implement GET in the
 netlink API
Message-ID: <20231122080042.212c054d@kernel.org>
In-Reply-To: <27b172a5-5161-4fe2-90b1-83b83ef3b073@kernel.org>
References: <20231122034420.1158898-1-kuba@kernel.org>
	<20231122034420.1158898-8-kuba@kernel.org>
	<27b172a5-5161-4fe2-90b1-83b83ef3b073@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Nov 2023 15:39:48 +0100 Jesper Dangaard Brouer wrote:
> Can we still somehow list "detached" page_pool's with ifindex==1 
> (LOOPBACK_IFINDEX) ?

Do you mean filter at the kernel level to dump just them? Or whether
they are visible at all?

They are visible, with ifindex attribute absent.

If you mean filtering - I was considering various filters but it seems
like in "production" use we dump all the page pools, anyway. 
The detached ones need to be kept in check, obviously, but the "live"
ones also have to be monitored to make sure they don't eat up too much
memory.

The code we prepared at Meta for when this gets merged logs:
 - sum(inflight-mem), not detached
 - sum(inflight-mem), detached
 - recycling rate (similar calculation to the sample in the last patch)

It may be useful in CLI to dump all detached pools but ad-hoc CLI can
just filter in user space, doesn't have to be super efficient.

