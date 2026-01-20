Return-Path: <netdev+bounces-251392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80BD3C2DA
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4472C5C8DED
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09FE3A9D98;
	Tue, 20 Jan 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQcghgqw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tmZGoWGf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CDB349AE0
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897765; cv=none; b=XKffkFw6ZtfQwBb9GL8gtgEWU2qvaMYunVeFnRhllKGnBjVhT15r9XUf0neLZhQZl5vJrFC+OkIOZC1xyX0YZx6816T4i7ASJQPlZyMug6Y18AibBXTwNgGwnJwcdHMBYaYgg/w+m6g9k62UgDQZOZspwcF/zi1Fm5OouidgYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897765; c=relaxed/simple;
	bh=0F5pRAQiD9A7ImGSSjD4nj69O4xpOqN06FuQAahRYFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5BTHxGDOoAlIOKg92fVONt/36SKrNHRPtgY7UKcnzAWV3bpNydc15/TlItZ4ZQXGAicnK/+y1DOm2uaEwLQx+u5AMZ4cT5Sx7j9ovfozEyPX69iz5oOUKed6TRkwAvHSQKG/Ftk7A1FHX8KA4CqhIyfxRMdMqhfsiayDE+P8HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQcghgqw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tmZGoWGf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768897762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mo/4nv+/PrSgsyjtI40Did2BQlBAXqljc5CQXnAr0SI=;
	b=jQcghgqwAulTvGpKSn6zDFP52Ygz8Qyom4z6HpY5rOSFYbBdGv47gvT8bW8RKDJs/FvOzC
	nQSbfKD9sFuEIveXy7Eob4ShMy7Htbn0DGseqR/+t6sLgOXQfg+v/3a4VfwQK7O/EjEInf
	GD8KPlDQvcRxoLq3fqquTUkMl3zUbdk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-5ya8fdDFOW2l3JePW5yZ-w-1; Tue, 20 Jan 2026 03:29:21 -0500
X-MC-Unique: 5ya8fdDFOW2l3JePW5yZ-w-1
X-Mimecast-MFC-AGG-ID: 5ya8fdDFOW2l3JePW5yZ-w_1768897760
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477cf2230c8so46409855e9.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768897760; x=1769502560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mo/4nv+/PrSgsyjtI40Did2BQlBAXqljc5CQXnAr0SI=;
        b=tmZGoWGfUQp5bKq99BNvoFAsxhGLDV5qlHpsCH28x0xyJs8svtvGbJ/DuYYn51a9LW
         2NILBa+FBeGNH1ttgmdB9hM8Vn1HWvub43umd0+BXwZrC3EOSDAGGZ6SatnsJmi8YRiN
         waljM6Pq7mUNbA9fP8CqqOwvIxfmOpZ/uiuQ55LXEAN8IaYwbiyqVNJha0+Ao64V6c62
         KC1632Ckws5EFjv9ga4KQeiXnwLoXO08wINIqR8CMdLwKSStFRmU0TTWJUJkQdsWfKU5
         MQkjd5ol2f63rUd3ZxPgZfxykabxA7l3l+gcSRRNKoXihuBiCYewTwjbikkHTlufiMcn
         /CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897760; x=1769502560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo/4nv+/PrSgsyjtI40Did2BQlBAXqljc5CQXnAr0SI=;
        b=g4UJ9J6Fie83y/81GMnz60M2y2TVCDeAMa4Dxrxs0KWBxsb8ssjCAuM4dUDjdiphsF
         TkWFVdBb5El3JbO+EpPGatfy+Hhwf201RCCdhKPwHoHXb/BqW/8Iggbg4t1wfL3CGuPM
         MdkB1LmATVXV9FdQwO7pfSvvRXmnI3i6HZRI3qhOiQgF8jIEJVlWnG71YQPX4OPM9jZ8
         u2LvpWCjNF6zDeo/i+iiTcrUWyMzJb/4jTpuAhYCBsE0JkTzvBLezbs9JexR/ZaO1Huk
         I13WOehg+f6YBZK0RzAh6ETjdxzUWGK6bsjVlzZE265djjrjsl6Xf2RRa4SYQx0hWYEo
         QYhw==
X-Gm-Message-State: AOJu0YyGXVy6HkbSNoW+vRTLgvHfvmwGI2FToHnA7JuhBLycDt84HGai
	OhmgXQrrmhtIQL3uMhqK88AQrtFoPvp8bJHqA63dOHjBsMxL0GUoEXoFybCJiRKuI2zGPrIlz8t
	kR3t1vbF/e0oQAULwjmg8x0RC53j8FrPdpQ3j+MC2E9Gj4ASFORiieSUf5g==
X-Gm-Gg: AY/fxX6e6bl+3OQ173V3gryzoPZcXAwHZpRsWBBCY4J86OJG6gBHCchj/8KynUyqhCU
	GbGQfybqBU46Vrj66h4ue2SwOGQY5eCIsWpLLRNopPMmORbI4KDpTVKqnqqRtapToOht1YLhL4v
	3iWdvjlAsQo9WUETf40hFxjob5RkaTIcDpSaKvKqbQHwCwbmlW9/ki85y/L/QEh98x4K/VozfHZ
	orL7hVxcfMvjm9WuoLmG8LlFBpa1x3O/9Mg9Uo6+OkVo8R01wxkUbzDvNCuKjn3d5tyLv3ukfHC
	/1oSPtivDBamRz9MDV8WMdjJ+dP/fF5pHxPMmfwJNdyZXgAJd6Y43jH3PThEuguPAxlVuJuHPRA
	tGVmfVCXwXQQa
X-Received: by 2002:a05:600d:644f:10b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4803e7e8548mr9365755e9.18.1768897759973;
        Tue, 20 Jan 2026 00:29:19 -0800 (PST)
X-Received: by 2002:a05:600d:644f:10b0:480:3b4e:41ba with SMTP id 5b1f17b1804b1-4803e7e8548mr9365495e9.18.1768897759618;
        Tue, 20 Jan 2026 00:29:19 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2672d6sm296787775e9.14.2026.01.20.00.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 00:29:19 -0800 (PST)
Message-ID: <71e30492-7644-4d4f-aaab-9a505f8faae3@redhat.com>
Date: Tue, 20 Jan 2026 09:29:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 2/3] bonding: restructure ad_churn_machine
To: Jakub Kicinski <kuba@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Mahesh Bandewar <maheshb@google.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20260114064921.57686-1-liuhangbin@gmail.com>
 <20260114064921.57686-3-liuhangbin@gmail.com>
 <20260119122203.5113b16f@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260119122203.5113b16f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/19/26 9:22 PM, Jakub Kicinski wrote:
> On Wed, 14 Jan 2026 06:49:20 +0000 Hangbin Liu wrote:
>> The current ad_churn_machine implementation only transitions the
>> actor/partner churn state to churned or none after the churn timer expires.
>> However, IEEE 802.1AX-2014 specifies that a port should enter the none
>> state immediately once the actor’s port state enters synchronization.
> 
> Paolo, how do you feel about his patch with 2+ weeks until final?
> The first patch is definitely suitable for net. If this one is not
> it should not have a Fixes tag. I'd lean towards getting them all
> into -rc7 if we can.

My personal preference would be for 2/3 landing into net-next: the code
looks correct to me, but refactor has IMHO still to much potential for
regressions do land directly into net and the blamed commit is quite old.

I suggested targeting net-next while retaining the Fixes tag as we
already had complex fixes landing into net-next in the past.

/P


