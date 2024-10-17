Return-Path: <netdev+bounces-136598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18A59A245F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF3A288184
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB321DE4DF;
	Thu, 17 Oct 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyXPz12O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F901DE4C2;
	Thu, 17 Oct 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173291; cv=none; b=El+aZdhwNOHpF2bl9snop/40k751f1XEUbiPrbr3sIWODm9pgkiNSW70PMRaI8927rwKNWYYQ23Vf7O9+85TJ9UDh3yN1sH6/cPzi1iLXdiYFUWoj3hVBnTjXdIk1w0GJMxZVgykC7ojSPXxxxcXZb3JMdanHghqQPA6XJNmX2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173291; c=relaxed/simple;
	bh=NGi2A8ULkjuZ6zgbxNmU56QYzHdzG396TXsDqS0rEOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbD+sJhwUGK19pGfXgW2GCb0OSQbgz3JTLW7Lb8B2Uo0FYJIQw2S+dQqqcT477qAbNa1Ytaj5vYOYb1xztLkA1JqcKymMqjwpExqOjDXhp1IQ+C26+XFKuq8U7pKcE7fZVPKjZRMfe3Uk5BIGhbqGSC9ARAybItNSSD61ueaxe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyXPz12O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DC7C4CEC3;
	Thu, 17 Oct 2024 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729173291;
	bh=NGi2A8ULkjuZ6zgbxNmU56QYzHdzG396TXsDqS0rEOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyXPz12OU9VQIuhJdzyo3o6ysFRCK68WcHY1Qx17vCnMn0R6NtnCTN1UF/4zXnKvB
	 wrZ5HTWh3kB6F2S3QUS+iEAyQCzt7AoB72UT3+zocArUhOTGLH9Ik7voyxpW697v3m
	 MQJfBglXVXnax9HLtZbUxL/usERXCUJyoXXI0UaAehcQ6k1MHmczf7OVrsYMx+bB56
	 Ogqy/3nJ9orJJwPLMO28adKgcbZ6mUwRrekz0oXvWNUmtFF47mBmm0sC3X9BEmdsLy
	 jR5fl4EEZK5tJ49l2p7vJDdPBdlkXXH9cSe/dp86IHXCtf0/sBewveelIFs+oXTOuU
	 xOvvlB4QAYbOA==
Date: Thu, 17 Oct 2024 14:54:17 +0100
From: Simon Horman <horms@kernel.org>
To: Wang Hai <wanghai38@huawei.com>
Cc: justin.chen@broadcom.com, florian.fainelli@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, zhangxiaoxu5@huawei.com,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] net: bcmasp: fix potential memory leak in
 bcmasp_xmit()
Message-ID: <20241017135417.GM1697@kernel.org>
References: <20241015143424.71543-1-wanghai38@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015143424.71543-1-wanghai38@huawei.com>

On Tue, Oct 15, 2024 at 10:34:24PM +0800, Wang Hai wrote:
> The bcmasp_xmit() returns NETDEV_TX_OK without freeing skb
> in case of mapping fails, add dev_consume_skb_any() to fix it.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

There seems to be some confusion over in the thread for v1 of this patchset.
Perhaps relating to several similar patches being in-flight at the same
time.

1. Changes were requested by Florian
2. Jakub confirmed this concern
3. Florian Acked v1 patch
4. The bot sent a notificaiton that v1 had been applied

But v1 is not in net-next.
And I assume that 3 was intended for v2.

From my point of view v2 addresses the concerns raised by Florian wrt v1.
And, moreover, I agree this fix is correct.

Reviewed-by: Simon Horman <horms@kernel.org>

v2 is marked as Changes Requested in patchwork.
But I suspect that is due to confusion around v1 as summarised above.
So I am (hopefully) moving it back to Under Review.

-- 
pw-bot: under-review

...

