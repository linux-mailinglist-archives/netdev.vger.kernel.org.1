Return-Path: <netdev+bounces-192740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2B3AC0FEA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 17:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4AF4E0955
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17A8298269;
	Thu, 22 May 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQQFeJVB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FC291144
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927604; cv=none; b=jEVkGVYprsyYZ4xSyLAlJzcv62AdMoikylzOvo5FWs9ufhVu3UOkWm8cMbyiNdwKNSg6blNZpSwMUOOS/WY8FGgD5aVy6ZaJ0s+GvnErf1LsyP+NPW36+5UHRThUGcrumKAEfmjK0mQTYqaTPVTujhCAzFtK0bYk98lCqZiecE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927604; c=relaxed/simple;
	bh=nPc1417pQBcgRqh7CMbuBPfBmsXTlRhlovCuTATIAEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qlCbBbHv2gdWZLwfx1BkQIbUTE+o9jkYR90Joasaj+GTmWPf2yKKGlXQ9PpQG5gyq+eZ+ASWgjzTZnNiAA4As6xAFwqTeTWTLvCoJ85nxBcHSB8Su9DRk3UK4lRQrNWZCX4dC5/sOIgTshOqWYe9/oCU5fGxFWvZfbtAPL92UiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQQFeJVB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747927601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mvu+OwsadrnbjwrD0fW0TeWbt90v2o9EJNf+xZw3UFs=;
	b=EQQFeJVBUVL0B1iFJ+8x9EhnqnJTAV9exOHTHjkbfMRji/AfQof6tuOtGVoNSnins5fTS4
	F0Feses4VjZ8qxZOh3rU1kzRhJ/PyCkTthGyQpk/YbnxtvWUChbkxnam3ZwCAY8nwbKuUx
	RvQzHRltHo7hzwO+nV39ogJxvUawEO4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-_Jl7nCQpO-aQoeZAyIQCxQ-1; Thu, 22 May 2025 11:26:39 -0400
X-MC-Unique: _Jl7nCQpO-aQoeZAyIQCxQ-1
X-Mimecast-MFC-AGG-ID: _Jl7nCQpO-aQoeZAyIQCxQ_1747927598
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a35989e5b2so5111066f8f.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927598; x=1748532398;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mvu+OwsadrnbjwrD0fW0TeWbt90v2o9EJNf+xZw3UFs=;
        b=kNLpQqOPuJGNflTJxhsUm8Rrm+6+SAXatpM85rHK4ywaBT/GKHeqR+XkOENREAXFj8
         CWi8hgV9YiobxRXKVqo9rGXxhRkC13v76u1U8P/RWzNgKkAIm0gk50VEsoUZ01suZrOi
         d2LWmiu4DlKVBwIFnX0obVSPessVgtFJgf8yfjWbQWUIasfh7FlBefg8HoUhr5Y1laEn
         DTrBiX5005ohp+aEzTihPiED3tpibyAoEKGfSCH9lRCTURaLXeu2ZO7w57pXtoKdqcbl
         dmCkWMYBaf2eRtPwFlP6l38yQat3IwW6/vWYJVW/bdtTE3rePqciz95ApUAPCkbujr9E
         WmmQ==
X-Gm-Message-State: AOJu0Yz6YmyjJP6nN5jMC42Ew2j3Qcv5dRZWsmUmR5lR/9Qy7E7GmWRb
	nOHlzlYeNKqnNGzFzdSH5E+HKLKnPm3L0XeDXyDpNTgIaSRJAcYKBZDg/hQZF0hmnRzrD+7EdP/
	x1lsP15AoM4HtGInTddH0qupAcE1CEYpn82cPPmtcGr0NpmLDy7BV0ykJCA==
X-Gm-Gg: ASbGncu6lrSDgQGxb44aw1teSsLEzHU5i/t30rKudCwu7J+pEbC3TFIIpEcNYNjL2Sl
	Vx8X93DwNWI03AmmPIMvvBV5CF1oNmgsznvEL9UAlateeV0gJXgaccJSdHYir7Gk9rGi/rCp9hf
	ma9+p4WQS3ffxwtFLsbP9Qt5FkG2/EpLXIy/E18JF+0bgX8BENPLZRb3S33gqe6O8bPPkBYizBI
	rM/xw0WAU51M0oOPUTa4YPA/S8y445K2AoRyKAlCEOQKmgxIviLtV573bpCJhb/NVEmXqTwzayj
	p5LGRYrpcZIkG3/2448=
X-Received: by 2002:a05:6000:2211:b0:3a3:6e62:d8e5 with SMTP id ffacd0b85a97d-3a36e62db78mr14328552f8f.53.1747927598212;
        Thu, 22 May 2025 08:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/hWWV68SjsQ5WocyIj9DLCq8lm8csLMUR/niSXIeugec3ABfUP1etJPL5j8vuP2Nlv/klEA==
X-Received: by 2002:a05:6000:2211:b0:3a3:6e62:d8e5 with SMTP id ffacd0b85a97d-3a36e62db78mr14328517f8f.53.1747927597757;
        Thu, 22 May 2025 08:26:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a8c4sm23197536f8f.27.2025.05.22.08.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 08:26:37 -0700 (PDT)
Message-ID: <d85926bf-ad6b-4898-9c12-693ee185f3d6@redhat.com>
Date: Thu, 22 May 2025 17:26:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
From: Paolo Abeni <pabeni@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <20250521115217-mutt-send-email-mst@kernel.org>
 <fa55e26b-54f7-400f-88f7-530f3a95a0e9@redhat.com>
Content-Language: en-US
In-Reply-To: <fa55e26b-54f7-400f-88f7-530f3a95a0e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 9:29 AM, Paolo Abeni wrote:
> On 5/21/25 6:02 PM, Michael S. Tsirkin wrote:
>> On Wed, May 21, 2025 at 12:32:35PM +0200, Paolo Abeni wrote:
>>> +++ b/include/linux/virtio_features.h
>>> @@ -0,0 +1,23 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef _LINUX_VIRTIO_FEATURES_H
>>> +#define _LINUX_VIRTIO_FEATURES_H
>>> +
>>> +#include <linux/bits.h>
>>> +
>>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
>>> +#define VIRTIO_HAS_EXTENDED_FEATURES
>>> +#define VIRTIO_FEATURES_MAX	128
>>> +#define VIRTIO_FEATURES_WORDS	4
>>> +#define VIRTIO_BIT(b)		_BIT128(b)
>>> +
>>> +typedef __uint128_t		virtio_features_t;
>>
>> Since we are doing it anyway, what about __bitwise ?
> 
> Yep, I will add it in the next revision.

Uhm... this is actually problematic, as a key point of keeping the
diffstat manageable is converting only the relevant drivers to use the
extended features set - and adjust accordingly local variables and
expressions.

The above means that in other devices a lot of code relies on extended
features being (harmlessly, because nobody is going to set the highest
bits for such features) downgraded to u64, or u64 promoted to
virtio_features_t.

The __bitwise annotation generates warning for each of them; avoiding
that warning require touching the same code I wanted to leave unmodified
(and bring back a terrible diffstat).

/P


