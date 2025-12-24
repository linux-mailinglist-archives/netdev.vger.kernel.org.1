Return-Path: <netdev+bounces-245936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C4ACDB1C4
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 02:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69A030204B8
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB925A2C9;
	Wed, 24 Dec 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2MY99Sz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOyPIJtj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AF18A6CF
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540880; cv=none; b=H0jnHUiPYw/aIKdBvrHKZy9aKsVWlIVulxszmpMLr5S2TVdUyw6IGroUtS4qDFTxW8O7lbt9RyQ1fCFR8rXkba6yjL1VXe1EOUbxQ9JQLfgnVnunqxou+N1ffZ+Qsj6Cx1MPYJ/JXV2AhPMKQll8Xz191FV8ZVRHY2CVP8SuAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540880; c=relaxed/simple;
	bh=rlBORRVqCuCCDKKTRMpReJJ+tKBroym5f9pOqNZrTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0hjIDkvH27gYhRVYGMmmpphErveakid41NMXD1VArT9x0jTURpvLukwi3iflxa39BQy8AsbfVajcrh4iQzBiwwkKb+nXD9xiEIc7MyGthNkKItRX4FWIgjaT+lJLbc4ciq5oyd97iXqu3Z/LgsyABjvdCfseI3kn+DAPbsGJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2MY99Sz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bOyPIJtj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
	b=D2MY99SzKCXazxcjf8a9zG2fq5bSLZ8veo5lQu3wUDfONcRp3uzL52glLairIlaI8ZAUMP
	QGUovddPw3XI329hjgZZeef6RbXQ9LviL0vvw9oXtB4zsX0rL5gFkQlTb0nMDMFo0jL1IX
	Lw6sxtx8FjUVj72QRVPvGqvmIc9PvoU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-FRumhjo6MgKgkk-jsYPEGg-1; Tue, 23 Dec 2025 20:47:56 -0500
X-MC-Unique: FRumhjo6MgKgkk-jsYPEGg-1
X-Mimecast-MFC-AGG-ID: FRumhjo6MgKgkk-jsYPEGg_1766540875
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f433419aso5341345f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766540875; x=1767145675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
        b=bOyPIJtjHQrXBSMYwqGZgR3N5yIKaTh+qSdhPNKF5FMgpymdc854lHm7HNoUY8Fni/
         dt79Yg/vt3DxoEfgCA/VHrubKzUL6Dv0VDfPvwZnPQF35W4DhyxxaC2xDT2/fkwzg9HL
         vH7+sIILWX6RvBQ9q6KHt2fWzZO8kGy6ueuderXEyjYVE6YGpZAdjnC+8wzt9mtgJryv
         JGax1cT/V0e/RGiezEz5oOqmS+GhrRzfH7cgnP06txF45spneLGkG2aFcnQYs0qxR0XD
         oNxJFBPjipMN0D7tor4vbvhyaUbI3z2gf8nfUuAy1ghAP8oCBHUj5GbCScTA+Pt6o76K
         rOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540875; x=1767145675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfLuOi85d1FraY7+0q787i/gVvs6BEvd92Xlu3j3K0Q=;
        b=Nh1f+vGqBddv5rqzim1mRkIuW7XwH9QqRsN1j5zcdrozQTzi0PAah45BnSZs3C4GIz
         38Pw2WJrBXirIytyckUFCi8Rc8VoZUzOrHuRxrbXbK3JLzt5f4KBTPAUt18GzyF7jEgq
         HyeKEvY4efyBQpjNGfJafljzg2iRtFO7SVLVxZ3Ethh8U/uwv3YYTnLiUYQpmjTc4fAh
         niEq7/uM+8fvM+ndwgUxkRzAYU3FG1KGvv31QK4aUle08UDB4e7epSPlaHDD4XvysC81
         /4FPs805PID7htkjuviWsTE8YBVU6VVgqsFKlpu5jLzCJc/qmK5cAPtd0MgOEPfB61MY
         ph5w==
X-Forwarded-Encrypted: i=1; AJvYcCWCE0ohK2euvUACf9u26t29x0q+YddVUmfb3GS2offEI7g+xRLvrdBwK9hxwrcHXKj2SU051/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIx2QR8+nmIY67YdVHiESP2dxFRwv1AWOaN/1y5jQZXN3CZUUZ
	HKtWOEW2Lzh3TeXNdW6FXZjMyjF4LAzGyDYAUc33KO63PM8FSVBFcW6PgRlLpdWU1HJSjy324qQ
	dJBj1HNBdcRMEehUA0QA0Vrc28B5Uw2Gxz89P1uz/NcJ4Nr3kPhMOv7Cwow==
X-Gm-Gg: AY/fxX4Hb+/kXDMu7XjG+VoTYUZpCROKGX8Kkmd3QgH4s1IYvXWMCynaOtWH9hpCI3a
	aeQICjNLjWAiAr+CcwNX+7nIU4wwGGPn6MoPiXQFfbKTIIfmK4foLMXR1KTTuBuhbqRGcXKInT/
	iKcQty+17CTSSSIrmVOj5H4d89ELCJF7GxSNjJly5znzchCFUdv1gptP27bWfzIcLr6m3GIVad8
	y0E9yGkB2I3JMq2KH7fBywODAqoTq/YyT8JIaWQvtRiSDAfnBIf3h+CchieEV5Rykdp5rKxQysl
	Oif/mFZivpT2wD/wyFPjg/+QIYTo4pf7xYSl/tz4sf2vD/MIIEOcoxRfK2a0roSaXhMcI82Yq7h
	s
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id ffacd0b85a97d-4324e4c3e13mr17469858f8f.5.1766540875203;
        Tue, 23 Dec 2025 17:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxAidHJN/0HxTdnoimsgwBvjgcKtPCXXltUV2xjreKTHHI6FxPbiJNRx2xvom7ebYh/UDBIw==
X-Received: by 2002:a05:6000:26c3:b0:42f:b581:c69a with SMTP id ffacd0b85a97d-4324e4c3e13mr17469842f8f.5.1766540874789;
        Tue, 23 Dec 2025 17:47:54 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea8311fsm31060662f8f.28.2025.12.23.17.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:47:54 -0800 (PST)
Date: Tue, 23 Dec 2025 20:47:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
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
	bpf@vger.kernel.org, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251223204555-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>

On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> 
> Hi Jason,
> 
> I'm wondering why we even need this refill work. Why not simply let NAPI retry
> the refill on its next run if the refill fails? That would seem much simpler.
> This refill work complicates maintenance and often introduces a lot of
> concurrency issues and races.
> 
> Thanks.

refill work can refill from GFP_KERNEL, napi only from ATOMIC.

And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.

Not saying refill work is a great hack, but that is the reason for it.
-- 
MST


