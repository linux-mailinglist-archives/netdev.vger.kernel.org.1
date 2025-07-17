Return-Path: <netdev+bounces-207786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C415CB088FE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C8565BCB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7D288537;
	Thu, 17 Jul 2025 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIePWOfr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCDA28851F
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743427; cv=none; b=mOhdQ/TH2W5i57wQexDgkuP2p4MP07OHaA++4q5vPBDhhY9N7AfErtEd9S0pNB239liZbU4vNZvatmklqXBBn8kkrH497I9V74n9Oo7VnYtSAyD7M2yG4okJezM6oNXRBXdCxJSlQKo80/ZpA4rFw3h5jMMRE1objUj2ZgBrIHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743427; c=relaxed/simple;
	bh=529Qak/sfp59pYGiC/TZea5yPOltqRTolGUKXHD1UeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHjT82I3Mh53OhY/JuKnA8BBvNYhpV/i/58GhxQ0SEQvkQq3nSU55O1KMvAOjxCeOTGhCfkmq8ykkynEFrxCEnyxLdi0SdNEmib7oSmcDlN/J7ztixCBfAs1nLPEQMIlM7XhnuEMZudqONDB4RLCjtsPqGGBCyz4O48XWE6MM/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIePWOfr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752743424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Fw27KCFfE/h9klyh3V20croFMoBwa4Sovv5KHmr7cY=;
	b=FIePWOfrJANXUw7Oeoc/k3lAW7KKP5XE2XTDconZ4p4RgURQLBKLggIKr4JHfQFxLanyT8
	smx7ayWSEq5+KQzb1Xz1XZTv0xGKb+zCdWMPjeIAWQm16nssXeLqKNPHiCsLkCvwl7FlDy
	tImndDOkAnPMlwiQY7lpaAs92bDBiMc=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-0ACJ37svMmCsERM5cFqe8g-1; Thu, 17 Jul 2025 05:10:23 -0400
X-MC-Unique: 0ACJ37svMmCsERM5cFqe8g-1
X-Mimecast-MFC-AGG-ID: 0ACJ37svMmCsERM5cFqe8g_1752743422
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-53141ba9e13so340395e0c.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752743422; x=1753348222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Fw27KCFfE/h9klyh3V20croFMoBwa4Sovv5KHmr7cY=;
        b=UUHRQrVWQ+iDYlrPUP2/ZN+La5BciVihwAmtE8/T5WJCfKUOs9x+53KOfS7sOTPs2M
         tT8n3ZH0QNNBYaFkHds96fbGveX2qhLwjdmcf9coGKLOSrPrfOS4Y6UPZMUwc6FQRt0w
         7QM8X5QjdRPKWCMC24BRjmLr5OD/xSs8IFmaleKwwHWXVNVifT08qyvscXPBA/rO3ero
         Ihwn6xlEX7uLJps/9Ctd6TSpK0lCtSJ+JhdIC6pnUsk8T+hyqdz3bnrNW8gG12SuC6J6
         ZwrdNvhd31G/YDhGoex8R6E4BohvqKyOrzRvSlc4pIfGy/02+gZwaByB47YkyJgmh4+C
         Ey3A==
X-Forwarded-Encrypted: i=1; AJvYcCWl+bgaaQk8LR5e0iv0MUsvOMaC6jWVHGBZyUluGfl65N8mW84jrvP4tui0/cu1U/7WKXW0j+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZH/WBm7AabZHbWkKB/SvSLUhQnwt8dvUnEsuabbC2eY8RXbE
	QhbUQG1ExbVsULfW2BghZKpQTRH1q2E+7Qb8ukOl6Oc3u8sp9thwjQcD746UMxq2mnpvTVNxKQJ
	SIS3GABAfMSpv2QlhnNEFSuiO4hvcMjcYpriY5I2aOSzcPu4+DUKNqE33lOIR9tUvjGnDx32bMn
	SWXB+zOEjr6knSJFTLePLhfJBmDty9uDnk
X-Gm-Gg: ASbGncv1X+QaARRyzXDvRcpCFesbvbSsMRlagJv8dGpHeTeHBXY9mrs8K/FWMKnzDFF
	ubp3yHrxHrjENPFoz3cmNNDczg5nk9zGrwmaq1cs1UYDQqqWhBNbEyUf8y/1zvfZS+ZtcyKfTFw
	hsutdd9L+LX7Sqt0fgUm8Y
X-Received: by 2002:a05:6102:5127:b0:4eb:2eac:aaa0 with SMTP id ada2fe7eead31-4f89996cb49mr3005691137.19.1752743422242;
        Thu, 17 Jul 2025 02:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECuZg4tnD3dbPOqkK7QLQFXVz6s0zEI1WL38YU/sbDVqoEGpcLhizaAQH/UfHtx1VrdY5RMF+LxyJoII3bJZE=
X-Received: by 2002:a05:6102:5127:b0:4eb:2eac:aaa0 with SMTP id
 ada2fe7eead31-4f89996cb49mr3005681137.19.1752743421877; Thu, 17 Jul 2025
 02:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717090116.11987-1-will@kernel.org> <20250717090116.11987-2-will@kernel.org>
In-Reply-To: <20250717090116.11987-2-will@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 17 Jul 2025 17:10:07 +0800
X-Gm-Features: Ac12FXwF3a40TcBiFPolR067u2ZE0YBPsrx96TsMziyQKG9t5JlhF_12qsJ9G6U
Message-ID: <CACGkMEsoBj7aNXfCU7Zn=5yWnhvA7M8xhbucmt4fuPm31dQ1+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] vhost/vsock: Avoid allocating arbitrarily-sized SKBs
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 5:01=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> vhost_vsock_alloc_skb() returns NULL for packets advertising a length
> larger than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE in the packet header. However,
> this is only checked once the SKB has been allocated and, if the length
> in the packet header is zero, the SKB may not be freed immediately.

Can this be triggered from the guest? (I guess yes) Did we need to
consider it as a security issue?

>
> Hoist the size check before the SKB allocation so that an iovec larger
> than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + the header size is rejected
> outright. The subsequent check on the length field in the header can
> then simply check that the allocated SKB is indeed large enough to hold
> the packet.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff=
")
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  drivers/vhost/vsock.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 802153e23073..66a0f060770e 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
>         len =3D iov_length(vq->iov, out);
>
> +       if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADRO=
OM)
> +               return NULL;
> +
>         /* len contains both payload and hdr */
>         skb =3D virtio_vsock_alloc_skb(len, GFP_KERNEL);
>         if (!skb)
> @@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>                 return skb;
>
>         /* The pkt is too big or the length in the header is invalid */
> -       if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
> -           payload_len + sizeof(*hdr) > len) {
> +       if (payload_len + sizeof(*hdr) > len) {
>                 kfree_skb(skb);
>                 return NULL;
>         }
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

Thanks


