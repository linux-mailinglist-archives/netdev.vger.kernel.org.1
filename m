Return-Path: <netdev+bounces-288953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ce7IxnaCmoA8wQAu9opvQ
	(envelope-from <netdev+bounces-288953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F9B569922
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1F2303B4F3
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B23532B99E;
	Mon, 18 May 2026 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PId+cVhc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo6v6eJn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BD3E51E7
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095917; cv=none; b=QO5li0SMPqsM4bSP8N39fZ0hkmCNbxuNrzlulcnYnzr/5H/3LKSpaYcZmK1QE6ZwM4e9rIQsxIkUmM1NrzHgtWfs3Z0a6Xl3UTkbmgYDEB0mpg0h9KlfOD+GivdOblWRKNfUeVW6KaaWSNwr900DaTyX5Yf3FaOEOqDSckmMKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095917; c=relaxed/simple;
	bh=+8/VJhhwAWRz5iKAyGx7YnwI1nUcMidMBg/lFGhMB3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/BzN8q/mE1+22lgsZ86SxmZ3pBE57TSSAc2RIgHEG1z4fNhmpYBkAMJcTXhtpauER6gXTLgvEkJsimsL5AFDUkIFUijXkhBG8s5PqzJLOX3GYKM1BLH7Szz6fIjTotVehU9WdS2xZ6ULPCcuG+B832yWxS2oH/NN2J/X9n8ZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PId+cVhc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lo6v6eJn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779095913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
	b=PId+cVhcgwMKOdro6Jy6rhfc+CnHqw3eB5SoHnufgcN15SYlE5KLieI2AxH3zpSD5Lp43+
	NiZfVcRvhYw7WAP2YwMRtDqWYX1xIyV0G6lvHH14NJZ6lVaHVmS4BCXZfkM21adwK/7orI
	+tNi95HlxCdNyWmImGWLDhXmPjYdtQg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-ERBWZ7IfPz2irv6Slf9jAg-1; Mon, 18 May 2026 05:18:32 -0400
X-MC-Unique: ERBWZ7IfPz2irv6Slf9jAg-1
X-Mimecast-MFC-AGG-ID: ERBWZ7IfPz2irv6Slf9jAg_1779095911
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a2c034fso2085474f8f.3
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779095910; x=1779700710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
        b=Lo6v6eJnjKsGJCDjgJ4/yFECN7KuX9gdg4Idj1Nyd+KHH/tpO118ULBLx1d++YlJb8
         wv8cFjuytScHRSTlYZynKaTl0dDkrP302Hk0dLjpn/lz7lrgza2RikZCcxvKuq1tHolF
         gDjdNC/xmnjPdE/FUshyz8rYvWJSOKGxQpyRVjanlGB2IapY6gdRMl83+RgFva4hfiE0
         RJ0Esbg9k17dxZsHUh2djM2MogDPeWy/t7p2HGPmpthcYXJpsOLN5oFd9uMVr0Y4rjDV
         CwuMrKNJP76gdVf6hdn7SG1iPz8Z9TkFgmUNHsqBoLUISORrVBZTByF9hzOfFMHhoWwI
         XrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095910; x=1779700710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EqKUKOs8Xdi2Db46H+lGN1qYJFfdvrNsugQmOuQMj5w=;
        b=Ql4Sr4aXIBejydH0TVxCkUNQYk0gG3iGKFG1B4GNFOD6ZEcHQJhzXb1SXzJH7pQQ37
         V6UdljhSb/QN101Y1QkDgZBSSXnCMMhy2tkNeJUVlPOo8BQecITN4v3KDd79XJD7iP7V
         WniptSGle0vlXzIysonZrA4w2FBOgkjqsNRHyipl6oS27EOEDSbLseRH9n0UCqYRvpYZ
         U38qK9xSsZ3mE8HVcYVOKFr2NofOXrCW3ZNW6CScMoMI9aUmLk+bUoqeaSHoj+VnemkQ
         gUFbCKiq8Gxa3l2CQXMHxlEQL4A//Gdlhq15ky/CnWunaywoG8uAuGRJONFEiFccUX2U
         Y1kQ==
X-Gm-Message-State: AOJu0Yz6y/TO3KYxk1Og78CrtN4SeYc4fJWHfNj0fMqknm6azUddEofk
	lDEJkEv1hNHm4OIqH2HFTS8bo7EQUH7snGvx0DWcV4jkNXXDpn3e1GnEZgRKcAqESovEe0wXYrj
	9cFOwd2pb0SNs9DEGjudRG7FUYsy7auqzX/qnb1qISbJpAIG0uAQvpYC95w==
X-Gm-Gg: Acq92OEMCn0BmBpfS0BuSMeYoMUQrufi9l5uyPPlOcfNHnPucIv/pTOe66s2uzsHjaM
	+X3EhNxyrCh88JN939zUJ0VVYorxfdVUs/xky7zt/XLvFzt/xaj8Mmb9pfed3JHFQ9g2goxr7ju
	q5c8CEmOppy6jcf+T9E2cWgU9mZffzTrR31CLipvgBCnFIySXHQugBbCWuUccduieHW+inwVv7L
	LHjaSlu43daQ3pnlVp7uBfoNDX4MC1/z+qeAHyctdXrigzuat4O9g8dw0p4BopE7LEOqnLkJpdp
	fnNdoONR2CYavayZVPri4tYN7W4Mfn6QB1amDJsgDzsh/PEaFaVp7r3OGVu3ZFilPMsORKsL7eV
	k8EmXuDrMiO7yuPd2T2UYdu4bDy9iV1n/P22+xFgVmKm7DbyhfjS/zT+E0EEN6diUc3ks3hmHhQ
	==
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr137667175e9.7.1779095910534;
        Mon, 18 May 2026 02:18:30 -0700 (PDT)
X-Received: by 2002:a05:600c:35cc:b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-48ffe2a1125mr137666435e9.7.1779095910029;
        Mon, 18 May 2026 02:18:30 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57944c1sm263396765e9.7.2026.05.18.02.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:18:29 -0700 (PDT)
Date: Mon, 18 May 2026 11:18:24 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org, 
	Maher Azzouzi <maherazz04@gmail.com>
Subject: Re: [PATCH net] vsock/virtio: fix zerocopy completion for multi-skb
 sends
Message-ID: <agrXvCtNRlySlwgx@sgarzare-redhat>
References: <20260514092948.268720-1-sgarzare@redhat.com>
 <20260516125329.7b699c6f@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516125329.7b699c6f@pumpkin>
X-Rspamd-Queue-Id: D2F9B569922
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288953-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,salutedevices.com,google.com,linux.alibaba.com,lists.linux.dev,davemloft.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 12:53:29PM +0100, David Laight wrote:
>On Thu, 14 May 2026 11:29:48 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> When a large message is fragmented into multiple skbs, the zerocopy
>> uarg is only allocated and attached to the last skb in the loop.
>> Non-final skbs carry pinned user pages with no completion tracking,
>> so the kernel has no way to notify userspace when those pages are safe
>> to reuse. If the loop breaks early the uarg is never allocated at all,
>> leaking pinned pages with no completion notification.
>>
>> Fix this by following the approach used by TCP: allocate the zerocopy
>> uarg (if not provided by the caller) before the send loop and attach
>> it to every skb via skb_zcopy_set(), which takes a reference per skb.
>> Each skb's completion properly decrements the refcount, and the
>> notification only fires after the last skb is freed.
>> On failure, if no data was sent, the uarg is cleanly aborted via
>> net_zcopy_put_abort().
>>
>> This issue was initially discovered by sashiko while reviewing commit
>> 1cb36e252211 ("vsock/virtio: fix MSG_ZEROCOPY pinned-pages accounting")
>> but was pre-existing.
>>
>> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>> Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> Closes: https://sashiko.dev/#/patchset/20260420132051.217589-1-sgarzare%40redhat.com
>> Reported-by: Maher Azzouzi <maherazz04@gmail.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 83 ++++++++++---------------
>>  1 file changed, 34 insertions(+), 49 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 989cc252d3d3..1e3409d28164 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -70,34 +70,6 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>>  	return true;
>>  }
>>
>> -static int virtio_transport_init_zcopy_skb(struct vsock_sock *vsk,
>> -					   struct sk_buff *skb,
>> -					   struct msghdr *msg,
>> -					   size_t pkt_len,
>> -					   bool zerocopy)
>> -{
>> -	struct ubuf_info *uarg;
>> -
>> -	if (msg->msg_ubuf) {
>> -		uarg = msg->msg_ubuf;
>> -		net_zcopy_get(uarg);
>> -	} else {
>> -		struct ubuf_info_msgzc *uarg_zc;
>> -
>> -		uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> -					    pkt_len, NULL, false);
>> -		if (!uarg)
>> -			return -1;
>> -
>> -		uarg_zc = uarg_to_msgzc(uarg);
>> -		uarg_zc->zerocopy = zerocopy ? 1 : 0;
>> -	}
>> -
>> -	skb_zcopy_init(skb, uarg);
>> -
>> -	return 0;
>> -}
>> -
>>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>>  				     struct virtio_vsock_pkt_info *info,
>>  				     size_t len,
>> @@ -317,8 +289,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	u32 src_cid, src_port, dst_cid, dst_port;
>>  	const struct virtio_transport *t_ops;
>>  	struct virtio_vsock_sock *vvs;
>> +	struct ubuf_info *uarg = NULL;
>>  	u32 pkt_len = info->pkt_len;
>>  	bool can_zcopy = false;
>> +	bool have_uref = false;
>>  	u32 rest_len;
>>  	int ret;
>>
>> @@ -360,6 +334,25 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  		if (can_zcopy)
>>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
>> +
>> +		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>> +		    info->op == VIRTIO_VSOCK_OP_RW) {
>> +			uarg = info->msg->msg_ubuf;
>> +
>> +			if (!uarg) {
>> +				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>> +							    pkt_len, NULL, false);
>> +				if (!uarg) {
>> +					virtio_transport_put_credit(vvs, pkt_len);
>> +					return -ENOMEM;
>> +				}
>> +
>> +				if (!can_zcopy)
>> +					uarg_to_msgzc(uarg)->zerocopy = 0;
>> +
>> +				have_uref = true;
>> +			}
>> +		}
>
>Surely that block should only be done if can_zcopy is true?
>And shouldn't something unset it if info->op != VIRTIO_VSOCK_OP_RW ?
>If the msg_zerocopy_realloc() fails then can't you just set can_zcopy to false.
>
>It info->msg->msg_buf is already set then I think you have to disable zero-copy.
>The caller has already requested a callback - and you can't add another.
>
>In any case by the end of this can_zcopy and have_uref are really the same flag.

I kept the same approach we had before, trying to make as few changes as 
possible.

All these potential issues seem to be pre-existing and should be 
eventually  addressed in other patches IMHO. This patch one only 
resolves the main issue of calling `skb_zcopy_set()` for every skb to 
avoid leaking pages, etc.

@Arseniy can you help on this?

>
>>  	}
>>
>>  	rest_len = pkt_len;
>> @@ -378,27 +371,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  			break;
>>  		}
>>
>> -		/* We process buffer part by part, allocating skb on
>> -		 * each iteration. If this is last skb for this buffer
>> -		 * and MSG_ZEROCOPY mode is in use - we must allocate
>> -		 * completion for the current syscall.
>> -		 *
>> -		 * Pass pkt_len because msg iter is already consumed
>> -		 * by virtio_transport_fill_skb(), so iter->count
>> -		 * can not be used for RLIMIT_MEMLOCK pinned-pages
>> -		 * accounting done by msg_zerocopy_realloc().
>> -		 */
>> -		if (info->msg && info->msg->msg_flags & MSG_ZEROCOPY &&
>> -		    skb_len == rest_len && info->op == VIRTIO_VSOCK_OP_RW) {
>> -			if (virtio_transport_init_zcopy_skb(vsk, skb,
>> -							    info->msg,
>> -							    pkt_len,
>> -							    can_zcopy)) {
>> -				kfree_skb(skb);
>> -				ret = -ENOMEM;
>> -				break;
>> -			}
>> -		}
>> +		skb_zcopy_set(skb, uarg, NULL);
>>
>>  		virtio_transport_inc_tx_pkt(vvs, skb);
>>
>> @@ -422,6 +395,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>
>>  	virtio_transport_put_credit(vvs, rest_len);
>>
>> +	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
>> +	 * skb_zcopy_set() increases it for each skb, so we can drop that
>                                                            ^ must
>
>> +	 * initial reference to keep it balanced.
>> +	 */
>> +	if (have_uref) {
>> +		if (rest_len == pkt_len)
>> +			/* No data sent, abort the notification. */
>> +			net_zcopy_put_abort(uarg, true);
>
>Is it worth optimising for the 'nothing sent' case ?

What do you suggest doing?

I followed what TCP does.

Thanks,
Stefano

>
>-- David
>
>> +		else
>> +			net_zcopy_put(uarg);
>> +	}
>> +
>>  	/* Return number of bytes, if any data has been sent. */
>>  	if (rest_len != pkt_len)
>>  		ret = pkt_len - rest_len;
>


