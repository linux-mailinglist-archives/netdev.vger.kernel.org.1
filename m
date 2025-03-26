Return-Path: <netdev+bounces-177719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096AA71609
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594A21894ABE
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42F21C7015;
	Wed, 26 Mar 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crbU+3DR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949AB1A5BB2;
	Wed, 26 Mar 2025 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989637; cv=none; b=R2m3G5pyvC3KJ8sMokRjpinFdrCQSb34eeKuBFUcZp6/Fqw3TjqEfnmZZUzwciDyNccd/6EYKaLnvP3LEixDCu7aV1BfruT0U9fEml+APgJ1/SQdXDK9HK6Ny3Tz8TxqyKf3qYHabC3GEOLFRK20T/f78N0rqkb1WcqtnIsjb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989637; c=relaxed/simple;
	bh=rClQpO1VRgNQPQsQ9p9QTwr5wQ/XGwxgDzc7bxprHFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APeYQSt1fkwPAZhGUCamWlblqdWcnTO4rf44c58CzHWcp1qWBcWYJP5gCuCu75U+9KcxjitTsHdYWTtpp+DY4cRl5YW8XtJ+DvjmL51niFuwjAomT1sCBRRG568gsLMc4w7HepB8BII1dgEXox8gXh7ElmVwFHhbj9ajs0JmmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crbU+3DR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3475C4CEE2;
	Wed, 26 Mar 2025 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989637;
	bh=rClQpO1VRgNQPQsQ9p9QTwr5wQ/XGwxgDzc7bxprHFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crbU+3DRCaOGuaBmsfvzesmYbupMrCT/cmk1/q/jSE/v/4Ef/YX4Y+SOFLFX4UeiG
	 1AupXC8PssF50O5qI6CwfD1PKqOpQC1Fe1cUCxH2cm64dSdhAzSpAKH6T9aNmDU+nc
	 Wv0xR7vjEAYgOcX8hx4wPYtfr0UcpPTQ/k0bXTRmB3C73bkzX8WjIE0ncIZeML3puK
	 T7pP/et2Codf5e8hbOON9Yqa6vJIHvKdpwYROPSFvNZdnFRVjRgiGRuoTmN+M0SzKX
	 Ba8PIi3Zilr7z5Zqev7HVUinUh48Tf8Okm1L/yVjptfshQE6Klnu9nSBKxvd/tkHO4
	 YhIpXcS4xM8Qg==
Date: Wed, 26 Mar 2025 04:47:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <cong.wang@bytedance.com>,
 <kuniyu@amazon.com>, <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] ipv6: sit: fix skb_under_panic with overflowed
 needed_headroom
Message-ID: <20250326044715.6d071be3@kernel.org>
In-Reply-To: <20250325095449.2594874-1-wangliang74@huawei.com>
References: <20250325095449.2594874-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 17:54:49 +0800 Wang Liang wrote:
> When create ipip6 tunnel, if tunnel->parms.link is assigned to the previous
> created tunnel device, the dev->needed_headroom will increase based on the
> previous one.

Sorry for the inconvenience but could you repost this patch?
Our CI was broken when you posted and we currently don't have
a way to re-trigger it :(
-- 
pw-bot: defer

