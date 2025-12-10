Return-Path: <netdev+bounces-244259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1EFCB321D
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 15:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A28130E7112
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31EF32277B;
	Wed, 10 Dec 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS5BI736";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2lovAsS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559D21423C
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376570; cv=none; b=PlsbOTi8Xty6zyvIZdxYudvKMUX7znGzS2bQQvkrYZpVer3px6YKv3jLBko1yXU7UWGIIaaxuwrlV+D23eyC1hUfAXvZnSAH7aWVAPj2iijzPW8uqGyXUflrMWFChSzRY0zTxq8yzFbK0osErStrCJhlZsZK9uWiFir39wyFMPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376570; c=relaxed/simple;
	bh=mR7FX3+KEfttN7RMnMM/NLVhqGV7g6DZNgB51VU9Uno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVCKvEFPI9mtlaRrlS0vgD9F8ryMtOqA89BxO0tQrulTsKEEz0ldNXGqv6z3cjRg/E2ky5fIhP7casHj1ea3OstdXFIv7XpmfMiZqtssNruujOPP9/0Dssqg+O+l38ySCbusBT2R2iRxH3Z68EH9YRSJZT9/N7H/KCtaJInIN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS5BI736; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=K2lovAsS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765376567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRJ72Nh2zwp7g0tNeZhrixaAdGzbaonGGzR4qDRLA7Q=;
	b=CS5BI736xTIfxN/Z+6wDjoFPW98+AtZ/T/euzhf69KKka8qrq2CYM7/kpvXG7xba0z88zw
	ZZWuvbqY46SZu80gmaP1y2OIYFBusTKO8iZE9RfnAdkGhGTrUPRI8idnqz/z6TMb8uxzxp
	9TnfhgGDZ3JgBR891mmTcZwzVohl5QQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-SX7LEImbMCutMOtGzgLdPA-1; Wed, 10 Dec 2025 09:22:46 -0500
X-MC-Unique: SX7LEImbMCutMOtGzgLdPA-1
X-Mimecast-MFC-AGG-ID: SX7LEImbMCutMOtGzgLdPA_1765376566
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so43381995e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 06:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765376565; x=1765981365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kRJ72Nh2zwp7g0tNeZhrixaAdGzbaonGGzR4qDRLA7Q=;
        b=K2lovAsSPduXODbZvjLeNm104rshGqUMRMY54tJKnVnuF/EtdHxuj+vFKunou5tjhB
         Vk5e5rPTVVoJEi0ao3TFx6+4eNrIsrhFqPoROEi1EqAO/DERJ5roUjDjcH6fbxG/1gMS
         jPExobzN1HX/Es+5yu7OZGdgI8djzpeTz5fFe+TmtPcG3IdA6NIx86PT4AasEXUCT4xe
         LK+YBizlVROaxo2/09snv/qxFMi98u90w3MR98cEdvehqGemmT3VGe+vGmLlZCH96ETf
         HGBxep/tC5p+dkcBh5bTDfIoIzlizAyUYFWHauPXlmnji3KBsOybrEJycZ043sr0kleg
         E8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765376565; x=1765981365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRJ72Nh2zwp7g0tNeZhrixaAdGzbaonGGzR4qDRLA7Q=;
        b=KguWQt1X/fwjKOxhogFrfFcUv8ncO9nrwJho8V1dDlV7RenVYFZqcxBNQmRPE4KfXQ
         kKhjYawDMrVDbasv+vLwIu5avC5elpkzLUX3UXkVelTTIjAEx/S+9Uc8Dx1GXJ1cxNx5
         YebsWho7FAASVgv9jpzygJ1UxvQQqUKk5n5iOxx4UHhfjfW/Pg4Kx7bbaGaa46Zf5fXF
         ExxQjwHh17fFf7CdZXaLPM4+Yr6bhQEnJqBB3Hs9WSxJqmlNRp2FBAJ6Wvjpk9OkmEpE
         I7YpsTjw5kujC1CucOyQ4SDY8r9/b53SCH1DNEurLttivnWK2dHB/j4x5QMxT5xoOLGU
         m3UQ==
X-Gm-Message-State: AOJu0Yz9kgVQC29N63OEaVDBP8H8fTL4FA26Q/44hYUUfOlBAQp773IO
	O69RnfcpmEtvas9rVJehasH0ou0JiZlAvNvcqTCpJOkGZ8M5ViGFvLqUdqTgsO0IZzv4gBLq/uT
	gqQST7Y279sNKaaMsu6DhlKKax3zPZ2rCJcXFIW+GFfQSPM7a3grYMUM1FQ==
X-Gm-Gg: AY/fxX6mbwMNUHX0XglMAN8puv3gHpBtqPrG3ZuhvkgeqnTuUhBuDxsPWP7z6DzniQA
	zFeKJ5jvRumngnN2Zedfrwvav1J3YD989x0Irn5KZmJE4TNrslYZnMstbU+mpcFC6J82N+wS52z
	yYJ7diPfZcEH53Ta0shFeIgD9V9NelNX0fA/7SV1RqKullRr3CRbdL6xlNJoWdRj/842/fxo03i
	h1+8EUMAYLe+ElSvBWlXVvqka2k2WUNSWSaUz2TA8o/xlpq2V2Jc+IusMLBzvzpagxRHyF9Wvam
	HFy024GaRvJHNfQjA7ouSykjS4BfXs7KvjA5i/YhbpKUo5MMEOn34+QuipaCXkfhyzCXhzRwqsI
	HNYseEbwcvEgXqODeAfOAcobsvG6c6Zz8DpSuWtzewP5e6NQBCXzFtal9Ba/sYw==
X-Received: by 2002:a05:6000:4282:b0:42b:47da:c318 with SMTP id ffacd0b85a97d-42fa3b18a0fmr2763517f8f.52.1765376565416;
        Wed, 10 Dec 2025 06:22:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe23O8ZHiqMm5vorjeh11c7DTLLOPAuIGwE8wgGZY4Ncci77xO6QqQLWpsM6fjDqtIM/m9Pw==
X-Received: by 2002:a05:6000:4282:b0:42b:47da:c318 with SMTP id ffacd0b85a97d-42fa3b18a0fmr2763455f8f.52.1765376564834;
        Wed, 10 Dec 2025 06:22:44 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm37857142f8f.11.2025.12.10.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 06:22:44 -0800 (PST)
Date: Wed, 10 Dec 2025 15:22:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH net] vsock/virtio: cap TX credit to local buffer size
Message-ID: <7m3k4fhwnyvocrpwyzkm2xpgssik7lph3f5kqagqifllijvhbq@5opsnu2vcgic>
References: <20251210133259.16238-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251210133259.16238-1-mlbnkm1@gmail.com>

On Wed, Dec 10, 2025 at 02:32:59PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport currently derives its TX credit directly
>from peer_buf_alloc, which is set from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.
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
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Melbin K Mathew <mlbnkm1@gmail.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)

Thanks, in addition to Michael comments:

Please run `./scripts/checkpatch.pl`, there are several warnings/errors 
mainly related to spaces/tabs.

Also please use `./scripts/get_maintainer.pl` since several maintainers 
are missing in CC.

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d58..f5afedf01 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/*
>+ * Return the effective peer buffer size for TX credit computation.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we
>+ * cap that to our local buf_alloc (derived from
>+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
>+ * so that a remote endpoint cannot force us to queue more data than
>+ * our own configuration allows.
>+ */
>+static u32 virtio_transport_peer_buf_alloc(struct virtio_vsock_sock *vvs)

This maybe can be called virtio_transport_tx_buf_alloc or something like 
that, to make it clear that should be used in the TX path. (not a strong 
opinion)

Thanks,
Stefano

>+{
>+	u32 peer  = vvs->peer_buf_alloc;
>+	u32 local = vvs->buf_alloc;
>+
>+	if (peer > local)
>+		return local;
>+	return peer;
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
>+	ret = virtio_transport_peer_buf_alloc(vvs) -
>+             (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (ret > credit)
> 		ret = credit;
> 	vvs->tx_cnt += ret;
>@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_peer_buf_alloc(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)virtio_transport_peer_buf_alloc(vvs) -
>+               (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>


