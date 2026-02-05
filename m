Return-Path: <netdev+bounces-257216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIh7E0yshGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:42:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5CF42E0
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB6A7303456B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9055840B6E9;
	Thu,  5 Feb 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="sOpKi6ra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B6407586
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302481; cv=none; b=tggnngp8pbhKz4Ah/5PbHiC393+UNzfRlQi4pVU4RlGZbufb5csfWHzv/aYuo0ovb5K67UCvZ4XQRXLs+dOCs29NpERWA8/3/yHyc5agiiRJkI6FdtptA/JvlhxhN4btHu1wvaYUVO3VXT19Iya+sFRf+IeoZ0GYOb8LxeNHYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302481; c=relaxed/simple;
	bh=xv9XqrB6fIUzpEEF7J/468aqjuYRLhV5nJlZyDo7wJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzwlT4wSVAU7lU7i8dJM6W64ZfJOAIyNHCz3cc/96HjNQYdjoAKLLzY0UiWBeY5SOw7GFufA0N/zyA5dxxEXqtQTmJVzLgNmw2SZEYHGBVBMz9lj2zCyeBCZ5jvIifYHoxk45OXg/AdmAOR8iTnvLfPSW0YRJCkB9XB+ilawIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=sOpKi6ra; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8eafb515aeso121971766b.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 06:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1770302479; x=1770907279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqXFNoUbhOdwZYum4sJeZUw29ERhNLD4od5OT229l8I=;
        b=sOpKi6raGLdA8t9HJ85r1Qfq+jT3+DJxHOY6hntDkl6on2LyUZ4NbSoILDrgDrABGm
         XtbF///ZNnecujxhqnc+8+qAkatKFmM+AzyGqUnuC7gNUzOFb6uIhEaOhS7C/cjRo1UP
         iQcxK2Lowr/OaRW817jtycpVT5wP1tHgfg6VHOuDm4ifC7jHmgoglp/sh9aJPJlDKcUP
         JESPFuw9xn7BydAwJwHVZYm0MNZ2iLADXvGoFm+pi9watEBiDzkLV75e5Z1R4v0Q64YT
         eijcQxDLa0BWfqloNx8mGYfB0EaDWshbQEwcgSTDY7V/5toQA1CcQZ1EQxfwYZu6K4oO
         6oXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302479; x=1770907279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqXFNoUbhOdwZYum4sJeZUw29ERhNLD4od5OT229l8I=;
        b=k4NeOFht0ED+hrpTPr/pKLBHny3WMWMbJPwKRHLaFkeAsSi/AEr/s0RAf7Msk0Z+qM
         4FI7w7ZXsaEb6gL9G93Ooq95zJu+sg5rtCMXCHCz6cExSR38MFJzajkyDzo0aMJMkQw6
         4kCM7er2P1pPvZ86Hd1htlpZHOrL7ZbKOiN9wAi8fBrrw2znGYg8MfKGD3g49GNYZOCU
         o+c3+CdCtlz+sCRZBYZjAyt9FiVA4YX88kJNH159zVVWXUs63wRDQuJKv9IcTZ9rUezA
         AQFewPpHjIdmkdMOIBtiqM9P+WemNKDE6892vH5lq1zZisRccsKqTOfKZgE8Tb6SJIoE
         ldLA==
X-Gm-Message-State: AOJu0YxSQEZ5xCBzHhuWQdMwZSNViS785fSBvY+vWgJcuo72oYo5wjM3
	UZOMy2Q//bBEtDQ3wwzAtf6S0bLdzcjUHzUTzh9+pdMhJkOGhDIpx389Lun0y8DYd28=
X-Gm-Gg: AZuq6aJI7JN9GXt56yi+1sF08ms2JiG3j3YXvdjj1gLOmsde0T4Dsl0mJMHo7NioSv6
	EV5hV11MZOlkFI4MCUldxeFFvkeJzPYy4kXfMQsoecxQz83fso7Nm0aintxdKfnmsy3QLAKTXUy
	6N1QNcSU5Lpo4AZYMsEhEPbOwPpQ5J49bwEvPE5KFcTTnjajEfwCLXJJzR4Osn1NYz2DK6McVW8
	b1LXu9vXnIzLMbsu37pXQCn2R5mp1Zygp/j6TnhUAPba+Dhqb7mJ9FVbWmsGkxcA9OlMwqYKK5M
	6Cdq8kRCIsO+XgX5BP/dOR1e8dXiU6ljaz86ZlfdOnK/4OCJTNTIbmyXg0zwQihOErEVnqvzEL7
	a2pNuYalPq761tiMhwh2szsASjokxjW3yHiyUDG3ucMzYPe/Angq4rx3T5S+9bDiUnI+ZhQqGBJ
	toUoB4hPXV1cKj76rvqUmBxs7g3Z/unbhOMD6I
X-Received: by 2002:a17:907:3f8f:b0:b86:e937:d097 with SMTP id a640c23a62f3a-b8e9f3e26aemr502115666b.38.1770302478983;
        Thu, 05 Feb 2026 06:41:18 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::159a? ([2a02:810a:b98:a000::159a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9feefedasm232471866b.43.2026.02.05.06.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:41:18 -0800 (PST)
Message-ID: <a4cfeba2-23da-4fdd-870b-6533b5ce267c@cogentembedded.com>
Date: Thu, 5 Feb 2026 15:41:17 +0100
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
 <237bee8b-a7cf-4c14-9946-8bf72dbddde5@cogentembedded.com>
 <TY4PR01MB142829EB0EDDE13B588F949298299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <TY4PR01MB142829EB0EDDE13B588F949298299A@TY4PR01MB14282.jpnprd01.prod.outlook.com>
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
	TAGGED_FROM(0.00)[bounces-257216-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[cogentembedded.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[cogentembedded-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cogentembedded.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3A5CF42E0
X-Rspamd-Action: no action

>> The driver was originally designed to enable hardware forwarding when not less than two ports are in
>> forwarding state. When only one port has hw forwarding, there is no destination to forward.
>>
>> Nikita
>>
> 
> The current driver allows Linux to use the bridge port as local port to the bridge. The offloading
> Also supports switching traffic to Linux through the bridge port. Therefore, the offloading shouldn't
> Be dropped if only one external port is up on the bridge.

"Offloading" means - forward a frame from one hw port to other hw port without inserting it into CPU 
queue. Offloaded frame is never visible to software bridge.

There is code that allows offload only if the linux bridge device used to connect rswitch ports does not 
have anything else.  If it has something else, offloading is disabled (because there is no way to know 
when a frame can be processed within rswitch hw without sending it to cpu).

Nikita

