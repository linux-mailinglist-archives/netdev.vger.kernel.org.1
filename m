Return-Path: <netdev+bounces-277889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bw5Ksn822kYKgkAu9opvQ
	(envelope-from <netdev+bounces-277889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:12:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35C3E5D40
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FA4300A756
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A97379EE8;
	Sun, 12 Apr 2026 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKaT3+EV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76323D281
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024775; cv=none; b=DLMT6Py1t/dzIjqQlzoyPSV8xtCUlLtMy5EltXhoqinUoraVgGgESsgO1I9JjG5/u7bAU74GD0Hu07gUe8YDHzMbooFzMcnFcnZTx20drEbaxnBQNe008d4bX72hc0sOVPnAck00VvSzMT4rDI8WEBD23uMqd12zjk1n6nZpwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024775; c=relaxed/simple;
	bh=9EHmBGbOcpV6F2r2vWgsHs3cWFEGuyMmtjfaJZdsimM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy4u2eTBCZHEU4Vk1IArPeAG/xSJI052xhR0RQfjenlKOawCt409X5RjisUbL5G9grErgOPC8nl+bt9vV1m0f3wiceKS2K8sxuim4zLeKPolf/PvbIOtVyloq52iG9IRswpqU5OctSY47Gh+Y3dqDQuneGde+wt+5oT+Iypx/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKaT3+EV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so2203313f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776024772; x=1776629572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hN6m/QzYh6HW+XfAh9ditjWhl6YsNRyPq6FG80kpoU=;
        b=VKaT3+EVi3cIwEmw5ahQ6MufPpiMUUcob0SnG4TWxPH5bqZgTjpZdtBy6JnrYrBq80
         Rr0xhWnXTmK+XIl8DcLyU71NgAsxBxSFv1ZWvB70OHOtaKk9nUKpLm1o1Or9wBFVkx9o
         yO68xIA4yBnzBVXcEEbQpQl1nZ0j0fyTDD9KNGknV1aWDOdG882uLb+Qphq4ozyUb+QL
         L86E/OhZlPO9ldU9mnJ/4rpuU3KEr48Eu9yN28U01NkUB/zksPxtyLGUDDnxKQAsNlRL
         o52OvvgtlkMRnQpMUwbOSIwm7/LOWYhfhWqzPbhDDZvppZdbV+V/yu6aZ/hGoMw+UB75
         mPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776024772; x=1776629572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hN6m/QzYh6HW+XfAh9ditjWhl6YsNRyPq6FG80kpoU=;
        b=IyqJQaz43n/MqfLvwFy4Rnm4f7oEn12xP483GAim/9zwuAvlX3waMj3rJyK+UeIiBc
         +Oy2RLtWm32yKExLYOJp/qZfnjpX0VA7iYKSm790RnTZc2+DU7n27jT9WcJR4CkffYEc
         kBSSuUh3tyyF3HVYmEpls2SR0kJk4igU2ZJw5GBMUiX9FakmpJerouf3MYQ0xMmm322m
         LqdgxtAvaIsBm3crBFACrdiJLihP+ZquviyZulU0qh4y7TlP2S2iry9TYAGTIero3cT3
         7Ql8N/tKtXq8RKhEq3x3XPcTU8ye12IwYnraGXjojwy0K9C5VjZlsT11BcG6eZHvNqg6
         8PIw==
X-Forwarded-Encrypted: i=1; AFNElJ+6P2gadK4+Wpap+72WHgeN+nX0O0fYhXG8IZXMKhAc17AZFwQr0mDeb60vMkNpYfaieua1sTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+9ZNTdpWGO1fsJBFWcesrN/HG4yIMWdW6mmx9svYemyb9CBS
	LzNiqBF8OzFfhDk7LC0d6IiEBBkByqyfFh8umSdSnEzuXlA8CLFWyQGM
X-Gm-Gg: AeBDievoMfm+0TooSdeY8lZbwdvfdFht7nzCtyZNAVGhPxwx1Ce+X4vy69kxkHKDJma
	IHH2u8TL9Ik8Lr/07vwnIcs4tu2jz2jIhkABk6kkvyYUM6idwyqREAC1clcvPzN6b/FW/k/vMw0
	YghXMaEo7Ot9KxxMfmqalwE8/92WtAbMZyVosuH0gagNMDgBUs9y/kInli1ifWq3wT1GggwnAki
	p6ENtF/xj73fK7x6e0mvWOGR/msoJ7aPjRWtnoYI9E68+L+8YoB/M9jcyQI8h4ElO29b1iF763S
	vDx9KgY7CPjk3a3wvNWlKr7qMRE1NNGS/XIGPyk4+cH9a4gMSX7xFlrgQJgLbsheuvYrDL3xR2X
	+l8gaDTTGpW2CG2o6xXem41g5VP18mfvmHLeR2cvaXuccwvNtUVmwaQbfeptfL6ivtCkRyNV0OG
	GKV6jUSMoyuqCZwVqLRYnUqH0KlNeuoX5LfV0FqAB+b2fdrQdO+vNNsnjY50IP47huLvjIgnWjR
	ai1XEYX1bjwpmNxXfzrT1X+P3M1rq999nMDMYjsa6an+DVWF8Axv282jZ89D+s=
X-Received: by 2002:a5d:5f46:0:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-43d642c088fmr15346977f8f.41.1776024771908;
        Sun, 12 Apr 2026 13:12:51 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:8d00:509:2813:3a95:e5b2? (p200300ea8f468d00050928133a95e5b2.dip0.t-ipconnect.de. [2003:ea:8f46:8d00:509:2813:3a95:e5b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d6ffd3880sm11093762f8f.7.2026.04.12.13.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 13:12:51 -0700 (PDT)
Message-ID: <b6a44c0b-5258-42cb-8eac-0a6e6d077660@gmail.com>
Date: Sun, 12 Apr 2026 22:12:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: Use napi_schedule_irqoff()
To: Matt Vollrath <tactii@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, nic_swsd@realtek.com
References: <20260412014031.525061-1-tactii@gmail.com>
 <d0e1bab5-3476-4b58-834c-6e742e89539d@gmail.com>
 <b6c325ea-8865-4aea-addd-3be2fe178244@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <b6c325ea-8865-4aea-addd-3be2fe178244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277889-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 2C35C3E5D40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12.04.2026 15:51, Matt Vollrath wrote:
> On 4/12/26 07:30, Heiner Kallweit wrote:
>> On 12.04.2026 03:40, Matt Vollrath wrote:
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 791277e750ba..4c0ad0de3410 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -4873,7 +4873,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>>           phy_mac_interrupt(tp->phydev);
>>>         rtl_irq_disable(tp);
>>> -    napi_schedule(&tp->napi);
>>> +    napi_schedule_irqoff(&tp->napi);
>>>   out:
>>>       rtl_ack_events(tp, status);
>>>   
>>
>> Not using napi_schedule_irqoff() here is intentional,
>> see 2734a24e6e5d18522fbf599135c59b82ec9b2c9e.
> 
> It looks like forced threading was fixed after your fix
> to mitigate the issue of forced threading not masking
> interrupts.
> 
> see 81e2073c175b887398e5bca6c004efa89983f58d
> 
> If I understand correctly, this should make
> napi_schedule_irqoff() safe in any interrupt handler.
> 

I think 8380c81d5c4fced6f4397795a5ae65758272bbfd needs to be
mentioned too, because only with this change your patch is safe
under PREEMPT_RT. Best extend the commit message based on our
discussion. With that one:
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


