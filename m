Return-Path: <netdev+bounces-183178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D0A8B4C1
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8358E3B8A36
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4F233D87;
	Wed, 16 Apr 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihoIMBG+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F1A233D7B
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794397; cv=none; b=OeJEQR7FOLzDqJbdqQu7GDfbIfNahZxsT1NgaJL6Q5YDEFhk47TEA94RkQqVOhv8po3HmMf6cS6h0/90BFil6eAwPvLRYLT73cQ1/1kiXx5AVaHS/V1f+ZV8eMh1KpGHJjJdBWuxRJ4Xs8RO0zsfwB8VMlQOmrzXS8CVX6Jtkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794397; c=relaxed/simple;
	bh=9J82hBUkPM21iE1p39RUCImvkqg8gQ8FIiqrohWzfTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nFXJPm/OE3yhtutK3Yd6xE/Olt6W88d4rWRGldPMXlnHI52ZU7j/zI22AXqANmpCNMByU25lYyobX8RoynAYi5C0WV+Cg6izTCBDDJWadqfW3K7wbLarYty6vnM2f8RBfVaBUVgozILdMy6dus35oPE86SVWDU/Zm14KX4yxTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ihoIMBG+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744794394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JZh6IEn5cuIyPxe+Y2bawmt3X8/HXdLk3GL/xB6zHTQ=;
	b=ihoIMBG+bj3lnnS4o68E4qOLYZ9Tg5CPg5ofp5PqTlQGwZ8RIEAeHcHVV+Gn29u/aLe1ok
	OwtLuqplXZWKkpNhvv59d2IxGEpwOp8bjz8tRwpYYHQIt6E2/gJUUJMgLnfqWoz3DR5R8E
	fVVL20YTdlkzIkkuBnzL2A7yXZX3Nxk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-bhvYolwdPteTSeIxuRYr4A-1; Wed, 16 Apr 2025 05:06:33 -0400
X-MC-Unique: bhvYolwdPteTSeIxuRYr4A-1
X-Mimecast-MFC-AGG-ID: bhvYolwdPteTSeIxuRYr4A_1744794392
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912a0439afso2697690f8f.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794392; x=1745399192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JZh6IEn5cuIyPxe+Y2bawmt3X8/HXdLk3GL/xB6zHTQ=;
        b=wPLmPoHbaM//GE76S78AWbJX+sNtNSW3M9W7rxF5zbp2sZTJ7XLb1tUVJWMHCr4Ri5
         nRKn4ILjaNVpzcm41EGExJMfuRQYfxlqiV9jqGe2nJOmmL0K5Fpo2RXQruYpt41hLCPm
         KQQ8zy78wM13ett7QRsjG93oq/An6ESTuNk6cIOPtEieAFE2ceif04THJz1sfO0vIM/9
         tEqJq+3NHYJSXRYIURqORCyc0UCZHuGmqnzdFZRyDXu6dsiipTwxDcJETzPsMdoV3yhW
         6b+vEe3ai6KdBiXjKUuVAJ93XOme8ZJKW1MCFwVZazIcbS+D1ljTeJpM7DWZr14xS/a4
         ZusQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU2XA5ptPKMPJ1Z6nbV4D0TY0fN+Cx6yY6I7nc87Y++1Q7x9YJYyfFr7nBLmxFRgyU2YTANos=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhjy8A0Gjf56YVLcCB69qGkwlc5GtiYFvN1VHNfVL3qa2ST3tW
	2HcG2dfMzHsuF5jGV+HO0khMJMMbJJ1c/pQ8qEw1C4Q5tt5zy8VtwQjA/h4pnMMik3mhwn9gVfW
	F5hUacKihPXeUfaAS3YIU8R7QQR3ku4LovIhRmEl9J9QDhw9tyXnMJQ==
X-Gm-Gg: ASbGnctGUYe4asB8Rd9wGfPk2duC7lTf/d4bgToMQDdaEteSm51ER9ETPMITHCbyePG
	dx1kS4Ug17LYDYu76b6g/do8Y3X2le754zPemakT/ER6j7nDGZGczIruBft77h3zjGEu9kRKHGe
	FRshXrjWkc6Ub92U5OjyNcwjl0olgRq1/ywWAOnesI2rq07cf4alpcQcJGiwo6g4WZWdT1AkUul
	pbDa9QOuh2Dq6ffAY5y7drM+VyMmKl1gT7swEYaMa935LNdAWbpbKCeN/rlQ9q4+75apgFVvb5/
	3bVRxMEsVxL+2B4z+bocF1RZu1OjiipeTsQYOOE=
X-Received: by 2002:a5d:6da1:0:b0:391:952:c728 with SMTP id ffacd0b85a97d-39ee5b11279mr934659f8f.4.1744794392456;
        Wed, 16 Apr 2025 02:06:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAWpUG28BpFbFdYI3Kxxv4egX8ITb6HhtoR+vUI5J8OyLwI5+Oa1SugpAM7yuKkQBNkKPOwg==
X-Received: by 2002:a5d:6da1:0:b0:391:952:c728 with SMTP id ffacd0b85a97d-39ee5b11279mr934638f8f.4.1744794392142;
        Wed, 16 Apr 2025 02:06:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae9807b7sm16628571f8f.60.2025.04.16.02.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:06:31 -0700 (PDT)
Message-ID: <1c382acc-d823-47e9-902d-42606d64daf1@redhat.com>
Date: Wed, 16 Apr 2025 11:06:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 04/14] ipv6: Check GATEWAY in
 rtm_to_fib6_multipath_config().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-5-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-5-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> In ip6_route_multipath_add(), we call rt6_qualify_for_ecmp() for each
> entry.  If it returns false, the request fails.
> 
> rt6_qualify_for_ecmp() returns false if either of the conditions below
> is true:
> 
>   1. f6i->fib6_flags has RTF_ADDRCONF
>   2. f6i->nh is not NULL
>   3. f6i->fib6_nh->fib_nh_gw_family is AF_UNSPEC
> 
> 1 is unnecessary because rtm_to_fib6_config() never sets RTF_ADDRCONF
> to cfg->fc_flags.
> 
> 2. is equivalent with cfg->fc_nh_id.
> 
> 3. can be replaced by checking RTF_GATEWAY in the base and each multipath
> entry because AF_INET6 is set to f6i->fib6_nh->fib_nh_gw_family only when
> cfg.fc_is_fdb is true or RTF_GATEWAY is set, but the former is always
> false.
> 
> Let's perform the equivalent checks in rtm_to_fib6_multipath_config().

It's unclear to me the 'why'???

Thanks,

Paolo


