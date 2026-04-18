Return-Path: <netdev+bounces-279503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /VTFFbiE42lJIAEAu9opvQ
	(envelope-from <netdev+bounces-279503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:18:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F434212E0
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 15:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BCE6301BC1B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD72340A5A;
	Sat, 18 Apr 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV6sqE2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FA253F05
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518325; cv=none; b=Gchq3m7dYZ6R9hjhv5Bb2nblysktS06Gnq9Jc5fA0abelkTUIIWSTmmG4L2njdr6viGXIjlpsvojkdaz0NQoG2upzCkvQYtdIi1/67StmIrvjGhphUzMyBCLS/QJnFVT/OXMdLOPkh1YKhJp3g26MOOTbmCsH6S85MQLDpiUUyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518325; c=relaxed/simple;
	bh=DEHdXWm3KnualiRjYBm1wKHFH28Za8KZWRHei6gH+iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljcpYV0vASOHCw7isHBAEvHzHwVEzwA4haH9XuLlx21QZa8k4WfJ9aAAY6OwcdABDtTyaersMuGEVc3iYoItBhwIdt/IWhDtRFD1PgrT2m3YabccfoeXtrIYRI7vvBllCMr44dNRUC9lSK6QM60IeH2p/3wmKT9XwcmBE5YcFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV6sqE2Y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso11940385e9.1
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776518322; x=1777123122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BW9qX9SA5xkQCZ1w/1p+DaP5ck6wzHD8I1yuPBA9Jmw=;
        b=GV6sqE2YMTloWofDDFypxbPx3iuBgNhktnOmVcomiNkz8Z6kP2qv2vzaPmusYebq/L
         57oUViWmc5xPdCus8ogSv3t1YDr7MBBFlQCp5N0boW2s5k//EUZhNTuWMkGt2DfhHLRy
         xPdqjN0mNg76B2eDJwGDK6Rdbdzo31JiedQvgJgsN8MRDi6rYW52Ow0GzZ7IMIzi5PJX
         VaVdM9p5A2+o0DNkdCx5MnfHbfDq+L/5jnYcqqVPNblPn91ff/YaPR0HGRUnUMxf0JcY
         YXmjeak1KPmBgIh+wPZu+RDDtc8dpBq0/eAYIvWUPg0esmbFPNOd1osVURZwnE/NdJYu
         Cv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776518322; x=1777123122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BW9qX9SA5xkQCZ1w/1p+DaP5ck6wzHD8I1yuPBA9Jmw=;
        b=RxiDcgmi4rxin++qz3y+06yqWIdGCC8NvV4V9BE/j/I2nPVRSrpp/6Ylfb29UDUcXm
         eGkogEcLDgtKCX1t2jgNcvp7HbZQ02QuRZsNbJWPfPhVsP0sTGjmh6NHeMHUJrmARRnD
         aBaFvc2FfpHMzpvmhDmtU4o7XV5BUKD/W95yLcCAVFPaBfpVFTGQqGPcnQJQvqAFaL0p
         x+qExOOUwetMBDMINL3UgOktnyCQCMu9bA0YCj9xiB01mIwOJ9OQ5JR5lcaan9bncNQX
         8Ixtujq/3aFcZ1zG4lx3LBjnpFCeuoGthWxWECTDw+LhNn3ZZ/Z0Rv/hMj8Mj/aXAPZR
         X4Hw==
X-Forwarded-Encrypted: i=1; AFNElJ9GHo/J2LpHY8lX0EiPr4OoFNKVLuHodVJtAhwlxxw233WcdMU/zko2ZFTTOJ8bsonOpIJPd/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOtU4sFjskiLvTOvqefAd376IWLRodveoVqJPebxsl+hFetaP
	ULP3fo3QzcGKUQWsx6XyJ6U6lgcifaNOJJv6iVl3h+0TTcQn14xTObWC
X-Gm-Gg: AeBDiesvCu6Nkhz4VEVD0Cyo8UcKwtryNLkG24hPlWygjGzvU1ggRWrZ9ovymNnUjXj
	QZhMO8Yj9DkUFUHUimIaaSUZTRBvXxGsrQTFX5JsHDAxPxRaPkUrViH9RhpH14kzId2JulFO3cY
	An4Cy0VWhzBOY1joHj4ZrzXQnbNbhU/keevCgcJMYdiyo+np9+Ymd5ngUjibKQ98khEWJ44ZIPj
	OZb1uoT789cb2Bn5IeEEzzXPTS73izrw+EZeLCLRPf/+P82pzo/gb6SGuonRr+4YHOkAjMfxWG5
	FFlmGiI29k+cxiVK2uqAVlsk6zAnG70vsl5EuELrHBuTNsusjP97bkELIaLse1K1kvkTZ1tODKP
	Uf9BrmoEa9uYiK7CFArExQD7mOJy6JXPCw4TbaxeALeA5EhzIF4wwI5WIZp51sAiKjj5y3AD3Eh
	2hw7XqIwJUMmH2KbJrkmqZaOi0/Gpra4G1qXuDeEnggrn3Ot0E73h15+dKuZal84Hb+6t/NdYzk
	eqYMwxC7slYfisi
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-488fb73d9ffmr75828605e9.5.1776518322054;
        Sat, 18 Apr 2026 06:18:42 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc181c6dsm118018395e9.6.2026.04.18.06.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 06:18:41 -0700 (PDT)
Message-ID: <126f6072-e6a1-4d14-be56-d98287e25e02@gmail.com>
Date: Sat, 18 Apr 2026 15:18:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Implement limits on extension header parsing
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260417171831.687053-1-daniel@iogearbox.net>
 <60b47924-dae4-4a10-b977-75b92e1094c0@gmail.com>
 <ae053593-907e-4891-90fb-03b4c5d8f5e1@iogearbox.net>
 <b57f31a2-456e-4727-839a-bc2f0fb07855@gmail.com>
 <d4c72730-2d74-4efe-8ede-50e3fe9658c8@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <d4c72730-2d74-4efe-8ede-50e3fe9658c8@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279503-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94F434212E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 14:59, Daniel Borkmann wrote:
> On 4/18/26 2:50 PM, Justin Iurman wrote:
>> On 4/18/26 14:26, Daniel Borkmann wrote:
>>> On 4/18/26 1:45 PM, Justin Iurman wrote:
>>>> On 4/17/26 19:18, Daniel Borkmann wrote:
>>> [...]
>>>>> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
>>>>> index d2cd33e2698d..93f865545a7c 100644
>>>>> --- a/net/ipv6/sysctl_net_ipv6.c
>>>>> +++ b/net/ipv6/sysctl_net_ipv6.c
>>>>> @@ -135,6 +135,14 @@ static struct ctl_table ipv6_table_template[] = {
>>>>>           .extra1        = SYSCTL_ZERO,
>>>>>           .extra2        = &flowlabel_reflect_max,
>>>>>       },
>>>>> +    {
>>>>> +        .procname    = "max_ext_hdrs_number",
>>>>> +        .data        = &init_net.ipv6.sysctl.max_ext_hdrs_cnt,
>>>>> +        .maxlen        = sizeof(int),
>>>>> +        .mode        = 0644,
>>>>> +        .proc_handler    = proc_dointvec_minmax,
>>>>> +        .extra1        = SYSCTL_ONE,
>>>>> +    },
>>>>>       {
>>>>>           .procname    = "max_dst_opts_number",
>>>>>           .data        = &init_net.ipv6.sysctl.max_dst_opts_cnt,
>>>>
>>>> NACKed-by: Justin Iurman <justin.iurman@gmail.com>
>>>>
>>>> +1000 on the need, but NAK on the way it is done. IMO, we don't want 
>>>> yet-another-sysctl for that. Instead, we have (well, not yet, but 
>>>> it's about time) this series [1] to enforce ordering and occurrences 
>>>> of Extension Headers, which is based on an IETF draft [2] (FYI, 
>>>> draft- ietf-6man-eh-limits is dead). I think we should enforce 
>>>> ordering and occurrences in this code path too, instead of relying 
>>>> on a sysctl. Let's keep both code paths consistent.
>>
>> Hi Daniel,
>>
>>> Hm, that series [1] should probably go to net instead of net-next, 
>>> but atm
>>
>> +1, would make sense.
>>
>>> hasn't moved since a month. I'd still think max_ext_hdrs_number would be
>>> useful given it has less complexity also for stable, but I guess 
>>> ultimately
>>> up to maintainers..
>>
>> In the short term, I agree. What worries me is that we end up with a 
>> redundant, or even useless, sysctl once the other series is applied, 
>> which will only increase user confusion.
> I'm thinking even if that series lands, and there is still odd hw out there
> where the enforcement of ordering is not in place, and users might be 
> forced
> to disable net.ipv6.enforce_ext_hdr_order, then the limit would still apply
> and protect them.

Agree. OTOH, IPv6 packets with out-of-order (or more than allowed) 
Extension Headers look suspicious and should probably be dropped by 
hosts anyway.

> Cheers,
> Daniel


