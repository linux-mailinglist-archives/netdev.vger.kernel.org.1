Return-Path: <netdev+bounces-290424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO+6HKoJD2oHEgYAu9opvQ
	(envelope-from <netdev+bounces-290424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:33:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6A65A5DD6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C407328356F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF8A3E5EF0;
	Thu, 21 May 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9VLScIj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzUwknpy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DA3D5C07
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368985; cv=none; b=IuM4XFncWs/S2uhZW1KHUTrwY6Tg10fEW4qvSBNKw6u+7ZQj7GW0FZD5D+b5m8dneSveVl9QRVH5xSM9xGc3NhfRFuI5xCKxPl/WahvjmQCTP6uEVOBg3unrLxwjxiVnMGeME0OR+BnDtuta77GEPM6Kl9/mncU4uRkgGu0MHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368985; c=relaxed/simple;
	bh=Jdm389GpaXuX2GWxlZhF6BpB83Vj3ksApFOhdPl2pZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCJMyuX1JWfoxUaep9Cr6KnoDo/f+SrTCTykGJgISpWwWfXYgGW7K2AL5SaLJmEd2OVZA7bxMuuey0qRigsXta1V2VH3QuLXTbhyvN4U3np+Vi/3yYa2RwAhWJn2pAHhXYJ0wxtZ4g6n/ZJ3xTK41SlSRcVrsyt3I4QlDasQONo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9VLScIj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzUwknpy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779368983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
	b=V9VLScIjN+NhBKis4WUCTC2eyMjIRWjSwj2roLaAjHk8+GhLBsQy0RF1x7wi0vjDhb/apA
	78TIbboWCWPAs0V37GtcSQoagELJTvQbNi1bLCHuBQNUpUz1u8RZpASjjpP6AidYZL9Zku
	RN8P/o4o1OuzVIPg05g9S56TYHuUFvQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-op--vcQtNd-M1cwAZEEN3w-1; Thu, 21 May 2026 09:09:41 -0400
X-MC-Unique: op--vcQtNd-M1cwAZEEN3w-1
X-Mimecast-MFC-AGG-ID: op--vcQtNd-M1cwAZEEN3w_1779368980
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so4814561f8f.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779368979; x=1779973779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
        b=gzUwknpykZJdMmq0ET5kHWWnIm59z8iScuw46XJl9HO4MtMct0S31JS9VQIqQS2Qmt
         qBI8bstnFhn27TxXDNzbtmsdowmCgKD/zzRC1Q4GtV3i7YFEWUyPcdp0V9CyN0tAu3lY
         rIXs7R3AKxDLQ7tw+s1Cm79+5P8EJ2WFsD3QGV2AMlxnkNVTV9hM233SYz0LvOgfxn8X
         kE8NdwFXAeyknjLtTifPCUm8ixQI578I4ZOsjrifkaf704+49owwj15NJRm5CdiuAcL8
         efD6eBJ65vXfLmHZAIZ4zgN/Utp5GvP2yeryupHCCarB9JLxDysDCkFq8yg0GMo4ltfy
         f6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368979; x=1779973779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
        b=DHU503Y/JLGxuiTzQ1QsHZOrhlI8rgktBA0+zMk/4QnzuZpbeTGyp7E8QRmJRTyLaz
         eOq8V3YQiX84OJZU2DEwxdtWi/h4idKCaUDoKHSgG//qxzKzz4hIrG/8LyeuthTyjtGN
         p5bqcKl7+qAt2dZ6unm/SPQ8cf2bAVUW2bAqm5yBm7aADL5bBLg0JvEy9uLGEINdfOZv
         gylT9LU+VC3bwJ9zm81JnvcQKrgkvH+qHOcGHS+0ftQbTPDQpxKvgdVOUX1GPSHCkVjk
         pTpnVou4csizA8d+rVXyDWnfTwJO0m0NWDnRcJ8073IoDPJtlxsKOrPff+9bFv3kffQv
         bVUQ==
X-Gm-Message-State: AOJu0Yzmu7fsMRzguTM6G9gwJ36pDLZ+fMYSBFyPdrEi2I2gQxglbyR9
	YzDR+ZesgYHiXavjVZYsO/9EsqHtefDZgFDHj0JmDUf1BesanoMDv3KOjRzUtMSckcWab+fFBop
	DjrwAASmgIL1k+QQsOLIDLMLeKm3F2cHJEF8pBHVz2/n5Ruo0D7R+1qHqqQ==
X-Gm-Gg: Acq92OGQSgoSdktz4dNcgYmfG5WPIA2mFWHrM6+Mkrjwtz409Cvwt+7d9NLas/jp41P
	1irWBT+fmdvYm51bMRToqiIkJosReyKCsYP1VTUBvR3czqhDfBf1FCOSaxx3mjWgW7Out4d9Kzw
	EHHJWCFqravqGI/WxlUokYnfj7r3sPjYxA8A3D6yuzRlZEW6R/j2U7/0G4Ep97//B9MYon6bhhA
	mS4H7RgnO26LlavfzYXgyHIqq89qnnW5ZVlXZ2V4vwrHZQLnA1McXaR03RlihhducbKtQJtC0Hk
	GYnnrvwZzq5fNEsG9XILP5yRqnb69U3ZeXJ031fn0OTe9t6sSRm7C2cR87AWmbX1iWwM9U0asAU
	CpIlGVs+2lcvQUdIwnDIGXYMgPoH7tPdkjkvVwZlVYdU=
X-Received: by 2002:a05:600c:a15:b0:490:3cef:bd90 with SMTP id 5b1f17b1804b1-4903cefbe6emr23446895e9.26.1779368979414;
        Thu, 21 May 2026 06:09:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:490:3cef:bd90 with SMTP id 5b1f17b1804b1-4903cefbe6emr23445975e9.26.1779368978717;
        Thu, 21 May 2026 06:09:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035edd7cfsm15236405e9.27.2026.05.21.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:09:38 -0700 (PDT)
Date: Thu, 21 May 2026 09:09:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260521090927-mutt-send-email-mst@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB6A65A5DD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:47:32PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> This issue was reported by Sashiko while reviewing another patch.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..71198bf23fc4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> -- 
> 2.54.0


