Return-Path: <netdev+bounces-252933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHKwEH3Mc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:31:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD37A28A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA0FD3011C6A
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B88C17C69;
	Fri, 23 Jan 2026 19:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3egmQKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4F3EBF07
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196665; cv=none; b=owfV8jJt1sFvhqxkGM4HoizK1Zj2Id/UZLSr5vpKcCoFoSgemyPGtZFwlcRDZExBS0KF4h9w35jQCMB6FvafI96Z/RrrPy0W1PTutCyIyxYB71N3q9wDaWz5z7FoPW0h8FFoW1+cnIzVZwSbHLl2ixUEN3X7e4+xiaMbsF15UGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196665; c=relaxed/simple;
	bh=i6tztDjzeZuOiCE3i5SEI4QTvnkCzHxSycXTtdJuMJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoPdcNJewT++E23XKIlcIBNSKfemKNMlKQm8NhN3bPXwZlDu4ka4uuKmjaD79FjGuOQzzZx2VuNIqT7uiTNgwKT6zhsZmusZHCcWOWmMXNJipqmDasWDfYp1014wHpvfAP9+XOaXOABrU+6BoOtBBR0sEqR3k2TC4k7Fu2o/UwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3egmQKc; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1233b172f02so3860755c88.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769196663; x=1769801463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YYGn7PtA1Bgd6nxyiW5JqtYRZEguqQ3AGEFdBEiZxGM=;
        b=K3egmQKcG25LVBui1AiGJ9tu8PW9RjWAAGgyLmUvKxNsyh9w/mUt/hxYYWPJbCyy3y
         mw/ZDDpS2H++Vsz5mz58CTLyqXH5qOjaMjsKded08MRvq4cKYl1ffkmCHCJ/Ez9lUiq4
         as9iDRxECq9DPpTCOGiHMHCpEfISlU7MaJ+TrfnF7LfwMb3q3UUUO6z4pjzzcSvvnO4d
         PZqr5T5UQOuDJwmPIO+ve+rZBvKB+rHTyl4jIciqbU4gQvdPwIl1NrzYGkoodQIjtt3O
         D/SODBsLfTuixzqNQHforyHFqYXUwY9ozYK9jMZJTOei/sWk26jA0vVlE1WiEOJ5MKqG
         oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196663; x=1769801463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYGn7PtA1Bgd6nxyiW5JqtYRZEguqQ3AGEFdBEiZxGM=;
        b=TuVFarBJQS1z6k1Nza8BlCLLM1vmmBFbfuG6QIGtPlvO9lWCt5wiWIB/ErWiRjkZlj
         NdjzouvTNheBeOMto+wPah/1SZkv8eLxtKSexph+XuViSdYOfb9FPQ41SU/CRXKZkfcM
         0t31Qi6It3OYwwoEXiwaAtkM6Lcg1b8CF335NbC+jjDR8110Tk1MmRNgWx9GhKXajfL/
         zQkHrXZofQJNKHfQ/nRvBICUfQG3Psl7/ToTIU8m3y9IJ4kYrJHLv1kFCzm6KTysmGll
         sG1C5opoJSdUKoKBPlYLJL4vZ8aIf69IkZJqfiexGzYQrqUbgbtglSIOZlcPexjkGPlM
         Lteg==
X-Gm-Message-State: AOJu0Yw+WOcrK9/rMZkP5YsybRXLPFHgJaNI1RfRvC7diPuJBS80LOBp
	IjhAOq6WqFJx323XLMb2zxX7h0M86ZpQokCHYaGUdYBhIyZm43Urv9bh
X-Gm-Gg: AZuq6aJBAAHeErkcWQFQgjM2HKqb60njdCr3BPkxKWlGm56iCQClr7SXTjq+VEJbBL/
	VEXKhxJn4r1eA/VgetfNL2zRw+2KTlJPXHKbh1xvsdgwTkoR4jfmerZX2tAEV2NTTC5k7U9cus3
	G/gTEA81T9J6vBsm8YfKRYlsmI5tzmJHaXJt9+G4y8gpQHwY+3wTB6dwo1eq2jY6Icl7WonFwSu
	PtIJBL5YVJ9kP7vkI8ih0D/qLqOxIGqVOme50XqLOD69ymiZ/zZewG8zmecitua2P33Vlyf0A1w
	X7vwHFbxhARZhsmW4atTUYBU7VqVd5Ay1BStU8MxgLUT75wvEtaaEJ2kcbxCvETRc6I6inkUbyv
	RHgMXaBXbVzHtA470bm0jlVPTrgdjjd+7cVvRYJ1xRDWi3HrEp6hltMty11Q3KxqaPqxA74Py8d
	tI9QjrF91vflCQlhe/C/qucAjHSzHZZnswwOfaja+Mm5l51+5P/zAYR/wApms7
X-Received: by 2002:a05:7300:6423:b0:2ae:533d:19ee with SMTP id 5a478bee46e88-2b739b6843bmr2193582eec.21.1769196663180;
        Fri, 23 Jan 2026 11:31:03 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::c022])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a9e1bc8sm4152498eec.22.2026.01.23.11.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:31:02 -0800 (PST)
Message-ID: <a1f5c278-99ee-4e99-a6f2-3a50db4ae216@gmail.com>
Date: Fri, 23 Jan 2026 11:31:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: ethtool: Track TX pause storm
To: Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, alok.a.tiwari@oracle.com,
 andrew+netdev@lunn.ch, andrew@lunn.ch, chuck.lever@oracle.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 gal@nvidia.com, horms@kernel.org, idosch@nvidia.com,
 jacob.e.keller@intel.com, kernel-team@meta.com, kory.maincent@bootlin.com,
 lee@trager.us, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 kernel@pengutronix.de, mohsin.bashr@gmail.com
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
 <aXNAjOjkCqOESf5y@pengutronix.de> <aXNbTVF5KNz1yV-1@pengutronix.de>
 <20260123104031.16d914e4@kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260123104031.16d914e4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252933-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev,pengutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BCD37A28A
X-Rspamd-Action: no action


> Eh, did you get AI to help write the full version? :) So much text :)
> 
>> - Does the 500ms hardware timer reset on "flapping" pause signals? If so,
>>    a stuttering storm might still crash the link partner (tx watchdog
>>    timeout).
> 
> Yes any discontinuity resets AFAIU, Mohsin keep me honest.
> 

Correct, stuttering resets the timer. A pause storm is only detected 
when we remain continuously in the PAUSE state for more than 500ms.

>> - If main case where we will run in to tx pause storm is OS crash, what
>>    instance will be able to read this stats? Are they preserved on reboot
>>    or kexec?
> 
> Good question! I was wondering the same thing. In the end I couldn't
> figure out which behavior would be less confusing. We want to make sure
> that the stat never increments on a live system, if the machines come
> out of boot with non-zero value some alerting system could fire.
> OTOH as you say we may want to know that it did happen while machine
> was out. So IDK. The fbnic implementation starts with 0.

Right, a non-zero stat would enable monitoring and alerting systems to 
detect anomalies.


