Return-Path: <netdev+bounces-212821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EFB221B6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B2023AEDA3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD552E5411;
	Tue, 12 Aug 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWENvyt6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765CA2E0B5E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988151; cv=none; b=J59kahzp07ZayApM1ECTzDW9EaDt/4KbywevtwysSH6tUO5eoFrqnFWkKEi73ycSr5xXqntOmoQaq4wwII97uzGgGgr1VuuaBRI8dMyF1lAT1UU1dFLqvp9LU6l2bQbZ/cjGez2s0ZwuTBwalco2xermEjfYqib+bjZMn1cqYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988151; c=relaxed/simple;
	bh=dtp145XFdvvxFdz1VPHRgGRMPeqyDu9XOfP84PjCvW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qrt9r4W/1OdAEfj8eGB5GabF8N+sehP+/I7txSxR50FIot6Bgo1Ac/WnyAX+VeeK/bPDBOAezOYe93lOGTlx9QPIQZx5R+VIu92rEX5nDBlKF+fw5ztQgVOgBKgQ22NXt1t9VCMlmHRd92b23+MjZGkz1DO8eI2+LKi7fYCQgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWENvyt6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754988148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rccHfIlp6zESJik0ZhO9CP4dAeru0VA0eRlmjizRq6k=;
	b=fWENvyt6dmF5FT2Tv8I54QIjAwc0EeaK4QQqCp5lbI2RuGVHnCvuk1nS5T5cQR0VIc27R0
	DYk5M+p2aG8WprNmLMnu1AKMSQ2y6rd/RJx5KA+0+L53CzDJEI4t9x0jfbC0EStN5Vn60R
	qtIXOZg/itIXWMXulBjazstFyaGLf+U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-vDYuukTsPu-EL3x7OFb6Qg-1; Tue, 12 Aug 2025 04:42:27 -0400
X-MC-Unique: vDYuukTsPu-EL3x7OFb6Qg-1
X-Mimecast-MFC-AGG-ID: vDYuukTsPu-EL3x7OFb6Qg_1754988146
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b07b90d5cdso65763301cf.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988146; x=1755592946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rccHfIlp6zESJik0ZhO9CP4dAeru0VA0eRlmjizRq6k=;
        b=i29qmh0lmI988Go5iCpDyfwe2gPQSZt8iJ9tPJpHRiPwad0QSpnmPI3Ljr8UR+S2vG
         2pJPeHfDCC1CXkODy+2aYYw0e6tdv6eJ0bDxw4V/vW0VZcuLMFQcAIkDwPm+k4PR0DS7
         qB8ugHwTq9Q6gikr0eP6kl6UsYCN1J1tuqktgFzAp5NeCYqTuomwpWXLNxr5UPMv2faO
         pvRGsUoHtSxGs+VL4ffKQVf98THnjK02j5oteuy46B9scBE016QKy47JWqmBwBJA8psV
         +nalK0JDfPqMOU3sA0q1KsThtZQU5jINFGjBkpm+EiN5cEkojQYiDaFwBuMLhBEi0PF8
         BbPw==
X-Forwarded-Encrypted: i=1; AJvYcCXX1q/x6rOlXBR/XbqMPQ1kZ0sVuEQgpby7yRcUCmY9kl2/LZle3EyPVp4B0wIFYW+l2IAXCqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjdPDVjv3c+mWCwnXDIM7nn4c+p30fTForfQgs79PmZ2Im3Bz
	4Jvptd6Xkva4MlldSg1hhW4Exb6m1rV1622mpyjfdbev932QTqr+pn1hUD1UWdnruNTzxpHUyQR
	AEAkBXb7VzLkT8TkrdwHMqK9vHsDM8tu+9rv+vHNUbxBhYUu4wtnSflagjA==
X-Gm-Gg: ASbGnctt5upddY8Po254I3Suc5RxzNESFWwWJ9zzUc0zG0YFjSUdYpGu8DfzWJL6+9C
	7FLnzLlXERJ+I6rFwrnVaPvCKbS4akfrueE9kUjf5MONkAtc/HxiXnqP//mHdLqR+D/BOJg+ftH
	9MKGu14TtVVlbmjrf+gbQKKJ4lDBGqWe7gp6Za8JNuTt9i8UECAMGDh2KgTdvY3c6EcJeDimcW1
	10wSHVI1zEKsUFi7ID4YbhXGTGTVMFqsEoX3WHkKJ9Ad1JY2OZM4kvXfrTHKLxjq7YGky/ubJ4p
	cLDOA/8c1WIMvVTYH2fhjScCV7yTYf2a2r/aTt2n20o=
X-Received: by 2002:a05:622a:59c5:b0:4ae:6ac4:69dd with SMTP id d75a77b69052e-4b0eccc774cmr33426531cf.45.1754988146489;
        Tue, 12 Aug 2025 01:42:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5D94N3cCmDOj4r29T+dIrmG4oDYTtzUGD5bS0Osxk18qa6XeZXwujzAQBdPNy9e3tgUet9w==
X-Received: by 2002:a05:622a:59c5:b0:4ae:6ac4:69dd with SMTP id d75a77b69052e-4b0eccc774cmr33426331cf.45.1754988146093;
        Tue, 12 Aug 2025 01:42:26 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e85d4f5ff4sm74216085a.3.2025.08.12.01.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:42:25 -0700 (PDT)
Message-ID: <83bef808-8f50-4aaa-912e-6ccdb072918f@redhat.com>
Date: Tue, 12 Aug 2025 10:42:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] bonding: fix multicast MAC address synchronization
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20250805080936.39830-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250805080936.39830-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 10:09 AM, Hangbin Liu wrote:
> There is a corner case where the NS (Neighbor Solicitation) target is set to
> an invalid or unreachable address. In such cases, all the slave links are
> marked as down and set to *backup*. This causes the bond to add multicast MAC
> addresses to all slaves. The ARP monitor then cycles through each slave to
> probe them, temporarily marking as *active*.
> 
> Later, if the NS target is changed or cleared during this probe cycle, the
> *active* slave will fail to remove its NS multicast address because
> bond_slave_ns_maddrs_del() only removes addresses from backup slaves.
> This leaves stale multicast MACs on the interface.
> 
> To fix this, we move the NS multicast MAC address handling into
> bond_set_slave_state(), so every slave state transition consistently
> adds/removes NS multicast addresses as needed.
> 
> We also ensure this logic is only active when arp_interval is configured,
> to prevent misconfiguration or accidental behavior in unsupported modes.

As noted by Jay in the previous revision, moving the handling into
bond_set_slave_state() could possibly impact a lot of scenarios, and
it's not obvious to me that restricting to arp_interval != 0 would be
sufficient.

I'm wondering if the issue could/should instead addressed explicitly
handling the mac swap for the active slave at NS target change time. WDYT?

Thanks,

Paolo


