Return-Path: <netdev+bounces-137821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4757B9A9F1B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572AC1C23E85
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC81991B6;
	Tue, 22 Oct 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/cZGMN7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E1E146A97
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590511; cv=none; b=h2WzXGE/mHd8JK8Fui/ngFl3FLJQbEblpcDelKvyl1KrfZcPaDlrS+qgniVzOhYyiHosloBLTUaBYoEnnqMrahASgQvkVEio0P10lJtbZbtNlCC7fnw6ESJU1c2PyBNlV2QyygHjNXpEyjTeSlADkz92fmX4CXI5iWybMIJnuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590511; c=relaxed/simple;
	bh=h5QExSH5FpwIjk76tbd1hfebqN6WOzSNNNcaIGbi5vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnzA+yPV/qGxEwXqyT9kjZIeil7+G2mQ9Rb6Tm29vQbgvoBsQxthvYHLGC6UTqLXZ0nYQry1lJFP+fM3z70cXR0z1AFMaXz4uSmyGYrD/TCBRZ/ahqG4743v5KTe55Kzz7k+PmHaiFhek+w5MD5HYW14Fr1+HO316KYult3Pnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O/cZGMN7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729590508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iEbIPgPvL601C6KZ3E2D4Xn3tKsNlbZfCIuRhDAjfM4=;
	b=O/cZGMN74zEy0pxj2ntcfYnlF4Xhd0LhXCwd6xm+sQIu1gs+aEjxAjhjULCPRiF7S4ubyv
	jxtTKo50AYRd96XN8sjWbZ+AoNKCvrDSE+9G5umTfK6s7HQzsNcSVkDsYkUSg236MGpOg2
	hlGUaLf87M8I0SLA/gu5/RY7CKySTMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-tNvOWcLiPSG7qbTQqltFlw-1; Tue, 22 Oct 2024 05:48:27 -0400
X-MC-Unique: tNvOWcLiPSG7qbTQqltFlw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43159c07193so48594375e9.0
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590506; x=1730195306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEbIPgPvL601C6KZ3E2D4Xn3tKsNlbZfCIuRhDAjfM4=;
        b=CMYZ9bs2sdto/VLkjwWnNlR0NzW/KhXTaok02oCtkt30XlE3Twdw+3YCwxJyKv9QCy
         KFil+1zphqaYvPwYBirmKksGLwxej1z2/ssDY10uR2TXLgJrCg/vbupeoWDG8JvbawXs
         t3pd3stT9wRwZAtwPRV147JwUKvmMF6g21bUy3oNCo7FWbXBPrYP3Tj7UfOYns9RPxxd
         QWii4eylUujDlKYuWwjnjLORJOdxIsKF/BoNnQVlKAMEYSyumV1fQYGJF6M4f0yIjphH
         CL+lWFtY+xlVAgXK4iOboIMVqlLB7GGUAHSu7jR1uvMqClrcb7xzMhcwCAw5toWmfis8
         EJLw==
X-Gm-Message-State: AOJu0Yz2KO1H3LMdLM7FfFeg/aLRTCAA3p2kbwt789Yc6LljfE/3CTaF
	o6jgbb/3ESiexEzjWjDmg26BvSujYTxu8VmWq6aMauX9X8uUqFo4CL4XMntTyvzg+Vnk3RT3Rww
	DL1zRJnJ2ckZWXy8fcBHMooxt/qM+GyPQ6LKppJPNWUtw/5mCTDkK7w==
X-Received: by 2002:a7b:c2aa:0:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-43161627e30mr150600865e9.10.1729590506211;
        Tue, 22 Oct 2024 02:48:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF96qU/9Z2K/IWAZJG7JO8BsrvfzdxLosKUDO/83RpxxK4h/YDUCY/dZB3+2Uk15dpNnbayFg==
X-Received: by 2002:a7b:c2aa:0:b0:42f:75e0:780e with SMTP id 5b1f17b1804b1-43161627e30mr150600445e9.10.1729590505738;
        Tue, 22 Oct 2024 02:48:25 -0700 (PDT)
Received: from debian (2a01cb058918ce00b54b8c7a11d7112d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:b54b:8c7a:11d7:112d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f58adffsm83215485e9.22.2024.10.22.02.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:48:25 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:48:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/4] ipv4: Prepare ip_rt_get_source() to future
 .flowi4_tos conversion.
Message-ID: <0a13a200f31809841975e38633914af1061e0c04.1729530028.git.gnault@redhat.com>
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
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 18a08b4f4a5a..763398e08b7d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1263,7 +1263,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = iph->tos & INET_DSCP_MASK,
+			.flowi4_tos = inet_dscp_to_dsfield(ip4h_dscp(iph)),
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
-- 
2.39.2


