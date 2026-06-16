Return-Path: <netdev+bounces-299732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fImMGqzTMGooXwUAu9opvQ
	(envelope-from <netdev+bounces-299732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:40:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F7068BEF4
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:40:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=adEh8vTW;
	dkim=pass header.d=redhat.com header.s=google header.b=qwULlY4i;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299732-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D703031AD0
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F0E3C661C;
	Tue, 16 Jun 2026 04:40:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C03C5836
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 04:40:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781584808; cv=none; b=ned+zuvClOIJjZGCQvhKm7PtRSWZj8k4E/d9juqa6lkOUx27ghWtFTUS6apIjigqE5E5paT9cStT5guVUlQT3HTNSOybo2G2HNQoksbAXU403/WRiFrbUP36sHi6ih1cDYF+ZIfNy4DiSOzJ4Q83srIJk6UVQQVL6Ww/6nCcXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781584808; c=relaxed/simple;
	bh=K0KBXkkerxODXYIYqDg633MvdlbzP4uKtATH407a6no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpfDFrpuo/SQH+WlgH5qi9gw+1RWQJ/UXQw8+Zo7Nr67k5VTRcAztj6Qo4FsTfXm7aFwoS4hZUhCv7eII/xUPpSRmCTp/SGeQ/7VNzGNxjyDCBKXvOb/+dAGQhDgTHgeMpITIh16oIoo0bQViXNFBvkXasCdlCnHpbT5dJfTvtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=adEh8vTW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qwULlY4i; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781584806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fa+y+4svYLao6WVKf5RjVtNUrFzhHWJGrO40meUSAic=;
	b=adEh8vTWHQ6tTp7RWjgsNgt8iVkp7bWttAuD2lRlK1YAU3q47DKMM++SN4p/53BScyIREX
	90cDTTQi1uGH+NKZMV6QhGaV0MGX1XGJwf3WVH7HW0fBu6z+Gteu/HnUapSTb9uk3J+llI
	xOP7o1fWS19nPV7CGiOATrhOD3h5pk4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-zU4IzQ9iNtGQRdxRgS3-YA-1; Tue, 16 Jun 2026 00:40:04 -0400
X-MC-Unique: zU4IzQ9iNtGQRdxRgS3-YA-1
X-Mimecast-MFC-AGG-ID: zU4IzQ9iNtGQRdxRgS3-YA_1781584804
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460153ce644so2958862f8f.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781584803; x=1782189603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa+y+4svYLao6WVKf5RjVtNUrFzhHWJGrO40meUSAic=;
        b=qwULlY4i8lxb/RUDrw3UDAD6ph27ES3FNPOyB9+ke03fGdhIydQvle9q5vOjx65pAR
         TPum1GgfkNO76EIXjFsNEYQyPT0+oWGkNy4Ei6gEdZYVbZJhEKFIvmBLOn+is0ZMMKHi
         fXyjNGB7WaOYcpojIpMV5vBGN/I5Yzw/55IbCkEyb3gzRtQtOy2M6iqSm89fbhiNGXWE
         Yo3la5GzoYWikmcIkdUm3CPBQ0cmW2EyuXvSlSUpMeMRNr98jbm+uVJ/FU3IaoDSgPZG
         hM3gQLInLrxx4Ajukcm0QphgdXdtyHHJMmzNIsCx03eadqtkj7qWWsByh8s4kvO30sGN
         Tlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781584803; x=1782189603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa+y+4svYLao6WVKf5RjVtNUrFzhHWJGrO40meUSAic=;
        b=ple02Td+CdNRiipqn+/2XbFyu0zqwfgcgaEQqHGBvLlui5ky4IXDlTlcVw5JxkufKM
         rfCwwGXNClqjfErlNXZYlxNMRU0lRt/vrmmx/inGCMT5Lj+N8jRYL7+8w5WgdUiDTy9R
         XOxNCF1+LNdeJmjumFUpaSgGK7p/Jg5bQZUF0bEM2rHJtWo1uPzey1ijyUL86QohuQ+L
         SCgHnRtmc/XU/3VPlzISMQ5yugvXMlPMM1pTZ5Lu6FQoJ6m6jqcV6UZoHFA+qM39vVJi
         DOTvKHBMwmyWBdDhZIPVWOyNGQqphT/u3Q+wWHEEAi7PUBGMovKqF9Vp5T0uCWUQhAc3
         77DA==
X-Forwarded-Encrypted: i=1; AFNElJ+1i9qUbDc1o8UdwuPybxhEs5V4Du/Un766q0ulJWB0JQplctCv+MKPZtqsbl27Lc360XczzRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxgnWQkhLCa1JDWy0IsgFjdhWS6tKATTX9Ir8NV1iR88ROgEJS
	I8GC91GodQxpbTghmyzx9C8Mf4oKVVvxfB+bu2NH+5NQvNF6eQeWdtThBnWFDIOLRmpA/wXEMIe
	TPeuZ4aFkPw/KsducHAOR/YNFNsUCrTZ5CO6zCjuCzTm4xaMouhKxDKVMVg==
X-Gm-Gg: Acq92OFwh/zPgUbo/3i8MNMP6ARlLaN+2P8mk/i++zOdA4RXV/Zur6szM1vJuR9Uo2l
	j82pQpl9HTCynYQhWhULj6CBExN26zk8zz5YO5dKoJNZzIWa1EDEyEuBdY/qKyEVpdb9ud2J8yo
	pyoMs36TrLfCxTQAXin7SewcH/RHj805CqRxo70wg9lD+igaICTU1vTWGF0KYV+RjM9J/E0SP3q
	LpEJCJGQoSm6MY8q+aCjeFKXK5rSaLBCpZCXn5eEt9DeDTuJEJWnvCrSAIx3EP0NlBukQjijQ7r
	QYvH2F8AwWoUGuR8hYEn3tKDstFNjrcQktHnjcNAjxfBKaaXWeIyUyn9Y6LaVWVBQ4vTp2Tb1DN
	FbM3lFvALmcjrKnFeH77BGfhru+0U25E/kU1qDxSqPjk=
X-Received: by 2002:a05:600c:4e8c:b0:492:3173:b17 with SMTP id 5b1f17b1804b1-49231730dafmr4650615e9.17.1781584803453;
        Mon, 15 Jun 2026 21:40:03 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8c:b0:492:3173:b17 with SMTP id 5b1f17b1804b1-49231730dafmr4650265e9.17.1781584802949;
        Mon, 15 Jun 2026 21:40:02 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a4ff67sm23740805e9.6.2026.06.15.21.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:40:01 -0700 (PDT)
Date: Tue, 16 Jun 2026 00:39:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
Message-ID: <20260616003903-mutt-send-email-mst@kernel.org>
References: <20260616042837.2249468-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616042837.2249468-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299732-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9F7068BEF4

On Mon, Jun 15, 2026 at 09:28:37PM -0700, Xiang Mei wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
> 
> Bound len by the size add_recvbuf_big() actually advertised.
> 
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v4: use easy to understand math to compute the max_len
> v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag

I still feel 2/2 is good defence in depth but it can be
pursued separately.

> v2: add additiona check as 2/2
> 
>  drivers/net/virtio_net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..8f4562316aaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
> +				sizeof(struct padded_vnet_hdr) + vi->hdr_len;
>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>  
> -- 
> 2.43.0


