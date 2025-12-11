Return-Path: <netdev+bounces-244381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9376ACB5FDA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FF1303B7FF
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CE23128C3;
	Thu, 11 Dec 2025 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNj+7jRA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qwgAsfsm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964E9312838
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458964; cv=none; b=OtApkGHKU3h7jAnPGAW39NW61VKMcbSYDDohV7kYTXvSpZL3Zuzl7JOX+I6JzzI65Oi5mkfcA+vPy4QWGtFEWRBHGi/VEF/vAa+qV5sztDl52oQG58Tl4sSVLkbCMGNCiyBvromJMiAaWwi33j2minhc5vK20tDRMbwodf4muoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458964; c=relaxed/simple;
	bh=D4DGGb+z62y89qoodZRwxBqyQ2W24OvlNfUQo6Mp9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPiUNGRgT0ZGWNtLaXH3r6WJ6I135uX6YCWelr8MiVGNDPS4oeABmQGal9xqjBqmShUyrAGbcWv8BRT04dfArmLa2USiksVLAh+z4aJdFWCvFP8hxN9Xg2Skyk9v8IZKaGgpyQZ+5ecsqNn9wuBU9YajNLgdO9XoNsUedCzibuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNj+7jRA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qwgAsfsm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765458960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcxS9gtwtWQRG7jJr9nwORwV625I1nRnmvMTOs/IWiM=;
	b=iNj+7jRAnai92jNpY129KUNxQncNQt0Yzm29SBOn5rvcWyJvnIQh6syeBxNZCkHZ/mSDXO
	x2gwWW4Bsbu4Jl7hMlgVr+8YjzOYAhQok8G6zpg/MQ4ViGT5znZ+iQkaalkI/WfkEnZ1Ik
	Xw5PqfU2nrTNHKwgdJaIKZhdmpoM5AE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-S2IHfncTP-KBxYGNysmAeA-1; Thu, 11 Dec 2025 08:15:57 -0500
X-MC-Unique: S2IHfncTP-KBxYGNysmAeA-1
X-Mimecast-MFC-AGG-ID: S2IHfncTP-KBxYGNysmAeA_1765458956
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so656165e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 05:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765458956; x=1766063756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcxS9gtwtWQRG7jJr9nwORwV625I1nRnmvMTOs/IWiM=;
        b=qwgAsfsm/+eg6noY8vcpjPkjaLEOtgYn3i9HBsHs1HyhVSRC9NfOq1KVfJ+TpM4P6v
         luOL7JCY77kLwcpIG8A44MCeuDYVdR3HLes8G5eBv5xlq/lEcvEb3CqKPGRW+7okgn+r
         P7Qqqz4YvBtfl4TSaEVjXlQtsoJ48sPVsRLYhGlVEcxCiqOa4e0VNhgaB0YeitZBo2uv
         peNkW2yiMO72BFcr0ylzGQ/uREG5WPv2rhSvYZ6vzI+Mun80Se8uimFybxoavKw1zuHI
         i5IjpYzWNczP27r00x0KXrYNhodhiMgqExoRRZKTE8dX+cleQE2tz8UGTLug8hqObuiV
         V0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765458956; x=1766063756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcxS9gtwtWQRG7jJr9nwORwV625I1nRnmvMTOs/IWiM=;
        b=Coli94/3U/Ms51e+EktBiVFEXzFbT1ZtT3Sey6PDJG5qEZBXL7YR99b9xIxwnPKw1+
         7JQ+D7qjapntsnH5DLEfT5Uogw5n0U7GEff7OLgBfYHs26RhRnG1PqxYdw48GcqCLcE6
         j8rPNh+znXyiRo43VT04NYqs7dMf2E3cS8vkS/zxysukZdGyTCeEMIQW/zH8K/cKr7UG
         ZHInsX/DXZbDXn1voCabmYVMN9f4tjJ2nQlStAW/rinjM6Utrvoj+SacPLoSZfZfA9r5
         O1aS0ZzcWU6TpQwC+HlAqbBFiLyEe3QfihuYFxZmu7IAaEYSwo2+HtsdYT0Fi8WC4ZMO
         V/Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXeZ+Jyp3Pjc2IlVCCUenvzjhtlbqZeKmgtrAN3FW+gt0js+9qxEn3btLvTbFnjEa+iJJzkAeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNlLwodhU4X4yeP2eA/W0UdWme+rprv5P1jtVfpH+52OuI6QZ0
	FW0EQ77ER2A+h7Ko62nQ+blTEBEwCEIyjTUMyZRe0XuVFY2I2AKW4xX2HDKV21fnR6Gcq3qkA9w
	N6z2sxoh/IUAWakv9Fl9dc/CHDnBhvI70viPXEVNmKweCyfKJE4t7YV5Gkg==
X-Gm-Gg: AY/fxX6FA4t5jlTxNmildygqpj1VBIWSMU7NL2vdpQW3Ct+yZDcJKR/U4n4hg59HUT9
	H+emvw2ECB/5GTFukh/rHeljPe7etVJasT3UHnDenjVQ2vj5UmjSCMfVYnnP9YF4uMwLV7fLOcL
	z/e9xRl9SfZ1fYAp5RilkjtMyMOTBjTAonlFBo/hk9Py14rlGHZjlXo4c/6jcTQPIOgH40ogC7H
	oLrucAofhAHcM3NpbQ3KhfBDLiHd/XQw6odOZ4qwiE0xsq93mR8cRdF8D7hj+1U1ZtKucbfGyfx
	T7Or8MIlKQbhCm/MekMNPJD4RgdRuo2uGihPE3L+zQcoORc7ol1ExT0xc+sZpl4BBF24GaOX80L
	dTdzISkOKgOTHgrzBakpXgSFjPTVd2izq+hrsjlOZiRe0eaHmXtvvFwl5zbLgjQ==
X-Received: by 2002:a05:600c:811a:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-47a8380695emr46248805e9.22.1765458956113;
        Thu, 11 Dec 2025 05:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPy0Hrynl/SKJgf0tueBAFzbll9ERYzFk6T5Mif9KPff/zyeo06XmGrpdpM7whHIa5OMi70Q==
X-Received: by 2002:a05:600c:811a:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-47a8380695emr46248335e9.22.1765458954662;
        Thu, 11 Dec 2025 05:15:54 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89d8405dsm14222975e9.2.2025.12.11.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 05:15:54 -0800 (PST)
Date: Thu, 11 Dec 2025 14:15:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <uo63g2tsmgcqqg3tpzm7tdtfn2pr73kymfyl4woulpwcobevuw@vr3d4i4konge>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251211125104.375020-1-mlbnkm1@gmail.com>

On Thu, Dec 11, 2025 at 01:51:04PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport currently derives its TX credit directly from
>peer_buf_alloc, which is populated from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.
>
>On the host side, this means the amount of data we are willing to queue
>for a given connection is scaled purely by a peer-chosen value, rather
>than by the host's own vsock buffer configuration. A guest that
>advertises a very large buffer and reads slowly can cause the host to
>allocate a correspondingly large amount of sk_buff memory for that
>connection.
>
>In practice, a malicious guest can:
>
>  - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
>    SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and
>
>  - open multiple connections to a host vsock service that sends data
>    while the guest drains slowly.
>
>On an unconstrained host this can drive Slab/SUnreclaim into the tens of
>GiB range, causing allocation failures and OOM kills in unrelated host
>processes while the offending VM remains running.
>
>On non-virtio transports and compatibility:
>
>  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>    socket based on the local vsk->buffer_* values; the remote side
>    can’t enlarge those queues beyond what the local endpoint
>    configured.
>
>  - Hyper-V’s vsock transport uses fixed-size VMBus ring buffers and
>    an MTU bound; there is no peer-controlled credit field comparable
>    to peer_buf_alloc, and the remote endpoint can’t drive in-flight
>    kernel memory above those ring sizes.
>
>  - The loopback path reuses virtio_transport_common.c, so it
>    naturally follows the same semantics as the virtio transport.
>
>Make virtio-vsock consistent with that model by intersecting the peer’s
>advertised receive window with the local vsock buffer size when
>computing TX credit. We introduce a small helper and use it in
>virtio_transport_get_credit(), virtio_transport_has_space() and
>virtio_transport_seqpacket_enqueue(), so that:
>
>    effective_tx_window = min(peer_buf_alloc, buf_alloc)
>
>This prevents a remote endpoint from forcing us to queue more data than
>our own configuration allows, while preserving the existing credit
>semantics and keeping virtio-vsock compatible with the other transports.
>
>On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>32 guest vsock connections advertising 2 GiB each and reading slowly
>drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
>recovered after killing the QEMU process.
>
>With this patch applied, rerunning the same PoC yields:
>
>  Before:
>    MemFree:        ~61.6 GiB
>    MemAvailable:   ~62.3 GiB
>    Slab:           ~142 MiB
>    SUnreclaim:     ~117 MiB
>
>  After 32 high-credit connections:
>    MemFree:        ~61.5 GiB
>    MemAvailable:   ~62.3 GiB
>    Slab:           ~178 MiB
>    SUnreclaim:     ~152 MiB
>
>i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
>guest remains responsive.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)

Changes LGTM, but the patch seems corrupted.

$ git am ./v3_20251211_mlbnkm1_vsock_virtio_cap_tx_credit_to_local_buffer_size.mbx
Applying: vsock/virtio: cap TX credit to local buffer size
error: corrupt patch at line 29
Patch failed at 0001 vsock/virtio: cap TX credit to local buffer size

See also 
https://patchwork.kernel.org/project/netdevbpf/patch/20251211125104.375020-1-mlbnkm1@gmail.com/

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d58..02eeb96dd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/* Return the effective peer buffer size for TX credit computation.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we
>+ * cap that to our local buf_alloc (derived from
>+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
>+ * so that a remote endpoint cannot force us to queue more data than
>+ * our own configuration allows.
>+ */
>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>+{
>+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>+}
>+
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	ret = virtio_transport_tx_buf_alloc(vvs) -
>+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (ret > credit)
> 		ret = credit;
> 	vvs->tx_cnt += ret;
>@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
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


