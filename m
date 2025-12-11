Return-Path: <netdev+bounces-244346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2EDCB5520
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 10:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90356300661F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A042DA76F;
	Thu, 11 Dec 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTbzpdyn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwjIrvlS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB02D6E5B
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444259; cv=none; b=p/aEET0Wo5lb7UpkfX0w1PLRefegdim39kiHgv4XNJWQnOcF4BqVsPFFcw+zvWP0oPOuQyU0rvFooV87zFVAJGaRO6A1YpfsDDDGu0ITxf4qPSlO28fdCDG/8Z4ni1UMoLZSjfEKdzZMfpYuyhzQ7ol/QPA4i4tyrvdmadMHIcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444259; c=relaxed/simple;
	bh=2bjsuHgqR2pBqJTjwbviCLdqZiOgEWxTUpAVbpAw2Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzPYSAMYjOXFCExUfq5iv+A3KYKIoTKkSLAlW1J/O2xXCh8IsXBb8w2XWDSDMYrgbCm7AxPCBZ5CZybr3vvnewpkvKlxA+QAONwaDi4ThmasPOGhflmQHbuNoKRIX4glSUi8ass+ZAlAOg7tzfm4rcTLQJbERhhnIPCLOFpIu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTbzpdyn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwjIrvlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=69iEnCdCnSl1sInX4QnhnjanZznNSbsv0LHo8vEaadA=;
	b=iTbzpdynL9/d+XJjy71v8I4jY2B9uBwaU+wS99gpnpDr9SaIxOrSMI71pmPC69LXvE0voQ
	jflPzhWtbhEsFLRjgWOFRm0qyn5OuCi/2hhq5ahlNvcsHJ5aks9oA5ZZBUIJ3U+L4oQquh
	k3p7jUUnbmAaWRUH75uWkTf9s3fDWYA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-UnlYXDLAPJKBXjSa9YKVVA-1; Thu, 11 Dec 2025 04:10:55 -0500
X-MC-Unique: UnlYXDLAPJKBXjSa9YKVVA-1
X-Mimecast-MFC-AGG-ID: UnlYXDLAPJKBXjSa9YKVVA_1765444254
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b726a3c3214so54512666b.2
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765444254; x=1766049054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=69iEnCdCnSl1sInX4QnhnjanZznNSbsv0LHo8vEaadA=;
        b=AwjIrvlSGIfOsHi0FNVysIQaUpecNf2erisMl7Uz0KtOTvzHGkORYpDAxKH7KMm+o0
         hB9Sh7Ohb0B0dHFdUMzzfl3pWRqMYHF5KtwBzKai3CnMCO31U/yiYgkUnid4cC0xr/Ki
         j2B4NEcOApBFYJqvQqCcYJaJqiAb3AvfpfWhorxHpVTJouPpiGn/0jREVMx7Eyg7OLAw
         5pntfLKpZ/ziMfLL9VNRfwjk/PrQA3bnfIT5heWRKJnNRDUiC3Zkys7l7/bYZdRSG9ZJ
         +BYM2gNLlWahFvvmiRBynU9VyX9eGdsM7/MxvKgMfrNijkUcTS8ftlxpgh6xpwbHIaaw
         4vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765444254; x=1766049054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69iEnCdCnSl1sInX4QnhnjanZznNSbsv0LHo8vEaadA=;
        b=i+L8jRH+9tFJhJMqy4j62dxtThKhsNSnHrPfrTricFQznZahRpQW6iJopVcIgoaUVw
         kr4XuFzIP9wb4XFPp+Rjpz5+N1ZtWkNaglk3mMivQimwNEHtOQSJGczrJtKpOPGlxhNr
         79HvaGiuLb/uK0Hfu3jBDzbQr8n6dImlcBpxnQ7AJSmQFI6tyTxDop6dQnCsS5OtoNwh
         IUk5a11wAtBz5UQtxicS4Ep5Z77+rOfDmcIwN6hq5p/Tk1pNaRkBIW/kjPayKZW+Rqez
         cj2Xz4Q5jtKlBR8AQRn2H6tF56tU3PVHyp6klAt3F9QJfGtSnXbCwy7FpdY7/Lo8vo/8
         oLDg==
X-Forwarded-Encrypted: i=1; AJvYcCV6lhHhU+BsdRL91ImcGkzHNi7NuibVfe7r9OqoqzYC1mGceNUhcDKxlks46QYTTW49CMEvulE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3AHA34LYnFXEapiofnhkYLdNkFrcM8PKV3yaXhOe8h7hWf7a
	HuPJk0Ew1Me3upJraJn3Kf+QfMCwLofDA1HYDB2Z59BS8PBrEZrCsqdsYc5uP6+BOxPqj6GYt1n
	O4q6hbwp+mjQIsVRSNyU8w4UH5xjaAyhSsSCVGe+4whUb/IoM6cCraIWAkw==
X-Gm-Gg: ASbGnctGlEYg051au6uqSHGTp2ets/9VB2JCcfemgvNzCV58oN/cA045Vc/ka4YRpR4
	dJSltf7DfLb0Vcl0pdsQHjZmzOPU/zpxxPGYsmT3Y4R1MknQOjZ4yTRYEwnIW/1d3mLFoQJmCWi
	7mvBxKh88c/H6wJm/QbaaRdH4cYyPmoxzGOi/KiDdZWMakZYWsOduywqFBsxLHg05qSobqk+qY0
	Tr3bdvuUIYfFnYzCFXy7srh+M+8vuZm9jCP2Fh0QdmgszEOpjP6jTetOtKXMAY4p3NBTcRQ7p97
	KmZCaMx3MyJQq20+Pk3pIpKFlWcx93S+PaEc3UHQijUaGoPAn8N2XjyxbZP6GPbi2kWspogtCK7
	V0Ziy6TRwsX+XM5d1RL06uytAqFv57aprpUf5jN2d8u1XlkIGeyYKJ9ErIt+AaA==
X-Received: by 2002:a17:906:d551:b0:b73:301c:b158 with SMTP id a640c23a62f3a-b7ce823a81dmr540585966b.6.1765444253903;
        Thu, 11 Dec 2025 01:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEew10O4bon7Xzeax0PYRU5JDJoxS0/dSqVq0TxsHXl0IJlpZHr0G2pLqtxoNtfkJvXUfn7Sg==
X-Received: by 2002:a17:906:d551:b0:b73:301c:b158 with SMTP id a640c23a62f3a-b7ce823a81dmr540582966b.6.1765444253322;
        Thu, 11 Dec 2025 01:10:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa56c152sm203140766b.56.2025.12.11.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 01:10:52 -0800 (PST)
Date: Thu, 11 Dec 2025 10:10:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH] vsock/virtio: cap TX credit to local buffer size
Message-ID: <ctubihgjn65za4hbmanhkzg7psr6kmj3jeqfj5sfxnnxjjvrsy@l6644u74vrn6>
References: <20251210150019.48458-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251210150019.48458-1-mlbnkm1@gmail.com>

On Wed, Dec 10, 2025 at 04:00:19PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport currently derives its TX credit directly
>from peer_buf_alloc, which is set from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.

Why removing the target tree [net] from the tags?

Also this is a v2, so the tags should have been [PATCH net v2], please 
check it in next versions, more info:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#subject-line

>
>On the host side this means that the amount of data we are willing to
>queue for a connection is scaled by a guest-chosen buffer size,
>rather than the host's own vsock configuration. A malicious guest can
>advertise a large buffer and read slowly, causing the host to allocate
>a correspondingly large amount of sk_buff memory.
>
>Introduce a small helper, virtio_transport_peer_buf_alloc(), that
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
>cannot force the host to queue more data than allowed by the host's
>own vsock settings.
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

I think we should include here a summary of what you replied to Michael 
about other transports.

I can't find your reply in the archive, but I mean the reply to
https://lore.kernel.org/netdev/20251210084318-mutt-send-email-mst@kernel.org/

>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d58..02eeb96dd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/*
>+ * Return the effective peer buffer size for TX credit computation.

nit: block comment in this file doesn't leave empty line, so I'd follow
it:

@@ -491,8 +491,7 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
  }
  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);

-/*
- * Return the effective peer buffer size for TX credit computation.
+/* Return the effective peer buffer size for TX credit computation.
   *
   * The peer advertises its receive buffer via peer_buf_alloc, but we
   * cap that to our local buf_alloc (derived from

>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we
>+ * cap that to our local buf_alloc (derived from
>+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
>+ * so that a remote endpoint cannot force us to queue more data than
>+ * our own configuration allows.
>+ */
>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>+{
>+	u32 peer  = vvs->peer_buf_alloc;
>+	u32 local = vvs->buf_alloc;
>+
>+	if (peer > local)
>+		return local;
>+	return peer;
>+}
>+

I think here Michael was suggesting this:

@@ -502,12 +502,7 @@ EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
   */
  static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
  {
-       u32 peer  = vvs->peer_buf_alloc;
-       u32 local = vvs->buf_alloc;
-
-       if (peer > local)
-               return local;
-       return peer;
+       return min(vvs->peer_buf_alloc, vvs->buf_alloc);
  }


> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	ret = virtio_transport_tx_buf_alloc(vvs) -
>+	      (vvs->tx_cnt - vvs->peer_fwd_cnt);
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
>+	      (vvs->tx_cnt - vvs->peer_fwd_cnt);

nit: please align this:

@@ -903,7 +898,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
         s64 bytes;

         bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
-             (vvs->tx_cnt - vvs->peer_fwd_cnt);
+               (vvs->tx_cnt - vvs->peer_fwd_cnt);
         if (bytes < 0)
                 bytes = 0;


Just minor things, but the patch LGTM, thanks!
Stefano

> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>


