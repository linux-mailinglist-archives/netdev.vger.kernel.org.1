Return-Path: <netdev+bounces-61340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74782375E
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC583288ACB
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31541DA2E;
	Wed,  3 Jan 2024 21:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQwMt7hu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE21DA28
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 21:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0904C433C7;
	Wed,  3 Jan 2024 21:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704319084;
	bh=7evY+Thk8UVxoNHyanWJrPDweTbRIRw+mgXt5AHtm8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZQwMt7huBv06cAhF2TyE8QHYuJa28TDZt4VUt15DgtGoN/DMoxf81uAVke5lOHp3V
	 exjFz+Z8We6faTqI6yUkCGOEeb59NfZ9Ef1sMyPNEZMtwdBOBJz5Y8KolgrmCv5g/0
	 ELErgWuebKOWO3Zl0pAyODYIcFXTmFdGWeyd5359eKMkU+mZSFqM+qrpn0FYzDoGNJ
	 GbTGLGnSv4sGajvIwvjoGa8LMA1eVaPr3XU5Lqo2ec7kcVQ+/XJvUjUluet8LPj+Sn
	 yVMBK4JluBkQ3u3vkLsaH4/2J7yCBQQB3J+6BeXY1cHXhERf/tZ2lBQ076UgB1DMqU
	 y5+8BIS4qFqTw==
Date: Wed, 3 Jan 2024 13:58:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] virtio_net: fix missing dma unmap for resize
Message-ID: <20240103135803.24dddfe9@kernel.org>
In-Reply-To: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
References: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 17:43:33 +0800 Xuan Zhuo wrote:
> For rq, we have three cases getting buffers from virtio core:
> 
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
> 
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
> 
> That will leak some memory, because I did not release the pages referred
> by the unused buffers.
> 
> If we do such script, we will make the system OOM.
> 
>     while true
>     do
>             ethtool -G ens4 rx 128
>             ethtool -G ens4 rx 256
>             free -m
>     done
> 
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Michael, Jason, looks good? Worth pushing it to v6.7?

