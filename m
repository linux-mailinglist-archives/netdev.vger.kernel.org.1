Return-Path: <netdev+bounces-175529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C628A6641A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F304718933FF
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 00:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA7045C14;
	Tue, 18 Mar 2025 00:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TXFJXX5C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BF621348
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258940; cv=none; b=AXBdkZKXDheNXJzpDOLaeBHWXpC19YRqLdp/PgBfoWqq3nBKz5urx9jLaXVtDqP1xqXxhI/X/vBPhYzwpxKvFf2z2o82RzkoVI/fIj/OZ3QOr8Bm7PzA1/LYlbfci9eKJwly/Ps30uTQ+ktHYsEOaM1XH52PNzi+ApfmfKzMgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258940; c=relaxed/simple;
	bh=747T9jLSqH8bFgDb72pde2D+kt0cpKYYu/2oRmA4qo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c99dyLHepnzSsxui/9yQ7n/M2zJVRSC++p5zaaJaeW4hgsPQaWBaU2MUC7QCEylwBHWi6dXwFbXkC+gEOI/lOFUhHeEx9cSaPmGtpV9rejr0rD7/kwBYhXHhZ3pcBohi8+rwLG0Q/6P6uy5EugiqoTa2cvFef7tQkcyUiGW33CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TXFJXX5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742258937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nlAq9ja2RSbJ2WExbn5JQkIBqDsE/3iSsVzG9YVP7BE=;
	b=TXFJXX5CoBrtvTTjf2ILo2xWysKiBPc8sqb9l1dzHnbZTTdN2eKnxewIlQ6oE1GEA6OFog
	pmhywWcwZaq0zPpgk4UU2rTD1Lgu7SHGDO3Iwktxw9h/WgioiW7LK9rzZx8N3pz5yZSC3t
	pnb8L+Op2xWH/89/3nTQ0+YPM4uERyg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-91G8EHITMru_yoTSqdXQrg-1; Mon, 17 Mar 2025 20:48:56 -0400
X-MC-Unique: 91G8EHITMru_yoTSqdXQrg-1
X-Mimecast-MFC-AGG-ID: 91G8EHITMru_yoTSqdXQrg_1742258935
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff55176edcso3763004a91.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258935; x=1742863735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlAq9ja2RSbJ2WExbn5JQkIBqDsE/3iSsVzG9YVP7BE=;
        b=nAXWONmlnvaU+IQpkzuz4fsb6BpW1V5DrW+vrYYzJMfkXBg58rHysYouc6EW2V5EnE
         mwkmosQthQp07kgHaR9TV8DaDV38K+udohEI9+/hr5/SsCJEcDY4OKsS6k8ojHpKQKie
         5+/hwDS9LgGVs8gD5BqUngCyiOJDOrLKYRWNYFKV/ImmjZQaS27uQgNdIWudkSNH0yLt
         vjjEKg9XEW3QKo2uMLKz8x32S1j8r9bbpZPzuXm7RabWlsy+nblVgXB1AtyayXvlG8Xw
         YVXfdqmNNSp72VzGhIxJ2i1hm5eTdjpKMRJEnUj4V2nKAYB72LEKL8RK8CNEfWlTawC8
         8o3A==
X-Forwarded-Encrypted: i=1; AJvYcCVNIdoNL/A2Y2b9BbTaivkbE1wMWq7Qsa873lANnP/vxU+ceVXl3VmoidafArSmiMfttDP57oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGTBJcPW8yrdjJKngBr7fevK8IZg5PENlHXpCiqaHlRVZ9h3Y9
	YJPKhoubuCc3xwwtI+4j+vtWttIUBw1oJwrV3i0/o/2388oAqXEkw6rB3AkpjaTG+bJUuteiK+Q
	yP5vMb8avmwWjaUU0HwB/QeT/AAp9CRutfRZoKU80zJ1dJS7J1Rkkfw575pOpch+Zl6HZH7twXe
	LXK0ql+3a/iQceMUUcg3MItboi5AQ+
X-Gm-Gg: ASbGncu7ElcRc1SObvRVwjT+2WSCGl5yv0QD8HCKah4Xlu7FoS+gRgbpQruEbuddhYt
	sc5pM80Kx0kMXlfeVUui0ZKDZ2bhLKew7xBy8D92e9Dr/Wp0UB2gu3abiei83eJB3ZTFkrQ==
X-Received: by 2002:a17:90b:4b10:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-301a5b1313fmr486183a91.11.1742258935177;
        Mon, 17 Mar 2025 17:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjSE8bZtH24Q4k70pqmCF3Pl5ZG79aTMFklPXXWxS7VadnbTFOusaQmH8Wzxx/kb4T1iFplzJMw+APpySRBkg=
X-Received: by 2002:a17:90b:4b10:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-301a5b1313fmr486162a91.11.1742258934866; Mon, 17 Mar 2025
 17:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317235546.4546-1-dongli.zhang@oracle.com> <20250317235546.4546-3-dongli.zhang@oracle.com>
In-Reply-To: <20250317235546.4546-3-dongli.zhang@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 18 Mar 2025 08:48:42 +0800
X-Gm-Features: AQ5f1JrAlxtKtwUtKRrW-cmJuRCs9VYdUge7DAbLNhWk3XLXSW2HZUWTJOSqcLg
Message-ID: <CACGkMEuhqbxr-20Jghn10fWH+pCAVih_KvWU6Mj+FXgE6TOTVA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] vhost-scsi: Fix vhost_scsi_send_bad_target()
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, mst@redhat.com, michael.christie@oracle.com, 
	pbonzini@redhat.com, stefanha@redhat.com, eperezma@redhat.com, 
	joao.m.martins@oracle.com, joe.jin@oracle.com, si-wei.liu@oracle.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:52=E2=80=AFAM Dongli Zhang <dongli.zhang@oracle.c=
om> wrote:
>
> Although the support of VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 was
> signaled by the commit 664ed90e621c ("vhost/scsi: Set
> VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERSION_1 feature bits"),
> vhost_scsi_send_bad_target() still assumes the response in a single
> descriptor.
>
> In addition, although vhost_scsi_send_bad_target() is used by both I/O
> queue and control queue, the response header is always
> virtio_scsi_cmd_resp. It is required to use virtio_scsi_ctrl_tmf_resp or
> virtio_scsi_ctrl_an_resp for control queue.
>
> Fixes: 664ed90e621c ("vhost/scsi: Set VIRTIO_F_ANY_LAYOUT + VIRTIO_F_VERS=
ION_1 feature bits")
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
> Changed since v1:
>   - Move this bugfix patch to before dirty log tracking patches.
>
>  drivers/vhost/scsi.c | 48 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 11 deletions(-)
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


