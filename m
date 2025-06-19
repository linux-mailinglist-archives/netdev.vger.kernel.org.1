Return-Path: <netdev+bounces-199467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE907AE0672
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B52C3A9C6B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD88914F9F7;
	Thu, 19 Jun 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf4K+C4M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B35241CB2
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338115; cv=none; b=cZrQTZE2YU1O03dq3eRw3j9TDoe+2B1q7feyPvbQU7fySZr2dA5gdI9BZsdPrDgB4h/Byi/05L4PbaILtolaW0uX8qdm1fve3Bd6IFSvNMKRa9sgSs/LbV91ZBRIaylcReRDVkg1vza3zsxxMHLi/cVucph/GGTwC2E0pY99gSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338115; c=relaxed/simple;
	bh=OfL9Z/ec/rxhkCQVMde9KEFugyDbiDaYhn/WPjvYD8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsHAnFxr56FFhJltojTdIVLTdhTsUnwI0eJbXE4cZlrxyF1tC/kwph52+T5GhMbBlYG966sFiKg9nEHdVSPIA537dWNZgvgDp/K/9hPJjYSGlyHDW4DJZFBFkKfl45GvPDia3NvAgqCfeoRWg6Y1OFwMlc4c8d4LbwDHtbgbVr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xf4K+C4M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750338112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coOBctdngiFLwqq+spwJrBWJfXd3eMBKsDk5b3tvSgs=;
	b=Xf4K+C4MxOp1ls22F+pKrL3GQEd0CbG7aOMPn3mdYLsO8OU2qScd5kK0ctAQbjRt8A8+SE
	oeXW6JoEmT+siXUEK1YixDuYI1ceK0muwqBAlHK0DPIML3A4hHwMZESYqbOSKnXXI2D0AY
	6j5/GWf+Kr1bKMm5QL+TVCvQsSogdhs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-GmFrq5cQPESYTuAPaD5Zng-1; Thu, 19 Jun 2025 09:01:48 -0400
X-MC-Unique: GmFrq5cQPESYTuAPaD5Zng-1
X-Mimecast-MFC-AGG-ID: GmFrq5cQPESYTuAPaD5Zng_1750338107
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-553acdcd5a1so396585e87.2
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 06:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750338107; x=1750942907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coOBctdngiFLwqq+spwJrBWJfXd3eMBKsDk5b3tvSgs=;
        b=reFwiFTvFTF2r62yfDW0I00YNN/t57o2Qlktw+elT60h2C0YB4NjSi/ElIWsi7vf6F
         llqEigTV2Sv1bmMqM2nffOvvocIubf5nC9Yhgo71l+qnc5HqVVD89uv//8urSNwJV/jn
         3fYDD9TSSS3OB0cUKX9kMasG/Ot0z+xO4U3pFhY8l7Q1WaQuYYzlzuTc5xi6KX/nlsF7
         soSItjt4xKbrGP2SIg5ZJRU4KHCGsqMSBygZMNGfKU6+zeUULvqVVZ7cycXNCPFcjzda
         YY8go0df81IkfWDY3/NWKIM/qMCBmn3Y5aulSbHJY84HFtsPq1QQ9BcBkNnpw80fm/qm
         XUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvmno/f9V0UawhOVjP/0VL/3oahsDIpinOaRjzeNllTrG2iFamG54bHfeStUfvD8Jqy3jUqH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSs0eGP4qD7ZJyRVgltSuyCXDM8sgU0bL3Gx32TFamNiscn5m
	57HOsavttIvIpgIT1JYJpJydLKt8bFhL2eTyqXz+crqbhFKNtiznZLREePkW9hY8Ywr8ntA9zNb
	PQUR8do1L83NtVfMgPJn5U1lHORjvWkUZjt8NJywH6Mtx1ekAs04geimw6A==
X-Gm-Gg: ASbGncuIakbWRaDxiEYMUaFUXpM4ysI/i+5IKkDrcHndNVEL+aovUbcnSGgOd2Xp+uI
	cneatVBBzv4X+uEEittogd8T2Ahbi+Nmvb6ZDGT4SFgWH3yl5Qfj+6Eksu0ZYPEJNBZ0A3FbNaB
	eO05j6PUApDPwZggBlIu0GeN2YdyrhptDMNgclW61MEVrh8ZqR6yCOeMpy5PLoR7ENrs4RGeIaS
	Qq579mrnuUkMJp8fLm1VMLWvJ+o/C7DMH38g0uG/yfW4ZkNS/lYUgGkUVVZgXThdc1mmH485fZe
	e7RQvfMyhBQmwKxlux4Ijr5AZFBfqw==
X-Received: by 2002:a05:6512:3b97:b0:553:2505:7db8 with SMTP id 2adb3069b0e04-553b6f32e73mr6262537e87.45.1750338106545;
        Thu, 19 Jun 2025 06:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQOluXT3EEJj5DfLvQaoZWgbGe1BTfiMovxQCHdQgTLXzqLtRTDndjrZ2gOETEAtyiMKEWQQ==
X-Received: by 2002:a05:6512:3b97:b0:553:2505:7db8 with SMTP id 2adb3069b0e04-553b6f32e73mr6262434e87.45.1750338105582;
        Thu, 19 Jun 2025 06:01:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b27795sm19444363f8f.71.2025.06.19.06.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 06:01:43 -0700 (PDT)
Message-ID: <4f35f129-7197-4163-a681-0b79c7d6a5de@redhat.com>
Date: Thu, 19 Jun 2025 15:01:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 00/15] ipv6: Drop RTNL from mcast.c and
 anycast.c
To: Kuniyuki Iwashima <kuni1840@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org
References: <20250616233417.1153427-1-kuni1840@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250616233417.1153427-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/25 1:28 AM, Kuniyuki Iwashima wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> This is a prep series for RCU conversion of RTM_NEWNEIGH, which needs
> RTNL during neigh_table.{pconstructor,pdestructor}() touching IPv6
> multicast code.
> 
> Currently, IPv6 multicast code is protected by lock_sock() and
> inet6_dev->mc_lock, and RTNL is not actually needed.
> 
> In addition, anycast code is also in the same situation and does not
> need RTNL at all.
> 
> This series removes RTNL from net/ipv6/{mcast.c,anycast.c} and finally
> removes setsockopt_needs_rtnl() from do_ipv6_setsockopt().

Great works! Makes a lot of sense.

I had a possibly relevant comment on patch 2, but let's wait a bit
possibly for other pair of eyes...

Thanks,

Paolo


