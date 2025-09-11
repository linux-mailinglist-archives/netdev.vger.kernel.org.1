Return-Path: <netdev+bounces-222155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D961B534C0
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B17483C48
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54051338F38;
	Thu, 11 Sep 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcGXUu6I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918123375AA
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599210; cv=none; b=Xh4n9P+dAy4z0o4ZPnE5VDAfgc435N9OpX7A0iUxATBLPbAXKB+A06eJQsmVqgRHSk37KDHCDqdZ0skkcCdGisCUxsPGZGNXZr7BPiNha4VEaiZ1D34s1bWMmB1+Q5OI4dRNj88wzQVSq4oN3J1o9D+/8tkJPNuPwvxsdCKiVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599210; c=relaxed/simple;
	bh=8P6pKBuH3o4LJUALuf7dFPcdShsl2DCELD7W7Uypxp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDlvJsG3G3rEaMpvpLdbXu9Ze3jHgAA9HvDgOsVg+8syigtF8g/5ud4CcOp7pHwZvS4fbx6Hptjde/bQdFeJyd6Qk2qmqfzWIKExYlU83g6lkN0HS/yX5DT2t/HjQrutg/DruWj17AmAVMxC2HHV1r4QHj+1tLsaMRaj2a+sESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcGXUu6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757599207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMvl4ZaMMNRsTyc0sC5TKMichDPUicJFyuFVDK4rjBg=;
	b=JcGXUu6I5q51PjyM3u++SD5If/h8sAGgyfazKkgWMmnRkZtgZ2WVdlU0GB/S7KAQbT9UPF
	NYusiv2/vABRpSWRn7bl0gexSNXO5DVWxjHUk2QkOuHfK0XLfBtbMqlkViCkTnLaZNgHuC
	X3F7EN8uqlyisxrQjOizS/szwmQG9uk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-p0ORaulbO9eers8iktAn7A-1; Thu, 11 Sep 2025 10:00:06 -0400
X-MC-Unique: p0ORaulbO9eers8iktAn7A-1
X-Mimecast-MFC-AGG-ID: p0ORaulbO9eers8iktAn7A_1757599205
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dd66e1971so7632375e9.2
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 07:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757599205; x=1758204005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMvl4ZaMMNRsTyc0sC5TKMichDPUicJFyuFVDK4rjBg=;
        b=c1qZOFhgfFkVM+qoDIZJ4oIRZCIjqh5OW4OYEkNNKLGI79HL8XVP7cc2abGiVH2JPg
         7rkvmCN5D11xmC1M0QJSQ7tB+/Ydy2vVZxsTrtADvgfM4OmcjFDoEASJCyL36q4uVmxH
         Bi7L3lV8RyAhFgHxfmSF8OyEslOlsmCKoT+lOHj3slu8c9M7G5CKxsLoJp6o8OxelDPT
         MSxk98J54iuviHMvu4BsHZHSPxs6xN0ebeF/GITcjixJR8xl7mUTiLR2N9Y4fPg63aGp
         cIpXo4aosMrNl0KOvVgTDeOgNlLc6Vh2QB8vYUYnlCF722mDf/79v1mBdmtRjJCT7zSf
         sK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTcyvJedn+pE29SGu7W0TFMOfAeTeGL3JBdI01cZmNZdm7C+YRJ2BFXoA6xtHSmAu+pdOvYps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+nQMdTjyzJ/SpGtBGY2WnR9H4+iE25UrmVEW2qRhL/ld2edT
	OC2Q1UnvweNwTrMV2BV0SpjuFqkee8z/APg3X6twNSeDYw51rsjLcHALStfS/yJQhau7feEEOIH
	J9ythoy65ZVDG/ZsZ9Vh9IV4Mc4RIDPzdY9NPF00AQ1A01meaicvJGgoHbA==
X-Gm-Gg: ASbGncvmW94sEioaA21DiEgR/h8KBQCXvyac1YMjlwuHZDwl1E0rea0moEA3i/ne9mL
	47MefnErVAQ9Y7i88IIN11nuO2FdL++1vvxap3rak6G6b3UH4rOLHdDsANKW8VEhbXpGyZYgeNH
	M/XtXBksaJUwSpX/s3pXqLUroHK4OK/aKfW8WvCnXoB9qn0/sr7g+kkck/bEC5kXceAvYFfZd5t
	gQ03Z+EpqBGfpq2M9byrw3llOjAEezTuWu9NfmSRrhqeEJeM9SYMEwOj0rIC1rVCT7ae7KAZWRF
	znaHLZVYIbWZRppCWxSQV+Q3v6KD8GGuKA2t0owBRbk=
X-Received: by 2002:a05:600c:3b8e:b0:45e:77cf:af9 with SMTP id 5b1f17b1804b1-45e77cf0b52mr10515595e9.1.1757599204851;
        Thu, 11 Sep 2025 07:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5/3K47VxkQklnYZy5IAifrnSAx6ttfAQzgoSSKxNlFH9ZcF4FTkfmwom00ShRuJ3a39agXA==
X-Received: by 2002:a05:600c:3b8e:b0:45e:77cf:af9 with SMTP id 5b1f17b1804b1-45e77cf0b52mr10515155e9.1.1757599204420;
        Thu, 11 Sep 2025 07:00:04 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786f81sm2556650f8f.18.2025.09.11.06.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 07:00:01 -0700 (PDT)
Message-ID: <d345995d-d636-47d4-8564-8177b606c712@redhat.com>
Date: Thu, 11 Sep 2025 15:59:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 13/19] psp: provide encapsulation helper for
 drivers
To: Daniel Zahka <daniel.zahka@gmail.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Kiran Kella <kiran.kella@broadcom.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
 <20250911014735.118695-14-daniel.zahka@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250911014735.118695-14-daniel.zahka@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 3:47 AM, Daniel Zahka wrote:
> From: Raed Salem <raeds@nvidia.com>
> 
> Create a new function psp_encapsulate(), which takes a TCP packet and
> PSP encapsulates it according to the "Transport Mode Packet Format"
> section of the PSP Architecture Specification.
> 
> psp_encapsulate() does not push a PSP trailer onto the skb. Both IPv6
> and IPv4 are supported. Virtualization cookie is not included.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


