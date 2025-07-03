Return-Path: <netdev+bounces-203791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB89AF7330
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408A6562E99
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E912E2F12;
	Thu,  3 Jul 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dco+cCvD"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58896EEA9
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544221; cv=none; b=qEsx+431PdWp+v+NGo/7+/7x1eAr+R2VI2WrpaH1rZEfrjRPXncJl6uuadKipMqL2QOqM141wAO5Q/byUZvEAv4nwPf9ni2r6nDggCGfld8z9MmMFUzlJszRVDXPo1jrh4c2vJozFFxgczt7XwvKV/A1Mh1gDkQdpaiTpDwujms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544221; c=relaxed/simple;
	bh=jerXSrRoqA1qUbkI8oky8jp1ImqFUxyU/bN43PKvfSM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=sgxpZ27rctAROUpGKC4eNq1SovDnAeVq9HBngpBbP2v8Bow6G3rJHrr5kN1h8kwGn7H1Gqu1d2L9qn+vIiwq5VWw4LL3F4T2zCeK/Tx/ErpXDgMf891NmlXm9jpY+TlGL+bGRTf0R7ft+AxifIP/ENUpU17Wl8H+pcBWhgJduLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dco+cCvD; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751544214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/8w/xeDaBVWRw9XzILJTV9gwuQG1T26Mai5piqvf6w=;
	b=dco+cCvDXtd07E6MtJaUfPxKAou+XRstlbU4pNHpBHSOjS1EfCn/aTXbQ/AlYwzmwrbq8w
	DbEawoGxejy3A5BRZzMeCXV8UrnPuayAvfIxanMZ+BHtqE0OYKNLwvmcH3MUTFhwVmPB0r
	fNvqLGQJQ6dxDoAImE6C2OYiahyERFU=
Date: Thu, 03 Jul 2025 12:03:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <6724e69057445ab66d70f0b28c115e2d8fb5543b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v1] tcp: Correct signedness in skb remaining
 space calculation
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org, mrpre@163.com, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David
 S. Miller" <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "David Howells" <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <CANn89iL=GR5iHXUQ6Jor_rjkn91vuL5w8DCrxwJRQGSO7zmQ-w@mail.gmail.com>
References: <20250702110039.15038-1-jiayuan.chen@linux.dev>
 <c9c5d36bc516e70171d1bb1974806e16020fbff1@linux.dev>
 <CANn89iJdGZq0HW3+uGLCMtekC7G5cPnHChCJFCUhvzuzPuhsrA@mail.gmail.com>
 <CANn89iJD6ZYCBBT_qsgm_HJ5Xrups1evzp9ej=UYGP5sv6oG_A@mail.gmail.com>
 <c910cfc4b58e9e2e1ceaca9d4dc7d68b679caa48@linux.dev>
 <CANn89iL=GR5iHXUQ6Jor_rjkn91vuL5w8DCrxwJRQGSO7zmQ-w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

2025/7/2 23:34, "Eric Dumazet" <edumazet@google.com> =E5=86=99=E5=88=B0:



>=20
>=20On Wed, Jul 2, 2025 at 8:28 AM Jiayuan Chen <jiayuan.chen@linux.dev> =
wrote:
>=20
>=20>=20
>=20> July 2, 2025 at 22:02, "Eric Dumazet" <edumazet@google.com> wrote:
> >=20
>=20>  On Wed, Jul 2, 2025 at 6:59 AM Eric Dumazet <edumazet@google.com> =
wrote:
> >=20
>=20>  >
> >=20
>=20>  > On Wed, Jul 2, 2025 at 6:42 AM Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
> >=20
>=20>  >
> >=20
>=20>  > July 2, 2025 at 19:00, "Jiayuan Chen" <jiayuan.chen@linux.dev> w=
rote:
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > The calculation for the remaining space, 'copy =3D size_goal -=
 skb->len',
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > was prone to an integer promotion bug that prevented copy from=
 ever being
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > negative.
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > The variable types involved are:
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > copy: ssize_t (long)
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > size_goal: int
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > skb->len: unsigned int
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > Due to C's type promotion rules, the signed size_goal is conve=
rted to an
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > unsigned int to match skb->len before the subtraction. The res=
ult is an
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > unsigned int.
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > When this unsigned int result is then assigned to the s64 copy=
 variable,
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > it is zero-extended, preserving its non-negative value. Conseq=
uently,
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > > copy is always >=3D 0.
> >=20
>=20>  >
> >=20
>=20>  > >
> >=20
>=20>  >
> >=20
>=20>  > To better explain this problem, consider the following example:
> >=20
>=20>  >
> >=20
>=20>  > '''
> >=20
>=20>  >
> >=20
>=20>  > #include <sys/types.h>
> >=20
>=20>  >
> >=20
>=20>  > #include <stdio.h>
> >=20
>=20>  >
> >=20
>=20>  > int size_goal =3D 536;
> >=20
>=20>  >
> >=20
>=20>  > unsigned int skblen =3D 1131;
> >=20
>=20>  >
> >=20
>=20>  > void main() {
> >=20
>=20>  >
> >=20
>=20>  > ssize_t copy =3D 0;
> >=20
>=20>  >
> >=20
>=20>  > copy =3D size_goal - skblen;
> >=20
>=20>  >
> >=20
>=20>  > printf("wrong: %zd\n", copy);
> >=20
>=20>  >
> >=20
>=20>  > copy =3D size_goal - (ssize_t)skblen;
> >=20
>=20>  >
> >=20
>=20>  > printf("correct: %zd\n", copy);
> >=20
>=20>  >
> >=20
>=20>  > return;
> >=20
>=20>  >
> >=20
>=20>  > }
> >=20
>=20>  >
> >=20
>=20>  > '''
> >=20
>=20>  >
> >=20
>=20>  > Output:
> >=20
>=20>  >
> >=20
>=20>  > '''
> >=20
>=20>  >
> >=20
>=20>  > wrong: 4294966701
> >=20
>=20>  >
> >=20
>=20>  > correct: -595
> >=20
>=20>  >
> >=20
>=20>  > '''
> >=20
>=20>  >
> >=20
>=20>  > Can you explain how one skb could have more bytes (skb->len) tha=
n size_goal ?
> >=20
>=20>  >
> >=20
>=20>  > If we are under this condition, we already have a prior bug ?
> >=20
>=20>  >
> >=20
>=20>  > Please describe how you caught this issue.
> >=20
>=20>  >
> >=20
>=20>  Also, not sure why copy variable had to be changed from "int" to "=
ssize_t"
> >=20
>=20>  A nicer patch (without a cast) would be to make it an "int" again/
> >=20
>=20>  I encountered this issue because I had tcp_repair enabled, which u=
ses
> >=20
>=20>  tcp_init_tso_segs to reset the MSS.
> >=20
>=20>  However, it seems that tcp_bound_to_half_wnd also dynamically adju=
sts
> >=20
>=20>  the value to be smaller than the current size_goal.
> >=20
>=20
> Okay, and what was the end result ?
>=20
>=20An skb has a limited amount of bytes that can be put into it
>=20
>=20(MAX_SKB_FRAGS * 32K) , and I can't see what are the effects of havin=
g
>=20

Hi=20Eric,

I'm working with a reproducer generated by syzkaller [1], and its core
logic is roughly as follows:

'''
setsockopt(fd, TCP_REPAIR, 1)
connect(fd);
setsockopt(fd, TCP_REPAIR, -1)

send(fd, small);
sendmmsg(fd, buffer_2G);
'''

First, because TCP_REPAIR is enabled, the send() operation leaves the skb
at the tail of the write_queue. Subsequently, sendmmsg is called to send
2GB of data.

Due to TCP_REPAIR, the size_goal is reduced, which can cause the copy
variable to become negative. However, because of integer promotion bug
mentioned in the previous email, this negative value is misinterpreted as
a large positive number. Ultimately, copy becomes a huge value, approachi=
ng
the int32 limit. This, in turn, causes sk->sk_forward_alloc to overflow,
which is the exact issue reported by syzkaller.

On a related note, even without using TCP_REPAIR, the tcp_bound_to_half_w=
nd()
function can also reduce size_goal on its own. Therefore, my understandin=
g is
that under extreme conditions, we might still encounter an overflow in
sk->sk_forward_alloc.

So, I think we have good reason to change copy to an int.

