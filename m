Return-Path: <netdev+bounces-188359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFDAAC76B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D3D522081
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3028135C;
	Tue,  6 May 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vg0x5+8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F85281374
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540342; cv=none; b=Wa2O39ZJOA1cmoTUPKpdTQPczsQNwOwxUpHgetWY3OA4ymf+5es/iZWuc/TxPCAprEVLhFmmINSBvfftogFRxaKzwWXo2QMRdB6A7qoq2leVEX4hc6Cq0FYwR1oIgpgpnGsE/pThncItdL2p42566aHDXo2mztbEWZ+plcPGUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540342; c=relaxed/simple;
	bh=m8P3EWoP+kX/U0WepN2nEPt3XqQjeb7/cDgQjDBrta4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xpj7oconiF2ZYX+VBTshr9jJ5tPudEpQJ/lHKMVK6JTmqvnVU6d2aqqz5KWo+bKQIqjOmhAPN7lQiV7xnp35I3RVMFNA2RPnmkuOKGziK3eDvqtb3D5+zstOI/c4QQikWqEOtNsSe2LuDnjOZxnWI85ua3AYl5Z/pK4qJb/2Omk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vg0x5+8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746540340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmkgEe/zoJIW9iTJvHF7KhR3zOP9cgU3gMh4xjoUmmI=;
	b=Vg0x5+8JxGRt3jO5BgfsmmoIwOoaMB6upixQfWK4e/x9r92pwAx1tqVxShte4ZKgJVCAsL
	SfU4QD6b1yob7DDQ8YddfWf4g+Sxq1NCcjujDvUDV8oMsoFLScIJMbXo3x5Q56USy9zpMm
	Y/WFb1v9AhvpeHCeXXJtrXlqgQGoj1M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-CtN-fxR9NR29vZNL5xAtsA-1; Tue, 06 May 2025 10:05:38 -0400
X-MC-Unique: CtN-fxR9NR29vZNL5xAtsA-1
X-Mimecast-MFC-AGG-ID: CtN-fxR9NR29vZNL5xAtsA_1746540338
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so31036355e9.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 07:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746540337; x=1747145137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LmkgEe/zoJIW9iTJvHF7KhR3zOP9cgU3gMh4xjoUmmI=;
        b=VilSFY8at1ylqDxQrtFRaPi/vdbtaZaZ2HRHlbVZjBrM1TD6aB4/tjhoINvaMrz89e
         tkmCPfQ8uQCt1719h06d+BbTCtBhrTOsu9g3EWWkjFqDiKiwZ+2ZvWGW1tQmRuyeurAR
         ncVpgY2KmYSho/1sSYewU9dpZtpneu7vlfDw+AhbZ5W1SXk6u6MQ1F4kF2/Z/1b0pL9V
         xc26QKezPr/g023MHdT6rhnjBsqJ7YuS/133uq4soIq0wAkPoOzy/aLOEDJqUNyax2+b
         9PjZzFXIEGirP15mY/rv92rC4CBrW4kFP2Z6tReyhNvFRufzpAAsbXLm/MhvI9ynjBJA
         70Yw==
X-Forwarded-Encrypted: i=1; AJvYcCV13NcGEOPQs2fQOtRUVncrjTCiZQzdEQ/mOUFnkJgiiMFcoVP/ZV2fCYRDwYsuG9oPcMQQiXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLGyNDik7qtboX0RnJaIOC3ncmb6iMQDLmBiXRFcvCbBCmrxH
	jITDHJIKhzMO0SZfDNGUAtxifSgsffnfnBkPObmgOuBZPMro0aM6M3Ufal4rBUD2UYrsgTLEI+I
	rxCAOeA8s1ElMnRUqXpNhq97/ZA7VGU72uHiTAQ1z0kDDP7hNZk+44g==
X-Gm-Gg: ASbGncuxrpxJbJISpZXHnCy+oPmhj6AhLYydndyegc2WCKHtgFQQtxaK0dwJzO/WCTe
	d5Pvsy34ahOQswi2IATQyPy5tVEHN+tMhjWIOBm9EhitVvGZ7eiZhIVxxZf9oH5ltB1DSeTWcrS
	9a+gVRs3vJxvRnrVWIoI4WDkuBRue4OkpWh/BPcBCtUrcqHLKp41Hy+YeiBx1QavQXrDL+tR+qN
	mDC8APosvayMHDdrTQfUUWnG6lrmHlyomvrvGSOykQJLeEq8cnnMs33pv24UY9JUMMNknYPQUva
	ZZlic6+nRdyPn8kPzho=
X-Received: by 2002:a05:600c:1e88:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-441c48bdf64mr92711165e9.13.1746540337498;
        Tue, 06 May 2025 07:05:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGepUjD22eYZierzyRzl6XCS1oXxMDWQze4ovAhd3moHpY1dHJBLieoYu1kCE54P4rlPKFjgw==
X-Received: by 2002:a05:600c:1e88:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-441c48bdf64mr92710485e9.13.1746540336892;
        Tue, 06 May 2025 07:05:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010::f39? ([2a0d:3344:2706:e010::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc469sm173068965e9.6.2025.05.06.07.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:05:36 -0700 (PDT)
Message-ID: <a6b82986-52df-4d51-b854-a2eb5842a574@redhat.com>
Date: Tue, 6 May 2025 16:05:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 08/15] net: homa: create homa_pacer.h and
 homa_pacer.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-9-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-9-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
> +	/**
> +	 * @link_mbps: The raw bandwidth of the network uplink, in
> +	 * units of 1e06 bits per second.  Set externally via sysctl.
> +	 */
> +	int link_mbps;

This is will be extremely problematic. In practice nobody will set this
correctly and in some cases the info is not even available (VM) or will
change dynamically due to policing/shaping.

I think you need to build your own estimator of the available B/W. I'm
unsure/I don't think you can re-use bql info here.

/P


