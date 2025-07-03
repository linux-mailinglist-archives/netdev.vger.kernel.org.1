Return-Path: <netdev+bounces-203836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D360AF76A3
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB5F554506C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E2D2E7185;
	Thu,  3 Jul 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="TtSV7JHA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36581A83F5
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551461; cv=none; b=qKNwzoDd1YLdg5e0hYjosmjigCcKKh+Y0ZUObPZf4y1hHeJz2KdzMtSNAApqOA5rsrUvc4FElz+YfpQa7YZ9iBxnp72XKy7E8JNt76DaYyQYmRtj5cnfYh9apWEDR84WqVD1a7htvdxmxWLu7i9JDquFILTTc1JUclCvwE6BltY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551461; c=relaxed/simple;
	bh=2Ja0DRql3lathYbsnh14IuivZQ4FJiihEMyCBFg1y6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LG5MDj34zdM2y18shSc3alM1e+2HR6OG4stv1Y8a/jqtxLJDC5Dj5yDCp0dWrqkkx3MSntNpA0a7JLwPb8u6lpECG2jJzmdTMRQJtYFE3t0dx2nEULsqTukSgTgOM2oRMLRF3WZBC0oe+5lF4kFiAyRC5b41mqhZg7rrx+Ekoxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=TtSV7JHA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a524caf77eso1216321f8f.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1751551457; x=1752156257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dDrJgI2UVALwAFMMfVSy2p69AmBm6S+zzAfjuuFd4NM=;
        b=TtSV7JHA98z6F4GHH35zpp4gDOAvs7W87NmDHqfSW96LSgYzE2ROJfELFFr+YWQLwZ
         t+ApmACziJ8WHArk3KjRI7peWUyiXamCAm0KTW0Rxngxz02dBm8L+euTcdeugX8tIyMC
         2dxFv3s9SJ+czqY1sFB42Ciyw2JENoadUcJlZZkAJTjk5w0cFesvYGin7PQVZWIvlDU6
         swCyJ27phZ0eGOUZt7nVNq3bXV4Bw1gyD872B886oIkPmtnK7xVi8gIU7D8GwicNJ7/U
         +/SANI61epMP3IuIEFIS3QISo4DwPMZxImRtfN6NiVFSNkC80xHGjDuiCc08mHxVaOBw
         H7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751551457; x=1752156257;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDrJgI2UVALwAFMMfVSy2p69AmBm6S+zzAfjuuFd4NM=;
        b=PQxJrB5VKgYcgHk8zwEyqtULOB0M5nSReFRbDM0+k+KkPctX4RHuoB6Cq025TMuqGe
         Y3DaI7632VeNp/SMSLiGXLRrTMWkduqVC4XUZ4HNj6cZ7Xe3r6Bs0VFdndv6caPz6YBy
         2IaMvPqGVv3ald8JIVYGAG8bFtP0AiB/DJjq3c9FhAyApfwH4OaBL6XcAZf2tRYhAdPa
         mqeLe7SPiiUDmAmP3hnmS/5pytfigOIRK815qBVnb/CjwGFOgMDjXlkzB2nwKx66YjzD
         6aBFgFL43Cw/LOWdKRXJ11W/ZkCByp2PLVQ/A0lF6V+IVirthSqFjRRw6wYvkt+PvQ7r
         Jg9A==
X-Forwarded-Encrypted: i=1; AJvYcCVfVqryvPH3WymhOtLyXzEviV96gHBsQgp2OVaUKPcLxIgEX23hMjirLiBhNbebV5MSUF0qn3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/mE1+y4kwPxg2DuZbtQ0vg0U3GxjV1U4KaH1M36skOcpjH6eL
	tgE0xaMDDkK2IloAgJYdV+qdWvSjXswJqBg1avyN8hlCPTl3kOlXIkDSAiaOjqWgAZM=
X-Gm-Gg: ASbGncuQzs41stNMQ+L3ZhvovqzLgVysKoG6a+aZtd2CoFs4hpwQW8JJDdoCQ1j0S0Q
	pgTpq5yeyRB3r+PZJojG6SaD31Hrss2VXb3rl5u5OiNx7+FlY8NEMbaNz3jR5OCIfbETvQr3NLV
	pRcStGXLW/yqq1OY7Injveol+Pl0jTSbGQt6ZPMQtiPy0S95Om8BVYBk2PwdXLSs+OhuzGp2F/J
	BEotMG/PltjRUAkzGJfMZSYpb6oRSX9hjf6SFWye9bS+xL7rTbi1S35xhaftiBb6dEloVUpc6tR
	8QLFLZqlav9RZ0hsjNL7gi0YPfnPZvmrDxe8LzuLWHB4j+mCyStdwsnTQYbtSGeexf4tQuCsRVI
	yTXQ35dDohq/xS20jEuGkApRklrZuCSQzWnDWjMQ=
X-Google-Smtp-Source: AGHT+IF5rCFDzUmRIqGfxH4DlbOtx7wQkmAk4Z9+J1BmQz88TZ603h5r95CnF2l2Jg+U+vKV4H4iEg==
X-Received: by 2002:a5d:64c8:0:b0:3a4:e740:cd6e with SMTP id ffacd0b85a97d-3b37b7687c6mr698382f8f.8.1751551457041;
        Thu, 03 Jul 2025 07:04:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:61e4:bb55:bb2c:ae50? ([2a01:e0a:b41:c160:61e4:bb55:bb2c:ae50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a99c07fcsm27185885e9.35.2025.07.03.07.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 07:04:14 -0700 (PDT)
Message-ID: <1e896215-5f3a-40f9-9ab5-121109c48b3c@6wind.com>
Date: Thu, 3 Jul 2025 16:04:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v3] ipv6: add `force_forwarding` sysctl to enable
 per-interface forwarding
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250702074619.139031-1-g.goller@proxmox.com>
 <c39c99a7-73c2-4fc6-a1f2-bc18c0b6301f@6wind.com>
 <jsfa7qvqpspyau47xrqz5gxpzdxfyeyszbhcyuwx7ermzjahaf@jrznbsy3f722>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <jsfa7qvqpspyau47xrqz5gxpzdxfyeyszbhcyuwx7ermzjahaf@jrznbsy3f722>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 03/07/2025 à 13:04, Gabriel Goller a écrit :
[snip]
>>> +    // get extra params from table
>> /* */ for comment
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/
>> Documentation/process/coding-style.rst#n598
> 
> NAK
> (https://lore.kernel.org/lkml/
> CA+55aFyQYJerovMsSoSKS7PessZBr4vNp-3QUUwhqk4A4_jcbg@mail.gmail.com/#r)

I will follow the netdev maintainers' guidelines.

If the doc I pointed to is wrong, please update it. It will be easier to find
than a 9-year-old email.


Regards,
Nicolas

