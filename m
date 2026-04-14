Return-Path: <netdev+bounces-278430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cExGICks3mm1ogkAu9opvQ
	(envelope-from <netdev+bounces-278430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAA3F9BA2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 546683001D66
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791E3E5564;
	Tue, 14 Apr 2026 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrBreI+0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E13E5594
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167972; cv=none; b=eNU+vAXlqV1ZZNBiCktrCOcLmSN5SSkXfc1YIbBIB3Izka2ED5VShhQZndDMKrJczyoYvCALou4oD4+ctkr+Jv215edZXleTHWqm7aoErZYLLjHQCQXyYYLJVPEbQw5HHy6W8rsbaI2UHex0U9ImRe/LiMU8PzdFZ4QZ0qtQMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167972; c=relaxed/simple;
	bh=IFeWrn/hnERBZvCI5pSNoznkYIvTh3rTkyNxR0Ex1zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ois0lwn3T/KcT/ISEOcsm44lgGNx1F59imaNeECFUHfAiLH5G4vDxZ2/DfOiuiogzzlcdQTm15WvBJYkAJIqCnzsIE8qbcuXLbsopjwk3tu7bN0AUHFeFXRoK4f5HxWISblgc3+UfkWwraKqUXzrix3Aejeao5dtsLEcjkzpePI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrBreI+0; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso85925255e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 04:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776167966; x=1776772766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cI6YDCMVOjwF3n4rp10xh1cUi74T8qWohjAF2esDvLY=;
        b=YrBreI+0mmV9/BKYli7tUMA44+vzFT5m2v6o+NFrcYUay3D9z5Qu6zWsgBgOrLBYN7
         Q5tLCTiNBQrIdlyoZ3KAo8X4jOGFF0wjHARixSBPW4hF6mfhpWOyO4LwucuH1yeLJ9Nf
         qS8puTrCXmm+fZRQoNRXhjfwID1PDB04aNtQDp1Wpf15vChECYQ4K8AigTMplH7tRTEa
         xEIEUfvOSN33zTvGiiDdyqO8fTOtbTftguZARABJ/DLuIVnIOH6uO6jAGnS64x7Zvdw4
         q5/8fCxX8UITQZbON6nmDCedVB2kb0Isz7Kp7pceK5hBX5vtVu97evQNMVv1GMkXYr7z
         nKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776167966; x=1776772766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cI6YDCMVOjwF3n4rp10xh1cUi74T8qWohjAF2esDvLY=;
        b=kHKJEnb08wqmeOVAqsHzqfOtsgFbEWP+u2wtfMZdZwfHjI1T7aG493fnbyyLj26Kiu
         h6DEO/xQ9CNqM6Uv3V4IX6KVbjjtHDGoY918KIJFPmryErseVbOCcHDK0M+S1cDN0J8I
         wPafZPvWlbI8yuWpivg7EcHLH02vEjYVL5ypgbsE9uYZOC9GMV8rSIZTIMdE0FMmzQfT
         z4sdo97mtspWRjLyFWGAsoxf/HpQkQOQ1y2iuD5n3i5d757JS7vmjvTKAogGH9AkatFU
         qHAt6uLeqyKVbNzk4Lz6/Fv38GbTHf+tIOm8HQ8IfTlt/x3WAxEV+QvfBpyYM6ldCNRF
         qa2g==
X-Gm-Message-State: AOJu0YyWdqqDHwj2LRB68tBbJ+HNBnl5/4lc3SCfqfG4UYB6f6EGluhK
	OWXXkP3OTq5vPU72W0F9p287P6udsFIFJQVxa1938n2AfFEaeXVY9e7F
X-Gm-Gg: AeBDiev+BVDzzyPyAOysSM5yu9QSsy2d1G36CD2Kzlcuiox6USXw6g2gxn30C1jjnfG
	BENe983krhMneKh3kF+NqgXp0WcKRlbecLQbgncOKlqKkW0oZnxUGu5K+9SF8mVf43MbEhBzi8K
	MwgoBpHATsfw/gtZMpopcHp0pt8htaVnCbyznF5i+dycAIP+dUxarD6739J5XQc4Am0HhTGboCs
	GaEM8W2Plln0GnqOEGoCwmitVuCO47K1KPHUCWRdxAcEqqqHld+FINsNTlfN9yZKi22DCdRz4RQ
	eLjq3KoLzzdr8ayHDYqTcOktkmbqDkUfzCB+I8BD2s1RKIlJUjYAtUB7Hv/7Eysp9Obf+PQTwbn
	NY7T1i16D0xxlMOnIPVnxS5CNSFlGk2SOg+gbRtHvCoGdz2qVwYcsLzeppYQfzvDV4Z+EBrzoFg
	QT/GBQbVEx7MnGyB8JV8K/5vffCReT6z0JK0v8cKU+dFZAwbZRABFHlgiPItLacmazr8VARRGja
	Ocw1NsuMNfpJ0dY1/4O
X-Received: by 2002:a05:600c:8591:b0:486:fab9:a578 with SMTP id 5b1f17b1804b1-488d67eca69mr181512605e9.11.1776167965806;
        Tue, 14 Apr 2026 04:59:25 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ee019e44sm79184615e9.15.2026.04.14.04.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 04:59:25 -0700 (PDT)
Message-ID: <4f009fa6-5fe1-4ba9-bacb-1bd8de820a98@gmail.com>
Date: Tue, 14 Apr 2026 13:59:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Marek Vasut <marex@nabladev.com>, Woojung Huh
 <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260414-ksz87xx_errata_low_loss_connections-v3-0-0e3838ca98c9@exotec.com>
 <20260414-ksz87xx_errata_low_loss_connections-v3-1-0e3838ca98c9@exotec.com>
 <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <ea90a671-70be-4d89-b842-1e54d687336f@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278430-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nabladev.com,microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,bootlin.com,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:url]
X-Rspamd-Queue-Id: 43EAA3F9BA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 13:05, Marek Vasut wrote:
> On 4/14/26 11:12 AM, Fidelio Lawson wrote:
>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>> Microchip document DS80000687C for KSZ87xx switches.
>>
>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>> where the PHY receiver equalizer may amplify high-amplitude signals
>> excessively, resulting in internal distortion and link establishment
>> failures.
>>
>> KSZ87xx devices require a workaround for the Module 3 low-loss cable
>> condition, controlled through the switch TABLE_LINK_MD_V indirect
>> registers.
>>
>> The affected registers are part of the switch address space and are not
>> directly accessible from the PHY driver. To keep the PHY-facing API
>> clean and avoid leaking switch-specific details, model this errata
>> control as vendor-specific Clause 22 PHY registers.
>>
>> A vendor-specific Clause 22 PHY register is introduced as a mode
>> selector in PHY_REG_LOW_LOSS_CTRL, and ksz8_r_phy() / ksz8_w_phy()
>> translate accesses to these bits into the appropriate indirect
>> TABLE_LINK_MD_V accesses.
>>
>> The control register defines the following modes:
>> 0: disabled (default behavior)
>> 1: EQ training workaround
>> 2: LPF 90 MHz
>> 3: LPF 62 MHz
>> 4: LPF 55 MHz
>> 5: LPF 44 MHz
> I may not fully understand this, but aren't the EQ and LPF settings 
> orthogonal ?
You are right that EQ training and LPF bandwidth control
are orthogonal from a hardware point of view.

In this case, the interface is intentionally modeled after the erratum
guidance rather than exposing all possible combinations. Microchip
documents the workarounds as alternative solutions:

"If work around 1 does not solve the short cable issue in a CAT-5E or 
CAT-6 application, change the work around 1 register (0x3C) to its 
default value (0x0A), and use the following settings"
from: 
https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/Errata/KSZ87xx-Errata-DS80000687C.pdf

If you’d prefer exposing these as orthogonal controls, I can revise the
interface in the next iteration.



