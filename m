Return-Path: <netdev+bounces-243179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222AC9AD1B
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0263A2325
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B14630B51F;
	Tue,  2 Dec 2025 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VrYTTgBY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ5gwqv4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8999A26CE33
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667023; cv=none; b=ufDweeJkJzk1opqeLNck8B1UIWVEkd+/TVUFRuNJi+2Ih7fvdLj0Y8fEbT6gIaDBIMRAJjrAWqQv2Zv0tXEvVoDXbIV5cThOdssS/rpG7MuhqvTj/A8x6ELUye8d92R8MCD3ZdYoEmePt2A4HtwYv9hMZ703FTpD78M2b5jXplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667023; c=relaxed/simple;
	bh=I2fUpfinEb6za9hQHzTv1Bikn29tKNm6adGiCK8ycTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JkfYaEyKeW4neEQ6vuXuYgmZJpOK96fmdTJ2+cRwnKxUEtSvkZT+OXFu1LrJCtk96iDbkmRSwY2Z0BY7uv67PdkQwO6Poyh3mr3GcYHEcuHiRK+n5sQvQIgH3Fiw9EU2LovjHJGtas4YgFbWaemNZh3DgyYMtOb+41fsQKRecFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VrYTTgBY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ5gwqv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764667020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCGsrUG23izEnDGb8sp08lSUDeok7s/DDzz9OH8cnoc=;
	b=VrYTTgBYZ28RERo2nMfMP+gVLQ/9Ldbtiko1l/KBy8zgPdwef2Ne/DCr8oA2mP763VLfyZ
	Z+MP8NzHxdCfp4AzAWKM19GPU+mpHqHxfR7tcDrgzsCjeQOBRSdIfDvR3T4oeYDxw/LnlI
	MyzkM2U/HthaKt3TdGMORXNbGSQGaX0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-81Heh9o4O0yVTkpp9xsAgA-1; Tue, 02 Dec 2025 04:16:59 -0500
X-MC-Unique: 81Heh9o4O0yVTkpp9xsAgA-1
X-Mimecast-MFC-AGG-ID: 81Heh9o4O0yVTkpp9xsAgA_1764667018
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47788165c97so36954635e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 01:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764667018; x=1765271818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCGsrUG23izEnDGb8sp08lSUDeok7s/DDzz9OH8cnoc=;
        b=jQ5gwqv4lSW752UG1U9Ob/zv0mt8LErWFVaaayISIdf9dJjUqLsHP8/kXfNJokZ2S0
         B46ypd1A3BkDEvZPAJRe5/Ioj24edRpRipnbhXFuH2yqPY7bmV9JAneypvGgncfScxnj
         sQ012s4Gozhab0s0Pn78abRFTxSFMaahAQSDgYKbSIhh+vYpCR5CtLKBI5ZNPZKkJrzI
         ss9G2y5EeKhI9AiuoDrLoZzoQsGqbrANuJau4H62zfaqFzjU2eX3QJ6Cbb/CTIShI1sL
         QxxjwJKYqvlrkh/YSwHHv05wqhwtmCutZqNmhN8iJ13fMKtJ8LbquZg4FGV6IICdEdFJ
         Q/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667018; x=1765271818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pCGsrUG23izEnDGb8sp08lSUDeok7s/DDzz9OH8cnoc=;
        b=Lo0wypB85bq9mFQd0nQSIExG/P0ff8y3EG7OT75AVONjD5ZVpZIjPnSQV/rpEq03+Y
         zdvkL0PQAxAF04w96zqgmyjuF7+GUasfnMslx1JKzZbCDdX1zb+wUskkbOoApk089lIO
         2phdxG+C5fgPxiCFvpaNg5ondhrm9EANLq1oGPUHh54Gc5BqN11vYfC8XIFO8eeSrThP
         ksjCqvrWongoprlt6CJ4RmfdXZ+/shq+7k7Ld8x613O8H/qcDmHz1NNy3smjY+0J865N
         UGzD4kx71w1Z46U6SbbkL8tWuQpZaYy3ZfMgc90o8Kz8uuVNSXaet4v6Zw/5xdfyOVsb
         QWQw==
X-Forwarded-Encrypted: i=1; AJvYcCXnwWwuhV2jt1sB/RWRaF8cmxBNFvepXF0Pl7NpH23AfxigWj5Kg3/iWeL9LtDaLkd8nYO23vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym4ZsxZ4J0xk7X8bQM1xwUfmSLeoIKR4CgUjxYxYeQQFKWpGa/
	t7jaCyf/KofJAaopanfSskDct4rK83smOruF4LkkOiRZJ5MuHEVvk6V2mG+6bMbG7UbRSSvyhu4
	ZVtIrL65yL1LprwIc9oK1TWuKfkm6UUeC2kWXBVWAf+BHbmHjz2uBLeztZA==
X-Gm-Gg: ASbGncusMTokV7q7MGLsI1DT0fx9z/XBv68zRtyFgujOqKdusIaX/2gL1U8gWwXnYWe
	jtsEkfQ82x1/rDhulR1MvA93u2uScETPIQI/y1f3RV7kRzSzu6YZQkwVQI/CuZrHvRCV+b6A5sl
	U6M9csZ/nDLNwC9ez3ld6OYWfiRm69kDJc8z5S0vf+DN2qs7uIsN7AeIx8LYbluuT0nQnNL9A77
	6fep8zDPkbmwdubk1E4KyWIYClCW8UDgeNXumZrHh3N2PvX7EX7x5b0RlHnen2nAICv5sBeuQuT
	YCmEz+Q6fLk8lDgoahIJme97Y92ApFmLZKG03ulItesAf+ed40p0h+9Y67jTxYtSNTkBQAvniUB
	yJ8At5Eg1ifZnBg==
X-Received: by 2002:a05:600c:1c13:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-477c01b201fmr400048545e9.22.1764667018245;
        Tue, 02 Dec 2025 01:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpn9/1fZ908KecQRldKdGXrA1FhtSyP95WNmsUq5rvm3LNwtssDFj26Nxp/mXvT92tYpxVMA==
X-Received: by 2002:a05:600c:1c13:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-477c01b201fmr400048325e9.22.1764667017897;
        Tue, 02 Dec 2025 01:16:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479279bf921sm9737555e9.9.2025.12.02.01.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:16:57 -0800 (PST)
Message-ID: <689591ae-2680-4ff4-b742-a8653da546a7@redhat.com>
Date: Tue, 2 Dec 2025 10:16:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v5 4/9] net_sched: Prevent using netem duplication in
 non-initial user namespace
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, kuba@kernel.org,
 Cong Wang <cwang@multikernel.io>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
 <20251126195244.88124-5-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251126195244.88124-5-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/25 8:52 PM, Cong Wang wrote:
> From: Cong Wang <cwang@multikernel.io>
> 
> The netem qdisc has a known security issue with packet duplication
> that makes it unsafe to use in unprivileged contexts. While netem
> typically requires CAP_NET_ADMIN to load, users with "root" privileges
> inside a user namespace also have CAP_NET_ADMIN within that namespace,
> allowing them to potentially exploit this feature.
> 
> To address this, we need to restrict the netem duplication to only the
> initial user namespace.
> 
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Signed-off-by: Cong Wang <cwang@multikernel.io>

If I read correctly, this will prevent any kind of duplication inside
some/most container orchestration platforms.

I think that nowadays completely disabling a feature for containers is
not much different than removing that feature entirely.

/P


