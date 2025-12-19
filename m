Return-Path: <netdev+bounces-245494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59115CCF179
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE05301F27A
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72223C8C7;
	Fri, 19 Dec 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMdSkZuS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6UIyYfO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1613DBA0
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 09:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766135777; cv=none; b=INRT98fhkYMu8WPJESGZe98xI22jIe0AmE1z8Z2KT84/LyRv4d3HNR0Kx8Xda2vh2heoTxCVB4qXetFkpFp+imjIj3HUuVV92wGOkNnkyzCFzvraIZNXbRlSc35Da5zk1gQNCfMsFJwZx9g4i7IHYeTcm300XTkvFV7UDXQymM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766135777; c=relaxed/simple;
	bh=MWbV7qEUCTgmib8jE99GEjEb6CVbTgiplGai9AtGafU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fiirddRYkP9HGO+hgRURGzgCmItJOuTEq9S4l7FewfozS8iKjCXC+6+oHqgde+v935YQ5FVyuC7gpYgyi/qtTrpHdXL09cP3fx49QO+4Ixl/nw9AxaJ2hf8qF+yenKAaIdWA0lRwp3+AS53c7LfU9uOHi3oyE/bjPcVnpc1MhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WMdSkZuS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6UIyYfO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766135775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+CwBSQLsOIgUTuETTK8GeMWA5n532bo/mkStF4lf1M=;
	b=WMdSkZuSkFyVjbx4/Z/rQgGBnfC7LSkIaXE9R0NgrB2exuEWE67NYXZ9L+ZHNr5UzvP9+9
	i0Tsnb0o9+8Myw/Ji1rOk5sSOD3LbTK1sSMqAGscYQqZSLX8k6GaPCj4d0EURNVJiQ8HyF
	QzhufK4VJ74XYouQseqBa0TpACJTag8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-RGBo3e9mM4mt_eOUqae-sQ-1; Fri, 19 Dec 2025 04:16:14 -0500
X-MC-Unique: RGBo3e9mM4mt_eOUqae-sQ-1
X-Mimecast-MFC-AGG-ID: RGBo3e9mM4mt_eOUqae-sQ_1766135773
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso18635225e9.2
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 01:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766135773; x=1766740573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H+CwBSQLsOIgUTuETTK8GeMWA5n532bo/mkStF4lf1M=;
        b=A6UIyYfOBXw9osr9D3GPpRi0sYcRSNQsE4hSnMoNFwRZIYgTkeFja3PicH/dAN649m
         fi8F74x+HioSO1FpqS12+FaBRi6BfzSe/jKYccRDJboCfrCp80amO5FZqOnlbxB8pilq
         y7E17836UVM5n1hEAkKmjvCSeJai+3KkSsgh8jHlARcZWCdkvErZ7y7Dp+iH6yvLmm1p
         trC18FJyAHCw+opAVcGYNH7IatAk4h2kBddfKpvMK4574y9B1SxwUkidEUswiVOBSPkE
         5d7C6rpRuoGQWrEKBv3IKoPkxXCqBDBO/Mfh4HsMjmevFM0WZ6YMW/rnkw4BciF4stv6
         A2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766135773; x=1766740573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+CwBSQLsOIgUTuETTK8GeMWA5n532bo/mkStF4lf1M=;
        b=kVDhAvRr3g68BuiBHeKQOSxwIHjZ5bPw7TdsY1WglXt/bMRkodySnQHCMSXI+TPtj+
         b3q6YE0cfKKHYGEaOr+xdNZvz3ipDRTrOVnntIjlTa0921mjbNQRgE8rOosLf1Afj3aB
         QTgWIZrAz+LXoeot7ht/TtJN/Lf0RvXKE5sSbXK1IKryJr1uGGe2M3xWj/cc8FGg7gvY
         VlZAEJMbDnQxg/o7GpLK0n5T2d0qTQtmNIfpblYsXpy6I1xpyto617MjYCYrXf3Ex65x
         y/YBmmmdaN72IhfWIj1b7HquiriVNQtJFjot3zz79F5fN2MBstOlYXyI6SWf/o0cM6h4
         ltmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3BteyB3vjut8eAaztCvAJipkpht+Bn5msRJ11o0gqPXN48bnu8ysrVA/W7INVaUaJ8wM1CY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6GJSWYqxQ8U2ThasOWQBs9Tj1NKccr+sivspfBX7m34Wh1wjv
	0UH8sdEnBEvJ0IQU4TKgXeeKvBXDWtI2Sdd+eOogxMIU1y7CPoCbVXOg+LgYoPPAg5dOBGLRERz
	IPsJRtO0yThMoBMJWP3Yf5hcX7+msN1BNGT1ZEQHwy0SAuSDv4qXc5ciO0Q==
X-Gm-Gg: AY/fxX6vMEElYrOsur/XV7RvXPCfRc3EfI+3N0i8uYeLuJAxrKKqtCJKkTloKdABDKT
	/hkS+sg0Cwbif5cTYobmBZkbYvShKQQ2SQxWFhTKImq0Si/FBpDxpdWog5w6zTTtbOy7hrml1IG
	+Z/vg4w6Ngd8p5NXqXw/DY84apk4eBuQeAp6LFvXs9M7jsorDJbjjvIfbFfkGmrpoe7YEp25C3D
	2tLFgmIiDihwW2LRxcR95OVnoA4LsfrIeN+ENHs4PMiNL1FPFf6VmUr9eA4r0pRK7z8YKdjn11f
	1GHBtPA/hCYQ9S7mhm7+0D+gfN9AWBreQnzQsDzr6H/86KHBYeceCruFeBr01nCdBlESx2CCrz3
	EVM1+YT8/o7m+
X-Received: by 2002:a05:600c:6489:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-47d1956f5c2mr17338075e9.15.1766135772716;
        Fri, 19 Dec 2025 01:16:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAdA450gaUCDr0G+EvYVvSKbzqSEhTogCX9lnbsYN2wuuFQSH6bWtzij5ZtAv0XjgCB05Bhw==
X-Received: by 2002:a05:600c:6489:b0:46e:7e22:ff6a with SMTP id 5b1f17b1804b1-47d1956f5c2mr17337775e9.15.1766135772355;
        Fri, 19 Dec 2025 01:16:12 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2723d19sm97243985e9.2.2025.12.19.01.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 01:16:11 -0800 (PST)
Message-ID: <9780d422-89e9-44d2-80b2-790328abc429@redhat.com>
Date: Fri, 19 Dec 2025 10:16:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Octeontx2-af: use bitmap_empty() where appropriate
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>,
 hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251216004742.337016-1-yury.norov@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251216004742.337016-1-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/25 1:47 AM, Yury Norov (NVIDIA) wrote:
> bitmap_empty() is more verbose and efficient, as it stops traversing
> bitmap as soon as the 1st set bit found.
> 
> Switch the driver from bitmap_weight() to bitmap_empty() where
> appropriate.
> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.



