Return-Path: <netdev+bounces-292412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB84LiAqF2qn7gcAu9opvQ
	(envelope-from <netdev+bounces-292412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2F45E8511
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F4A30125FC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC944D00A;
	Wed, 27 May 2026 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIW0v5z+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOEM50Ys"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D732D7F8
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902527; cv=none; b=XwhJLpHaeDyTpvNMrc+XRWlX+LS9T0VOUh/1OO9p5LM8Osc2Dg+qTCN3lKjBRoQOc/me2l0JX1/4Gq+sKEsr7f2ugE6JNSGpIjirxW9Zk9PQC8t0l6CjPjQc5VccmMRYA6cHnPJTLIR+MUZelTck4srjfz8YJ22SzrWxUA3ZrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902527; c=relaxed/simple;
	bh=CPbqDF454Z+Ji6GvjieOLoul6JPLkeDeLkJZd8vBXK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osVW1e8Rg0PHO0xKab2fqOYLR6zFAYJoqEIFAvi2gxl/NgAMEhjnK6phSC1CFcdvI4ZV/iSQFUl2JETsxoz4i4ahsEadDNcmMmYHnS9trDW42tSEXq7lgVJPY8AEizFEGdiNn9vLPwYBnCyfIP+HJ8W0TXsf8N6q68eHHem8AAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIW0v5z+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOEM50Ys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779902524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
	b=RIW0v5z+/A2bgnSZBypcBlJ4mL6YEVobKJHdPIddruUEvX92N6XNtaIXVoCwoCvyaKIRQC
	ksCM0v4O+HkxVSB6+HYgdHyRvjmlQWmpWNfZlegUyWMUGsTEgHQa0H8E0ULTiqDsm0iHP+
	0WWiZt2BBi/Va1YB2bvd0bd7Xtm7CKY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-olVygzYZOSqST5Jvcmh4og-1; Wed, 27 May 2026 13:22:03 -0400
X-MC-Unique: olVygzYZOSqST5Jvcmh4og-1
X-Mimecast-MFC-AGG-ID: olVygzYZOSqST5Jvcmh4og_1779902522
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso73238975e9.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779902522; x=1780507322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
        b=eOEM50YsFf+tfxXTQ7WjxZDb37lhfZHvWuJlqo0Wf20yS8b3qx49e0DMDxSPtKizdX
         s7qBh1XOpGTcNOWBnRhesTo/1RbEaOHHj5L8eYO/e5Yw99wl6DySlWffm7KCfZReH/A1
         PXzjbywddZeEHLIrX6EOylX0WDukVUPbqJjiggRH7RS9YGh0wEGFuCMtc9ugYgrQ+Ndv
         hXds6frC6eFoOr7R2Pqm954M4E6ipiT2BmNOqja62Q18vg4E/BJI2ikJHDvsZLT9qhF7
         Xysrrkxq3OkrrP/n6tBx89utVptf8WmdvHfklhJeSeP4nu1rHSyKl3XT4C4vS+DgjN1c
         QRCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902522; x=1780507322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
        b=p2BYHmToo0hq9f8GeUrAlAEIW4DN+Aa4o4jtz75ytRY2peCp4CmJ5VCHiEnG/0P46E
         o0JJmF3TqG4jhMAd14QgZ4BlSaN0paaQdghB44EfhgLGYU5paEMdGSSXYZxwSxKAbTA3
         OyktV3zMuCuTu37fQBRmDJDWvM8WsYq379dCCepKBp/LWaVjWK8ueUbmSTZHV0Srhr8G
         LGcDhdRQoThiUNCjjYpFU86rLeRMwalBp26zBhCPtpL+3H2TfWG21rKT0lVhcysEUzYz
         r5V1KeV8KjJng6k8bxPM4A5wmNu2BlomzaSgAC/hvTBVKavLj3vriQerBpHFvZQzFOyL
         SRHg==
X-Gm-Message-State: AOJu0YxPTq84BWwvbWpxDAM/LhKHN2ZRKAT4h/5AmViF+blEKKnlUEnd
	klP/ZUbjFMNIKfHBwIe2O1Hh4RUp6PPnY5ofoy3+aQVoy0uDzpqgf9XiNFV4pdqEyKpljVPa3IE
	mC/Pho3Kf8F15SIoVE2dXyqshfjXXb5jDhJtOyfLAiV+PX8Sw9f4WkkZ+pg==
X-Gm-Gg: Acq92OFVQp7rKk/x+yeTnYsKgV9WkniA+Cvef4Wt93j89Z+hJUIAnfG0tsDDoKvQav0
	m9Kr/KWPKIf3KC/9IYT5DaZkfu9vTqes7b/ivZhAficf+pSP2gAqYBBdaw2LHARDtYfeqdREEvN
	+8gcGns8Vtpufk2GBnW/4OgiZK+kiwS4ZjPhrC7kTJppNy6IkCCooiZLuBjMBPlSddjhoFR5K+N
	XukKEgX4sP87dZyRuERkSxmtxv16fcSrRqd8cU3eoYWr4fqr6NOZ/S1wHDnJzXM8oYvAoq3SOz4
	v6TieD19ZfJdH7a60PhSd2S/fYIUWlV2w2+ZKWwEpF9nf0W91V8CKlQOiGWhyWinwcTru9vOGcN
	5NLu+jxD8iWhz
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447993275e9.30.1779902522038;
        Wed, 27 May 2026 10:22:02 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447992735e9.30.1779902521535;
        Wed, 27 May 2026 10:22:01 -0700 (PDT)
Received: from redhat.com ([31.187.78.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee2a12a69sm315565f8f.16.2026.05.27.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:22:00 -0700 (PDT)
Date: Wed, 27 May 2026 13:21:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on 32-bit builds"
Message-ID: <20260527132150-mutt-send-email-mst@kernel.org>
References: <20260527171046.130211-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292412-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,redhat.com,lists.linux.dev,kernel.org,linux.alibaba.com,google.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E2F45E8511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 07:10:46PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> overflow on 32-bit builds"). The fix was semantically correct (although
> it would have been better to use mul_u32_u32(), as David pointed out),
> but in practice we are estimating the memory used to allocate the SKBs,
> and this will never cause a 32-bit variable to overflow on a 32-bit
> system, since the memory would have run out long before that. On 64-bit,
> SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> already in 64-bit arithmetic without the cast.
> 
> Let's revert this to avoid unnecessary 64-bit multiplies on the
> per-packet receive path on 32-bit systems.
> 
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b143290a311d..d4d26fba9e37 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> -- 
> 2.54.0


