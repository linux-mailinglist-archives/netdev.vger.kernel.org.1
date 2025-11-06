Return-Path: <netdev+bounces-236205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FACDC39BD3
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039123B0A5C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 09:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156A230ACF1;
	Thu,  6 Nov 2025 09:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJa0aXdK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkavMKQh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691A30AAB7
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 09:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762419924; cv=none; b=n/9lWpwxkEE4+6qANnLvRJyUbf1+tv5Ng/FeIlo1VmsTJnqKvqK6tBP7R7oiiJbkPaHpRhyh3cHPauVe353sL74PA20jT+euvOEAeXNlGYVE127A+nIgbRvgRfuOyC9FDV/9nI8oG8dmDj06sRL0VEOYz/jsQ2TsA09c7bn6oHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762419924; c=relaxed/simple;
	bh=hZ+GsPkKN1xnfuv8yHnCdYhnGV8I07dQkQgK+RpyRUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LphkSJ8/nbVHXDCo55/5A0yamkPrV2Ey0rzu3EPY2ShbvSFypo9mrR3yhrIviJO8hsaJkRmn+uVKaf4wRk9EnB2jbMqBHH6SqxdCxv5q12hCPBA7CVcOH8BVcASQFJ3fDElY0o9EUqhN6l6jSYorl5sMij/aMek1yv0Fjk0HeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJa0aXdK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkavMKQh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762419920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVVWReHzjccMkJIoRCRx58qRrx3kfa4v7Yjth4dJqLs=;
	b=eJa0aXdKSzSM/OY22rl2hlbgtZM2n88yIOrrN7kT/2Ff6JOxig0vn4p149chD+THcBSLbS
	Hs6Uv6OCA4XRgu7No6msj27H9OldqHt6veSXx1ivOZULbpG11DmRCyF6koldGWGvLqaq7G
	C4xxmnG2T5PTAguX1TgchxG97w8p/hU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-q8-24V29M_y-7kxfsq9s_Q-1; Thu, 06 Nov 2025 04:05:17 -0500
X-MC-Unique: q8-24V29M_y-7kxfsq9s_Q-1
X-Mimecast-MFC-AGG-ID: q8-24V29M_y-7kxfsq9s_Q_1762419916
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47740c1442dso5001205e9.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762419916; x=1763024716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVVWReHzjccMkJIoRCRx58qRrx3kfa4v7Yjth4dJqLs=;
        b=EkavMKQh3ZqL1Hti1j9E6szS2fxXyO3Yo3ffCZ+JpscXys2ZZtN437XN3l+u5cqJya
         j9UHb3ellV4b/nLFbZ5BqEjQMwwGIEe+WVi5Ez7uQkuFLiIaEQLuihn8RCFyv0trVBf/
         5Qg4JtOoavoC9TwWI2x4Yo0oxSgoJCWkaWKJhDtp4ARawJVV9hwBBesaOnMxSxI0wD5C
         QyYuM0lmfmFqkAbznvfTB6KQz0hp32r9uTxtQzomB31oKIFohUh4o6WDAHTiixnR8AiN
         +6Es3M2k3RKxlVkhqOI2KvMXbvwf5LyWZZSqrLLOWF8Csjn0juiz9MAcydDnTYZroyuT
         5VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762419916; x=1763024716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVVWReHzjccMkJIoRCRx58qRrx3kfa4v7Yjth4dJqLs=;
        b=EImviZHzZvpES8/FiAfrKfsRWYf+hTfy9NlHGXOLkGx4En1VPk78blwCqF4DbSSbbe
         RC7Y8pIc2UBFFI8TW6Qq+XAXPN0tVDuW68D3Ly1m3pnHpPRc/OToO5h4TX52hCHkSrAm
         lz/iZSWiLLISP8+BtAVhKKBF/VvFgpKtX8CIFJAGbS4PzOmhvsUpWQAi0URqcY/386oM
         VzyjPojfi5mZeogOaDmZzZg7dhi5n3rTtfLiFum5hPupCTL+pZnLp29uom3NqT09wxol
         vGeKnPtsM4E39hVpJ1nC9YiWolw8eoMDYUA/4/1f3pPy+Hm2U2Ml+Cyen13/M/SvOcw/
         in/A==
X-Forwarded-Encrypted: i=1; AJvYcCVUwfc0QFJAG77fcqUyisVPw6bkK4yOl787bo4or8PkxOyGHE0oo0cOo7LB36mXbnIFtvH5aYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGU8B/gweDRUgPl6MQNEThkpSII9XAnOWYtHzS97irJotMLP7j
	NeR4r8f44B4X7PEqd5Dn/3dORUsrI+zRL+RQkyPPs33EZEvlieun+58c7h30vNMhdF7x11NXo+C
	COz+LfH3V0pYinB3HvQdswyItyVDfmipDLDMwBYjKgGexkjoLXg+gQEIzNw==
X-Gm-Gg: ASbGncsCleWja+ImhvkuFufEaL4oTm8MxYzFJcKpqNEHndbNzxCkE9vme1eXtLD1lJi
	25ZJlKIHOa+AXBFfOEeDzTzUNeFchhZYkl+vBHkV5sgzKRvaEwh5QoVdtxPWsxXzd1HHRu1mch4
	1dbSNaHuiCdUzwALqbuHPhHjjhdfuUv3IvRudRI+Y0+ksVABzEVleHyT2cKfQ4TeYRkTFkvekYW
	ybVdkNwWpshi5ARv3+23OKui//VCm1bR/pkstRfxSfyGuzK113uI7lSywDRCD78K7CZkys6aHF3
	T6LmFS6YNXS5YQ6MRzDgy9n2exq/HV5mSu/P2EuYgC++S+IPKy93LcZR/Nt0HXT84Iu8pbtZmLe
	fWQ==
X-Received: by 2002:a05:600c:35d1:b0:477:542a:7ed1 with SMTP id 5b1f17b1804b1-4775cde5a28mr66445055e9.19.1762419915852;
        Thu, 06 Nov 2025 01:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuoU0KPtmSEkjEUR2VzH3YlJ8/xQZ1jtaiohdKFeznqvN40OCPAbZhkOL6kWmnEONW+fIqRg==
X-Received: by 2002:a05:600c:35d1:b0:477:542a:7ed1 with SMTP id 5b1f17b1804b1-4775cde5a28mr66444755e9.19.1762419915467;
        Thu, 06 Nov 2025 01:05:15 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763da0242sm11361145e9.0.2025.11.06.01.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 01:05:14 -0800 (PST)
Message-ID: <8ef591e6-9b05-4c7b-8d75-82ced4dd2f31@redhat.com>
Date: Thu, 6 Nov 2025 10:05:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: add prefetch() in skb_defer_free_flush()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20251106085500.2438951-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251106085500.2438951-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 9:55 AM, Eric Dumazet wrote:
> skb_defer_free_flush() is becoming more important these days.
> 
> Add a prefetch operation to reduce latency a bit on some
> platforms like AMD EPYC 7B12.
> 
> On more recent cpus, a stall happens when reading skb_shinfo().
> Avoiding it will require a more elaborate strategy.

For my education, how do you catch such stalls? looking for specific
perf events? Or just based on cycles spent in a given function/chunk of
code?

> Signed-off-by: Eric Dumazet <edumazet@google.com>

Just to avoid doubts on my thoughts about this patch:

Acked-by: Paolo Abeni <pabeni@redhat.com>


