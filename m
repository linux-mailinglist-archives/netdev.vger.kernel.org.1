Return-Path: <netdev+bounces-176330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A475A69BDC
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 23:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E19F16C059
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277BC21C163;
	Wed, 19 Mar 2025 22:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgID2YZJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D421B9DA
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742422510; cv=none; b=NPEEjC6lXac6jtElNfksKwUT6+VlBMR1lNVjrpR9lS4GjWVcprsm6NpoEpe1CTgC42Sd0pYnult7geDeuIYLwOu8BhF/Dn6x84BAIOJprwr0eocmbB/lK0Wmgawl4Ne3hkE/N6qI8X7ONFo7/tWz8IRKQ6KQctIxf4q8JnRdkw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742422510; c=relaxed/simple;
	bh=GAU9JELsRjS0E0ycE1mw3vNamwKciJ1tn14RHAz3h9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkE2u2K1ZUpIyddIw+NS83QKXt1sg2aENstnZ3X+eD58GG/msydL6kUCxas/lSSPgSDEGOs967nevUFHsMQR6sUB/afL0fuGdz4oMxwLuZ8xy0m4ue8/h7LVUhlFxFQ5QtmiV0NC6VG/rvmExpwr5RvztyxwIfwq0nLoQgPKqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BgID2YZJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742422507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qyx40AJk9JZISSLmOSMgq6YyM0xAis4sSuMWF6t+SaQ=;
	b=BgID2YZJq8hiNVNdiVjY2CVo39TqZ/6Vaa0KyTveaE9HH9QP7ynD9ba2y9RmRLr2dWZ37r
	LfBcxKyGhK1lL/JADf8oYzUEJ2t8r3xjmFcRkN235vu6UVCI3uTSytNqj/DXiAT1GvkOHB
	kMDhrSKhXBQMUwfF9IRB3Q+RIlvQzxY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-mDSMrc7TPNuC7WRj0pmXKg-1; Wed, 19 Mar 2025 18:15:06 -0400
X-MC-Unique: mDSMrc7TPNuC7WRj0pmXKg-1
X-Mimecast-MFC-AGG-ID: mDSMrc7TPNuC7WRj0pmXKg_1742422505
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so537325e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 15:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742422505; x=1743027305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qyx40AJk9JZISSLmOSMgq6YyM0xAis4sSuMWF6t+SaQ=;
        b=nUt/zGfnXSLqLUY2eBF+sALmnKF0y0banXd5GYPr+zGx3pX7+uaFrqw/sJZKGlgPzu
         FdnOlFjkqOWc6HVGe9T2pvB6cGmfetK678J8Y0zHZZPK6RdEx3QNK38ruVhifENnhBto
         oACl3gycGsGYFdymVpsTJ/YmRnkWlkNFMMFK0g3gUAVrF69ZKXrCXMtyU9jGiPZn8Jbd
         iAEsOXPWBsMSarK4ruRyFbXyh4IZ1HBLotZXSwE3xNoWCxQY5zgoh1M0kRKCVqcKN4Bf
         L1hN9hkp1gkS1T5fZ1HaiM01IPpLp3YHaNlRRQD/DQ1GrkomGOA1wQZ1Lz0aEF80FVtK
         tSdA==
X-Forwarded-Encrypted: i=1; AJvYcCWZN5tsYS/lRK9zz2RbHLmd31Y1YkHqYGr8MSwSnjORgo5ikNe0OlEvWuvKI9zeb0+UKrMg45Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4MUrrUsOdbd9ObL3xDxmJnu5k4wIyxgQYUy2xGzsMP8jz551w
	i7tRNSv7/f00fkWx/YoxpUHx6mplJyKeG5RZgESVw/tx0o2dzxPSSHGrj3iE9yI0LF4Nt2jaUZK
	l2w039UpAfwSS6iGULXpylFFLUTAxAldicWrJZhTeDb6ldh/Zn6Vd0f2UQbgBwg==
X-Gm-Gg: ASbGncsY0IUwEwv7aQqQgnzC6erJhXZkvS2tLmt8M54+bmNcQwiCoQpON1sF+M8K5qr
	Kk3cWNa8FxzSm4vkDlnyua4cFPprfydslsIMnF7sOku/pNPmcGDLC+LPScIYLaw32PjufvWDAYX
	7efZ+gtFjB2sfYRe24Qi+7C45NCg5+lRuChpEASMPT58QWKPKeD+/0DSMQNp9nvsHUf+o+rTYtM
	0hTzVIzFzoZMU+049bMR1ulRYWUeWOQyvmpmzdd4QqWaoE9voUFzMUF8A7PYpaRvB2+CzMlnkPU
	7aor7WsX0ZFcrHF10tPFuEeUMn4FBMsOCumU3OPNiFDe6Q==
X-Received: by 2002:a05:600c:4687:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43d43782c0bmr40146885e9.3.1742422504769;
        Wed, 19 Mar 2025 15:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElIwPkUzNDCiNtPuvhyWgQXHz5gQsgHMUZE31V1P/7fxV2t3drwvN/RDv+BvSvHzl0+3FNVw==
X-Received: by 2002:a05:600c:4687:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43d43782c0bmr40146745e9.3.1742422504424;
        Wed, 19 Mar 2025 15:15:04 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f85917sm30181825e9.35.2025.03.19.15.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 15:15:03 -0700 (PDT)
Message-ID: <fa4a449a-9af9-4106-924e-97e14e7fe7c0@redhat.com>
Date: Wed, 19 Mar 2025 23:15:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] udp_tunnel: properly deal with xfrm gro encap.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, steffen.klassert@secunet.com
References: <6001185ace17e7d7d2ed176c20aef2461b60c613.1742323321.git.pabeni@redhat.com>
 <67dad64082fc5_594829474@willemb.c.googlers.com.notmuch>
 <4619a067-6e54-47fd-aa8b-3397a032aae0@redhat.com>
 <67db0295aca11_1367b2949e@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67db0295aca11_1367b2949e@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 6:44 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> Given syzkaller has found another splat with no reproducer on the other
>> UDP GRO change of mine [1] and we are almost at merge window time, I'm
>> considering reverting entirely such changes and re-submit later
>> (hopefully fixed). WDYT?
> 
> Your call. I suspect that we can forward fix this. But yes, that is
> always the riskier approach. And from a first quick look at the
> report, the right fix is not immediately glaringly obvious indeed.

One problem to me is that I have my hands significantly full, since the
revert looks like the faster way out it looks the more appealing
candidate to me.

WRT the other issue, I think the problem is in udp_tunnel_cleanup_gro();
this check:

        if (!up->tunnel_list.pprev)
                return;

at sk deletion time is performed outside any lock. The current CPU could
see the old list value (empty) even if another core previously added the
sk into the UDP tunnel GRO list, thus skipping the removal from such
list. Later list operation will do UaF while touching the same list.

Moving the check under the udp_tunnel_gro_lock spinlock should solve the
issue.

Thanks,

Paolo


