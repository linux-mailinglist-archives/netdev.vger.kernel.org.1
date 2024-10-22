Return-Path: <netdev+bounces-137846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFFC9AA113
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A155D1C2286A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39A119AA72;
	Tue, 22 Oct 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hcfw5+Do"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E7119ABBF
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596237; cv=none; b=PucAsWcfuHUGxJ7RK5YXcQn78aGAM0IVFvoQTt09bbFUlDXHkQn8kuLQQIgYwr41fRlDvXurCjiaLnFoft492I+QGbTDlpXzd5GUJUx08TPLOB+KcarWwHOQkYiP4uOS03EPyMFW5QKByz3uc9UefBh2ybm+A1mKmiLZqfsBpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596237; c=relaxed/simple;
	bh=0/KTaaJyBbcAWKlJjZS+HmyFWRq9tb52XGqNbB26q1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wp772hu88xRnXIs2n8p6lZxLrsXuqBE4Xq0NzEZ1e1JYuT7or+nrhOWKIBy5MgeyK8DlihZaTeEpeHbzsGXffUHbNiVcmSJrb1zI150FlLJnzWpsfl8Cic+c6XrNsSW8ltGWcRnLBfnD+S9GgVxs30gB/1J1t9X8vizvC/HLjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hcfw5+Do; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729596235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzDFvmcduq6o5UAjPvw5D86lQPAfvz+FZE4EB1pRWUM=;
	b=Hcfw5+DoITm3WgIOAbyGhW3iNy+nKQPCezhW7l+UBbUrtNX/1AL2bShgigCJ6wxdxZLxBR
	q2olIEHzOfTI0LOrXVWnCQXTWcRDBxwLqk0G5kHqsVtgnyCvOWCpwfym3KEOei1wOWdW/q
	Z/0TWTDDhFMxmLNq4BJ/DFmj4nXYmS8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-TbYHN9ZdPDOWBuGgqNOI8w-1; Tue, 22 Oct 2024 07:23:53 -0400
X-MC-Unique: TbYHN9ZdPDOWBuGgqNOI8w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43151a9ea95so32155175e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 04:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729596232; x=1730201032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzDFvmcduq6o5UAjPvw5D86lQPAfvz+FZE4EB1pRWUM=;
        b=fiOxZyBfdTrx6iv8VaK9bmO7B4kNvb06+r9D5x8vul8hdYZrGc5GIM/e0nB4jMggaa
         8UxtRpBFfQLr70rM8NSAGKKslRPagaf9V2mVqJoPQrk79MUz3pRfD1KkaqfGnIts20sO
         xyWJkw1CaGbGoIoHkldP4VT2b/+9iQMw6+Oc3/eLzuaEn3TcMcRVt6p6ji1wCYM1HKMa
         PxJDpw8zFG0IX/u0wbje4K8ivP2fwJDICz4k6r9n7sZ+XVsa7EgsYlc8NZSGbVsdMRkG
         lz0bpVyA4+YCPWY2YEhG5UBCA5zltwXslWNfWg6ipxe0gIHZYGjRPOy2EXznHcoWB+40
         2RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpQjzVy2Ia7VYNN3xlfiJberkxFjP+qETlKu8+E6vBycMFi3o4nFD+BJWwr7DH94E7AzljsAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkWv3A5/fZ2STjomJRa3rsOH6aW/Y2tC3WIbr/LJLy3MLMKUmD
	QR0xtnk0Cser3qesDybFOAmpYEPmrNOI3fcfqxLXG/KSn2XudwIVJlOl4hls7PzXj8jX1EX9Vgq
	OX+pdC1fCjZ3Pbv+jZ80x3lILVWazedzV6jnRc2h36F7vaV8iRn20Ag==
X-Received: by 2002:a05:600c:1d10:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4317beb1da3mr16291905e9.17.1729596232454;
        Tue, 22 Oct 2024 04:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEogZzW8W/aycQJ11eGnoB2NIpJ+Dvrva9EUYYQpmsOQ/KYiEpBTMCj5DRpYusimSWO5k5qMw==
X-Received: by 2002:a05:600c:1d10:b0:424:a7f1:ba2 with SMTP id 5b1f17b1804b1-4317beb1da3mr16291735e9.17.1729596231964;
        Tue, 22 Oct 2024 04:23:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a3650esm6465349f8f.4.2024.10.22.04.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 04:23:51 -0700 (PDT)
Message-ID: <68b06b79-d8fb-456d-9c21-b95087bde815@redhat.com>
Date: Tue, 22 Oct 2024 13:23:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
To: Simon Horman <horms@kernel.org>, Oliver Neukum <oneukum@suse.com>
Cc: edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 Greg Thelen <gthelen@google.com>, John Sperbeck <jsperbeck@google.com>
References: <20241017071849.389636-1-oneukum@suse.com>
 <20241017161110.GZ1697@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241017161110.GZ1697@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 18:11, Simon Horman wrote:
> On Thu, Oct 17, 2024 at 09:18:37AM +0200, Oliver Neukum wrote:
>> The fix for MAC addresses broke detection of the naming convention
>> because it gave network devices no random MAC before bind()
>> was called. This means that the check for the local assignment bit
>> was always negative as the address was zeroed from allocation,
>> instead of from overwriting the MAC with a unique hardware address.
>>
>> The correct check for whether bind() has altered the MAC is
>> done with is_zero_ether_addr
>>
>> Signed-off-by: Oliver Neukum <oneukum@suse.com>
>> Reported-by: Greg Thelen <gthelen@google.com>
>> Diagnosed-by: John Sperbeck <jsperbeck@google.com>
>> Fixes: bab8eb0dd4cb9 ("usbnet: modern method to get random MAC")
> 
> I accidently provided my feedback in response to an earlier version [1]
> https://lore.kernel.org/all/20241017134413.GL1697@kernel.org/
> 
> It is:
> 
> I think works for the case where a random address will be assigned
> as per the cited commit. But I'm unsure that is correct wrt
> to the case where ->bind assigns an address with 0x2 set in the 0th octet.
> 
> Can that occur in practice? Perhaps not because the driver would
> rely on usbnet_probe() to set a random address. But if so then
> it would previously have hit the "eth%d" logic, but does not anymore.

My understanding is that the naming detection is 'best effort' and the
current logic fails 100% of times, so this looks a worthy improvement no
matter what.

Cheers,

Paolo


