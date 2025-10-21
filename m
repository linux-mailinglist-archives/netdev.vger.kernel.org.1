Return-Path: <netdev+bounces-231104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57937BF51EB
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6FF8F4FF7F9
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E914926E71C;
	Tue, 21 Oct 2025 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bP/M/3RP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099927CCE0
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033287; cv=none; b=cBZQeQF5gW4NnsSOSKU39eK06F9zO7sRDW2xH70Ns47oYWzKyrim4i4bYfIBg/klxiyRbNzLzD9UB1vVT9t6UWrrj/F9Z5p7OzcG0iitOGxxq2WT2qxeNYoJFAFvHk4Syc9ooX1c5hY+pl29vh0/oy2N+uieFlAqXJKQNQfO+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033287; c=relaxed/simple;
	bh=F0DjcYZMN6dfyiq3peDoaltx8/kmdCZUyrkfEQr8AZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPvVshYUdr+UrqWoh9WGvdTtRey/enUxYL5Jos0uDneOkBgFxV/AgaVwD43lMrHKS+9XyYNNnn9N/o72t6KwvxVPl7ecrb6paeOi7tUk03NMJV0kqwCX3tiLdwoocB9/ntucg9IhIgxCkpIwgz/0UBnsHpRb4BkeiUjwxTQCSwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bP/M/3RP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761033285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FMInfiv3dy+mIkZqNkew5SZAZMUQOoN7TRdbQvCdd6Q=;
	b=bP/M/3RPrfs30Lnr7M4rJ1s4oujAaflz3lS+GWl+iVpsrDC8iBIbKZGSLteH+aW3RtGeF0
	cdcQyD8IShW5va4QasXMEkQInJyQrgC1NowZ+/GihzrWgVj47e+mqJUeueIzBcLrsFbhew
	mdZM3gkMSWDHD6hcCjMrlOdBsnVytjI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-OogzyW_OO6atUnsia1n0bw-1; Tue, 21 Oct 2025 03:54:43 -0400
X-MC-Unique: OogzyW_OO6atUnsia1n0bw-1
X-Mimecast-MFC-AGG-ID: OogzyW_OO6atUnsia1n0bw_1761033282
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47114d373d5so51267665e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761033282; x=1761638082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMInfiv3dy+mIkZqNkew5SZAZMUQOoN7TRdbQvCdd6Q=;
        b=azAnOnylqK/bYQCTGCP5SzSDwTByW2wsFQ/ZVdVURjFNJUv7uILASUqZTtI311Ckwg
         KpuWloHIq2H4JpeffaR+HcOEgOpDd3XRokEq2Z5hSgMiHLDJsYQYl3wLs3D+EjX9Sm11
         XFIPPTUh/fQzYyOM8VdfHCsdi/IaMdjeHzJ/joTU4OAyAuDimNsnCoNgxd0ryrq571nA
         6NjGdKyyzFtYTbWm7VbvI+qe0E0FsKhhlJOu62fuTcVI9rY5npjuMMLa5+0VZkyCAnmh
         SL2kivUAZoF1Qab4/onlgJeSHTqwBkUMTesp395cjCDgvLdRIaiMRtJ4Yjvx4bLHPQ/L
         HYJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbVnIA4ATCgVD0oNSTYHT9XAADhJBpGBNu1u6l4Uv+Mnv5UXuh49vcIMMG1jNsj+wdJNtHeXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVvbmU3S/Tx0/WO8PXsOusMmUloXKO2A0BIbRheRMPUGgN7Zx
	Sj5U4WYMDfERsSSBTZMDLPF/atCCEui/+nw53GOxTAkXPnGka0soHUDCi5oLwXnHi8T/iNBF+1U
	1XtH2IkcHeW1rnyTrPCvSJedCqljk0vbDjUPDZRAITjWpGNzBAxWiEBesAQ==
X-Gm-Gg: ASbGncsM4UJ/UkTcTQBpBxo70p+5+nSBrhZ8yrl7UZrlGQXXldxhuu0MIR9HjA0n84/
	m45nY2BP8GKGxaq+qpRz858cTgoYBkaKzYlb+vI0RNfva28vX8xgiJkrfaqGkH9Eq6iJkslf1Ai
	t+NyHspbYaDE4FRv5fy3c/NrJwQUbPqKLoJ2QZ7Sajym9RA+bFw53IOBTbuZAfzvJZ9FDjd+uw9
	s+oJf7x0iK+SLXgl28ezPD5gPgK+coNlICGxx3bHCocIHDMuEztloJIcBOjXD+K4kXUvoAYlulh
	0FjXbS7m33Jt+WSpBDXVu++njCFdXhGw9oH6t4QGldtB0wIRzw/DLJQEFQEMWGmpczJzCLo/+jD
	tGVqsVTJM+VaP4s5xZtSMDzLI2f9RXtB8tKlJKL7/XJsQVCo=
X-Received: by 2002:a05:600c:4fc2:b0:471:1717:40f with SMTP id 5b1f17b1804b1-471179124damr125020745e9.22.1761033282317;
        Tue, 21 Oct 2025 00:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDhEYl1g3b9DS05yJXD83DcN7Ofw4BNMQiJWEdN09jbVJiMjhYQd/y8ZxhL6cnSbmuepizWQ==
X-Received: by 2002:a05:600c:4fc2:b0:471:1717:40f with SMTP id 5b1f17b1804b1-471179124damr125020585e9.22.1761033281959;
        Tue, 21 Oct 2025 00:54:41 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471556e17afsm178904255e9.17.2025.10.21.00.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:54:41 -0700 (PDT)
Message-ID: <a73d19f7-6f71-4e82-a8d5-5b56e6b92f0c@redhat.com>
Date: Tue, 21 Oct 2025 09:54:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/5] eea: probe the netdevice and create
 adminq
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Vivian Wang <wangruikang@iscas.ac.cn>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20251016110617.35767-1-xuanzhuo@linux.alibaba.com>
 <20251016110617.35767-4-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251016110617.35767-4-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/25 1:06 PM, Xuan Zhuo wrote:
> +struct eea_net_tmp {
> +	struct eea_net_cfg   cfg;
> +
> +	struct eea_net_tx      *tx;
> +	struct eea_net_rx     **rx;
> +
> +	struct net_device   *netdev;
> +	struct eea_device   *edev;
> +};

Whoops, I amost missed this. As suggested in v5 and v2 I really think
you should change this name to something less opaque i.e. eea_net_status

/P


