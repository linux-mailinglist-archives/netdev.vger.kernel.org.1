Return-Path: <netdev+bounces-241467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E91C5C84336
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D3F14E81F4
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97085269CE6;
	Tue, 25 Nov 2025 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXNI4l3r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nUrSStRk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FD9269B1C
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764062551; cv=none; b=KOkytGbFN0SgMbhoXa6FeVhVp5JTYSm22J9+t4ndSkydM9aC6TVvBg+vSfmER6nJusLYP0kHMK3qs3HRz76nDMqtRL6cPcPfomS0Cbuf86ZeaIQSDrPFM0nFhszDu229R1DBUTFxXpL2W1V6sEcDBGenB/0RAHisesfP90kuZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764062551; c=relaxed/simple;
	bh=d9QfXw9j5nCTdluX52ct0/3g3ewF1ZOiUx5/M5ROZ1Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=t7SUn6EijXqCON1dMFZINHpgeYV7OUSI69Kj0RX52uNt210yvTXLkXSN1p7uHf4RiPJzdvN91Bb84ggAIL+HfXx43GBz6xQGt8HtF3J2/9DXaZS6+he4QNg4AgWNxegiVOGrSi7U2eqhqMdJAs5ASIUgXqFMgsmJrumTy5ALdcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXNI4l3r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nUrSStRk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764062548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p8JZAKMb72KNGpUvq/R2dmJOIcIW6mORgzE61trYq6M=;
	b=aXNI4l3rZEoALlZghuTAD4t3k+C6IA0rgbzqQHVGzZz7gxMQ0uRC3O+AvF6THQ1+PBGMaL
	C7VoAdCeHH2ytSTRqrD+fEDSivwmJN9K57mjHe+9tlmiombVkZHF5UvKbZ2qpegQLN5w/i
	vrhHDTgB7aCtN4sR5xb3GfHNxtKxLOM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-mtbNhIsdM5KxVzxXRMKrXw-1; Tue, 25 Nov 2025 04:22:26 -0500
X-MC-Unique: mtbNhIsdM5KxVzxXRMKrXw-1
X-Mimecast-MFC-AGG-ID: mtbNhIsdM5KxVzxXRMKrXw_1764062545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3339cab7so3509026f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 01:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764062545; x=1764667345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8JZAKMb72KNGpUvq/R2dmJOIcIW6mORgzE61trYq6M=;
        b=nUrSStRkIVk4SrNpwKClY9hwIrA66qayfLXxCidNo5YH2yngnh0Ldb/dyjy5ufDPPB
         9u7n/YdlogNtFLJCC8KYDJrGeAb0kcT+eVvnkUk7k/npbKCudFqvsmhTqdvpFHDRKSNQ
         qk0ZvW7B3Ud3R97Tb0pisS/FxEPJYoK59VEFZYSjItKEjHLFAtjmyrkVEukDQu1x67vP
         /Vu0NDeNa9722x+gL+0NSLHpwJfIPhu36wIO1RkE2lThxFVvcN8Qh2L2r80iTCsDbWhc
         tFxZWrXGqE95z6mCg1li+0hJXb57/ttmOLiNSaJPg5winI7WJhyFGeAYAii3pEXMf1XZ
         Uouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764062545; x=1764667345;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p8JZAKMb72KNGpUvq/R2dmJOIcIW6mORgzE61trYq6M=;
        b=Li62YnlwI4whbXkmZXxSgW4dYOCFW53ivS8UDzM8Lb4i2IN/mvb63ueVA811UzhmCK
         vHsT6pxS9iOicQk67iF7xw8LX0lcWVKyQ5VMO1hPn24NSPB12VReQNuI6R3g8lI0VG1O
         MBjgj9xXNc7V8kxUWY2wpnPr9eyK0Jki6W3K4XYRZrdLDB317JtUoevwYlXva85h3cxZ
         o1+r5z3NoxPUfUIqvYpcsIg79n2JTHWwSGD1jSvRDD5HOq5Eg97jE6433tMMxIyxVQHs
         pc4/ewaMMYFLLSm+HG6XQPTzeWRzt3AODKZMc8g4+h/c+Hy2rco2DECFv5TeseNt6/6w
         EN2Q==
X-Gm-Message-State: AOJu0YyIucjzQgl/8UKW/ZYZG7jSo+kiASG3y25BUnFsq7Vol7BzwtIP
	2IBG65Vv35nH95hmrqy2l7YWUYGJ7SiL1Is6iph4sXQcSzfevImi0tu+E5fiPFnw8Z4QUTUdWN6
	vP0zMJDqu9mxEpdGhoqKX2yCvQUa1CLenIw9NVtP1FFKpl3S3r8ibH2vhJw==
X-Gm-Gg: ASbGncuHwylVu8cX4P/EvR1883oSxBwOgaA5Sfjdw126KHcIiLxSwDi3d1k2SQoHMPO
	Gb7BEv/mMu/sfiW5fNHM3/gq4t0hgPfjs0CuMhYdaM4Ty9ozISgwKMBY6RPCIkIiPHPqb+GbWRA
	88gFtqSmhdc3KWpgv7BeJiQEYtGjbikxJDV8Gv1jiYoQMa1sqhHr9s/uDueO96b5hdpUliwgM+g
	qp9yzNYTbn4F1FdA8WQk5RqpcVszQ7X5ezPMJN9LBy9lG6bhzKqdDGCNIqaH/4qFJNO/xpnUPnP
	ij9rSz8sLLuhRfidh/9sEfHgrnb0JLodiFvi+fktqEFH+y88QnYs92fxQ39QmEcrxIM5izLoUeQ
	U8deFFjYpLEjHhA==
X-Received: by 2002:a05:600c:4f87:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47904acae93mr15474105e9.2.1764062545266;
        Tue, 25 Nov 2025 01:22:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAxsr/ubfN5YpYd4v5eJSL+F7mCFnQZ4058Ogje1+SdICGpg+eoVD6KSI9ATHXp50CNkWDhQ==
X-Received: by 2002:a05:600c:4f87:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47904acae93mr15473845e9.2.1764062544770;
        Tue, 25 Nov 2025 01:22:24 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf36f535sm245502945e9.8.2025.11.25.01.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 01:22:23 -0800 (PST)
Message-ID: <526b5396-459d-4d02-8635-a222d07b46d7@redhat.com>
Date: Tue, 25 Nov 2025 10:22:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deadlock in virtnet_xdp_set()
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <e6a561af-0e3d-4ac6-bdbf-581cbb21de33@redhat.com>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
In-Reply-To: <e6a561af-0e3d-4ac6-bdbf-581cbb21de33@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/25 10:21 AM, Paolo Abeni wrote:
> the NIPA CI reported this deadlock in the virtio_net driver:
> 
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> 
> while running the xdp self-test (tools/testing/selftests/drivers/net/xdp.py)
> 
> Quickly skimming over it I suspect a race similar to the one addressed
> by commit 1e20324b23f0 ("virtio-net: don't re-enable refill work too
> early when NAPI is disabled").
> 
> Could you please have a better look?

Whoops, sorry for the dup, I forgot adding netdev.

/P


