Return-Path: <netdev+bounces-298767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w+TwNc5PLGrZPAQAu9opvQ
	(envelope-from <netdev+bounces-298767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D24A67BAFD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:28:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gBtqjW6P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298767-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F07632DABCC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33D37FF60;
	Fri, 12 Jun 2026 18:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602B37D13C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:17:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288233; cv=none; b=R+vCde6z9oIP3HWdEXPeAh05UaCqIjydNUFIoMZIXBSE2bXcfo0pOpddib/CV+isQpSZ+iWWS723tRH0REmG9QcgOiZp5Ne1X3gRTYBmkjYnJ0z2N/kvnPhLeLBWuVSpTP6Uuk48cNWTQHlKREsaAKr/VUbpfABK4xwIJ1sLODs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288233; c=relaxed/simple;
	bh=p/UozsYJO0z6duo7WzsC3D4cFBwaT5yaJi31DXHhCj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M69sURLURQB9I4Cprf5kiY62LX38iDcqdfk6z2At2woqbeqNgLmRZYU3P4ThlxQnOYfNp+/TLqz4USRpspeJnJlWehuiw14D2bjRER4qQ6vTlDvWylonxcOlrKnEIswBtL5aYU/WiyuGVdWdmYFftGdxUKv5TTAzr2o786COvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBtqjW6P; arc=none smtp.client-ip=209.85.208.172
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3965f215817so12479391fa.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781288231; x=1781893031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKvKH4snFOx3a/w17jY1jRQJi3nETniDRUK13h/HlS8=;
        b=gBtqjW6PYy5OPoT4TwzCu84NVLgmmwe7EG8l5zZbjebV2qLCcqqndLnRFay2P4ixXJ
         tRp8Mcq8f7ZA1AYOV+KdsGrgf5IFeA77A/2iF0zZFI6esEmNGo0WjSuBOwvdYbaw5gxo
         kYW/XcaDu9Ypa6u/oyeunlShVr/4iCVV+LLQF8DEOJelMQ1qc6QSwl5sBgmFIENfZEQY
         lCMorwD5OZOIKOX3+EK3z8MiYe8iqDnFBA/qcaNVYlUj13FQbJRInuRpfne5EqeixJkX
         rDyOlOw/GPWNS845k2lO8jKmlx0ZfPoEKG83W9JPIvpKiN3nvpW3b/TAOqA7FgeyJAu+
         G2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781288231; x=1781893031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKvKH4snFOx3a/w17jY1jRQJi3nETniDRUK13h/HlS8=;
        b=I/pPRc08MBgiNk6caYbfi4Abj0+GrIp3cGZO1Gf49/R95TCbksJB8/s7P042izNgYP
         Jv0I4EMeJuzKwdmZYF7NDhIeccELPGWsj+MjxcDY5YYL6gFSoXF/Bj4j80ewwwuNQ6wC
         jx02DXnov7gJYXv5zAS5LVysGGwWyXbscwklFrJ9g9FZ5s6kWie3tMWAu+/G8MrAVRAS
         BRtSovs14Jj5DDFuveAHx8Q/M636LCc7UKHg4wy7bAl4rMWdW+bFMQdYjOfOSZZLfa9K
         NfEsvt3CLk61auKxbUYAdIy7xVxa2jxzw064AwU7BW50ceMytV+gE2FWyEgAGOkwVebq
         l/5A==
X-Forwarded-Encrypted: i=1; AFNElJ+wRARkIqakP3zjC0qLwWFKBs5pFdZBePKuIGEblrE3TgL/cHMasV2+pAGP1vgaG2krfzvZ/Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YykM2Tz+2n0O07Q4EZmqukUHw2neoscf1c3UUigDEEcWrMsGFcJ
	AWvuzuKLxbla70fDDSmb5SFxGsBewFJyWR4p2qZeXcBzdaxteeYArEtr
X-Gm-Gg: Acq92OFcyNXl1sqWU0K9P+oPCyMhiJo2FUfGnbt7psJM+aPwQ3tjWdtGjAV2Nyng/bb
	qlSY1/+o0U+wXb+A47o6KoYjlaiYxMk60n3Ld1E4vV6ABA2RE2/KXHjqS17VNsZWGQBDPhDPeW3
	uKa+yvhSmSqyCNpUbt1UqMyw8mm65AYq/7yUgrtAmfNyQcP3GqQ5Dp58KLxJJyBnILhFmEyG4zD
	8dsv1KctUR1tAJsgG4SyeoDCTyjd5x04Sca2StDZMdJ9/ELdigHoLLqow0rvU5802A/NnhH6uOe
	I8JDNLk7rGQO1EuI4VOiHA98RGACaMYmHuOh4LSGxVqUCh0a7ZIaz56X2fskw93WhHGKGtj9LpE
	f+pT+Drn3xRTD1FBKBcn3g21xL/5Z9Oq6RnM1qrk298PAYWFrRUAevn3Z46O+j9LKP2uBosU9AV
	xy8aNSvXXEq9caMiO1ks2BHjXeeNb2FE8vJysZ4keDs6EGfpDXpZSEno14ANXdY8HxSmGaErgA6
	oM=
X-Received: by 2002:a2e:ad91:0:b0:396:74ed:a7b1 with SMTP id 38308e7fff4ca-39935620c54mr855351fa.15.1781288230370;
        Fri, 12 Jun 2026 11:17:10 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee? ([2a00:1fa0:742:25a:e03e:6c9c:49d8:2fee])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f4049bsm8116191fa.29.2026.06.12.11.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 11:17:08 -0700 (PDT)
Message-ID: <cc81f7fc-59e2-4cc3-baec-dbf2f8fe5388@gmail.com>
Date: Fri, 12 Jun 2026 21:17:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 4/9] net: ethernet: ravb: Remove redundant argument to
 ravb_ptp_init()
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Paul Barker <paul@pbarker.dev>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
 <20260610102432.3538432-5-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260610102432.3538432-5-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298767-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niklas.soderlund+renesas@ragnatech.se,m:paul@pbarker.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:netdev@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:niklas.soderlund@ragnatech.se,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[ragnatech.se,pbarker.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,glider.be,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sergeishtylyov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D24A67BAFD

On 6/10/26 1:24 PM, Niklas Söderlund wrote:

> There is no need to explicitly pass the struct platform_device pointer
> to ravb_ptp_init(), it can retrieve it directly from the private data
> structure.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

[...]

MBR, Sergey


