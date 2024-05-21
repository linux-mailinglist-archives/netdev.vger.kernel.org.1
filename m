Return-Path: <netdev+bounces-97301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F298CAA68
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12CD1F22878
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577E56757;
	Tue, 21 May 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg5IzGox"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDE71F951
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716281831; cv=none; b=A0H3vsYeLJrmjQZWMHExpQFq9rz4Gf1X2c1Hrwq1qMGeUnIj1dnrmUaL4gjA+l4nA08a1RkfXbzNzazNMLoznpMWNYB3HJ9Ifvv6mJccgpMK8EI3TmGNub7t8bM36cZBHpvEw+aSSfaxsSPWCXNSZ7Lv20Qm6PWukP2ujFDIGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716281831; c=relaxed/simple;
	bh=96o9obeoQkHYpLRCBMLnAK6l7ExdwIHoAc5SDeX+7SE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AmHvwkh2NtfQQDqsC1lmI4w9n9/01xqU/0AK25QwAUq4+HDcmuEunROP+pKDbVyqfgir8mhuoW/OLW3ddtyu03HNrVp55ARZoi+hE4NuLFt6WbNLMze3rSHZFyjnX/hdCPeqk61HOVvus8reHJ3XyYnLfmfVbYcQh6wKYX+g4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fg5IzGox; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716281828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=96o9obeoQkHYpLRCBMLnAK6l7ExdwIHoAc5SDeX+7SE=;
	b=fg5IzGoxFwu3/t5Qde5OPXADkl9h5gus0GR/iXfXTX6V9JyulLMc4w+r8fKvLsx2qZO8wi
	dR8Wq5KJj8YA6ssHerlREsNd8U+CKjGe0k5I6Cdum0Pvris0kQsGd9VvVNFAQ+qeqm0XE8
	TE0oE4eON5TdwcGOODXFDQekwRQIETc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-pZ46kIJHOraSFHidWB6rEQ-1; Tue, 21 May 2024 04:57:06 -0400
X-MC-Unique: pZ46kIJHOraSFHidWB6rEQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3502ba9e9b7so1555394f8f.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 01:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716281826; x=1716886626;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96o9obeoQkHYpLRCBMLnAK6l7ExdwIHoAc5SDeX+7SE=;
        b=lKaU5hMHUkOwV051dUGPLldFwqkVirwfVknZDEQxVylm0RWZZQjQjI9g7UNBjbfO2l
         CsPD+Z6wyGkB06wO1UYTID319gccFa7OCNym9lnlQwKf9KR1EPiJ/CR+Ex6u761PCKqe
         HYJL9cV+rWtge4DPlhNYorVs9rzg+R6rs5EeiGtceIfAHgqIPreizCTPlNvTHOfV8UL1
         vTFlcGhVxY6JEf/29qatTBAx8qJvms3UvP0ehfYdZrQt+0pCt0Vv/AJB9QXTKxGj0YVg
         PZDQjXJ1EZEWN3M3VW+8N7dd4Rm6wMSjDcIpQkJ0PZJyIB16EOuCeuH5zv+XC6qKy39G
         jJQg==
X-Forwarded-Encrypted: i=1; AJvYcCWMtCGC3idLtfENITO+ljmtgpVMT7LVMJDpdoHIwZJDRPGcliykD2bhD6u4JT7Wx2DYyuivBwYdnnh8Wlsl/hdCL24KsY0K
X-Gm-Message-State: AOJu0YxJGmFujdeLtbYE1bDGTHUDcC5Sh3DCxkgSmlAXUXP7xVANef1m
	CQakrFtmdps2UC9NHvbfrodmb6g5uIChIAKuqgfUkdutfZXuQw3w4s9JzzW/ZFKImZd1Uu29pr9
	28Lj6xk6HQk5h0jiKYRGm3vV7Nyj74WXzg70EqRhcDX47nVFl6KtnUQ==
X-Received: by 2002:a05:6000:184f:b0:354:c5d5:295b with SMTP id ffacd0b85a97d-354c5d52d27mr4428043f8f.2.1716281825732;
        Tue, 21 May 2024 01:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsz1FhOM8YDELlCkwmAYcps89RSC94PODvwAMsFgcN0WkXjNlPFg7VwuBZHz9FlMXNCu6e8A==
X-Received: by 2002:a05:6000:184f:b0:354:c5d5:295b with SMTP id ffacd0b85a97d-354c5d52d27mr4428028f8f.2.1716281825250;
        Tue, 21 May 2024 01:57:05 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc3bsm31329449f8f.13.2024.05.21.01.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:57:04 -0700 (PDT)
Message-ID: <664d3f4f3a743315903d56a89317c19edada92a2.camel@redhat.com>
Subject: Re: [PATCH net-next v2] icmp: Add icmp_timestamp_ignore_all to
 control ICMP_TIMESTAMP
From: Paolo Abeni <pabeni@redhat.com>
To: ye.xingchen@zte.com.cn, davem@davemloft.net
Cc: edumazet@google.com, kuba@kernel.org, corbet@lwn.net,
 dsahern@kernel.org,  ncardwell@google.com, soheil@google.com,
 haiyangz@microsoft.com,  lixiaoyan@google.com, mfreemon@cloudflare.com,
 david.laight@aculab.com,  netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 fan.yu9@zte.com.cn, he.peilin@zte.com.cn, xu.xin16@zte.com.cn, 
 yang.yang29@zte.com.cn, yang.guang5@zte.com.cn, zhang.yunkai@zte.com.cn
Date: Tue, 21 May 2024 10:57:02 +0200
In-Reply-To: <20240520165335899feIJEvG6iuT4f7FBU6ctk@zte.com.cn>
References: <20240520165335899feIJEvG6iuT4f7FBU6ctk@zte.com.cn>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-20 at 16:53 +0800, ye.xingchen@zte.com.cn wrote:
> From: YeXingchen <ye.xingchen@zte.com.cn>
>=20
> The CVE-1999-0524 vulnerability is associated with ICMP
> timestamp messages, which can be exploited to conduct=20
> a denial-of-service (DoS) attack. In the Vulnerability
> Priority Rating (VPR) system, this vulnerability was=20
> rated as a medium risk in May of this year.
> Link:https://www.tenable.com/plugins/nessus/10113
>=20
> To protect embedded systems that cannot run firewalls
> from attacks exploiting the CVE-1999-0524 vulnerability,
> the icmp_timestamp_ignore_all sysctl is offered as=20
> an easy solution, which allows all ICMP timestamp
> messages to be ignored, effectively bypassing the=20
> potential exploitation through the CVE-1999-0524=20
> vulnerability. It enables these resource-constrained
> systems to disregard all ICMP timestamp messages,
> preventing potential DoS attacks, making it an ideal
> lightweight solution for such environments.
>=20
> Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: zhang yunkai <zhang.yunkai@zte.com.cn>
> Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
> CC: he peilin <he.peilin@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Yang Guang <yang.guang5@zte.com.cn>

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our
pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes
only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle


