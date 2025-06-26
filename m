Return-Path: <netdev+bounces-201430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 904C6AE9739
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB10189D6AE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F075236453;
	Thu, 26 Jun 2025 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O659ElZ4"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DD20013A;
	Thu, 26 Jun 2025 07:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750924272; cv=none; b=JH6Ho+x4xiZ5FKg1ozKVDn+Zygk5iLN1YaMCrPxfF/kVA5Cezf7/7AaUAPiTbj24eSGvoBvTlEFYN473ePOz55d7/UFkKR7RxfCir1AaXLWpppgm1pz6mQhCqDOEoJcp+6yPws5beb7/7WnGBO+R+RgQ/63aRacMaRLMtzX3Iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750924272; c=relaxed/simple;
	bh=xjVdLV/JVz2BsWEL05AlHxeZQWEEvAm7WvVCsdy8r8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZauVaJX6rri1QTLUUHMKFrCSdZ6rVNjMYYbnQTVDHdFToj3xpF0fR+JIysTU8g1htdWSEVUbAX6wpsQ9PYom++y7EcQrG+gUcmBxijvTZNp60DTHWLdD0XXX2xjyTQV9UfAI7MM6ZgOZAUJeDE3WZ9/fHS70Fjc9XedinJM74C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O659ElZ4; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nr
	cH+J0mcbi7MPQc1gfhaJE8haS8C9y1V4Z6MecyyhQ=; b=O659ElZ43LwpJ6LGnv
	iK3ZnWDuqvKYBGWSTLSn+Wu2Y/dLWk12YeIOOP6JQYYuHHzhZXnBgITO9wVcVZbG
	KTxPpblbRKacaR0mbLtOuD87xYRIOuZZleEdi7bAub6x77vJkUsFZ91nDy/Hk9HN
	drPNa9urCGwBov1ew3UioPn/c=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXX+i8+1xoujOlAg--.17814S2;
	Thu, 26 Jun 2025 15:50:22 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: stfomichev@gmail.com
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
	willemb@google.com,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn
Subject: Re: [PATCH] skbuff: Improve the sending efficiency of __skb_send_sock
Date: Thu, 26 Jun 2025 15:50:20 +0800
Message-Id: <20250626075020.95425-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <aFxBi55GlhVdHzE4@mini-arch>
References: <aFxBi55GlhVdHzE4@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX+i8+1xoujOlAg--.17814S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF17XFyfuFWfAF47Cry5twb_yoW5Cry7pF
	WfGFZxWr4DJF17urn3tw4F9r43tayvkr48GF4Sva4fAr90yryFgF4UKr10ka9YkryxCF4x
	Xr4qqr1UKrn0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUyxRhUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiZRx4eGhc+MFgSQAAsd

On Wed, 25 Jun 2025 11:35:55 -0700, Stanislav Fomichev <stfomichev@gmail.com> wrote:

> On 06/23, Feng Yang wrote:
> > From: Feng Yang <yangfeng@kylinos.cn>
> > 
> > By aggregating skb data into a bvec array for transmission, when using sockmap to forward large packets,
> > what previously required multiple transmissions now only needs a single transmission, which significantly enhances performance.
> > For small packets, the performance remains comparable to the original level.
> > 
> > When using sockmap for forwarding, the average latency for different packet sizes
> > after sending 10,000 packets is as follows:
> > size	old(us)		new(us)
> > 512	56		55
> > 1472	58		58
> > 1600	106		79
> > 3000	145		108
> > 5000	182		123
> > 
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  net/core/skbuff.c | 112 +++++++++++++++++++++-------------------------
> >  1 file changed, 52 insertions(+), 60 deletions(-)
> > 
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 85fc82f72d26..664443fc9baf 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -3235,84 +3235,75 @@ typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg);
> >  static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
> >  			   int len, sendmsg_func sendmsg, int flags)
> >  {
> > -	unsigned int orig_len = len;
> >  	struct sk_buff *head = skb;
> >  	unsigned short fragidx;
> > -	int slen, ret;
> > +	struct msghdr msg;
> > +	struct bio_vec *bvec;
> > +	int max_vecs, ret, slen;
> > +	int bvec_count = 0;
> > +	unsigned int copied = 0;
> >  
> > -do_frag_list:
> > -
> > -	/* Deal with head data */
> > -	while (offset < skb_headlen(skb) && len) {
> > -		struct kvec kv;
> > -		struct msghdr msg;
> > -
> > -		slen = min_t(int, len, skb_headlen(skb) - offset);
> > -		kv.iov_base = skb->data + offset;
> > -		kv.iov_len = slen;
> > -		memset(&msg, 0, sizeof(msg));
> > -		msg.msg_flags = MSG_DONTWAIT | flags;
> > -
> > -		iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, &kv, 1, slen);
> > -		ret = INDIRECT_CALL_2(sendmsg, sendmsg_locked,
> > -				      sendmsg_unlocked, sk, &msg);
> > -		if (ret <= 0)
> > -			goto error;
> > +	max_vecs = skb_shinfo(skb)->nr_frags + 1; // +1 for linear data
> > +	if (skb_has_frag_list(skb)) {
> > +		struct sk_buff *frag_skb = skb_shinfo(skb)->frag_list;
> >  
> > -		offset += ret;
> > -		len -= ret;
> > +		while (frag_skb) {
> > +			max_vecs += skb_shinfo(frag_skb)->nr_frags + 1; // +1 for linear data
> > +			frag_skb = frag_skb->next;
> > +		}
> >  	}
> >  
> > -	/* All the data was skb head? */
> > -	if (!len)
> > -		goto out;
> > +	bvec = kcalloc(max_vecs, sizeof(struct bio_vec), GFP_KERNEL);
> > +	if (!bvec)
> > +		return -ENOMEM;
> 
> Not sure allocating memory here is a good idea. From what I can tell
> this function is used by non-sockmap callers as well..

Alternatively, we can use struct bio_vec bvec[size] to avoid memory allocation.
Even if the "size" is insufficient, the unsent portion will be transmitted in the next call to `__skb_send_sock`.

Here we just merge them and send together. The other invocations of this function should still be able to send normally.


