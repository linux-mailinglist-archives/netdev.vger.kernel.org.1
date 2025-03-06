Return-Path: <netdev+bounces-172406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C531BA547AE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEF4416A91C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9A201005;
	Thu,  6 Mar 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC/3GzWi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2251FF61B
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256649; cv=none; b=uoY41FvMntq1NJoFHOSFmFC1BJ9toS8S/eIlwuCkgWPGA1785MoJfhxqIjbsOYrXUDFqfpxb5ZZVCyMKZoHu/u3J1JGsRB3Uf+zlO/Bp1Tdc7s9b4HFqK5VMOYoymK6yAuJsAyYPT8Sr3GDYBx80VgQtuAWil9HkGPXSR6YzQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256649; c=relaxed/simple;
	bh=VVYipkYLNb5t+9YmKhk1BqO/Y2/m8jpgq4uarLDVMbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toH+TS9hHAKsz5Gx4T3GZ8Q65NLHtTA7d+36kqOLMcrlBE7JMhrVyyMBWVlsoWRuCbTxYSMcmZcq/F0Igb/iUROBz8kFzoGwPdGdE2bPa7tN/0lgb7ogsvBrHEuwEZc8MA7zq1enCXy1/nej9ph4z3YTQoJMbT6PY2tpBdrxpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC/3GzWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741256646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aglrM8CNKJEPllmPVOPL+c5A7efpanfxsTy232pZSvo=;
	b=DC/3GzWi3YEwOGuNl297obUNAXjegvaKeZ/U3dcVyGw9s/uaCYoTq5r5TpQ/9TX/BT7try
	+Y/aZagSeV58wdlFeOF2FPfcsMbI6FhnSo438xQ1YGngwTzIetBEKL3cO5+3NW1tIfRNqI
	V8Q6lxOjoY8A/9Xmr+/cAcbCb3RC0l0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-x72qKrmKPFGYyM5s9horuQ-1; Thu, 06 Mar 2025 05:24:00 -0500
X-MC-Unique: x72qKrmKPFGYyM5s9horuQ-1
X-Mimecast-MFC-AGG-ID: x72qKrmKPFGYyM5s9horuQ_1741256639
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bcd9a46feso1936455e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 02:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256639; x=1741861439;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aglrM8CNKJEPllmPVOPL+c5A7efpanfxsTy232pZSvo=;
        b=hrHlIYostWeWnvBGAzqdr3Hty/d1m3tfJS5eRPdyTiwT00RnlTc4+dogjHAqr9TJin
         5BelMI/dOjtuCwXn8hrLluAcpEPKJRvGtFilXjtRCb14C81KepoRnjw2GJ/s+iG2GWqI
         iDb5xKm7mx77C9SYjeg+OI7CAvgVymTLZO+Py2G3dJVR1r5HIleJOunKcUwPFoSPw8UZ
         qEFlE61neJno4zKm+NWYS3hR0V333puzkX5Jy3EG9irmbVXFe3T2Xf0jqTE0LkG/bX+/
         KERmjGpH3YdgXjOjDq0OSDVZ5sWPywVZF4RAnqH7Fg+o1B9ubk/Z4liUQ5U6kCOhGttY
         pesA==
X-Gm-Message-State: AOJu0Yy+IhABI3Ukv7yxrU1t6m+1SGkpL3hMGLjIwWHFsygn+FzKnvxR
	iCf/0Wod5L8tquD678dF3wfq0MizDSxMMtooLA9Hbm7xno/vvTPhXYg089g//MtCCUjkVo9qxzq
	qk5R1JSnjCfSXVzrzeofY9NyQl+71ZCZJn/eR/4/we/fQLn3KPFYOF0xL+E2Log==
X-Gm-Gg: ASbGncvGcRs09uwn+ck55QXr5UpweQucar0k+go5fALluRT0PXbkt4SWS7RMjEgwkBu
	wWoocY1KvPLyDR03eI0klXLRPE07clI0P+dExzEItAQD+UHKhXjb8b/f2+oBegv1PGl2yg39Gh9
	GY0i66AhlwAgdQs11VQ+z8cZPMX1B3MoffBqw8p/iidO2YDN+asilrZ1rz5QkSK/Ov9QXuFHJHC
	m7Z6K/tMwbIuTdRwp/74Gxjozr7TkMRiN7ypAUwxNc4/Qr2ZNt51lQr56F/2t++M7JSO64BB9h/
	V/j2L3MbJNZxGZCWA0lkIFFxLecFtUbTyo5WyTYJzxUa5A==
X-Received: by 2002:a05:600c:4f15:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43bd2ae000emr44180355e9.21.1741256638863;
        Thu, 06 Mar 2025 02:23:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIoZIyt6jyk+WnBMEb/lQeHYz+OCGGXjIdOb57DuDYs8jhj4eoCzP/nUrMSqNkwfd5oBy0Aw==
X-Received: by 2002:a05:600c:4f15:b0:439:8c80:6af2 with SMTP id 5b1f17b1804b1-43bd2ae000emr44180245e9.21.1741256638494;
        Thu, 06 Mar 2025 02:23:58 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8da473sm15414015e9.18.2025.03.06.02.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 02:23:58 -0800 (PST)
Message-ID: <5cb7c179-a132-477b-b74c-6dba261aba77@redhat.com>
Date: Thu, 6 Mar 2025 11:23:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: dp83869: fix status reporting for link
 downshift
To: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>, andrew@lunn.ch,
 hkallweit1@gmail.com
Cc: netdev@vger.kernel.org
References: <20250305094053.893577-1-viktar.palstsiuk@dewesoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250305094053.893577-1-viktar.palstsiuk@dewesoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/5/25 10:40 AM, Viktar Palstsiuk wrote:
> Speed optimization, also known as link downshift, is enabled for the PHY,
> but unlike the DP83867, the DP83869 driver does not take
> the PHY status register into account.
> 
> Update link speed and duplex settings based on the DP83869 PHY status
> register, which is necessary when link downshift occurs.
> 
> Signed-off-by: Viktar Palstsiuk <viktar.palstsiuk@dewesoft.com>

This looks like a fix targeting the net tree: please provide a suitable
'Fixes' tag, thanks!

/P


