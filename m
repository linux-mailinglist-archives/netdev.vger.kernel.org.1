Return-Path: <netdev+bounces-246646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F77CCEFD51
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74A2302A38D
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3542F60B2;
	Sat,  3 Jan 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnVwzN1J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nQv5l98g"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED20238D52
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767431599; cv=none; b=tTG6/rGOmBhuL4gMeXON8MsVVZN/+jFINyLT6FXFusjw6j5qhqy/lbdx1MiiWCIBzYtBYZLtugeWXBIQjsi1An/hG+nIBUNMQrrRrQt6MIIBd0mIgoxcRoNoVSECl4gI6QPiC7qHS7EIitoSSGOy20nDH1BJqBmG0mME+hNFRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767431599; c=relaxed/simple;
	bh=D2JUwaLgQPVcFVxnKAJxg4vCYvDrhyAGsjt3mPC1zq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqOU1Jiarxk1/+fzDNPNv9KjzlqIUMhyNB8vPwiG9cp8rksnZxRp7WXZkOfaDOyN2Uf9I19rCGzJWTK/rJzbc87zA8dAn2FmX5IIQvlGjJOKtnTWZ9da0B/CR9QInXtJgLhqYX/nXrfSImVXcZ/MJtrSZ248P5I/6ofzQQlnnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnVwzN1J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nQv5l98g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767431597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
	b=NnVwzN1JaJvhrffA7KmOD4YD9v3x3mERQ4f9zMkGxx0O+gcr/hN2bOaLqKmsYj9h8WlnID
	SGHxJPKJL3PljNm/0jF1aLJ4+lba0jz0Wh+YKGqy0lafiTTnSK+DTQtb5D9cBB6w8bsQrl
	UOctnKrn8NPuSvu1fK0UYlEarEJTty0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-8bDbwRyQPmSrtevEwOkqxA-1; Sat, 03 Jan 2026 04:13:15 -0500
X-MC-Unique: 8bDbwRyQPmSrtevEwOkqxA-1
X-Mimecast-MFC-AGG-ID: 8bDbwRyQPmSrtevEwOkqxA_1767431594
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-432a9ef3d86so284526f8f.2
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 01:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767431594; x=1768036394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
        b=nQv5l98gQ+cgHNo7yX4C326Q7WkrMYQ1j68rqYQVQkUHlhU0x1uSd7E7EJ4DMxmkGY
         X3WkX/VuETV2g6+DzlVFLtqdSkXTGqhmeyW7j6ej2axyu9upsywoNAOWyq1CNWOtZBRy
         KJHaSVXHd5gSJK+rAaOfcMAyOXabRpvOpw1RyCygJ5nzbGVBpnUTOAQO8XvCr9jWlUIw
         uKCw4VS56743CdVhhudSOM82CcolYJuwLKKhEWTgp9dNwQ4nlX4M5U9QCVmpVJ34Ag7+
         kepOfXvcl+9zWijc0dprS+7/DARBNvlOQI7x/xaHqbkw8AeFVmQJURNWNYPBcd6uU/Mk
         /tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767431594; x=1768036394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hb8jN/L6fYCR7fWSSvv5cBYqP1P00Le5VoBUo+rlAg=;
        b=hMPkQLJAqTT7T1RlikWVD75NNW1vyBdrzb3YMm7tEDTb65yOkUX5rEPEwbVpnLuSrz
         +HzIq3gGdfeMYa9H2sWE93P43WeA+e5Qq1eFrTrxaDT6GAhSO/qIjx3ox/JnSqQwxN4p
         P7QvPujfowJc3wI9BW9JA1sZm+IJnPDD9gS8zABpKSZlcvGakYFViohrBDSVlbke9f9K
         OClc2Y/2wFMIqScgqcYm+oNbO3YSUONbmqmrllGLLfj0mqClYBMuSVlNsTqeF5TA2YAg
         fUsuDdevlnWPMhGR5pLqHS6fMgpaNN+pjlK5uV/3UnB07exIYCaUMqOgWg3QeRxoCeOg
         ZZjA==
X-Gm-Message-State: AOJu0YwIqOp5OAovfcRKL7MlUgt9CKNAbzqmIHS1lYgZ9706sntPHckq
	n92F0YXFC3jK/KHFsLnVHKny7mLuNibxx+Yss0xmP9ZtJQtHHn9XydR3kqHd5KibfWJTNA+8fEe
	A87fJ9f+qZMus5AJQKtkKMZM7P9zT2LmGux5zcZRNL3CaOYgzGyHcNtlm3A==
X-Gm-Gg: AY/fxX4Z+2CCHn8JX41HlxCg2Lg8/JPsUFW76gloCMUvKHh5f6nPfhw8RQd9fgZb5u+
	CsQo0v5rg6JsAT1iREWdPYHTi6LuOTiZK6nND4mpdl46RUCJAatFnFq7AR6oMp9H2l4r4WjCkog
	b2BhpnYwoyJf5C3PsgtH50WOAjfvOWFUwH59s1WVSnDoylq+FpiU7fCJB4oezTtQ45nWP/YL9B1
	XsmZBqdDyEIQNxEufmU/oyyz7j4e0gpeTvMfaRkwY6DfdGsDgb+5/n2M+uK6oCTtjkBIOknyuYt
	7FintjmSmQOdpA2mKD7Uw8v/H7XXS1gbSyyff3hqGoFeXUJrRS7Qt7w9+YLhmA93IZImAQik4Pu
	Bnnj+vg==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id ffacd0b85a97d-4324e4cb94dmr57084911f8f.19.1767431593693;
        Sat, 03 Jan 2026 01:13:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE26GgQLEflvynAD5o7MsvyW4N7h1D9HT11b4Oml4DoyBao3uW+BjntwVayJEJqPx+C7BOcZA==
X-Received: by 2002:a05:6000:40ce:b0:430:f2ee:b220 with SMTP id ffacd0b85a97d-4324e4cb94dmr57084882f8f.19.1767431593183;
        Sat, 03 Jan 2026 01:13:13 -0800 (PST)
Received: from redhat.com ([2a06:c701:73d7:4800:ba30:1c4a:380d:b509])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4325b6bfe88sm80644627f8f.19.2026.01.03.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 01:13:12 -0800 (PST)
Date: Sat, 3 Jan 2026 04:13:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] virtio-net: fix the deadlock when disabling
 rx NAPI
Message-ID: <20260103041213-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102152023.10773-1-minhquangbui99@gmail.com>

On Fri, Jan 02, 2026 at 10:20:20PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
> 
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
> 
> Due to the complexity of delayed refill worker, in this series, we remove
> it. When we fail to refill the receive buffer, we will retry in the next
> NAPI poll instead.
> - Patch 1: removes delayed refill worker schedule and retry refill in next
> NAPI
> - Patch 2, 3: removes and clean up unused delayed refill worker code
> 
> For testing, I've run the following tests with no issue so far
> - selftests/drivers/net/hw/xsk_reconfig.py which sets up the XDP zerocopy
> without providing any descriptors to the fill ring. As a result,
> try_fill_recv will always fail.
> - Send TCP packets from host to guest while guest is nearly OOM and some
> try_fill_recv calls fail.

Thanks, the patches look good to me.
Sent some nitpicking comments, with these addressed:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> Changes in v2:
> - Remove the delayed refill worker to simplify the logic instead of trying
> to fix it
> - Link to v1:
> https://lore.kernel.org/netdev/20251223152533.24364-1-minhquangbui99@gmail.com/
> 
> Link to the previous approach and discussion:
> https://lore.kernel.org/netdev/20251212152741.11656-1-minhquangbui99@gmail.com/
> 
> Thanks,
> Quang Minh.
> 
> Bui Quang Minh (3):
>   virtio-net: don't schedule delayed refill worker
>   virtio-net: remove unused delayed refill worker
>   virtio-net: clean up __virtnet_rx_pause/resume
> 
>  drivers/net/virtio_net.c | 171 +++++++++------------------------------
>  1 file changed, 40 insertions(+), 131 deletions(-)
> 
> -- 
> 2.43.0


