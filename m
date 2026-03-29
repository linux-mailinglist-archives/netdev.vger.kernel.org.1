Return-Path: <netdev+bounces-272927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCy1FQBByWm1wgUAu9opvQ
	(envelope-from <netdev+bounces-272927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00E352873
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14BCA30022CF
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5299A37CD27;
	Sun, 29 Mar 2026 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNGxhWFX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D837C114
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797054; cv=none; b=FgJlDZ7O3wPkOuewpWs5OcFXSQ+vba9275dx4uWY1/ZkJfdj3AtOQ+OVL6NYs35lG+0SxrF0w+E2Ns7H1rcac2hubk5z0fGqsHP5Bu2+Ua38zo+Hzo8/xFF0HtLCLla4VgWcVIjViZDL301zE72wgmLyMJdmWsekF/LC0RpkafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797054; c=relaxed/simple;
	bh=LLr5cmf3SYYozYXM1xWVhMV/tB13W4sXrryaCkfDtAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuLH5fooMa+22M/rHTHnyupZX3d9LknlfhwBQUx9Mies/ymmXGfeA5A36lQd0rpoU4DUgw6Mkp11W1xs7limXYTWhgA1r9ucXQQtgXod/HU2SjMrj6GpjSQNQDFfkyiqdbjHPsF11HbE3qUnQnU8N3QHHs9K4hPmV8baVRxUMQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNGxhWFX; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65015facf32so715193d50.1
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774797052; x=1775401852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLr5cmf3SYYozYXM1xWVhMV/tB13W4sXrryaCkfDtAI=;
        b=QNGxhWFXskETE6GLekQJYDfjGzsz6l5JxFNH1lf/RPQLeCcr7b/MKxwbDhl7cLqm36
         d28NVsjRWWY80+uh5FMFbAjIvwklcO+WTOkyI3A2eKjv98AH/jWpVoZH6d2v65ozNOIq
         ajYnnHfdglnl3GUW0sLiRJK+fBwnQocfwC3HajhXdJFuGSzPKbXgla7LkGiahr+qmIwK
         DsYw89F/nzt2POCfKCdlGZtcSqOxtpbDwIii/klccS8sDsU6ve2H6LNSRjnJhlEogfQS
         /FJjdVi9Y32e+k6TPS44cJfy9wYDvurYNuGcyD72EonW6YvelN6zV8rUviTE4orRDjUp
         XWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774797052; x=1775401852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLr5cmf3SYYozYXM1xWVhMV/tB13W4sXrryaCkfDtAI=;
        b=W/DPLxi1T5csNakdd2pJbP7LAz3kcgsPBth7Q/crdAzZ8fwGt50xBD7ScgsFeng3M1
         SY91z9vKS7DsSHeDSJNqford1RkT4xtPJkVj/lGV/qNrTV+cuoR0XRfmTMBsYpVKPObh
         pSI8mM+dN4D/i9Kz0S52/fa7MQilBbqvdKcXROvjCFiszME8kEu4UD0Wi/H9+sMkyZYk
         Sa0hxSZcp76EzRmwBy370PHuiPwa9GIqXxfArGwTNGMraU7euwMcT1JKab3UxqbRE6FP
         qcycGSTHxvVpil+9TY/ayIdIaBg2tTrybNxNYRROXLtFHCilUS8TtHLsZY13cS95c04V
         QsZg==
X-Forwarded-Encrypted: i=1; AJvYcCVXjanX9XBLJH+TA7K9Pk19GIFh0Pyp2YN7A9CMrKFUfxxov7cVhkM39ac6PJrfsoQexfBXk18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHOE+G2zW+0EZRgHJ/6AGJz1RFxoVAKnw8cpLxhCadEFCJ52G
	1jMmfsFqLEWjlRT6jFc3oRWU/yEgdPc2ShlTw06vktUMg7qWbrs9WBi0
X-Gm-Gg: ATEYQzwnGn6ZWrRuBlKfEPwvo7Uu24ely/HtClQXJyZg/fLoFop8LNoOmjxCGYKSwlg
	20/5wBYzEt3Gpt+1WmBC3/sH61t8IUM9A4FMXclAvq/hUK0jjTwvXWw5rs+na75fo5YxOLdMLTd
	H1SWcW+sZ5SWuum1Sur93OnKae/wvqWOJ1CJj1eBAspDT/ivfaerQduEr5KR7aEMw8c4R+3as9a
	iNHpyW4JUhpYZVOckPfSf8ExfwKzeLCnjPvApyQk7IKOqAYvG1d731MCaQPKDUFOTnymzL1sVES
	oX3GZGtMphrI92dyJhfNqSoHcved1g+3//bKIIGxz+BIj+PxoEd0oAa83ZJQR9YqFEk3Bni6WqC
	Xb0obXzI4tk8Mps/ixp6aE4fRKVAhxRJkZwEectoPiJhST6dmBJ0HRzbENuFiO8sIJqIZuz6Oeg
	YnSDMUsxHClV+ljOGMegj6buQIJk8TQ5um0V+CS5jU/wiVOWUWeA/phktChZ6TMQspoZTBYyovl
	q2QK3k2wPsBj3qrWn2bKOVMJMPLlcrRuLKOQj6welC2
X-Received: by 2002:a05:690e:14cf:b0:64e:e90c:5684 with SMTP id 956f58d0204a3-64ff742c558mr9453537d50.64.1774797052021;
        Sun, 29 Mar 2026 08:10:52 -0700 (PDT)
Received: from [192.168.5.93] (76-224-22-216.lightspeed.sntcca.sbcglobal.net. [76.224.22.216])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65009262fa2sm2601166d50.8.2026.03.29.08.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 08:10:51 -0700 (PDT)
Message-ID: <fc702208-daee-49dd-9b67-9cb123b50fd8@gmail.com>
Date: Sun, 29 Mar 2026 08:10:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] Fix page fragment handling when PAGE_SIZE > 4K
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Alexander Duyck <alexanderduyck@fb.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>,
 Mike Marciniszyn <mike.marciniszyn@gmail.com>, Lee Trager <lee@trager.us>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Mina Almasry
 <almasrymina@google.com>, netdev@vger.kernel.org, kernel-team@meta.com
References: <20260324195123.3486219-1-dimitri.daskalakis1@gmail.com>
 <20260327202958.53d26d46@kernel.org>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260327202958.53d26d46@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272927-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,trager.us,intel.com,vger.kernel.org,meta.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC00E352873
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 8:29 PM, Jakub Kicinski wrote:

> On Tue, 24 Mar 2026 12:51:21 -0700 Dimitri Daskalakis wrote:
>> FBNIC operates on fixed size descriptors (4K). When the OS supports pages
>> larger than 4K, we fragment the page across multiple descriptors.
>>
>> While performance testing, I found several issues with our page fragment
>> handling, resulting in low throughput and potential RX stalls.
> Google AI reviewer points out that we will also be toast if someone
> configures the ring size to just 16 descriptors. Can you check what
> is the min size that doesn't wedge w/ 64kB pages and let's just set
> the min to that instead of the current 16?
Yeah, this looks legit. Bumping the min to 32 should work, but I'll
test/verify before submitting the fix.

