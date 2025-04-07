Return-Path: <netdev+bounces-179802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD9FA7E884
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ADC3BAB70
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2A217F55;
	Mon,  7 Apr 2025 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrDoUfSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CD4216E1B
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047194; cv=none; b=k7gTeIRtNu8ZAjB4d2uoNgJJXaUA6qyN+ZPDK+bIIPRHl8oYep8chIWTvhqKPn8aVcuTVz1gp+H9sWBPZz2LAC8FUlI04Gx+awuZzkwjGVrndcUGoSs4xZ549xIdIgiQcT2APrLLLhaLdVeAClT9TUcuz1154Bg88s/45aaNw0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047194; c=relaxed/simple;
	bh=fZ/DXxfx/8LGBizu/81ytPfWP1YU2wPcDDi7cJT3AdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiCod5ayajduNVMe8Qps9895GeRmnWwD+GxsjAp0Q4ZgsrcqdSierjvWe5ciNBPkyyN29Srf+a4CMzIzkWqR1EDYqNIMBlakhviPQvUjSkSwlSE97WqZjQ+g2AsNUKXL7E/Ekg1WoK/kZ89/DzaUwcDKFnDDzSeEYdiUbAjuwVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrDoUfSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F4C4CEDD;
	Mon,  7 Apr 2025 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047193;
	bh=fZ/DXxfx/8LGBizu/81ytPfWP1YU2wPcDDi7cJT3AdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hrDoUfSaJRXlDPYj4hzDpN9kM+xF0TWG2yMV4a+VHnGrJ9Y6axFasHGZpkoAu37G5
	 LwNhysodH16urP/KIyE3KfLLMye6hEktzwoAY5JrwODn1EPKN1csdtmkqYkN3jyn5w
	 bTglWrpVAqFAfYQcdhevZhwt9HAn2zoIVysBUyk3r9qTFYQVflvk/tqzsVjetz+0ml
	 3w4NVHZRk2px8NJqbdxK/9bRY7Uj+OElYdqBFJMj/jxQ7JCueYM7vCNNVhJCR7/wiQ
	 BuwoSpdPLszuSci/T1DbRqNCDWFkOg8i1xWUlOMxc5wBgDMNGyHT75rDv30vHDUcPg
	 OQufgcvQzjvYQ==
Date: Mon, 7 Apr 2025 10:33:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 jiawenwu@trustnetic.com, mengyuanlou@net-swift.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jdamato@fastly.com, duanqiangwen@net-swift.com,
 dlemoal@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: libwx: handle page_pool_dev_alloc_pages error
Message-ID: <20250407103312.745986db@kernel.org>
In-Reply-To: <CALGdzurKz4D3tzbjY-_xES6VUzzg8E2ALmj3mgiFT=4yX=_aCw@mail.gmail.com>
References: <20250406192351.3850007-1-chenyuan0y@gmail.com>
	<Z/NjXSRVFp9c/XmQ@mev-dev.igk.intel.com>
	<CALGdzurKz4D3tzbjY-_xES6VUzzg8E2ALmj3mgiFT=4yX=_aCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 09:43:56 -0500 Chenyuan Yang wrote:
> Hi Michal,
> 
> Thank you for your reply and suggestions.
> Would you like me to send a new patch (for example, [Patch v2]) with
> the "Fix" tag included?

Yes, and please don't top post.
-- 
pw-bot: cr

