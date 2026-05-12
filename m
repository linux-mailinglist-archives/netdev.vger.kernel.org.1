Return-Path: <netdev+bounces-287111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGHcIU0RA2qX0AEAu9opvQ
	(envelope-from <netdev+bounces-287111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C67B951F7B2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65333064668
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9E84D2EFC;
	Tue, 12 May 2026 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRfyD+IW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNOR1zEY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9544D98F4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585794; cv=none; b=akW1Dk9bUSNPQuoKx63rVe4v/KbINn+asMLV576IFCgLcV9PpcNbQ+baLBkOooGLSo4V4pJ+tbpBlYkjHMN8l64Q2DpD75aJnMe9zTzVl15GJM4mOTJrv4sWjOvjjVmNJmwvrffVsSc1uUyO6zP30VGIglZcV6hZxWsgoPp6c70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585794; c=relaxed/simple;
	bh=tD09wB0HSocpKa+1WEGTLBF7rc8s7bhV3jRNSldHa2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6vsJmmZVyGR2rhXUQUoOeg9KYm4vvOhgXqZxa+mDVB93po09NEcNvFX2q6o8NTFphNQDTldMeO21SZfITNCgEnvfRGMDZPp6NZjhC9Rys5I7dmL/ZLo350hB8XubhYOgMNBxv1+S2PW8lunQyOnNTzkltNDrn+Wz//VtZVS3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRfyD+IW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNOR1zEY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778585790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ph9gHYsx1MwJsXlOBpqpwZIJ5iQf/Q82Dt7OeJw2IpI=;
	b=jRfyD+IW0W/Ibtt5+agFRZQ/tTj/wB7bs/FcLSqNNBKHFSzTJ1Y5UoCWc9PIe3YU1pKCEY
	E7y6GC+zkLNqInN9zMOvKHZTeRda9HJM9U4vY2cjU83Qux5jRj99oh3yOVwq/g0aIoYFAL
	EOXmyL/BxcSZlwxoKtU9VzGMRSURMKg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-ns71KD6TNxS7xrqsRZ0xtw-1; Tue, 12 May 2026 07:36:29 -0400
X-MC-Unique: ns71KD6TNxS7xrqsRZ0xtw-1
X-Mimecast-MFC-AGG-ID: ns71KD6TNxS7xrqsRZ0xtw_1778585788
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a9592f666so36346885e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778585788; x=1779190588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ph9gHYsx1MwJsXlOBpqpwZIJ5iQf/Q82Dt7OeJw2IpI=;
        b=iNOR1zEY30kw1wXLvG4XGfDkPXMPNxWcqIj+P2vM45ZHyG5dfLGX58Ap9I/npdHI4A
         bQqFi/d76Ktln5lcalAc0QMHNjmzwdPeIp6H0KHuKWy+KBWVnR0EZWinCitMFsrQl2iF
         JfMQFtEZ73OLQBgcgH/elwE5qqif0srNSYHpwk4Nm/JatBUT9wYG4K8jTKawPxdLnlqO
         EkGz3GYwwopHLYgCESE3I/sp8eTPh7U9op0ZPHynkb9kJbR+dU/EfW29FtywKD+3OhSy
         EGMWlsy24uJjmzddHQ1Q0QbkwIY9J1Sldu1cqemEb0W42GrN6X6YjVEJ2DGXV0/b9/W3
         bexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778585788; x=1779190588;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ph9gHYsx1MwJsXlOBpqpwZIJ5iQf/Q82Dt7OeJw2IpI=;
        b=B8/o/cNWRsFE+T/0vPgMKeQDsRHcPJJ/C9kpeXU9Q+BGexzuicMN2E2nzvlr4kV+M6
         ddOX+yQuHKex84zkOwk6E9vpOjzNejHzmWFyQJGYxQ0KK9+IYpVXR+RpkJ70RStr7dH8
         aJ6Qxt8VxYrHZG3sRQdrs/ACQC/eHiVosNe0ZqwLmd+UQ6cxTgfCmCZhleciMrllkP5Y
         v3wNNXGvoyPdtbJKOHZClTx+JMlWs0dVnq0nuZicxiRxs0dJ8I5p/PIObfXFBHYWhKgP
         CXRfM44KgD2o9sQQOggU/X7bwKqwaAbukUepaj0Wd27RgFf0CE472cBV3/dntdL23aEy
         DOKA==
X-Forwarded-Encrypted: i=1; AFNElJ9vXNDz04pqD8n9gdYdXbqJbYuwdQW3K5TrkyLQZmUUDBw58lKYYbv5JegaMBkZu3n6ZK5KBqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn82zp3vZLej57YIdPFNjukDT2HZADhcroTe4DxY+rEXZmg6aC
	HESR4rq19zZsZlKUKynsfofUWJ7TT8rcoC7Z3Vvaqnj6DP8jcczeYrtdCHnnmPTe3my9m0KqMpg
	kVBQzl/uO1FgkQubVgC4FgYgfGVH9QqD1mYRMLgQt6uMl/oXRTnP7RBbF9g==
X-Gm-Gg: Acq92OFT8rB/lMGgLptw+4XwiMLh90pjFDqw+6asLKUN8S7jxihHrrVOvCSTKM1yWdC
	YC5IlgX9k+jiRj9tA5/+3kVSZju4v7OiLODGvTy7H5v6agNDNdKM//Mwh1NnZGmbbqBLFH1THau
	oNy0kcEq3Dkt2LrBHlF6DO0mAvymfes+/asPWj+irfO/P3j0dEow/QSwkXYd1CnCnV2O50RByMX
	lgdppi33rPj0JeuHQgjH8fhxHEBLHQaZyiG8J78VnYRcwZPXZOmPW27cy+keO7GFjw8nAUPfTYg
	4ZoqrWxZft2c2SJOJzGkDY+pjVQ+G0NP+GzdgQQbCYNBoZos5r3C85U2kbxknfOW9suAXoxdd76
	9PTcAuBZPErR/msQEZBAIwTDNWKRf3oJht2fjIuHw4PTyU6dp1xqDiTg=
X-Received: by 2002:a05:600c:8486:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48e706be062mr230118795e9.20.1778585788046;
        Tue, 12 May 2026 04:36:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8486:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48e706be062mr230118195e9.20.1778585787633;
        Tue, 12 May 2026 04:36:27 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e90681760sm40268075e9.12.2026.05.12.04.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 04:36:27 -0700 (PDT)
Message-ID: <259b0641-fba1-4977-adc7-fd4002412d7e@redhat.com>
Date: Tue, 12 May 2026 13:36:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 3/6] net: mana: Introduce GIC context with
 refcounting for interrupt management
To: Long Li <longli@microsoft.com>,
 Konstantin Taranov <kotaranov@microsoft.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, shradhagupta@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260508221202.15725-1-longli@microsoft.com>
 <20260508221202.15725-4-longli@microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260508221202.15725-4-longli@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C67B951F7B2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287111-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/9/26 12:11 AM, Long Li wrote:
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 4673ff62e6d9..78cb89c46ff3 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1618,6 +1618,164 @@ static irqreturn_t mana_gd_intr(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +void mana_gd_put_gic(struct gdma_context *gc, bool use_msi_bitmap, int msi)
> +{
> +	struct pci_dev *dev = to_pci_dev(gc->dev);
> +	struct msi_map irq_map;
> +	struct gdma_irq_context *gic;
> +	int irq;

Since a new revision is needed, please fix the reverse christmas tree
above and elsewhere, thanks!

/P


