Return-Path: <netdev+bounces-246138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F72CDFED8
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C4D3005B8E
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41320320A3B;
	Sat, 27 Dec 2025 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTyDpC26";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FP5dn9oo"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20231ED70
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766851250; cv=none; b=F+as6994RNEEGZbP/oXuD+PJKG9FtPfSr0WvkOQccWDBQmoqaW3Rgeo6HlLyc2h8eVMOgiqKJ3c1UZ/J8gdGjYreEpVHAIAgJ59aDv3Ab10b+s6AQrhGa04QSkwe24PCUbP0bY0dHbW8GVteWoWOIDnkuzONr9XYduy4+NAnCnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766851250; c=relaxed/simple;
	bh=lcuvBY2m8iD7c7dHI2UnTehi9o/oOqtZ3SoF6v0FUlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBpgvZg5O9/TjhSvQRn5ggX7/eLRNDXEJ9Ozk1jPkANnrjPMbV0wynXsXai148C11f0Bj+/cCrVfwvu5haqvkl2Ewk/jKpKAPIPfFqOktWE4DyYw46F22r/s3RRgYQqgHtw7G/sBw0onMhfq4JrOevRSqxrJ7iLsS4UX4qTYqjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTyDpC26; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FP5dn9oo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766851247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KUjyEByrb4N0ONuMDPVPmOr47Yaw1ycFDG37WrD/UmA=;
	b=fTyDpC26Ems41VxIUKwg7KGBZBZMSnDi0wBG2W4rl5c64wcWK2iVUigEhhAYhdFLxorDLf
	5bAMB7/uX5D3WFqE1jnKT9EhDoW2aQPEIFDuu0S/hoTQXCGJyN6pYW9S01o7sb2jodHlpO
	L8ill0V+E+osoVBnbaDL8EfKFfYBm/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mmykLv_LOV2y0b3S2hNhQw-1; Sat, 27 Dec 2025 11:00:45 -0500
X-MC-Unique: mmykLv_LOV2y0b3S2hNhQw-1
X-Mimecast-MFC-AGG-ID: mmykLv_LOV2y0b3S2hNhQw_1766851245
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-432586f2c82so3635164f8f.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 08:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766851244; x=1767456044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUjyEByrb4N0ONuMDPVPmOr47Yaw1ycFDG37WrD/UmA=;
        b=FP5dn9ooniJWVpxotPTwTZ37dDsd6iMMNos09piic/mSBYiD8noyLzfjCHJvPqnUNg
         7IvgJgcNwXE28+taHZNPCoI+241A+zycKiz+G7LcKqEcj5RF2ury2XBszJf0RKsSoK2J
         jsCfr4p39ATGYSu1qfglHIxSNo/B7gJwYD4k4kqwJvCVtJsCJlm6FbhA5iLWuwonXR82
         XKPmVm7hO1gXWoecR/t2mgxc5oM+CYphwsiygRWL7NFAlhjwl1mmgnxfw6EJaNLPcxm6
         0YmCMatdP/I6Cjjo3EQSH0CGKy/vOE2aH1Bz3+5Pcvo/Qvn33k+xf04p3nGkkie/fS8k
         sh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766851244; x=1767456044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUjyEByrb4N0ONuMDPVPmOr47Yaw1ycFDG37WrD/UmA=;
        b=DCS1UBTpy0zacrPlQ04xTA6Dp3XtXj8/l04DoJG7HQ39ar1kvWNuYaT1Xyq2f+DdHB
         dDOMyW+ANBjreCSA3BYrGlysMhPERw6HpPJw0eBPugUu6a7Y+UGTV/7EGNISi/+q04RG
         dgTw9rSVfQNyNxzfSAJMq3TxxZlJ6ZpOyYpMjdq/NO4hIApBL9UmUXWzAo/yPK0FXA7p
         PGDpSyxGtlT2oxalO9+ThnGe/z9BEw6TLbvHxgQI6BxejPuqap5kNlWikNjZWm8ilG+I
         4/jKk0Q533vz/xwOI+3g+ypmPf5JECkxkSAzD9EWSZald2PpJ4X1Pyk2It1mIl2gn/QU
         DsTw==
X-Forwarded-Encrypted: i=1; AJvYcCXumGgWDbL3moW//MN5DONaCuI5qCtE7O9kwzfNMuhEl2yc2oqYDHd/qHb2MAhlpafvrHC3x10=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhrJcsRvS8Xv3pm3Qngky/GBTYXBXVhpu5183gIwPrylUxXUo
	ONFKAZoW2vWEczvZs71Jz2f1PUEY5hHtzPWzOQZaKgBt0dbRpe1qII9CpCooHWVpiHM4hxh4qoL
	CfvFoEDZWtZkute8+icA5NMKRZxpjGTUU91E/6pYQlBm4zRZxi9BROm3LSQ==
X-Gm-Gg: AY/fxX7tIkn/2+2/izuQ4LyABB9Vz24LbbfET4oIV4jl0XeVJOFc/vFQ1jqf3oLQkMI
	2pCEb3w9vNfR9TZJoT9nZWMK6cMOD4XteYLmsfyopvLwlN2ahzYtfxgkaONQL9dP3wiFo3JMeZ+
	bhOeNuPPioPS/OWuXbjDDKIUfJ3x/ygjzc939tt9zKfPdU/0G0OTutjC2fDAydZYYQSTun/FXmE
	Vf4uQDs49tkxPVSvHXqhVfyjGxC6OrQ2g4H+LksRlTiuiKbYQ1Ouh9AKRaMHxVXBrefSEpmqHR+
	Prgfcf39+rbweUS+SbjqnOsgGjAdyFHJ+m7PWdE7NEEek/fGBHXBUUlWgrkL82NvUPCNfwx6Xjw
	b6wJNwPqJJ+yUFg==
X-Received: by 2002:a05:6000:430b:b0:430:f736:7cc with SMTP id ffacd0b85a97d-4324e3ebf79mr29498333f8f.1.1766851244490;
        Sat, 27 Dec 2025 08:00:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnQ990ZAjKC9Xc/EGp7gWnlDf0T3OHO+QMebAR5RxVxtFTl7hbC0j3cx3WcWXz0mwHyuhA8g==
X-Received: by 2002:a05:6000:430b:b0:430:f736:7cc with SMTP id ffacd0b85a97d-4324e3ebf79mr29498301f8f.1.1766851244058;
        Sat, 27 Dec 2025 08:00:44 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm18816981f8f.11.2025.12.27.08.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Dec 2025 08:00:43 -0800 (PST)
Message-ID: <d4a97f0e-a858-4958-a10f-bf91062e5df9@redhat.com>
Date: Sat, 27 Dec 2025 17:00:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/4] vsock/virtio: cap TX credit to local buffer
 size
To: Melbin K Mathew <mlbnkm1@gmail.com>, stefanha@redhat.com,
 sgarzare@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-3-mlbnkm1@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251217181206.3681159-3-mlbnkm1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/25 7:12 PM, Melbin K Mathew wrote:
> The virtio vsock transport derives its TX credit directly from
> peer_buf_alloc, which is set from the remote endpoint's
> SO_VM_SOCKETS_BUFFER_SIZE value.
> 
> On the host side this means that the amount of data we are willing to
> queue for a connection is scaled by a guest-chosen buffer size, rather
> than the host's own vsock configuration. A malicious guest can advertise
> a large buffer and read slowly, causing the host to allocate a
> correspondingly large amount of sk_buff memory.
> 
> Introduce a small helper, virtio_transport_tx_buf_alloc(), that
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
> cannot force the host to queue more data than allowed by the host's own
> vsock settings.
> 
> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> 32 guest vsock connections advertising 2 GiB each and reading slowly
> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
> recovered after killing the QEMU process.
> 
> With this patch applied:
> 
>   Before:
>     MemFree:        ~61.6 GiB
>     Slab:           ~142 MiB
>     SUnreclaim:     ~117 MiB
> 
>   After 32 high-credit connections:
>     MemFree:        ~61.5 GiB
>     Slab:           ~178 MiB
>     SUnreclaim:     ~152 MiB
> 
> Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
> remains responsive.
> 
> Compatibility with non-virtio transports:
> 
>   - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>     socket based on the local vsk->buffer_* values; the remote side
>     cannot enlarge those queues beyond what the local endpoint
>     configured.
> 
>   - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
>     an MTU bound; there is no peer-controlled credit field comparable
>     to peer_buf_alloc, and the remote endpoint cannot drive in-flight
>     kernel memory above those ring sizes.
> 
>   - The loopback path reuses virtio_transport_common.c, so it
>     naturally follows the same semantics as the virtio transport.
> 
> This change is limited to virtio_transport_common.c and thus affects
> virtio and loopback, bringing them in line with the "remote window
> intersected with local policy" behaviour that VMCI and Hyper-V already
> effectively have.
> 
> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>

Does not apply cleanly to net. On top of Stefano requests, please rebase.

Thanks,

Paolo


