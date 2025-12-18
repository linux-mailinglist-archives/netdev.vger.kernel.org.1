Return-Path: <netdev+bounces-245317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9638ECCB68A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D959F300D90F
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E153314D9;
	Thu, 18 Dec 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ztj6ehof";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jact1Bri"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A2F2D5944
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054151; cv=none; b=pQ7kDkmC4rxEq278wFDHQPRxe4MDFUETF3XwuQjntkkoLZ9jArT//+xJdNORlhG80Mj11ahdGKK8exQXEaY1gKFl1L/VdCHssZFJKUT5Iax1YHAtOykbrMUSgRt3O4PN9yfswwyKxsTjT7G6PjixeRK0R/r/wki7FXeDBFaPXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054151; c=relaxed/simple;
	bh=scDcShiTe36eEo7AdZxDEhGcYN81Yg3zJDeo3SZEHlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTbUrBa3qqv37YaPfk1RPVfXZiE/UWsGAX5D1MF9UORrIa5uHwD9qw7yHms5d+JkpSWc+jEdSG7mK19yxd0uShgJdJQqjP+mb7m8gs1MCIPrvh8VtpwgjdoqWzSXJFHQX/0pS1W+sslyQSlhBfv/gD6EkfZ9Rd9AajHiUiJzsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ztj6ehof; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jact1Bri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766054147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcsyVwiGA164RIE3MGNGW0ZXhxN7EmdjJgU83vvtPmM=;
	b=Ztj6ehofunljVxj+kqBLE7Dwx4Jv9B9177dQ5ATQFbVGg5bAmho+L70IKbIUueuQIlt7C6
	WHoCuXUrtfin/ZMpa1Ky8iN1k9PY0BYi/OYDF7CO2fMdAnMPsi6LLCHFlNNrEIex0U6ktM
	xNww/lp/7U4jCesHXOgOA4Z+Lcdq1nc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-j3BcbmKnO1-E41cVT8OWEg-1; Thu, 18 Dec 2025 05:35:46 -0500
X-MC-Unique: j3BcbmKnO1-E41cVT8OWEg-1
X-Mimecast-MFC-AGG-ID: j3BcbmKnO1-E41cVT8OWEg_1766054145
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47910af0c8bso4624605e9.2
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 02:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766054145; x=1766658945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcsyVwiGA164RIE3MGNGW0ZXhxN7EmdjJgU83vvtPmM=;
        b=Jact1BriHCl1fsQ5I26UiYueoeCSBxD8400ERNWXNef5ZbzVRW/zt/g8/Bw0MbroVk
         L29V5fjpXHYn+ZxV1Au2IZmE86+C2IRJYo6SGxvTneUFlnCnBZAzQmEbhVgidKMqE4Ph
         eWEKw2lcbdyGYaSAtzhYjpUIoJrAvj6LHN9Qlrzdiw6oqjxKrhK0rZjEqkvCdQEI71nb
         1Ua3r4EANUlrZ9ZJUeQ9SpVZLQFLk+KoZ6JZ2dg6P/gJS6S2l2HIeJJrn4MtAWgml0Kw
         AjJqrDw+cIPdOWzDJIVqXMfhHSK2zbPF45AALTa1fzhVBhCsckss5NvVCB3FSXlNg/Ap
         VRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766054145; x=1766658945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcsyVwiGA164RIE3MGNGW0ZXhxN7EmdjJgU83vvtPmM=;
        b=X/9SuaYutVc5113oK1Glr7x7Xn/nFMZRcXhfLjBusbE1QJ4kM4q63P2Aq1EzE7i70P
         87uyTq0AkWpOKRuNb4Rs/KisJ9FgLYc2W5GOckDkIEAafPxLLVdD2dpWaTXtvLQEdVsh
         zZmA/tW7IZtg0MpUYWA+uhQaC2LvKYFjbk28JJZ3aAmdsswPvDChxge1DrnqKRMwaZZi
         zDhzkACMGtiRenAiV5EVI+7oM5yW1GaZXla+S3Jeu4hBo+dYOskn3AHjBBkPiSYh+8Bi
         v7QFszXQvMyVJj/wST8TxEPM/qp1qPKsI0qj8+Vo3AD/yTuuqsRei8GCRk8Ltx6MVMQQ
         nrlA==
X-Forwarded-Encrypted: i=1; AJvYcCUfNmrM8Uqxt07sCrG0G8LmFHs6bKnyPUEnwuCfvRq23W+z9su+Lp7jSTC2Inux1bpzvOHRZlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1B/3sI/LxtGLiHO8YY5LzfPJVsE+HOqGmj198v1RgoiX9JE7P
	e2VnjnNC7nPEwVxa12zrNSRhLY4TjxG3cHmkjySFsQ6R/ooBW82BPigHwJof1tassHcNDXA2DT3
	GijMuxEcyN4wvcIS02BdTDLH3KClSH5oEfS0aKZTpiwhKV++kI6LBqaGIvQ==
X-Gm-Gg: AY/fxX7Kjuz94JF33Mg3nBTL2dn+qYozcI9M0U9WUV3zVpZhpG8kXbIrcQd4N6z5+Lz
	wBCROWh0N+/h/rha99coYk/bfMpUqTeXCPWpTZAGcbt/n7tTkI4gr4LcSdsX09VunVc+3MoDMwJ
	h+SsywVIQbeTl2FGABFW/N71Mftr/DFjplLJ+jUTVo22iATM7611fyCtvuRNBFXmWX8Tm/MV7Bz
	HwbLFzelWspZ5CZGpaJLcYG7Bf+edvby53hh3GeGi/TsODHZwWWp5lCQJzgL0wSSAbImPHW4k+r
	NkxcCiNL8JCauccKLv68CboM7H+5GoW5xxuAEl+sOK6tlkPOGFueHRbIvBq0X+VpV1o+G5dRhTS
	SdiZh96SpW2BMHQ==
X-Received: by 2002:a05:600c:3491:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a96a2e1f8mr174342475e9.11.1766054145242;
        Thu, 18 Dec 2025 02:35:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmKmaqal6bJ8AW/tGnL90ZaFTNmIdc/vSrSGtodk7X4rC4lZvPiUFMpY4/A4JSbBYs4tNZPg==
X-Received: by 2002:a05:600c:3491:b0:476:4efc:8ed4 with SMTP id 5b1f17b1804b1-47a96a2e1f8mr174342145e9.11.1766054144861;
        Thu, 18 Dec 2025 02:35:44 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3aa7cd0sm12039835e9.8.2025.12.18.02.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 02:35:44 -0800 (PST)
Message-ID: <3394763c-c546-4c80-8157-98467c8e8698@redhat.com>
Date: Thu, 18 Dec 2025 11:35:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] seg6: fix route leak for encap routes
To: Andrea Mayer <andrea.mayer@uniroma2.it>, nicolas.dichtel@6wind.com
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Lebrun <david.lebrun@uclouvain.be>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 stefano.salsano@uniroma2.it
References: <20251208102434.3379379-1-nicolas.dichtel@6wind.com>
 <20251210113745.145c55825034b2fe98522860@uniroma2.it>
 <051053d9-65f2-43bf-936b-c12848367acd@6wind.com>
 <20251214143942.ccc2ec1a46ce6a8fcc3ede55@uniroma2.it>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251214143942.ccc2ec1a46ce6a8fcc3ede55@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/14/25 2:39 PM, Andrea Mayer wrote:
> On Wed, 10 Dec 2025 18:00:39 +0100
> Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> Le 10/12/2025 à 11:37, Andrea Mayer a écrit :
>>> I've got your point. However, I'm still concerned about the implications of
>>> using the *dev* field in the root lookup. This field has been ignored for this
>>> purpose so far, so some existing configurations/scripts may need to be adapted
>>> to work again. The adjustments made to the self-tests below show what might
>>> happen.
>> Yes, I was wondering how users use this *dev* arg. Maybe adding a new attribute,
>> something like SEG6_IPTUNNEL_USE_NH_DEV will avoid any regressions.
>>
> 
> IMHO using a new attribute seems to be a safer approach.

Given the functional implication I suggest using a new attribute. Given
that I also suggest targeting net-next for the next revision of this patch.

>>>> diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
>>>> index 3e1b9991131a..9535aea28357 100644
>>>> --- a/net/ipv6/seg6_iptunnel.c
>>>> +++ b/net/ipv6/seg6_iptunnel.c
>>>> @@ -484,6 +484,12 @@ static int seg6_input_core(struct net *net, struct sock *sk,
>>>>  	 * now and use it later as a comparison.
>>>>  	 */
>>>>  	lwtst = orig_dst->lwtstate;
>>>> +	if (orig_dst->dev) {

Here you should probably use dst_dev_rcu(), under the rcu lock, avoiding
touching dev twice.

/P


