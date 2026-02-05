Return-Path: <netdev+bounces-257188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIAaNAKjhGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:02:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4BF3B5D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B95C130579D2
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1963E958E;
	Thu,  5 Feb 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="W94ksg2a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB493D9045
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770299841; cv=none; b=pRQ3lYGtzWRnOmjRQOrrf0Gkmep4zO8/8BkXerkC2Ec0tsmHraYDBK4dUzKs+qjsORcs3ZLiIy8VV1Dxd+tzXm2G4seEyNtQOknIh6eBgddWLBiJQhwzfzxyjNGbFAg1B+zNlBItpT7BkT9S0jM2GklTpjGjS07d/03yw0+vGCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770299841; c=relaxed/simple;
	bh=zXTe+BYDJ+Z/ekQAgc+SG6itGOz1xj6zpkfaFjywm7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ch35G5SQ0RUVidu2A6kS4V1p70J52RRbiyIRoQ4v3UCcc+J6aZA85sz8QgqHCdj8GA2TolBiVXnbDJcZ/x6N1FPmOjk4lNyxbV87ZZH0Sfq6/1pM+A+eBSCUkV/CsF6nF0TeL4te+Dped1oXMN0fpouCda/kXNk/UTkOfK1RP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=W94ksg2a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso10988065e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 05:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770299840; x=1770904640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//Oz6Yho5HmPa1EIIL5aLcfVNr7sW1OS3X7pkoStOfY=;
        b=W94ksg2aMQVp/wHtRbkRa6pSHVwT7qOfk/wtu8OoawW1AE9Ms2S56tB1EqIliS/V7X
         bKBznGzd7v7ej4JqHiY4VvsjSP71+3SWFo/whvx1SIF29QFfm0bZ/w3A6DWaMar42o/j
         rP9Stgo2AMoAn6PfPAqfG46yPO557ImnVblgzoWiAdcpTEJ7+eA683CIqAcmPNe2t8wz
         kxgEApDYaJBvSrvf3FnvY58CBxq/JFr/WHI9uluSMIa250TYA8zrKubCQ3FFIVktUZed
         v45PW6LS5Hi+TOEzr7+cAYl1hY/NtpXQPRbpsINC+KOLuSvhgburFeYl3SD1PufEOTDQ
         lZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770299840; x=1770904640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//Oz6Yho5HmPa1EIIL5aLcfVNr7sW1OS3X7pkoStOfY=;
        b=NazTy4adKc+liyooGz+/m9gcu0kTPwxQ0QDMedZbRUP9CjoV/7SpgpARzb1HV2CAlm
         WrAHA5NWYkh57NhEns34r3jLuy9IRgTGgHVJCno0RARDmzWlsX6jHQ56Arsmicr1dkDK
         aECDoF/dL3MwBXuWMID/pZO4am1esXJ7oMrhyoN/ZTNxY5b+pp64D3y40FxHcvMjER+v
         SXEzizX1awduGVlucq+vtws7WiGO5nJ+zyFUarchZscDeVNd+91oBbG3Ilr4lnp8kxbE
         +Zzj73xzar2C1pf1tHwRja7LAoGRmx/iK70HTFTNgVkEyEiGL+nr+N0CKNar8oRQFDvh
         wVjw==
X-Gm-Message-State: AOJu0Yx+9F8appR+9kGU6i2kbkRqYAwNUk4ZoG+g+AYuSCKERz3Pi8UY
	vQbeRt6JRsQHQyum8MrqFAvpOwDV3Y95E2fKZoNmtBwHX7z2QQW46ZplUIvfodbbTZI=
X-Gm-Gg: AZuq6aJPijqUBp7YS6nHkpJVaIBu2f4760Mc5HXs6gyqtr1Fu9xyX46Q5yTa+dsi21E
	oKSo9v+TuDAfKtB0GtXCsNNuamXzItG+8BhlQES0X8UEfw/FtR4sHrOfkyXug3IlEi1o0+IEWdv
	/TH3SDXbXGf1uNXZO9rUsCEu3lizOkc9H6KAg2oZ3FEDDrWTP9Y9FCL1xgYywaWBShPrChsBC4Y
	DXTDvUibGEryqWeFE0zMk5XthnDqEqJW713L9w3UQpAUh9+0q6egE43PMkqkjL/KVieWu7PYkrV
	IxFQ3TRByFLs6hLsxUVH60aLEMil0H68MseD8CVcNFrfLie9BCZD3deJ/zigmqoAc/LqKIFna51
	uE6aQoWG71Ot/rVnMd9MmIi5SataZHTzB7G0x0KjBJGaBDec8QeEi1H0lgYUzY/geQcQHRC5aXa
	G5sdYPnThM0iFlFrPC0jJV0QvXZmUyHYYI+E1amHQMNQ3CdMk2u16ocn6RPuf9GBzYYADvqg==
X-Received: by 2002:a05:600c:3e0d:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4830e96fb0cmr74468735e9.20.1770299840013;
        Thu, 05 Feb 2026 05:57:20 -0800 (PST)
Received: from [192.168.1.2] (ip2504fb9f.dynamic.kabel-deutschland.de. [37.4.251.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d2085asm63423095e9.1.2026.02.05.05.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 05:57:19 -0800 (PST)
Message-ID: <237bee8b-a7cf-4c14-9946-8bf72dbddde5@cogentembedded.com>
Date: Thu, 5 Feb 2026 14:57:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: renesas: rswitch: fix forwarding offload
 statemachine
To: Michael Dege <michael.dege@renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260205-fix-offloading-statemachine-v1-1-640224a531d0@renesas.com>
 <3b1405cd-6c7f-4883-95fb-151cab223a68@cogentembedded.com>
 <d6a9356d-6fd4-459b-9c5a-2f3e20368bbd@cogentembedded.com>
 <TY4PR01MB142829D9748A483ECAF19FD3D8299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
 <25ff0841-545b-433a-8e88-6e463ea718e7@cogentembedded.com>
 <TYRPR01MB14284CB75C7DCD35381BD17EE8299A@TYRPR01MB14284.jpnprd01.prod.outlook.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <TYRPR01MB14284CB75C7DCD35381BD17EE8299A@TYRPR01MB14284.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cogentembedded-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257188-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[cogentembedded-com.20230601.gappssmtp.com:query timed out];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikita.yoush@cogentembedded.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cogentembedded.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cogentembedded-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7FA4BF3B5D
X-Rspamd-Action: no action

>> Quite strange, is anything else logged?  E.g. some messages from linux bridge layer?
>>
>> Nikita
> 
> Here is the log from the version without "if else"
> 
> [   83.107759] renesas_eth_sw e6880000.ethernet tsn0: Link is Down
> [   83.108734] br0: port 1(tsn0) entered disabled state
> [   83.109669] renesas_eth_sw e6880000.ethernet tsn0: stopping hw learning
> [   83.110519] renesas_eth_sw e6880000.ethernet tsn0: stopping hw forwarding
> [   83.111405] renesas_eth_sw e6880000.ethernet tsn1: stopping hw forwarding

The driver was originally designed to enable hardware forwarding when not less than two ports are in 
forwarding state. When only one port has hw forwarding, there is no destination to forward.

Nikita



