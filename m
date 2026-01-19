Return-Path: <netdev+bounces-251239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9C3D3B65E
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A0B30443C0
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239138F256;
	Mon, 19 Jan 2026 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjv9+zet";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e05UBm1y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E9338F22C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849109; cv=none; b=hDEHeWke1Lz6bV7ZV7Nowmuec+EHCRp7YtwJFb5vXK4PF3CgkyM/Zvvjiep09XQ+P9MtJsWjS0ksUmP55ZRCjNvCduhrMHjq40OypcHkKiE6IaAx84xyOM182SHaEHfj/DObPQRgCGFqkp3FbDLelgIjACf+dLlZOpb8L6pXeCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849109; c=relaxed/simple;
	bh=5V+pFqD2o/wRnzCeLWKobwXGmUaxl1rFFC+AH0XqvZA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s6N4Vl1wruOuVafECC/E25Sg0KnVsJC1PuTFZW8w5pypMSkiPG7t0Hdw8iAQjnY4iP6dSRgyOlYDtwRDamQorkUP2R0Lg6/NIDWCK/5m1zllt+YRyXuRuFrgqEc1O/QNjT6hlksC7zsMy/BI/EcwCaDc1Z0QyZ5nNVKsM0cvqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjv9+zet; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e05UBm1y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768849106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DgC6Jni62XYTCD5petL0d2cX56Taw0XxcowmSejvo6w=;
	b=fjv9+zetW6bmtjXreb//Lweyoc1xhL8UZMZKOuSl66NLRl2erhyZ8Maql48S0QPcm6JgJS
	IVZwlkWTq0T7XTrnyqRx6CRcz0blj9GoFZ6rVqdilWv+aEQqs4GgK8m0MoZCyit87sA3YY
	m6FaFrLU6dhoQk9YjHgwyer6+i31unI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-EZ-YEN5uMRyhJZYOmmWrkg-1; Mon, 19 Jan 2026 13:58:25 -0500
X-MC-Unique: EZ-YEN5uMRyhJZYOmmWrkg-1
X-Mimecast-MFC-AGG-ID: EZ-YEN5uMRyhJZYOmmWrkg_1768849104
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d2db4625eso7268549a12.0
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768849104; x=1769453904; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgC6Jni62XYTCD5petL0d2cX56Taw0XxcowmSejvo6w=;
        b=e05UBm1yISeXFe9O6IvrZYJa+GjJoPbfZ3A/7X3KzEboFaaXFliJovyQ21C3HNB5xk
         0MSZxJOTLnqfclq2tE7mrBUnYWwOqSIhEKM8xYjYuC4tdgwAowWPkXzVLkZyqx1NrdhK
         gacQ+gh1KMgXh47Rvv7E7tUoJhTSwl1jyezbpjfHLFJlNrWMVGkcnvyH+ocx/L8Yvg5i
         TmTfkIENgqe9TkMKn4NW2XtB2pq7jvwMT+3OM7AQBLEkUIFrmuNv+L60nX1WG4D+9sAy
         n48LIkxGVCIZemaoZnxqwXDjTtSEW6d/2JXUDQfauo+SppMp640+xxvp65pklh6FpztM
         +bWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768849104; x=1769453904;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DgC6Jni62XYTCD5petL0d2cX56Taw0XxcowmSejvo6w=;
        b=jYZsvN607tN83tje1h6GUZ4P1PU2U5sij1qhdRChGmI2vv6qMKzefKe/ziTWpe38FH
         29z3Py/co4eLj6FtlnI2019g8mzUYknpwjYxvPn9N1G9/Rx7YCvpC1cE3D22jlh63S31
         mcaKHzT45GmG47hVExMfpkuO4MEci/mFYbYADdu03vn5y9unuXlFVP5oVEAeqRGcL12R
         mTpLGtZvLsN9poaocWF5Zu6xpWypSm6Sio9qtbudLY0s9mco5MTZZ/rywZ3mPh+aZFZ5
         5m2gNJjNda+daRumiO6wXtsP1Aee5zE4Q7GFFjGZrBI8tJ/JPg/7huJJOTAB1b3CzEbx
         Sm6w==
X-Gm-Message-State: AOJu0YxcYpcKsxEWHt1rcWFWNehTfEKm5XakvJ9jvnJmjJNiljHzXiJF
	XMpCQVks17uSzhHlahp9VHM+b60YocC8/+859lSxqRnWcxEQX2MseUIGbn1VkHwJec6xlQ4I6+H
	O1ltR37aoqMbsl6fBqTDxDXyuqIZfJM2yKAEEMvfyzZ5Pzbh2tc9FRuWoqw==
X-Gm-Gg: AZuq6aIQYeZ4CS3fQUEkptheBeYHkT5PUz/5rZifrnEqxCKR9GVsmYMgOLanIDVTF/Y
	Y/++oW9TGP1GrA63a1Kvrzhv1xZr48glWQka3N6OEmmihZgLbK07pz/51V+DP2n9wyK8pQTWZx6
	o8cGViJJtBEv7TY29oS8u3/Dn7vtbzm47Q6vNKWw7FeFN1Wj1hglen6QH3/cZfiVeexF5ynkuzZ
	OF2Exr6D0Nq6PUMp/zNJ5kufMMVGUl28cDHADOLBFfL18XpoR0WKJnoTx1A7DQcGuGFQHcFQGfn
	BNcXrT4r511XHYAgCfwN/Irf+6wy8AeI9l0IlBMUwA5jEJ9hVjXVWKRBwgilGs/UOG7RMfoyBqL
	wVz7DuOScRooZZS7EzzZ70tb8UCamcKk0EuFzl2TJjn34m2w=
X-Received: by 2002:a05:6402:398b:b0:650:891f:1bf9 with SMTP id 4fb4d7f45d1cf-654526cb85bmr6485585a12.14.1768849104134;
        Mon, 19 Jan 2026 10:58:24 -0800 (PST)
X-Received: by 2002:a05:6402:398b:b0:650:891f:1bf9 with SMTP id 4fb4d7f45d1cf-654526cb85bmr6485570a12.14.1768849103775;
        Mon, 19 Jan 2026 10:58:23 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-657e61901e9sm2612439a12.4.2026.01.19.10.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:58:23 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?utf-8?Q?Th=C3=A9o?=
 Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
In-Reply-To: <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
Date: Mon, 19 Jan 2026 19:58:06 +0100
Message-ID: <87ikcxpgzl.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 16 Jan 2026 at 06:16:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jan 15, 2026 at 11:25:26PM +0100, Paolo Valerio wrote:
>> Use the page pool allocator for the data buffers and enable skb recycling
>> support, instead of relying on netdev_alloc_skb allocating the entire skb
>> during the refill.
>
> Do you have any benchmark numbers for this change? Often swapping to
> page pool improves the performance of the driver, and i use it as a
> selling point for doing the conversion, independent of XDP.
>

Good point. I'll collect some numbers and add them here.

> Thanks
> 	Andrew


