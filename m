Return-Path: <netdev+bounces-193442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AC2AC40BC
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72CAF177BAE
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0619020D4E4;
	Mon, 26 May 2025 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQFkxSdp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F920C487
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748267664; cv=none; b=Yq3eRCSxrT0SJLd4tuG6TbBoRGTB2SDos8T7HQhr91737qeYrczQ6DN8fh/aOEEsiR1/roUA/6v/O+OBh9FbL/brzDxs93lWytOnrw9HbVvwdXBODTi1Vw9wsyOlfHfpKhalH+ADlLX0DEyjSOJ9YCoESnnOyFWOVpZa7bb4c0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748267664; c=relaxed/simple;
	bh=cm8VcAMTVaMfQQq25DP6H1KOaETEYG1SmJ2rmGO226g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itNfW6U0OIoejO0Ih3Jco2GPasjJ3q9/UFNt/4sQv3SImN5anA+mEQXgTQ25SRxSk6mKSuzZDaI4vFYPb+OgYR8SJreeD8V22o7Q7j6w9lsE4Y3evTBYgBuR4T4AD7s4raioDPJLPwsvGaA1veCZn/V1mqAdx0LDyiDdPq+HzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQFkxSdp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748267662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g40krMSI3KPVx/gkHC7ZBGvC36woERbrWjiZZaJNrhc=;
	b=dQFkxSdpAqqfkfciNIW97iC0qn265oXGN/pj9wZ2FhuWDQqTQrQ8FkywlCkkDfkQW7hiRC
	hKS6P8whjKOtEYmdrbZzlTPcvW57rEwqVIywNBoObUtx40I2aD5pw8VFQFpf8p+US1aARH
	CqIE6rNCyHwrtsM2N+AAlYgTEWqe5ug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-F9fSMiPkO8mXKOMEKYTNtQ-1; Mon, 26 May 2025 09:54:20 -0400
X-MC-Unique: F9fSMiPkO8mXKOMEKYTNtQ-1
X-Mimecast-MFC-AGG-ID: F9fSMiPkO8mXKOMEKYTNtQ_1748267659
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4cceb558aso903865f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748267659; x=1748872459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g40krMSI3KPVx/gkHC7ZBGvC36woERbrWjiZZaJNrhc=;
        b=CvVmcCpqdnW8TKNcCc+OG6Nehb8BTLhiepU8aR/zFVuzvrr+otCz4qGBW+VQhIjZQv
         Wzpxh1aeRWNQbBgVnsrD599B7pV9vA4f5pP72QjakHOM4VN1NJrGgL+Z0rjjJthg9rbB
         X5FWGhrdjBu1gqfoNIouVBS9s+OXMqWDeRgiDIyGTr9iBKeFMLZf0gZ2K7Oc8U3c7h7Q
         mlr+0ShldViUdKt55IN4DjAk8w8bt+HLSB0SJkeBOz2hiHWOuruVeeps3b2kk2knlQwx
         eP3wncaj6OlDnYOh42RJAiXYqigeMcd1sNsI1hH5DMBhdAHOK+aY8QDPQditCF0J/EJ7
         ueLw==
X-Forwarded-Encrypted: i=1; AJvYcCWSt1Rcd7LfZjZRgIvyexhGfmmtuCirAIhRpTQGJ1UH0n0RZT/FyVU55EJtSzaeidyV1tpbrCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEyJIMlKDfpdn7Km9tU4h5KJe/d5T8SRS9PraxwQkHCyo/OVQ
	CDWHrMu7egYkgFrTjGR/jt+sRwdD7VK3wbvxM5HZHc9FtuiV6863JObfnM2azFcDbpXr1803EYu
	Fue+GIruHJrd1+pyfnHFHoNC9xJXW1rAqxY9n+t5gsz0FtYD+3m3xZNwufi7YTSWj0CFB
X-Gm-Gg: ASbGncsOQXLJTrp0zmvEl3hLIC87xEC6XwDP2N8vPs/A5xlV0+fwBHyqHatbvo8h3mL
	e5nu9AN2pqZuwSFrk0LnqsFBVLjaUgYY1nNkHazjIhFvxGoYJkOziX7M7CAYFyzIAXUyAF47yNp
	3iQnUoAqAXHjqWUtyTqNLF9f8UR4RxV3Up5GL3f1KyMNOOVVBbmlPQURvZ/OIH2UHlcTCIl9TEr
	jocjwSThGSgpUgoREwCaIEdN51uibts06f6LSso0rQFCyy+rWjP1D0h6Ies7+Zf1HyhmXUJkzMY
	o21dhdUq9RcTEbZE8pA=
X-Received: by 2002:a5d:5848:0:b0:3a4:de27:e00f with SMTP id ffacd0b85a97d-3a4de27e06emr1531849f8f.7.1748267659273;
        Mon, 26 May 2025 06:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiG7FOfv6b9WqOpalfP4cWB+fgbGZlYPID5TImsza1uAaoWfWRUes4loK7bwCNhatMHGPwNg==
X-Received: by 2002:a5d:5848:0:b0:3a4:de27:e00f with SMTP id ffacd0b85a97d-3a4de27e06emr1531832f8f.7.1748267658891;
        Mon, 26 May 2025 06:54:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d9982c96sm2814709f8f.64.2025.05.26.06.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 06:54:18 -0700 (PDT)
Message-ID: <dab3eb18-dc98-45bf-a81a-56cec78eaac0@redhat.com>
Date: Mon, 26 May 2025 15:54:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: usb: aqc111: fix error handling of usbnet
 read calls
To: Andrew Lunn <andrew@lunn.ch>,
 Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org
References: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>
 <39e2951b-6e57-4003-b1c7-c68947f579be@lunn.ch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <39e2951b-6e57-4003-b1c7-c68947f579be@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 2:34 PM, Andrew Lunn wrote:
> On Tue, May 20, 2025 at 02:32:39PM +0300, Nikita Zhandarovich wrote:
>> Syzkaller, courtesy of syzbot, identified an error (see report [1]) in
>> aqc111 driver, caused by incomplete sanitation of usb read calls'
>> results. This problem is quite similar to the one fixed in commit
>> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
>>
>> For instance, usbnet_read_cmd() may read fewer than 'size' bytes,
>> even if the caller expected the full amount, and aqc111_read_cmd()
>> will not check its result properly. As [1] shows, this may lead
>> to MAC address in aqc111_bind() being only partly initialized,
>> triggering KMSAN warnings.
> 
> It looks like __ax88179_read_cmd() has the same issue? Please could
> you have a look around and see if more of the same problem exists.
> 
> Are there any use cases where usbnet_read_cmd() can actually return
> less than size and it not being an error? Maybe this check for ret !=
> size can be moved inside usbnet_read_cmd()?

Judging from __usbnet_read_cmd() implementation, it's actually expected
that such helper could return a partial copy. The centralized check
could possibly break some users, I think check the return value on a
per-device basis is safer.

Side note: the patch should have targeted the 'net' tree as the blamed
commit is present there, given we are now in the merge window and
net-next PR is somewhat upcoming, applying it to net-next will yield the
same result.

/P


