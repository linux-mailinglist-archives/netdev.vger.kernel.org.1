Return-Path: <netdev+bounces-194669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E004ACBCB8
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 23:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A963A2F7D
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4A14AD0D;
	Mon,  2 Jun 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChJkCIme"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5C26290;
	Mon,  2 Jun 2025 21:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748899994; cv=none; b=t0a5/+A3GYpquHxAyCgNoeEmJQjC5ODV9Qm2GLuc8VnKQT+gyXWNsk/0aoXetPn6evdSM+xw6kCKQBbHuXSo93it9KL+aUbq98oVhSQQKNL461iN+q+Mk39M7OTM5CRI4j+lhfFW3GmAG8Nrd0t+QS+ynMnOaivfDsYRvzygTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748899994; c=relaxed/simple;
	bh=a86aTqIcBI5tthEK2kvW/+QKG2BbgQM4Dam2Dx/8QMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KooZEHqu+8gEiE9K5rM2KQCd1dgGzDpnynI25AbNQyrg1fGo87+ZzexFVt61eLwGaJmAlaGeDjlUG/VwCpWlakvhwxf1r/cyk3o8vO87ZQEsz8RMf0ZI4yrK8hHcGvoO4N/UCbUzTy04vKYuB5qrkqopOVpUchLRoV6QrinEIIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChJkCIme; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747d59045a0so1412222b3a.1;
        Mon, 02 Jun 2025 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748899992; x=1749504792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPMINMJUPObAPOCWSKu25k01E5gHE2sQKNYTtWRAQTI=;
        b=ChJkCImePQ/Q58nb6GZzGUMIjjhagWd7Q8PUHsPmUMMJwB1DCyMQkqOFDw2AiaoCyW
         aYQO8f5DVY56VvVypJYqYFsGuSQ8smcik+EtPDOs3TPGMPE2BNo7VtVLMmCn4+s//yPf
         BfLpCBw9Q2lG6Zy3V8gMbNkOXFR55+NXWzZAuva5FPDhxEciH4tXtZ2vFKxm0HXvCLgJ
         g7LjxntckS0A8cj82RPsF0ju5EuJ4dcg9TJLmq3iUVXu+rHfnTMwJ4ZdbPFCuMLQVX7b
         qh6lZb8Dr0dhIOqznrp2hCOKvrsT+EJN2pR1Uhd3NSJ2feP83a+wXNhFNG3EjAEFKxJh
         VNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748899992; x=1749504792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPMINMJUPObAPOCWSKu25k01E5gHE2sQKNYTtWRAQTI=;
        b=ImtPCvx4kbkp7EPA8aBwRmmQXRGuNDOFw5IiptQCXoxiX/+9NaI1rpXEi8OlGR64Dg
         bE/5CFDQn2ZoFXHi/65bp3FuI4i6qiCfwNIXGuTmhCd87yaMZb/ZTLTwMWXEcF0zumIw
         WM3x6H+QFcbh11iMhRYDdAqDiq50JIJXSVsstJcXFuKafn35oVECtft5rm5CWWyseUgF
         8P+D0dZe4mxHTF3IdHgMiCHqC7U6yI8Lgkcy4KV7QuSuL08KJ0BYeVSw2bwlQt/0MLsd
         hlVPTBIQkdk6CwL8Z5NZBzuSQXnbF2Tyqf4gQBxZxBADjSdfsZg1Pz/MvoInnGDGrnb5
         rJvw==
X-Forwarded-Encrypted: i=1; AJvYcCW/sw39nY+qsX/AUIR+A7NV1Cwe5+QZiVwfMLT0u122zMbddzblD5xLqyIRZaZ6q8Q8DR2hhc5ekAJOUTI=@vger.kernel.org, AJvYcCXflJaAxC1kIT7f3WxGnOFk4hwSABNGamxc0M9EW4IapcP6h+Z7cMEt3Mp68J2bvqbPjZPnLmGn@vger.kernel.org
X-Gm-Message-State: AOJu0YwULY/G6VBAHCGS9avt7MxliQA62FAq6MW2dcTwkw7mbyGy1rno
	aAoLHOoRCS/tIIuvS6GJURcxWdUUAMxeiN1yVBS2qf2UMK399RZWsRk=
X-Gm-Gg: ASbGncvva5DIXhWpBX2jClLiuUcCf+b2d9IA4BIl6n9+SqfNccgi+fPJNL4TjqSl8sH
	wz+IGhqPCPEE5RhdEzW2gJkH4zHJ1VuhPQVwEQjLdO+qjXCtpSGeBZso+f+ptwXCeTU9+lcVDg2
	zCRwfn+IqPDoYkSAus28wV+p121F4KnEKjPH+5T6eTLzOyGDw6JJFAjKCi08dwAmdAHZtQY04nV
	sO3+35Xv2WIqh+/7i8GpwHVQY5dNogNPiu0NxVfD0CM5sr0FEqz7LSqYqT8B60NZU0cGkExN69M
	lPoQZVu2MKPIAxCvQFAMOjR8OmuF
X-Google-Smtp-Source: AGHT+IFGmBtSXYwlbVvI2uonPiFcImm2xv3bUvZrAywZsxlqL6ozv3gYH8Ba5lZE8OQAITc85gBSiQ==
X-Received: by 2002:a05:6a00:1749:b0:746:27fc:fea9 with SMTP id d2e1a72fcca58-747c1bcb1demr17893776b3a.11.1748899992310;
        Mon, 02 Jun 2025 14:33:12 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeab743sm8344713b3a.54.2025.06.02.14.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 14:33:11 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: rafalbilkowski@gmail.com
Cc: alex.aring@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH] ipv6: ndisc: fix potential out-of-bounds read in ndisc_router_discovery()
Date: Mon,  2 Jun 2025 14:32:35 -0700
Message-ID: <20250602213310.2519903-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602065826.168402-1-rafalbilkowski@gmail.com>
References: <20250602065826.168402-1-rafalbilkowski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafal Bilkowski <rafalbilkowski@gmail.com>
Date: Mon,  2 Jun 2025 08:58:26 +0200
> This patch adds a length check at the start of ndisc_router_discovery()

I think it already has the check.

---8<---
        optlen = (skb_tail_pointer(skb) - skb_transport_header(skb)) -
                sizeof(struct ra_msg);
...
        if (optlen < 0)
                return SKB_DROP_REASON_PKT_TOO_SMALL;
---8<---


> to prevent a potential out-of-bounds read if a short packet is received.
> Without this check, the function may dereference memory outside the
> buffer.

Do you have a KMSAM splat ?


> 
> Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
> Signed-off-by: Rafal Bilkowski <rafalbilkowski@gmail.com>
> ---
>  net/ipv6/ndisc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
> index 8d853971f2f6..bdaac5a195d6 100644
> --- a/net/ipv6/ndisc.c
> +++ b/net/ipv6/ndisc.c
> @@ -1235,6 +1235,10 @@ static void ndisc_ra_useropt(struct sk_buff *ra, struct nd_opt_hdr *opt)
>  
>  static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
>  {
> +	// Check if the buffer contains enough data for the struct ra_msg
> +	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct ra_msg)))
> +		return SKB_DROP_REASON_PKT_TOO_SMALL;

Please run checkpatch.pl.  We don't add code before variable declarations.

Also, the skb is linearized in ndisc_rcv().

> +
>  	struct ra_msg *ra_msg = (struct ra_msg *)skb_transport_header(skb);
>  	bool send_ifinfo_notify = false;
>  	struct neighbour *neigh = NULL;
> -- 
> 2.43.0

