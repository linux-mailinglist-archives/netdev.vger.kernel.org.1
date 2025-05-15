Return-Path: <netdev+bounces-190618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE55AB7D83
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4160868014
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2865121B9FC;
	Thu, 15 May 2025 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k5wHJR8M"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A91A5B95
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 06:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747289058; cv=none; b=oOyvVjlP8wMXTL4xAo1EVgoO1dFJ3dK4Qcez8cdCu0/mIty+p/Q4AqvsgGJGNOd3HLIof4EonKS8s2qKJK1Q2W5i9vLRbghX6NrGIQ6J8Uhv/9p1W3zngDpX1niAc+5n9eNj11pczeYAJorfjSseEfFNQLCj4ehaypwItsGgASI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747289058; c=relaxed/simple;
	bh=fY9aDSLlfYiNbA2FvV9knhNei76qMJ8rL628l6Wybxg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=d2ht7UyMa52bMWq6HtZ8u63ASAnAulFoCY2rBjEvUiyyYXHlPiMfoBEkmbJnkFupQyMvlU/K9DZcSpuLGwEogLsv2ONWvlIrm1eMkwejiMiYaansv87Cz2B1vSoDTFvaWod/0xaGEEjivpgkBbUBXvpBR/6s+P/0SGwLuTB9Rxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k5wHJR8M; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747289043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F92b3CDbHsErtc8gsB0XSFuVmpF+K01KffAPJ6dv2HM=;
	b=k5wHJR8MgJm8s+Zofv9j1a5DKn7ffczxiU9sRiPFOoSf6Z9OGScom+OdsPgiuEn5xNN2ke
	uYmYiCGiD0mulp6peGtxJK411t70xHB8mhwRTH4hFmwE13udZrcbcezm0LRgy+DaHIGckL
	FnAlTfomRWFLUIdUbuuajen7fYfD4WM=
Date: Thu, 15 May 2025 06:04:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <646737505f4d827be204b2498f094669b81eda24@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v5] bpf, sockmap: avoid using sk_socket after
 free when sending
To: "John Fastabend" <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, "Michal Luczaj" <mhal@rbox.co>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Cong Wang"
 <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515055356.bgevcqwkyv3q7acr@gmail.com>
References: <20250508061825.51896-1-jiayuan.chen@linux.dev>
 <20250515055356.bgevcqwkyv3q7acr@gmail.com>
X-Migadu-Flow: FLOW_OUT

May 15, 2025 at 13:53, "John Fastabend" <john.fastabend@gmail.com> wrote:


>=20
>=20On 2025-05-08 14:18:25, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> The sk->sk_socket is not locked or referenced in backlog thread, an=
d
> >=20
>=20>  during the call to skb_send_sock(), there is a race condition with
> >=20
>=20>  the release of sk_socket. All types of sockets(tcp/udp/unix/vsock)
> >=20
>=20>  will be affected.
> >=20
>=20>=20=20
>=20>=20
>=20>  Race conditions:
> >=20
>=20>  '''
> >=20
>=20>  CPU0 CPU1
> >=20
>=20>=20=20
>=20>=20
>=20>  backlog::skb_send_sock
> >=20
>=20>  sendmsg_unlocked
> >=20
>=20>  sock_sendmsg
> >=20
>=20>  sock_sendmsg_nosec
> >=20
>=20>  close(fd):
> >=20
>=20>  ...
> >=20
>=20>  ops->release() -> sock_map_close()
> >=20
>=20>  sk_socket->ops =3D NULL
> >=20
>=20>  free(socket)
> >=20
>=20>  sock->ops->sendmsg
> >=20
>=20>  ^
> >=20
>=20>  panic here
> >=20
>=20>  '''
> >=20
>=20>=20=20
>=20>=20
>=20>  The ref of psock become 0 after sock_map_close() executed.
> >=20
>=20>  '''
> >=20
>=20>  void sock_map_close()
> >=20
>=20>  {
> >=20
>=20>  ...
> >=20
>=20>  if (likely(psock)) {
> >=20
>=20>  ...
> >=20
>=20>  // !! here we remove psock and the ref of psock become 0
> >=20
>=20>  sock_map_remove_links(sk, psock)
> >=20
>=20>  psock =3D sk_psock_get(sk);
> >=20
>=20>  if (unlikely(!psock))
> >=20
>=20>  goto no_psock; <=3D=3D=3D Control jumps here via goto
> >=20
>=20>  ...
> >=20
>=20>  cancel_delayed_work_sync(&psock->work); <=3D=3D=3D not executed
> >=20
>=20>  sk_psock_put(sk, psock);
> >=20
>=20>  ...
> >=20
>=20>  }
> >=20
>=20>  '''
> >=20
>=20>=20=20
>=20>=20
>=20>  Based on the fact that we already wait for the workqueue to finish=
 in
> >=20
>=20>  sock_map_close() if psock is held, we simply increase the psock
> >=20
>=20>  reference count to avoid race conditions.
> >=20
>=20>=20=20
>=20>=20
>=20>  With this patch, if the backlog thread is running, sock_map_close(=
) will
> >=20
>=20>  wait for the backlog thread to complete and cancel all pending wor=
k.
> >=20
>=20>=20=20
>=20>=20
>=20>  If no backlog running, any pending work that hasn't started by the=
n will
> >=20
>=20>  fail when invoked by sk_psock_get(), as the psock reference count =
have
> >=20
>=20>  been zeroed, and sk_psock_drop() will cancel all jobs via
> >=20
>=20>  cancel_delayed_work_sync().
> >=20
>=20>=20=20
>=20>=20
>=20>  In summary, we require synchronization to coordinate the backlog t=
hread
> >=20
>=20>  and close() thread.
> >=20
>=20>=20=20
>=20>=20
>=20>  The panic I catched:
> >=20
>=20>  '''
> >=20
>=20>  Workqueue: events sk_psock_backlog
> >=20
>=20>  RIP: 0010:sock_sendmsg+0x21d/0x440
> >=20
>=20>  RAX: 0000000000000000 RBX: ffffc9000521fad8 RCX: 0000000000000001
> >=20
>=20>  ...
> >=20
>=20>  Call Trace:
> >=20
>=20>  <TASK>
> >=20
>=20>  ? die_addr+0x40/0xa0
> >=20
>=20>  ? exc_general_protection+0x14c/0x230
> >=20
>=20>  ? asm_exc_general_protection+0x26/0x30
> >=20
>=20>  ? sock_sendmsg+0x21d/0x440
> >=20
>=20>  ? sock_sendmsg+0x3e0/0x440
> >=20
>=20>  ? __pfx_sock_sendmsg+0x10/0x10
> >=20
>=20>  __skb_send_sock+0x543/0xb70
> >=20
>=20>  sk_psock_backlog+0x247/0xb80
> >=20
>=20>  ...
> >=20
>=20>  '''
> >=20
>=20>=20=20
>=20>=20
>=20>  Reported-by: Michal Luczaj <mhal@rbox.co>
> >=20
>=20>  Fixes: 799aa7f98d53 ("skmsg: Avoid lock_sock() in sk_psock_backlog=
()")
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20
> Is the fixes tag actually,
>=20
>=20 4b4647add7d3c sock_map: avoid race between sock_map_close and sk_pso=
ck_put
>=20
>=20Before that we should call the cancel correctly?
>=20
>=20Thanks,
>=20
>=20John
>

I missed this patch, the fixes should be 4b4647add7d3c.

Yes, before this patch, the workqueue can be canceled correctly.

