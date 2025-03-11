Return-Path: <netdev+bounces-173941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264CA5C53A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76AA77A3658
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F725E454;
	Tue, 11 Mar 2025 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNY8Y78n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8197325E836
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705947; cv=none; b=ahsFxpJqI/ubikeEypj9FdvmE4VziIKuzgQF9575zFC/4izxJx7NLv6INjwiDpzDMObEVliAlFOPgnIdAhW7GHn8DTv12qTakVlaisaaDFwlvux7R0Eapb5oD+cKlRfcDnP/4X02S7JBeiDm37W4p1dwqK6B48zQ/XgPUzZH3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705947; c=relaxed/simple;
	bh=yoIFgSAiUdP7WLCN8rjXmsWHH6MBXmDZmh0tA1Fgl9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx31MiaQVD090UIeoIQwjeg7ksZYrotrPW8NojKPMenZcHQ7kj3C/2+aybbbF3/jK0EfVSUHHpNOIjKQaT4jp/Iz7nrkvXraDeEdzOOQ0SsnBWJq73M5QHo3xWRH7AmEqvct+3blivsQ+56hPevc8HnuH3+4TU4Hj2L/R1pZx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QNY8Y78n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741705944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CF1D3f8jUVM7pHhMLuoyN6eGJOPdBvif3ySD4aoMxU=;
	b=QNY8Y78n1obYjJ+UwtujJR4NP9FjjIe8mDDvxVSqhx1w2acnx6AJPnLO1W5Ybw/ZrAhOcl
	6GDTjFhAJzSNlup1YjnOFhPTqNwzABSDHOrbAK4U02J8yBssV7Ckp1aMhW7lnmERXrnt11
	KTU4l3EV1tIjHN4kH149mgUgns46O8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-8C0U57XSON26aVjh8Eg_FQ-1; Tue, 11 Mar 2025 11:12:23 -0400
X-MC-Unique: 8C0U57XSON26aVjh8Eg_FQ-1
X-Mimecast-MFC-AGG-ID: 8C0U57XSON26aVjh8Eg_FQ_1741705942
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso39060675e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:12:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705942; x=1742310742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CF1D3f8jUVM7pHhMLuoyN6eGJOPdBvif3ySD4aoMxU=;
        b=HdpF0I/YEnZox5QTfcku52/LIzSY0XvWfA0eZGsr+JVYbiDOyi5vV42p6qGv4+76A6
         LuGjanqssGGKrjnXEBQzBavUVKTIsuIQd6No0K6Uf2Mc2kyxfrXOU3nz2qhvivLfiOPJ
         urdkSIY6PhZQt2pC3jGSXHMVHtEF7cNedxyPVwj1xsIeIXJ2CHqwNIVx2Myq4V5V9Nee
         RKJnb40my3aqiu2ZTrvzpgnkz/KPFL5DystbwSTMkE11zohw4mafTSYhXBoHhBFdDFq5
         p1JH55UriCHuKuHAKKooWZvb9Sc0pfOmZ0vlf5ECMQ3xiew1c5Cc29Q3Vf4eAkAsaHw1
         vd+A==
X-Forwarded-Encrypted: i=1; AJvYcCU1PWr8VCpmG1Q/W40liyjl3asptB8v/PmLRB56SXuL3gvcLceWfxOnx6f3eoa6nwxlnb19O50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEhZuYk5scUl7+QZrc12L4DI0/Qj8j8VeNCgLwkYwjFlk+xYDS
	vlgzI3YmQ8AYgVojM4u96yYcEkVBu1JG44o/VT9ZEd5zSJ/8NrlUNL0tUJhenng3IuDEsH2dS6G
	DuYAmB4XApwduYwvd75eyl3Nk8BzZMeOsfzof2Lo7Q+nj8H62OdmYHQ==
X-Gm-Gg: ASbGncv28K4piqTA6OEOE6iQ9fZErreST+ya/dg5V6jc8WCKzIOZZCJba8tifs5dgjz
	wgkpch3gKNz+Ivi2/U418A2PAeJy+pzaC+DVCKMBYemLK/zQT8LCnL5PYuTo3vzUeAqaBbsImh+
	ctl6aysxUoUWpKSyFy5DJl0dMFPoKrB0RYvhNvXxJVtwAW5ZgVoP5xFlQMzzaZcGEoabtVs2vi6
	Lf+TjCIcSI57vlX7fucziYKUXuNoEvNPO0oeClGOmoiemrfc/i10PWEM3bCNFyWgaaViwnHYvpo
	QAUL+e5u3QF3VaEq07qztD5H3J/woY+0cOTlMv5LysnqJg==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43c549dcc0amr165020615e9.0.1741705941880;
        Tue, 11 Mar 2025 08:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9wsfMW51qmxpjFmLDHcrjDMvKfOqYeqwdWAaGS77Is3jnHVeG6hcVj7evohm5SosdgEeGRQ==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43c549dcc0amr165020345e9.0.1741705941538;
        Tue, 11 Mar 2025 08:12:21 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d031d0e41sm20581855e9.0.2025.03.11.08.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:12:21 -0700 (PDT)
Message-ID: <15066f7b-217f-4457-8bff-a4aef614cdf3@redhat.com>
Date: Tue, 11 Mar 2025 16:12:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/14] xsc: Init net device
To: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org
Cc: leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com,
 masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 geert+renesas@glider.be
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100845.555320-10-tianx@yunsilicon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250307100845.555320-10-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 11:08 AM, Xin Tian wrote:
>  struct xsc_adapter {
>  	struct net_device	*netdev;
>  	struct pci_dev		*pdev;
>  	struct device		*dev;
>  	struct xsc_core_device	*xdev;
> +
> +	struct xsc_eth_params	nic_param;
> +	struct xsc_rss_params	rss_param;
> +
> +	struct workqueue_struct		*workq;
> +
> +	struct xsc_sq		**txq2sq;
> +
> +	u32	status;
> +	struct mutex	status_lock; /*protect status */

You should consider using dev->lock instead.

/P


