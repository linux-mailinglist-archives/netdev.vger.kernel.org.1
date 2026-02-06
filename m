Return-Path: <netdev+bounces-257651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP06CfFJhmmdLgQAu9opvQ
	(envelope-from <netdev+bounces-257651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 21:07:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DF6103087
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 21:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 886FA301DAC2
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 20:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D62F6184;
	Fri,  6 Feb 2026 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BNJVKLcB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529A2BEFFE
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770408400; cv=none; b=nc1TJFoM6C6mw+zXBNIn67HBBC4GzfOaopxeSWRg6HpEkRB6MA1kp23ChdiP8n3Y+QMp4tYmeiBzwB/XM2h5JtTF4839dwQVW4pfoFpytWtZceU928GcqMMIJeW9K4sAZ2nkNRqtijL9rcNWi4UL25UAhrPIaSngIVTMnN8ctvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770408400; c=relaxed/simple;
	bh=ULUa21GO2iklmjg31M9THX5fuA3oUFiMhKC3xON5Faw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNa77Nj3OAEFx3w1939BxUq0XNtJkBgI8QNkN5l7Os3ZICeK4VNGf/WPGczCQoFn6BiNyRs5L/aiYc5G29LSSjCAbxlgH7/1NMGZeaubyYDpbBzuHWpbQ29BY6vfpWaJcGLzCkg9XpoLaYD/8pLPzcebhywZiOQtVmHxsWq41uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BNJVKLcB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48069a48629so22936325e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 12:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1770408398; x=1771013198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PaNaMffxjIXphx0AHXkWa5X4Z3VPaJLNxZNxYe6XY2k=;
        b=BNJVKLcBtiMgOQoZ6xdGQSiCI9uDDjuiCWxEd/kMdeAhZnd1VFDF2zGp2xHkxnbGKJ
         Qrq7hncj0fMk1rSZ//hD8jdJEDXFXa4qWOHVQJqZrobl3MbqT24hclybLQdF1vOdeg5I
         g4BXryFi5N8e5vFgAXBEo+7CSULqbBDR9GGiRudsFz91J1SNZF++elJ1chWD4xJCxBn/
         B9FlWFtqCJmkzGB2lDHSiLdkyIFPDD9srFSLsZmJHUimx8Hz/QSJk7t1PilfhK+SUymQ
         sFinoZNg0m/xwLUrnn/XQsWDR17+DKGmJS3euhQxz8xE5yMYVulLGib9E1pDMTJtU53d
         tDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770408398; x=1771013198;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaNaMffxjIXphx0AHXkWa5X4Z3VPaJLNxZNxYe6XY2k=;
        b=OZaDgyHNVSTkC/SIuMROIIfExR5v33xZgp6aBI0ds15/zg8WdQf6re2aeX4S6U+6zx
         OO4zlHz4udCXkHj+NYnU2Sxih4xTwh22jtx58XUUtsWaAAFfE5XhLBagnfLdV453d6Pv
         W4L4mr1m9TWTRDXASkUAqsiJyueeKvtamPjm3CRjQpBG7F4ebTqzuVhTdv0aJujtHgQj
         MjfJZx0SqR8xkB7ll0AtjdG1nRkGPACq94QX130QaLqIler72g7IuIiEnn7J7rSyyTYw
         YTPm4pwAhqjBNqbvq8yu/d4wFFjR+sBaI2EjEio347TRwxYue3UV3zUJIa40GfYkjzNx
         E1gw==
X-Forwarded-Encrypted: i=1; AJvYcCVbAxZf5Yxjk/5O0cWXTG36nuoNaawpNQPOof/C0yHKTwoc8b5w13+8J/f9z1UXzZIAmcnxb0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmZGMw7S4cc0AhbT592lFHOZAM/NzNOX/WN/O1XRkcV842RNz
	OVkaI9X96tlYPiaXtH65892Uaan5H1hd+4O+fO9oSgz8zvHWuYjqjopUbfau559d5YNX6j+T4/F
	gFzr1OSrTZPSBQUWGecWRBz82KEWmR9/TPFK6vp7gZNA5c3PU1Ic=
X-Gm-Gg: AZuq6aImMFbqTPKRQkf/5biYyEuaQqmgt4bvHTTXTP9OhIVgecyuupfHeWvuFrnPt6T
	NgsqBDpx4KYgGKzt1+DoFriThof+k8YuBs6oHUbOVsiM4B3Ge0ydROaHUhjbQyCo0q01hG9DT/3
	pYhXO4sbt2cfuQRW15N0MB1NAuuoYr/kGWK2PNMKP0oRfJSHDavq7qBauL6/MjjJtYS9z6toTYz
	+cRNgTp6F0tG6ei3574BVZfD/JbUc6cXDUf4yPCTB2rF0xkpcLGDpigHc6Pjorzr2urzj5KNOGJ
	G3HvrNacRnaEgvljGe4jcgJmFaUOQN4FHoaikqn9iZRMJGBWeA0S0FubciPh+vRh7cj3yJCmIYW
	zP1Ty19gN+d5n5Kjfr8H+rRqUnfKzvmb1aUHNOw3uhLu3XUKYRAU9XTNEgovWRaZX9QuEUmYyIm
	HrQ5jdVgCHa6MWlIB/8fdXHippJT1Zipg8EU82J25sUeqKxsWwtg==
X-Received: by 2002:a05:600c:34c7:b0:47e:e414:b915 with SMTP id 5b1f17b1804b1-483201dc5afmr58864775e9.2.1770408398550;
        Fri, 06 Feb 2026 12:06:38 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:c364:c475:2c68:30fd? ([2001:67c:2fbc:1:c364:c475:2c68:30fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25d5sm8626759f8f.2.2026.02.06.12.06.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 12:06:37 -0800 (PST)
Message-ID: <9d240ea8-7e55-4be2-b99b-3f2657c5f8c8@openvpn.net>
Date: Fri, 6 Feb 2026 21:06:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1126499: linux-image-6.17.13+deb14-amd64: ovpn NULL pointer
 dereference and lockup under heavy load
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Jon Penn <jpenn@bentonvillek12.org>, Sabrina Dubroca
 <sd@queasysnail.net>, 1126499@bugs.debian.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Lici <ralf@mandelbit.com>
References: <4be2e796-77ba-4864-a288-e6edf3b7de12@bentonvillek12.org>
 <176996279620.3109699.15382994681575380467@eldamar.lan>
 <be2d036e-42eb-4d3a-be1d-60c49801b884@openvpn.net>
 <aYYwvGbStTFvof4E@eldamar.lan>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aYYwvGbStTFvof4E@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257651-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:dkim,openvpn.net:url,openvpn.net:mid]
X-Rspamd-Queue-Id: 77DF6103087
X-Rspamd-Action: no action

Hi Salvatore,

On 06/02/2026 19:19, Salvatore Bonaccorso wrote:
> Hi Antonio,
> 
> On Mon, Feb 02, 2026 at 09:26:16AM +0100, Antonio Quartulli wrote:
>> On 01/02/2026 17:23, Salvatore Bonaccorso wrote:
>>> Control: forwarded -1 https://lore.kernel.org/netdev/176996279620.3109699.15382994681575380467@eldamar.lan
>>>
>>> Hi Antonio and all,
>>>
>>> In Debian we got the following report from Jon Penn using ovpn,
>>> reported at https://bugs.debian.org/1126499
>>
>> Hi all,
>>
>> Thanks a lot for the report!
>> We have a fix for this issue in our pipe already - I'll forward it to net
>> ASAP.
> 
> Do you have patch already which you would appreciate if Jon Penn could
> test and maybe add a Tested-by or is that not needed at this point as
> things setting already?

This is the patch:

https://patchwork.openvpn.net/project/openvpn2/patch/20260202132309.567382-1-ralf@mandelbit.com/

Jon can definitely test the patch and give us his feedback.

However, being this part of the code very critical for socket handling, 
I am still spending some time with Ralf and Sabrina to make sure we are 
not introducing any subtle bug/side effect.

In any case, please feel free to test so we can confirm that the problem 
you reported is truly the same as the one we were already investigating.

Thanks a lot.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


