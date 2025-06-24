Return-Path: <netdev+bounces-200565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB27AE61B9
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0581B61C65
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5086E280014;
	Tue, 24 Jun 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsB0vqQm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4827F4F5
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759379; cv=none; b=XWzYXONcuQcc6yds7UBRfNArzO4l6FtQAS/+WHg+plV4YcS6Yc3ist0gowEdq+lsMD1tkrMde7i2+JiMNqQomk31eUHQACUiRXAK6kzw8eAXLgXWPl7xFkOtaDF6JnAI7I3xNbUOHBW+HFk3dqvhr6eawDT3YP2kwS3KD/sd+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759379; c=relaxed/simple;
	bh=iOw/L11BDQrjLHtuit0xpOKB235eAAjDVcmGUBFHfS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaY04NJ5wGw4sw+0hI8z/JcC79emi+U91NLSy4EPffYeywRnTCCbdzqiH9WhCvwRCnO7oxznzfQEP83g0L5VPufEvym1pdBLVwwHK5tiI//ZvRX+oXyzn17iXsAcnOqQ98ntmgAAV6PhJ62KFZWOmPYPpZsnykV2JhlmcHi2jOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OsB0vqQm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750759375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRBtRqPAyg+QV0d52jJWOCZGpVdQ0NwXgV55dkzF008=;
	b=OsB0vqQmXHfkDIo6LnilsqnFDSha7Whx7VXcihd7ybDowKer3J20mY8+NHELhfAO8mUIDw
	YNkVk3+Y2LPDs2lsLqju1cPjVZMvK7GYdJfSshshqMZh1nm4rHgj+B2/f85M7gklmcZR1+
	I0p5iQUQQCat1gmFX2ssDsw/kT4pnV0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-HdPBYg7ePnigiCxJnQb-HQ-1; Tue, 24 Jun 2025 06:02:52 -0400
X-MC-Unique: HdPBYg7ePnigiCxJnQb-HQ-1
X-Mimecast-MFC-AGG-ID: HdPBYg7ePnigiCxJnQb-HQ_1750759372
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so1685015e9.3
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 03:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750759371; x=1751364171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRBtRqPAyg+QV0d52jJWOCZGpVdQ0NwXgV55dkzF008=;
        b=v6jPWSsplEB3fb8jYoRYmDMSq5P3xxePAsFy+QId87Y+vz2H8pAP8AaxBokZmpLrby
         /jEVEGvFXSGP4uUos0dOkR/paRUYk0nKRR3UT/mRfYJb5wr7G1xtpSZ3j7r3Dc7w9OyK
         2rrcmdCJgpime3DbCXA2PsvhYNkM4Op00JMdrovua4r/i0HVzFdF6dkc99oQjzbwPpsL
         hWEsgnoP7MlJlEcOI1p5Ix3FQXKM8V4Qp6AaECAHFNDhJFrXkEzkln5RV/LNbpohmO8f
         jox22iWSPtMmy403bCMOvVLiX/GbGx3SAGO1/jk86tIGxD89j8Ox5uB3TtDabVaHeJ2u
         9gYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHRFwjSRTPCUbaHEm/CG0r5ZXrVRG6k2EqbdtAEPvibt7O0yavSDjbRNhcUr8Fb5q/fsewmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7pRQ1CIpSfaKdfRnwbieJsXLuzc7e2tV5YrHIv+Ta0VLjP3A
	E/MwwqjiUzL23k6NXmpyWoNveQazW4hmPRha4l7AtOu3HzNe/ZiPg0xDzEzwSFW5sn5O9kfdqEe
	AQsrHmHrkac9gBG22My5H+D2/VAsOUUFgzVHEZGNpU0vfbB4qVtlLGrjzMA==
X-Gm-Gg: ASbGncs3oiIO733x4B86pzYD29UcH44tCIdFpeMskq1vvrXCC0avGOh2Jye5YTrzWlv
	iWLr9/jSW6qjKpjb96J+t8ZU25vAvnBqurh9ro62GgzpbJpp9R0fQRQLHKkMreGIE4oH/ZyfUSF
	+qjPIzUhKd4PBetItNt0WvRcou15MWuzgLUdHGjytKqi18nMDosar4jzt7EAjPRR7aKPFUnKzYK
	xvvIPeZhPjMqv3rIULWKRPu3Z07S++dstY0t+6rvusWX2qoApM4ZCn0uahBJJLuM4sOdIiN8OSc
	9lQEeTDnJX75xw9/rFFr//b73XLIew==
X-Received: by 2002:a05:600c:1d95:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-453659c9cd3mr127322975e9.11.1750759371552;
        Tue, 24 Jun 2025 03:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4nOxjPFsJ1eZqeyQQfzna9JUiKLhgP6SNKYrgYsBIKI61asj0UadPwdpCO34yq47DYpw21w==
X-Received: by 2002:a05:600c:1d95:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-453659c9cd3mr127322615e9.11.1750759371097;
        Tue, 24 Jun 2025 03:02:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead202asm170467905e9.27.2025.06.24.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:02:50 -0700 (PDT)
Message-ID: <5fb3c0e4-759c-4f56-8a78-e599c891f618@redhat.com>
Date: Tue, 24 Jun 2025 12:02:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length
 check
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-2-minhquangbui99@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621144952.32469-2-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 4:49 PM, Bui Quang Minh wrote:
> When calling buf_to_xdp, the len argument is the frame data's length
> without virtio header's length (vi->hdr_len). We check that len with
> 
> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
> 
> to ensure the provided len does not larger than the allocated chunk
> size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
> we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
> to start placing data from
> 
> 	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
> not
> 	hard_start + XDP_PACKET_HEADROOM
> 
> But the first buffer has virtio_header, so the maximum frame's length in
> the first buffer can only be
> 
> 	xsk_pool_get_rx_frame_size()
> not
> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
> 
> like in the current check.
> 
> This commit adds an additional argument to buf_to_xdp differentiate
> between the first buffer and other ones to correctly calculate the maximum
> frame's length.
> 
> Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")

It looks like the checks in the blamed commit above are correct and the
bug has been added with commit 99c861b44eb1f ("virtio_net: xsk: rx:
support recv merge mode")???

/P


