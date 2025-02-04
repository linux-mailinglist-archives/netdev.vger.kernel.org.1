Return-Path: <netdev+bounces-162644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1F5A27764
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 939511882259
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8B216383;
	Tue,  4 Feb 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="mVtuRQLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA05216612
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687125; cv=none; b=BDmS+ajvsXejGXMjV0GSqTTfTl+nwEcyVGb2SGfNvcn3i8/eMj4SbZJT5LoDP4ly4kXPMkyhXV+n8UDZ/jyBUGmRDXqEJ3M3h0GtcgCoknfJ5wfVixxi0kGlAgGVGaiLRa+zexHG6onKoNANM+4R8Z2BLrE6AFGOEPpizzKI0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687125; c=relaxed/simple;
	bh=h4YtJRWFxGc+VBOsFApiyqh1XqNP7DcCZBALFYqdrck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9e46Pu8QJupfyG7rKSQ460EWmMeakQ1cePJgZ9WZ88mM/ZkvalgoXHh1PBUTRfGAjsNxD/A+NUqrJpkVAl259PYzAfpm/fML1bNQsNOuikYBSOPYxSVleeQEQQZqMLahZ2uRoRapieCUTobkkioUMfZdKwCBsPVxILnlrWgDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=mVtuRQLT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso10599463a12.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738687122; x=1739291922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s/oi6vLJrFpwJXucCGnRk+gKcQxcv8eGViephUTtud0=;
        b=mVtuRQLTa3kioQO0fetRU3olp9fMOxtzTht03qnYS3D5iWx7VuqSI9K87+oflWiydj
         6PRThyHVsTDhTijOwA3me3ePjVCootApaQrb1iElTT2+yGiuqwbokreEMY35loVIW9gu
         jEc2JBIFQJ5SP4HQrTmwk6PvB1OAJF/SW7P1E6ikNIyQXAu73U5d41uTfOI0BWwGYhUl
         UmNEGFxKCvRTi3i3hNRQTdApHUdTzVlkzGbTGESd7wOs1u+VyVpTmRvM8OT+hlP1xpwj
         ebROfLNpVOtQu0X8Wrct0nQyq8YiFnStoL7238fcLZRnzlX0IknUQR5/6roNrLY/Wvgg
         8s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687122; x=1739291922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/oi6vLJrFpwJXucCGnRk+gKcQxcv8eGViephUTtud0=;
        b=NKldiZZ8AOnnfBIq4KQQQ8G/Ci/OrBA4/Q2gnnF5oggs63Tn3WZ6+OZwvZJpG/QnlF
         2ZeEyCMFzQHUIaOui2jkU6f7zUbJwtHpux9DVOMpIGB33Ohf951enjoCN1J33nKqd6U3
         VwnWUbAzqB1nzRw5PXSJyCM0CGjhH+5XyJHh65s6RWvu8qpud3054Y5qrnDz84ZYTQgQ
         7yfk1MgWhd83MjaM3WPr1K8rBkXtJyMVLDOFpGgq4DpjCul6PrWzkPhS4g2C+8uC0YiZ
         eZMYQFuHGSgpbgwBDoICJt2xDpUnqw6n2wSPovVSqpPRxHwlOlU2nr4vxnI2Ynpyeoxc
         /1DA==
X-Forwarded-Encrypted: i=1; AJvYcCXeoPApB0aIxZcYd1BqRrcMSJ78wDMomYZsz6NHM52CPmKCqTjYGxZXIsdejeGWig5lwHvLHYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/6/TlSKZmifAEEWb5PLphJe9zaXZ/yMH0oIi7X/EP7dUbbnT
	Tv9icXVxJS6J6BzRHSPIFWu+zDUQBvkOGMsOvxFJhoxja77ugRWdTSLEHqUaFzM=
X-Gm-Gg: ASbGncvjaxIJ05IklfyVvys02c3XI6pHeLrYM/nRjARNEf/DcTGtAcc067lp8WFiCNu
	9rytKkLLwqbMfjycFXDJiXb+r2ZCSpE9L/dlQxAn/h92Gqln4uirJZnk2A7cUfrT5//S/ipeTNh
	JNeMK3CL90AEKna25IFlJGTTCdw7Ij0BSqv+hCJWlkORyd5Gx6W8XqA8/2vogzJFKEZJlhPquGg
	TulMR0umZHPR2yE5awXl5fBx8cBxQ7UcshjSzzqnAWTqSIg5fPxPzwKCNtDGe3zfaghVSseEiw7
	r7pGveHDRApMOuts9CDh78xnoEOmUoo8CD+91KBAPW2xLfA=
X-Google-Smtp-Source: AGHT+IE8U1dg9PgxcBKhgIjNnWQN8FwnuJRnSab0/bBNkHB4i+a1p/Q8RRNfGMYfFbU+ri63Ll1QMw==
X-Received: by 2002:a05:6402:248a:b0:5dc:796f:fc89 with SMTP id 4fb4d7f45d1cf-5dc7970050bmr22077414a12.2.1738687122585;
        Tue, 04 Feb 2025 08:38:42 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcc28a4c29sm1585372a12.23.2025.02.04.08.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:38:42 -0800 (PST)
Message-ID: <fc78aa59-ea9e-4d56-8ff7-ce304dc76e9b@blackwall.org>
Date: Tue, 4 Feb 2025 18:38:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/8] selftests: forwarding: vxlan_bridge_1d:
 Check aging while forwarding
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 petrm@nvidia.com
References: <20250204145549.1216254-1-idosch@nvidia.com>
 <20250204145549.1216254-9-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250204145549.1216254-9-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 16:55, Ido Schimmel wrote:
> Extend the VXLAN FDB aging test case to verify that FDB entries are aged
> out when they only forward traffic and not refreshed by received
> traffic.
> 
> The test fails before "vxlan: Age out FDB entries based on 'updated'
> time":
> 
>  # ./vxlan_bridge_1d.sh
>  [...]
>  TEST: VXLAN: Ageing of learned FDB entry                            [FAIL]
>  [...]
>  # echo $?
>  1
> 
> And passes after it:
> 
>  # ./vxlan_bridge_1d.sh
>  [...]
>  TEST: VXLAN: Ageing of learned FDB entry                            [ OK ]
>  [...]
>  # echo $?
>  0
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/vxlan_bridge_1d.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


