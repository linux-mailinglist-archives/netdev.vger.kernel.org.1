Return-Path: <netdev+bounces-166063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29DDA343CF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4431887BDD
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC20242928;
	Thu, 13 Feb 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNNv4Imk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375923A9BF
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458043; cv=none; b=gUzlFQ4aPdmFy14gAi3n4hlrObYELiqGi1U8D00WFfxym1x0caW3yPv86113NnwGrTpijz25OLHP3w5WjMujDAF8DZ3L0meLk+BAYG/7rlx1irhIzVrYN+cxljiUaFKHQ/qEQTdDJZ+vrqTe/xk9E3R0DeY9R82NI0ZgdcriYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458043; c=relaxed/simple;
	bh=tPhyVVJDg+eB9kkF+HosG3iztKpJSHNf3iCVuHVuR0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cl0m+f5AkyNz9m765nxNPlq2EyU1eEU1S8t1QYq9iDcY5kmMqzgYGl4N6sGqvFaceW+zUrS16OJHYNEeqi62XmdNeX6+qtLuRcS+PlXahckywCCD1xoyGaFflXx/1N4Zj7vL/pSUbbl1UQD0Vmykaaw8eSCSImcg1MYyHHdqOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNNv4Imk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739458040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAKfOutKaK2ALg6/h1nMfRqlupNtDP/2Xy+rsmNojjc=;
	b=TNNv4Imk8497K+yOnhAEaegy/3l5KkC+xYfBc2h5RngpdFpEnKyyBGPx7Jhp38IKk5SV07
	ie2ilDLuQ6zzKkgMtJHPlSKxh2NAnlqiUmML3doDjXbX3CfmxFq6If0IyaEitZFVp/IgvB
	N8aE50Ci2N29FC3m0FNLFGqCGGcjExU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-p6PYlPXvO5ulAp4toBvrcQ-1; Thu, 13 Feb 2025 09:47:19 -0500
X-MC-Unique: p6PYlPXvO5ulAp4toBvrcQ-1
X-Mimecast-MFC-AGG-ID: p6PYlPXvO5ulAp4toBvrcQ
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6f9a88fc521so13616307b3.3
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739458038; x=1740062838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAKfOutKaK2ALg6/h1nMfRqlupNtDP/2Xy+rsmNojjc=;
        b=Kr5xAOOw78YEY8cLvKOae6tvg5EkfTTsgWa1W9XAl7hPxRoKUbYzNXmBaf6jnOv7gE
         CNsyrWgs/N+QsBwrzl4YNBmWGzmEsdLjVd1Vm/LyUx776wN+TNUYtxogDlI15+8pSHkI
         KrwtK/7Xc3cqf+8dnB7u6UulSnXkE4dUTdHIvqQiZ7Ehlh4hlsqNNoeP7+IXqq3yEHfz
         /fJQCeWLVSMtl9Ba0E8H70NKtvi2T3U+aqzMHOFkTFVeXmr4Rngu43sNxCDxyH2v9RJ1
         oo8p/bgEF07xaAJJi4WOlvFVpO8R3Yjz/MHwxROx93oMHvbiJQsv3yQLG1vQ7vT4XLiB
         zgwg==
X-Forwarded-Encrypted: i=1; AJvYcCWFRIZzQJ3aauHstwuL2NPI1N/SX+N6PuRzAD3lWuMUFU2SK0kd1R5I1ENGvmf3o7QRV6kl8PM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65lmzOsCm1VkFhwjQA7PThh5d1Ip41dE0DdaYnNyeI2J1YwT3
	LxPG4ahMrFGY4bofZwoY5mWzH2+R9J5Ys+eZ2gtkK69O0To1JfSt54RL3CMhserdcSJSOuYAeYJ
	N6XHM6C8UBHpkfcyy0hSeZpvAyXjvoNEo2Ekx3sWd5PSeFxOXcoUErGeMCedSzbkHh8aE4MlD3O
	3kKwbY7/YkvDHDZlpDWSfLrunUhySN
X-Gm-Gg: ASbGncsPJeZuPSXlZPh0xALzMLJ4Y9RoqSqh4UAvjv3jZeS+6ZW35P/3SRVO2qprxeu
	EzIcgQMIiSpDEoi7/jJbXbcmoL2/CBKL1kdGdifhbLrkS5e1PIP5Te/pRcl6h
X-Received: by 2002:a05:690c:690e:b0:6f7:406e:48d with SMTP id 00721157ae682-6fb1f29bcfdmr76979527b3.35.1739458038734;
        Thu, 13 Feb 2025 06:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEeHYNZFDgV2vgtp07+EXLG6diJ0WLxws7MaPqF2P91HH13rbU2aou20GjoSl6bzof2WHxUqurRf5pGgUAIn4=
X-Received: by 2002:a05:690c:690e:b0:6f7:406e:48d with SMTP id
 00721157ae682-6fb1f29bcfdmr76979187b3.35.1739458038365; Thu, 13 Feb 2025
 06:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gr5rqfwb4qgc23dadpfwe74jvsq37udpeqwhpokhnvvin6biv2@6v5npbxf6kbn>
 <CGME20250213012722epcas5p23e1c903b7ef0711441514c5efb635ee8@epcas5p2.samsung.com>
 <20250213012805.2379064-1-junnan01.wu@samsung.com> <4n2lobgp2wb7v5vywbkuxwyd5cxldd2g4lxb6ox3qomphra2gd@zhrnboczbrbw>
In-Reply-To: <4n2lobgp2wb7v5vywbkuxwyd5cxldd2g4lxb6ox3qomphra2gd@zhrnboczbrbw>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 13 Feb 2025 15:47:07 +0100
X-Gm-Features: AWEUYZk5_r-tBhZvoaLYlDqhO9_sUVYkjzi-JYbjI9o8ZFZY67uC4S7eLbX9jnQ
Message-ID: <CAGxU2F7PKH34N7Jd5d=STCAybJi-DDTB-XGiXSAS9BBvGVN4GA@mail.gmail.com>
Subject: Re: [Patch net 1/2] vsock/virtio: initialize rx_buf_nr and
 rx_buf_max_nr when resuming
To: Junnan Wu <junnan01.wu@samsung.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com, 
	stefanha@redhat.com, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, ying01.gao@samsung.com, ying123.xu@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 10:25, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, Feb 13, 2025 at 09:28:05AM +0800, Junnan Wu wrote:
> >>You need to update the title now that you're moving also queued_replies.
> >>
> >
> >Well, I will update the title in V3 version.
> >
> >>On Tue, Feb 11, 2025 at 03:19:21PM +0800, Junnan Wu wrote:
> >>>When executing suspend to ram twice in a row,
> >>>the `rx_buf_nr` and `rx_buf_max_nr` increase to three times vq->num_free.
> >>>Then after virtqueue_get_buf and `rx_buf_nr` decreased
> >>>in function virtio_transport_rx_work,
> >>>the condition to fill rx buffer
> >>>(rx_buf_nr < rx_buf_max_nr / 2) will never be met.
> >>>
> >>>It is because that `rx_buf_nr` and `rx_buf_max_nr`
> >>>are initialized only in virtio_vsock_probe(),
> >>>but they should be reset whenever virtqueues are recreated,
> >>>like after a suspend/resume.
> >>>
> >>>Move the `rx_buf_nr` and `rx_buf_max_nr` initialization in
> >>>virtio_vsock_vqs_init(), so we are sure that they are properly
> >>>initialized, every time we initialize the virtqueues, either when we
> >>>load the driver or after a suspend/resume.
> >>>At the same time, also move `queued_replies`.
> >>
> >>Why?
> >>
> >>As I mentioned the commit description should explain why the changes are
> >>being made for both reviewers and future references to this patch.
> >>
> >
> >After your kindly remind, I have double checked all locations where `queued_replies`
> >used, and we think for order to prevent erroneous atomic load operations
> >on the `queued_replies` in the virtio_transport_send_pkt_work() function
> >which may disrupt the scheduling of vsock->rx_work
> >when transmitting reply-required socket packets,
> >this atomic variable must undergo synchronized initialization
> >alongside the preceding two variables after a suspend/resume.
>
> Yes, that was my concern!
>
> >
> >If we reach agreement on it, I will add this description in V3 version.
>
> Yes, please, I just wanted to point out that we need to add an
> explanation in the commit description.
>
> And in the title, in this case though listing all the variables would
> get too long, so you can do something like that:
>
>      vsock/virtio: fix variables initialization during resuming

I forgot to mention that IMHO it's better to split this series.
This first patch (this one) seems ready, without controversy, and it's
a real fix, so for me v3 should be a version ready to be merged.

While the other patch is more controversial and especially not a fix
but more of a new feature, so I don't think it makes sense to continue
to have these two patches in a single series.

Thanks,
Stefano


