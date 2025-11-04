Return-Path: <netdev+bounces-235509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F0C31B40
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 16:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440C83BB6C3
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FBA331A6C;
	Tue,  4 Nov 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fC0uk44p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSCKeDRG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239C93314DE
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268252; cv=none; b=OtAlPyNQ2hhgpfJMI1QNPzdU9p3M7z7YoClvVDO5JTWaozBZ0MI7UjFpT58xiRlru/K4QVSBa93I5K7KbP5iOYX1Fqga7K6TkS1ZuHAT/vQ3PaAKkkGQhBE+C3QTkGBVUBoBcAlxuC2TmpXCDfJIingxdkEdc6wwEoIPXc4YQ8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268252; c=relaxed/simple;
	bh=liC8Wm0AyDhrxgcEx+GniQix9bJZ8C2ogFs2WxuC8Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgUpXH6f2cCz0C4fUYbmIZyhnZDUxGKlM8U8qZ5+g85UVRjvjSbHPYo6eMM9eU0lN/WS/CIoLp0a5FZuqUwr6YUZA/+3s2fvRqsN6L07MeWu311c8NAtTfWEYj+X7Bv7QsvIthzpNziBhKBqrGHqLP7EfDbTtZrO19uqQVNHjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fC0uk44p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSCKeDRG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762268249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8+Qd7R5Cyqm4zUAEr3+3Wzhvl1Gxm8Bjv3wwIMGw7WE=;
	b=fC0uk44poyZcGIWRL4J3x45hd4Y2SJRzBBWRi2ZD7+XEPUjczhCupAX4KaK68sSoA/agdK
	lpy27f3KKBAgh60WRDc3I3OHu64fKjCk3aytc/p9J9hDRijvob18GSKpSAE65d/cqDXfpJ
	iGBmKazN8+cqXnzSDVF76oChYZVFbPY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-t20hNGi2OoirmX4aW58mkQ-1; Tue, 04 Nov 2025 09:57:28 -0500
X-MC-Unique: t20hNGi2OoirmX4aW58mkQ-1
X-Mimecast-MFC-AGG-ID: t20hNGi2OoirmX4aW58mkQ_1762268247
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477113a50fcso46011585e9.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762268247; x=1762873047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+Qd7R5Cyqm4zUAEr3+3Wzhvl1Gxm8Bjv3wwIMGw7WE=;
        b=aSCKeDRGuDlLNO6aL8yVyRWr7sJEvRna5BplmeCmoMyS/hanAwTKP57KlSH8ChcMLj
         eSgiCcGjYD7AYq469y9Jfh8zGBKCpUz+j5KhHO5Ogp3D5/CIfL4w/7YFzck2ySGYVsIE
         38fD3urGWaVG9H4h57ezUWjIPhTVJuAuceKxrVdBoxTj400ArmVERIG/aceRxbpLd2RZ
         8ICbL3tTkIug3gDN+U/4nONtIiYPDVQ3uz9yJKiFZgSgRvrgVYELPoINoWuZaDXsCmM4
         3EAd5AgRMNxfCBzaaBPD3DApUmvjBFDPM9hDTEvAoe1Bpl0p40vFI6MHVGZeX1Xj5nBf
         Deng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268247; x=1762873047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Qd7R5Cyqm4zUAEr3+3Wzhvl1Gxm8Bjv3wwIMGw7WE=;
        b=bKTT9uV6LqyNobqh0mnGwbZmCzH7Nr2WJ+wjlLAtgMVsjzky5szoUBFC5IT+60Bnzt
         FZR10V0oO4K7V60zEJ8/vSHhOw0jmIr2fScXX+mAFwTSudDhTXFa+0OzxBB3a71VmHJG
         Aq05FrCGmM6Xk6LVdWgWcD26WGq/2f6uKDkElm0QpKkXTYH9jIsX23KUFLggGePHhhYQ
         piKyeusvsJBJcQVem4854NZgLqW2VHT8TiK8Oe9kY1dl9AraKeITh0cYIod8SsVM9d8L
         SFCzRS91Kys+A5R1ziS2i4D71Z5vUkqpqrzmWOZePhxeYAJis65+TcjubJT/TwuwDiIs
         yVMw==
X-Forwarded-Encrypted: i=1; AJvYcCWvGvKT6h285BH5pujt+WNpxPKg636iotdpDcu5yXMNE7xG4y7MIMquQeC7xGyrswdXSFAokE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQS2ejb+dnB3x9G84+4ExRyFT0FdyswjRaqMMaiPu/H0/kLgE
	iTR3kxr+I8FwAXrAEHzcU8GP/Caj/fnZM5HJY4qKv5RNHQ1MD3QknlhzUdw4zEvaJ99VYNI8Mpe
	eWrxzInlYiSCm2ZgZ7zG3UnqWJtYEPER/pCQX6csTAQckLjwaA7miHD7UNQ==
X-Gm-Gg: ASbGncvCwcVMx0vccj4Ip8qFRwMk/YnpxWhtEVC/tXxGbT5l2bdwYFA/8szCqqHX82o
	unbnfDUa2Cnzm3Cw7a7H2yVjJBsZoV1oMRjTpTEUZZQWGRuxCheeriwupRTUNP0dbIWqInqrCTO
	kexiN5cEzi8rnBUL/aaItZrPSDmUv+xAUOYh2d/qkPfsx5aAWNY1Q+96f19Jqz3V1tKjHl0C5CG
	ZtFJ2G1XxJXc1WRDW7J56e9yU0XJmv8aNTIxFu7Oy45EFryn1ezKC/qvOTJjZktavDBvVR8Ny/j
	oEgXDeNc5HilmwZ+5fJimaYLGzU32EN5Qyv6K48np+MVkUC7upfYEfHDO+ZoqFBZK5KEyieUPTp
	AuUOqTK4ZJT09TnDK0VnQFcI4uYKZBp1maIkXt0saCZr6
X-Received: by 2002:a05:6000:4614:b0:429:c851:69ba with SMTP id ffacd0b85a97d-429c851a81cmr11182537f8f.29.1762268247388;
        Tue, 04 Nov 2025 06:57:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuQnp6R0myrfafNWEFW+Ykg5K+hkEdLj39XlL4xzqHcxa8sv0FlMMQNmg0LWUaKKhEKQuY6g==
X-Received: by 2002:a05:6000:4614:b0:429:c851:69ba with SMTP id ffacd0b85a97d-429c851a81cmr11182506f8f.29.1762268246982;
        Tue, 04 Nov 2025 06:57:26 -0800 (PST)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5be4sm4914239f8f.31.2025.11.04.06.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 06:57:26 -0800 (PST)
Message-ID: <0bee7457-eddc-493f-bdb9-a438347958f9@redhat.com>
Date: Tue, 4 Nov 2025 15:57:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/2] net/rds: Give each connection its own
 workqueue
To: Allison Henderson <achender@kernel.org>, netdev@vger.kernel.org
Cc: allison.henderson@oracle.com
References: <20251029174609.33778-1-achender@kernel.org>
 <20251029174609.33778-3-achender@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251029174609.33778-3-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 6:46 PM, Allison Henderson wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> RDS was written to require ordered workqueues for "cp->cp_wq":
> Work is executed in the order scheduled, one item at a time.
> 
> If these workqueues are shared across connections,
> then work executed on behalf of one connection blocks work
> scheduled for a different and unrelated connection.
> 
> Luckily we don't need to share these workqueues.
> While it obviously makes sense to limit the number of
> workers (processes) that ought to be allocated on a system,
> a workqueue that doesn't have a rescue worker attached,
> has a tiny footprint compared to the connection as a whole:
> A workqueue costs ~800 bytes, while an RDS/IB connection
> totals ~5 MBytes.

Still a workqueue per connection feels overkill. Have you considered
moving to WQ_PERCPU for rds_wq? Why does not fit?

Thanks,

Paolo


