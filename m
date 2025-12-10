Return-Path: <netdev+bounces-244256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1597CB3105
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 639BC3062E06
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EF230ACF0;
	Wed, 10 Dec 2025 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffNoOWU/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gt0i5nbz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A1E2C3757
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374455; cv=none; b=Dgn0UPsVuOPuFyw80goxNspnwSgzp1s6rkh5iy4EouFXeCpa85EQ7xgWBa5iUNU6uDGb3mJNN8fKtEs3iNFyilu8JF3kaNHybEV7QJr8n8bBwcx3QIgMMW3lKXh0xLRUuzeRZUyJ0n/IK0WgZxd/4860B57C0UmfGOibkFm/wzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374455; c=relaxed/simple;
	bh=CeBJJK9qDZuXXuVvS2+T2iTGf8HWKyVfgoO1+dvvBfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edEmUKZsuQgepbL7ulQO0xUTNgXr7UDnAQ25uYMS0EJO3acRB8jf5ILcMU8NN+QMbff8WtpXKPqWcINkXKe+O3gNeMG4hsEExWk/JV9Hyp1HDDU6VCh28AN3KL2cVXlu5QZUZt0GbXjnha0nG7bdwCaUSHWRqKX9OTJJ1IIGMVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffNoOWU/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gt0i5nbz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765374452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8lpG6zjZ8rp4g1clQM1+Gw26UIeELt9eGQsZzCeUek=;
	b=ffNoOWU/j3d3IVwAaB8ROAuWYpf1Yh0CeAlnD0Ezsc/YgZkV+bQlu9M/EGT/ZHG9kY3PEi
	zCY7sVJlga3jjg3ofdt6iFEHPT7YrSc7Wq+fesB6AyGcTXD0c8YkQ0fKoD8upWpw5yLSCa
	iOu1iePXvrliO4zEklw73kgw1eRWgHQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-fgJHn81ANVyjlPdk_aLvxQ-1; Wed, 10 Dec 2025 08:47:31 -0500
X-MC-Unique: fgJHn81ANVyjlPdk_aLvxQ-1
X-Mimecast-MFC-AGG-ID: fgJHn81ANVyjlPdk_aLvxQ_1765374450
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b2b642287so3459854f8f.2
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 05:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765374450; x=1765979250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E8lpG6zjZ8rp4g1clQM1+Gw26UIeELt9eGQsZzCeUek=;
        b=gt0i5nbzL7rIq1YLoLaEJFKATjLdzFx1QmFy8wrq3g9F7JAAUskBSwUcwrGUpdDRyK
         QDzVDMP8h6Hc2GIMa6xdOJDBZ46dp7ZWhq0l0gYXxgM5WYDNY6AHzQjiAIe2+6WttpgA
         VzWqkmWARk6y0en95X4LezXBaTt2i6MXL6kLstZYS97z+rM+r0jQZ1owZwVfzF+okn05
         71ujEeeII5r0aEGnLuAQioPQEhSH6KHMt/cCStzCa9/Fvznbx9ILAaQ/D/em+QcgyvT4
         seogSd5P7gi7Tx1l+fGJ+CHPwqnLUj6Ktu0iSqhGSISfllSBMo+LYoiERpJf4Hgp+OST
         mN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765374450; x=1765979250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8lpG6zjZ8rp4g1clQM1+Gw26UIeELt9eGQsZzCeUek=;
        b=mqV9egP2yOvlM3/hZsN4EcCf3FHxH+7zToXExjHZvSE8lwik1kH6lqzKISwA1Nj7eQ
         3Gd/oG7qAJ+60hI/H9H+sTQwNsqGV2iuXwBQUAedeLFSYsesvySn2VMp5h6gtOmDFhg/
         FFp0dFGPmDQz8y0/EdxKCEonvhl5Iy7Y2XS7ExxN2S/MIkFSOjd8GdtWIRCmgYRMmYs5
         rPalU2q0nIJvHPtTuQaSwciTjL+dbiKvAO+IpARUQjVttc/SS2mBdm7XLF6CWrz4KrYF
         xq91KQ9FwbRW2HIXvJX8OXKZ4pKWi3DceKP1+GV01rjkcs8swFxP+vWF5kFO+jxl7fO4
         WV2g==
X-Gm-Message-State: AOJu0YzCDAaeCBwS4M2syG4AHIWGHYvrqUHJkBVrT4TalvrQndpm/gxz
	MLGGag/HDIMc5w1wdW3vqRRjC0IY08IdJwRuQ8EwMzTKYzw14l/ECZ/CIRm8DDceO1rO8453Eot
	EiOjhAijJlPgaERSQC9Sqe3NxPsSdtM5e5JhPOaGIzF+0PfRL+2RaE/TiAA==
X-Gm-Gg: AY/fxX5qb0701w3ohhFcP4h9UTU9HoOx04fffXmw5yzzlRquHMNbahVjQmZU02d5ovL
	fLgaPLTooto5YgV3+5vzTK18ypXWasGPpUiGgbKLC4wgQAt1kMUWcgzGAzd8PyRqLCGffg/MAvv
	2uy7in1jcUpafTRL09b6xcoGosZgr+2OqK8Zha1fSt9/hkREFxLQG+mAw5WBxr8f1/Wh5sEN2JC
	9z5vTJCfJVI+KXYCq8Yk2bmemY4gM54OLCntceN+Aerqr2sntkzg2mc0vhS7xwXhqNNm17aceLp
	Rp/Eh2FMpmMc4Vz2JqvfBy5Kl5N/m6pgTyXz2t8aqPwkLtMdkqGb2b5zLYRf0xiNRL94bOI4nDQ
	V
X-Received: by 2002:a05:6000:22c1:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42fa39d93efmr2861947f8f.11.1765374449978;
        Wed, 10 Dec 2025 05:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiF31+YAxj1nTU+k9IKhu5KpZ7qCaRU00CbygNqArk3v8Ax9QOK6j54I8ZYvQxFU065UDJWg==
X-Received: by 2002:a05:6000:22c1:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42fa39d93efmr2861913f8f.11.1765374449390;
        Wed, 10 Dec 2025 05:47:29 -0800 (PST)
Received: from redhat.com ([31.187.78.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226c5sm38428743f8f.23.2025.12.10.05.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:47:28 -0800 (PST)
Date: Wed, 10 Dec 2025 08:47:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com,
	stefanha@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH net] vsock/virtio: cap TX credit to local buffer size
Message-ID: <20251210084318-mutt-send-email-mst@kernel.org>
References: <20251210133259.16238-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210133259.16238-1-mlbnkm1@gmail.com>

thanks for the patch! yet something to improve:

On Wed, Dec 10, 2025 at 02:32:59PM +0100, Melbin K Mathew wrote:
> The virtio vsock transport currently derives its TX credit directly
> from peer_buf_alloc, which is set from the remote endpoint's
> SO_VM_SOCKETS_BUFFER_SIZE value.
> 
> On the host side this means that the amount of data we are willing to
> queue for a connection is scaled by a guest-chosen buffer size,
> rather than the host's own vsock configuration. A malicious guest can
> advertise a large buffer and read slowly, causing the host to allocate
> a correspondingly large amount of sk_buff memory.
> 
> Introduce a small helper, virtio_transport_peer_buf_alloc(), that
> returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
> peer_buf_alloc:
> 
>   - virtio_transport_get_credit()
>   - virtio_transport_has_space()
>   - virtio_transport_seqpacket_enqueue()
> 
> This ensures the effective TX window is bounded by both the peer's
> advertised buffer and our own buf_alloc (already clamped to
> buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
> cannot force the host to queue more data than allowed by the host's
> own vsock settings.
> 
> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> 32 guest vsock connections advertising 2 GiB each and reading slowly
> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> recovered after killing the QEMU process.
> 
> With this patch applied, rerunning the same PoC yields:
> 
>   Before:
>     MemFree:        ~61.6 GiB
>     MemAvailable:   ~62.3 GiB
>     Slab:           ~142 MiB
>     SUnreclaim:     ~117 MiB
> 
>   After 32 high-credit connections:
>     MemFree:        ~61.5 GiB
>     MemAvailable:   ~62.3 GiB
>     Slab:           ~178 MiB
>     SUnreclaim:     ~152 MiB
> 
> i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> guest remains responsive.
> 

what is missing here, is how do non-virtio transports behave?
because I think we want transports to be compatible.

> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

that commit does not even include the patched file.
how can it be the right commit to fix?

> Reported-by: Melbin K Mathew <mlbnkm1@gmail.com>
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>


this is the fix suggested by Stefano, right?
maybe mention this.

> ---
>  net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index dcc8a1d58..f5afedf01 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>  
> +/*
> + * Return the effective peer buffer size for TX credit computation.
> + *
> + * The peer advertises its receive buffer via peer_buf_alloc, but we
> + * cap that to our local buf_alloc (derived from
> + * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
> + * so that a remote endpoint cannot force us to queue more data than
> + * our own configuration allows.
> + */
> +static u32 virtio_transport_peer_buf_alloc(struct virtio_vsock_sock *vvs)
> +{
> +	u32 peer  = vvs->peer_buf_alloc;
> +	u32 local = vvs->buf_alloc;
> +
> +	if (peer > local)
> +		return local;

> +	return peer;

is this just
 return min(vvs->peer_buf_alloc, vvs->buf_alloc)
?

> +}
> +
>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>  {
>  	u32 ret;
> @@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>  		return 0;
>  
>  	spin_lock_bh(&vvs->tx_lock);
> -	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> +	ret = virtio_transport_peer_buf_alloc(vvs) -
> +             (vvs->tx_cnt - vvs->peer_fwd_cnt);
>  	if (ret > credit)
>  		ret = credit;
>  	vvs->tx_cnt += ret;
> @@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>  
>  	spin_lock_bh(&vvs->tx_lock);
>  
> -	if (len > vvs->peer_buf_alloc) {
> +	if (len > virtio_transport_peer_buf_alloc(vvs)) {
>  		spin_unlock_bh(&vvs->tx_lock);
>  		return -EMSGSIZE;
>  	}
> @@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	s64 bytes;
>  
> -	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> +	bytes = (s64)virtio_transport_peer_buf_alloc(vvs) -
> +               (vvs->tx_cnt - vvs->peer_fwd_cnt);
>  	if (bytes < 0)
>  		bytes = 0;
>  
> -- 
> 2.34.1


