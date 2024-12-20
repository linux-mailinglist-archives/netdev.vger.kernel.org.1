Return-Path: <netdev+bounces-153707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E78F9F947B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 15:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC6F165298
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670B2163A7;
	Fri, 20 Dec 2024 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Tcr2XS+w"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33877204567;
	Fri, 20 Dec 2024 14:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705311; cv=none; b=cJ7jZfGNMKO/fQsRYKJOE4YVsRKVpyp1oiQW67+HfyoKeh3oPWStS16vDky3FX5R7+ORU7T0gEcZ4rMeaQ3KXUHxWtpunD7zwYfysMg/MNi9WcBF5AZ/9y7Iwib5HqEVGN1XDOqHsssQUnDQIOr6cXWIFbkgErWagD63lfzkhp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705311; c=relaxed/simple;
	bh=LCPBtL/uXiFkgmQXVHF5Nv5K6A46/9d86qUCYOlizc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6wP6Y5OqpXgTzsRtmMr2DY2sHA7E0tl2rfEoVeAGa3SgK2PodyARr2qzdVjE1lYlkHiloiTxuaE07xHYXMuHZml2j6iMkurskcLGp001c00zdc+Ap3/21ETHlr02vhsHBe8NQAOWGRlslIyGVZiwYTuwHeAN4zYI68MS/mX0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Tcr2XS+w; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tOe5e-00Ayr5-Bh; Fri, 20 Dec 2024 15:34:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Lfv9zF1rca+KAyc4+BgK6OBzttFWIwtQNyXSxi64xOc=; b=Tcr2XS+wr3wf3pznEqyailSDKg
	5Ryyncm0zuWza6RmF6Y/SDr9H3SDUgw7XPU5yjWOs78Fcn/Md3ns8VP6e+eOjlm03JsNHGfmlQ6Hi
	9J44+91awjbU8+41C0hb42tfJ39pcN8JtnKY2x04hBq76ZB4dFwGZD9IG5MbC+hiV6Cnt0k9X3p6Q
	qQYW1XqkRc61R6ILHo7ZRzdhj90ntaaXI6JYCHhz40UPjQdg3lz7DwCDx4IT+TB5+Tn2jUNOAhdhx
	xizxc8ToAId6w38qL6ZqZfGsw/gcTVNOjORDkqs5ownntv28kPyyQn2+2VvJSMqdaXF9QTAokC7TK
	DTFXseag==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tOe5d-0003jC-HE; Fri, 20 Dec 2024 15:34:53 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tOe5Z-000CXF-8S; Fri, 20 Dec 2024 15:34:49 +0100
Message-ID: <b098c1e0-4422-460a-8372-b5aaea76bfc1@rbox.co>
Date: Fri, 20 Dec 2024 15:34:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: Fix null-ptr-deref in vsock_stream_has_data
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, qwerty@theori.io
References: <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
 <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
 <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
 <cc04fe7a-aa49-47a7-8d54-7a0e7c5bfbdc@rbox.co>
 <CAGxU2F5K+0s9hnk=uuC_fE=otrH+iSe7OVi1gQbDjr7xt5wY9g@mail.gmail.com>
 <2906e706-bb0d-47c6-a4bb-9f3dc9ff7834@rbox.co>
 <jkhr2v5zjebxnckmhn3f3dvv5zdzbldkyxbe5kx5m7vzvw6kzi@nrqipygyhlix>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <jkhr2v5zjebxnckmhn3f3dvv5zdzbldkyxbe5kx5m7vzvw6kzi@nrqipygyhlix>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 11:49, Stefano Garzarella wrote:
> ...
> Note that non-NULL -> NULL should only occur before a connection is 
> established, so before any data is passed. Is this a problem for BPF?

Please take a look at vsock_bpf_update_proto(). The condition is to have a
transport assigned. BPF assumes transport will stay valid.

And currently that's a wrong assumption: transport can transition from
non-NULL to NULL (due to a failed reconnect). That's why we hit null ptr
deref via vsock_bpf_recvmsg().

That said, I sure hope someone BPF-competent is reading this :)


