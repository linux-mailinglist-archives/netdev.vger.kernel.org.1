Return-Path: <netdev+bounces-159856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF208A17323
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EFF160516
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769E1632F3;
	Mon, 20 Jan 2025 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cq9R58wL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186E76026
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737401521; cv=none; b=ftYZ9Ho35Fd4pw2ri5ktbtB9KJEfRWVJxcs+83Lkwj3U+J87ozcvwsqf8yelAUcf140rJJthyLt3MUjSHIEkbg34WHCn0q7a6Wme5AN9bEioZUSE2zBNrsxzP63rI+nPd1wsQwrYGVwSO8j7ROUKsctLZsMshKqVN5+X+yZMQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737401521; c=relaxed/simple;
	bh=jSA/oaAiw/A5O314aSywKXdtzsB1IxTIyw2Ikv5hcB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kK60wI0p3vsCWqYdpVlUWr2s8uKfDfwP015rn3ju6GIQ9NJHEy+2im34pdDFwmmnvktsUCFMRTWn3A0EsD6aiwI65SpI1pTtUQElXAaqaj4QV9J93hz25atzSDE9P9iVOEn+xrKz/IYgSbh+NdOn9+FHG32bS4daOq0QO6wQBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cq9R58wL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3539AC4CEDD;
	Mon, 20 Jan 2025 19:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737401520;
	bh=jSA/oaAiw/A5O314aSywKXdtzsB1IxTIyw2Ikv5hcB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cq9R58wL4054zRUIBraxd9p/T58w+bm6aaOXHy3zlhR72WdTv6KdKx/SnbIocMf6z
	 QmfMOAd0JsOxinV+Yqz26W7/ZPx1r0VU/ZRRYtp6jrdVg6aaYi7Tf7Lubi6lnMFxsj
	 ABW+cIqMl51p1uYr6ry6Svkv02OhLoq6SalLmDU/a8/OkV8TvTaxvPgx/WAtoYgq7c
	 cgsHa6J609HIfBaK78bUxxRmwb2E6+wqHg0KTxqSKJzsscFUSo9DfUB54H+RjX12Qz
	 EGkH4qRIdDeoGzg7fnCvZ+c682oF6rmNRrZIXtKBKbU769KWjNKaQMxB0CI2xZJdoT
	 2oa/YuS0Zf2Aw==
Date: Mon, 20 Jan 2025 11:31:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/3] enic: Use Page Pool API for receiving
 packets
Message-ID: <20250120113159.7386b5bf@kernel.org>
In-Reply-To: <20250119200018.5522-1-johndale@cisco.com>
References: <20250119200018.5522-1-johndale@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jan 2025 12:00:15 -0800 John Daley wrote:
> Use the Page Pool API for RX. The Page Pool API improves bandwidth and
> CPU overhead by recycling pages instead of allocating new buffers in the
> driver. Also, page pool fragment allocation for smaller MTUs is used
> allow multiple packets to share pages.
> 
> RX code was moved to its own file and some refactoring was done
> beforehand to make the page pool changes more trasparent and to simplify
> the resulting code.

Sorry to say, we already closed net-next for the 6.14 merge window:
https://lore.kernel.org/r/20250117182059.7ce1196f@kernel.org/

You'll have to repost in 2 weeks.

