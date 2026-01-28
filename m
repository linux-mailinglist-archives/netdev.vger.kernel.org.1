Return-Path: <netdev+bounces-254425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAOxJqVeemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:08:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B48A80CD
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AC453016241
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A175326926;
	Wed, 28 Jan 2026 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFqF22Lr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A122264A9
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769627297; cv=none; b=t/F5mhE3TtFSoBo1YVN9iNizGdcNBDgoRxt5+ZdkpeUmyquUybWYlMRVr1LzQYMdL8mw5lXau8dztVsD1OudjNGYPfEcf02sZ65XPBFoO1zq/0Oo1Y4TZycdDYWhn+pKFjr1DGD/+gnM01ArhyJYfPLW8znfbRfvCWyGVlxqI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769627297; c=relaxed/simple;
	bh=OuOg7fK0b5YBPtSlz+PhLb0OTUf/fvAXBnGVS6t3Bww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Srk+iJy88AwAGv77Er6JSUhwXvVd3hSmMCRtqgvADEjF8Kdegm6YJEG+1j5ZyCPJAB7npF+4KaaidcWNp6NNNg9tMnTEtLSAiZHyVf7XdYZEJ9dgJPcVJ+bwNPmPjMlvqVcQbikXMApxDQ/cFkFGh3gTKASEzzdzJX4/yDK0Iek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFqF22Lr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fbc544b09so190788f8f.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 11:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769627294; x=1770232094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0ztyyoXr2qR3JG+E16z7tyT9/q0OUQVhQKgl5XpldY=;
        b=UFqF22LrfkVxW1J+PhP9keC1ZAjvAcHwdHasVHk6/g/739vES4ed6/LGEwxL34gPs+
         jFHYO6l5O9O0serDCGsZPps/W15x1GfivIc6S8qcaPCo8sAp5GQ+NkVvwR1mHs7UROdJ
         nQRhv04h4mMH8BFjdSiPP0fJRSNFbiJaycJKAF5zNUEgo93KdliRX5SWNBTN8cCf156K
         1XmN89UWM72bJxvMXgDpaqiJS6Zptp4CVWhNWaOAYQRplvFQU4LeUsE+hBkfqqUYZJJE
         v9/mzjQRFTGMzcAD32RRC5jWYk9h9oa/eqfp0VmrWysivlB9AtL/mGqyi0zR9AbMWCk+
         g9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769627294; x=1770232094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0ztyyoXr2qR3JG+E16z7tyT9/q0OUQVhQKgl5XpldY=;
        b=oC7shrvfCEqmRGpn/K8iKWMo0/ANyQrV4jh0WBH8WBs3N9kqRPA90xitXF6XTbGnsB
         ptgjnRQPdu5/FaYTR/NsV8BlbB0lyriabUf65QGjiK5xKvxHYM9Udk8ubM+6IoHLjhPe
         uiEOozaqukV3BpnwqluANUIkE5D9m4veCJwAd+Ny+hT7gAIDMm8VyzAILTxOlFsqEBsz
         YKnhKh2tZS2246VxDfdH7RqxCqf4Xnf/erU6Sy0GjGHU+lUm9xXxU81E1yKI/Bm/1MOy
         Wub1DtlLw7ZejMVkEXumULMvjx69xWhInJyZ1JK0GAxv/ngs2yYDWzkZYFRZSsaFgdRd
         W2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1t1rRdDL27ZaErHLVhhw19m3iSFUZdW0K9Q69ok7G+UXuRQQOB5xEORPescnLFwaaGFkDK+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdLmiYgiCLgBaNMj6+syUeUuj662u+mG+OoMNRm7vBFQfRtX9o
	+fxZ4e+2vxMtCMrD1eiFXbNZw7ye5YFGOWwDvnJMuUEDpKjaJis5tQ/T
X-Gm-Gg: AZuq6aLMJH/WzjGEdjieQ+TnMAlpUBxCTnhRwcOpCk3rVUVr+BdEqarJkTMp9HCkytE
	F6a2F+Uz71vQ9dt1AXugJjV5LjkcTVpnuMSYEqcPftzk+/2tgNzfg0MP/qv55/hBTelrJBhZaWv
	TCbCOR6YgUp1LjSbnDInXuPDrD1FkeEjwq6z9uaW88KSRgwv8YmL9vO0BSJNqJ5Xy5JpZMo8wSd
	9yiODCTtrrZ/d6mdqRnEvbK+NLeYLEkg1YrTBWlkDZDzaeooB+tN5W9L4eilez6de8ZdcqFC+y8
	oBKE38pv8iHrX4sUNlomIg78P55iR5u1uw0hOZICd7kyCbdNgY82IDs3ePYezwv72mCAG+Kf823
	Mgt6yLXWQiRJzZsZxCWIeMZzJChz400zM3kGZ9DH+yDGs3xsgl3ISWyAIlNANvPTFvPzP9xQY22
	uB84LCLZFxAMx6mJ50E0dHksGYaj0zLY/DqwvUEKsL1ymcBN+gnMAAe3MlWt2UKKY2/D+tXwDpP
	4JU82/nsAg5S0CDlFD/ZqgGKzjGKsGi2ZIfGrM+p+YP8t47000pxg0KHa4c73dd
X-Received: by 2002:a5d:58ef:0:b0:435:dd9e:9704 with SMTP id ffacd0b85a97d-435dd9e9724mr6265093f8f.8.1769627294140;
        Wed, 28 Jan 2026 11:08:14 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2b:7200:a9b8:4711:836e:e074? (p200300ea8f2b7200a9b84711836ee074.dip0.t-ipconnect.de. [2003:ea:8f2b:7200:a9b8:4711:836e:e074])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee04csm9144019f8f.12.2026.01.28.11.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 11:08:13 -0800 (PST)
Message-ID: <4a13d635-7a22-4de6-a4bb-1ae4351b114c@gmail.com>
Date: Wed, 28 Jan 2026 20:08:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] r816e: Add r816e driver in Realtek
To: javen <javen_xu@realsil.com.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, nic_swsd@realtek.com, pabeni@redhat.com
References: <640c373b-09d9-4b54-9113-782df41aa152@gmail.com>
 <20260128065309.556-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260128065309.556-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254425-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realsil.com.cn:email]
X-Rspamd-Queue-Id: 10B48A80CD
X-Rspamd-Action: no action

On 1/28/2026 7:53 AM, javen wrote:
>> On 1/27/2026 12:34 PM, javen wrote:
> 
>>> From: Javen Xu <javen_xu@realsil.com.cn>
> 
>>>
> 
>>> This series patch add a fake driver r816e to ensure the kernel could 
> 
>>> set the correct power state for #fun through r816e driver when suspending.
> 
>>>
> 
>>
> 
>> I think a better approach would be to contribute to adding phylink/sfp support
> 
>> to r8169, so that the SFP NIC versions (incl. RTL8116AF) can be properly
> 
>> supported. This would have to include making the SFP I2C bus accessible by
> 
>> the kernel (instead of firmware only).
> 
>>
> 
> 
> 
> RTL8116af is a multi-function device. fun0 is a BMC virtual driver and fun1 is
> 
> the nic driver. The BMC virtual driver(fun0) is used for power management,
> 
> while fun1 provides the actual network functionality.
> 
> 
If only purpose of this dummy driver is to bring the device to D3hot during system
suspend, then this may be a question to the PCI subsystem maintainer(s).
PCI devices are instantiated by the PCI core, just that in case of the device here
no driver gets attached. Still PCI core applies a default suspend handling to each
device.

