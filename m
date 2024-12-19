Return-Path: <netdev+bounces-153391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C886A9F7D3B
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F85188EF8E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F0224AFC;
	Thu, 19 Dec 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Du7IDZKR"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86417C;
	Thu, 19 Dec 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734619009; cv=none; b=jbvZ73sQpGQ14Q1n+o65bvNfgM1hLpd6V+0X7lgBFeoPoIZVVoumZg9vsZ6Ka5b7ZqYUJI5An01Phlm7RXWzLcUnqSOVomccfkcPk1cFqOKly0uu9os+aDbPEN21dzo0/PRaYIeUyG0dBDE4Vu2QDMVwe0/w89lkfmnc8e7QrMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734619009; c=relaxed/simple;
	bh=FW/oE3fT4jjePA8UEJ+h3WanuAAlT/bPb5uQJlRqjtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVF5+Bx5fMVnYMVGzhyfIxBcaBf8tEGP1zaTljxSFHBxPOdw/4aI7oZanpncCKobPdEfJqFTSozE+3RrYvHh1PrWf3wX3+H8v9DKbIm3NoQ5myBc/s6QZTxJpV8wg0OJIQTAlqba7Hkp5OWkHvNwSkX2arZyoxJp3vgRM7mcGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Du7IDZKR; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tOHdc-00812l-IQ; Thu, 19 Dec 2024 15:36:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=YIzskcmCVKS25tfACUjyCIbzgyDneSLF6bsODTD8JMo=; b=Du7IDZKRVN9e4zTxUJ50Py/zMG
	ZylvwRIn4B/Pghv0YWTT0er+aUH3KEGWPTuNli2E5QONIHOpf1YfLZtSZ+PwNRBpGzJGaXFj+iZDM
	X0dbmAIhB89/xNPGCFVsxvIw11n7grlXxde/+4+Pqyj2Rq/qjzlBmd5JkdqcWX5nD2GWP9hZ9xrD0
	ZuPCN3thtPagR53C5lc9tRQ7E1yEEQNxEz4+R6jJbobwr3FSXJCeRc39pnqdJJKdkduya64rSKKvg
	bUNMDWrewMhPQC2kxbtoLihYOgwUXzkGvDyGYI5Oa0E4IAZR1CpOz7my436ZgpXEeqR/fE/ThoN/M
	61oxbDVQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tOHdb-0004RP-FA; Thu, 19 Dec 2024 15:36:27 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tOHdG-00C3iD-SR; Thu, 19 Dec 2024 15:36:06 +0100
Message-ID: <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
Date: Thu, 19 Dec 2024 15:36:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Stefano Garzarella <sgarzare@redhat.com>, Hyunwoo Kim <v4bel@theori.io>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
 <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 09:19, Stefano Garzarella wrote:
> ...
> I think the best thing though is to better understand how to handle 
> deassign, rather than checking everywhere that it's not null, also 
> because in some cases (like the one in virtio-vsock), it's also 
> important that the transport is the same.

My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
it impossible-by-design to switch ->transport from non-NULL to NULL in
vsock_assign_transport().

If I'm not mistaken, that would require rewriting vsock_assign_transport()
so that a new transport is assigned only once fully initialized, otherwise
keep the old one (still unhurt and functional) and return error. Because
failing connect() should not change anything under the hood, right?


