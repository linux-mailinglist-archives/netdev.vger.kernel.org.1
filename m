Return-Path: <netdev+bounces-190013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A18AB4E8C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71520188FA15
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052A920E01A;
	Tue, 13 May 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMHGekhJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA601F1524
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126317; cv=none; b=JezMzJcYQ2bQLR5kmfA+1smh2Q43iz04GnmfIcNThHqdg4oeK6L9QL7ZiywihBCLJagdB+N4pIcSlApWUvP+o1KTE6BG88mpw+PlG/rLbviwB58KNFIa8QKPIB9KgiG5zNmBBlsusElA9mtDq7ou7n7ZstO9vlNnrQ5avVZCNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126317; c=relaxed/simple;
	bh=ioYfR82as7BxIQ6g6jQFZ3hhJuiFD+Xx+vMITtkD7po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9ZfV8lBwlJwbFmRPhOjlBfjiXubx+12G8haHxkUZVIw+Lf9vHc7kY39Wsocxa+mWCY68tJ/070VyUdiH+eLKSEa6T1l/71ybZESPg/0A4fBL38eQeb+zz7vqt228yN9GTFzwBq5mEHjdlS+PFwHh7cR0DwKMWC8l1J/V4cXh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMHGekhJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747126314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXsGs2VA+ITuyh4VRCJh/Oyjf9ibDYe324RnCVY1HpQ=;
	b=EMHGekhJ5lMb7e/xgfNEEJ44fVfalDlWaBDhi8rqM2C7k2n2NFtWvrlc87LlJghZBy6vNh
	AqtHZ+MITyNK/ZYQEPVafMqqVYx5eCRkpyZkC9pOCpXOwvqH1qPYxwcMw8Dm/FugvtQkbp
	4MMfUiMBIt82I+1dfnFIdjbvN83UYxQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-Ia1vix_JOWOlwuirSt75wg-1; Tue, 13 May 2025 04:51:53 -0400
X-MC-Unique: Ia1vix_JOWOlwuirSt75wg-1
X-Mimecast-MFC-AGG-ID: Ia1vix_JOWOlwuirSt75wg_1747126312
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-442cd12d151so36224045e9.1
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747126312; x=1747731112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXsGs2VA+ITuyh4VRCJh/Oyjf9ibDYe324RnCVY1HpQ=;
        b=OcLA8F8RqQEdTo+qN6slhSzlxk8+VKesrbbbhfBWM6ws1kmOrAZvgUCQ2VTiiw8KSs
         KtJdSEmoqt4LmLSm9+yNRms1hiCiGMvj2Og+AgNWiuow1rD/5wJ+uAKbyajEl/SSvem2
         BVa3+xEdUONGvrT+E8PwUH+7jHSe84TYJLsgTT6Kzf1U8+TKURFUMK+Gd0sntO0ObOcR
         SQADQndTn6aGg9nHX7nzU7kdOwm9TCwMO5uCK1lMQJQhH83DNKhHovgz2Q4+P2Gt9vZa
         Lm9t1KhRWvu/68f8ADJpwx8RI/lN4nByl8BHAG/McWyiDUNX4dFgXGVzhv0GTPySCHUO
         gIRA==
X-Forwarded-Encrypted: i=1; AJvYcCXsVDjKIob9O8cEV/VyU5F4kFX1W/hUq0WETIRs4eIDLAwfR0dul8KUKTcH7yxtsvHZeO38ZlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYrQl8cD9dsRctR1LLO5xDGJ713Y/wIcoI1SwWiDqB/dojxLD
	rN+JfsIMldQIq8OkA6phMWpsYTFHSdv6GshIFFwGVju7//J7t1z6rYySuf16TcYWnQNtJq77t7H
	L8hrTrYRswwgXZJWs5ZLZ9Fk4yGd4aeTyZ9ov7SccNFRA2rB7ESGf3Q==
X-Gm-Gg: ASbGnctukvylkxJ+VR/QRQe2oyXne6Aw1FSFfoJ4c50Nw+KZ7sVVpi7jLIUGorH4let
	9pib8yJw2wq7wCJXG5YIEw6GBJXREoZnDRb/10sxL4IsCWGTdLfObMx3oXLG9FOowmd8HvCAqsh
	s+W9zjqka5BrKeUucVXaNyjBHaD6767SBM4MAitf8+VUHUlWOnKeLdQK3DE0z/jgwQRhvfMcYD9
	pZVca2bg7qNUumRSobvlwH1mFMPRvZsBvCX54KWjkQld1prbeXDvIqhJ8oXVkJtpogZ3gcsngDw
	NYBTnhch6/ZTMy2yl/s=
X-Received: by 2002:a05:600c:4e0e:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-442d6dd9d54mr144108565e9.24.1747126312092;
        Tue, 13 May 2025 01:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtul9+WMHSXrK//Kbrqv9MInD7Mc4snBmAwczFOs24A5HdJfBc9svhiLHz11Vw6gpX0UPuyg==
X-Received: by 2002:a05:600c:4e0e:b0:43c:e305:6d50 with SMTP id 5b1f17b1804b1-442d6dd9d54mr144108295e9.24.1747126311750;
        Tue, 13 May 2025 01:51:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ed666dc7sm11376705e9.18.2025.05.13.01.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 01:51:51 -0700 (PDT)
Message-ID: <7b5f7e09-7df0-43cb-9acd-c31720002860@redhat.com>
Date: Tue, 13 May 2025 10:51:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before
 sending IPv6 packets out
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Gert Doering <gert@greenie.muc.de>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-4-antonio@openvpn.net>
 <fc07f58e-488e-490e-a33f-50f09163a0fb@redhat.com>
 <effc10de-e7a9-4721-84ee-caafcf9aedb8@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <effc10de-e7a9-4721-84ee-caafcf9aedb8@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/25 9:51 AM, Antonio Quartulli wrote:
> On 13/05/2025 09:37, Paolo Abeni wrote:
>> On 5/9/25 4:26 PM, Antonio Quartulli wrote:
>>> IPv6 user packets (sent over the tunnel) may be larger than
>>> the outgoing interface MTU after encapsulation.
>>> When this happens ovpn should allow the kernel to fragment
>>> them because they are "locally generated".
>>>
>>> To achieve the above, we must set skb->ignore_df = 1
>>> so that ip6_fragment() can be made aware of this decision.
>>
>> Why the above applies only to IPv6? AFAICS the same could happen even
>> for IPv4.
> 
> For IPv4 we have the 'df=0' param that is passed to 
> udp_tunnel_xmit_skb(), which basically leads to the same result.

You need to include (an expanded/more describing version of) the above
in the commit message.

/P


