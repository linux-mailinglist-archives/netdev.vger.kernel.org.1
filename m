Return-Path: <netdev+bounces-295854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 84apOQ7oImpAfAEAu9opvQ
	(envelope-from <netdev+bounces-295854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:15:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33C64931F
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 17:15:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d5BrtvbM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295854-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295854-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C12203071B26
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 15:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48740960A;
	Fri,  5 Jun 2026 15:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10473BB9F4
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 15:08:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672141; cv=none; b=k0jxrvbStYAui/dm8ktJTSHKVnBxEwMgS9db8qydqzaPUu6lGwZ7TZ8/7jtkpvuOj5BcpUVLnZ/ebSlENlOZZYusCq+OiaFCDBOV8ZwD4isfKTksrU62LS/T3L+FOsPKp6+ec6c5zBuiBQmBCM6Ef+1LaDT8kUR8eVmgmBenH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672141; c=relaxed/simple;
	bh=HtxAlA0bpzrKu0Tr9l4oqmpPC0VovkQ79lbq7PZ+w0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0kp4FZ0jEYkuARXu38dwegnZiyZajHsffECm5mbJ1RDEdPllfC0w0LEvmyR+lLGNoKwi8jAbiHQ01lnK+f5SxSy05qDeAa111KHMPjN5Bb5ocUbA4b7HenB4eDpuUtOFCwMjDs7RZVilTyngyUDw0/ehlRPHswLMz3YtuPJW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5BrtvbM; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45ef5146b56so2029386f8f.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672137; x=1781276937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgCzrE/kcx5xV+VBfBM1xmyxfRLG6AWjmyf9O3n0QS0=;
        b=d5BrtvbMXEDCgZvCQNMkXEn5ncEoQFAE+6s9Uyu8L88v59qY6BebWcFhmu+TOxtilj
         JvMQiLvjTaNwMM6O60kXDlHIoIfJBtSZ5rcFyPj9I8fSD3zsQNA8wIG5ET/xKCX+YEGr
         9OL82xz9iSOPVy/1v16IEmF+TmvSZTgwg8v6gGUWJ/0Zubs5XTaqzZwyGAWDBisrwSho
         d0WFTPJaK+YRA/YhNHa03QIaTfKnUq8koKcOh7nxi5V8CM3Q5SWniZ2sgW0RwGhfd2WV
         SNQQJt+3bD9MyF61Cd6k0XT7MlSF1XQdUUHm0hcUmjNMjNaoN1Ahrve9VTkVEf/0vO+k
         1znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672137; x=1781276937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgCzrE/kcx5xV+VBfBM1xmyxfRLG6AWjmyf9O3n0QS0=;
        b=FEaeigjoKO5yyaHsN6mvoMoxzUnLkM3c5y0KldcfsDtYHrWy9/g3MO3DgPKu34epV8
         brj+4grDtKJR0InpSutZKWKmAbXnjBp78oePtmQv8iNugVQIbRX6wvtokCN1EpxtygAJ
         2U/d0/nZg2F4guSMMfVVPfvjHJKLePJ7blSujvGhf+5oFmX8hkhm7qbTyIhnsP0cldor
         oYbnCAnHIdewnK0KzT/90uSMLcXs+jmellhW8iVMj6O+qxt8ONb4xMQiTjq3CU3p9KUO
         JWDaEGtUo/x26li4gW6k3AyeF8nNj1dopQXgs4x38GhDPzRtXeo/kQ/Ubsjt7gJ7E9i0
         VqnQ==
X-Forwarded-Encrypted: i=1; AFNElJ//fpWn63LMN5gJrr84mlQMf8dNnFLoKJMnFJLgIV1ExigjlwQ3t2U5+EQiEY9xpqxERIs6LmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyStLGiHCH8HTF579v+IujOQgpCGd5t0XVBoes9ckhns++OzFWd
	KE+RLR2dolejD+Y4OmiUz2R7hP+aw2GMMhF2g+7oWwdX99GznYfo0Wnx
X-Gm-Gg: Acq92OHSM6JirSw+xU/N+2CKaihk81gXFp8By/j/RSouGkzgTvStHih3cGkHpowQOFx
	tslAl+JtXSrfABzcPzH8NHJ1qPe7+VqQoJOtDtX2CzTjWUMqSK2GNrjhtICXUxGNQ6rUzqj6uPG
	Zh6M6edv8NxJJ/xiuncokQS7PWMJSa4rnBthprxe4ViaRQaxexl344AgUW6vjryVgws/gCqIrhL
	OdNDYUORhDpDIEcpwOeIHrRMQlCaEG4BFtzllEujCA26R7jJsjRBEDS6Qx6+MLx14OxzTKGapew
	FoyXRa+22PJhaK7suGjpwYtcitFGNoIMGITyYSiBPyZQgpNWRLA0jdeVdb8oHextDvh+tj23hiL
	SOPNW9bnqQuiHyjEGsbwvSmKSVh6DQ2F8q5Si0rracAYY58A4svyNI2NtqXTk7iTOe5GhO0UKbS
	01OpBbhUTdz/2aWudsa608NshbvQd0HbAxyC38WUlBdho9SezTTNRTivn8tHqf3oQRZXA8LPVG9
	dSB2LdOOw==
X-Received: by 2002:a5d:64e5:0:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-46032da19dfmr5307301f8f.16.1780672137010;
        Fri, 05 Jun 2026 08:08:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm44178439f8f.27.2026.06.05.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:08:56 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:08:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260605160851.3ddbd2ed@pumpkin>
In-Reply-To: <20260605115314.552321-1-avkrasnov@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:jasowang@redhat.com,m:bobby.eshleman@bytedance.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,bytedance.com,linux.alibaba.com,vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rulkc.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F33C64931F

On Fri,  5 Jun 2026 14:53:14 +0300
Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> Logically it was based on TCP implementation, so to make further
> support easier, rewrite it in the TCP way.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 2fd9eaaf5ca6..00caeeaa5590 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>  				     struct virtio_vsock_pkt_info *info,
>  				     size_t len,
> -				     bool zcopy)
> +				     bool zcopy, struct ubuf_info *uarg)
>  {
>  	struct msghdr *msg = info->msg;
>  
> +	/* We have completion - attach it to 'skb'. */
> +	skb_zcopy_set(skb, uarg, NULL);
> +
>  	if (zcopy)
>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
>  					       &msg->msg_iter, len, NULL);
> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  						  u32 src_cid,
>  						  u32 src_port,
>  						  u32 dst_cid,
> -						  u32 dst_port)
> +						  u32 dst_port,
> +						  struct ubuf_info *uarg)
>  {
>  	struct vsock_sock *vsk;
>  	struct sk_buff *skb;
> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (info->msg && payload_len > 0) {
>  		int err;
>  
> -		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> +		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
>  		if (err)
>  			goto out;
>  
> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>  
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */

I've not looked at the tcp code, but the above doesn't look right.
I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY set.
That would give the outer code a callback when the last skb is freed but
still copy the data.

I also don't see the point of calling msg_zerocopy_realloc() to get a
callback when the last skb is freed and then setting
	uarg_to_msgzc(uarg)->zerocopy = 0;
so that the callback doesn't actually do anything.
It isn't as though you 'find out' later on that you can't actually do
zerocopy.

>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
>  						 src_cid, src_port,
> -						 dst_cid, dst_port);
> +						 dst_cid, dst_port, uarg);
>  		if (!skb) {
>  			ret = -ENOMEM;
>  			break;
>  		}
>  
> -		skb_zcopy_set(skb, uarg, NULL);

Aren't you passing uarg through two function calls instead of doing it here.
Doesn't even make it clearer what is going on.

-- David

> -
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
>  		ret = t_ops->send_pkt(skb, info->net);
> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  					   le64_to_cpu(hdr->dst_cid),
>  					   le32_to_cpu(hdr->dst_port),
>  					   le64_to_cpu(hdr->src_cid),
> -					   le32_to_cpu(hdr->src_port));
> +					   le32_to_cpu(hdr->src_port), NULL);
>  	if (!reply)
>  		return -ENOMEM;
>  


