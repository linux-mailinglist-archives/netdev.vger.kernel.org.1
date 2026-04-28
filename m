Return-Path: <netdev+bounces-281899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DZ3CoPB8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:17:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE1486C50
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C26163138161
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6033F788E;
	Tue, 28 Apr 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/c47M8J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhRbaqbk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E713F23B1
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384266; cv=none; b=arIK0rwoW1F9SKNaAW8xFzm8rrwBw4lTbGlmBSKy0PtS032iB0YxPig5z+WLtnx5djpkIFUvDtIUYun1d2euc/ugI7KZhTDxihCZYsLgDtjtwVKoVd3ZIgWcSDOSBMENVkuj3tF/cIYVjk5f29oM5/Sv+V81VyEFrLIdkpcHunw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384266; c=relaxed/simple;
	bh=dc3yYePbeC00ushKLZfPED6+lsm/zSBPjlXUP80humA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY1VmhiIO2y3DGVeBmIoDAxSQxMlY+upn0Cpqa5mvVRRGx/E/GbDGTk9uLC8OCgSsP0o3PV7qmLv9JGUoa+IibEpHw+Fnq7ZvjrAG+lVHvG35MUmmyVWmWwFAXSQH+2pLw40D2drqmbGIQdc+s9E8DLhDVYzms4ew6ZEXqfusLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/c47M8J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhRbaqbk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777384264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oERSgp87PptIH/1TPj1jRI0j8pcldWXFNEeBCpNH6M=;
	b=F/c47M8JEZZjREiIFSlZ9ceU0bp+32EklAeWuH54lB4EaLKcC/KcgnsgRlyciX1Vw/9EZ/
	beW+EXq4slNe31pAp7uROUwbSAj2hgvoGSHsMLMg9iMFlsIYOoK/s0+Hill5MoT/kusoHX
	dHEP1ReMgdDzk/lnroRe+hVNRjNuaEY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-UW5Z5xHRPXug_cjR73IujQ-1; Tue, 28 Apr 2026 09:51:03 -0400
X-MC-Unique: UW5Z5xHRPXug_cjR73IujQ-1
X-Mimecast-MFC-AGG-ID: UW5Z5xHRPXug_cjR73IujQ_1777384262
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43ff0eb2b2aso8543144f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777384262; x=1777989062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7oERSgp87PptIH/1TPj1jRI0j8pcldWXFNEeBCpNH6M=;
        b=KhRbaqbkn1ggHV8qNoEC/3VciyAT1syPlwh4ENdQUP7Atu5inu0efUDoCzqh4LcAun
         Jqm9QH0QOC4hagn6HJ7zfvgQagNPgjiZv1RvWMG5A6oohOi75wJddeijKXhYsBA1DvZa
         O6VClPTkNCzRNX7C2i7/QAcX3m6RlPRHFja4p1afu1PoZiL8aR4TJh8rz/Fo3lavk6ze
         QZwm4m8nfjqU0pTPdekjBH4GbiI2MBPz7v7kazjczTFM967jzvbi5vSFXqSptTVCwlYY
         eJG9pG7I/WWGcQ/8aM5PgS3cQY+NntkGAP+oDI3h0ppGsR1QHUQkAJvQDACEI7MnfVny
         f0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384262; x=1777989062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7oERSgp87PptIH/1TPj1jRI0j8pcldWXFNEeBCpNH6M=;
        b=hzHPHhFQmjq0Xwk4a8snhBeu+CjhiYNh6tJ+KaILhYOXfx2rgskhs4OCn7FUBD47Zo
         RgWpgy43O5V6XvgDxhJYPKjb/N9kp/abohfnU4kV2/XUZcDB5yKCgysyKEtPFwlICM6h
         aDPXq9/OMxfaejSWezEv10W+Y6mo3Nmg1y9KhL/7MqSniZSg2OkBD/2ym5xV8yBUlgxM
         mAwWsOdhxSgia0745T2/9BHNMCQrYzvcmhA9B9R0bDsoj9duJeRrWxTINbXjAfub/IP8
         zfVxuWsmKwYQfEiTi2N+7RUrS2IioAvcWMpZKuhNVoyIwEbivM2f1sw7X1rn80D7uVux
         uBzA==
X-Forwarded-Encrypted: i=1; AFNElJ8uuH8gLWavL27wUMuUm0xNUDcYN0j5kuldchtkipvbeT7+Xqq6IygFenaZXVs6cSshvV4Orb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAEi5toIN1CUMqYWVjaOrUMsehc2r8pBILW6gXvHCc2uNMyFS
	/w41Yfx4SuDGufIASmrwHq80RYxWaBUfgytM2f8I6cZDc0n82kAR1f0sYodO2TFhiWm1kiQPa4p
	9jVWxy6HACJWp/VoQXS4FtoDlrPmNl46jmlqUKa0CVLdLC04oq0itd+W2dQ==
X-Gm-Gg: AeBDietObADYNaDJWhQKtcXIb6dMM21iHN/EZOL6FSsieKq24gJ+KrkzkInoqKB/rv6
	I1oFICuHg2eh8mF23HnmW3jAbjLkaGx5cMBwfT5AfBkEqYIKy3It3Bj1+D3aQEJtmhJaicAi/iG
	A1z8SvksYzefysV4jVAg8x033RVfv8JWaCLxt+DA2azOYBBmUzF4DhKmYZQPF3/2SZXHzOs4xaM
	FVERih5MPrlLMMTzAr2RFpIzuwl6+dVKGFMUZaEdqC580MWwVBQ+LdC3fMnAfGQCejijNTe8Mg0
	R7bAuq5VA83lPZtG9r0HbeR2KZXE52MU6ShEq+yzuYYAb7CjeWjdzSoMkWe7FBK5y747mjS0YWP
	Z0W9nokI/oLDg5VPUUkN/4F5FAg3zpZ114Akc+NRSlJ2O16Lp0nL/c+SBhFogvTOYJg==
X-Received: by 2002:a05:600c:3b0f:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a77b061a5mr50966595e9.17.1777384261691;
        Tue, 28 Apr 2026 06:51:01 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0f:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48a77b061a5mr50965575e9.17.1777384260877;
        Tue, 28 Apr 2026 06:51:00 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a79ab6ec7sm23143205e9.10.2026.04.28.06.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:51:00 -0700 (PDT)
Message-ID: <fcb880c0-40d3-4613-af73-f1cdd1764975@redhat.com>
Date: Tue, 28 Apr 2026 15:50:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: phy: dp83869: fix setting CLK_O_SEL field.
To: Heiko Schocher <hs@nabladev.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20260425031339.3318-1-hs@nabladev.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260425031339.3318-1-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 78BE1486C50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,gmail.com,kernel.org,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281899-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/25/26 5:13 AM, Heiko Schocher wrote:
> Table 7-121 in datasheet says we have to set register 0xc6
> to value 0x10 before CLK_O_SEL can be modified. No more infos
> about this field found in datasheet. With this fix, setting
> of CLK_O_SEL field in IO_MUX_CFG register worked through dts
> property "ti,clk-output-sel" on a DP83869HMRGZR.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Note that a required fixes tag is missing here:

Fixes: 01db923e8377 ("net: phy: dp83869: Add TI dp83869 phy")

/P


