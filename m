Return-Path: <netdev+bounces-88997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121078A92C8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445371C20DF2
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 06:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BC95FEED;
	Thu, 18 Apr 2024 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPAgivSP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9391A282F4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713420545; cv=none; b=Ye7eXDPHv9EqI0NNYn9kLkZ6iBPRReqUv1X1ik9NqydjTle4usFpNG4iZo+a7AfDlPsonrDEpjb/lSaZiuTW+1aG5AmM+dsv9Gf8xO+NVgJrZiT9xXQYiLBNvujp2qInFHTp0fT3elM8oCh9WAMyQBFkFy2wWJ2f/MaIGbnKYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713420545; c=relaxed/simple;
	bh=SSUou10o2pDgMGqa3LTxveoMpsulBzmXgzKBkv/6KSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwZzEaCyLM3Oy/PPqZMDinHGsCe1ieV7RSfXhbzNxrJso79OAARFvqBAbomrWgaK7YRlyCxDjLcsy2NgilFEVR5u1fe+gU9r5t4ATtbq9u4he3yahImwPR2vgrpyGlYs2+abr6VMzHc1shpvU7MMPGcoBZpKAO9AvpBKxWfo8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPAgivSP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713420543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5rAnqK45cddGOhhwEGJeeGo4xeCJaxK4G8w0kAzgPg=;
	b=KPAgivSP/SCMXcGqZWOExEm2aocv/ALbfQY9YT3bCjPeFnsZ6qzFdJN+jHgsRlyzNiIo3l
	4wes7/ukVEigwuoLpFhEXwj0hvoXTexBmXr9U52vRJSJq+Wz3bLOKkNqiy2HKzGuSObkWK
	34t/HiSyqAUujaqZDSR9Pjso6IDd/1w=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-qK4LvfeCPHS06towKVTnRA-1; Thu, 18 Apr 2024 02:08:59 -0400
X-MC-Unique: qK4LvfeCPHS06towKVTnRA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5dc992f8c8aso550900a12.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 23:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713420538; x=1714025338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5rAnqK45cddGOhhwEGJeeGo4xeCJaxK4G8w0kAzgPg=;
        b=UKDrsTyakTNitxcX3w4KPzAFC12x8moC0/qWn3tpjSf5Uhf1a+UL87RubG7CQRs5/v
         eDLhzDCLEXqToufDLirb7yvVuSVFh/aUtzsZgd28v0onlmokOd8MV7c8HMvGSDNLPqDI
         9XvSVE6AFSxse5jWYknv4VAkm2Au12RY7E0EC/aFFzXlN7SrbPTn6GQmEoxFrrHSkjnb
         QfR/seGH9bklWCJ0zslh7+8b/ybwC1hrRSP+bWudbVPJmIPk5sgf2lh6VM4h7Movd3+4
         KxQGu8wIz2jT2NdcakGkN+MTtsUKnfQ410n1k0QXU5I7gKmhUE5wyQN96PF/ZNLd3mfH
         TMxg==
X-Forwarded-Encrypted: i=1; AJvYcCU+L8Se5OQYUOOBHgyZfc6nFAA98lgyr3bdbxni/kQRuNFfCRJ4ZBXAPbA9WZ9d8X/OxKR/GFiaYz+/MobjOBG8IDN4sq91
X-Gm-Message-State: AOJu0YxIu5ylU33lV3r6ccfcA1mSee2Qykkoy0/yLuP0VGa1HX6lGmKB
	tH8dar+3ikng3G+cuqlwVKYYZXdFHGF47oTaiP9E409jIMfxWxl39espTUmCX2Gwlj3dHXq+7Uo
	q/8C0zDuh1h+yywSOL4aasTyGI2sxTVHUMBFSshq5ZCHDa46DGoRPL9fi/E9eSWg+vBKfnjFOYK
	lmEEw75RYxahNPpcv74KxDrsLt6TrZ
X-Received: by 2002:a05:6a20:748a:b0:1a7:aecd:9785 with SMTP id p10-20020a056a20748a00b001a7aecd9785mr2293889pzd.25.1713420538545;
        Wed, 17 Apr 2024 23:08:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsJsT0x6OHZetDoaWQ1nKS4EkZBAC7JoKFrSyZxcWc2dmmPrIm5K1eaDg1B9l4iwS7BnuNpR7nozmkwwtVJZA=
X-Received: by 2002:a05:6a20:748a:b0:1a7:aecd:9785 with SMTP id
 p10-20020a056a20748a00b001a7aecd9785mr2293878pzd.25.1713420538263; Wed, 17
 Apr 2024 23:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411025127.51945-1-xuanzhuo@linux.alibaba.com> <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240411025127.51945-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 14:08:46 +0800
Message-ID: <CACGkMEvSTPnYGXmnOtAODS-0UPVaAqdTV_5zqGceN8R7=MvkGg@mail.gmail.com>
Subject: Re: [PATCH vhost 1/6] virtio_ring: introduce dma map api for page
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:51=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.=
com> wrote:
>
> The virtio-net big mode sq will use these APIs to map the pages.
>
> dma_addr_t virtqueue_dma_map_page_attrs(struct virtqueue *_vq, struct pag=
e *page,
>                                        size_t offset, size_t size,
>                                        enum dma_data_direction dir,
>                                        unsigned long attrs);
> void virtqueue_dma_unmap_page_attrs(struct virtqueue *_vq, dma_addr_t add=
r,
>                                    size_t size, enum dma_data_direction d=
ir,
>                                    unsigned long attrs);
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


