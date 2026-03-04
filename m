Return-Path: <netdev+bounces-263509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCvrBJqIp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:19:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C2F1F92C7
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0305F3076501
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FA3093BB;
	Wed,  4 Mar 2026 01:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV6MAc78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7E2765E2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587159; cv=none; b=TgzxvZwhSZmE3Y1wE9bdP5UMzm+b3dYLm5hBtuKGIu8zpBIKaQ5dNX3rKCIRsJXqZfIQhvr1ZkLWCBAxGirmV3qL5j3EtFnQD8lrEWyvk9UlGq88LSC6BgIp9VHuerGMkFML0EV0unVDW3ujxxQI2cBpcSvSacnX48nwcQ4AaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587159; c=relaxed/simple;
	bh=rdDyhELc7hSIr6ByJJWu3JPfPVveq+7o3+8nhUm+zc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m25L6HVeOTCAOPiVptEhOCTziNULSAf+kLvlE3ZTqUTmK+nE4JsBP8ga/vA6a1cPVjQXiAXtQlSTGeyhW5/lzYHZzgiLf5mPFWh8vJet153nvlXouL2zb00wKKVt0ZYC4iPJv1PJWVmg5wATUb5iGEQCP1GAhsGfFNFGU8KCLCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV6MAc78; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3675206eec.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772587157; x=1773191957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvvy8mrMhzjULjG/waJaGKSbWOymXRI0aiNwOWuVKAk=;
        b=WV6MAc78RB8PldkwMpwzKY2soJ4AMRocvWmV1o73BS0+vfQajVl4Mo8WIBlI0idUzo
         MWVNLFEvHi1L3FG4jwfCucdOqCEAYH9s2Ia7StCK7C+h+mwedKQuODpfbbNWU10x0hBM
         lSgB7sT9piaqU3TDThacV5Q2mUxiJPXpVcXB74Pd7HWufh7h+76iJH4b0lR6K+ssprKO
         rT2glzNJSnLNw7ruMJWv6EBEtH+GOImml5jfRrh2L2FRf2UGEiby9O1GFo893Fm16K1F
         JJBOCz4QHUTkP9C36fAkOJlZyTQHbrWA5teT3V4a4lPuVMNqmNhxmXf3+xHLRnAfGWuL
         PACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772587157; x=1773191957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvvy8mrMhzjULjG/waJaGKSbWOymXRI0aiNwOWuVKAk=;
        b=jNc5WJNxhN7fwQjv40u6Mmw+TzRhcOUwxiziblm2dNWGlVaY2nJI6cosx/t1+aHkFN
         UzjP/KY9M7A0QYYcMzaeP1IleaWpSHCTNfuk+tvO2U4ahq1pxdft/nDUU/8NV906V/r7
         aNplq6wMGQTQ4ullU9q3TZ77hXPKwA12WXZ79mnxYzAmR7HKFFi8oeNRO4Am2Z+bDtoX
         6wB7PT9ZbNuKXz1ObQy+x/NnabSV+ojQqjuFXv6k82WIe7NGL7RDvlmBlddADy7uuZzu
         p1uwjE5c1NfCXni7lq1ydgVP3HRMp8ScF0SCYoxlgg4CFDtUtmSuG6yJtI/qz1xEi9/x
         EGTw==
X-Forwarded-Encrypted: i=1; AJvYcCXUTp8qh7cIiX+QikRgvenNO9VNDAl9TbablC3bAjVR0Aa5+xyD3PGKXXnkuZAC+gVbEH/iJT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS00D8UvsjdkNqOUg6rBdKShllZf4XdkvtEQoqgpmh8D+KwgkO
	gdGzwCqmi77WlLWVTsN2f/HSgSySnnVZq2SoowiYM35156gQBbi7+2lJ
X-Gm-Gg: ATEYQzz8rchDjl5BSquZpQqY09CDGDJNqaOjGgxwQ/7jPEe2zhpowG52Bxrg9KlewSS
	+SiP2hDHZOpk6SbEwk32aE5fH0uII4LweZxBsZ2yoUpuBLXMp7xf1VmfBksqav47EMi+Mb0YSay
	43HqgC0LGisvq5tXW0GWrIVE7XhRkSfuPENAHoiOYkFbHhPY2G2+0rzu+Ouv78PTuL2vEehVMBL
	xiKrm02zBwCRCVTMyT/WOpzCU0TR7rJkY4vGTvOiVU5jn7nxAIM1rcO9+9VXxNOn80ZWT7NT2Gw
	JyvWsFYjS8HyGdTIV5X66XvyQ8vEh1IUPmAoiZW7MGc1ED803VRmOkyLPdvVPsRN6QxPPr5ks1X
	iUAXsz4OU4ka2CHSJMEELtRQNTPXRPh+vq3jAaVgtIuuyB6H9+1aw/PKCQOKUbXE4WYUgWK+cBE
	xDDg23lP9cxXOlSFjsz8c8uYhOwYPDTH6KBrvxFSjr8JKIeic=
X-Received: by 2002:a05:7300:ac81:b0:2be:969:75f6 with SMTP id 5a478bee46e88-2be2344da48mr1494176eec.9.1772587157326;
        Tue, 03 Mar 2026 17:19:17 -0800 (PST)
Received: from [172.16.0.242] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0d7e0d40sm6999679eec.12.2026.03.03.17.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 17:19:16 -0800 (PST)
Message-ID: <05a15890-392c-41c3-9566-8eb506ddfe5f@gmail.com>
Date: Tue, 3 Mar 2026 17:23:18 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: ethernet: eswin: add clock
 sampling control
To: Conor Dooley <conor@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: lizhi2@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk, wens@kernel.org,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com
References: <20260303061525.846-1-lizhi2@eswincomputing.com>
 <20260303061637.872-1-lizhi2@eswincomputing.com>
 <20260303163846.156d18f7@kernel.org>
 <20260304-regulate-verdict-c3a361d2dc83@spud>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <20260304-regulate-verdict-c3a361d2dc83@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79C2F1F92C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[eswincomputing.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,dabbelt.com,eecs.berkeley.edu,ghiti.fr,lists.infradead.org,st-md-mailman.stormreply.com,einfochips.com];
	TAGGED_FROM(0.00)[bounces-263509-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ganboing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi All,

On 3/3/26 16:47, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 04:38:46PM -0800, Jakub Kicinski wrote:
>> On Tue,  3 Mar 2026 14:16:37 +0800 lizhi2@eswincomputing.com wrote:
>>> There are currently no in-tree users of the EIC7700 Ethernet driver, so
>>> these changes are safe.
>>
>> What do you mean by this sentence? The commit under Fixes was part of
>> Linux v6.19 already.
> 
> The "funny" thing is that caring about users doesn't even really matter
> on the devicetree patch, except for this hunk:
> |@@ -81,7 +99,9 @@ properties:
> |                          or external clock selection
> |           - description: Offset of AXI clock controller Low-Power request
> |                          register
> |+          - description: Offset of register controlling TXD delay
> |           - description: Offset of register controlling TX/RX clock delay
> |+          - description: Offset of register controlling RXD delay
> |
> | required:
> |   - compatible
> And it only matters here because an item is injected mid-list. If this
> was moved to the end with the RXD delay, the **dt-binding** changes
> don't have issues with safety. I've not looked at whether there are
> knock-on concerns about users in the driver or whatever yet, but from a
> binding POV only that hunk can break something that currently works.

This was already discussed here in v1:
https://lore.kernel.org/lkml/e7183ae1-8b8b-4e77-9f4e-3bc1b4b63556@lunn.ch/

The device-tree is not checked in yet by ESWIN folks, so there's currently
no user of the dt-binding. No need to worry about backward compat.

> 
>>> Fixes: 888bd0eca93c ("dt-bindings: ethernet: eswin: Document for EIC7700 SoC")

Bo


