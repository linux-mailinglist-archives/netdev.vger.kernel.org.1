Return-Path: <netdev+bounces-193814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3FAC5F2D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBDB23B2234
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 02:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A872C1A2;
	Wed, 28 May 2025 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGZ7Xljy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5398FC0E;
	Wed, 28 May 2025 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748398633; cv=none; b=F66fLYROTBlMj3Gorq+uowqVsroxqwxBqhhVJ7+MjuuwNnRorGH37ClropDvA9KS4mcbdn+cpc52K4zlSHKKykgEsInhyqB/WUUBCsDNhTh/TwTz6LCEOcVyUoTTVFIAYPcFuNuGhKcyvQsNjrF4Sb6BJ092CTAfN5JEfYrdrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748398633; c=relaxed/simple;
	bh=10/gph/i/RNgm1Fvfr7G66Z0UHy6P3vtGDz3OjATGEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLKpv92mfvKoVKQtEOE2r8GPcHc98A1wEPmsLTS6yyOnb2BMsq/F8XIp0cJSfrpuJbb+AaPvWuCzrY9LCQKNe5EmdYcYsQN8BR7oED/6Fqq2HYgzBLOhf/WQSdreq0WU0AlW416mSi1hJnvluM4fm93wqRSL5NsOPwFwyJGM2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGZ7Xljy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB280C4CEE9;
	Wed, 28 May 2025 02:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748398632;
	bh=10/gph/i/RNgm1Fvfr7G66Z0UHy6P3vtGDz3OjATGEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FGZ7Xljy79p2hvIMPpIW2ozU7Rmym9T3nOqDXggxn2ukqooddtM3Nf2yNZJ7zFYru
	 gZy4qLnwZvOCRTQbH6noo4dtaNWMhBCretzGjUexpmaQfmSlLGZPEow0ZRn74XbAUZ
	 5cfyue5ekNTTJgHUqDbpGqIF6x0rwYeethfWkp0e18xb9YHXHM27083+tfRo0dk068
	 85Wf17YQr+nQYrcjGzAM4J/uK51vlaqnEIccLd8YSmocmL+MaFssktUYQa8UaSLyMu
	 tTNGNSDmyEcoyW4/lqXt8yPh8wEFFlUyS/CVcJ3Fw/vKoR0ySOle2NlJHS+BltPgmN
	 2XIwocYfD2TVw==
Date: Tue, 27 May 2025 19:17:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <jiang.kun2@zte.com.cn>
Cc: <edumazet@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
 <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>, <fan.yu9@zte.com.cn>,
 <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>, <qiu.yutan@zte.com.cn>,
 <zhang.yunkai@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH net-next v2] net: arp: use kfree_skb_reason() in
 arp_rcv()
Message-ID: <20250527191710.7d94a61c@kernel.org>
In-Reply-To: <20250527185736038u-6EtRPVin2ftxbrp-C4w@zte.com.cn>
References: <20250527185736038u-6EtRPVin2ftxbrp-C4w@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 18:57:36 +0800 (CST) jiang.kun2@zte.com.cn wrote:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Replace kfree_skb() with kfree_skb_reason() in arp_rcv().

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.

Please repost when net-next reopens after June 9th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


