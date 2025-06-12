Return-Path: <netdev+bounces-196757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C796AD6462
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 02:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE873A8F2F
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 00:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99FF8BE8;
	Thu, 12 Jun 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejCqHYl5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53433AC1C
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749687435; cv=none; b=sP6xG/+Y2+YgnD8MgXCEMfmHC5mPYOx4t3hlYNbOQfl5fRAbsuqrRLN0wM90EDR0ctG+wcs6gVtOxEqCI+3AxMgvyHszSjqG0UN9rGf59o4AmXdoKG5WN6hrD3Ucxes/8VHhrb0nCA1jDO6JH533mRCzq64n2i/4LwoxuyD9Zj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749687435; c=relaxed/simple;
	bh=JMFQhB0uffFpA2YrgJR7++VAouSGzHBkzG8xb4fo66Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qexBdDFhtMF1apshX+IBymEmPg61TfHcKFclgMSzT1ievTZUZzl1CfHzbXHkcgpxwfLeaeI0OjMgsJCYoZrVn4nEG4JMj5Y0lWPX1OL9JT19cgWNhNw+3f3TupeRjQuHaOxa+tG64Q0cm9Sja0RPuYvNXcxaRZquyJIM6ZnvRWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejCqHYl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A474CC4CEE3;
	Thu, 12 Jun 2025 00:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749687435;
	bh=JMFQhB0uffFpA2YrgJR7++VAouSGzHBkzG8xb4fo66Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ejCqHYl5ji6PNMw6s/ahy9kt//ZFR0+Ne45RIAf7F93T6XZEMz10xojc/sgZO6Mbk
	 lX+B2M0L2IF5L3gGhLsp/5LwhwTEwv3RfUnXgQVp6evlp71JlHHOBY6xF5nw6OtsrL
	 DZBct2C3sNIz8zeFernFUwNKX+f6p9malH1v43w2FFN4ogRwruX0n9G5rkc6+6PgTA
	 JwojEAtr8TT2cLrpKmqMzTBseqeVB+lfzKDVDFZ9VGCwLITIAR2MaABUwALswqMt1h
	 yQtkLsgEB8FOq+e+TkHBOWH1+A8rqk+xqNGLUjUxO4e/W/v61xysH6bEnc9UA1frO3
	 o9sDCMTzMxIgg==
Date: Wed, 11 Jun 2025 17:17:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <jiang.kun2@zte.com.cn>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
 <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
 <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
 <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH net-next v2] net: arp: use kfree_skb_reason() in
 arp_rcv()
Message-ID: <20250611171713.1614ad32@kernel.org>
In-Reply-To: <20250610164445403aNkwCjYV-MAINIWe0T9JJ@zte.com.cn>
References: <20250610164445403aNkwCjYV-MAINIWe0T9JJ@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 16:44:45 +0800 (CST) jiang.kun2@zte.com.cn wrote:
>  {
>  	const struct arphdr *arp;
> +	enum skb_drop_reason drop_reason;

nit: please reorder these two lines, longer one first
-- 
pw-bot: cr

