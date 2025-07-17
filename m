Return-Path: <netdev+bounces-207765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A0FB087DA
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416EB17ED60
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7316267387;
	Thu, 17 Jul 2025 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tv1OktWJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B435957
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740660; cv=none; b=VapDgXhkIpsssN6YONMpaRuTKY4NCJCwnTZZcPCYJXL+yTgjop9GwVNi+L/NPyOAV4eZ8xrVLuFUaOVQtXZHrneEAPNhdEtT6B2G3NLE4h5hfHVcOi4XDJyq7iIdYoyMdWPJRndkLktePc6x24nfp6/fgjwN0zNBKXCI1atdc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740660; c=relaxed/simple;
	bh=mY2OkeWN/Up78Escl+NpYurOTSn26D+3ST+eXgxbc38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGD0DkrfEsLBfqFBIPgjxQ/vgRpmgb6IeBunRq2kIAY5Rh2M3sAZHEN116zwkVPAaQwdKMwDObxqSLRDZ6XHI+03Ilkyec6phoU0K4aokgFakPqTB/oY3P7xr+oegA/s5vktuIhjFkxcE0254fRs9jZPknE3sRl2fpxnNPbc2Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tv1OktWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752740656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SAlzjdrm6SC0XhEhxFlABzUlteqzMCPq5wuuyHWbXFc=;
	b=Tv1OktWJf3sKjqT3R7PMhl/RII8cc4GiAN1Rvwgr8C0NocyGbCmaHIuw77Pt0I+9uShH/P
	V3vjyAvkw2ORIPXUL6JiwvhuC/FPuXXccGeNN6Hk6R7lw1atbUXnbNCvWj1yEe7W2iEYHm
	zHwGI43ZZRgV4w3Fcv2mUqLubpMHZuY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-_usjLe3kMcKSB1nQxB0b6w-1; Thu, 17 Jul 2025 04:24:14 -0400
X-MC-Unique: _usjLe3kMcKSB1nQxB0b6w-1
X-Mimecast-MFC-AGG-ID: _usjLe3kMcKSB1nQxB0b6w_1752740654
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45626532e27so4245725e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 01:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752740653; x=1753345453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAlzjdrm6SC0XhEhxFlABzUlteqzMCPq5wuuyHWbXFc=;
        b=rVWS2awQEnFtyje9ePExcUpD2dzZA5RWdnhO6DRZh2M4QmP5kucOolwfHYrggTxB7v
         xjBCZImPuNue2hcN+jTd1kUPPT+6r9azqzJOpDB09Rwb48Q7UHIqD7Oxgt3L/i44NNu2
         aaCCfY+0+eJgldnNGsbjFQ51m3drfMtd4MDSKdKefexbEl25wfhdH84dZsTonlWdXsVi
         Whb9G+fdqWe9gysVEcjp8HGp63rgGSHxMXf67WzS4Ola61fmzNvCpFZIesCTdHc+9aQG
         5GUXa+uZtJNvDa1O2vFBqGgKSE9nXB5cfJuAAOPE1W/Xo2FIukPf3WGhsUe+ggf92woO
         a6Zg==
X-Gm-Message-State: AOJu0YzClKv+k9Hm/nS2v9dA/KMbiiDncnf3dFtS2m2c9zKbpoeRl5gn
	nrlWgIlkG9s4YFILjjcFI8kvD7W2v003k2bFIqH8ovtbra3HQPlBH2G6UdWnC5TTTZOVfOkflJW
	0+eUL03W8wMGVk2MuzJ2+dbvRWA0XsebpwnWl9RRFdCeQD9627uuRwmGUpA==
X-Gm-Gg: ASbGncuLwWZMGtOqlOSGsf/SnrRV+Hjjt59yLxMPR1fucx7QMRcBBPwYCLDkRZqdoj9
	yhAU5zQ5mc/aJUoxAnLVbHbjzFAy5a8v7zP6znEv8qvN5XplIK2K4QhE/BClwu/CEAOmSesJbYI
	4zngQLv/rzkLOnMsq50oDHPwcIJrL0n/aYsUKJwxr5OsL3YrREZlB7KQSRUmZI/d7N1Dvxh9n5F
	4ZPWul7paw0zJgDpOkmMNgfci/pV7E7YSJaLly1hINMIPutep4o0Jeh6jdK9eBlqvrXE8iVX/U4
	AuVMT0ewhIojgCOkpGDoctyrsBJe5iFn2Qyyee+njVOwqBW01TA2qgasQSr9bhNrmlIQecnYwJd
	1XhR7o/K6PYc=
X-Received: by 2002:a05:600c:3496:b0:456:2832:f98d with SMTP id 5b1f17b1804b1-4562e298b4amr53124595e9.27.1752740653507;
        Thu, 17 Jul 2025 01:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX5gc870EVKpZhI2cMimL7+R+rPZI8aZB6P2UDNTNus/JMBWJDuTjF747CLEK5Fhj3Rba0Zg==
X-Received: by 2002:a05:600c:3496:b0:456:2832:f98d with SMTP id 5b1f17b1804b1-4562e298b4amr53124365e9.27.1752740653106;
        Thu, 17 Jul 2025 01:24:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f4c546sm15030425e9.7.2025.07.17.01.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 01:24:12 -0700 (PDT)
Message-ID: <9c67190f-62c2-4498-937d-5213de1a3fe0@redhat.com>
Date: Thu, 17 Jul 2025 10:24:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: correct the skip logic in
 tcp_sacktag_skip()
To: Xin Guo <guoxin0309@gmail.com>, ncardwell@google.com,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org
References: <20250713152253.110107-1-guoxin0309@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250713152253.110107-1-guoxin0309@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/25 5:22 PM, Xin Guo wrote:
> tcp_sacktag_skip() directly return the input skb only
> if TCP_SKB_CB(skb)->seq>skip_to_seq,
> this is not right, and  the logic should be
> TCP_SKB_CB(skb)->seq>=skip_to_seq, 

Adding Kuniyuki

I'm not sure this statement is actually true. A more clear (and slightly
more descriptive) commit message could help better understanding the
issue. What is the bad behaviour you are observing?

Ideally a packetdrill test case to demonstrate it would help

> for example
> if start_seq is equal to tcp_highest_sack_seq() ,
> the start_seq is equal to seq of skb which is from
> tcp_highest_sack().
> and on the other side ,when
> tcp_highest_sack_seq() < start_seq in
> tcp_sacktag_write_queue(),
> the skb is from tcp_highest_sack() will be ignored
> in tcp_sacktag_skip(), so clean the logic also.
> 
> Fixes: 75c119afe14f ("tcp: implement rb-tree based retransmit queue")

At very least the fixes tag looks wrong, because AFAICS such change did
not modify the behaviour tcp_sacktag_skip.

> Signed-off-by: Xin Guo <guoxin0309@gmail.com>

Thanks,

Paolo


