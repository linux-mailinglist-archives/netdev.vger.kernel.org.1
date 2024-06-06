Return-Path: <netdev+bounces-101348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 050328FE387
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64145B2A15C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69A17E458;
	Thu,  6 Jun 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYpjzhGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353ED17DE1A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667391; cv=none; b=BN5ebiyVKpeILwzIk1k11S7Jmx8GqjzcOWtrgWd2gOaH0rCS9LXswJl0nsiqVIm/7BwwEVick7PHcbPbjPMqIccM3gGm12jdTYNNtlqiv+NhqSaEAVKiS7fcAnWPiYhXnrWAiZBtONVZRqtGpLBzN3W52neWuLV+RywfLG+zB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667391; c=relaxed/simple;
	bh=+s+yhOwg79j75o8WoByyWhf+YyJpWwFPenJ7DA7VLW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqF6+/2mNewgI8i8HopTLw2A/JWX8XMJo1T3U2XsGaqqqcXxUAY0VYIRIUc872BW1Hm8LeEmmv39KbQx1qcCxYEBhSRGSiTUApMgewwVx+eKF5aOngk6C03Jmn/CMeCOSxiEeeBvIbSdDSsMuwhLhtNnwGa6Dh/DWNZmO3w6eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SYpjzhGQ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ae0c4d23ddso4053656d6.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717667389; x=1718272189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5dL381WobNig2njEknAbaM2t6txWWIRtjrYV1jJVaM=;
        b=SYpjzhGQwi6333WbPInlvqabETPoav8oVYf4feGBtBVlV1jw+pznvqyzafjw2ARXsh
         qAAQFRs9PBcfrqeBIkk2YpAy16baAGGtkPzHrTfAvClCpKf+Rxi5oSCzlDMB6+VF8OgD
         EXxK7CE33dZuB1Qy5iz7Xi1dvAQIbZziAkZJYQwjfAS56tftDpWd1wae2TLh5R4eexlz
         6pm8V8RZ+uvercw7LCfZMKaxKgXY8UCxJr3lPnGRRIoAuEoI8j/kDTgcM3STYxeSQ3Z1
         WjJfdLtGysuK1rZp8M2i1jUjhAZcHSOlFw1+ZvBFxaoP4WRNHqg9kPFLrDus/7cxmCsv
         JiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667389; x=1718272189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5dL381WobNig2njEknAbaM2t6txWWIRtjrYV1jJVaM=;
        b=oWaPyJg1xm0sUqnT7th8Gmz9Ym/noEW1JXnQnD/lPTIgSgglw2AzJIOhSaYhPKqGWG
         4qtt+S3y317JvgthlOS/lCTn5RjfkCGiwlWfpu+53qszWQPZCn3XGgmtVqgVu96Xq0Yx
         wHe9aWIPbH23S7LbVlN35AkB3xEORnHZM0g8Yi7b2gK1rlPfQFuAQUAYr+8fQ+jwOcTj
         qvxLiRcoJ/gOWjGYwbe38muXMGFl+1pcsG3b996j8sqh8cnCzwQlSVVAtwBITD8nJyWC
         eAzJjonrbOvU0VZVEIL+WIowxEalNNm3TJNTYm5O8H5znb4iM2wwiEkFI8ouExUx0/vl
         QW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvVRZubz5eRqmrR1P27z9tVTBart3PEwM1ygzzelfPOMALm51q5xnXXr6SY7SaCqvxfbqPbK5d+H1EhHjNoZHsUY5cjzTm
X-Gm-Message-State: AOJu0YzaH1RXHTQRW55Ci7wUXT5MjsTM1bsiF5KJ7sxNB6mOQk/BXof7
	9U8U8DyiBuHKEa9LRdyHdNtBkMpPnHcYXAMAISGapnNyjiGI2gT9VakqvQSSFEWR+vFIGg+uOTf
	4XjbqOIeUa5cwZVckWObJbt9eKEQILcAqkhp3
X-Google-Smtp-Source: AGHT+IGSavWspcAP+9gFMHHK5+xZQBSdefZIDFgx0Jb2MuNzkoSE1fUwptT3XiTbAuOpSImCAU9XqTknjXm91l63MJU=
X-Received: by 2002:a05:6214:5f01:b0:6ae:cec8:be38 with SMTP id
 6a1803df08f44-6b020321366mr63489686d6.5.1717667388916; Thu, 06 Jun 2024
 02:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-5-xuanzhuo@linux.alibaba.com> <0b726a75574ad98200b815f173e59a5378e9df04.camel@linux.ibm.com>
 <1717644183.6895547-1-xuanzhuo@linux.alibaba.com> <CAG_fn=UsqAhH57s08+prkj2iJshhxuLznzDNft4dPXHKX9V72Q@mail.gmail.com>
 <1717662283.8634596-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1717662283.8634596-1-xuanzhuo@linux.alibaba.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 6 Jun 2024 11:49:07 +0200
Message-ID: <CAG_fn=WwijXza_xufVNpBMo79Nh6uysV4MyWt_T264Pji3gA7g@mail.gmail.com>
Subject: Re: [PATCH vhost v13 04/12] virtio_ring: support add premapped buf
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:27=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 6 Jun 2024 10:20:21 +0200, Alexander Potapenko <glider@google.com=
> wrote:
> > > Could you try this?
> >
> > Hi Xuan,
> >
> > What kernel revision does this patch apply to? I tried it against
> > v6.10-rc2, and only the first hunk applied.
> > However this seems to fix the problem, at least the kernel boots withou=
t
> > warnings now.
>
>
> Sorry, I have some changes locally.
>
> If the hunk #1 is applied, then it is ok.
>
> Do you think we need more test? Or I post an new patch directly.

I think we're good to go (just double-checked that). Assuming you're
sending the following patch:

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2a972752ff1bc..9d3a9942c8c82 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3121,8 +3121,10 @@ dma_addr_t
virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
 {
        struct vring_virtqueue *vq =3D to_vvq(_vq);

-       if (!vq->use_dma_api)
+       if (!vq->use_dma_api) {
+               kmsan_handle_dma(virt_to_page(ptr),
offset_in_page(ptr), size, dir);
                return (dma_addr_t)virt_to_phys(ptr);
+       }

        return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attr=
s);
 }

, feel free to add:

Tested-by: Alexander Potapenko <glider@google.com>

