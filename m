Return-Path: <netdev+bounces-177747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC7A71820
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C83B8313
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEE01EFFBC;
	Wed, 26 Mar 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgJD9wLA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF041EFF98
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998203; cv=none; b=tgfRnRc/2MIOztj1zCD6k19f6gZT6G+YEjwpWz3dBcLzYMaaWzuN+2rn2zcztq1zcULfrChiN51rcbWKYlJVoZT2fOXPcHje0wnO5T67RYwdv2uTLFPpuqwlKVZU7lx2w0xfFUYwk+0kqPc3q71NG2QzzTN9VdMRy9sdzcIPPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998203; c=relaxed/simple;
	bh=TiT5Ac7TPTnCg+kaSQKFZgIZG7AtDCZpkkpuxB0RSkU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SQBVi/IJaL0DbNfrJezT7jdVENjJap2afbTmGMcY9eWyjIWP7ZVUdd/AZ1E74tTOVIxCtOi/oflcuzotLS/X9OobZZG0NAtzLYnH06Z+q7a1bv+dinPacarZFmxFDnkVmX9+qtrfnU66FLXfQ3Tr20N+WFRLzlsW9O/Qx4Om5Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgJD9wLA; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c5e39d1db2so84352185a.3
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 07:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742998201; x=1743603001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAknjqi5ofJbFzoVt7wCX3+vBejJwzZAlNg3vXeX8Nk=;
        b=MgJD9wLAbhqqSE7mTjYhqhDmq8VuZNOv0Eb8tNBv5GUYo4cjb1G/6F4TUa6k9JHBdu
         BXHZ9sX5lr1xlqtId6jteIbN9N2UZ18oJJrCdmQLJ5oyVFBysIYAttEw5+eqQ+DP6hca
         Vi/Cu0rrwQad0znILFCBITy6d8Qagmw+B/7QShyUIsaTJY/NnSBeL/n4zgDpouAhcWt0
         PbzwTtXuMzFCShwehMDQucfPNfjyGy9lmx9MAvxKETeuVCprCrdT1z69qauIjw44cOmM
         t9rqDGpio+M36gd/TBPoMXqh7ZOGr06j8+mvWBMopksb5ptVEypLV02m7SxY3JzfVplb
         XKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742998201; x=1743603001;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CAknjqi5ofJbFzoVt7wCX3+vBejJwzZAlNg3vXeX8Nk=;
        b=KCKcI28Z6UzcnAyD0iR+begyehNjd7pdInwcmtzGKVWR7071aI7EOjaUqZpJpxhsyC
         gD9XxD8UvbtcY4I2CVhRZe7WjxjEiuaxSiir58yW4wlQnbri0qZkc3tz7uTbcrAJ3St2
         Oq0200ycE1xvAc/YG1vXhrlt7K9Rg/oc2+j73XlSXCoflXUhcRiuzHPTmJfu+eATmLyW
         i4Y24ODYeSeYhxpK66yF1/Dus9Y0KKOtqbhIjm88kEwfHYBg6BOIrLinp/vy2NxuCoOJ
         rGKRcL8pCUjSYO3YnproyB7ma1trgcrIImxDhPw3dQIO5rZYe57KaLXZ+EEcPUToUz1o
         UKig==
X-Forwarded-Encrypted: i=1; AJvYcCVBfbaQF+wAED8jykKy7pecMrD+h5SB917oK5+p+3E0EBZsvPKxWYNnuIF1EQ6Y009FqiCZb5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+A/zZq1CrvU2HdZqkCJ+sWJ9U+S7jCSELi7ivLVoLvp/M6ng
	AuDw/+W643DQHRLgyIt1bwuKI9ttd1MgRHDig8CIUgsgm1uUJYchLMzuIw==
X-Gm-Gg: ASbGncvWzY+qrG5EudUUTsTViYpTu0+tLYtHrmzERJBwKktekCz1EjLIhLeWE+FqEoK
	OhCqgtJKVDXxRYd/lHxYFWY8HZAMl+IXnGHcMOPZQLaAeCs+6AT5IqikZbT693ecV361YKNMOXL
	+JLyhKKKQ0dr2bCrXIpQOMVzpMC6v4YpjF+viDujXe/1yfZtuDW4zb4bd0NNen961d7102Ugs48
	P08gz3mh1VjAIn9M0kX6wSHK4Jix4Tjg2cVDPHR6wTo9uKcq3Xu0aAMhElVTyrQ13BDTqqO9EbN
	dbw/nuTVgNYBsC9KuXJgzHAag1T4ZTSqpoyKeQVgXHhs4tS09XMHUq9lJYSUQhtTeYwZQj6kmFG
	AamJGbpPmU5CygVpl+Rc97A==
X-Google-Smtp-Source: AGHT+IFgp5uaWkit8xB/KTZidRyR4MAQpHvWQeO8eGBgFt2QfdLePIbqPRpdWlUIMtteM0hSelPVjA==
X-Received: by 2002:a05:620a:40c7:b0:7c5:460d:45de with SMTP id af79cd13be357-7c5ba133d4cmr3302877285a.8.1742998200597;
        Wed, 26 Mar 2025 07:10:00 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b49a2sm772286585a.1.2025.03.26.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 07:10:00 -0700 (PDT)
Date: Wed, 26 Mar 2025 10:09:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <67e40ab7ba532_4bb5c294e3@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250325195826.52385-4-kuniyu@amazon.com>
References: <20250325195826.52385-1-kuniyu@amazon.com>
 <20250325195826.52385-4-kuniyu@amazon.com>
Subject: Re: [PATCH v2 net 3/3] selftest: net: Check wraparounds for
 sk->sk_rmem_alloc.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> The test creates client and server sockets and sets INT_MAX to the
> server's SO_RCVBUFFORCE.
> 
> Then, the client floods packets to the server until the UDP memory
> usage reaches (INT_MAX + 1) >> PAGE_SHIFT.
> 
> Finally, both sockets are close()d, and the last assert makes sure
> that the memory usage drops to 0.
> 
> If needed, we can extend the test later for other protocols.
> 
> Without patch 1:
> 
>   # Starting 2 tests from 2 test cases.
>   #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
>   # so_rcvbuf.c:163:rmem_max:Expected pages (524800) <= *variant->max_pages (524288)
>   # rmem_max: Test terminated by assertion
>   #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
>   not ok 1 so_rcvbuf.udp_ipv4.rmem_max
> 
> Without patch 2:
> 
>   #  RUN           so_rcvbuf.udp_ipv4.rmem_max ...
>   # so_rcvbuf.c:170:rmem_max:max_pages: 524288
>   # so_rcvbuf.c:178:rmem_max:Expected get_prot_pages(_metadata, variant) (524288) == 0 (0)
>   # rmem_max: Test terminated by assertion
>   #          FAIL  so_rcvbuf.udp_ipv4.rmem_max
>   not ok 1 so_rcvbuf.udp_ipv4.rmem_max
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

