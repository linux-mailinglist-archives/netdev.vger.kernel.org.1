Return-Path: <netdev+bounces-146431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F29D35C3
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 09:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A01F24233
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 08:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACFE16F900;
	Wed, 20 Nov 2024 08:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEsQ2MtT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852C16D9B8
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092331; cv=none; b=EcNcNdfrNxbkOlntxASAHd188ntMDY6+fb+mb6sAS8g+bJafCCMWWKCXLt37uyfmiOIx2rUp6q1wMajKge+TcWBJkgCjkemOjbAFnEXp9MA0PzXDnnCrD57A6xp1Cx/+hE21UocO0UNybLAjeNJfT2qrtPgqgLlNIFER3wGf+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092331; c=relaxed/simple;
	bh=n8Cn2Kx19JlAAC3I2rxr/XyvMslCd9DJGTEEdgx4suQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SubIr6szEVx+NYVXbK8/BoMVXrFwz3Okzt/W9wBAI5cUxRvpBapz1TzDobzta8cEFQNpDQ7ZCHDaC5eg2AKDfmMov3QcawlmLnDenPXbMuSBfvb7yS5RYgnQOk5djwYlZ/mNeKEgiMmoGFDTnjUKygqVQsOKQkk1FLux6eoDHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEsQ2MtT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732092328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2Xz/RLYCNlQFdl8WhsbYuCjLGK515Ww3NMwch5fjwI=;
	b=bEsQ2MtTa9WIAvoG7ChoTcxacduV/EhNjFBk/SSPSp1nh/14k4WKn9YzWFKTWAngv+Yk/w
	JG9GFJO54NCsq0S7wke6pqF0v2F3tzKfmrgeLyStL7tREyfZQwd5+zD6RiiWJ21nZXwrjy
	Qk701wlxlrcTq/+1/GbeILv9Tfbl+Nc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-zs_Z4PZ0P9q8sE1CFh_bOQ-1; Wed, 20 Nov 2024 03:45:26 -0500
X-MC-Unique: zs_Z4PZ0P9q8sE1CFh_bOQ-1
X-Mimecast-MFC-AGG-ID: zs_Z4PZ0P9q8sE1CFh_bOQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3822ebe9321so2994490f8f.2
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 00:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732092325; x=1732697125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p2Xz/RLYCNlQFdl8WhsbYuCjLGK515Ww3NMwch5fjwI=;
        b=q/mzSDygaAyq8cXxxiKdF26z89SPBZuKo27IPVDzH29u8b/qcLEnev6CehrOLN6588
         1DraERzY9gk8z2XyL/fdcONsQ/BggrwO1EV7gqj5jhi+iHnarLYINAaKqU5NUXojLsd/
         0f7Lo770RfCGeMhBuu/8zHJUyuNt46fpLSfRJ3mnRAQBlWALrGZJbvslVveA/qsj3oVU
         5Sa+77tk8vSH8rVDzlJRODr660sYpHT1weN6FpoFGLwVAjn+hqOnI1E/umjdmxxcjQEO
         w8y1aL1qt+eUf+ZO5AlUxzchcdbdiBbo1EJcX9QapZ6OOVcQuCNNfPjQiI27TCQEj+VY
         pJ8w==
X-Gm-Message-State: AOJu0YzL76vUp7SS9sQjcxmJmp31TgbBS87oNA/NxkIPzIs58VIkiKl/
	h13aQ5VJYpddGyo/BdFGO+I9OOu9t6tH4yCcGyrJyPLD6upmnBTqyzY9osml1STnNvixS+3DbHC
	+oF9AZubv3CvrCM1exrQg9f+R2lhIad3LE2WnecIBvZDdMjQ2SLadhvV4TMLsKg==
X-Received: by 2002:a5d:47ac:0:b0:382:4dad:3879 with SMTP id ffacd0b85a97d-38254a851c6mr1636207f8f.0.1732092325372;
        Wed, 20 Nov 2024 00:45:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFo3rT3bAOLxAf9P69ArZlmaO0CBwJR6o9bLMD3f8j565NzJ1s1ddL87bnDxhDplwFVHxYWg==
X-Received: by 2002:a5d:47ac:0:b0:382:4dad:3879 with SMTP id ffacd0b85a97d-38254a851c6mr1636188f8f.0.1732092325023;
        Wed, 20 Nov 2024 00:45:25 -0800 (PST)
Received: from [192.168.88.24] (146-241-6-75.dyn.eolo.it. [146.241.6.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825493ee3csm1408601f8f.102.2024.11.20.00.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 00:45:24 -0800 (PST)
Message-ID: <2bfbc6ec-0a25-4203-ad15-73a7864e2e04@redhat.com>
Date: Wed, 20 Nov 2024 09:45:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net vs net-next conflicts while cross merging
To: Jiawen Wu <jiawenwu@trustnetic.com>,
 'Russell King' <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
References: <f769256c-d51c-4983-b7a5-015add42ca35@redhat.com>
 <013a01db3b26$2f719310$8e54b930$@trustnetic.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <013a01db3b26$2f719310$8e54b930$@trustnetic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 09:28, Jiawen Wu wrote:
> On Tue, No 19, 2024 9:15 PM, Paolo Abeni wrote:
>> I just cross-merged net into net-next for the 6.13 PR. There was 2
>> conflicts:
>>
>> include/linux/phy.h
>> 41ffcd95015f net: phy: fix phylib's dual eee_enabled
>> 21aa69e708b net: phy: convert eee_broken_modes to a linkmode bitmap
>>
>> drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>> 2160428bcb20 net: txgbe: fix null pointer to pcs
>> 2160428bcb20 net: txgbe: remove GPIO interrupt controller
> 
> I don't find what's the conflict here. Do you mean these two:
> 
> 2160428bcb20 ("net: txgbe: fix null pointer to pcs")
> 155c499ffd1d ("net: wangxun: txgbe: use phylink_pcs internally")

Yep, the latter one.

> If this is the case, it should be resolved as follow:
> 
> static struct phylink_pcs *txgbe_phylink_mac_select(struct phylink_config *config,
> 						    phy_interface_t interface)
> {
> 	struct wx *wx = phylink_to_wx(config);
> 	struct txgbe *txgbe = wx->priv;
> 
> 	if (wx->media_type != sp_media_copper)
> 		return txgbe->pcs;
> 
> 	return NULL;
> }

Ok, so it looks like the current net-next code is correct.

Thanks,

Paolo


