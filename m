Return-Path: <netdev+bounces-280735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FexA9cL6mn4sgIAu9opvQ
	(envelope-from <netdev+bounces-280735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:08:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1FB451C62
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 14:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10369301D621
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ACE3EBF1C;
	Thu, 23 Apr 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH2YXuPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135DC3E0C5C
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776946115; cv=none; b=ooDv391hpr0QCmlRWP8THiEjWMy4v46UUKfgBahANbuY/hz1QvoXhgLT3GkTRuq+bHpDB2F3jT1AFH3WBiETh2vxZV1oxbvxgDWR5guCupY07TAoMm3RHRZHWiwzY0u+HMAoweuvXiyHH/NxjtX/q5kJX8t/9W4m/frN0tHepwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776946115; c=relaxed/simple;
	bh=nbvVHypLXYe4HQ6kM/FsSGnZ/2YTCBEdf3DpEFbQvMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/n3uE/zh0S4K1AalpLzCvwXF6RHq0GyYp7oZsqKa8z0j9qK+e6WODT/K+Riu2VVo7GolYs3XL1Pw6LWWET//6p6WPEGNUY6Sk2F27HB6YFx1GxlhAqsRMF7GfZ89E3QsWXeO/hjmCwiu1t5orunFrkQv/eJHflBUaBJ5Pc+Wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH2YXuPe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9d9971d059so971313166b.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776946111; x=1777550911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SRhug5EctNOjlbS2XQzhvxEAEMbzIA+RUPcEwvw3GOY=;
        b=iH2YXuPemyx6UQ5/DLT4XzWNHQyMYf0PWZT7fmchSobAgF18y0Goq5IFqyNwCpEz06
         6Q4l4yeqFakEbtMtkFsrVp+N8DYEk/jJ/RUe/kGVUuvLjXt1Muob8afevP6OEiKwKzRP
         kc3PYvaUelGmcPillTbSFMprLaBoDsg2hrR//RLW4Z0O8XnNdHKHJbMm1oaLtNlrVy2j
         o82KHUojy6KCJmpgkak3wpVNCqutY+4dNNdW3sCykGaGp7XVoWWvyj63rDbNnzMzzsXs
         e2plnUW7bR7lYA+mJLUqsHZaZFdI+O902QcE3Qs6FEQaf0BRHll7lkQyisBnIBuraKUM
         pNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776946111; x=1777550911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SRhug5EctNOjlbS2XQzhvxEAEMbzIA+RUPcEwvw3GOY=;
        b=eacMIXbi7R9f3H7PJFeWYZ9dBznBKhrpI1D+u0ihLGKf5IatZ1ROlkUafzfGdROvXY
         rm0XLWnB+6lMREbuLC87ahUE5dLtl40kYAQ67FH5lAutG+CULkPfViI0ylYqZusvEm+3
         SYUSloE4GAKgGg2vOeXbXqNPHCQ6D4Cn0mVA3pjux7Ne7ROVY9Eb5TcKO0SBbwG81XRd
         ci2sjlCuGnj+cCM2Ek8EV4zF9EJgzJVmagn16WOH3MJAzQIPX0bxoLk5dlIk4SEXpagv
         3TUmW7VcLKuLAx8Ns5L6FDGV5epQSoSGInulCWMSBCdIZ5CKkuyWys5UiywJRrD/wNZX
         R2dQ==
X-Forwarded-Encrypted: i=1; AFNElJ8G2TpZnItCJRuDLMlGLYM5OvazkhfGnkXQqt+zb9LcJLcc4hL5lXuczNLqq/l4LT5BORx2Lxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDgJsteeKC/Cjq/PX6glBn9xhm4DUEPyQ3PcjlOYaUKXpDdyNR
	pe1QMQJslZt7BTyXe5c/AusXSj56O117+bmS6NvFHd4toOT9fYUa/lvV
X-Gm-Gg: AeBDiesOZgA5eDtrO2V/FEIoep1XSamkcZUnGAX6q6QvIJz8VEEM8FObuj34G5A92NK
	2zB9br9gOO4RI+0p2NgRny3lHnCESOahppYgXtE0IQwtCM5eBva6tlB0R5FiMKHezfgoHBcWXWB
	WhVK0ogsNr40doC0+MHfbR7tS3xEzgzQW20XEiRvWKhP+DljAK3IhvCkC3O97M8390m/WHV95J+
	jZYtugCXiHjUmBGS/xw3nyUergq+OAMwUqh5NvwOggxlPqm35SjxMHIeVziqB8iNWxhtuRVKhVu
	d8FQfpluYFYDJqBDzGyvuqsghD6hHOiw7ipQnZxPj9vsJFWjbwCvefKgYnpTzPHsOYfLakYuVgG
	WyBn/g6/9ja8s2i+/axpjA7FLiT297LwrwXEu1ix1XrSYVLRJfb7gmpeUPA6SYAs0Csi6Jxl98S
	Mr7Ir2tL+X3YELPBj2cA5kF8lDZ0XykyIch+gNmX64paL+b/NZ073bavF3hmCpZ1adMWNIjDjl0
	X0SOsNe7/Wx9JBbUnJfPmLZrMtoBwchUGJp/AvyrUNkVbBDFnljqi5bM13F4IQcnDwLIQD+pYUu
	hdTeIT/MbfS6HGx/pQ==
X-Received: by 2002:a17:907:806:b0:b9b:4519:7914 with SMTP id a640c23a62f3a-ba41a82618emr1393462366b.33.1776946110847;
        Thu, 23 Apr 2026 05:08:30 -0700 (PDT)
Received: from [192.168.0.2] (dslb-002-205-019-021.002.205.pools.vodafone-ip.de. [2.205.19.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45504441bsm644606266b.45.2026.04.23.05.08.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 05:08:30 -0700 (PDT)
Message-ID: <c346ac78-3e33-4062-a459-b83d845dc2eb@gmail.com>
Date: Thu, 23 Apr 2026 14:08:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup
 from MDIO probe
To: Corey Leavitt <corey@leavitt.info>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
 <177693362253.84762.6848519898058872632@leavitt.info>
Content-Language: en-US
From: Jonas Gorski <jonas.gorski@gmail.com>
In-Reply-To: <177693362253.84762.6848519898058872632@leavitt.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280735-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[leavitt.info,pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F1FB451C62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/04/2026 10:40, Corey Leavitt wrote:
> Apologies for the noise -- this series was inadvertently sent twice. The
> first send went out through an SMTP path that stripped the patatt
> developer signature and re-encoded the bodies as quoted-printable.
> 
> Please disregard this thread and use the clean, signed copy as canonical:
> 
>   https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/T/
> 
> Any v2 will land as a reply to that thread. Sorry for the extra inbox
> traffic.

https://docs.kernel.org/process/maintainer-netdev.html#resending-after-review

"The new version of patches should be posted as a separate thread, not as a
reply to the previous posting.  Change log should include a link to the
previous posting (see Changes requested)."

Best regards,
Jonas

