Return-Path: <netdev+bounces-153435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 431CD9F7EF4
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107BE188F037
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C85226168;
	Thu, 19 Dec 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="YHY1GRX2"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DD136E09
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624607; cv=none; b=GKWZFjB/9MlGI8rUYM6FqcVqDjuY9uTwwNJRA1QVkNxsI0NoxBEFcRr75Q+CrM4gTwHtKY6J8W7k5sm4lIRNRm+Qf8Lk5E9qEDRxB7jSeWKBsC07ohxW5b3+D8ICLjjepwzC0ia1zqPzHxq7CthnegRpfatfTQp61dkmS+ZSIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624607; c=relaxed/simple;
	bh=w8uHLAOWytKhZ+2rc6CmLW4hjt/sBLkeIYoFGGtcGKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aROrxWUCGXmC4do7ydTEUB7Q9GHmAlxi9hTVv2Q/Em0jhX3Dj36EHS7CXBmcQX708NNw8im1uJMviru67GYyEynlIpHP+K47UTTTPLXu7VMo4b6wSzYfiFPpnx7bfy4akTRgUjN8LHyirRG/d8sTxs4g69wJ+0a+oGIa0vo3vwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=YHY1GRX2; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tOJ63-008EMI-60; Thu, 19 Dec 2024 17:09:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=QVsORav3DcVAhBYvUaAOANSrKkq0cKBzJoIMSAjqDVQ=; b=YHY1GRX20+/b0sq3p9K21iUEom
	dZjaWWOi64Qwp7hLn1BFKyXgIS1q1Grmj1rgvarCBURRp5Wxzcy6sCvOEcStIXUlNnBxUrUNnWfJV
	WRjwhqXbJXQJpfgWM0Nxxrq5/NHy5MpkxEQMup1jKXDd0/2fGOuofaUVyoT83iZPEyWAQmDx1FKP8
	4dglqCWayHf9FNLWF7ktY84iym1Dvm3c+SNOJU5c4ciuyPZQOjWiF99VwyZfxmJurUhLTz/YKD7o/
	EiBXkv42H0qxVq55KYhbBlFwZg3Up3MH5LVH2w3nTGuQwLaI/PErMhSQ7NKr3BsKSzA3npCOyimbg
	1LejDZog==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tOJ62-0002R7-6c; Thu, 19 Dec 2024 17:09:54 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tOJ5r-00Ealw-Pp; Thu, 19 Dec 2024 17:09:43 +0100
Message-ID: <2906e706-bb0d-47c6-a4bb-9f3dc9ff7834@rbox.co>
Date: Thu, 19 Dec 2024 17:09:42 +0100
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
References: <Z2K/I4nlHdfMRTZC@v4bel-B760M-AORUS-ELITE-AX>
 <lwfkm3salizjvubc5vqnkxi4bk4zdglg5um4xygfxwmrkktrbc@bvazoy4k723k>
 <Z2LZ3HK05RH8OfP5@v4bel-B760M-AORUS-ELITE-AX>
 <s2k74f6zvjm7uexqfyej6txvoqgf6lkaa47igo2eh4pq55d4n2@wnrrcr6aa6lk>
 <f7a3rlgpc36wk75grqeg6ndqmlprvilznlsesyruqfb7m5vrp7@myil7ex4f62n>
 <Z2LvdTTQR7dBmPb5@v4bel-B760M-AORUS-ELITE-AX>
 <5ca20d4c-1017-49c2-9516-f6f75fd331e9@rbox.co>
 <Z2N44ka8+l83XqcG@v4bel-B760M-AORUS-ELITE-AX>
 <fezrztdzj5bz54ys6qialz4w3bjqqxmhx74t2tnklbif6ns5dn@mtcjqnqbx6n4>
 <722e8d32-fe5c-4522-be2b-5967fdbb6b30@rbox.co>
 <CAGxU2F5VMGg--iv8Nxvmo_tGhHf_4d_hO5WuibXLUcwVVNgQEg@mail.gmail.com>
 <cc04fe7a-aa49-47a7-8d54-7a0e7c5bfbdc@rbox.co>
 <CAGxU2F5K+0s9hnk=uuC_fE=otrH+iSe7OVi1gQbDjr7xt5wY9g@mail.gmail.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <CAGxU2F5K+0s9hnk=uuC_fE=otrH+iSe7OVi1gQbDjr7xt5wY9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 16:12, Stefano Garzarella wrote:
> On Thu, 19 Dec 2024 at 16:05, Michal Luczaj <mhal@rbox.co> wrote:
>>
>> On 12/19/24 15:48, Stefano Garzarella wrote:
>>> On Thu, 19 Dec 2024 at 15:36, Michal Luczaj <mhal@rbox.co> wrote:
>>>>
>>>> On 12/19/24 09:19, Stefano Garzarella wrote:
>>>>> ...
>>>>> I think the best thing though is to better understand how to handle
>>>>> deassign, rather than checking everywhere that it's not null, also
>>>>> because in some cases (like the one in virtio-vsock), it's also
>>>>> important that the transport is the same.
>>>>
>>>> My vote would be to apply your virtio_transport_recv_pkt() patch *and* make
>>>> it impossible-by-design to switch ->transport from non-NULL to NULL in
>>>> vsock_assign_transport().
>>>
>>> I don't know if that's enough, in this case the problem is that some
>>> response packets are intended for a socket, where the transport has
>>> changed. So whether it's null or assigned but different, it's still a
>>> problem we have to handle.
>>>
>>> So making it impossible for the transport to be null, but allowing it
>>> to be different (we can't prevent it from changing), doesn't solve the
>>> problem for us, it only shifts it.
>>
>> Got it. I assumed this issue would be solved by `vsk->transport !=
>> &t->transport` in the critical place(s).
>>
>> (Note that BPF doesn't care if transport has changed; BPF just expects to
>> have _a_ transport.)
>>
>>>> If I'm not mistaken, that would require rewriting vsock_assign_transport()
>>>> so that a new transport is assigned only once fully initialized, otherwise
>>>> keep the old one (still unhurt and functional) and return error. Because
>>>> failing connect() should not change anything under the hood, right?
>>>>
>>>
>>> Nope, connect should be able to change the transport.
>>>
>>> Because a user can do an initial connect() that requires a specific
>>> transport, this one fails maybe because there's no peer with that cid.
>>> Then the user can redo the connect() to a different cid that requires
>>> a different transport.
>>
>> But the initial connect() failing does not change anything under the hood
>> (transport should/could stay NULL).
> 
> Nope, isn't null, it's assigned to a transport, because for example it
> has to send a packet to connect to the remote CID and wait back for a
> response that for example says the CID doesn't exist.

Ahh, I think I get it. So the initial connect() passed
vsock_assign_transport() successfully and then failed deeper in
vsock_connect(), right? That's fine. Let the socket have a useless
transport (a valid pointer nevertheless). Sure, upcoming connect() can
assign a new (possibly useless just as well) transport, but there's no
reason to allow ->transport becoming NULL.

And a pre-connect socket (where ->transport==NULL) is not an issue, because
BPF won't let it in any sockmap, so vsock_bpf_recvmsg() won't be reachable.

Anywa, thanks for explaining,
Michal

PS. Or ignore the above and remove the socket from the sockmap at every
reconnect? Possible unhash abuse:

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 5cf8109f672a..8a65153ee186 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -483,6 +483,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		if (vsk->transport == new_transport)
 			return 0;
 
+		const struct proto *prot = READ_ONCE(sk->sk_prot);
+		if (prot->unhash)
+			prot->unhash(sk);
+
 		/* transport->release() must be called with sock lock acquired.
 		 * This path can only be taken during vsock_connect(), where we
 		 * have already held the sock lock. In the other cases, this
diff --git a/net/vmw_vsock/vsock_bpf.c b/net/vmw_vsock/vsock_bpf.c
index 4aa6e74ec295..80deb4d70aea 100644
--- a/net/vmw_vsock/vsock_bpf.c
+++ b/net/vmw_vsock/vsock_bpf.c
@@ -119,6 +119,7 @@ static void vsock_bpf_rebuild_protos(struct proto *prot, const struct proto *bas
 	*prot        = *base;
 	prot->close  = sock_map_close;
 	prot->recvmsg = vsock_bpf_recvmsg;
+	prot->unhash = sock_map_unhash;
 	prot->sock_is_readable = sk_msg_is_readable;
 }

>> Then a successful re-connect assigns
>> the transport (NULL -> non-NULL). And it's all good because all I wanted to
>> avoid (because of BPF) was non-NULL -> NULL. Anyway, that's my possibly
>> shallow understanding :)


