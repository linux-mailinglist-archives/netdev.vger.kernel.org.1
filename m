Return-Path: <netdev+bounces-245306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A0ACCB2BD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9F83095A82
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E792E5B21;
	Thu, 18 Dec 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8ExoRne";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZBCuQ/3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413C2E7650
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049890; cv=none; b=rzoGeirrlc4DJ/QVhDY15QavmvaZ0z14IQENgq+9CP/Al/hGM2cO1a1JtaZhLydHPzcV6p4aRydYhfLGhSvlCJOeMj8GlWw1VE4iTMCUrnm3vGmXZkm1yHJ29gxaFbKBHVEuqsoOu4ABho3aXoO9lOE7fOIqBguLgC3vIL+/epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049890; c=relaxed/simple;
	bh=8Jfg1L5A+9i31bArag6GfEHKUct4Y+XgPXMRDVY45/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amFhpMxT56zZ6n38cX96DU/gUeG1uPr741E0jTC90nFMaKswj1isp1wuHQqboTzRFfWFSQWv7zdthc4fe8xGw+Wblta7swGXrYK3L9uJhkEI6HR5tE4fcPhOqe/4KUXOMFyeFWbWZwaG18kFE9sBI0d+7NkCJ6383kOQKUN2sYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8ExoRne; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZBCuQ/3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3Me7T/ecX/eWW08pmqEzTYycDuOzXsGOt1u24i6yLM=;
	b=h8ExoRneB3RaG/AdGk9D2Xjxsbr/mqsTgu6auHNs7OlNZLAdXZMVjzG93WxF7W2g/EK1Ct
	gIvFebBaujULVpQXlsj2gnhA/n4eBngPSQtjpU6Ctut90MtLJsKj206buPIOKjWA2N0efA
	15sOo9BK+7aii3G0r7BrVehPLdcKAZo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589--0sNMA8QMy-r94kq3q0DbA-1; Thu, 18 Dec 2025 04:24:47 -0500
X-MC-Unique: -0sNMA8QMy-r94kq3q0DbA-1
X-Mimecast-MFC-AGG-ID: -0sNMA8QMy-r94kq3q0DbA_1766049886
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b7d282ac8aaso55127166b.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 01:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766049885; x=1766654685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s3Me7T/ecX/eWW08pmqEzTYycDuOzXsGOt1u24i6yLM=;
        b=LZBCuQ/3wd7fnAXgNZefuhFMGT8t0dzgXALkdkTj9SXTcSiLDqPmqj7e370s1C4W1S
         5SbBtDSIDFJjfu1DM5AKYnv1k0ZLQ55RhdkvhJRLt2XyHwmPse48/39WqltvJ0c5foJy
         fDXHN6UmiDfM8tZni+3hGxMqPInnwyTencEzVIPg9OPo7WWvd3g1VnNJ3WD5ZFFpni4I
         hSrvuPi5e0XPDMon6PBOL2pBCjmr/VsX4LmXNNSQ7ZtbfTb7/1PdANVGC+GGJRs0QlUZ
         BwN54iR0TeTo/n2PWsj57b+z5GM6Gr9nFeEn0Sq6FUs2lRYhE2laucxpd2tMChmCgyNC
         n7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049885; x=1766654685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Me7T/ecX/eWW08pmqEzTYycDuOzXsGOt1u24i6yLM=;
        b=XHAscayE8jMQEIsSld4+QEATQ4cnKWTirMAHhv3MT5tFwdrWvJEb5nXSeFq6OMpKnu
         3mYCYXvaEZHf+2n75dW+MkirppNJy6lSwfc9hsXgo2HQ/zrB6dwDS4bldxLPCQ/uciPw
         3Tz9znXgAWAzTgOb+M56aDKxrXfhYuHQLav8hBk/4bekrV0mP1DZwGHCjFpP9zH7X6C0
         HTdz5FRHtOUkasvWVx/p3+4r5v+taCVXqk4jVN4tolXF6ug+AcYTWA7+XtchDCGlD7S6
         rgsbLNm7zu+zpGj18c5OwWgpCpU7hapa18oM20vIIn1Ljz9X6bj9ZimQ3boIxbJe9sWz
         WL8g==
X-Forwarded-Encrypted: i=1; AJvYcCUpp8RGkEXOLxGZIwtO2xN1SJmBdjKf24/DbBcO3dACXH7Pj6kbephE4m/AuwlsirTG4spC08I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGSUjGQ0Roi06xQmNrMfs3p9APQwj+9yfyzemYftBD/s6njYNg
	dnaLamXbtayKSHeKDeShKpLYG7CceUyYtmZ4+xzD2pRhaJqqIhFn8BDPZ14fWcjeZEM0ie/ko+d
	Im+oIRB5mv6+B7jl0pTCEGjYWAC1jhsrThuLE29FWCRZFegudRJ5zyaRabA==
X-Gm-Gg: AY/fxX4P+fkAzeYFPbw3HUZWTjIj4nqGcCGYX1kWZAwySVtKIYtd5zWTjBUn8ox8xG8
	smIEwJjbTiNx5uWFnMsASnNKmaKQrwJ9doM+ZBZp9f/4fDQA3lT48GYjxHnfBUvYfp+c8hIBcPK
	ZiUQ3Zk8myd5juDnYLxmwsVnhns/0tfrHlk52ThuqjEUPkysAvVp5yO83NRUM2ZC6MLpMrypRYg
	/uEQwtWW286qgzGo8/kHojczbDiCuIBqC0k5MZo50Ct0GDyqPx2C+BOnyqTDtUuGpkVhKoiIfWO
	K36U+YLbkLCCgb6jsCBlAOrBLEZ75JpUtgAaYPhX8nXd4WXDY3h3Tri/N5zt0Cg1nB44dHFj3xK
	l8mhNQF274qJPig0=
X-Received: by 2002:a17:906:c113:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b7d236193aamr1980318166b.9.1766049885548;
        Thu, 18 Dec 2025 01:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAD/qWKmkhpOLZrhnnlUGJ7m9SKv8TWSmzS9CTD64tDpvQQIIz9pomfLb46awD8PNlKE999Q==
X-Received: by 2002:a17:906:c113:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b7d236193aamr1980314666b.9.1766049885020;
        Thu, 18 Dec 2025 01:24:45 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8022f96096sm175047866b.10.2025.12.18.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:24:44 -0800 (PST)
Date: Thu, 18 Dec 2025 10:24:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 2/4] vsock/virtio: cap TX credit to local buffer
 size
Message-ID: <vekrofb2syrh35whi7tznmypvekvqmcbjjlv5bhyknrghhnxr7@b6v3yxubtu5y>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-3-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251217181206.3681159-3-mlbnkm1@gmail.com>

On Wed, Dec 17, 2025 at 07:12:04PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport derives its TX credit directly from
>peer_buf_alloc, which is set from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.
>
>On the host side this means that the amount of data we are willing to
>queue for a connection is scaled by a guest-chosen buffer size, rather
>than the host's own vsock configuration. A malicious guest can advertise
>a large buffer and read slowly, causing the host to allocate a
>correspondingly large amount of sk_buff memory.
>
>Introduce a small helper, virtio_transport_tx_buf_alloc(), that
>returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
>peer_buf_alloc:
>
>  - virtio_transport_get_credit()
>  - virtio_transport_has_space()
>  - virtio_transport_seqpacket_enqueue()
>
>This ensures the effective TX window is bounded by both the peer's
>advertised buffer and our own buf_alloc (already clamped to
>buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
>cannot force the host to queue more data than allowed by the host's own
>vsock settings.
>
>On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>32 guest vsock connections advertising 2 GiB each and reading slowly
>drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
>recovered after killing the QEMU process.
>
>With this patch applied:
>
>  Before:
>    MemFree:        ~61.6 GiB
>    Slab:           ~142 MiB
>    SUnreclaim:     ~117 MiB
>
>  After 32 high-credit connections:
>    MemFree:        ~61.5 GiB
>    Slab:           ~178 MiB
>    SUnreclaim:     ~152 MiB
>
>Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
>remains responsive.
>
>Compatibility with non-virtio transports:
>
>  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>    socket based on the local vsk->buffer_* values; the remote side
>    cannot enlarge those queues beyond what the local endpoint
>    configured.
>
>  - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
>    an MTU bound; there is no peer-controlled credit field comparable
>    to peer_buf_alloc, and the remote endpoint cannot drive in-flight
>    kernel memory above those ring sizes.
>
>  - The loopback path reuses virtio_transport_common.c, so it
>    naturally follows the same semantics as the virtio transport.
>
>This change is limited to virtio_transport_common.c and thus affects
>virtio and loopback, bringing them in line with the "remote window
>intersected with local policy" behaviour that VMCI and Hyper-V already
>effectively have.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)

This LGTM, but I'd like to see the final version.

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index d692b227912d..92575e9d02cd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,18 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/*
>+ * Return the effective peer buffer size for TX credit.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we cap
>+ * it to our local buf_alloc so a remote peer cannot force us to queue
>+ * more data than our own buffer configuration allows.
>+ */
>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>+{
>+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>+}
>+
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -508,7 +520,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 	 * its advertised buffer while data is in flight).
> 	 */
> 	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
>-	bytes = (s64)vvs->peer_buf_alloc - inflight;
>+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) - inflight;
> 	if (bytes < 0)
> 		bytes = 0;
>
>@@ -842,7 +854,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -893,7 +905,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>


