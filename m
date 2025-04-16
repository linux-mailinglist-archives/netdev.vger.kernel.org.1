Return-Path: <netdev+bounces-183351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF4AA907AC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA7104477F4
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232A209693;
	Wed, 16 Apr 2025 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6fcQvh3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA462080F3
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817217; cv=none; b=Vi2WfwPkB+C+4HuKMTj+Ryabqq65CeQH2p+cQlI2RXZPrLoeBx/4eCsM/yH5j8CRvugYapt10RCi3G71xElGQGinXMCTmj1iOuAIsO/o3ameNkiRI2GENtomdIxMrQbZa6O15zo1tJq4veSs2UBf0jRYu5DmfDJ3sexyotyi7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817217; c=relaxed/simple;
	bh=M2PwNTRChn7TSIjDxUqmd9ksPTCvx4N9j7kNx1JYeVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmnyByw0XPqTsq/eWYOyAIuG18rlKiG5f8zQlDjXf93GQnY/wZ34NaEdS1+7oKztYZBEHBEWDP6GC5kexdjLR1e8n/C20hiuaskCOUWXNXdOxKqdYSnzQq1CmoJ32wQeNayOKRIqCfrVQHZiEIsCVEbUceyzh15CIog5XJJJai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6fcQvh3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744817214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzCdDtZ0GBW5InewPauRK4/LCQXMAAyeGDLOtH5ZPx4=;
	b=Y6fcQvh3MgGqQDjTTI2ZnIMsKAOpso2Ad4qhiYXOZ/JdTIEHmkOudlFAWjb95mBXD8ok6J
	Yrca5Fi0cYRGAWOojGtUCVOa6JHl/aDUPsWwut84rGbE7OX424BAbrBIayl0IwN7oA2yic
	fJa5oI0xqU3aCQrynfh/mOyz6LiKhhs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-FI7RYuygNz-k97YgazRfnw-1; Wed, 16 Apr 2025 11:26:52 -0400
X-MC-Unique: FI7RYuygNz-k97YgazRfnw-1
X-Mimecast-MFC-AGG-ID: FI7RYuygNz-k97YgazRfnw_1744817211
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso44189515e9.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817211; x=1745422011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzCdDtZ0GBW5InewPauRK4/LCQXMAAyeGDLOtH5ZPx4=;
        b=lrSQB3zg5Xb1EFh6KKkUj1yzxFTQ9wVqLiNIMRSG832Se8qSqEjK6aFEm6usBFRVxL
         AyrKK1HKuyuV5fU6pcm+CaXn9/KZz3AACuRmF4jupCv9YZzt2RSAmnhdzUyhtVHkCs1R
         lV2SYGQX16xAsNcjhi/Z1sUhAQYFo9uZjXi/dFG3nOK/44McDXzYNxtEvY0RBX6ERAiK
         Rdiag2fJ61gCz6HzLZC0tt2wigbJn50W6uSwkP62ffSYY9WDWobF+wbmoGQTusSeTF0b
         IbSbRrp6cbWyzACUbfrIzdH3yYwxbidiF4HwZoNz3cVPVkvlTpLn6OmdZeveIUBhnQMO
         K9Wg==
X-Forwarded-Encrypted: i=1; AJvYcCXU753cxwORQt4rEAcdHrJO224tvTcRpSVguLS4Egyb2q9hL/I0lxHEnIogR25GYK4psSgFHGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpGZU+rZwELcp4fW2VRM2spZ6oMjeMr6hGy+pSIsZ8N4YJaZig
	hZ0yG6/DhKLZgC8Oi0fQzEnE8qejep8lBBAyDwJKV57+9NHu1R/uX9b9gK9hrfPtpz7UTYDvHXS
	1Och/Dkl7ae5lkqRUYZ8sMVXqNA6X2btybwtGIr6FYL5Ob7UtU05wgw==
X-Gm-Gg: ASbGnctmX9w5JmVFo8Jm9RfZ9hvoDgpJjrSsacqQiri1BXS/VGzlysbSm70+Qt1C5hh
	0MVqs6NPcJXALU2a5fvoDcgjr+FU5mZQBOq9FbnmmgrOmkn8SNLyxPW+aeHSWpZCD3S62D696/a
	la3iYuldJm5xECNMOF2JsXUa6wSm2F9QVo7x6TsovDkxi/Dh+d3cbj+nYrjzvDLG1gsVsy7FwqF
	apboRDbpOjaLgHIJnIR7Md1WIxffmXC+UxEL88RslF/Qrlsa91D/6dxjQV0bnY2o9EfhtJ9N9Yx
	ZlLkq+NTc2gxfeGOpWheKntfoONh4fv3icKA1cc=
X-Received: by 2002:a05:600c:c11:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-4405d5fae4amr24046185e9.3.1744817211113;
        Wed, 16 Apr 2025 08:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYkE8ummEAwHnRLK2Urh12dZdwMs1NLrhIRhUNrfSO+fVYgh0sy6cXqRF/SSvZfC/ZNU1LtA==
X-Received: by 2002:a05:600c:c11:b0:43c:f8fc:f686 with SMTP id 5b1f17b1804b1-4405d5fae4amr24045915e9.3.1744817210791;
        Wed, 16 Apr 2025 08:26:50 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44044508a7dsm28272085e9.1.2025.04.16.08.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:26:50 -0700 (PDT)
Message-ID: <77c438b9-2186-49f4-b95b-5e2df61a573b@redhat.com>
Date: Wed, 16 Apr 2025 17:26:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 14/14] ipv6: Get rid of RTNL for
 SIOCADDRT and RTM_NEWROUTE.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-15-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-15-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:15 PM, Kuniyuki Iwashima wrote:
> @@ -5250,7 +5252,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
>  
>  		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
> -						extack, newroute);
> +						extack, false);

It looks every caller always pass 'false' as last argument to
lwtunnel_valid_encap_type(), so such argument could/should be dropped
(as a follow-up if this is too big)

Thanks,

Paolo


