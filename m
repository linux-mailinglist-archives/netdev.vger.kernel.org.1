Return-Path: <netdev+bounces-288959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP32K+zcCmpV8wQAu9opvQ
	(envelope-from <netdev+bounces-288959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:33:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D126569C87
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 285843015A72
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BFE3E6DD8;
	Mon, 18 May 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/CaEIFn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJ9EzcEb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFF3E5583
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096797; cv=none; b=SHD5dThnqakZ8fgjYRD+CQdqdEXhr/Ba2Etam0Nq81T53UH1WSCpWTP68aRaP7Bl8F+CLGucaCfYg7nBrma9VNp5pQvAmrqD72SXzOyqWRxwdDOmwHGfJL2OxLuKjfdRBNUxXDhvMo/d0GK5vam9xIj0G6Xyqyu+d/jC02qJmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096797; c=relaxed/simple;
	bh=jSlre+l4xv2u3lht0ewJ63vmV7qP+xbiV5kD+x9/9jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5Pfy3z7erGHNwIfYlxDAGei6K/1xr8RJSqagcKTYdgGuETXDIpCWrhTL13/j3I55f3Zw+BO+5/dkTf2OMfAnhy9TFX3F2cGcrtHXXqiaci3QSKpBrIjdsymHUQgMwm1lOULMhTM6OgWBlTtT0Zdi7KoROJHIU2t73e7t1pvrRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/CaEIFn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJ9EzcEb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779096795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
	b=H/CaEIFnctrW8LwWROHQmclAXO14GVI//8RqNtIbFTUScJ1n4mAyViylj7JUvJX6A9aPlF
	mXAZ3LGiv9VgH0fV+DcElauqHi1xHRGb1XzKCxWxt1wrZLWmV0JI95J/REs7TOp2RSy5+3
	d29Hw7uUUq8zJeOGdR/TExcKnJlVrcw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-Qi9vWkylOoiWEJJYwsfIVQ-1; Mon, 18 May 2026 05:33:14 -0400
X-MC-Unique: Qi9vWkylOoiWEJJYwsfIVQ-1
X-Mimecast-MFC-AGG-ID: Qi9vWkylOoiWEJJYwsfIVQ_1779096793
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fe3e73da6so8994155e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779096793; x=1779701593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
        b=cJ9EzcEbqft16LRCVOblEHlFhqd6dFMM0L00aCOKdX+l+fN6L1YT3ipc041q5f9gm5
         IIzcXTQHUrfOqyMWabOchDC/00Mdnes3DQoU2Sujp4/Gn23Q1z2eYtvNq/p/IkHIQcTH
         XYEWygRp5Cfytu9pHUyHJ1MVbG5pR8qV9gfnUHXcfyED/XGXtM+CDbD/wZAEJAXZlc9U
         sCGIZgAcJIBFHuRI+m6qeDaVvW3eX6h0DLN8zq54hlIDC1tYnpRO2ok1NFLJSBJ82E5w
         X67CbTOGYHbriz8T6kf5LfQNeB+yugk7QBmc/iuPAZSmBFZV8i7ILUKx6NHTnZJCGFU0
         cSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779096793; x=1779701593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rMc/AxTWnfe6rPr4aOrLy+F5Zu/TWf0k5shSHIhIko=;
        b=FYEf2vp5OUwcx7Z6fTaGtM23Z1wHAr8A7H6AWC3FQSpoWiIeRG1VkjafGJrI03z5hM
         xCt48qUPQBo1fePVmAG7g6S7YPgPPepuUCJv9gBhN0oHcFfIyB6iOqq2B0kWbMvhmMi/
         gEo/ERqIgwuH9tI3aIXY1561mH9GVBdKXHnuWsCJ4ycULvNh4GzbTC2rdeutmisBs/yq
         cMEgsuP67gJYZtObND+IsYg2RN8JMmf57OwyioxIYITfr4cSPzCvHLM3B7DowOjK/k9Y
         wbGJ1RP5R6ehHZZiHY62js5EMiivMyXPbR7RP2+VyQJWjY4uJT1TBLzz/GLwsW7y5T+b
         ugaA==
X-Forwarded-Encrypted: i=1; AFNElJ8c28pRZnkRgGs9Skcs/0+NStVBPm7aoirMDiYIUmiU7zOH1VXDCm238kUGemiU5RkhWFRjefg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51MiwC4/1AGdEnx8zgUiewPyEp6UDD8UILv7Ol65yHJ2pPvEn
	CSVeSPOpK+nsY540lapTf8L66Cp/CV/zDmtHMF7WFc1pkKUyPL0cvI0vbeupFG8w1DA8FwdWlpy
	GCfrT2pb7b3jv3XQYWxCVEfAKwN8GLzda0tZB/NZ38crMUszw1To08p+TWw==
X-Gm-Gg: Acq92OHql1Rh+Rn1MJ0hUH+vuz+leX7wp43ldHGOgqJ9HrWRlczitXJSVJmPGUXo7wO
	LlKrbOCoeteE4h7Z7z5KSvL5S5ixUkcrYhnZYr4J5ClYdw+cb/l41l0LvrDokXM/bBkn1Wu4A73
	HqTA7z0BFk29gmSPjW4siJNNYxkZtKtKOM4svah8+9e3Yd5pm8TWICuIWO9fYuAMzBU8zJ02nXg
	7gYuHCCnnlFm0OkDFjTLAHORAhdK78domofcKhFHgVwXt0Vp/7aVlz3R5lGiiQ1G2vfRI5HduTc
	dg+MJJ+fha7SlNOuKagpiu2EGhVJBTMKitRmVQXB3afFixEbEiGa4Up4yUlB/WvCW2YUWn/bYlf
	oupbeH4G23yml7fkZYZGJPcEH5kpkRVHmIxWQQw9p
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr173599055e9.31.1779096792670;
        Mon, 18 May 2026 02:33:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a406:b0:48f:e230:1d12 with SMTP id 5b1f17b1804b1-48fe6329913mr173598345e9.31.1779096792146;
        Mon, 18 May 2026 02:33:12 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm140342335e9.4.2026.05.18.02.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:33:11 -0700 (PDT)
Date: Mon, 18 May 2026 05:33:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <20260518053223-mutt-send-email-mst@kernel.org>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
 <agrXvCtNRlySlwgx@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agrXvCtNRlySlwgx@sgarzare-redhat>
X-Rspamd-Queue-Id: 2D126569C87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288959-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,redhat.com,salutedevices.com,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,salutedevices.com:email]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 11:18:24AM +0200, Stefano Garzarella wrote:
> On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
> > On Thu, 14 May 2026 11:29:48 +0200
> > Stefano Garzarella <sgarzare@redhat.com> wrote:
> > 
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > 
> > > When a large message is fragmented into multiple skbs, the zerocopy
> > > uarg is only allocated and attached to the last skb in the loop.
> > > Non-final skbs carry pinned user pages with no completion tracking,
> > > so the kernel has no way to notify userspace when those pages are safe
> > > to reuse. If the loop breaks early the uarg is never allocated at all,
> > > leaking pinned pages with no completion notification.
> > > 
> > > Fix this by following the approach used by TCP: allocate the zerocopy
> > > uarg (if not provided by the caller) before the send loop and attach
> > > it to every skb via skb_zcopy_set(), which takes a reference per skb.
> > > Each skb's completion properly decrements the refcount, and the
> > > notification only fires after the last skb is freed.
> > > On failure, if no data was sent, the uarg is cleanly aborted via
> > > net_zcopy_put_abort().
> > > 
> > > This issue was initially discovered by sashiko while reviewing commit
> > > 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
> > > but was pre-existing.
> > > 
> > > Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> > > Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > > Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
> > > Reported-by: Maher Azzouzi <maherazz04@gmail.com>
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > >  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
> > >  1 file changed, 34 insertions(+), 49 deletions(-)
> > > 
> > > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > > index 989cc252d3d3..1e3409d28164 100644
> > > --- a/net/vmw_vsock/virtio_transport_common.c
> > > +++ b/net/vmw_vsock/virtio_transport_common.c
> > > @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
> > >  	return true;
> > >  }
> > > 
> > > -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
> > > -					   struct sk_buff *skb,
> > > -					   struct msghdr *msg,
> > > -					   size_t pkt_len,
> > > -					   bool zerocopy)
> > > -{
> > > -	struct ubuf_info *uarg;
> > > -
> > > -	if (msg->msg_ubuf) {
> > > -		uarg = msg->msg_ubuf;
> > > -		net_zcopy_get(uarg);
> > > -	} else {
> > > -		struct ubuf_info_msgzc *uarg_zc;
> > > -
> > > -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> > > -					    pkt_len, NULL, false);
> > > -		if (!uarg)
> > > -			return -1;
> > > -
> > > -		uarg_zc = uarg_to_msgzc(uarg);
> > > -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
> > > -	}
> > > -
> > > -	skb_zcopy_init(skb, uarg);
> > > -
> > > -	return 0;
> > > -}
> > > -
> > >  static int virtio_transport_fill_skb(struct sk_buff *skb,
> > >  				     struct virtio_vsock_pkt_info *info,
> > >  				     size_t len,
> > > @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  	u32 src_cid, src_port, dst_cid, dst_port;
> > >  	const struct virtio_transport *t_ops;
> > >  	struct virtio_vsock_sock *vvs;
> > > +	struct ubuf_info *uarg = NULL;
> > >  	u32 pkt_len = info->pkt_len;
> > >  	bool can_zcopy = false;
> > > +	bool have_uref = false;
> > >  	u32 rest_len;
> > >  	int ret;
> > > 
> > > @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  		if (can_zcopy)
> > >  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> > >  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> > > +
> > > +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> > > +		    info->op == VIRTIO_VSOCK_OP_RW) {
> > > +			uarg = info->msg->msg_ubuf;
> > > +
> > > +			if (!uarg) {
> > > +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> > > +							    pkt_len, NULL, false);
> > > +				if (!uarg) {
> > > +					virtio_transport_put_credit(vvs, pkt_len);
> > > +					return -ENOMEM;
> > > +				}
> > > +
> > > +				if (!can_zcopy)
> > > +					uarg_to_msgzc(uarg)->zerocopy = 0;
> > > +
> > > +				have_uref = true;
> > > +			}
> > > +		}
> > 
> > Surely that block should only be done if can_zcopy is true?
> > And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
> > If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
> > 
> > It info->msg->msg_buf is already set then I think you have to disable zero-copy.
> > The caller has already requested a callback - and you can't add another.
> > 
> > In any case by the end of this can_zcopy and have_uref are really the same flag.
> 
> I kept the same approach we had before, trying to make as few changes as
> possible.
> 
> All these potential issues seem to be pre-existing and should be eventually
> addressed in other patches IMHO. This patch one only resolves the main issue
> of calling `skb_zcopy_set()` for every skb to avoid leaking pages, etc.

the patch is upstream now, right? So pretty much have to be patches on
top.

> @Arseniy can you help on this?
> 
> > 
> > >  	}
> > > 
> > >  	rest_len = pkt_len;
> > > @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > >  			break;
> > >  		}
> > > 
> > > -		/* We process buffer part by part, allocating skb on
> > > -		 * each iteration. If this is last skb for this buffer
> > > -		 * and MSG_ZEROCOPY mode is in use - we must allocate
> > > -		 * completion for the current syscall.
> > > -		 *
> > > -		 * Pass pkt_len because msg iter is already consumed
> > > -		 * by virtio_transport_fill_skb(), so iter->count
> > > -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
> > > -		 * accounting done by msg_zerocopy_realloc().
> > > -		 */
> > > -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
> > > -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
> > > -			if (virtio_transport_init_zcopy_skb(vsk, skb,
> > > -							    info->msg,
> > > -							    pkt_len,
> > > -							    can_zcopy)) {
> > > -				kfree_skb(skb);
> > > -				ret = -ENOMEM;
> > > -				break;
> > > -			}
> > > -		}
> > > +		skb_zcopy_set(skb, uarg, NULL);
> > > 
> > >  		virtio_transport_inc_tx_pkt(vvs, skb);
> > > 
> > > @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> > > 
> > >  	virtio_transport_put_credit(vvs, rest_len);
> > > 
> > > +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
> > > +	 * skb_zcopy_set() increases it for each skb, so we can drop that
> >                                                            ^ must
> > 
> > > +	 * initial reference to keep it balanced.
> > > +	 */
> > > +	if (have_uref) {
> > > +		if (rest_len == pkt_len)
> > > +			/* No data sent, abort the notification. */
> > > +			net_zcopy_put_abort(uarg, true);
> > 
> > Is it worth optimising for the 'nothing sent' case ?
> 
> What do you suggest doing?
> 
> I followed what TCP does.
> 
> Thanks,
> Stefano
> 
> > 
> > -- David
> > 
> > > +		else
> > > +			net_zcopy_put(uarg);
> > > +	}
> > > +
> > >  	/* Return number of bytes, if any data has been sent. */
> > >  	if (rest_len != pkt_len)
> > >  		ret = pkt_len - rest_len;
> > 


