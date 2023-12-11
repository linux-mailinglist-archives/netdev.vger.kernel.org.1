Return-Path: <netdev+bounces-55982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C11480D22A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA951C210A6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070CFFC07;
	Mon, 11 Dec 2023 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyNgZNRv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761C0C2
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bzIkbZpiRzJdrc6a6vDeJqlwsyKzW2Z5OW2xriwEAsQ=;
	b=AyNgZNRvPlI14B00qgmh+59nrePQvvFxvgLqjwEsIEET96ob3FqhrlFZqBtbXBvxtAuquN
	ffiyyICbk0gSwDqBksSS21yBeRdW2nQsufam+bSoIik2L/r3WJtYlwHeOhpcPDdKQb6H5Z
	+dmb1F4r63FEx/X5ovOPo8QSWLjTBXw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-zU82tsiOMqWrw52sO3eoUA-1; Mon, 11 Dec 2023 11:38:51 -0500
X-MC-Unique: zU82tsiOMqWrw52sO3eoUA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332ee20a3f0so4092342f8f.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 08:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312425; x=1702917225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzIkbZpiRzJdrc6a6vDeJqlwsyKzW2Z5OW2xriwEAsQ=;
        b=GfSdxXJCmxEM6pu5J9w10KSWPqluV3xoIfQkHit3H9fwo8mofWR6ld18AUoIFpNnCb
         SGzPhKTQQY+1ahzAhL5ZJkhw0W8smhieKXuKaZjzqwAn6AtRZOvODs0VoX69AA1wW+Ku
         PwEheZ6Pm3t1nNihm3MADCtKAyLZeqxFlGtkNBqES1FOn/frpOXeSCR6cSGwM0ECSmG3
         UKvEbhoA6h0PvV03b0gN0UZL/wX/abvXA8peBWb84PxbBrX/CJc/tKxA7fPxJRYKw+vP
         DlStwMX+velxHuW8r5noQvhh1Ho9zV6ocxIc/qnbzScYPab3PwFNqOKFNz0VB/9/ErZe
         tXCw==
X-Gm-Message-State: AOJu0YwmCrruVKdZn6/TWzB9PdR++V5kb6fMHcGYWUcOw1cSv29wDW8T
	zTOvn3JyJ+920xBul2LsIxnmnmCCsCeLvRjLXk/jitbFzCW0siHVIQhPN6F2k2DwoCC4mK/AJul
	USmgOFguCyCaSkUnlcPV2PazO
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr1172684wmr.281.1702312424877;
        Mon, 11 Dec 2023 08:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVGkZ4+oYYezirnB3Q25N7aHGvQW9MmXB7XVlCjjG2JGiHt8ONICyX4hMLT/PJy3biQX9FqQ==
X-Received: by 2002:a05:600c:501e:b0:40c:25c7:b340 with SMTP id n30-20020a05600c501e00b0040c25c7b340mr1172674wmr.281.1702312424427;
        Mon, 11 Dec 2023 08:33:44 -0800 (PST)
Received: from sgarzare-redhat ([95.131.45.143])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b00405c7591b09sm13524344wmo.35.2023.12.11.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:33:43 -0800 (PST)
Date: Mon, 11 Dec 2023 17:33:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nikolay Kuratov <kniv@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vsock/virtio: Fix unsigned integer wrap around in
 virtio_transport_has_space()
Message-ID: <nuyxku7erp67jjs2uw4kpufwxcgdrevl2lqys5fyltzgz6ikgk@3db26gkjghjw>
References: <t6mnn7lyusvwt4knlxkgaajphhs6es5xr6hr7iixtwrfcljw67@foceocwkayk2>
 <20231211162317.4116625-1-kniv@yandex-team.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231211162317.4116625-1-kniv@yandex-team.ru>

On Mon, Dec 11, 2023 at 07:23:17PM +0300, Nikolay Kuratov wrote:
>We need to do signed arithmetic if we expect condition
>`if (bytes < 0)` to be possible
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
>---
>
>V1 -> V2: Added Fixes section

Please, next time carry also R-b tags.

>
> net/vmw_vsock/virtio_transport_common.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index c8e162c9d1df..6df246b53260 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -843,7 +843,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>
>


