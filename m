Return-Path: <netdev+bounces-183206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EF4A8B651
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BD95A27CE
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376D24169E;
	Wed, 16 Apr 2025 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="as+0iShO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B785233717
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744797651; cv=none; b=lKE21v57VOO+hW/aWd6fiKFn9YDKtI0JG1Q7sAXc0LhoSU78pt5hZS/YTzivILTUoxhdoTr0+he7rQ3crZ6KVZ3sYl+LxBKfDS8QWnnhOiM5U67BzDdvl3dC5aKXbVcPugdTH9djRdWDlZJWt8RPwqaTTulBsE+gMbSZa9e7ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744797651; c=relaxed/simple;
	bh=DtYPH+vIBwQz6U6Qa4gvHYRHfj/u3+H/aUNeQctA41I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eERbS6qTg7FTow76xUP+WDYBaWAxvgoa9XU/7vNY6Kcni0t1ExeFbLVHLVE0x4rZvBg03ne8Q0KyFvfZ5N8mvkzkRniq8Xc1pWQn5qeXYQIgKK4p/tVTlbK6oKyhL+ZiKPulSzyULehnz+ldIS8ISRmD9lsSpoSuYqWChGWs/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=as+0iShO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744797649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJxp7TMT/8f48a7ksTnmjVQzowbLQdOiNt3LtlK1kfQ=;
	b=as+0iShObgsZkJ5BKlZm/Pu9Fbk4+2AeVun8kWNPg5oannzkZpGS5KJzR1W9FmZVXp1g0x
	OAdPzzIQ2SVgz/ev0my1cpTYDiCaW03imhvyctT2g9viC5Ah5PpUREBhGaSGXDEc/ZeRC+
	8Eg/HmfN7Z4pwyM798o/3kFSzdfvmiA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-KjgOPyS4Nl2fq_w4ekO_sA-1; Wed, 16 Apr 2025 06:00:47 -0400
X-MC-Unique: KjgOPyS4Nl2fq_w4ekO_sA-1
X-Mimecast-MFC-AGG-ID: KjgOPyS4Nl2fq_w4ekO_sA_1744797647
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac6ebab17d8so659735966b.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744797646; x=1745402446;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJxp7TMT/8f48a7ksTnmjVQzowbLQdOiNt3LtlK1kfQ=;
        b=jSDtErGE5HoslrQ3+VcwsLiydco6jGz9uY/E6263R4vhzl68OCHNdkxD0447ZH+M6Y
         7FkiJ6VmXd//E6NDuf26AvBjDji/0+CHAnPCwbWtLBhvj0a9iq/wQzNnrqh0va8BdLpE
         YnVLthj7otw9KO8MqhSmqo7Kf5ESNzp42y6Gx12UO7/6ZhFKP6Rr2fK/bl0TerOc4T1D
         HXvf27f3FjFMN1rXZRTQTvZQOmZtXpC1PhAlSF9EXhsH5hfMGqB3FhJvhxXcY2I/S8Zl
         yEs6ks4683mIUKEz6i8Khi2tEFI6436gQyOxl/djoLk5YhK28bbcLk0jiVj7GKt7nQ2G
         hNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrcsbLNAV/LRM2kvj/X4BboewyXcZBgcCHMm1+HCWoXdbePG2Ym+12Sl6F6OdBc9jrxLe27KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiJGeth1hzblX9QGS6Q2TYhfMt1dRQ8YUX/I9607J4M1VHoJNg
	gq9TSqdnYg/XFp+G+Mf5Zeqc6A2A98HIjcKglXS0bYNWfHsX69m8/vM951j7tJWh7KZVG36MDnN
	z8DZPS1ZUAuvI/cFd9JBUhLX3rtH3zPf/12kTZJdepu1F07byRcbd6w==
X-Gm-Gg: ASbGncth0hN65qEPjyTzrVudxy26XaHSBF5A44oGjAHKTiIWiV0/ER7GfwmCMmZqpKq
	6GqOOdXJKck/+CDpK7hYy5+8etC5sRZS2+4zHYICOfRnbhLr1qkZICxJxm2Kig6kesLtxSsP0Ab
	ZU3fsJQrwl/gZ7PizL826QRTKxnD7xw29hC5In9PRbWlBsUr1aTz2sZ4/6fhepBaHlwGnLKzSak
	Z4vbkKPIlse8SE7dhX6UOETuazlVtv8ED6e9Yj2j2CLIjVKnKhO7s4bocI4l5GW7iqVEO7Ar5CB
	PqF8KdQbQ0d7jtQJccn9bX9z+WfNqHkHMTkgSbw=
X-Received: by 2002:a17:907:1c91:b0:aca:96a5:9861 with SMTP id a640c23a62f3a-acb428fd82dmr98297366b.20.1744797646568;
        Wed, 16 Apr 2025 03:00:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtv5R5SEvZ+eIZ30yu6koWsqGfUWIpRpbTyJQqlb1Z488XI7MN4FOLBTNlCgokYhPXHoRswg==
X-Received: by 2002:a17:907:1c91:b0:aca:96a5:9861 with SMTP id a640c23a62f3a-acb428fd82dmr98295066b.20.1744797646178;
        Wed, 16 Apr 2025 03:00:46 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d34a2a3sm95479166b.185.2025.04.16.03.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 03:00:45 -0700 (PDT)
Message-ID: <816b639f-5ce8-4eae-8eff-73eb2631f8be@redhat.com>
Date: Wed, 16 Apr 2025 12:00:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 11/14] ipv6: Protect fib6_link_table()
 with spinlock.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-12-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-12-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT.
> 
> If the request specifies a new table ID, fib6_new_table() is
> called to create a new routing table.
> 
> Two concurrent requests could specify the same table ID, so we
> need a lock to protect net->ipv6.fib_table_hash[h].
> 
> Let's add a spinlock to protect the hash bucket linkage.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


