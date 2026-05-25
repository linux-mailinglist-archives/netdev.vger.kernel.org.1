Return-Path: <netdev+bounces-291295-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDnfMs8xFGqUKgcAu9opvQ
	(envelope-from <netdev+bounces-291295-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:26:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B83C5C9ECB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F078C301C91E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4737E2EB;
	Mon, 25 May 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChAz+QjC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lmgy4AaL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072033BBD9
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708349; cv=none; b=BUmvam0aCxNGZ/huovsws/jvFXJ0dYOhPuVNSm08ysG/rQfE3e+nk88hkGHapfcwNzk/ABxJMUr+Z20c516bbRiue+sx/BKAoulEkouNbRi4gYJdqr2HO2I33TqXTTtfRgPrS0y9GUQ9YNZlHkvK5cLup1RXFBqQrWD5onNB0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708349; c=relaxed/simple;
	bh=zuX0Di4TKhnMq54tvjmHDzO+X5SQw874TgobIrg3T80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUnQPCp7dTJUbKfZ7JGqU8teBxr9/1R82rUocFx9gto3625J7EkHieY9cFGJH+1C+Cm2Nf/CbjGx1Pv3IIXMKLTYBU+KvFgdXTMSta4KDJlpZZap919nP5iHOpWyEtBKtFYZdxJsezACU/IAiK3BYYjwwCr2HgLe44tCymilcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChAz+QjC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lmgy4AaL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779708347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IxQxHR/6kpLhzpKQfpUJefi9nFgXyGkAWeI40YgJOo=;
	b=ChAz+QjCeyw5nQWNTdDrt36Nz8F7JjIMwIQIBvD3XwZh2KV0D37mBv8YowQ6g1Ntht3A7u
	ntb98HQ4cBL71XNKuhxQzn3ZaxDwM86fNZvu/gJHT+sxRD/S+W3jj9pU5uQO4jt7yiP3y9
	lDF9qoh2zyAULNUjnWHSqlZMZRspLuo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-FRKJFYDmPoW4VUsXalta0A-1; Mon, 25 May 2026 07:25:45 -0400
X-MC-Unique: FRKJFYDmPoW4VUsXalta0A-1
X-Mimecast-MFC-AGG-ID: FRKJFYDmPoW4VUsXalta0A_1779708344
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49047e22ed4so22427625e9.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 04:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779708344; x=1780313144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7IxQxHR/6kpLhzpKQfpUJefi9nFgXyGkAWeI40YgJOo=;
        b=lmgy4AaLlJfOdThQu5yi+DCX8IwCo7BVxLO/aaXkN98Fy/FfcDdA+Vhq7wrfndnGlu
         6IiyWYnK5fmNaGKMOgc8Q0rescBU/gD9DErPgMS41DrH7NpZ6KoeXO8XDilylLpB1eNI
         wGjzoij19PRsgzzW6Dz/W1x0XSjzs6xB2/sldWEemCQaEddiaIxoa2eKCxlVCybrMRaN
         X4ZELGBV/u2O+JNv8BTyWl3gHUkOXWUh5wtaAHx30GoP2ZEWHpu+hMYwFuLHqzMFg5rm
         /NJHI94zk+OHiC+tb2W9iEwj0ZP2QHYRRzgi9+EB9whMq3NJ5riIpDNG8j9TmoAUDb9y
         7TRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779708344; x=1780313144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IxQxHR/6kpLhzpKQfpUJefi9nFgXyGkAWeI40YgJOo=;
        b=SsgjrLa4MLTHUSKJSqTAYuOyOaPolU2acfo8hkucjZID4AUVEFdHujSe05h5/ixH8w
         Sj2E8nrOZj93VoqEpT+XtH/poQrzkpWTah4CFEwVgkA9TlwMnPUzfB9hA5UpWHJfLXLq
         IOjpO/Vwpe4FwpO5u2Ttt8lI/fJI2OfB4RVJoa6tO3/1GqolT6l2ceF2MKW0iSGRtQLC
         CHjybkMdrXEvgMqgDbTc+Q9zgQWgqhcMFaZzMED64xr11G/ahEsiCU0t+4k41QSDpQ3W
         1YuL7aSTu8U4b+oI5AFwPP6yQsNYPJ4iY0ssIgBjPshikBEYPKXxGxOavsbdNu8bX+KU
         2O7A==
X-Forwarded-Encrypted: i=1; AFNElJ/qtKyrurKbR/2s5/uFP4Y1+QOQbM/E9xyJifxwNF4LmJ7yLXmOBEakd8y/kEZ6UKcXs9peapw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/JRVj4jXNcByHtlWX+Kjq5rrzaNUgiAGtqUZBxxbN0orgvK/
	fVUXv8HEXoncxi7k6tS6PCK4xD4lKe9g1ytcNA4UN6ttNXq4mRZjV1gQhYS/IP4iU0/cg9RkibU
	d5waOZH9ZTfiZu2uJcpgqMJTRDc9agvo6SdfPONNbQtfrP3lUboG2WNGFAA==
X-Gm-Gg: Acq92OFNHTBXcXuGj7+2HTmmSIHyIFbXZ+vMPyEvaHfZcKrnmCtD+ZLDx5z/cdCAOcl
	xZhxsM5Hw6NuouH0ktVXumJi1r9ach39C/bCqbomWHz/kIBk1DreDIgYF/Tej7Xrn19LldXe9Lf
	8YgzJvVzf1BYOEHC9/D4+mMFPNSlCmVB1Y8ASoQ0X6zrdFR9F/c6/Lktjhmaplozp0472t15d8G
	h/s84QQlvybM6XCnDI0OmVawE3B9dif4iOXi5y5fR7elGX8YjgS2Xs5nLGBmGI3+lYj/guhe+bI
	TMR1x28Tv919XP0ca25Iy9guXwcSaX6FTftqAC+JhlDB/uGMx4aIbZ0TxH//LBp1RoXCPIsADqL
	a/hF/88lydY/wKilQ7bCASIFf8jWWU0YubmjwjmizNHc=
X-Received: by 2002:a05:600c:4510:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-490424a682emr215601195e9.10.1779708344018;
        Mon, 25 May 2026 04:25:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-490424a682emr215600375e9.10.1779708343354;
        Mon, 25 May 2026 04:25:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm268455945e9.8.2026.05.25.04.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:25:42 -0700 (PDT)
Date: Mon, 25 May 2026 07:25:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "malin (R)" <malin89@huawei.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	tanjingguo <tanjingguo@huawei.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, Chenzhe <chenzhe@huawei.com>,
	cenxianlong <cenxianlong@huawei.com>,
	cuirongzhen <cuirongzhen@huawei.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Message-ID: <20260525072533-mutt-send-email-mst@kernel.org>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291295-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 5B83C5C9ECB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:15:12AM +0000, malin (R) wrote:
> >From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
> From: Jingguo Tan <tanjingguo@huawei.com>
> Date: Fri, 22 May 2026 19:53:45 +0800
> Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
> 
> virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
> before entering the send loop, but virtio_transport_alloc_skb() still
> fills the skb before it inherits that uarg. When fixed-buffer vectored
> zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
> managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
> to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
> skb_release_data() falls through to ordinary frag unref.
> 
> Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
> before virtio_transport_fill_skb(). This keeps control or no-payload skbs
> untouched while ensuring success and rollback share one lifetime rule.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..73f58925ff72 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -205,6 +205,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
>  static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>  						  size_t payload_len,
>  						  bool zcopy,
> +						  struct ubuf_info *uarg,
>  						  u32 src_cid,
>  						  u32 src_port,
>  						  u32 dst_cid,
> @@ -245,6 +246,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (info->msg && payload_len > 0) {
>  		int err;
>  
> +		/* Bind the zerocopy lifetime before filling frags so error rollback
> +		 * frees managed fixed-buffer pages through the uarg-aware path.
> +		 */
> +		skb_zcopy_set(skb, uarg, NULL);
> +
>  		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
>  		if (err)
>  			goto out;
> @@ -364,6 +370,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		skb_len = min(max_skb_len, rest_len);
>  
>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
> +						 uarg,
>  						 src_cid, src_port,
>  						 dst_cid, dst_port);
>  		if (!skb) {
> @@ -371,8 +378,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		skb_zcopy_set(skb, uarg, NULL);
> -
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
>  		ret = t_ops->send_pkt(skb, info->net);
> @@ -1183,7 +1188,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  	if (!t)
>  		return -ENOTCONN;
>  
> -	reply = virtio_transport_alloc_skb(&info, 0, false,
> +	reply = virtio_transport_alloc_skb(&info, 0, false, NULL,
>  					   le64_to_cpu(hdr->dst_cid),
>  					   le32_to_cpu(hdr->dst_port),
>  					   le64_to_cpu(hdr->src_cid),
> -- 
> 2.53.0


