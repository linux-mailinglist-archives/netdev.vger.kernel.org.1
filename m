Return-Path: <netdev+bounces-146619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C33E49D4989
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C23EB21B88
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974371CB9F0;
	Thu, 21 Nov 2024 09:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXx63RYK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74401BC091
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180093; cv=none; b=TPxsxWzavLBPLMztMFrWQHLszM4Fy1n0aicAsL3uX6UKxnUOPV2bteRm89aqhxUbpL7rQJsOBGeOwMMtczi6z4VF9TUP6qze/v6du0fYxk54wWRn4BnTxex2j9r5q8IW1W8anKCx4MwO1ccLdWEei7ZDFf2KthUt+hOFAYxORFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180093; c=relaxed/simple;
	bh=XfxHG7T9zdJ9nblrp6w+ekWfkJvYj/7d5Bu7Q0dX2Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRQZoSgJguzHUBNw3Sqj4C2XmIAj2chtWRXw1Vg+NHFBb8LyR9Ooc4i2T4hhllWf3xyYPKKOymPowWSw91i05JstK7uFQoc9RLn9LzKZ3LrsS7Ulck1UL3cDkV9WKWeblLJxlpu/iHgonF4IF+hc9XF6iviA5SRlI5iA/fYails=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXx63RYK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afC2fEWr0oOrXo3pVR/4wD4LruzaVFrljRmorsICJx4=;
	b=bXx63RYKEduDE99zNB0uqUxUMCieweSlzGRruOYGGkIbRDMxX8fT8xvHUoExKlUyiAiODY
	WtKpFZHrNvk2DYggAVwRhw9LgVN7notwV4Uh0yvukM2POHM5y/YpU97WvdOM65pTUIr4UH
	+IoupB2ucpUzUygqvO0CGhQCkbB7ds8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-cEKtSmrnPH26fPaZ60W4hw-1; Thu, 21 Nov 2024 04:08:09 -0500
X-MC-Unique: cEKtSmrnPH26fPaZ60W4hw-1
X-Mimecast-MFC-AGG-ID: cEKtSmrnPH26fPaZ60W4hw
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6ea863ecfe9so11597817b3.3
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180088; x=1732784888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=afC2fEWr0oOrXo3pVR/4wD4LruzaVFrljRmorsICJx4=;
        b=IWHSuR16li36mnZlxr5QKJzaY7hr6hcEtDT912pwcfR4vWxjIMgTYKHN9eIYAOt6TJ
         DAl8NPVrxY6vN7AhxO+c5NZ2Exegswbr4yqLhzSrEOgQV0i7hgHBp1mwhSk0+ihVp3Le
         oj0AVioX7gbJWqx4OrHT77xnHtnBB2ChEYRQbDTlDJHPmxp1m0n7dCJxye7QcB24ViDR
         eQZqUWHR13NW3qho7b5AV5ymlwv55KugFhAbnjbYGuhBWkHWI5HFRa1wiuS94fQXqE+6
         E0bgz+FOv1j/MYzGzcoTGCIJBm18tqGHh4z/+c9XvB4bavRLfg28e0gXMEGIC5Abjf3R
         ZFBw==
X-Forwarded-Encrypted: i=1; AJvYcCXW61FQHXnT22B/stVL70iACgDWo5jbMS+FtLtkduUY76zKomkycPmudm9NhckUyC71vjBU59w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8Q5lMXkpG0u+hUn1QgMgEBBY3asosUdO7VUjRRApnETvp37X
	v7zBVtzDH8B2frQeX+CFSVgwHdRK81455EZHPQpp9bBzaCs+suVrjyKwls0McXbzQc82mstx5ro
	xYh0AFWwJMeh7An+MUuxI5ToI2MY31DSe45vPWPkN4XGCzeMMLzkvz9Bh/ZaOe9Tr
X-Gm-Gg: ASbGnct3qMbYXYcvYmhfkXHN2sKpRhpMrvo2l33KOszOceBY4t4D6DFPbObqpze5lx3
	vDqyEshn2TxX8ev/lOI6TLKO+JSgaBtJPuoAi+RnRAixIVvjmDepZNbKVplSouM32RbXTW6P2le
	jUG9FabVM/cgUZrYujBowhqxVMAe/zLo5OSd22zzzhCJ5h6B9r2pl/qWvMlwnk+VIjNmN+VTPPE
	+oMA2rE/FI0LaQfNmqpu2So639Nk4KjsVPu87arFH4GzA3eNXF3d3j4swuuaxO1kPIp0FXGxQ==
X-Received: by 2002:a05:6902:1107:b0:e38:ae50:3360 with SMTP id 3f1490d57ef6-e38cb58cb69mr6096053276.27.1732180088124;
        Thu, 21 Nov 2024 01:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvcd2Tc+vOWhnMdPjejOD4B82sqJ4ONVE5q8tt3h7dnbHkb3vWE9q84qQ2i9DLtZwcC9d5Bg==
X-Received: by 2002:a05:6902:1107:b0:e38:ae50:3360 with SMTP id 3f1490d57ef6-e38cb58cb69mr6096030276.27.1732180087824;
        Thu, 21 Nov 2024 01:08:07 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4646ac1971fsm19452431cf.89.2024.11.21.01.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:08:07 -0800 (PST)
Message-ID: <ed3a24ba-ec2b-4261-a479-11625b04b44a@redhat.com>
Date: Thu, 21 Nov 2024 10:08:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/smc: Remove unused function parameter in
 __smc_diag_dump
To: manas18244@iiitd.ac.in, Wenjia Zhang <wenjia@linux.ibm.com>,
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Anup Sharma <anupnewsmail@gmail.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120-fix-oops-__smc_diag_dump-v2-1-9703b18191e0@iiitd.ac.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 16:01, Manas via B4 Relay wrote:
> From: Manas <manas18244@iiitd.ac.in>
> 
> The last parameter in __smc_diag_dump (struct nlattr *bc) is unused.
> There is only one instance of this function being called and its passed
> with a NULL value in place of bc.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

## Form letter - net-next-closed

The merge window for v6.13 has begun and net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Dec 2nd.

RFC patches sent for review only are welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle







