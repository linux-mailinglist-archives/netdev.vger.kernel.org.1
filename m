Return-Path: <netdev+bounces-166603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E302A368F1
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C4F1725F7
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D601922DE;
	Fri, 14 Feb 2025 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKqYFPrD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACB191493
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574938; cv=none; b=bhShQUSpYXZU280PQvYBtpnxEvZJHcZ98uIGRZqpzyr68yVXKn6iWogzfwebGNC0w+WR0ViP9FewY1vBjOB+Z0fvXGKDOB11bhduCrOiEZxrizdKSddokITJNrSRj9MITVSIgbIiW0wfpm0zV388Yf0Pnt5iFvGbWHA+v1KC7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574938; c=relaxed/simple;
	bh=dCQEUPW3bF6z/PIA0W72z1Sx/yTML9yZcgJSLS94BvM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ChzKMkD5ePYfTVK3GZTFTNhuchBf3P2GDyuNKJObXZIwzzuRH5R8VJQqW+0kLjxIegRmfYZVOK4p48dpZtcgtwHo/t9kFbxoDqA0ejAXW3lsoEZFdtMsird2ECVjRPv+ItAq91es17JUMbrWJZZnOuI+aci0wLIwzv1DlFsd58M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKqYFPrD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c079026860so295699785a.3
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 15:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574936; x=1740179736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDZBVvqGC948KUxzy/pTYFzuUP94o3HP5o4MoUQdhUc=;
        b=cKqYFPrDz359c7Tx2yqFENX0GcBmrt/ct8IHGOpmGRsN/HbPV9tHYfZWdySf1vS9Fp
         WvVq7R9DuFjW2mELD7wwcEQ4GZUtTdB0gSuS/hsAGw12cSWq+h7Qj6NzZHZDBAenlpY7
         p4/enM/pRhrD8AEfLRRyiL9A+EG7wApsPYO1G/tg5gxy16vbXLSB890MdOt0qhEbdjIV
         Yw+gxNE6AdtRe+KhK/XmF1ymgBqHD1JWMCTe+QTAD00JRMxNYIBAodx9bfhiuu/E/q2A
         nw+9AlclmJs/qRKuHB8DbEhWdLW0VldC63lnllIdxD35wB4hvexLol+zHWpZ+/JgjRkj
         xzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574936; x=1740179736;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EDZBVvqGC948KUxzy/pTYFzuUP94o3HP5o4MoUQdhUc=;
        b=ZtgxWvIA86t1+kzysQMhGohCi17U1bOhN252aCxMm25R1MTLqoubvR7i+fIWKpDzgz
         yf2KH/lXyiX4TPGbVxdmYPADf7Zl0aqpLlGDPVALnQbGze/eNVrQCmqE0GfI3MqsE8og
         TPyakbAgPxiIQrRyPaD5aIXp2MA6oh9QZWLuYgHNQIw/kYUuIrhAqqaSsLeXabf8iPNj
         hM99GAqXXg1aQrMSiZx6fGeyfJRXI9bNruzYXTfs3JFC3iGAR0X4dLiUZxC3l40Nf4DV
         dQqbdtAZzU3CMBpnYrwqCb8FKPFyVi0O1/RpXOuNN39NXLWAm9veD9oSl2jbefkh5zzn
         JPLg==
X-Gm-Message-State: AOJu0YyhRiBuZOnl29rWF7skabRWr4Io+GETXtYQaCZFOvpDIJksqadD
	axZJJW8aBp8XvAN1xlgp5bNMePsfE9kEqRmZcaeD98p8qQeFCbWeGwLl8w==
X-Gm-Gg: ASbGnctG6wrJ/E5Dolz9s2Xfd4zdFDVYnjVYx1x2ATvDCP6Z8R3Pspx1MrZGCcWze0Y
	OBvoepNs1Y0jmE2sORJmoSMIH+/F/Xqs6qIktTRKvf7aFrWUl7S6Kov2ZAWlABizoZR/0Wsa2Uk
	WpzRqKAGw8LaNaMXNawABCcN9a5qbT22cYBIKH5IX6F6NvckCvWTow9fxLBFOxr237/rGgFtUEc
	UWJ8UKB+tCnzt6+iThULeqoVYkTOcZwktP2gtw6ShNx+24fUuD1bEXhT7NtoHh8m7tfv6qgcxKq
	o2+uZoyqX78g7lb3ni1TG18vBi1W37Ppl4jI5UuZ+7aP2sE8HwtvfanAI7v4nKg=
X-Google-Smtp-Source: AGHT+IEI8zCXo9RMN0pP596HD3wOGUnpo8abQD2TQ/c/zbmWiatis4SkmdgllciB+TcbpDEweezKsg==
X-Received: by 2002:a05:620a:1a8c:b0:7a9:c129:5da7 with SMTP id af79cd13be357-7c08a9db45amr187534985a.29.1739574935793;
        Fri, 14 Feb 2025 15:15:35 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c861221sm257569985a.85.2025.02.14.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:15:35 -0800 (PST)
Date: Fri, 14 Feb 2025 18:15:34 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemb@google.com, 
 ecree.xilinx@gmail.com, 
 neescoba@cisco.com
Message-ID: <67afce96ccece_312c64294fa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250214224601.2271201-1-kuba@kernel.org>
References: <20250214224601.2271201-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2] netdev: clarify GSO vs csum in qstats
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Could be just me, but I had to pause and double check that the Tx csum
> counter in qstat should include GSO'd packets. GSO pretty much implies
> csum

Unfortunately specifically to virtio_net, this sensible limitation was
not enforced from the start. Which is why virtio_net_hdr_to_skb has a
branch for !VIRTIO_NET_HDR_F_NEEDS_CSUM && gso_type. Mainly "used" by
syzkaller afaik.

With the addition of USO besides TSO that could also eschew L4 checksum
offload. But the local stack does not generate those (udp_send_skb),
nor does UDP GRO (first branch in udp_gro_receive_segment).

In any case, the new comment clearly mentions this limitation on L4
checksum.

> so one could possibly interpret the csum counter as pure csum offload.
> 
> But the counters are based on virtio:
> 
>   [tx_needs_csum]
>       The number of packets which require checksum calculation by the device.
> 
>   [rx_needs_csum]
>       The number of packets with VIRTIO_NET_HDR_F_NEEDS_CSUM.
> 
> and VIRTIO_NET_HDR_F_NEEDS_CSUM gets set on GSO packets virtio sends.
> 
> Clarify this in the spec to avoid any confusion.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> v2:
>  - remove the note that almost all GSO types need L4 csum
> v1: https://lore.kernel.org/20250213010457.1351376-1-kuba@kernel.org
> 
> CC: willemb@google.com
> CC: ecree.xilinx@gmail.com
> CC: neescoba@cisco.com
> ---
>  Documentation/netlink/specs/netdev.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 288923e965ae..48159eb116a4 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -457,6 +457,8 @@ name: netdev
>          name: tx-needs-csum
>          doc: |
>            Number of packets that required the device to calculate the checksum.
> +          This counter includes the number of GSO wire packets for which device
> +          calculated the L4 checksum.
>          type: uint
>        -
>          name: tx-hw-gso-packets
> -- 
> 2.48.1
> 



