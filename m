Return-Path: <netdev+bounces-276602-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJxVIj911mlQFggAu9opvQ
	(envelope-from <netdev+bounces-276602-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F83BE3F5
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCB0C3044836
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCD37AA78;
	Wed,  8 Apr 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2MYGPD2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzecFXX8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492527EFE9
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662283; cv=none; b=a1VBsWPvKvEOM9t4bSmnJggB3T+SexiALtBnxPFSE3b+7JvROGss1ig8rP4wXVeNn4kqPohCJ44JLSd5m7P3cIAjK3KPRNR+F0uhFiqE+7QaoTSyu09G/iRAZqa6hMC18h8uID/niMoXofyZ5JUBPr6Fted0IhARrYOKp9p997M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662283; c=relaxed/simple;
	bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFzUcTVOst0Jz1gT7o+6JGN27BfIVsTbDws6gsARuBOkDZ/tWUEiQykduo1s6YEfOTs6e4XTKNO1uzP6tts/R2N+ISgCsnR1DfvdaFlJLfXeAxmPPH332DDkrA7tumdihKwsuonlqBuPacBK4ICRRGG9uQ/5HIxV1y0xvEH1jGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2MYGPD2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fzecFXX8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
	b=H2MYGPD2ZugPgrdsbg6sVXDho80h46PFxdGGQoe07YirbkfEKXdp87sUClCWqCtaZ7pQl3
	p7jF+OEgLuLeUAxkBMc03HntJD8+Qaf2GY2vTocEm6aDvY5F9zHkr125hRTZs9umg8sCKt
	YAeGecIWTWML3irufjl4at8PNplrPPo=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-RmYuPkHEOdylfYF1KpwpvA-1; Wed, 08 Apr 2026 11:31:19 -0400
X-MC-Unique: RmYuPkHEOdylfYF1KpwpvA-1
X-Mimecast-MFC-AGG-ID: RmYuPkHEOdylfYF1KpwpvA_1775662278
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7a1f794a45fso677547b3.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775662278; x=1776267078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
        b=fzecFXX8y2zXugQR58HXuLHk7rt8X5YIO5l1AC2T2PpWhAcVKohNVX9/BqC4jZpGee
         qV7EIBJVbxzKRVN7HvEdG9UQWTOGqRIx6K5CPwBMTF3OyM1gqtiSCanusZW/Td458Pzd
         KTG2EYfXrsz0qfxXpldFRv1rhFLbk9oxkzYKkuyZuydfHe0OOZ41Vj5/HvbH9bU2fi8D
         XiCaFk4TorO8+U7lhSP71dMkDCO8VfRgTw31ZqvF3GxC6yZGP/1LyFRCdz7EC0I8mNvO
         JWNVPLuAmfTNumklVqbxzCoR+02yOG+Ag5dJgPpEzT2CgzeIoaZnSMmHp2XAmwhcDTeB
         RzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662278; x=1776267078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMz7w9UlDj+LjzgtxcZGpJSP55mlyq1h/m3lZi4NBQM=;
        b=AiT3umjf79+8DUozGNntaOK8nlImkx/AkjDGvNeHYb7qx2kPpjOi1rm4/WSg4SCOX8
         +PHFWfitl/k3scmOxy/vn91mgEy19KLyHSokdvhbcJOye/cr2Uy0C7sWG3hyw9tCYLYX
         lAE4yDKe9KVQ0wk5UD1oYCxDabYkl31gIEMT7ysr5o4bjmWFJN2aaEnHW/lTxFGqLABP
         FnL3ki/BniHncSUvcwPyPiHxzzSsCQIgvfQm0YErx/89koD2Qlm69pwMV43KINnaCctG
         XHoFULLGqW65LwHirHkVM2oAf22SUvuofdhnjGiPZ1mX9tFTY1LXaIOheIHFxbqU5+1F
         DcSg==
X-Forwarded-Encrypted: i=1; AJvYcCVSu4Oc9mrdWYXfBTN/E79UPfnOOt4aUT3EdqAklUdCYP5f1x46RpxtYbGwecakx/iUy8SH/sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRflVSe8Z9sHaB+4ilU8zCD4z2WjeQ94GYHlSEcez2qsqNPsq
	7Lw3fLE4+kpLNIwi9zj2OXjSvNnfZ78h4T8eaFIYqfdSJvSKEeBpruTNMJ9atvcfYvllIoYb517
	vhH3bS892xrfuuK6IfoEujOwuxThFFSa8fwN/faB1kW0XZqUIslFiOAh/Kg==
X-Gm-Gg: AeBDievShGoT0qQ8DlrswNZ3CHSD0sZ2/0OaqYv2iBP3nuosY6bwb09oBb0LN6AAAHd
	ntGw746P7bzgK1DvPDceJBAhf/7ZGY0+Tnc/Iog5jmNtdXna9sRsACXLrwstoOyaQE0O3mL5yln
	kxPgzvXrqvgC3iQVhKa9UV0KkCBPtKjk6m46RFu5lvZEdf8EZXC9chAspIETE1agzNEhCGm5SjS
	Ki5hO55rV/yXqH0Nem8OzJseUrx4js1ecCGFlg04Ld/m+iKj4vIpAqkqWbggTMpMCPCaq7bW5ym
	MOfWJ54yzwWvxYqdSp2zYoyw6itgZTN8GQyWn7Nihzlh8fR/ew/Ig1LAIU7q9ecc1inFWrF7UB6
	RFT8wYuhY3DHAORlR6TyQyv59qsTpHv7obxMcJcHjWNWez+fhz2D5P4tU4u+UDQo0I6QTir7n1w
	==
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr194747457b3.8.1775662278395;
        Wed, 08 Apr 2026 08:31:18 -0700 (PDT)
X-Received: by 2002:a05:690c:338f:b0:79a:b0c8:da98 with SMTP id 00721157ae682-7a4d32e4846mr194746647b3.8.1775662277684;
        Wed, 08 Apr 2026 08:31:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-236.retail.telecomitalia.it. [79.45.205.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac4c10cb96sm49299076d6.39.2026.04.08.08.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:31:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 17:31:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] vsock/virtio: remove unnecessary call to
 `virtio_transport_get_ops`
Message-ID: <adZ0pWsWQcbTAPEw@sgarzare-redhat>
References: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260408-remove_parameter-v2-1-e00f31cf7a17@redhat.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276602-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E49F83BE3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 05:21:02PM +0200, Luigi Leonardi wrote:
>`virtio_transport_send_pkt_info` gets all the transport information
>from the parameter `t_ops`. There is no need to call
>`virtio_transport_get_ops()`.
>
>Remove it.
>
>Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Changes in v2:
>- Removed Fixes tag.
>- Picked up RoBs
>- Rebased to latest net-next
>- Link to v1: https://lore.kernel.org/r/20260407-remove_parameter-v1-1-e9729360a2be@redhat.com
>---
> net/vmw_vsock/virtio_transport_common.c | 2 --
> 1 file changed, 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


