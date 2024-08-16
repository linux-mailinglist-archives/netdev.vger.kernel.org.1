Return-Path: <netdev+bounces-119058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEDC953F27
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6C528299D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08929D06;
	Fri, 16 Aug 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="de4Xg+jK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687429CFE;
	Fri, 16 Aug 2024 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723773295; cv=none; b=UkwKebVLnqA4kYr/4QcNrcKQBpitjpaa73ocfNFURPpvFYsOGgfLcRu9A3H4IYcVh7DJRx2XOr0dSfOmi7Z6SirYrP7fAVXyKuUsajgrONvvwMV1fK2hhJin6JusK0eXVqmn/qAG4wxrr1hQNEi3h1U/EopW+ycGISVHTkpb9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723773295; c=relaxed/simple;
	bh=85OslUvDlZYNElnxXbO39jZzvIIMRhCg/1UC+cEB+Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BDyifyw/oW9/8YucaA3xuhBZkuCyO3NufkzZooeH2JRJTDFYiWOocNVRcXdihsLLYnd2C5OWfc4kXexLCYuONFpUQMxzbaj6pzs+5tikxWvN51GXbRsrgTZWN5A89QgLdfvMS1CsAraSucnkEc4ZiqKKLOcC0uvJihJFtm2zNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=de4Xg+jK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF14C32786;
	Fri, 16 Aug 2024 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723773294;
	bh=85OslUvDlZYNElnxXbO39jZzvIIMRhCg/1UC+cEB+Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=de4Xg+jKWbP51DbAJRjkamTYKaLdzN8P+jbvjjvd19R7CxcV605YIYM11uWkRMqto
	 WorSHr+7zAUU25t70+eTj0szmhlgnzYHN3C5qvQlxz2GlDck8uuERwJ0tFqMoEdc6f
	 Hzpc6lse+FT8Btwm0DLadgYQY67pCsgaam7D0z57MdaXNhlkyb/js+x53pgLRaA3dM
	 a6S11rJDxwrDGXuLbk5cJsOhhSJrRRNZe9pmIYYocw2kkl4XSEKIPy9LsjsIVWdfPn
	 1n+96d4juz8T+ZLBSQ0Luip0d4m0LZsIrbQKVNL+Be+jRpXCtkWmpflhhCau4R0UNy
	 OjrjdSBOVX9Dg==
Date: Thu, 15 Aug 2024 18:54:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <jdamato@fastly.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v27 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240815185452.3df3eea9@kernel.org>
In-Reply-To: <20240812063539.575865-8-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-8-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 14:35:33 +0800 Justin Lai wrote:
> +	if (!delta && workdone)
> +		netdev_info(dev, "no Rx buffer allocated\n");
> +
> +	ring->dirty_idx += delta;
> +
> +	if ((ring->dirty_idx + RTASE_NUM_DESC) == ring->cur_idx)
> +		netdev_emerg(dev, "Rx buffers exhausted\n");

Memory allocation failures happen, we shouldn't risk spamming the logs.
I mean these two messages and the one in rtase_alloc_rx_data_buf(),
the should be removed.

There is a alloc_fail statistic defined in include/net/netdev_queues.h
that's the correct way to report buffer allocation failures.
And you should have a periodic service task / work which checks for
buffers being exhausted, and if they are schedule NAPI so that it tries
to allocate.

