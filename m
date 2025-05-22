Return-Path: <netdev+bounces-192768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC173AC1167
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD767A227AE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52061299926;
	Thu, 22 May 2025 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRKBwT+C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832C18C932;
	Thu, 22 May 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932596; cv=none; b=bManV6Lw2h0oD/wORAmzxklVQhefw3pn1S4mUHVsBqqSRnKSDcZzSsMAvSyHG5YYDOaNmQZvpGlinBhZ4ADoE3AXC1L+UnzQxtV1lR7dfW23BXDdz4BzVaTxkQbzguuq6GLrmoQWzYO0MIRSm5+bBt0mkNkmKOV5viBwGz3JvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932596; c=relaxed/simple;
	bh=uSsuvsWmK9ORuTQBOXLOaS8S9bzS1b6Hm6DJ88zHHzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaOHbJP2KJ/N1fSYjIMG40MKR30fk8Htq//zfNEqUSmMDoXsSCYdfLswhUKlqhBul5qMRm5YM2QKdrqmceMBEJmJMTyBPXYnB8GUTAxJ4Vm4dEy8ocvvQvunoVebKBUbSsdArZhE7I3TfSL6Hp7QNWt6U/5HrI85sYofTsUlh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRKBwT+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33FC5C4CEE4;
	Thu, 22 May 2025 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747932595;
	bh=uSsuvsWmK9ORuTQBOXLOaS8S9bzS1b6Hm6DJ88zHHzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gRKBwT+CdogkwLafnrr3J6BYgTdzfnjj+TjiJyNl/22BlxoEtjWRO1Av7IbO9mB+D
	 nitVbkyeqeqgSORzDTdVCnDyO+E1XDVledNnosQIi4N4cawHKDxOy9nPZ32eErunwk
	 oXd+MgpMqiko4i9CyK4mjYz2Dh4iNuDI08NFlis0UsBn3qXHsIHlt7YlOx8bxDmM9U
	 nSO9es6arfRTGpvCWPXRw/BNlL5/Fd5F8Y/ij+a/2fCRXJJQqYZjb1jyumfBZceX/7
	 n+E9BBaOKUYNsqTiND6Z2kz4GKWnirICmH5FDy+6Dn4fHncRxwHv/Hf3gtOF9fJzfI
	 24v7BWmc9BsEA==
Date: Thu, 22 May 2025 09:49:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: <willemdebruijin.kernel@gmail.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <matthias.bgg@gmail.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <lena.wang@mediatek.com>
Subject: Re: [PATCH] net: fix udp gso skb_segment after pull from frag_list
Message-ID: <20250522094954.2f8090ce@kernel.org>
In-Reply-To: <20250522031835.4395-1-shiming.cheng@mediatek.com>
References: <20250522031835.4395-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 May 2025 11:18:04 +0800 Shiming Cheng wrote:
>     Detect invalid geometry due to pull from frag_list, and pass to
>     regular skb_segment. if only part of the fraglist payload is pulled
>     into head_skb, When splitting packets in the skb_segment function,
>     it will always cause exception as below.
> 
>     Valid SKB_GSO_FRAGLIST skbs
>     - consist of two or more segments
>     - the head_skb holds the protocol headers plus first gso_size
>     - one or more frag_list skbs hold exactly one segment
>     - all but the last must be gso_size
> 
>     Optional datapath hooks such as NAT and BPF (bpf_skb_pull_data) can
>     modify fraglist skbs, breaking these invariants.
> 
>     In extreme cases they pull one part of data into skb linear. For UDP,
>     this  causes three payloads with lengths of (11,11,10) bytes were
>     pulled tail to become (12,10,10) bytes.
> 
>     When splitting packets in the skb_segment function, the first two
>     packets of (11,11) bytes are split using skb_copy_bits. But when
>     the last packet of 10 bytes is split, because hsize becomes nagative,
>     it enters the skb_clone process instead of continuing to use
>     skb_copy_bits. In fact, the data for skb_clone has already been
>     copied into the second packet.
> 
>     when hsize < 0,  the payload of the fraglist has already been copied
>     (with skb_copy_bits), so there is no need to enter skb_clone to
>     process this packet. Instead, continue using skb_copy_bits to process
>     the next packet.

nit: please un-indent the text, you can keep the stack trace indented
but the commit message explanation should not be. And if you can
run the stack trace thru decode_stacktrace to add source code
references.

This patch seems to be causing regressions for SCTP, see:
https://lore.kernel.org/all/aC82JEehNShMjW8-@strlen.de/
If you send a v2 please make sure you add test cases to
net/core/net_test.c for both the geometry you're trying to fix,
and the geometry you got wrong in v1.

