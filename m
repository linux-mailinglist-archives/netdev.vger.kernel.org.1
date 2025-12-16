Return-Path: <netdev+bounces-244973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C89CC4546
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90AE530007B8
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD622C1786;
	Tue, 16 Dec 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ3LAgl1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88F02C0F93;
	Tue, 16 Dec 2025 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902953; cv=none; b=UHz9hZQfZWiUS4mXguZiHEjSi1oBYi0hLa5ReySPYObnTzf94yNasahD7NuEfcKpaGwzSbufRd8O9iohYkPwyJEenA0jX88T1095799KaiVsrtG7VwAziiiZbQvGR+19ILOEzywP3I5MOExwOr4PpSJhHZAAqvpU0kHgU+su5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902953; c=relaxed/simple;
	bh=j/B+stqcq8Efl0Q33Cl4TMLebNAGeqQ/75cVbr8SGOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFB4uAPmVKqFr4vhW1Q/6SbWUXErAJXkD0g4hTjmndkQXkBEGBnlCrsVoNzjMKn1GJ4meVbdl83eugCWDKshoSvIbzLive6gEw8VKGZShngAfdzHfvnYfXZiuAr/IKhvWhVARmWSiEUcrQATQKYFRjCCy+orhFWBjBP5E0pO1TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ3LAgl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F78C4CEF1;
	Tue, 16 Dec 2025 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902952;
	bh=j/B+stqcq8Efl0Q33Cl4TMLebNAGeqQ/75cVbr8SGOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJ3LAgl1F7cfEt4JDOlIyOPwSm/JvsCBGZLRn7vQqH6nrCA/J6bifjoeL/NQyek4P
	 YQTDp2FIyP+nuW3zd0gqNPtnL/BMPHOUZkfS773j67sXSbuUg6rlDwocUFz1FResC8
	 IlwCalVv0EhQgqhLKqV4IQvO39VjmT7JRNfaeYHqILiCa74+4zr52PLCiFoPgNhqYc
	 hNjigyQ2pdsQjWwxzp6nH/VzuqIFOGOQh44kxifzbiAFsTVwiIpHRlB319xM5wWSmx
	 iAudNl9U5YP+hwUJALpilpyLEh7oHDGDO5G594BTtW3T1w+6DkwqobP6yPMlzlC67k
	 Zo/eCfNI683eQ==
Date: Tue, 16 Dec 2025 08:35:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Bauer <mail@david-bauer.net>, James Chapman
 <jchapman@katalix.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next v8] l2tp: fix double dst_release() on
 sk_dst_cache race
Message-ID: <20251216083541.70fb3b54@kernel.org>
In-Reply-To: <20251215145537.5085-1-m.lobanov@rosa.ru>
References: <20251215145537.5085-1-m.lobanov@rosa.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 17:55:33 +0300 Mikhail Lobanov wrote:
> A reproducible rcuref - imbalanced put() warning is observed under
> IPv6 L2TP (pppol2tp) traffic with blackhole routes, indicating an
> imbalance in dst reference counting for routes cached in
> sk->sk_dst_cache and pointing to a subtle lifetime/synchronization
> issue between the helpers that validate and drop cached dst entries.

This seems to be causing a leak:

unreferenced object 0xffff888017774e40 (size 64):
  comm "ip", pid 3486, jiffies 4298584595
  hex dump (first 32 bytes):
    10 00 00 00 e9 01 00 00 01 00 00 00 00 00 00 00  ................
    ff ff ff ff 00 00 00 00 48 4e 77 17 80 88 ff ff  ........HNw.....
  backtrace (crc b523287):
    __kmalloc_node_noprof+0x579/0x8c0
    crypto_alloc_tfmmem.isra.0+0x2e/0xf0
    crypto_create_tfm_node+0x81/0x2e0
    crypto_spawn_tfm2+0x4e/0x80
    crypto_rfc4106_init_tfm+0x41/0x190
    crypto_create_tfm_node+0x108/0x2e0
    crypto_spawn_tfm2+0x4e/0x80
    aead_init_geniv+0x14c/0x2a0
    crypto_create_tfm_node+0x108/0x2e0
    crypto_alloc_tfm_node+0xe0/0x1d0
    esp_init_aead.constprop.0+0xe4/0x340
    esp_init_state+0x83/0x4c0
    __xfrm_init_state+0x6f2/0x13d0
    xfrm_state_construct+0x1455/0x2480 [xfrm_user]
    xfrm_add_sa+0x137/0x3c0 [xfrm_user]
    xfrm_user_rcv_msg+0x502/0x920 [xfrm_user]

