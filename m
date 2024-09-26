Return-Path: <netdev+bounces-129929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E98298710F
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EE028735A
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC981AB6F6;
	Thu, 26 Sep 2024 10:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ8pIUa5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103317BB30
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345691; cv=none; b=WBLi+yxJxRMdV6qjk+qwq4PlCUC5zCyQFZTh+95hCwy0tPJCFswV6qrci+57TAynEEXiYVFZdG5ut/aZRHswcQkKNEzu9SSyo3RI+ittjdwtkT/KbaEKPbW/+vnlpkbNIA9ASt4b6fixODxF/Y0COfWEO0hdLl7uafzi62CeZYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345691; c=relaxed/simple;
	bh=WP2pqg2XGT2RRxkBuRfwbWvSPbLpXlRh+T6L24H7DGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NBX/gXds3ZMQdICHJbxHRxMN0ddI+WqMJw+d/I9m32Q9aX2CBF+r24na7GePgTaYrN9F7VU/9ypGv85cj2MaB/ULwxmaKtCMPKCnrHoWETx/d4TQQ3qT1q+QTDsHO6mfcCM926UT8d75n+tZm6pWfjsERGvTeniYPUBtk5RWmvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZ8pIUa5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727345688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6HA6osz3/tvzNq8SJI+S2bTwMdosXneQAdRrwNfyC8=;
	b=OZ8pIUa5hlJrTHthIpVn66WwbuZcTZahhzhRmVywkwOTGeb2gVkqjdVDNYX7z6ih1/l4mi
	oKcn5N9sWgNsU/Z3Z6/kb2Ry6mOh5ThA6jNE4QRaAzrWJFohA8uphCOGCiXE91ySwD+c0d
	fg9Kbpj22kr1G1RS0+CViiZScuw7Y1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-jJLSajvSPr6eXdRTipRKyA-1; Thu, 26 Sep 2024 06:14:47 -0400
X-MC-Unique: jJLSajvSPr6eXdRTipRKyA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so8591135e9.0
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 03:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727345686; x=1727950486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M6HA6osz3/tvzNq8SJI+S2bTwMdosXneQAdRrwNfyC8=;
        b=RqGqPcfMOrTg3o/YMWq8kvO1YtNhwBHimVTAB6sGQ2zq07FwK+GYwbLui4hBrBsg6H
         IG+CRPl9F8BOrIMmbySBtt7Jh0zc6rAgGgzgW907x9I1tbbr4IEMnj/DrClMwxSrm52g
         F3z6sk3C3cCRyOjigt2bnSIPzI1oL+f/HvAW7hGBUcwSdY++IAqIuQ/oG7j5AO92/r/w
         tADBhsV0DtYeqsdGKJ+5Ca3q/NdbNcULDImWm4bzOBVCzC7S6lglg2bwzz+HpP2NbmK1
         0sJ+LkdPEhKvxb5PWHaKrSh6L4L8CmajgKQRj1h73R4jBT0oNEXDkYChgfLJwa44QXfE
         vD8A==
X-Forwarded-Encrypted: i=1; AJvYcCVfWoYc+M7C4Gyn4IEPHmtVK3YUipYYbN6ySGMCZ0XWygd5ij0Oi4dxnS/YSs0QBv5c81UFtpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5cTyv/eUcmRdg+yC3EiC1IrV7F9g8WwwUTYKwyv1StCTHrlm
	HIbWrLq73IlohYQqEwRuGsX9RLzBpg5KTP3HC36L4d1yAuTkQcDgALszDajbbENRMP/wmh9yGXO
	QqH10hOIhBIwX57g00RzT6OnS8XgZDcioCzgAVJLufht3JflDwSk4PA==
X-Received: by 2002:a05:600c:314f:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-42f521cb8bbmr15308755e9.1.1727345686391;
        Thu, 26 Sep 2024 03:14:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELnFAnpPKbuQqh3tr9qF593fQvuCTSrGIm4M6e28riy7R6x0Zgq0yI19kgY3gMxfyRiaDGJw==
X-Received: by 2002:a05:600c:314f:b0:426:63bc:f031 with SMTP id 5b1f17b1804b1-42f521cb8bbmr15308615e9.1.1727345685994;
        Thu, 26 Sep 2024 03:14:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a168bdsm42792695e9.37.2024.09.26.03.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 03:14:45 -0700 (PDT)
Message-ID: <17c1c03a-1703-44e2-b586-01be0f86c0f7@redhat.com>
Date: Thu, 26 Sep 2024 12:14:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: expose __sock_sendmsg() symbol
To: Sahand Evs <sahandevs@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: Jordan Rife <jrife@google.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
References: <20240923170322.535940-1-sahandevs@gmail.com>
 <CADKFtnS7JRHz1eg8M3V52MAcJUW3bVch2siaoqQSqMPW7ZrfUg@mail.gmail.com>
 <CANn89i+asgFpSSAxavvLe22TW897VaEdyYzMJ_s0JpH+2_RzUA@mail.gmail.com>
 <93d71681-1a3e-4802-a95b-4156fa3847fb@gmail.com>
 <CANn89i+PnFohFa3Q0DhcVS129u8NVbtnNkUvgCFRKocgP2Ekrw@mail.gmail.com>
 <CAEhU8Zy09JLHhiAbPw+es4Pp6Xumg5DrDaNv=jfNvGvuReOnbA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAEhU8Zy09JLHhiAbPw+es4Pp6Xumg5DrDaNv=jfNvGvuReOnbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 21:36, Sahand Evs wrote:
> On Mon, Sep 23, 2024 at 10:30 PM Eric Dumazet <edumazet@google.com> wrote:
>> Convention on netdev mailing list is to not top post.
>>
>> Removing the static is not enough, a compiler and linker can
>> completely inline / delete this function.
>>
>> Anyway, I do not think sock_sendmsg() was part of any ABI.

[...]

>> Removing the static is not enough
> Should I also add a EXPORT_SYMBOL?

No, the relevant part is that the kernel don't guarantee 
__sock_sendmsg()/sock_sendmsg() being constant (or present) across 
different kernel versions (it's not part of any uAPI/ABI contract)

The user-space has to cope with that, trying to attach to different 
function, according to what is available and visible. Possibly you don't 
see __sock_sendmsg because you don't have the kernel debug infos 
available. Try install them for the running kernel.

Cheers,

Paolo


