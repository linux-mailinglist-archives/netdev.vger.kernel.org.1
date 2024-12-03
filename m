Return-Path: <netdev+bounces-148442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7B9E19EA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A0616671B
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A891E261D;
	Tue,  3 Dec 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTtfinIs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1691E2846
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223111; cv=none; b=jL+guOaT4ILRl7AsIoCH15XA+K2EdRofk1HQd6qTvvM+RwniaivFgxY1PsTJ1hzWTP+YEOPkbNyGiSp71zmZLrmWI6isrO1YbjBP4VJmsdwIKz1qz2v8PkhhhrfEt5sqZCm10drABpZIptIBUTvuQOmoyJtiIj6j/KPhVTogNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223111; c=relaxed/simple;
	bh=zCvFg4vEIpOLlT0v1hFR9CAMJ4AmEjDBRmcbbFYBMYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVrybNqqYaQyMynvqcn1cpnHKOiryLQ7zI79I34Sw1WWd+ur9xFsvA3ZA0XOoZzEnEV+5+3OUg1Iimjnjnaxn3bMvETGMdFrHUJi1UbHCxDH39Sl4hpsJ9v6WqOKl7mZhk856vXD+9JOhA0k3iEOHjmQvgjWwRn9Lr2zoR2U4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTtfinIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733223108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHBxos+o3qrEEMMHC+x3OhB+3sIk8pos47xZWNsi7So=;
	b=eTtfinIsYRaYh3VM5ONUI4k5DbQhqMcpuJNeE560ntRDk35UjqeTSA208gZ+epa9oNH/0D
	loSYOS/L99Wbv/QolV9nG6pqKcb+Kxqk012vcmdPwiT921yj9f0L7atYrJ5CLmRSlZXeKz
	usPfybUeuLiPx11xKUdA1rJZ5A9b3D0=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-ii9e5qPeNCWI4x9WgI7GJg-1; Tue, 03 Dec 2024 05:51:46 -0500
X-MC-Unique: ii9e5qPeNCWI4x9WgI7GJg-1
X-Mimecast-MFC-AGG-ID: ii9e5qPeNCWI4x9WgI7GJg
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-515b01f64baso419484e0c.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 02:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223106; x=1733827906;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vHBxos+o3qrEEMMHC+x3OhB+3sIk8pos47xZWNsi7So=;
        b=EJuBmiV6lxwTBkDeMfBHPCqU0dbIG6V7c59rpXLyh4GrEJR8xOGgFxfKK5OwAVEnki
         aJd/wiiOlGB3Gino+M88ofDEMq/+2G6JePSAnHOjc5JM3dc5AbmJnI7vfl5C2NPZBhlv
         6+BAsNav77cqdIytJX62zswfPeDbAdO+VHMFzbBhEVqNbdZUHHOY0iq3lU3RR3FlkcWH
         HVMp1j8yBwi5Q16iYHaahGoOlmhjgkxj2uJuJBn/CNLAdqKPPSPO6wFBYfBOaqzSGi/1
         8VIGiQeDILzZkJAw0TntFIL9JRwrYnZHlSXdGxZr5Xzkmwd7NUzzZEmh8zhHzW+ZAuMf
         I6Gw==
X-Gm-Message-State: AOJu0YxZCq9ELx7jaKyjRd8GjgD8tK+Z2zFmWu3Mip06XAP3qyz38Kr3
	RUDLexgFieLOX+qJ/t4YVPmgwYbRzUqx3WOwJGQKVr95kd+NGGWKH2CTO1EvRU9WyVsgrRqUHzP
	IdR83+gsOWf4LRNXWVomtr+K9eYcXjaHNrEuZB+q+ilb+75WkrmHiKw==
X-Gm-Gg: ASbGncuzBMW+W0Rzxuw04E253lXHGETAiXyuVJV88YNl/ahGe5dw5B5Qn59T8sRqIzL
	/bhNzR+KB/45PY2qf5ia4xqdj8nwgnsYU1RWdWzkOG6xCoLYQq+FKbnMd2+Pxwi9S1QepnKuosx
	+kyDQIkEgI0We2Dim3JHSyDPq++dtp58myd1ae4JyzqH7hskqwvwGEldiLR42+2aSAQZ2mZCo6Q
	rvynbpQvmtuWUaVBoCHOf99TU383IW2AraC6eMkoMl06DqYU0lf7tppADIblWH0xR/GHDRCLQPi
X-Received: by 2002:a05:6122:2221:b0:50a:b728:5199 with SMTP id 71dfb90a1353d-515bf526dd7mr2760856e0c.7.1733223106208;
        Tue, 03 Dec 2024 02:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdkOU+cxeVvQy6UeXhx2+etKkA87xrAvza0RmQEt7J0nuUg9/7W+lTdTD8ONvbnM6oW7eaVQ==
X-Received: by 2002:a05:6122:2221:b0:50a:b728:5199 with SMTP id 71dfb90a1353d-515bf526dd7mr2760843e0c.7.1733223105881;
        Tue, 03 Dec 2024 02:51:45 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8a0c9004bsm28533096d6.80.2024.12.03.02.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:51:45 -0800 (PST)
Message-ID: <85376cf2-0c95-4a08-bcbb-33c30c2f2c51@redhat.com>
Date: Tue, 3 Dec 2024 11:51:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4: remove useless arg
To: tianyu2 <tianyu2@kernelsoft.com>, eric.dumazet@gmail.com,
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org
References: <20241202033230.870313-1-tianyu2@kernelsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241202033230.870313-1-tianyu2@kernelsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 04:32, tianyu2 wrote:
> The "struct sock *sk" parameter in ip_rcv_finish_core is unused, which
> leads the compiler to optimize it out. As a result, the
> "struct sk_buff *skb" parameter is passed using x1. And this make kprobe
> hard to use.
> 
> Signed-off-by: tianyu2 <tianyu2@kernelsoft.com>

The patch code good, but the above does not look like a real name?!?

If so, please re-submit, using your real full name and including the
target tree (net-next in this case) in the subj prefix.

See:
https://elixir.bootlin.com/linux/v6.12.1/source/Documentation/process/submitting-patches.rst#L440
https://elixir.bootlin.com/linux/v6.12.1/source/Documentation/process/maintainer-netdev.rst#L12

@Pablo: after this change will be merged, I *think* that a possible
follow-up could drop the 'sk' arg from NF_HOOK_LIST and ip_rcv_finish() too.

Thanks!

Paolo


