Return-Path: <netdev+bounces-113676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F993F879
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFEFCB22587
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F02E154C0C;
	Mon, 29 Jul 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfxAs09/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92441527AC
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264147; cv=none; b=mSC7RIzqCDqXSjDbN6BFFP9VQi7OJ1H1DGCbTLer/g2PznjZ5Yh/2cqHkNwCCpifKc+BDQ971D2oEQzOsVJoGxYxRxZ5hTzugWf7hQXpqfgsgV9q3UozBKeJYRnyM6vEyVq7WYG/KnguGF0EikG+BqCeq3R+1jaSRAtmQnJ0gaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264147; c=relaxed/simple;
	bh=Wh5lTSut92dp/DjC/kt3iMn/zN4wyl/OLKpJdjlaLAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rz3NZEaIld9r4a7Jsdwia6tytTg0SBfVGr6+KPNGfcLlEHWEirsR+vyKueuj85JgoochuOjGLtam3OOG9m8giYLANii5mnq81citEEWy5AykdobgrdLoIXncLpx4ePy3oAVwxkZnAqmcRPm1v5RUdTzThxUxZqqGLZAMEi+OKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HfxAs09/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722264144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IsFjDpcDbjYQAtXewle16fE/z5Mql1ohic0zQnoaTr8=;
	b=HfxAs09/KhVdcUV16EzqRMDtVRU9xtHBe0jthEPTQx09vOtV+xDE25K/JEJimB+Q0aky57
	QFgxQZ4n8zbxxsrho2DUHtpq5hvquP1XYLIo0axq6zQhaYQomAYnPy3ZYsUFh+e4G9rN46
	Bv8CSWgBAr+ZYDoIfypN3lXCShFXa8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Et3y8LpSMbe61gr4qUAIxg-1; Mon, 29 Jul 2024 10:42:23 -0400
X-MC-Unique: Et3y8LpSMbe61gr4qUAIxg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42808f5d32aso4610635e9.2
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 07:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264141; x=1722868941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsFjDpcDbjYQAtXewle16fE/z5Mql1ohic0zQnoaTr8=;
        b=i6wP6Kme0xkj4755qHcBNxWkwikNL23hOqePozO+/a9EmyqOVJnU2lZstwu/xXzFB4
         uRu3vFfxamG2SuzFLAI1fH1nMZHep4ucdUbBGZCEn8iJ/ju1vdViNSu4aIN+07PhSxpc
         4AMMQG+4+NSzFV9rnYD0cVE3ny9ex7NDaaaa1z93krYM68Nwh1EMc2XIJgjftLN7E8wd
         DHlzmYOYXO1rMv3W4U1YiJDSQWUvagrajgxmybU7DvPC30M2uyczeJ8OEYoxBmj6sGlx
         yyPM2he4rkBzmNr0fA+Kag+BNcP5HE/y4Oy6DPqmnMGN0zmBn8ECHCpIxnWUxXll8RCE
         7vdA==
X-Gm-Message-State: AOJu0Ywa7QNMg6RqlJDX4sNpRKoVKQ8KH9Wl5xA1rTp8l0T4DO74c8zL
	8UYL9g5j6e6TF6YWLSU4IC20nMGKtfSwiGSLRa8A/MaYvVHaAsI8JuY5I3ORRm7OWcDUqPTxh5q
	jhb6WCeXPnXI/XjU3tMgOLGwWH3+5kkxjOPDUMFBAR48kuZXWZg/twLcQOGdHhWrw
X-Received: by 2002:a05:6000:178c:b0:368:4e52:5877 with SMTP id ffacd0b85a97d-36b34e30238mr6164119f8f.9.1722264141467;
        Mon, 29 Jul 2024 07:42:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrMUA5d409Z1REOJHTBKL7Y8UaQyA/Gs4MbHiyWfvmqQRgGxxVpGI3i3j/gyWLP9r9hjwuSg==
X-Received: by 2002:a05:6000:178c:b0:368:4e52:5877 with SMTP id ffacd0b85a97d-36b34e30238mr6164107f8f.9.1722264140998;
        Mon, 29 Jul 2024 07:42:20 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0320sm12419405f8f.19.2024.07.29.07.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 07:42:20 -0700 (PDT)
Message-ID: <5fb64fb5-df6d-409f-b6c6-7930678df9d2@redhat.com>
Date: Mon, 29 Jul 2024 16:42:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 00/11] net: introduce TX shaping H/W offload API
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1721851988.git.pabeni@redhat.com>
 <Zqc3Gx8f1pwBOBKp@nanopsycho.orion>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <Zqc3Gx8f1pwBOBKp@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 08:30, Jiri Pirko wrote:
>  From what I understand, and please correct me if I'm wrong, this
> patchset is about HW shaper configuration. Basically it provides new UAPI
> to configure the HW shaper. So Why you say "offload"? I don't see
> anything being offloaded here.

The offload part comes from the initial, very old tentative solution. I 
guess we can change the title to "net: introduce TX H/W shaping API"

> Also, from the previous discussions, I gained impression that the goal
> of this work is to replace multiple driver apis for the shaper and
> consolidate it under new one. I don't see anything like this in this
> patchset. Do you plan it as a follow-up? Do you have RFC for that step
> as well?

The general idea is, with time, to leverage this API to replace others 
H/W shaping related in-kernel interfaces.

At least ndo_set_tx_maxrate() should be quite straight-forward, after 
that the relevant device drivers have implemented (very limited) support 
for this API.

The latter will need some effort from the drivers' owners.

Thanks,

Paolo


