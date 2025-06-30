Return-Path: <netdev+bounces-202320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EA6AED4D2
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 08:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CCE3AD6EA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 06:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D601E8333;
	Mon, 30 Jun 2025 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jS9fPYq/"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8361D79A5;
	Mon, 30 Jun 2025 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751265778; cv=none; b=Ml9qKjKwjIgJmUHQ4X5WWE2Mcy4ZL0kBg78/0GL2/D1feFUvmV21hbDFoMjZ8exn2UnuQ74M73cLnv+xPTYGow5VbICgoWkqgh9n0z2MLJ562QT4ZN0PdarZzr+DchnXZR36+79kttxNpxnhKIYoza/JD38HOYNDTbswdvuIzdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751265778; c=relaxed/simple;
	bh=dmBlpegE9rKAvLD82Gm4eaxuW6Mr6OFStIpe4VEMhW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bB2QgIHgpVvoYvm5JBcLNeW8favYdll5DcOQ2794rwQKbaQkKvcamZQFw4oIGAoo7M1OXKeBAuoNoAUoe/tbfUYMBymk0UnP2tkjr8kSnInvyQAxlll3GdvkuqOoORfoIOS5kht+b+n/FataYBV41kARwWoFDrrKu5v2PUXtXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jS9fPYq/; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mj
	0//ntO7V6GTvOGZ5O6Fosu16j1jVIMCZpAZZqbU/I=; b=jS9fPYq/60AsWixize
	aFVygS+QLr9kEHzab7bH6X9c0DnxuzB/wG5kiova5gNYZDPzXiGeqEqSl+NrUQQN
	FvMbzfax8JrMRlZ7SuqQ3jdU+oz2Y0qWZcWNacTDbA8vQGz2KGAv1ukh1lUTiUok
	xTWzZPbpMET6NGa+FdwIWa8wY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3T42+MWJomBI0Bg--.44606S2;
	Mon, 30 Jun 2025 14:42:06 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: david.laight.linux@gmail.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	davem@davemloft.net,
	ebiggers@google.com,
	edumazet@google.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stfomichev@gmail.com,
	willemb@google.com,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn
Subject: Re: [PATCH v2] skbuff: Improve the sending efficiency of __skb_send_sock
Date: Mon, 30 Jun 2025 14:42:06 +0800
Message-Id: <20250630064206.70948-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250629123339.0dd73fb1@pumpkin>
References: <20250629123339.0dd73fb1@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3T42+MWJomBI0Bg--.44606S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr13uF1kGw1UKr47Jw1DKFg_yoW8Zw4Dpa
	95WFyqvFsrJ3WYgrs2q3yrAr4Yy3s5Ca48u3yFqas5t3s0gr9Ygr4UKF4Yka4Fgrs7Cry3
	XF4qvw1ak397ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRcTmhUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZQx8eGhiLyBRZwAAse

On Fri, 27 Jun 2025 03:23:24 -0700 Eric Dumazet <edumazet@google.com> wrote:

> On Fri, Jun 27, 2025 at 3:19 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Jun 27, 2025 at 2:44 AM Feng Yang <yangfeng59949@163.com> wrote:
> > >
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > >
> > > By aggregating skb data into a bvec array for transmission, when using sockmap to forward large packets,
> > > what previously required multiple transmissions now only needs a single transmission, which significantly enhances performance.
> > > For small packets, the performance remains comparable to the original level.
> > >
> > > When using sockmap for forwarding, the average latency for different packet sizes
> > > after sending 10,000 packets is as follows:
> > > size    old(us)         new(us)
> > > 512     56              55
> > > 1472    58              58
> > > 1600    106             79
> > > 3000    145             108
> > > 5000    182             123
> > >
> > > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> >
> > Instead of changing everything, have you tried strategically adding
> > MSG_MORE in this function ?
> 
> Untested patch:
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index d6420b74ea9c6a9c53a7c16634cce82a1cd1bbd3..b0f5e8898fdf450129948d829240b570f3cbf9eb
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3252,6 +3252,8 @@ static int __skb_send_sock(struct sock *sk,
> struct sk_buff *skb, int offset,
>                 kv.iov_len = slen;
>                 memset(&msg, 0, sizeof(msg));
>                 msg.msg_flags = MSG_DONTWAIT | flags;
> +               if (slen < len)
> +                       msg.msg_flags |= MSG_MORE;
> 
>                 iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
>                 ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
> @@ -3292,6 +3294,8 @@ static int __skb_send_sock(struct sock *sk,
> struct sk_buff *skb, int offset,
>                                              flags,
>                         };
> 
> +                       if (slen < len)
> +                               msg.msg_flags |= MSG_MORE;
>                         bvec_set_page(&bvec, skb_frag_page(frag), slen,
>                                       skb_frag_off(frag) + offset);
>                         iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1,

After testing, there is a performance improvement for large packets in both TCP and UDP.
Thanks.


