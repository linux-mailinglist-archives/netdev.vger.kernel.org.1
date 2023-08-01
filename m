Return-Path: <netdev+bounces-23081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77976AAC6
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B92817EC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349D11ED2E;
	Tue,  1 Aug 2023 08:21:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7458C1EA9A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AFFC433C8;
	Tue,  1 Aug 2023 08:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1690878076;
	bh=SdSpzQrfWhfHyrXQhEcCm9xTj2Z7bwVFrrUBGSfQ6jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h44OEA5UrUyZLkbqP0xodxVwaBmCmf+8GcZO402BbcusWHfvdSiqb8Krd8BncNsrS
	 dOfNuPvvR9TJOOl2qIqa6e5GaZkz7iUFi/V8f7CabPalqmVeVhuTJ8jUquY7d7htAy
	 N3s0MSMa5h9+N/p8XYF9LlTZCgKutfsIQfiJQAzM=
Date: Tue, 1 Aug 2023 10:21:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org, M A Ramdhan <ramdhan@starlabs.sg>,
	sashal@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, hailmo@amazon.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4.19] net/sched: cls_fw: Fix improper refcount update
 leads to use-after-free
Message-ID: <2023080159-status-barracuda-99dd@gregkh>
References: <20230727174629.55740-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727174629.55740-1-sj@kernel.org>

On Thu, Jul 27, 2023 at 05:46:28PM +0000, SeongJae Park wrote:
> From: M A Ramdhan <ramdhan@starlabs.sg>
> 
> [ Upstream commit 0323bce598eea038714f941ce2b22541c46d488f ]
> 
> In the event of a failure in tcf_change_indev(), fw_set_parms() will
> immediately return an error after incrementing or decrementing
> reference counter in tcf_bind_filter().  If attacker can control
> reference counter to zero and make reference freed, leading to
> use after free.
> 
> In order to prevent this, move the point of possible failure above the
> point where the TC_FW_CLASSID is handled.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: M A Ramdhan <ramdhan@starlabs.sg>
> Signed-off-by: M A Ramdhan <ramdhan@starlabs.sg>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
> Message-ID: <20230705161530.52003-1-ramdhan@starlabs.sg>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  net/sched/cls_fw.c | 10 +++++-----

Both now queued up, thanks.

greg k-h

