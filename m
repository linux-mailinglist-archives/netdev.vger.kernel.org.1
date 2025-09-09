Return-Path: <netdev+bounces-221167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B0B4AACE
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 12:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0D51888625
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 10:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E462D73A7;
	Tue,  9 Sep 2025 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyZpiP4Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6853242D93
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414154; cv=none; b=kF3QfuuQ3T32Zsmx6BWZCo0Y7fIaVdHuckQyUIU9Tun0lwzTW0AAYgX70wnZxBpAsVu62E58URnROFUXdpYcH25P+v/RvYCQ1X/Rl1+/FbaJgj1VUT1e5kvPeerpvzqMLTGrw3Mmprhgsgsub4TSw/VFU5hPwwmBR8K1czQuZ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414154; c=relaxed/simple;
	bh=jXzv9iCGp3BL8Y5WtKFZfKQOrd9Gg4g0fNzVnx7sU3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rE1hMwekXkHo3OlEYsIkFateIPhdJyROv17Olnza8xCyJtC3yKpLe4Fc1I3pSI6c59FgBtSaxQ+eGnze2MC8zcgSmkoFQ+q+lqmYvbi7kOgKDBG6ACU8ChJu9qYwqZO5jD9rhHRHme0ZRMYrH9viX70J8Q2pP4HlxAYMyjIboC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyZpiP4Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757414151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hcq5eJSCSrjCKibAj2Df80bFB10pidDrkH3C2Ui1bf4=;
	b=TyZpiP4QKU4Z/f2cA32fTVs9aufbjyOmDdOTk18UfgLfftppgkUksk+fzJUTQjaYTTQZ4R
	Fyk6DSjjUIZvfEy1FCKUbHZkNvzmedv46jBcSFn97gK8wYRT/K440dcTMrilFX9Imus+tF
	pWO6HuBhuBml2QmChvpar+lLG0aFHiY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-_aafA0hiMfe-V8-HCFVHUQ-1; Tue, 09 Sep 2025 06:35:50 -0400
X-MC-Unique: _aafA0hiMfe-V8-HCFVHUQ-1
X-Mimecast-MFC-AGG-ID: _aafA0hiMfe-V8-HCFVHUQ_1757414149
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3e014bf8ebfso3138980f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 03:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757414149; x=1758018949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hcq5eJSCSrjCKibAj2Df80bFB10pidDrkH3C2Ui1bf4=;
        b=bX5SHitLNjRbXK+gkyjkG/y2yPcSLxE43/J/uoWXnXKofJu/Inkt2SgyfKG1oZAHwg
         v8p+kXeUocN4ZnQdSHiTvrQ4wy2QWmqWgc8RyJQYMzqIwqQVTPeIncFIHst8xE8nCl42
         S1EkH6Dpag9ioXqGOvbna/aymeY9A9jsBvAnxtvxFVS+BnO1/m8s8ce0tmRH9gTZdm6N
         VeCBnnFN0cUuSqVw37lRDYeXQWybGW1ZDuYd40A7zOMtls/2NrJ235wdvERs8sp8VqhH
         q6mwcj1Kipsvxs3/n0RX0QATnezYB6wLVDpIspqcUTyVd4C/XOLyn7mXlwRuqhys+o0S
         C67g==
X-Forwarded-Encrypted: i=1; AJvYcCUeN6Qrc9NGsmdQsPIsqS1OoJUONbRf95UPMzFtjIQc7xLRAsCXVxjsqMHDfcSmhiNaKCC/1O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFypkKrXjkLfhcaHH2cJc7Vw6BPm/+eoR9TkJJtbkXkE/BOO+v
	ZOAobzk9xKqDPIk7DXiljIk7kAKr75AVilWxbZqPZ3GmC0g3cTGDKJr/bjb5cTAS1ENrGdm7Llz
	YxNY4C3z8BKZk1+OaUG9BbHjwMRPYHRg9whWkB9RRMPUweriZT+e26AzFMw==
X-Gm-Gg: ASbGncvsykodpBl0zBgGgmWRlQ4/yMYnJe9ICOWGuziMQA3rDRsjrRFWRafR1caeU6x
	40MntppUH95XHVIzIiM7yF8wwZ2zLY5ToyCvuASeBH28VnGQTYJeDr8/8D/9oHWXzfqSWAez1w3
	pQtuygvroP+LEGBRUro39CJc1ArVTXrkRtlY+KRzmmFWVmCO1wmXdRapgOWRmk3q+2bkgK7IlTm
	JpNk/wtEj7kYbQHyjjh/wMG4AcHt11PqeCvxtlIz6YpAGR55vkE31GOkzcPSeKbyywn/L6zh3vc
	YU+9WHFhUUXz5Ws6uMqE+c2SRmmnPpEhIlZ2ir3qhsZMrrqQnCim3aaqcnaciTY9kuTGU/8xqFV
	dZ84ILRa7tXw=
X-Received: by 2002:a5d:5f42:0:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3e2fa64c720mr14413370f8f.0.1757414149018;
        Tue, 09 Sep 2025 03:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGrFPUq1e+l+KDZXb55Z+P5p7wP8w31cGiVGtf+1tnvj/A13Xo8l0XSiIZ6DWfdHjx5QJgTA==
X-Received: by 2002:a5d:5f42:0:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3e2fa64c720mr14413349f8f.0.1757414148634;
        Tue, 09 Sep 2025 03:35:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm32939185e9.23.2025.09.09.03.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 03:35:48 -0700 (PDT)
Message-ID: <c649a695-caeb-4c20-b983-9035c396e145@redhat.com>
Date: Tue, 9 Sep 2025 12:35:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: networking: can: change bcm_msg_head frames
 member to support flexible array
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 Alex Tran <alex.t.tran@gmail.com>
Cc: mkl@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904031709.1426895-1-alex.t.tran@gmail.com>
 <a7c707b7-61e1-4c40-8708-f3331da96d34@hartkopp.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a7c707b7-61e1-4c40-8708-f3331da96d34@hartkopp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/25 8:25 AM, Oliver Hartkopp wrote:
> On 04.09.25 05:17, Alex Tran wrote:
>> The documentation of the 'bcm_msg_head' struct does not match how
>> it is defined in 'bcm.h'. Changed the frames member to a flexible array,
>> matching the definition in the header file.
>>
>> See commit 94dfc73e7cf4 ("treewide: uapi: Replace zero-length arrays with
>> flexible-array members")
>>
>> Bug 217783 <https://bugzilla.kernel.org/show_bug.cgi?id=217783>
>>
>> Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> 
> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

@Mark, @Oliver: I assume you want us to apply this patch directly to the
net tree, am I correct?

If so, @Alex: please use a formal 'Fixes:' tag for the blamed commit and
'Link: to reference the bz entry, thanks!

Paolo


