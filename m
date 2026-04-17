Return-Path: <netdev+bounces-279369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEAMOL5g4mnI5QAAu9opvQ
	(envelope-from <netdev+bounces-279369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D5541D270
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91E53069600
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BCE34F24A;
	Fri, 17 Apr 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzW1jFkr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF3440DFBB
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443458; cv=none; b=bDifspcbp6Jmdl0EDUopQfHrydASGt9aPjps08SZ0OrRt4InCakG2IlussL6TwicfXvaNbXBGXD81d670nGyclLRx0/v0PD5Hl8THR7gM9fR7diBmHasjJSbenpzOonyHLxZ4WQFVPM92XLUUItpM5N668ZuPharJm7M2S3XftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443458; c=relaxed/simple;
	bh=E4ar9NUvc2qWGLJIF7uCSrM/JvkMwP4AzXksTc2k7IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARwcUJaFs/H8tPar1dqMKWckU51g8nm8UcHqoLr/P2QxB8D4a5SqvBU8YcmAWb/hp/IinYUwsqjBDNyNFkCdnq4zi1QTW2LHZ9boZlmTIDqfS4I828GABJTNnOAWEW1sUGqPRqEtkDlOPNA2SEdyqcRadA7WwxggpN8FJGCLc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzW1jFkr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso552863f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776443455; x=1777048255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koXM2wPhQ8UAG5DcL1KIuDkPbaO7I5Fq9oLj0In1fHw=;
        b=BzW1jFkrAxQZhwa+/N5ag3W9SwhTfmsqjGD3p0d+PJQC5LaR1weMjKEjC69RtvQ5dc
         21xjD2r4Mtd5ESEU5/AovZhRGQI9u+7ElElCpegZT0xHbgEcsRMniAHlFWCZ4xc+cuta
         QUrBTdiQ2nssGLVQETgSSFCWdtEB/PEOsbowr6/fxzbJjLrs1QQKOcURX6S4LPB1dvhd
         USr/Ryfjy+yXhPaSN+6rXO1AgBQG7FPruYzivqiiBU2Fxy5Kq9om7nyeMGrcGv2cbKAM
         KXvJRWR1QXRbxP1ET0efkJ3jsvlwVeWVLCLD55vBriwNk6ZrKzIqFkA4UIFejh/j8tGG
         TTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776443455; x=1777048255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koXM2wPhQ8UAG5DcL1KIuDkPbaO7I5Fq9oLj0In1fHw=;
        b=lhicYcetFBMn1AlGb3fetQ50MkUTcMycLemokLwIhx9ciFyRZGumuiDp4cCnBA//Sp
         qoebnWfllcAk72g7GU9B7LdmtnFx+o6fZm1ipchksyNV8mCSXZapzLQE4s4QAoaALOFG
         LKEHqIC52h0E6PjZVLsLbqX0VEb2zqunKgqn+T8nYhg/7UJ37UWlBCvCX3qZstIJtwuv
         +HsR02ebmanzgy5fmK55FuCisf/lv099oFrR79dXKhDIBL0DdPfHo7HtgCupgLfLTAt6
         c0tmMtjMTHgr/vGr6KGhAMpFT41ANgAocuFACYVU2RoNvKYySWuXF1SWiOpWJjVdBxB6
         VFzg==
X-Forwarded-Encrypted: i=1; AFNElJ+0+LgIghfHB8xjWvL6oC5LZt4b3MI1Sd2QKowfI7FDbFxK3P+tVpF+1lQ8sYV9HXcm1bEL+uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Z7yvJwul/lbmahxY8eyUQn0+pQ2GC0lZsUFCDWVUWTownnfu
	DOfW2uQnWmsNR+WbbbPAe2ntCbV6hnhATYw/GBGq8jZZlruo+2JWgfyB
X-Gm-Gg: AeBDieuzS72rxHDwImMIK+mvEPAxFHgizKpwPA6NG3bT/Ix97+yUrIB+XTDOkGg3cCb
	jAYO/EyjSmKA/l/OWobSYbimrgvlHakoMJQIVxB9+WpoVHoYNSA1znZQtFDfX5XCidQHpbkNUOy
	0F1oONEkC5G3jdloU8oGSxE9TwqRsnRCw14CqZZKowE4KP/+BeK8iOxeEAwtnDVdpz1iCB77eP7
	nU79Y8iStkUQBeaM8uI39UIOn+GPAgkGIt5F7+1KuxJSF7qRslyIROcspj0LbFj5VJS0uCf3qeT
	t59NNFVDoIe/Jt+T4mrPujjbHq8GeLcw2N39CbIQ9L0dVM/PI2mRmugjHTUEarHTgsF9gAe/FEu
	h9ZkTvpkOranIrmX4G3TuYuENpfqfoaEqtbMbqZQipN/VAy8S+PUJALl2U/F0YSheBPvHh45KND
	atrTOv4vg0J5knHzZ7dOId9l8Ot8yaBLDnauJg6pehEdRXppXjfVV045eWoH7x4qKxdt5x4YnsI
	HSBSol0NCHzparaTxEy
X-Received: by 2002:a05:6000:2308:b0:43f:e9e2:efac with SMTP id ffacd0b85a97d-43fe9e2f02amr144741f8f.5.1776443453186;
        Fri, 17 Apr 2026 09:30:53 -0700 (PDT)
Received: from [10.1.4.108] (cust-east-par-46-193-119-166.cust.wifirst.net. [46.193.119.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc2cacsm5675179f8f.13.2026.04.17.09.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 09:30:52 -0700 (PDT)
Message-ID: <18cfeb86-9879-4644-b2f8-ab7775287b1e@gmail.com>
Date: Fri, 17 Apr 2026 18:30:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Marek Vasut <marex@nabladev.com>, Andrew Lunn <andrew@lunn.ch>,
 Woojung Huh <woojung.huh@microchip.com>,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
 <20260417155025.488290-1-fidelio.lawson@exotec.com>
 <BYAPR18MB3735885B13017500E153FEA2A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
Content-Language: en-US
From: Fidelio LAWSON <lawson.fidelio@gmail.com>
In-Reply-To: <BYAPR18MB3735885B13017500E153FEA2A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279369-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lawsonfidelio@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,exotec.com:email]
X-Rspamd-Queue-Id: F0D5541D270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 18:10, Sai Krishna Gajula wrote:
>> -----Original Message-----
>> From: Fidelio Lawson <lawson.fidelio@gmail.com>
>> Sent: Friday, April 17, 2026 9:20 PM
>> To: netdev@vger.kernel.org
>> Cc: Marek Vasut <marex@nabladev.com>; Andrew Lunn <andrew@lunn.ch>;
>> Woojung Huh <woojung.huh@microchip.com>; Fidelio Lawson
>> <fidelio.lawson@exotec.com>
>> Subject: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx
>> Module 3 low-loss cable errata
> 
> Since this errata is a fix and pushed to "net", adding fixes tag may be required.
> 

Good point, thanks for spotting this.
I’ll add an appropriate fixes tag referencing the commit that introduced
the KSZ87xx support, and follow up with an updated fixup.

Thanks


