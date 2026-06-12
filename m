Return-Path: <netdev+bounces-298752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EBHlLD1DLGokOgQAu9opvQ
	(envelope-from <netdev+bounces-298752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:34:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF59867B5CA
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:34:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=c6WhmD5u;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298752-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298752-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 844F83007A61
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5F940628A;
	Fri, 12 Jun 2026 17:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f99.google.com (mail-ua1-f99.google.com [209.85.222.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEE374E66
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:34:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781285681; cv=none; b=kGtHFv91knyH8UJyGkibyTHODq6QDCEVJ5m35yXzaJBBAIlsBoycuKjDpOCkYAH6E9ifXO2swosv+ILMg4ec5dW4HcP8CuCRx27rNr5cTptPw1Rnjt5d7hOwA1UFXZRltQZ2piOnzJkaDGX65P632gmRgeweTUSF2y7HKiwelB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781285681; c=relaxed/simple;
	bh=IvywPrYtqHwOPWtPbL5ec8PVlYD1azkdeorAonyzRE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BxR8nj8Ppl4+fs7CQrdapIsLbXOaIVFw0iB1Tvgj8p2NlQq2s3JG/HRz/X3AJzYKZEU0f9dc3BMIi5myFg9V1ewqBX0+yRi/pCOByeTQMTX4H7pssWgvl7AEso1ojm0jpXmV/tEWibeBP1OyfLb5HTYn2ME0BmmuYDVtEK/DdyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=c6WhmD5u; arc=none smtp.client-ip=209.85.222.99
Received: by mail-ua1-f99.google.com with SMTP id a1e0cc1a2514c-9638f7e9896so1304337241.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781285679; x=1781890479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LK+0/7C2rh+DDX++KBE74peykTPgebClJfikfMK5nUQ=;
        b=ICmrBAJzvtn84xC99mfC9WqflM8tAjLr49MIRmUU3y10+v9uoNUTAN+o9Rb9P203oP
         i+K7cgodR3aed30pFOxRE19nbZiIUzRctM71cz0Z2LYSVYZcI4TWBZ+B1mUuZw4pIRX4
         dhCpP/NtMl6BltSj8QGRdWHu2o+ZQOJe70JhHh7hQwfCuBObJqeXfexn1e70Mnw3KRd6
         mGT9P8kUYiugyygNz4XYHfYKuOEe+ppef553IOHYiEonTBdtah/TFJg2sfyDgdtl9z2N
         Ctg662hOvM6TS3eP0BfdoLK77DsPhtN623z40kaIJuCXJA5bKNgUmRv70pk2NLdbK2LJ
         2DcQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZIfXPtwzK7/prfXTSA/iCui/ecOIXSyDltkKbAWSQSnaChoknjBw6B7QW5/ixNivninUk+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHpPqJoc6tLv84K0QoeOuIdSn/gzjZJwopwm1ZmEpI7A6SgoV0
	ikWzC18sMFmVI83xoA72ZtWphfLv9Tlm9cwNX+GAKZseVIhFIXcY1fSjNxa0FJpaqF/kXkV1LeY
	rh4w6+dxU0sGwa8SfBABHJJLuDlvuCLPBfZCGuS6tbAUUeJbPRIgbUNeSla4b7tORU0utqAz5do
	ohkkXdpRakCrh0jtIk+eagiBEqz1mpeMAUzNCrVpaKcR8bgk2eOdpkeOOcGzwpUvbLxkUsS7I+p
	gVz/CKPxw==
X-Gm-Gg: Acq92OFHr5eJa4SaKR6kJkEZkKiwtFOazYjmCzYqMbnxZgK5n/X39MS/1nHxysOiplY
	XxYdMe9W+XlFhgnSz/y9GlA+90qnwH9Af6nkK6tFap2a8OeQ1GGJzMM0VLM5dx6tu6LuhxynYQr
	DthwrONV63UF0kPWBUnuC5vHgkQXyFsXiA2EXzJEITjIOAjaH5pXARcgGusd9iGN9diXLtv2T1B
	nYNvvMSqpJWX+e7pVJFLXP9BumHYyA1DXLjItxdwft348zpr3v0qLQCRKOJf6hJknX9ctbOCsi/
	dlLp4fhUS7AGnAxfnP4oxUS/r0k6SZED2Q09DGLDm1TGvA69saF9FlRFW4Rtv+yjUH6dhh9FHnz
	9G3NeY5RnQAlTrwm3cVXAiGfFJ7rAUZz+WWEr6372quxNRdZjBSDSCqMguX/lPiMZPeJ80K8atk
	6DIPkZwtPYLdKO98TbxpaZ94JnhuLR/565PBJlg6Bry+IaMUJfrz59u2xcyQ==
X-Received: by 2002:a05:6102:1611:b0:633:4d1a:65f5 with SMTP id ada2fe7eead31-71e89b80a37mr1686168137.10.1781285679004;
        Fri, 12 Jun 2026 10:34:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-71e889fd8f3sm143634137.21.2026.06.12.10.34.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:34:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-304c652be4eso1593006eec.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781285678; x=1781890478; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LK+0/7C2rh+DDX++KBE74peykTPgebClJfikfMK5nUQ=;
        b=c6WhmD5uZzFAHFGm8SNJFAlc/1T6QH05gfKNI2jz20E2zjgP9w6RKdZQAJvWeNvkHi
         SV+JMbLx41DjSBKy6ypGb/Aaslag/yvG0fAsdzVJIdkAhKM1f3Mt9NTqIOtMIccFgJet
         Ww4OE+eohqCErPwTnO8KXMEuqO8dttURploVo=
X-Forwarded-Encrypted: i=1; AFNElJ97kufTIz7WtSJesZJqw7DuPW4yiu0/i9UgyqlZhhLzNAWJ3rbLtOsLasqMQceoXvDEOVRY78c=@vger.kernel.org
X-Received: by 2002:a05:7300:66c7:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-3081e46e982mr1621445eec.12.1781285677659;
        Fri, 12 Jun 2026 10:34:37 -0700 (PDT)
X-Received: by 2002:a05:7300:66c7:b0:2d2:d5a3:e97c with SMTP id 5a478bee46e88-3081e46e982mr1621430eec.12.1781285676963;
        Fri, 12 Jun 2026 10:34:36 -0700 (PDT)
Received: from [10.14.7.225] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm4615599eec.4.2026.06.12.10.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:34:36 -0700 (PDT)
Message-ID: <0ada80c4-0ad0-4475-9a5c-173ead88a4dc@broadcom.com>
Date: Fri, 12 Jun 2026 10:34:34 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: Use weighted round-robin TX DMA
 arbitration
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610085238.56300-1-ovidiu.panait.rb@renesas.com>
 <2f7e70123887fcfd8bbf4ce92f73574d@tipi-net.de>
 <d700f8b0-b315-468d-8681-b97653ed76e8@broadcom.com>
 <69d920a3b52cc049dc1b96a9c7d5e3b6@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <69d920a3b52cc049dc1b96a9c7d5e3b6@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:ovidiu.panait.rb@renesas.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[renesas.com,gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.chen@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF59867B5CA



On 6/12/26 12:37 AM, Nicolai Buchwitz wrote:
> On 11.6.2026 19:27, Justin Chen wrote:
> 
>> [...]
> 
>>> AFAIK the existing queue mechanism dates back to the STB QoS use 
>>> cases Florian
>>> had in mind when he wrote the driver, so let's hear what he has to 
>>> say on this.
>>>
>>> The change itself looks correct to me. My concern is the targeting. This
>>> flips the default policy for every GENET user rather than fixing a 
>>> specific
>>> defect, and Justin's series already called the persistent timeouts a 
>>> design
>>> issue rather than a bug.
>>>
>>> So isn't this more net-next material than net with a broad Fixes: tag?
>>> Please also add to the commit message that it drops the existing 
>>> priority
>>> handling for rings 1-4.
>>>
>>
>> I'm ok with these changes. Internally we no longer require priority 
>> queues. It is a legacy use case we no longer have. My idea was to 
>> remove the queues entirely and have one big queue. But I figured I 
>> would wait for Nicolai's XDP changes so we do not need to remove and 
>> re-add queues for XDP. This could be a stop-gap solution until that is 
>> done.
> 
> Thanks Justin. IMHO XDP could benefit from a queue-refactoring prep. It 
> gets simpler on top of a single queue, and dropping q1-4 frees up a 
> bunch of BDs for the XDP ring instead of the 32 it has atm.
> 
> Happy to take it on, or leave it to you :)
> 

I am not going to say no to less work! Please do.

Thanks,
Justin

>> [...]
> 
> Thanks
> Nicolai


