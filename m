Return-Path: <netdev+bounces-109722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CF929C0B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE4A1C20C86
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCE10953;
	Mon,  8 Jul 2024 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkegVhdX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6077125DE
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419519; cv=none; b=de4gz46vLI1xvlX197fzrbonNJNScCgdAl5FMkWrrBwSG0QAcwIbHoKKbWewBDEGu4bCnPeSN1gMFmSTVVLNtZfnIIFUZpIE9F8t3p0FKB70wc/BMXlJREvNKVwdstrSgV0qiBDDo2kToOQy85nT8Z2PuskxRaXjUVWynAgLH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419519; c=relaxed/simple;
	bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYNnFzYOwigmThicBhX+MT+Wh34htNeL7OtPg24YEx3jrtX6Cygh/weExSwt2iNtm6yp+Pe+hvYPUqaqN9c1uBabUe1FNqzyFCqtJvlyn4UQwn5uDIhMb6N/Q7VS4jLs9CTzKHUdrcsWIRWoUjZwRf/M259tYROyNUway2GYJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkegVhdX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720419516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
	b=TkegVhdXhouBsYUYdbm7TdMPSiy3pOsTOO/qkEu9jceZKhC34hd1N/nyAHEXWUpCVEMuwk
	d2keaHLGgr8nP9fGYqoQ+F1bxCzAbH9YLgqWkbXFdDECQ0s3pxg+N2vx01q4Mx7H9j/H4m
	anlQtO7S7vYXxR8lcmDsQ5u70ualg5w=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-FndGnJ44MU-afMtdOvt6zw-1; Mon, 08 Jul 2024 02:18:35 -0400
X-MC-Unique: FndGnJ44MU-afMtdOvt6zw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb268028d2so19768395ad.1
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 23:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419514; x=1721024314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJyMS4iuI2rFPim2v94RCi0s1Q/QgRPRXzwYukaZDmA=;
        b=CwZhYtfV/jlgrvfI+YPv488LbxdhaWISc6ZLYbSoabQ3Srot294z2sB1NnszHtn/gm
         /2DGbZNK4afXeH30mqGYUQ0HWxfKj7iOOoIaupfAxZP4YPDdsN7Ij7rd9a9FIoiIdXbB
         lFbnPU7QEEGu1gogwOCUTqeNuXSYfLXuq7+eU+tVg+Gs/k5GICqjcVieYsi68HbA/4fl
         iaUSM2RPQVwDjpkGbINWrg7nFNCyifv5IfBhk5b4ZWcDGP2dt2TycyZvgEkiKDmpBGC8
         jQTgjghTAfW6l/hpk/Coe8Uxo39XilaGh864vWMrm0KvTFV6ESkq86J1O4+2gnCz+g+Y
         GWcw==
X-Gm-Message-State: AOJu0YxSQVu1bNHMzjd7FrS/u+JfPikjmz1UB7IeAo1KBF1hDEhjt6ix
	4tIje08O50N6e46jh4E5K1eHwnvrI88DIhDJ8DkMkiEZ3T6lYjUyJ208OZ/vLpJctubnHXxEA16
	K8v4lSeSGesR78zcgVE8hGfAeV/hBGUilRiw6mCx1DDiVNEGqQo1zfpOq1S7Z8sN09QN7PeFZe5
	9C8YrNFcHoDGMuOu3Ks2Mrzfn8wFl2
X-Received: by 2002:a05:6a20:2d10:b0:1bd:4bc4:754 with SMTP id adf61e73a8af0-1c0cc74d964mr8965813637.27.1720419514339;
        Sun, 07 Jul 2024 23:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFayZpPEg9Vaky5HR/PLqBUvW+SazsbNfG/BvLurCEgyFqG4nbfYr5z1CFXGnmN81flNu6bpN0+rmCr78Y+LjM=
X-Received: by 2002:a05:6a20:2d10:b0:1bd:4bc4:754 with SMTP id
 adf61e73a8af0-1c0cc74d964mr8965797637.27.1720419513986; Sun, 07 Jul 2024
 23:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705073734.93905-1-xuanzhuo@linux.alibaba.com> <20240705073734.93905-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240705073734.93905-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Jul 2024 14:18:22 +0800
Message-ID: <CACGkMEvr4QYNBX0fQAkXYUuKn0JvZ2dZtwsqh+0SCJBCsxMVnw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/10] virtio_net: replace VIRTIO_XDP_HEADROOM
 by XDP_PACKET_HEADROOM
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 3:37=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> virtio net has VIRTIO_XDP_HEADROOM that is equal to
> XDP_PACKET_HEADROOM to calculate the headroom for xdp.
>
> But here we should use the macro XDP_PACKET_HEADROOM from bpf.h to
> calculate the headroom for xdp. So here we remove the
> VIRTIO_XDP_HEADROOM, and use the XDP_PACKET_HEADROOM to replace it.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


