Return-Path: <netdev+bounces-221174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5054B4AB96
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 13:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23A74E1892
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 11:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4412C235F;
	Tue,  9 Sep 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="d59YAnra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12531CA4C
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416647; cv=none; b=MoU8XnXprDtI5WcFvO/KEhE+hz45aw36h3xXzt6Tg+VOpaZzB2hsxb9OyZf3WyuVWn+rc1pRmmIzfX+SuFZkc/hhcccOPsEY0ctpvgDFzDBQScH4CN+y0okZ13i4EfNjd1QEzzxMeagtKppt81laTNJ6MkleBVzoPn6172ihtgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416647; c=relaxed/simple;
	bh=/Ki85/UUF2HARjWBX628WZfq0M6PY2jLPYKMfphCGo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAIAtxdLcQlAcqzYbmRfZcf4XZPhc4jun3Hmm9JGavyfEEV52sq4QnKqbK9zAHz8bE9AqOz54Yu67XF5Iya/PNHYL+gaBdH7EosVQL0R79E92VeA/ylU8h0zdQmUv7ggEuMyQeg87XbCDYwaojhMTGwsi1I6gn07eX7c7nt9L+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=d59YAnra; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b042cc3954fso923839466b.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1757416643; x=1758021443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QIT8bDT5cuH1Mqs5DCizrQUzPvHzQNsppM2R92YaOao=;
        b=d59YAnraADyYD954eli2fqN4XNa7uTAu3vLCJ2y+b83qwhX542i6Cktm8OGHf/nJrk
         aP2PqTlR/nIGi1iSq7JJ3kjXmLYQbeGAEzfpFQFh8Jf52G4PIt2zQLTlhA21JroMqzkp
         pvZRwBk4My/P9t2u54RKqj9rrY0ZVp2z/2lM1823LtKhbfkLV0LwctTZpRNeR0C33Vb/
         YM+JYLZe0l9KZ4VEGtE2dfaNrzEknXtFUq622XD3ALpE0I5AIabcIShPFC6jKv582ZXA
         H8zMpL6CydzoA6bRkPkPkgs3lobC/a5GAeutkG7BwlaAffhbF0DAJ/1vf3CL7TEvpGXV
         uz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757416643; x=1758021443;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIT8bDT5cuH1Mqs5DCizrQUzPvHzQNsppM2R92YaOao=;
        b=UJyNdV9SV4a/oNe9Fbs4+xM0QbLJ4r3qgheiX3yV8VSrnt/011YxFZeXLch8jXqLxs
         8KovIeKJu16+PORVkPfFloGvvX9kq24U5I9N/ox1VvRAd6S7ffTlBNGdrq7S8RHAsCXI
         rZpcyvh4jN7baJVbCYi1f/CuArWP038BnYhERyJjuUbcHn0ClioJKmNW/lFbJX4k+Ezs
         rgCIPdfUfzwvOIrPYILf4XzFlzY1aUwVzXBivfc+olQJ+9LYOm4QlGFDMQ+3F34NfKjv
         97ZZzIMx0jUEfRwy+GcrKr1KSxwGYe5uURL2c0VkotYwaTtWDUeuyNoHH9IjS3p3kcEr
         WkRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYSSolvS1nDmshyjBRHRpAVGGGvYqrjLd4rFgB8R3A1iXGJ6U7EzPMUJkF+aXYhULq4cs1ouo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcwkWhg4T6Tjfafqhz9hGqy9Z+c4uijAf7h/gF+FaFRRlCoWU
	PJaRemhIjSbLPkPJLLcwc9q1M+TDKRPlTRi9PENNZEFA5Y1lDtVSKx9zU8nSkZrPJirp1mluLEu
	giD18ztPgOa7Lr/Uxv03vQvLtwZsqjW96pf+j6nZKdeJNESiPqTiT+MGi7y8YNR/o
X-Gm-Gg: ASbGncun61ju4MM9SrgswVSjbLRwo+UX93KebdS2iJOixuJPmNsTVsVogpXyDLefLHN
	wk+b/8fp8hU3gHS0bZHLupB0qGgKq+UjkRmZ6CJBIuxaftgXL7dYF7qen6n/xxMvwz02foQ4he+
	H+F+KW+exQg8zdovJ1rY3+mil0j9Bg2tY85KODaKqSqT9vQ8vTk56IUJHLQoAYHQMtQYVuU79bO
	Q6YSPrR68k8RBLpspq0ZU7JyhHuXnIufnw3hnpB02ib9HG/8QoPBDnnqyzdYazrRLV5rOMM8jLF
	btB1R24jN1FZjo/Xylr1/IKQpzjU1R+J8VGCgZCp3mEos8tDUmERd47txKuvm8csCkDnI5C0x5q
	SMKSYvkPheJ1oi1rjnlkFr2xY++URbN6aXa/CMUg3aC5fO++xJTBs6nzLe4zOpv4GoGaKtTw=
X-Google-Smtp-Source: AGHT+IH9YAHcLl9lnvX2v0Irba20/4jvN77dI3OZFxZn/ThSrUVaR+LS2anSJTG3qYJuJOB/2a34kg==
X-Received: by 2002:a17:907:6e92:b0:b04:54dc:3048 with SMTP id a640c23a62f3a-b04b148f4damr1121912366b.21.1757416642059;
        Tue, 09 Sep 2025 04:17:22 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:2565:e44e:f9fc:733f? ([2001:67c:2fbc:1:2565:e44e:f9fc:733f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff138a8c1dsm2551579666b.99.2025.09.09.04.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:17:21 -0700 (PDT)
Message-ID: <b8b604f7-c5c3-4257-93da-8f6881e96fe4@openvpn.net>
Date: Tue, 9 Sep 2025 13:17:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: tunnel: introduce noref xmit flows for
 tunnels
To: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org
Cc: openvpn-devel@lists.sourceforge.net
References: <20250909054333.12572-1-mmietus97.ref@yahoo.com>
 <20250909054333.12572-1-mmietus97@yahoo.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250909054333.12572-1-mmietus97@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2025 07:43, Marek Mietus wrote:
> Currently, all xmit flows use dst_cache in a way that references
> its dst_entry for each xmitted packet. These atomic operations
> are redundant in some flows.

Can you elaborate on the current limits/drawbacks and explain what we 
gain with this new approach?

It may be obvious for some, but it's not for me.

Also it sounded as if more tunnels were affected, but in the end only 
ovpn is being changed.
Does it mean all other tunnels don't need this?


Regards,

> 
> This patchset introduces new noref xmit helpers, and incorporates
> them in the OpenVPN driver.

-- 
Antonio Quartulli
OpenVPN Inc.


