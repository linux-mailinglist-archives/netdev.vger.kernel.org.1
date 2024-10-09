Return-Path: <netdev+bounces-133508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C37A99622F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD41F21D53
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8165188A18;
	Wed,  9 Oct 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxpUjIhD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43770188733
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461703; cv=none; b=dAM7G7kpj3sy2szwAcMugucHp423NszQ/WgMqKU5gox1ibByh9XD5gaZTvES9Fvz6SpBe+6i46tIdwPBALOLvZhjVru1i7hPHtkp/jTXQ8IgQI1at261vt0kfDkbrd7gT7EpWCnidgFBpvj2ZPEJc+tqipSsSfwa0F+krMzhzI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461703; c=relaxed/simple;
	bh=AXLP2KyrAqjaejcHnTbI8HMVGaKN1T0qdKQjIwPuqBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jezyl5Paow6nwFi2bF/tUaxMC31wEtH9RNp82UwJ9S/IukSzDS5R8c5MqzdEaJCPgKa1sO5V8iYjPMTrb2WOnlKoFl/1S5BvfYK8phY5mo60MWVDuweU3Z9pSFhy451gIk44DFEwDcSUSEe5EFRvgwjeQ5lXYrz6qo+u6Q5QzNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxpUjIhD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
	b=MxpUjIhDhUfisNAmQ3skP8ogg1R3B8QpiN9KDidyfWel/s7MsEcim2uTGkU4g4r1Ft3TsW
	zIGK+DEF5DBLeU6iikqYsy5sr68jlkysSHaG5EzVBWnP1c1jWB2QVVD1uzcDnMeS5ALRZi
	emkEpluhdtkzWUOcE4dHCc2jZkqa5YI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-wgy8G4L0PBeaQXL-2sgTkQ-1; Wed, 09 Oct 2024 03:45:22 -0400
X-MC-Unique: wgy8G4L0PBeaQXL-2sgTkQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e28d7928d8so1709257a91.3
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459912; x=1729064712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
        b=Cwp6uTrl7lIHJbkbDJv3FeBl3YRPjnOjaoQGqVijKTkuoi62MXgyNWoFiJTnGJQFki
         TjQnOX99BUszDjXNcwVktUMA6A3mZ+Im6ju9kt57e/POUDZr1+LQzvvonRPik7FWwPDb
         kj8QSjzpm9hyaRv/j4lHBdv7JRtHSD1DO0Jqt9jb804is3BYzHzMPYIfy2GW14ryZn+c
         Mn0BmhTuek+cAraHUN5+DvCEuTVnr9HShZooI8EWGqQELGnCgdYNODgb01DPM0m2/L56
         19ywFti2OVPPcZUINBTpOlQA6AmDuDx1l5PV76m2HWk0zMzA91BRbY2hL5sPj8G5zo9i
         92ng==
X-Forwarded-Encrypted: i=1; AJvYcCX2OGO+rW5RF/g60ziwpKidM5HJhA6gzRUOJFVu1nfGm7VWecVxaDBkFv0gTn0BVr2PTo4wwhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+4TwB6+bu6sg9fiKGJMu9N3bOe7/w/TyBgWIC8BELOIOG90a
	88Ms4iyR3qZJPis1k9qAVF3ZpvygF01qfn3PiZWJ3rPCjRKU+fgnncj2+1xMS/7Lq21mE9s2XOp
	eXw3/1e5zzkK3gL2Fav62eJOg+uN1n6+CbhAxkmq467RhK7hcQJR1WGi8eK65DJPKs/fEvFfaAo
	2pEaU0fsLLE+X5WApIYq1es/g3qwtS
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id 98e67ed59e1d1-2e2a2587e6cmr1772577a91.40.1728459911719;
        Wed, 09 Oct 2024 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXS3Vu8tqbV1XHkGBTCNaL2VDRz7beWlworvX+yKRqbV5bgZG5ofneJzBijB1Dsili4oRB7g3ygL6aKFSPxI=
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id
 98e67ed59e1d1-2e2a2587e6cmr1771623a91.40.1728459881543; Wed, 09 Oct 2024
 00:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com> <20241008-rss-v5-5-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-5-f3cf68df005d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:44:30 +0800
Message-ID: <CACGkMEt054F1AZP7V0ocbUce_AvQV_Cw-K21y7Ky1gWa=eSpCA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 05/10] tun: Pad virtio header with zero
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.
>
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

This sounds like an independent fix that is worth going to -net first.

Thanks

> ---
>  drivers/net/tun_vnet.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 7c7f3f6d85e9..c40bde0fdf8c 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -138,7 +138,8 @@ static inline int tun_vnet_hdr_put(int sz, struct iov=
_iter *iter,
>         if (copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*hdr))
>                 return -EFAULT;
>
> -       iov_iter_advance(iter, sz - sizeof(*hdr));
> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +               return -EFAULT;
>
>         return 0;
>  }
>
> --
> 2.46.2
>


