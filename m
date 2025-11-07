Return-Path: <netdev+bounces-236576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60066C3E0F1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A803A73E5
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CED2DF140;
	Fri,  7 Nov 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syt4MBuT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4548361FCE;
	Fri,  7 Nov 2025 00:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477054; cv=none; b=VDklBT95OmDKP3dA0DcH4r5LUdraJvj0rCYXBX6ZTAkpZxpUO/lOXXAPiNoYLL/p0zZMg2DA0TJBWDi6zVNSoG96MBarQf9Yz/kLJqw5S/Srf+8Zpgu6ew+EZl31FBhjxKHxA6tbeusG1QaL0Afaq4y01ra1WXoKdPby4Q3Ay7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477054; c=relaxed/simple;
	bh=+HNsLXJ/tO6B0e84iu9sD/tN/wykl6Kgdq5YXLsIuBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8Mp0HR9Eh9jhSGDzMBbQKR9TXa+aw4BYmDaNnc8zeyLjeKwwAiK6r4KzWJw7MCVKSocrbwNCxtUBGf0it/WRpP4WjH2IRz6R7bvYDiQyBL0OCW7VkYfLmWbFerOoaFOOyEyLm1voLf5D21SvkMLWXBurSC3ACbjWqAInYgjaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syt4MBuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB8C4AF09;
	Fri,  7 Nov 2025 00:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762477054;
	bh=+HNsLXJ/tO6B0e84iu9sD/tN/wykl6Kgdq5YXLsIuBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=syt4MBuTR69E/hMTxgvO86jwnQg0bXv+oygHb0D4sAfayztR8x5XpZEkO2ecr5s01
	 Px7aSTv7mGPaLruLLuzmzYVAKY64l9PFPb6gWch2Q7AgWD/g/rdIdc9xxndEzzYgaE
	 FsCaGz5bCEWQCkgT1pwlTmoDqobtVI5V7IM46rsATnDTOvtn2rWePziXv9pW+PYXvB
	 LBR8aUVCeUXy7w2SBrvt/KLLc0dVrNqhtoXH6+TCNumn/PT51EPa8i2EgALEyteEcC
	 6UMxYoeeJOqcOC/1W9TjN7fg8gnOTdQrDFIhTRLB2ppAOrrCKL5hSOhcU9Jb4tD/fl
	 phvP/tg7+TN2A==
Date: Thu, 6 Nov 2025 16:57:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, alexanderduyck@fb.com, chuck.lever@oracle.com,
 linyunsheng@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 syzbot+4b8a1e4690e64b018227@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: core: Initialize new header to zero in
 pskb_expand_head
Message-ID: <20251106165732.6ea6bd87@kernel.org>
In-Reply-To: <20251106192423.412977-1-activprithvi@gmail.com>
References: <20251106192423.412977-1-activprithvi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Nov 2025 00:54:23 +0530 Prithvi Tambewagh wrote:
> KMSAN reports uninitialized value in can_receive(). The crash trace shows
> the uninitialized value was created in pskb_expand_head(). This function
> expands header of a socket buffer using kmalloc_reserve() which doesn't
> zero-initialize the memory. When old packet data is copied to the new
> buffer at an offset of data+nhead, new header area (first nhead bytes of
> the new buffer) are left uninitialized. This is fixed by using memset()
> to zero-initialize this header of the new buffer.

It's caller's responsibility to initialize the skb data, please leave
the core alone..

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6841e61a6bd0..3486271260ac 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2282,6 +2282,8 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>  	 */
>  	memcpy(data + nhead, skb->head, skb_tail_pointer(skb) - skb->head);
>  
> +	memset(data, 0, size);

We just copied the data in there, and now you're zeroing it.

>  	memcpy((struct skb_shared_info *)(data + size),
-- 
pw-bot: cr

