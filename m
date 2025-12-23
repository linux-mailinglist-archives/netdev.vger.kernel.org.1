Return-Path: <netdev+bounces-245832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38534CD8CBE
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 11:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6873530124D6
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 10:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE95213E89;
	Tue, 23 Dec 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC094IuK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OT4aaQh+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7A1E5B94
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485604; cv=none; b=sQkZRjnNHvrKBdM53ynmKYcWYGY8xvK55UwzJfz48C+ejR34MY41JrXkpYjmdQ19PcnNkRZQP0n9HZSIYjV6elB4sQEIAnXJzcq1ON2UAOh783gTfHlnsMCdkKt1XnbK2V465EexvMpfqRflQ67ymJSmmZrWkSR/ccHyUeYHju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485604; c=relaxed/simple;
	bh=sNEqRtQD4cC/+OMMSzcvqkxq3t+X4HG/LceG/m0g/kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvaKaLPIyjpOL4yiXeOjwDfN2xWDW1h00TOMSZEBNoJaSfjWLnRPEkdDovlPLkFlIAk0Sb07CJKA94W00pOmJWWN2PHhC2CQ/HGJ1KD+PKotNfEkU7L+/6KMw73qLy4IvAEM3v7Upl9IBLG/gwvF816NNeZonMSSHRzLdasOBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC094IuK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OT4aaQh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766485601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Xk52MTUM6mXrnsoh/1vCK6e+/qWXck10bUHZ/gzoQs=;
	b=LC094IuKYvSX/y2SvHgkJpcZu0sSGS1xwCVZABzK4wUNdEShgrR+slBAxK5xNYJeVv8m4p
	sO4WGxIBq4Gmof78Hd62xKB0OFGAGnOWOmgEIrDBNW5b+lTqTaeRInCqfzB5ezInFe5Y4D
	bfG0+XilPdB8HQaNK8DaTmCj+N9opss=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-F3zqMcz8ORSI8ftkFhtRZw-1; Tue, 23 Dec 2025 05:26:40 -0500
X-MC-Unique: F3zqMcz8ORSI8ftkFhtRZw-1
X-Mimecast-MFC-AGG-ID: F3zqMcz8ORSI8ftkFhtRZw_1766485599
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so26168575e9.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 02:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766485598; x=1767090398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Xk52MTUM6mXrnsoh/1vCK6e+/qWXck10bUHZ/gzoQs=;
        b=OT4aaQh+F/b5Macq8i7wXdZv07/6oO7yjLbzdjpTHYt2Dcf6BhDk65MmFlMmRtgs6v
         2sEuwR4lAqT63ypi7TGpD0paJrjXCzrbWZnnTBLJS21IvxmTg4Q1X3LBq+DNQMH3pVI/
         YfXCZBHduVg2yB62QKnbTeZya1+apagtnjGCd/tkUgTi+3HClESGDwQBAIyCEhhZFFEA
         RU+kOCAquItBL6zzZ9wmyYz9wrv5CCYGajZXZN5pGxJmBTumfCYCXnOLi8TxYMZiP9et
         4jmf7qyFhz4HdGQt5i1nnLXEc8PrXRR5aA8bjcB8SHCXDd43ASOIJ75L3Z6dG7PXLEJU
         C4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485598; x=1767090398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Xk52MTUM6mXrnsoh/1vCK6e+/qWXck10bUHZ/gzoQs=;
        b=UfajNd3EeGdKKqzYkdNSj+CWdNM2UivxxBAvzOJ1hIRNTT0q/mYY7qI2A5+EK1Cs8i
         d5+3Ajw1+QTWrrGf2v2wH0lKNqjoxY1PLTs1KMNTClLHfduXgfS+G+fHStwUuPnjYZG5
         cN38SfHTHlGQOjFt6gO51gSBBreK8fA5veotT2xFyHjDOrbzxMYQS+gxH9FdB7KbA+x6
         vRSEFNKw+EsuRUpUHrvhBwcY2iNBlTAyhNjzeMGkRlE3Icy6SzB7pHnYfRihTnS/rq+U
         VHqhmDECCOdBqPFzp+hFFXBKl8zYHrRIPnchkaqJUqJSszsGFU3T1/j22WHv7g2vMWH9
         7n8A==
X-Forwarded-Encrypted: i=1; AJvYcCWuQV534uvpOQuA6iJAjgCz4pU/qsFwhBhElF43syv9GarzQoG46kjO+wdgaZugFsLoeBgi2Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1+HkHSVL48KdlmjROAWJvTG73T/Gxe7d6zX5zAJB0S1Oe/6q
	aVdJ7l5qk1YhuGd7SJZnjW3xPKSUrM/p14+EChd1sLayW6HvhV1ngx5j/u4zVBWOslvn3d+/4ss
	c2133RXKraEmC8kE3PvqJKGytHGBg9BZL1l5DnyNlWWJWMFGq2RPtN552VWDMVnVlVkvl
X-Gm-Gg: AY/fxX434YpDyaahH/Xzp+KLvcefLL5D3XgLQ4yX4ghX7b/InqHWPfE2IbmIcJCxO57
	yEUqc/PJJGak3P5Eu/LxAG1HZ/XsAXqkX7zLAt9iPk0v0r2DEkP9wiWCPxWmX6j6Dg6TUDBNFtK
	VFtxPVUKYKbEnXvm21pf9/MRGOQyKN2IEqjiLR6AeHvmK7TlLkHuTpvPUlbd9O3EncNANSrlyiW
	51Po09IeQEZoiaw2XpGi5BQsuUqcS5syEnmtLrjqyx09JPWPU62da5OYmR6C//lCv3q/lGn8ZXB
	JigYJakdJpCZWYGCePuT2vDdImWMU5t4j3J4Y1KVKn3600F6YD7Mwxw7XYEmZz7CuIR7U4j9GCP
	148nZdKm1A03vdi0hMgJA2odb/7h7T+NdbYgaD8051H4d6YKYtPtU
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr164372375e9.31.1766485598477;
        Tue, 23 Dec 2025 02:26:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbUtwawXu/vlfSTAPP1ZyM81dCauGdjKgGdznuMdm2wRU0UBQ0kTjpv1BCy/z2B8qhN87GiA==
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr164372085e9.31.1766485598067;
        Tue, 23 Dec 2025 02:26:38 -0800 (PST)
Received: from sgarzare-redhat (18.red-88-19-32.staticip.rima-tde.net. [88.19.32.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346d33sm240268595e9.3.2025.12.23.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 02:26:37 -0800 (PST)
Date: Tue, 23 Dec 2025 11:26:31 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock: Make accept()ed sockets use custom
 setsockopt()
Message-ID: <aUptJ2ECAPbLEZNp@sgarzare-redhat>
References: <20251223-vsock-child-sock-custom-sockopt-v1-0-4654a75d0f58@rbox.co>
 <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251223-vsock-child-sock-custom-sockopt-v1-1-4654a75d0f58@rbox.co>

On Tue, Dec 23, 2025 at 10:15:28AM +0100, Michal Luczaj wrote:
>SO_ZEROCOPY handling in vsock_connectible_setsockopt() does not get called
>on accept()ed sockets due to a missing flag. Flip it.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 1 +
> 1 file changed, 1 insertion(+)

Thanks for the fix!

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adcba1b7bf74..c093db8fec2d 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1787,6 +1787,7 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
> 		} else {
> 			newsock->state = SS_CONNECTED;
> 			sock_graft(connected, newsock);
>+			set_bit(SOCK_CUSTOM_SOCKOPT, &newsock->flags);

I was a bit confused about next lines calling set_bit on 
`connected->sk_socket->flags`, but after `sock_graft(connected, 
newsock)` they are equivalent.

So, maybe I would move the new line before the sock_graft() call or use 
`connected->sk_socket->flags` if you want to keep it after it.

WDYT?

BTW the fix LGTM.
Thanks,
Stefano

> 			if (vsock_msgzerocopy_allow(vconnected->transport))
> 				set_bit(SOCK_SUPPORT_ZC,
> 					&connected->sk_socket->flags);
>
>-- 
>2.52.0
>


