Return-Path: <netdev+bounces-82755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EB188F9A9
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 09:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A369A1F30007
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 08:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844A54FAC;
	Thu, 28 Mar 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qd/v9pf1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF51548FC
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711613119; cv=none; b=FS728rLceOi4/FTPUTQ3MRKMXJ5boH9m61OXpeStb4B2veXcYsx90h4PXWJC7n0wrlk3wY3kbVj/dwUaiLSacnIJ75YLzXnkkUQzOyOVPwB4AzcURhhx+BsDfWwqY4paXqWmHQmYqWruoCTtQ2lowzWyk0dN22gdA5nUOCU8VCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711613119; c=relaxed/simple;
	bh=Be0UUd5PJExJNdd3TaFGM+tMRsL4MrmrEUd8POcwdfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeECTIcOKOfk1oIH0LVjRxaGxAKuzytv/I68XuHOIMrL746PZpPVDgKHTsoOWKOHsehVsCExljG6xxhV0UDp2eNu5df8PpEWFlsaMPOEFFEItnA8Db+VCERP44kSZ8iIzsVMoKMsDr2Z1g/FRRfFKo8yKnLiPxq380LNCeBZ4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qd/v9pf1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711613116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be0UUd5PJExJNdd3TaFGM+tMRsL4MrmrEUd8POcwdfo=;
	b=Qd/v9pf1/Xlih3DYTDvlyuSK9izd0ubjlcEUH2e8/OOxsKJC7qxfoiJwG7kXjca5SGLtUI
	42MRewTfkYbGpXU/YnOrDGIqd0v7WnFlvJ5NB1GhP8Ts2R/unSxpugwOOJvRwTAnbOGP7E
	vP1ywNrvI6PIo0xQmzx3Wd80pDUo4gg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-NzHaWJgbPfy3ujgePZArew-1; Thu, 28 Mar 2024 04:05:14 -0400
X-MC-Unique: NzHaWJgbPfy3ujgePZArew-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c5c8ef7d0dso494280a12.2
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 01:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711613113; x=1712217913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be0UUd5PJExJNdd3TaFGM+tMRsL4MrmrEUd8POcwdfo=;
        b=QybK7tquEtpNUJ5zX4J+7xrzEl69rk3GtKBwOCfGGtjbbR3dEbu+Gmpqz1YCk8Ql+5
         V7yVJ54w3asbHbVjZ0xW/togTzLDNGox4ptzKO9k2aPVZ5OMOGqe/xV44JeIiVREbyJa
         EzF6QX1bLVJ31s4h/my6Yt8oFNsdlHuPUC4rw6+vCq5/2EBAN6AzzYd049wiCDC3OH+E
         r7zeHD1VNwHAHPymR/4A56Qs/TZfY6f+MdTmP5MmMywpAbb0H3AJYTr+NTzXUDNEgEKV
         i89jI8hPLljKRPsE/RmCJ7IkMci9qCCiBkUS1GE+2n7YkDBSOJOMySRv28kSZBYYhVo4
         jiVg==
X-Forwarded-Encrypted: i=1; AJvYcCW5PiWtInuMscsQ/TDVT6Ek2PQ/fPKNIrUDWIiU6WiISnjL+X7nkpcYyFK7YzyMzCA0xQEajEM6vrv26dBEy0U3hXfjl1ue
X-Gm-Message-State: AOJu0YycJCIHi35x5c/TaWNjkBcIQV1gmvGcbxvP5Bk2NRYYvImknfBE
	KopwJIOq+pKPHFPxjvuBogmM3eVRI1vlpPLdzy+IvFs62+fWpHefceEh/JdbbCQ6VjlaUu/G/Ty
	ulO9ECREPfNdj0UG0ApslYX2yaDf/AnWJmckBTIaMFGdeZqNho1yb7kDVqqfVf1CQIpHQiSdVcj
	IFiCikFMwn5gq/NZz8ZjtgfHwXd0A4
X-Received: by 2002:a05:6a21:338f:b0:1a3:71d4:cf3 with SMTP id yy15-20020a056a21338f00b001a371d40cf3mr2662981pzb.59.1711613113303;
        Thu, 28 Mar 2024 01:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERrEZq1/g2j0eedaT4nU+tDdrIYn3NcnhmsxEIr3VlSxiStFU+h9PY3rVqqpDbZd11ygttWItTa2FI/UGvmcc=
X-Received: by 2002:a05:6a21:338f:b0:1a3:71d4:cf3 with SMTP id
 yy15-20020a056a21338f00b001a371d40cf3mr2662962pzb.59.1711613113069; Thu, 28
 Mar 2024 01:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com> <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 16:05:02 +0800
Message-ID: <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, the virtio core can set the premapped mode by find_vqs().
> If the premapped can be enabled, the dma array will not be
> allocated. So virtio-net use the api of find_vqs to enable the
> premapped.
>
> Judge the premapped mode by the vq->premapped instead of saving
> local variable.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

I wonder what's the reason to keep a fallback when premapped is not enabled=
?

Thanks


