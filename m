Return-Path: <netdev+bounces-199832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9464AE1FD7
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCF74A6DA8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB22EA147;
	Fri, 20 Jun 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="T7RuoPuV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C030B2E9EDB
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435797; cv=none; b=dsCVKbdW0Xmb9M/ADcqYs0E+bDcH5eBzeWYT0dXbUtuVCGw+T3bpTSJpKjc7pvCTdR6l1/eMeWs+SmPvFopl+hCQR/vSRvxEjlBJZNxcCttNM98Y9bxS9SK5X0/SPP1J7lrbGhQQ0iefYHxzbkj2bWtAsjxjtQ4/I0QEyhjswF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435797; c=relaxed/simple;
	bh=iFVVi4SD0YvwzNNEJrKdCVViwyMiH30A2N4p5nVGGjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SQsZrHN581Ny6oLL0kk+HkhxZEVt+l5iExTnAoJSSO0ABFkDOGjYO1DbQGr55kNNZ3TlVGFTOD5VAOQaqB1+fE+UVA2WkLnaSmhj7jr7KOGRjX6uNICSXtm26vI9kV5/Fu6QEgUpnDPtIXd/LUWQBpwZqOJTStjZVElsNT5VL3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=T7RuoPuV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-450ddb35583so2835055e9.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750435794; x=1751040594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4MHwIvFZs7vEBdlpudmn2AZHeZK/CymJMOEvq5wOqyA=;
        b=T7RuoPuVjaxRpgRyQu1hsJWWFe6uvyzcuRISNElaE165hCzrTUK7enTxuRPv/fj3Oj
         WgnxzhnreYd2qEkHB857IoqhsZqPrDmwG3paAUyq4A8D31plJW1nbUS8h60eAPL4M1Xz
         v7Q3mZyNFp+aTj8PLV9WG//KfkH/t0Nqm4KTEKoeaCZau3XgErpnca1S1fe9Ttw6/mvQ
         eer6p2Wn+O5HjVSwuNfGZaulBeFiYoy7w8WBqrGKJNisuUzl9cf4DVlKEudCKt6uGNu4
         Sa90y3lYgRefn6ivuOdeT4rUSo1Z24mcI3AOeOzlzSJEJrcoF/B5n97VMQI/2eZoPSvH
         i70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750435794; x=1751040594;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4MHwIvFZs7vEBdlpudmn2AZHeZK/CymJMOEvq5wOqyA=;
        b=o0JB4wj4u397i9DN+lYSqxv9tzLcrBiiPo05CVQDIw5JqSUkF8e3s65HX7sAxhPluq
         e1pswqzHCZTBK4Cx8H2/EIU6YqE36P2xYtuZn2sNFe/c2tNeao1D/vMpVr4q5xKl1eRF
         ub60FWCXz0ZZfJC0cMY3L6QQyXd7LEIpvf9VCSKEib+QCINxMVVr8gADPJgfr/8Xbx5j
         LDmgqmP2CY24nIttEOKC0ZGx0v3BvJfm+U0qA7Mks0j5S/9groeIaoUnGVpnVWuE0xcB
         uM4DSYp26WcyfEW6e0GG6VZIrQrb1cdlhCR+BGWUZ8xjc47raZ9jy3OOQRwGrBPIDwgS
         WhTA==
X-Gm-Message-State: AOJu0YzN1eEB3X4lFdyUKCb2ALM/lqxZNDA07mN3rvyCI1CHTKeynnDs
	ODoXuDQsRtWnO3fCBu7OR3tD9L/Rm3onbmyjowMX80uiRw078FjXJfSiJ+EbCmamqf8=
X-Gm-Gg: ASbGncuxspNXLJhGRcOrKgFu/EWJbtRSWgMuHO0fq3eSxlwRbowNtaC3uwGLIh9DP2D
	AGr263gVLF1U5+gSRcZVLYbpuHU7+MZ0B+NWuGvaFhZy99/0xlAx7TeREadZdW2jhiD3F6v2h2i
	r0Fh50kR+VrIN1RymcSMDCpd7HXRG1qV9Oh3KuY/UKMHtyiOyiulHaP+h/2pw7m+PgsNQoM8stA
	io4056kfuT5Cat9J4OM0oWf4sU/Hn8h8nQhs3c8KbAT8BpEoXgziH3p+THi0LoaQWrf47IHu3Um
	gSEFMFtS3xCU32FhOq1sK1zjUk6J7+SYUe+xN93SHpr38fgcELzyvfSZKRXsdMCXkxJKqlcxHI0
	T2b1MRt9wBYCYvv0Ha+pA7Tz8cDW9O/5KmKBG
X-Google-Smtp-Source: AGHT+IFN8t0bmdeFCNJpnI3GNp5nOCRtp+46NKWjbqyGgAS4qJRFmSf3Ir+Qksns73qPm7zaAQsYsg==
X-Received: by 2002:a05:600c:1385:b0:453:6124:e70e with SMTP id 5b1f17b1804b1-453659ce97emr14835945e9.9.1750435793789;
        Fri, 20 Jun 2025 09:09:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:607e:36cd:ae85:b10? ([2a01:e0a:b41:c160:607e:36cd:ae85:b10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb672sm30205755e9.6.2025.06.20.09.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 09:09:53 -0700 (PDT)
Message-ID: <d429f28f-f515-405d-b490-9b60e5f95070@6wind.com>
Date: Fri, 20 Jun 2025 18:09:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC PATCH] ipv6: enable per-interface forwarding
To: Gabriel Goller <g.goller@proxmox.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250620152813.1617783-1-g.goller@proxmox.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20250620152813.1617783-1-g.goller@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 20/06/2025 à 17:28, Gabriel Goller a écrit :
> It is currently impossible to enable ipv6 forwarding on a per-interface
> basis like in ipv4. To enable forwarding on an ipv6 interface we need to
> enable it on all interfaces and disable it on the other interfaces using
> a netfilter rule. This is especially cumbersome if you have lots of
> interface and only want to enable forwarding on a few. According to the
> sysctl docs [0] the `net.ipv6.conf.all.forwarding` enables forwarding
> for all interfaces, while the interface-specific
> `net.ipv6.conf.<interface>.forwarding` configures the interface
> Host/Router configuration.
> 
> This patch modifies the forwarding logic to check both the global
> forwarding flag AND the per-interface forwarding flag. Packets are
You cannot change this, it will break existing setups.

> forwarded if either the global setting (conf.all.forwarding) OR the
> interface-specific setting (conf.<interface>.forwarding) is enabled.
> This allows enabling forwarding on individual interfaces without
> setting the global option.
> 
> This change won't allow a `Router`-state interface without forwarding
> capabilities anymore, but (with my limited knowledge) I don't think that
> should be a problem?
> 
> This is quite an impacting change, so I don't really expect this to get
> merged. I'm more interested in hearing your feedback and if something
> like this would even be considered?
The only way I see for this is probably to introduce a new sysctl, say
net.ipv6.conf.<iface>.fwd_per_iface (there is probably a better name).
When the user set net.ipv6.conf.all.forwarding to 0, the kernel should reset all
existing net.ipv6.conf.<iface>.fwd_per_iface entries to keep the backward compat.


Regards,
Nicolas

