Return-Path: <netdev+bounces-248004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0612D026A6
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4246530B726A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ABE345CDA;
	Thu,  8 Jan 2026 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBurWId2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0ZaHClA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22B333EAF9
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861709; cv=none; b=gEcL9aExQsOKcd8oIr7noLIUp36fj/B/iwvIeI8TrVfVitZYvOKpGNVL0vTudW/S1pLfKwRTkJNxU/IxlCd4zZM6eKWgFU0VaAerhyhAjR+Ic+/1F4xsrwxrNiCYMgotx35Wg29apQ4G6mvONLI2gutoi2ep66miH6b1Dw+ppYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861709; c=relaxed/simple;
	bh=T3g1hkv59Wof+KEXGfr6rRK1rS6rPS46Y5/WRoZTizA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YRg+ahvO+qVhVL/DJGd09fR9FVqJ6iHG9giQUvWfMk8uJvGGDI968pPz4TNw9CsOww6k3DxiTTY7rWPwoGjvgaHSo3e3bRgh2CgusXtxx6bLnVndhfNR5f57JAvZtMw7E4bLU22dmoga6jOqxUebNkut4gQjWkRx4Xa+wQ1+aN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBurWId2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H0ZaHClA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767861703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
	b=VBurWId2HqDrerkVnZFpzr+u2oijSKw/y5AwinLgSSqHcGcgpuwRuA5rqmcZWF2crUSpTe
	RgcDPzslfnlUj/2Hr/2KycWtH0/2yuS2lGUT6xY69D3DF84Za6K3U2G1Z4229diie6+XUQ
	c2Y1jJGUlznxQPsD4sy68uJajZBycuA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-Id_QrRnuMkm6-5rgHwY9eg-1; Thu, 08 Jan 2026 03:41:42 -0500
X-MC-Unique: Id_QrRnuMkm6-5rgHwY9eg-1
X-Mimecast-MFC-AGG-ID: Id_QrRnuMkm6-5rgHwY9eg_1767861701
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47d5c7a2f54so11181565e9.1
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 00:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767861701; x=1768466501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
        b=H0ZaHClA6c3KoNXD+3tXrJmCoOMCR4qT4eAFmnf2dOeabJW5fsJqAWfno/Hnr6IrJF
         PZsl7U0+3YU3OI4CFlEzjkH45/HO0+BSrGX9ycowVi6hz+rbrBz7lDIeSMLATjJQ8fpj
         4bcunlq7X/5aKBSUWaT5w7dl3OVtHYcGXCexzwle5no4JMZ2LS/+MjdiFTy4ANdhEH/D
         EyZTVPMJdL1rs56ukgozYGLyIfpVz8OLhjT6Pu9aHsf61+U5LHYQAbpy+Mb13jGJg28V
         njkHf0BGhtJDYMe/xcmy1utfrDHkmj/67hrPfw1S16/xnMmMbWsfk3Xjx2at6abqluqP
         Y8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767861701; x=1768466501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RGxvIn5fQFYR3/ngtCtv4UC6h+IZmTY0D3VzGMTF2k=;
        b=CBn5NJcUdRq+IG7eYJ7ffz5QjgOqB/WrelrcQhHkLpQ3bsejfTCY0kdt7RzVSkMbVS
         lDk6h7kw97KO4Wjy73J7IKNvPVJq2gfDKg8FwTTo0FjpZUiku2pLCSOyKMt/fmOztUDk
         XYYojlLj20UFu1HsfIcZVvJAuByHELJFagr1qDJAbVmfZid6su5vQQVhEW4fUfVLmuPc
         Gp2LviT3l15SoU3GIhTLDa+1G8vn6krG0QXwbRK3MMPjc2h8R5AAf0LrZIncYvVaPNSE
         6pgHt8/QoQmFR3sspFg9811jyCVA6veN7K1CosmcofQ8ea1hMbVd5rgwSQ3nfJiEhX5A
         Np0g==
X-Forwarded-Encrypted: i=1; AJvYcCW+YKezPpLFH7GlCJTOYcE1hW8hmNPlIrFGbLvpdpQQoGLMhdabw2VLdOJdc4JaMlsuGHCMaYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDfBpRYO5pOrDtjsJhn/xxczEddW8tgbetELKwoornBGnIEL+A
	bT6WQdThvjfEkMiPs0/Oxc+xp+ChxHrI+IvwA7feD7zYRF+QrrwW4r/D2dXDh3aSa5iZ6a901Td
	LyEV6JyFMdUbuJ1t1HkMqQaBhble74ks2uLEXOgXiCgB3Gb0QzoXctfy4Lw==
X-Gm-Gg: AY/fxX5yKLUfBXAQowJM9Ze7owJ5gy8BHOkXcDA86ZUEnjPRStB/x6gncRTaUhWKnkF
	iZiMTCl39WhnHrJlDdVNYTVBuy0Wc2UjXTT8mZscwGYQLdfgzHmhoWEZvkZOA4s4OMEiwbtF5KE
	gVcvZPn+lq04GL1Yl5XR+r+oQm3/EXNZZZ4PUIyOAh3QKXYp4oMHnnr0DwpCrXVynLTFHtfF0YO
	Olqdg1VTZZBwGWI/6rG+2t7lWhYdkKHjWGwFZlwiruqm/d2+riye8RM40A/ro2FRff7ghtcnEK0
	eHCpEPnI6E6aAnmVkRnn6jpro76XQ8ljLb3cuvmedBF5cP4mGDOf7Wtgdjxz0GhoYFFvXW87Bh2
	qKWv5jL+09oA9Ug==
X-Received: by 2002:a05:600c:6749:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47d84849fb2mr69624025e9.6.1767861700977;
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMRmXfUT8h/fx23p3HVnSIevvQ/xZpWdXJvjJswXBBTxuR8fZK2hfXFsrWgfe2gcekBcZ2PQ==
X-Received: by 2002:a05:600c:6749:b0:471:5c0:94fc with SMTP id 5b1f17b1804b1-47d84849fb2mr69623615e9.6.1767861700621;
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f703a8csm139970835e9.13.2026.01.08.00.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 00:41:40 -0800 (PST)
Message-ID: <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
Date: Thu, 8 Jan 2026 09:41:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling series
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Hello,
> 
> Plesae find the v7 AccECN case handling patch series, which covers
> several excpetional case handling of Accurate ECN spec (RFC9768),
> adds new identifiers to be used by CC modules, adds ecn_delta into
> rate_sample, and keeps the ACE counter for computation, etc.
> 
> This patch series is part of the full AccECN patch series, which is available at
> https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/
> 
> Best regards,
> Chia-Yu

I had just a minor comment on patch 11/13. I think this deserves
explicit ack from Eric, Neal or Kuniyuki; please wait a little longer
for them before resend.

Side note: it would be great to pair the AccECN behaviours with some
pktdrill tests, do you have plan for it?

Thanks,

Paolo


