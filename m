Return-Path: <netdev+bounces-159284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A92A14F86
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0383A13AE
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 12:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2D1FF613;
	Fri, 17 Jan 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll12p8Jx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B171FF1D5
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737117912; cv=none; b=Taf4U6IAQu1pfX0rchQ7yGcmJLRT5lCAaxOaKk2ehhwpPF4JvkXSy/2CAyxOm4I1j24JOFujH8VmLoAG+V7ZmOM/sbMb78/rWKgz+3naAexTDeST2G48MJLFU/Rg9LwCOPLWTZ/YfL9g4WwdYuzfk+8C+9oKtJlXAbp05SjzyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737117912; c=relaxed/simple;
	bh=z5CesBDK1xBpr2Un/QnljJBmVidZTP3FaHlwwSl6zIg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tt3YpGHfSbkC0DLd2iw/zq7KCXeHdIdMj2fhLkcsAqBp0M16gk5r4qmsEasvcdKDcklxb+bOD80jxlf7dvQHgrdnccwJ660tIGm7+SVOt2sr4uB78xr1/oMum7EoznQp/h4tD8Cal3xJPZcufCVSB1DkBCumtqaT2M4HjBPYpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ll12p8Jx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737117909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z5CesBDK1xBpr2Un/QnljJBmVidZTP3FaHlwwSl6zIg=;
	b=Ll12p8JxU54xBO2PnqHSNAc+c1qirnqSMJlx8yDPOQ3V3YNlp1rDJrd1rwbCmEh5QKPylD
	qrtbvaGWD5IyMZ9J6pqbSp64R4z52ga/sc5sK6cbRVWp6sWs1JlPtYp3kgyuJmtNrJXRvn
	Bdwp+8eDAcSiuDgf1UT5CD1lKWAICLQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-BNUWGSkQNXqygcdRHE22aQ-1; Fri, 17 Jan 2025 07:45:08 -0500
X-MC-Unique: BNUWGSkQNXqygcdRHE22aQ-1
X-Mimecast-MFC-AGG-ID: BNUWGSkQNXqygcdRHE22aQ
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab2b300e5daso258888966b.1
        for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 04:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737117907; x=1737722707;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5CesBDK1xBpr2Un/QnljJBmVidZTP3FaHlwwSl6zIg=;
        b=TPveFIIvDf5cItCW1r/QL4ASrJmAQbs9te9mkTfFsiBVs6llxli9hLowP7sP9Lo6o5
         FHhHdCHBI9D/lvJyRC7ucDtx048+azrUiDyQ26EFPtqFEnmBqsmr9E34KiW5qMHhMQeb
         H/VqgJ3zXqPeWiSF0eKS0rqSpZFqJlA8z5jrw3zU2bWEgkeaPMPI1doJGKinFuInU9sc
         OxJtwESKtV8jZ/RAd8Dk0U4aHyqHk+3sVUhspL8/8FjlhKrsMk2kZKRrDMUQwyqmzgke
         afnfrU3jRLlSmd5jNjt4DL5hcXcm3IwgU8lnHOlZnq7PXFnCecvM92kTWp9dBr1lFDtv
         Pqpw==
X-Forwarded-Encrypted: i=1; AJvYcCXuPbxWclinC+aNnR5fahfnDPeonhs4xrYn9wJhwm/xP38tLwROwXAQmkXfuz6OfigDhyLi48k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIzuwNVvxcSlUp4DSOoZ2pbxszKq58J5uDXzEm6ZS0kI80xJN
	VnuHmg2izRLJib/ik7yEnZ/Uo5MaKqtIfW6TCSy2FvvQmLrE7kFNFExsWBulb8tDPuSYd/l/mB/
	Uir9lkweWBeBjdC9JjERnOTwLHFERCZ8Db5U6nMr9Ujeae1IFSnZd8w==
X-Gm-Gg: ASbGncuN8IjV+hXDmpZwx/LTRu31OdrYQ+rKNod5rGw4PouZ+eb5m6RfKmU68DsA3Tr
	gJzN2SL7LWmOMSA5hc7HacWtRBTm8jmj/RNGqIonxchXrew+xNxjj4Km71fTNqacbIEJr2eTynr
	4LHwWEck/c3xFd6NoyXmamDCVY0ZYF8ysKfOA5SyS3GFjLpKz/er6iMUWrr62M3ED/UpjcYUgZP
	3KpGBaTQeRQAkHBckjTs3CVJFXWBUXYG/i6uP7fzEoD/yMiO5kFhDeXy0hQI+TyqcBZPQf5GxGF
	WDHj5w==
X-Received: by 2002:a17:907:6d0e:b0:aa6:966d:3f93 with SMTP id a640c23a62f3a-ab38b112b07mr226450866b.23.1737117907405;
        Fri, 17 Jan 2025 04:45:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfFt2OocIDCeVCuphJzNl9Mw6EvXmqC8VOMNFVCg1AliOY0zzpd05VMHD+2EiGsW65Bih1uQ==
X-Received: by 2002:a17:907:6d0e:b0:aa6:966d:3f93 with SMTP id a640c23a62f3a-ab38b112b07mr226447466b.23.1737117906979;
        Fri, 17 Jan 2025 04:45:06 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f223f3sm164037166b.116.2025.01.17.04.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:45:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6986217E786D; Fri, 17 Jan 2025 13:45:05 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] bpf: cpumap: switch to GRO from
 netif_receive_skb_list()
In-Reply-To: <20250115151901.2063909-4-aleksander.lobakin@intel.com>
References: <20250115151901.2063909-1-aleksander.lobakin@intel.com>
 <20250115151901.2063909-4-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 17 Jan 2025 13:45:05 +0100
Message-ID: <87cyglobhq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> cpumap has its own BH context based on kthread. It has a sane batch
> size of 8 frames per one cycle.
> GRO can be used here on its own. Adjust cpumap calls to the upper stack
> to use GRO API instead of netif_receive_skb_list() which processes skbs
> by batches, but doesn't involve GRO layer at all.
> In plenty of tests, GRO performs better than listed receiving even
> given that it has to calculate full frame checksums on the CPU.
> As GRO passes the skbs to the upper stack in the batches of
> @gro_normal_batch, i.e. 8 by default, and skb->dev points to the
> device where the frame comes from, it is enough to disable GRO
> netdev feature on it to completely restore the original behaviour:
> untouched frames will be being bulked and passed to the upper stack
> by 8, as it was with netif_receive_skb_list().
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


