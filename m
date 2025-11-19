Return-Path: <netdev+bounces-239770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A85C6C4D7
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5168350CC6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 01:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90849243968;
	Wed, 19 Nov 2025 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhyNiyHU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbSa6r0n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70B86353
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517209; cv=none; b=fK0AKv+RSwtv28lj/s0T6QLSySoloCjPly/9giWwbMckwwNFK+0E2YAYX2EM6CmowewtrLycGxAX3OFjiGRo4B7meisAOzQxXD3UHgOwbrocruR5j2mlVrSjTNr3Bdg+DZu1PXcYgkevpGoffrP5AgJTWkl5afrwOq7PVoAWk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517209; c=relaxed/simple;
	bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCL7GVOXD/BtL8LoDt4tz0MSx1e9cawwPM22vEsyMO3vBHi4TiBTx0AOY73bH6txntVtFDpdbEjAflN1oQmKYgy/JU7nZ5tsuuXrX2OLWqMSLDVg8DAiHQesU78E9bauxqTeoQ3ofzFo3mAJKTDZUj1GkPMww/eS6yngDefKNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhyNiyHU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbSa6r0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763517206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
	b=FhyNiyHUFiEbK7+aO7jIqbf3CJcqADxzOG8cWKBBn5/MCeLDSarxphcElGbEuAcn7iImPi
	K+UGJkhZxlTEsEHifixMpGR2m2yB+qt4YgT0+YeRlHm+ofudnolbt/grOSG/csUa2VqcDG
	Ud0gd0jo32UdSxJo28VE66+9AnuGkZI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-XHyyWejcM_6LbijkUKOrHA-1; Tue, 18 Nov 2025 20:53:25 -0500
X-MC-Unique: XHyyWejcM_6LbijkUKOrHA-1
X-Mimecast-MFC-AGG-ID: XHyyWejcM_6LbijkUKOrHA_1763517204
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340c07119bfso16281486a91.2
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 17:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763517204; x=1764122004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
        b=dbSa6r0nkDdbm+V5KCUkhCTZxbROcrLh0L+HY42grllXPmzS17SgzS36oXf50q4R8Y
         ywLUo/UoUhao0gswGVS2/79oQRXE+0FhQTy/kkysag1NbUOaWL0Y1IhJjScckP3HC7+3
         bM4aZ1/x5BeLKkLknumpdGDPXOLCmSliZ2jKUb4OfZUlZtwYYeRA/jkYWdJdweFLP1vA
         MabGVR5F3uM6g4xCANkfuvr4cLiaRdxSx+HzeRx049Xwbk9FL5QF11CcgMDLhccqFaed
         gudX08bOP5NQ/vVkDz5VZRM9EN76AUvVNeNGb5jQTYJIBzxZdYsUX/QWYMMTnbgsIEC3
         cysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763517204; x=1764122004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KyrZzK9mqPm9s39/r9lrWoYLT4pjxbJQMQSDqyYyq8Q=;
        b=U8NbwG6juIlC6mJOQbUAV3pREh8lsRelSqtCnulqYOo+Sn5vZDAlOw70WGLzEDNBTU
         l62nH+1ScuBoLccuQVekBiMc1MOn5/x9yh/Nu/wC3k9B1bpiH+WEdmoEEeXyOV0GhMx9
         kAHdJ7nC0q4tH6wNhEtYq19Yz38DGt0ikGIP7Glo0a8lUquf+DRLoANXZ9h90NAn41Wy
         1KkXoK4OJr3x3b0zUPZwF1hfenE0ot3/IS451hLGkPicCdlfmZEk5QOR8hleN8W9ZR+H
         wTMMGXgNmYwZufeDL6fp4BmEf1VPpCJ/spZkXgr+o9fIvL6vgSxHc6AkVT/xQKvEsHxD
         5D/w==
X-Forwarded-Encrypted: i=1; AJvYcCXTIYQSjCOrJhePM/SDdHQ2X613MGlif35CzcJut/o5nlUrbnvCxpBAE1SlzN/Hpzo7DQdEupg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TvGoasbFHi16YvMkKB6Ga92JBtLBQi1ckOjptbPwDnDnkxda
	X65JEOS29IfEh0qiYLH2T3T714JWSwNNV+4VFh6jlKpYzE5BL0CNT+V2SgyzkKBIF+5dfd0MDe9
	awx1y8CX/IX+9BK1v2BeHMj1a8oZaf03g4uKyYzG9S6kM+OGGDOiKpQrkVucmNArte1CtxqkypJ
	nYJ1OMxVqvfB2E92d3Qmjc5LGEvVOPCzRj
X-Gm-Gg: ASbGnctqdZaghvv7x4UysDTRrdn8OWoClc6Lqkxbz4UmjuWVDfhenjiHD0yO6oM6vMi
	Asw5buxO/BKxlCvUGy2HmGytkrYCbXX7y7FApdX+V+xosxh42qR5ofJFJjM+81mw87rCBI3nkQF
	BqesLAJ/geKYipZoJ86ANMMyBkO0pQcl4KHdLjhz/vmfcv0ZRP8XJxlKELuQIxECE=
X-Received: by 2002:a17:90a:c2c5:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-343f9ed96e7mr18500455a91.13.1763517203962;
        Tue, 18 Nov 2025 17:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK0BojLkbLsinUEMLK9poTO5T3VKUI0LJ7vBrGV4ZQeudjfClMdb+kGPfFRQFUzDtww/LkSD4FupuTf50Ci1E=
X-Received: by 2002:a17:90a:c2c5:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-343f9ed96e7mr18500412a91.13.1763517203120; Tue, 18 Nov 2025
 17:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763278093.git.mst@redhat.com> <67ae57499e779aef2c5bd7ee354af5d4af39bf60.1763278093.git.mst@redhat.com>
In-Reply-To: <67ae57499e779aef2c5bd7ee354af5d4af39bf60.1763278093.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Nov 2025 09:53:11 +0800
X-Gm-Features: AWmQ_blKYAEU3q3XwJg467m-DKxSN_o3KNaIqr46lnM6uOA9mljHAoG_O8bYpVw
Message-ID: <CACGkMEvgQmUNVOzceNscLJiBxUiJDwJeST4Fe4Up7yBgbpxu4Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] virtio: clean up features qword/dword terms
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Paolo Abeni <pabeni@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 3:36=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio pci uses word to mean "16 bits". mmio uses it to mean
> "32 bits".
>
> To avoid confusion, let's avoid the term in core virtio
> altogether. Just say U64 to mean "64 bit".
>
> Fixes: e7d4c1c5a546 ("virtio: introduce extended features")
> Cc: "Paolo Abeni" <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Message-Id: <492ef5aaa196d155d0535b5b6f4ad5b3fba70a1b.1761058528.git.mst@=
redhat.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


