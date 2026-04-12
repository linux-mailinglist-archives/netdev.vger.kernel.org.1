Return-Path: <netdev+bounces-277792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOESLRqa22nbDwkAu9opvQ
	(envelope-from <netdev+bounces-277792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:11:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B22683E3F00
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BA603001FB6
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585237B3FE;
	Sun, 12 Apr 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW2ABHk2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39C369222
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775999509; cv=none; b=BaovNaK+9pVGIjWvyI75hje9qojdsP7/sEwABwjIRecVTRIn0nIqZAfftxQi0zM3PWxM7AZRv5LWNrUyHwwClnxOJtMTKJaU1iblT2H3n2dnIFuk0wZt8vGsr/EZY6ZH++pm9w9W2SW5xpxqPm/L06FgQmZ1sQco77WqJ9TP1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775999509; c=relaxed/simple;
	bh=B3HWLnfYc7hYPUewuJjAgEfEaKIo/JeH5JEO/rPQ1E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GlVhKddKVeih0NMpJeZ/ceDAGrF+Zq9vqtHA+Xz27OeShTGnXKtQT1e/WSv0Z5PkjNR1STiIbMFKxPHXJ0ggfBb+UUbZKJm5Rxocb/xfCHeN7YcELWqrwEpg++1QEO+hVzRKC0lA91v6LguT2sK1YSBRc96yAHkgjna8WJhmf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW2ABHk2; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a60975dc5so37534387b3.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775999507; x=1776604307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4du0A15RO+63OLRWH2z7MneZJ5F5Yb3MO3EVSqO5GKI=;
        b=GW2ABHk2HVzVPjCRDBDsf0/DoX0VxOr3BrQ8a42KTuPeRlKeb5hzjbj3T7mim/A6hW
         7eLNuPEUNgnn6toNuebS1oMES/N5ATtDVUadsb3SjtFCqWEcqjRtQEmXm4ii4a7toE/d
         na9EAv6yp8ZLIxZFnfBI3jmtEhrFbgBD0pAAV4jqas77+/mrkcgBC66YHoJHK303Kd6i
         gC4q8qcf+mPV/2MMzct25lkKvYgEJdDCPBZlfVd1JcLT2vehuSeefS6XCNHm9Hppo01o
         RANdgwhGzDETB2dkQ283PwDX1RruIBS6LIavYD9bjvQ/ceeoNh9W8lKA6T4IdhOZaag4
         +gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775999507; x=1776604307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4du0A15RO+63OLRWH2z7MneZJ5F5Yb3MO3EVSqO5GKI=;
        b=iydw8gLaorzyxvJNOW77jU2+f95K2QWDLE4BiwUwhl9/ApoYlRou7rotyfJKT/WzPZ
         h9MyXTgW9cNiP6OMOnI+JpJyscBPQJCTwkRt3hhe3ITT6KvdhkWhpPpDiJVSJBgRuee7
         nYLMV8UJHwnJAYjPLMrsgL6ka081RhcuAoS0l9+g5Uu2QyU/rPxpYVdPIf3DfchD+s0b
         j5Tbk2K/aX3XxTqHdypaZ7G+Ud250befnleqAHgvtZh+jTroPi37BciyVM1GZFkgOWx3
         2f1xQWJdlec7LF9gyRVzGnM6uhGdm7oimMomoZMiPBzlPEATY+WBNnafs02biWc4HBOs
         cGRg==
X-Forwarded-Encrypted: i=1; AFNElJ/buMDByDvKKaCxSO/tpxKqO+DfGMquW1NDpBw3fVMl/DM+YLJNSI7LtFByLNWA/QYdfjoWaKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdyf8BalFJPBojxnbQ9A86foZ2wGOybenMy0NXhzHk/u+Pz80
	ou9nS7P2FQoZrSufWQQC65M7CkXIZZiG9eX+zp5mU29Z3HRt7adjvnNB
X-Gm-Gg: AeBDiev+97+WyO6HlwnFxl7779eN/EbfZzMj1phc76AnxfQZ28AyX6dFaOtuXpiHGhb
	lIO28Q17dGQTZfX+MoDSdBYkQWdQYyGY/QngrIySp++T3XZU1GkepixwewyDD2YspObNVdtI8zU
	i5WoG2nC9P1+w6WMdNMZeBklpst1I32oCIipYzS60TLihcVkgPKQgYCs/QDNY1ctpuVYYo6ReQ/
	0IB1EcxL6R/Wthcjw00fI9q8lm6Yj5Z44lB0vn1ineYjZdol+YVfTyhTfE3bFjQSCVJeZkNA0MJ
	BrQnoicrxThUf9rGsWazLsfqQEjZnj52F08Ovf66IYNY/Rz2WbUi72V63XRlk88xTcCTYLM0jc9
	fV3O484DGkF4+e1a14oDTv93fgds01nAAPNBOaMdnV7y3UfmFFc6WDgEcEhJRyxZSQgPSRSjm1c
	Fnp/H/UQ5veIxpNjdtT2KkqZi3nqHASZD67Xw=
X-Received: by 2002:a05:690c:6d83:b0:79a:b5fd:793f with SMTP id 00721157ae682-7af6f327ddcmr108138107b3.3.1775999507005;
        Sun, 12 Apr 2026 06:11:47 -0700 (PDT)
Received: from ?IPV6:2600:6c5c:6b00:ba4::23? ([2600:6c5c:6b00:ba4::23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af39b78ac7sm39414747b3.0.2026.04.12.06.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 06:11:45 -0700 (PDT)
Message-ID: <ffc3be55-c9ac-4c92-b044-74c2991d8aa8@gmail.com>
Date: Sun, 12 Apr 2026 09:11:43 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: Use napi_schedule_irqoff()
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, nic_swsd@realtek.com
References: <20260412014031.525061-1-tactii@gmail.com>
 <d0e1bab5-3476-4b58-834c-6e742e89539d@gmail.com>
Content-Language: en-US
From: Matt Vollrath <tactii@gmail.com>
In-Reply-To: <d0e1bab5-3476-4b58-834c-6e742e89539d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277792-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tactii@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B22683E3F00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/12/26 07:30, Heiner Kallweit wrote:
> On 12.04.2026 03:40, Matt Vollrath wrote:
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 791277e750ba..4c0ad0de3410 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>   		phy_mac_interrupt(tp->phydev);
>>   
>>   	rtl_irq_disable(tp);
>> -	napi_schedule(&tp->napi);
>> +	napi_schedule_irqoff(&tp->napi);
>>   out:
>>   	rtl_ack_events(tp, status);
>>   
> 
> Not using napi_schedule_irqoff() here is intentional,
> see 2734a24e6e5d18522fbf599135c59b82ec9b2c9e.

I see, thank you Heiner. Seems like it could work if
legacy interrupts went to a separate handler, but not
worth the complexity for this small optimization.
mv


