Return-Path: <netdev+bounces-179618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E66A7DD82
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EA318913C5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CDF23BD16;
	Mon,  7 Apr 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPOZneqj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5E022A7EA
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028167; cv=none; b=b+1ooPYJVneZw8gyGuehmmoxr5Irh7nehPtIqmVXw5t4Ki2ZEw5boL4bJyq2Jd5xz6S8vcjVCo0F0+TigXQKskJGu18lzmnvAzKb52Z8vXhmrig3UrxwwxLxjZwWSp2eVuV2FIsdNxkukie+/YiKU8XHQ3fX0flCxdPXQ6FpHDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028167; c=relaxed/simple;
	bh=h/Yfjz6YoSOb1yR78KwBldNpn4OmHvYMvB6/iKoIxWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SinLxYYDkmvXTpkaknJGDkwJJJyRvvbyfjSGuo9Vy4yKlW1orAnnRC1Qwn5A8bVboe2+5cHZiHYf/z6LYIhsKBVTGK5ObmGZbhKOpRjTqjfzZp40gUKQE/EYLIMPLDuaUypSP4YQZ7mqBP+yRzfUC9U0aiw6BtbIOmvBeb7MdDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPOZneqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5ACCC4CEE7;
	Mon,  7 Apr 2025 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028167;
	bh=h/Yfjz6YoSOb1yR78KwBldNpn4OmHvYMvB6/iKoIxWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OPOZneqjRDdEC4/DJxFmNzHSzlfSr+8wnvqBNal4bFb0hFx195qGke5hgzFQAVod/
	 e2ZuzP0Jgw9trZGgbjFT8MctEj6c083H4KFYbNjwqZcYIOBfVM4oAJ7AGUjnHUyaPt
	 6Jfxx3/gYNnP8957WYoc/M70//mGUzdF2kMFrPRezriiP5uxKfaVnzfcqciG+cIkmW
	 5yv9U7cztDZQzJqU2o7tCXF1byW+ZG5DwS8hpYhht0dSUqAhj4Z4RKEoWHkFHEUZ4s
	 WpG2dJE4mt3yspAyAN15YXdAjlb14rAZIhZ0txKcmh2XPEcUDbJbUKI0SMr8GLbaFA
	 8KdrGjd5zrQdw==
Date: Mon, 7 Apr 2025 13:16:03 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	victor@mojatatu.com, Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: Re: [Patch net v2 06/11] codel: remove sch->q.qlen check before
 qdisc_tree_reduce_backlog()
Message-ID: <20250407121603.GH395307@horms.kernel.org>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403211636.166257-1-xiyou.wangcong@gmail.com>

On Thu, Apr 03, 2025 at 02:16:31PM -0700, Cong Wang wrote:
> After making all ->qlen_notify() callbacks idempotent, now it is safe to
> remove the check of qlen!=0 from both fq_codel_dequeue() and
> codel_qdisc_dequeue().
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


