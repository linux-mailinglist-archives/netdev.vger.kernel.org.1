Return-Path: <netdev+bounces-137820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AACF9A9F1A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062F3284373
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3619580A;
	Tue, 22 Oct 2024 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRvqEIv6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2ED155330
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590503; cv=none; b=N6Ja5P4wnjvk6fi9n/q7h24wM3JcP87YkaTpM4swV4DatVZHygzNd6shNACVbqyQmVr0PUH+4BClquJ+eaEnHuX4usabip0TqJ6Ilmk8QPF5Vm5FWRFNw/joCMxPhuKVD0KZU537VHQBnjtaqtcw5cvmk9pW5GUyeDHiDYbA8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590503; c=relaxed/simple;
	bh=ZRqmtFtpN6pL6xPgI7LsATitWXUIUBemhFkGzlCmPt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0x38shtLeQXniZ/aKPaaIiArusUwaGy0VEfCrRaAsRQYTSe9WmxNoslGAza9Qs76aYw8PSAbOH9vPhuGRE18UzNPNreq57S/8nRHUisuQ4fEkEAHLNJ9viw0RMbpjwVd196PrcwotdnrvXhBa7L4vEynb867QpJt3zpFOaUOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dRvqEIv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XD9BsKkXKs/DyY017aAgEepYSP6HuYEsFB0I6eYqQg4=;
	b=dRvqEIv6V7osPJaUA4VDGU6iqrLh/9+wGHc907vmGv/2cvf88+IW7S8YGKQ1WPLMrHDQzG
	Y7L/rM955jBRy2O5FmZ7D9behoyZeDQXGgS1DcmuCLTxp70J4MVaA6zmobwzIcT75inrEr
	fw6q7hDaLzHwPTkeTjBZwC2pBuqAKWI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-No4CSRKOMRqUirXgIbOfPg-1; Tue, 22 Oct 2024 05:48:19 -0400
X-MC-Unique: No4CSRKOMRqUirXgIbOfPg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso44226185e9.3
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590498; x=1730195298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD9BsKkXKs/DyY017aAgEepYSP6HuYEsFB0I6eYqQg4=;
        b=suCr4G08tSLR719POOMdmyoaLyg+IM+EZ86f4Af8Ir/PDlBukuAcyZezASaVAubw0e
         +1OV7YMppoct8qDKCb1Hogt82eAC20buB6ovcI09noRQW6SGglnxn0T9ARNI67f+C/9d
         2TyDgF7t7qNS73dF+XI8beEqDZqmjm/pHTtL2oI81BmL6vsP3Xh6e5Bp9xzDYorZvnPk
         9HTwEEksvC9rw1WiQhfAJQ1ebGGVT+EV7McqD381AM3Iu9s0dBzx0+6kCzyVjEmaqMQu
         rRljhpPNbywlpMhXoSGEQjpevhkJZ/PJypFPbG3XNqAKqkL4fvl5iAzr0qa91/FYFH8z
         540A==
X-Gm-Message-State: AOJu0Yw9WZ+Z76Oi9L3S40NLnz4DpqcLpurRc5Nhm/Xg3xZKVb91BqUG
	rRAtublU7wX0JWN23rT2v8+QqZn/VTWTLCD+f8my8ZSTc0w8PUoJyD3yBcx237kVwYLFkgD4F6W
	PvNcXit73WbtNXyesmmvvS3oxRvpf26fVaxJrzn9lz79PO72Se37x+g==
X-Received: by 2002:a05:600c:3d9b:b0:431:40ca:ce6e with SMTP id 5b1f17b1804b1-431616a0986mr106060125e9.31.1729590498341;
        Tue, 22 Oct 2024 02:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMoXUcyBDBlvdUThYTiFcEuZ6XXmu6oF2dUWjDb8EvuYSPFlf1hesnX3+QkgfA3OyhEj8n4A==
X-Received: by 2002:a05:600c:3d9b:b0:431:40ca:ce6e with SMTP id 5b1f17b1804b1-431616a0986mr106059865e9.31.1729590497959;
        Tue, 22 Oct 2024 02:48:17 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ea4asm9268305e9.0.2024.10.22.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:48:17 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:48:15 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 3/4] ipv4: Prepare ipmr_rt_fib_lookup() to future
 .flowi4_tos conversion.
Message-ID: <462402a097260357a7aba80228612305f230b6a9.1729530028.git.gnault@redhat.com>
References: <cover.1729530028.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729530028.git.gnault@redhat.com>

Use ip4h_dscp() to get the DSCP from the IPv4 header, then convert the
dscp_t value to __u8 with inet_dscp_to_dsfield().

Then, when we'll convert .flowi4_tos to dscp_t, we'll just have to drop
the inet_dscp_to_dsfield() call.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/ipmr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b4fc443481ce..99e7cd0531d9 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2081,7 +2081,7 @@ static struct mr_table *ipmr_rt_fib_lookup(struct net *net, struct sk_buff *skb)
 	struct flowi4 fl4 = {
 		.daddr = iph->daddr,
 		.saddr = iph->saddr,
-		.flowi4_tos = iph->tos & INET_DSCP_MASK,
+		.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph)),
 		.flowi4_oif = (rt_is_output_route(rt) ?
 			       skb->dev->ifindex : 0),
 		.flowi4_iif = (rt_is_output_route(rt) ?
-- 
2.39.2


