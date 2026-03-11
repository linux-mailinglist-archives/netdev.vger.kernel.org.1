Return-Path: <netdev+bounces-266692-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPSjIS+SsWnkDAAAu9opvQ
	(envelope-from <netdev+bounces-266692-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:02:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE2266EA4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03685302E7C3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFEE3E0C5D;
	Wed, 11 Mar 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b6LNihfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68403B6355
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773244903; cv=none; b=kUh5SqbVr8HDc7Wjzl0p45gPCEuCvyATBtzo2dKMg/ATuEYgWVAaQ1fhaCU1eNzXel699KjNObIoXo4MPLZ7s0L/jfK3gcTEiGG4WFc7AWWlG+v6h0L2b+5PgT1K++FyllcrZHjgYBI0NcnEbsNRlbAfVX22/tXY2NsP/9Gz5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773244903; c=relaxed/simple;
	bh=OSYChhkgL9QLYey1/J92a/3Xa/25vRaPcOHe0XnyVg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORXbPX0YZqBJt+rotnJEqptgj7z6DXm9iBov9xEQhjj772Tj1iaRXE5m11ZFE2g+VYvnBYcyAw28+IF1R1vH8K/LBy7OxqzeGIksanpsTk6fqtTG5uPll3SE3aeB77ozcld7spyardqF6HS64m1Xih1/x0kRUV6S8AStLYd20vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b6LNihfH; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d73dd9cb9bso59710a34.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773244901; x=1773849701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XHylZPD43sAa0o/s0snunFXKESFhlWC7FjRf+5pW6g=;
        b=b6LNihfHj4zmwmUhHoJMDn9lu6Z6P+/WprEkwJxmXOnMTT/tN9Y72nWw1vF1mWPUsw
         KlGIA2cLtKkv0ZdMT0t+QiI7HUM0wQkdgBC1HtJpZY03cnU+yxO1Gp9o0U5hHSBHxOYR
         3kNN1ZGUQScQXymv9GNQZ56ke4tM9YicKoGRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244901; x=1773849701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XHylZPD43sAa0o/s0snunFXKESFhlWC7FjRf+5pW6g=;
        b=sT1sCsTYdzmXP3FHFBtbhrvGXDio7bQSKz+A4NQ5Yy/B8aTxfpK/GmrcN7tTcCqxNg
         3CgTkitOdMfqgLgeyh+fMA2cMVBaPnajM2MgpvdpuN1kn9VZtFUy/THzPI9C79BnnYlt
         o1dQkvNo+TURnbFIVwEoGgd0LSIwmAzg0ST4B1zuKWazM2q8vq96n+AsU8f1gKmscWsk
         Zkdm7VTexUwHZDrYUtJITezi/9QIfB2kwgKv6iANtLn25G+1yBndT9B5gVt+SPbKiaS0
         lYmhmUpI677IQVN/rQyiq0I5qlrKuBDPUDLfGuERl09fnAIlVSNYC4jQInld2ogAgBMF
         u0kA==
X-Forwarded-Encrypted: i=1; AJvYcCVBGV/8/iINwhH17G4fCDBlVEicCPVHl75bSOz/GAwKhwH54tfQyo2lTNqqnarvjlDXfOp8ssc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRpseN6Aa47GuMO18VjCxxAFvv50N0j1L7miSarqwYjN5L+PW
	b8U2z761hRpnTAG9+wVOT0wMWa9+Jb5SwzwzxazSazrRBHEWyLrvXXbJsFLkAkMRhJ0=
X-Gm-Gg: ATEYQzwCE7EHqBzL6q065CRC++eyfSE7u5V38V1UamZyQMINaFFTqJn9fkviGX8IJEW
	X99Rf5iTGAZQJtU1S4ed28mu0VD2EXBteROFfGln76PG/G/YAXgFhXoCJVgE92rAHRE3DzntdCE
	cI30pNR1pVJ33iYUTHuyi60wos8ElqKJ77IxW5jK7ueUDasdBjrbpRykk6ZrWkFIs4jNxsnDm20
	ORWe3hu+f1Jrr4Vi/TERo7UC80PU/or9fvdim5bqkJwBq7M+tle0JYrIfN1IbqwcrdI3JTIb8jW
	xrOUfd9Q8dbRBAxzJU6FG68HHZGSm7XCWLUdzAQW55iIYlgXNaY3/CHiSituj0QeVzTPXITr9DP
	eKmICZW0345LyT/1m4YkHESTXqQ0jq+g4ais6qTbM3dkBdU7MQvsMCNKMewX/pZBFhi1+L7pZSI
	rAZbYCgo6bKpfFdL+na4IyF7FNuHn+AglpkGc=
X-Received: by 2002:a05:6808:17a7:b0:467:268d:31cc with SMTP id 5614622812f47-4673349dd90mr1688611b6e.26.1773244900597;
        Wed, 11 Mar 2026 09:01:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467342ef6fesm1473123b6e.14.2026.03.11.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 09:01:39 -0700 (PDT)
Message-ID: <426c282e-862f-400d-9989-f3a572125dd3@linuxfoundation.org>
Date: Wed, 11 Mar 2026 10:01:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: octeontx2: fix typo in documentation Fix spelling
 mistake "Crate" to "Create" in the documentation.
To: ShravyaPanchagiri <shravy112@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, Shuah Khan <skhan@linuxfoundation.org>
References: <20260311024312.6760-1-shravy112@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260311024312.6760-1-shravy112@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266692-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2AE2266EA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 20:43, ShravyaPanchagiri wrote:

Missing change log. Instead of writing a very long short log,
you could break it up to add the sentence below to change log.

  Fix spelling mistake "Crate" to "Create" to "Create"

Also there is no need to say which word is misspelled - we
can see that in the patch.

> Signed-off-by: ShravyaPanchagiri <shravy112@gmail.com>
> ---
>   .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
> index a52850602cd8..c31c6c197cdb 100644
> --- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
> +++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
> @@ -323,7 +323,7 @@ Setup HTB offload
>   
>           # ethtool -K <interface> hw-tc-offload on
>   
> -2. Crate htb root::
> +2. Create htb root::
>   
>           # tc qdisc add dev <interface> clsact
>           # tc qdisc replace dev <interface> root handle 1: htb offload

thanks,
-- Shuah

