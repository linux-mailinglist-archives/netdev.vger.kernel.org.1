Return-Path: <netdev+bounces-251856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOiXDPLBcGnzZgAAu9opvQ
	(envelope-from <netdev+bounces-251856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:09:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B456892
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 951254617D1
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B503EF0D8;
	Wed, 21 Jan 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoZ9WNtn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TT4lfn2s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972753A8FF3
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997246; cv=none; b=iqOFM9T4xxUKTbFr5i0VzqzPEo07ClDCJKPQNqPHNfxcukxQe6zSGnTs/SYaqSmBI+K4fZOfMbcisJV2C/3eTnN3o8GG2VlUrqD/0T+QyzPU/wh2ajfGNpcXOCDOqhMSLE0N23JB8ZSkyDUIXMCLLFH3UsZBsxzdoMiTRlqIm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997246; c=relaxed/simple;
	bh=sRJH0LcPiGEMiEKO6ssQ7+EoDIhVQvOD4UKf23OY3vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uusR4KndNIaWZOC9uCWwsSeuOfkhgscb0A58/uEBwDG98BgQUaPybbLLAq5h5ZOiV26GapMPwpKmpVd/zm0JZbtbZOBPS8xLAuMu1FwDaXrif9HKdHkvbsLwZBk5a4ysfp7q7STvd+TsG+uD8Lc7kfRxatop1JUINt3j73ySc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoZ9WNtn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TT4lfn2s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768997243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRcVrBqhQujwyY3t8+ooFMd21puB/4S+X1pfO3AW+ug=;
	b=UoZ9WNtnzrZj/fh35Z+uNAFJO3PYsu5hB3DfMitohaFUmAsz7bfgRaROfPwQsoci3rZNsB
	UIwJxkoAR7z3QB/Rpm7X1BLIfBF2kuSUilheNzz62KoakLbL04gFGy2m2dugBVophJ4rXB
	wWjVBjycB8JdYcpQrnprBIrcLMcOXEY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-afwltUXGOk6nkSK0xRWbwA-1; Wed, 21 Jan 2026 07:07:22 -0500
X-MC-Unique: afwltUXGOk6nkSK0xRWbwA-1
X-Mimecast-MFC-AGG-ID: afwltUXGOk6nkSK0xRWbwA_1768997241
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so60220885e9.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768997241; x=1769602041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRcVrBqhQujwyY3t8+ooFMd21puB/4S+X1pfO3AW+ug=;
        b=TT4lfn2sSGIKKmGEFjXuJ+gDHTb4eBFDlCoigiVvx4ghQtF6sx/ehFf+TaiH+C85X6
         ufbuZYdyiGHR9WK9+vbYoLBP6btx2S/eUnK1J6TP2jPRwiCwpmgJMkoj53mxxIC4BT+y
         Tyu4vwfv9rH+eZHaSMImnCkoKW5oNlJgTuRhvbqyYUVRY2tb+tj//Xz0B0NllXpV/wD7
         ESc+l2Tu922YtRvmNXXeGUg8ll2qPoY7HUX8QgGlxtaMdaMjYq+r0FFTt2hW+gkPd6O7
         cRx2Iu06Q1zYPvnmF+wqTlPlPe+yWofTOPPEC17fET6VqXfLDm46rTlUkdb3J7IpuMPJ
         /kVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997241; x=1769602041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRcVrBqhQujwyY3t8+ooFMd21puB/4S+X1pfO3AW+ug=;
        b=nSbWxKfZznGoA54ehlYvGYRKqer2D77XgIx2/m+vOm6qLVPjzMoXhnH5omQ2K5YRBV
         6+DobtVek2fgOkl3Z/0dn2Nu3v9FpMTxHY33Z9Ohf94l9UrAbT87VlyXxwJpRg0Eh8ER
         p6YQ6XpHA5kx1XiZKgNg4oHSDTgsCgeo6IucNxsQ7w+egxBPWoPMJvIhIY+SM/uFw7nc
         GjUAvkMH1XlrQ8Jhmr4RilnMMmsiTAPEfQukt+tE//x/GUvfmWbORfyj2l5C6mBNkGrg
         pnrIlZ+/jHsUlSZffnDaO3CosUXSujp/fhQFz7N4gVJspr3PfC1hVoziA3nnGbIWGn0/
         soaw==
X-Gm-Message-State: AOJu0YyODcRfbBbn1CfNsPsoFXKxdhwmLDWLgAExnQaps1lPRqCn5zCV
	MyLRpr5BTIV+2VLryZQbbrvT/e8c8RDCh50zUGcTPHbM8hQNJ1OBTGdEqRT72SC32XR3k40ithX
	iScWmoLfPPw2S2VA0NgTbMUtNN+oQgKHQutfPJEMzOqORTKTzpli8dWlbVw==
X-Gm-Gg: AZuq6aKFIw+5BOUINE5OJodoknBMcFqhRnnM2u6OARvh3hh79FmakLc+1uUKGVDryvI
	le0m1Qc1OHmLPQjQtFYn0ByfgJCM9qIeXdYPGtmZkNxOdyKxlEDDODEc7+MvXGx8KqVzECZODGb
	b7f/RTScqGJrWO2iNZLUXvB3H0FLt9rkxA2Wl2uYURIRaTk4aGcoJJJb0gHCNGqT3VdiaoialA5
	bjuCesXwhGK+2WVNR6e2mTd2rhNpJo7zQpNTD6XF29gSMZ0+4jyRkKy+gv4RZclhbPRfUFUy/++
	lTqoTkJ6DV6kBy6rel147v1WJSN4Rogl+ysiSx6zipfRqt1XGi7jGR1QBv31XVtDOdho7ZbvXpU
	ZlOuMR4MkrxcZryA=
X-Received: by 2002:a05:600c:3e0e:b0:480:3ad0:6509 with SMTP id 5b1f17b1804b1-4803e7a2da0mr80802965e9.12.1768997240984;
        Wed, 21 Jan 2026 04:07:20 -0800 (PST)
X-Received: by 2002:a05:600c:3e0e:b0:480:3ad0:6509 with SMTP id 5b1f17b1804b1-4803e7a2da0mr80802465e9.12.1768997240572;
        Wed, 21 Jan 2026 04:07:20 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480424a37dasm22002135e9.2.2026.01.21.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:07:20 -0800 (PST)
Date: Wed, 21 Jan 2026 13:07:17 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Asias He <asias@redhat.com>, Melbin K Mathew <mlbnkm1@gmail.com>
Subject: Re: [PATCH net v6 1/4] vsock/virtio: fix potential underflow in
 virtio_transport_get_credit()
Message-ID: <aXDBKc0HyN8f-8l7@leonardi-redhat>
References: <20260121093628.9941-1-sgarzare@redhat.com>
 <20260121093628.9941-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260121093628.9941-2-sgarzare@redhat.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251856-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,google.com,redhat.com,sberdevices.ru,davemloft.net,lists.linux.dev,linux.vnet.ibm.com,linux.alibaba.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CD7B456892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 10:36:25AM +0100, Stefano Garzarella wrote:
>From: Melbin K Mathew <mlbnkm1@gmail.com>
>
>The credit calculation in virtio_transport_get_credit() uses unsigned
>arithmetic:
>
>  ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>
>If the peer shrinks its advertised buffer (peer_buf_alloc) while bytes
>are in flight, the subtraction can underflow and produce a large
>positive value, potentially allowing more data to be queued than the
>peer can handle.
>
>Reuse virtio_transport_has_space() which already handles this case and
>add a comment to make it clear why we are doing that.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>[Stefano: use virtio_transport_has_space() instead of duplicating the code]
>[Stefano: tweak the commit message]
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 16 +++++++++-------
> 1 file changed, 9 insertions(+), 7 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 26b979ad71f0..6175124d63d3 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -28,6 +28,7 @@
>
> static void virtio_transport_cancel_close_work(struct vsock_sock *vsk,
> 					       bool cancel_timeout);
>+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs);
>
> static const struct virtio_transport *
> virtio_transport_get_ops(struct vsock_sock *vsk)
>@@ -499,9 +500,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>-	if (ret > credit)
>-		ret = credit;
>+	ret = min_t(u32, credit, virtio_transport_has_space(vvs));
> 	vvs->tx_cnt += ret;
> 	vvs->bytes_unsent += ret;
> 	spin_unlock_bh(&vvs->tx_lock);
>@@ -877,11 +876,14 @@ u32 virtio_transport_seqpacket_has_data(struct vsock_sock *vsk)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
>
>-static s64 virtio_transport_has_space(struct vsock_sock *vsk)
>+static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
> {
>-	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>+	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
>+	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
>+	 * does not underflow.
>+	 */
> 	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>@@ -895,7 +897,7 @@ s64 virtio_transport_stream_has_space(struct vsock_sock *vsk)
> 	s64 bytes;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	bytes = virtio_transport_has_space(vsk);
>+	bytes = virtio_transport_has_space(vvs);
> 	spin_unlock_bh(&vvs->tx_lock);
>
> 	return bytes;
>@@ -1492,7 +1494,7 @@ static bool virtio_transport_space_update(struct sock *sk,
> 	spin_lock_bh(&vvs->tx_lock);
> 	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
> 	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
>-	space_available = virtio_transport_has_space(vsk);
>+	space_available = virtio_transport_has_space(vvs);
> 	spin_unlock_bh(&vvs->tx_lock);
> 	return space_available;
> }
>-- 2.52.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


