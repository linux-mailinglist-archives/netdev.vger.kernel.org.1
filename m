Return-Path: <netdev+bounces-74845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B2D866DE9
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 10:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26E51C235DC
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 09:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C11EB31;
	Mon, 26 Feb 2024 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X93QE35U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B918AF8
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936280; cv=none; b=DJ1GTrlbC+/5M3F6t3eK6b8dc8zskTOA7oV/LHO02NuoflbC0MdrSjRufreku6/nWKbakRZv344qPESnu1cr3mE8ou7qduZi9HfeOJvVzaxO0yyRp5+yLI/bA6moslADc/alXjOQwOTZjF3364aafcNds9btcOZi4w1MjD1mnFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936280; c=relaxed/simple;
	bh=Dygiyz1OnjTfaz+BngVouI977noQ0Hft298bDIocTX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQstVceoQ5neFKpw1EtZXkdZbLU+7ueaJ74uS2j5nONkg9G+WfOHULazH8KCe11BKe667IyZ8elzsvR3HvTTa9Mg2TwCH8CvmRfJShFfzQvVedkL5zm/W44ps/fJEG3K6xgwe6ilnMa/O5VQvv7driXn3oSetaW9b5J5SsRxoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X93QE35U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708936277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TfCEbsiS180Pzdnz3BmbeixICS+mxWP3WbokAEMsGb4=;
	b=X93QE35UGYNsh/jjlggILxsEYwRkax8OSMs8R1jZTCnrFfGwQyThcg8y/7HQM1E/JBi0js
	Lc7e/Ira5ARgmu99B49TTjx7FBEuGSAVQiLTmnQGoGrt7eQHB19AL5uLqd7snpb8kdGBgF
	+De1OaxUFj5nRI9m3rQ74Za1l4D/sXM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-B0ZEbJQUMA2_ZMktunU6Rw-1; Mon, 26 Feb 2024 03:31:15 -0500
X-MC-Unique: B0ZEbJQUMA2_ZMktunU6Rw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3fc1f1805bso145402266b.2
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 00:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936274; x=1709541074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfCEbsiS180Pzdnz3BmbeixICS+mxWP3WbokAEMsGb4=;
        b=ByIsn7Gy+yS7YWN7EKfk7ZpPU/gNx17mxEMVkxP/zRSVcZUBphFYLdtK9K4CZLqZ6/
         +OTOpOMrmW0q70ZzzMfqEUc6YaM4Jlsr5YQj2e25XcvlupJh/tNZCt1PCquDwG0DWbt6
         NdH9YxDHnBlXB6XwRPw7kc7v2TEJZSto6GRJ+gEPdhsz5h6vIWX5huDuUeCXNE3g1y8O
         j03obKZ7NZmBpYeWNyUBiz7qIRdfJ1fyXeooTPCfWxJa1xwyN9R2Be6FbXM2AA10waGj
         UrpAZhZKWFRxOxAfAqi10V05j/zA52++/iuT0hbLAgNXfdaH9IuoH4rRU/wlXk4Gx11Q
         CRhw==
X-Forwarded-Encrypted: i=1; AJvYcCVb3JQyjkDQxXCH4aCCCUG7czYwhwA28T/u1xryEOmDH99RGKqp/gcW0b+8ehupU0UWh1wLGU0OjN8Tk7NG7fLc5nKQ4Lzc
X-Gm-Message-State: AOJu0YweX64v5I3nNtEnnEx96syjsw7EeaBP7sp/uu4sa5lqDuqXcjCq
	K17vN5pECGmHKZtzsn2p7m4fk1MeXbI3cbwiRVmouQnbik+/uwAzv6Y8nrOCI5Bca4/8cXmcgJT
	dRIPIV3/k4stjpoqbQFvm2xC0pACrMrMRoEv2dOhSoyc0G7EeyHJpAA==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id cb13-20020a170906a44d00b00a3d9a2852e6mr4010970ejb.50.1708936274468;
        Mon, 26 Feb 2024 00:31:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkiK6ZRARULAZlIUD5UEKkd5/oLyZp7eTkoe/Z67A7OQ0GXsH51rC970dStdoLZ85YatD2eQ==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id cb13-20020a170906a44d00b00a3d9a2852e6mr4010953ejb.50.1708936274154;
        Mon, 26 Feb 2024 00:31:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-148.retail.telecomitalia.it. [87.11.6.148])
        by smtp.gmail.com with ESMTPSA id vk3-20020a170907cbc300b00a42fe08081fsm1874734ejc.47.2024.02.26.00.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:31:13 -0800 (PST)
Date: Mon, 26 Feb 2024 09:31:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
Message-ID: <rqyg27a7ukbrg7wz44jqliv3ckl6ub6fnpdcpxsutw3yyczajm@iqzvhw4rqdy6>
References: <20240223115839.3572852-1-leitao@debian.org>
 <20240223115839.3572852-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>

On Fri, Feb 23, 2024 at 03:58:38AM -0800, Breno Leitao wrote:
>Do not set rtnl_link_stats64 fields to zero, since they are zeroed
>before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
>Signed-off-by: Breno Leitao <leitao@debian.org>
>---
> drivers/net/vsockmon.c | 3 ---
> 1 file changed, 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
>index a0b4dca36baf..a1ba5169ed5d 100644
>--- a/drivers/net/vsockmon.c
>+++ b/drivers/net/vsockmon.c
>@@ -46,9 +46,6 @@ static void
> vsockmon_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
> {
> 	dev_lstats_read(dev, &stats->rx_packets, &stats->rx_bytes);
>-
>-	stats->tx_packets = 0;
>-	stats->tx_bytes = 0;
> }
>
> static int vsockmon_is_valid_mtu(int new_mtu)
>-- 
>2.39.3
>


