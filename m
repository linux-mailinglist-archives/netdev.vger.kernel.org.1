Return-Path: <netdev+bounces-97494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57A8CBAAF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 07:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FE928301F
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 05:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6071EB2C;
	Wed, 22 May 2024 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScWb5upx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B321103;
	Wed, 22 May 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356109; cv=none; b=pDYElhrt6VelaQvf/aZHtuOd5xqQzK7ZPd6Zil9tuJbouzc+8JgzeDxJE1gNHCS2lg+D9aXLt8pwOWDETGaX7DOjhZO5MTXItMwI2lpojtImIKllQWK278mcjn4ysPREynRiQ2MUeB9z3cTCv/UVKUTbS3Jgv6/htMfNGlNjMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356109; c=relaxed/simple;
	bh=IeIDVNL0556RdHCQpN6cPx4tg7Y+U1PylG3a1OAcmJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXT6bzpLjhbOS+DgonGwko0V0ZymQ0XcDsPUdo4bfQwLd9CTrnSnq8KrXHWNOwhSXZVSdZkejGntAAIOWsH286dSw9JWThqROZK6ed+Eh9ZaEMLT8XQPoo6JktJFFB6Jd7w/TlOsj0dT84du27L5I+Xx6m3n2NZAw/HaP9M3t9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScWb5upx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b59b7so3659825e9.0;
        Tue, 21 May 2024 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716356107; x=1716960907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hnqQb7U4e4IijacHkvjFFWOyOsyI3cgB/ooNZw5ifrU=;
        b=ScWb5upx1ixoQioeXw53A/M3bRhdyYG+s0FQOTx9QPOZSTsEZVUNkaPLQx8gWOGYvZ
         Hl2y7Uyu0Q5xaK1zxEEFbUqOJneh+z0fb2TSA4zbPjIugw24kyjr6aTknUTQzsNYQo4R
         2gyArX17YrEZBBZ0gF1XbNMAmwQQS5yZOkD0WKxUkvL5yOkkKsrFz6N6BzK6NtDSeL3w
         ilVukoFJ2Muo75URQOEIuzdeyS9igZjLulBLj3IEBcL+mhcSNF81H8c2kHDENQ+Ypedj
         VWJudY0/1HFSmBCJjdLLoa+W6iiLcXnQ/yTpaPVZB8zExFdAGf61TNT5ezNB4b0IZCZw
         S3Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716356107; x=1716960907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnqQb7U4e4IijacHkvjFFWOyOsyI3cgB/ooNZw5ifrU=;
        b=OaW1YU4Lmfzfc0eM5CxHZuXXcgKLj1xQpVyzwql72N0nSrawa8sClbGMCP2hvmFLfg
         W2cr3QX3ccwB7QhDFyXAqN0gQlFhcBdUeHMTID11I0E/qpT99JMegRut3L8PlUMv+Tnq
         6YvBI+iL1YLgxc8UA+obiTRyZ+ZjAnao9lhNrS/tF4IyNVFyIJW20xXbqOTgOWhm6Ki4
         XzQlVzRtYmnDD+4xTNmpX2IN8Oe0yNTvr5kif+zNZsp6JF9REQMFbWIq7ek7MpNvY7jN
         gHV7KKVLaD39yKF+AFQ03niF5Yp9k9bjznP12odOCQQycW2ertLhWH9RwGHd29UYLowd
         2gyw==
X-Forwarded-Encrypted: i=1; AJvYcCVepwh48Qm8UxdE2C5SUSzcHc/uAZX6NLDxyLipD7Xm3ecuZ4fjJRTX3nJrGGREobLCkGvKbFwJVQ9GjSzSLaoULIvbyNMZaDDS2h8nbiMkn7rfaARyp0VcRCE1Gn4nKXqwCLkW
X-Gm-Message-State: AOJu0Yw+y1OEQIoSdB/BE5chFttdXXAEiXJFmsPGMxzbhPBTPN6Jdr3z
	Zxt/VPVLaFFBlFh2Nw3Hv29L4x+uWLIA+dhk26KANfTcnDXYNuO1
X-Google-Smtp-Source: AGHT+IHs6ItXVDo4qBIwoQzgmUjLFR4UNqssRmD39BcGlIRQLI/YbiGWZAQB/5FmBSGh0Cvor6FHLg==
X-Received: by 2002:a05:600c:2109:b0:41b:e0e5:a525 with SMTP id 5b1f17b1804b1-420fd3225afmr5309555e9.17.1716356106701;
        Tue, 21 May 2024 22:35:06 -0700 (PDT)
Received: from ?IPV6:2a01:c22:77fe:7c00:3433:dfdd:9df2:1fca? (dynamic-2a01-0c22-77fe-7c00-3433-dfdd-9df2-1fca.c22.pool.telefonica.de. [2a01:c22:77fe:7c00:3433:dfdd:9df2:1fca])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41fe004eae9sm473415605e9.1.2024.05.21.22.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 22:35:06 -0700 (PDT)
Message-ID: <36887d73-46a1-45d8-b55e-50e574f72aeb@gmail.com>
Date: Wed, 22 May 2024 07:35:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: Fix possible ring buffer corruption on
 fragmented Tx packets.
To: Ken Milmore <ken.milmore@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: nic_swsd@realtek.com, "\"David S. Miller\",Eric Dumazet"
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <27ead18b-c23d-4f49-a020-1fc482c5ac95@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <27ead18b-c23d-4f49-a020-1fc482c5ac95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.05.2024 00:45, Ken Milmore wrote:
> An issue was found on the RTL8125b when transmitting small fragmented
> packets, whereby invalid entries were inserted into the transmit ring
> buffer, subsequently leading to calls to dma_unmap_single() with a null
> address.
> 
> This was caused by rtl8169_start_xmit() not noticing changes to nr_frags
> which may occur when small packets are padded (to work around hardware
> quirks) in rtl8169_tso_csum_v2().
> 
> To fix this, postpone inspecting nr_frags until after any padding has been
> applied.
> 
> Fixes: 9020845fb5d6 ("r8169: improve rtl8169_start_xmit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ken Milmore <ken.milmore@gmail.com>
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>



