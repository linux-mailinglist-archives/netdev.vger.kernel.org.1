Return-Path: <netdev+bounces-283266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HxsIe/r9GkaFwIAu9opvQ
	(envelope-from <netdev+bounces-283266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:07:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9604AEB84
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 20:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C8D2301C15B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A8433D505;
	Fri,  1 May 2026 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="psJ3Fjh4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0431F985
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658789; cv=none; b=GLDfgMW+jqfdki92U4560tAtJfYB4578EMvDPXF9N36PIxcRDokzrhQS46ChN29jAr3+KkuUSpH34ZDpDtpXGZt2osr1tXpnT2s8slKQMAsAfLpnP00UIHdW1i9GrGcydJ2zWwgfGpyPFbxPaS0TWAdSGWYVPGxIvQXqFgUbCTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658789; c=relaxed/simple;
	bh=oKkQnY5vlFNovbcjfh6JBo8TVogGXpyGhtvkDtTNy3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3nT0ea8eUkeJG+ZuPjpKfWLnk0Sj5SG5cdflEfEfGZd+BeRX23ECdEEqfW8EExICbjXrd2c0YPnpOzfFFlV3GCgMU1hyTrF8wuqpgyjxggC8/RQ/X/9vRZ9Oa7ulQaiGgqfULRf8zmV0+yjVJ3PrZKcKfXcjiNq7na14azN48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=psJ3Fjh4; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a46260385so28859567b3.3
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777658787; x=1778263587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1DjW845zhModhDu44NYwmrHvDI4OE4s13MqVWiObLc=;
        b=psJ3Fjh4F/IvT+GnFPrExEwYlGYre21c/sJ635RZrszNYBXaXf5wN64XMn6ym7/psU
         Q2p+xXX2OyIDv3LMm6MTze4TlZkVqEoa5LBRKzq8SHUMpzTAWhKGajoUlT/6qaLDwchY
         5BnJcxhDXuQgHakxWjVfWWVVLyFWoIHmsKPMrAtEoUGU4SP3U/bJWLSo/wF43VT4VLU3
         JVzTAhYmNHQMjGVKGbxeLIpjZKHAtTc12qpZWpK/Atj7nRqy6PwkvuqCStFJ1iK3aWrp
         kNUE6XQc2lSrMSKr6TAQQe2G4Uo/xq82lf8T/LX65G1UDU74tl4CipLKYY0ErDW5fkzF
         Md4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777658787; x=1778263587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1DjW845zhModhDu44NYwmrHvDI4OE4s13MqVWiObLc=;
        b=EEr+uZ3wjNVDs3LFjj+Mye/V7A9lXWoqSyoTCoCoyJJvZ3LKezrHvnm320xfDklcmB
         70jcXVOqYyTEb0jMq/2v9cgE3p8CeuGLFKOFk34TgwURz1sb8U1MtLIRwOuODwdE/GZj
         tTSF8Fc5a8KbkIkWwwTDqFN1O8gScvgxiNOOZLPkTR0USfXBScXiGd+hQl3uJ1XqnBp8
         YSVBQyKF+LiGwnF7/flJnm1dEoUd83sVW38RdoGcgzyeWmp47ArF9bWj0+v8X0Itz3tT
         5MxN1HZct7u1LnT82OLYcHM63oAOo5N1KI0smkXbhonIg+demJgJtm9i+g2AG63H65Rl
         UwTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/reFXT/0XjfWt6f3wO5qIrQTt5/4uRPm0+YNv4kPp+5prnLexLy9nMVcC6AuplaU4RaASqaio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiXAfLRIRHOhjJKu9PJZQs33+lu/WwjgTuf9vf9Mo7aVWg0TmP
	UoPqDgHs3eTw498P4pIYQdo4ISaaycD7R/E1nbT30kZRqjLPAWauBm917QeiB370zY8=
X-Gm-Gg: AeBDievirtVFOZMe0jtvqx4kW1Aal74R4OIeoRb217J9we7ZF1hNXYnwV1xd1wpU++v
	Xrd07tp//SaTilrmoMP056/fyUiO96lmRmZStjTYQt2LT00Wmdyh/8MMYpoaKq8lerqAIkwLNoX
	01i0zq/EPgrYsNd5MH1TnsXy8aQn0gyuKLsdp0URSk4MwNrNquoR2lkXoPzHOnwcEkFJo3yR/9W
	bWVPBqASru0Se1rEbRBu52NkYjg+Tx54fTOxhHjYJkVVHN8I5JiI0FBvbSWNaAqjGnvdgNR64gr
	WKXxocSLsJmH2Apa+KX47pNwt5YIDWCblZjLopwj9JVVNxaOOFdPwdHR4HUsPFw593xSrPaDhPy
	GjBCN4LBidcA9cCqWYvEnlSKxKfRR9iuApTulDpvSAhxf6cGU77b35m/PfcAGsbWTQ/hT6oAxG8
	5lZflQY0wseVO49zkILWnvyOvEWa72wHhmFQ6CHSBzjGvbbWeW5TewcDiR5wX57M8EJayMh/DNu
	g==
X-Received: by 2002:a05:690c:dd3:b0:7af:6904:3f3f with SMTP id 00721157ae682-7bd77170409mr4261187b3.45.1777658787005;
        Fri, 01 May 2026 11:06:27 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm14575347b3.0.2026.05.01.11.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 11:06:26 -0700 (PDT)
Message-ID: <539b9de3-4a78-44cf-9085-06cd0cab2d17@riscstar.com>
Date: Fri, 1 May 2026 13:06:23 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/12] net: stmmac: dma: create a separate
 dma_device pointer
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-5-elder@riscstar.com>
 <9203d8dd-8ec0-415e-9c2e-5b06b1b8dc11@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <9203d8dd-8ec0-415e-9c2e-5b06b1b8dc11@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BE9604AEB84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283266-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar.com:mid,riscstar-com.20251104.gappssmtp.com:dkim,checkpatch.pl:url]

On 5/1/26 12:13 PM, Andrew Lunn wrote:
>>   	if (priv->dma_cap.host_dma_width) {
>> -		ret = dma_set_mask_and_coherent(device,
>> -				DMA_BIT_MASK(priv->dma_cap.host_dma_width));
>> +		u64 mask = DMA_BIT_MASK(priv->dma_cap.host_dma_width);
>> +
>> +		ret = dma_set_mask_and_coherent(priv->dma_device, mask);
> 
> I'm nitpicking, but i don't think you need to introduce mask.
> DMA_BIT_MASK... is already on a line of its own, and is within the 80
> limit. Nothing changes here with s/device/priv->dma_device/
> 
> 	Andrew

I did this.  It was simply to silence a checkpatch.pl warning
about a long line.

I don't care either way, I'll gladly put it back the way it was.

					-Alex

