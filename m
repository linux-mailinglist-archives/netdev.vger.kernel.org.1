Return-Path: <netdev+bounces-257033-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK1eGPFOhGkE2gMAu9opvQ
	(envelope-from <netdev+bounces-257033-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:04:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08356EFB35
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2560D30689AC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC75360729;
	Thu,  5 Feb 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="OTLFZ8JU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7A35FF73
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278335; cv=none; b=EudsUiBUnMvUBCJQbERzKlRBGe/qOsU1M5k2c4qud77fPrHshf3f/wcZ0L8mVYs5535fbt0+6k6tHfVrQTQnQb2n920VHj0g+s283yvUsBjRH2imrW5UkIo7RMs7/04W3j/EUcw2rZCzwDqOYCjfIbEYwjDL+uRvWeI9rxyTjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278335; c=relaxed/simple;
	bh=sZQ3YwewM9Ai+7WG00Ix8G/HdOMYfSXLaxEv1z7nGr4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qYjyJY9lC/Zkq4GCiESedlPERSHUYcelquJJdwrjDyBSMNSpR1yWd5ajz0MR4N9qtvL6uzb1HLymZKqjUTsbE7LHSkLELyNW+zYBwYrmIAtJPJKCteJFL0q2tDOPwNVNXwiM9uaS8Z+pMvXeHemZaUPJcWZwhVMlkn0vlx5xmAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=OTLFZ8JU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4807068eacbso5089985e9.2
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770278334; x=1770883134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kv4UVvtp9oTgfg4NwZs5j17xsQoACWxzr3TeGIM+1uc=;
        b=OTLFZ8JUwzyHB61KICJ/1PQ18g5HGVT7ZgNC/swVn9PjHsytoKdwI8g96lVNb5wEpY
         Rh/ReKrNM+AdxTCtbpBooPNiVMo9O9GvfkXGDySmI3ibQBvq0hnKrjs+KgTDfCFwtGAD
         XebrjxO6fDNe0SZoHk4gqbRbzIB8w0B9j0Kncsmj7v5wmNpEuqZjS/h8yq2XyxUwvPaI
         4NpGrJ0NgOK/rGUS2WdSdYZdabvkMuLHzHqPEnweLu35CUf9KhEGieoRDalJqSjHC0ps
         /6xXDmeGOv8ym7AjtApliErqaZM+qhS6lUErnPC7cbLSf5nmvxuv3fmZF9PS0WBP9+s6
         2/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278334; x=1770883134;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kv4UVvtp9oTgfg4NwZs5j17xsQoACWxzr3TeGIM+1uc=;
        b=J5sNpvteHDpChrcOrYUH12Ia33AugIf7jlwPpnbA51QWp42h7GMrKduJQfVPXfkRKR
         cdfywl1YDIB8kRO7uIeJd4ZW0wotf7r7RJiaI/4iGcwNnJlsCtW9vh35KILwmmAA7nM1
         KfAzNQubRGx2abNpGhr4Yu2dlpiP0IK79926DxU7/ItSQn+/3J+S7ZYAPpGgoANOgHVH
         uy7GR9gXNhlL9Oy7ci48MVTvcaAOt4D+cL9YCcEXr4NsCLsMjlVnJADCh0Mh7EvIzlh9
         4raYtmDlxSxUnNtBE/WnJyXOJRTRfdW1hhyv7D4/cIMPzA1+zp3sQ26R1ErLRimWR9Gz
         mzmg==
X-Gm-Message-State: AOJu0Yyui6yoO5K2Z3F5wS2SD7X79OVOj10s9B36KK0srx9owF5aQduA
	S0xPVvB2NYKdesfpVZbM0nvzFbvmtv9reS1MPAfKMmA6box7OKxrGTLFhbQOuWysU00=
X-Gm-Gg: AZuq6aJdc6/7GV++BvzR0mq4t3FLgwic/5onhMVL6JoPL31rfsY/H+e1svey2eADwru
	alxC4n1GHMGFxg4Yh5Y2ZO9pHUewSkr0D195WStnJ5HsnfpHAFAhOf2MvbuWvpzq1xLWzKy/2Zn
	Apit/3v2WKYjNkwsUZMsBroCQJa9V9SIDbyI3IGnq1/UBrZvRcZweP2t5DuyV+578YAkkV2ASBT
	ZIvvMt4XLklikTCVo9djJwRqKtFG3Ytc3a7wwFs1h5ZAGEsWFunE4qp19yHExpQexG4BfRubxeH
	QgcdC1k/udJLAuCfo5xjzmHla02QciqbCT63WwM+YRN8tpmjC/quLojh1EXZX+hr/MoO8MxMyDo
	6EuvjlIaain9iTGEQ0Id/5rURizEFPnF/mvz3lYNP0hKVbbEsLSocTFbeS7IbeCNBPfar8Zx/Fm
	94IonKMWmn+IF3EFFJv1UGR+ZrOnupSe8zUyRomRD6EAWbjcg=
X-Received: by 2002:a05:600c:154c:b0:477:abea:9028 with SMTP id 5b1f17b1804b1-4830e92a7c4mr78949725e9.6.1770278333677;
        Wed, 04 Feb 2026 23:58:53 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::b3d5? ([2a02:810a:b98:a000::b3d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe69e9fsm51569315e9.6.2026.02.04.23.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 23:58:53 -0800 (PST)
Message-ID: <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
Date: Thu, 5 Feb 2026 08:58:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
Content-Language: en-US, ru-RU
In-Reply-To: <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-257033-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cogentembedded.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cogentembedded-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 08356EFB35
X-Rspamd-Action: no action



WBR,
Nikita Yushchenko,
System Software Engineer @ Cogent Embedded

05.02.2026 08:47, Nikita Yushchenko wrote:
> Hello Michael
> 
>> -        } else if (rdev->forwarding_offloaded) {
>> +        } else if (rdev->forwarding_offloaded &&
>> +               !rdev->forwarding_requested) {
>>               rswitch_change_l2_hw_offloading(rdev, false, false);
>>           }
> 
> Although indeed the condition in the current code is not correct, I'm not sure comfortable with this fix.
> 
> Full condition for a port to be a valid candidate for hardware forwarding is
> 
>    rdev_for_l2_offload() && rdev->forwarding_requested
> 
> It is not obvious if at this point rdev_for_l2_offload() could get changed from the last call to 
> rswitch_change_l2_hw_offloading(), so using only the partial condition at this point does not look good 
> for me.
> 
> I'd suggest to either change to something like
> 
> if (rdev_for_l2_offload() && rdev->forwarding_requested && !rdev->forwarding_offloaded)
>      rswitch_change_l2_hw_offloading(rdev, true, false);
> if (!(rdev_for_l2_offload() && rdev->forwarding_requested) && rdev->forwarding_offloaded)
>      rswitch_change_l2_hw_offloading(rdev, false, false);
> 
> Or maybe just
> 
> if (rdev_for_l2_offload() && rdev->forwarding_requested)
>      rswitch_change_l2_hw_offloading(rdev, true, false);
> else
>      rswitch_change_l2_hw_offloading(rdev, false, false);
> 
> since rswitch_change_l2_hw_offloading() has internal check for the current state and returns early if 
> the requested change is already applied.

May be even better to add

   bool new_forwarding_offloaded = rdev_for_l2_offload(rdev) && rdev->forwarding_requested;

at the beginning of the loop body, and use this flag over the loop - it will make the code shorter and 
cleaner.

