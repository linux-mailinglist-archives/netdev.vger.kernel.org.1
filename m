Return-Path: <netdev+bounces-119135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A4A954495
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 10:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84951F27D72
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67CA12E1E9;
	Fri, 16 Aug 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hpKx1L0l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD121D69E
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797469; cv=none; b=ebtcfQVY/7qT6Pn6Ymnnl2A0w7eovQCmTaVv52eTGnX29SOJGX+xi7G+I0G4VIgzZE/eWnz7wddKLI4a8JwDHEcSeUcGuYKSwWQ0+IWwOHbNTNQuWoZfYWovu6awF16+rlwCMfiKgOI5NkaVhWY8Qpbn1py4eqBpSeCVwHyoZf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797469; c=relaxed/simple;
	bh=ZUz2iYHqvrn/cYuUYnR5+uUUQuLflOpWkqyDGbWD3qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgzT9Jd7bNKTpCPSQTztb/ck7q6xmmW+YNhrE9vyryqn1ifYwDGSXJxMK9Kjndo1KVMg7WJxkAND0UiE+oPkfWJH75cpbVTylel06/tYw2RdhOD66evvSGFzH7XLntAOy0ZufRYvlGCbkkIAYOBplojgc+lbfjD2bYdBxoYJTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=hpKx1L0l; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bec4fc82b0so2033283a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723797466; x=1724402266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okRaO2NjndrnhHpvoryAQJD7oMur192dhTfSj5AVPe8=;
        b=hpKx1L0lWu6EytY1EPJov7Qm0dF5oHAFxEazrhsP7BZ3FLYh3nI1FrhL4tAuB+zYD5
         lKsp30d33/WK2IzM2sHueOWx1zfpzJYrri023qLKZ/ZMD7PxRoA3CXswKz0WyULPMWWN
         CjPdq5zrTA/e0pYKl1u0TJqDbPMaHLwjsZDiT19pISviej4K9/i077iPOvHrCeuiMVgu
         39PfZs3NEPBo7fmRjwdiKQHo4s0jRDB5LafiBPx1giRdCaffEh6+BTQtM9zjlhM+on/H
         Qh753m4bsbf/IQxThX+ki1UBPckjJ0Osz1omM8qMHUexn+nyR4FJKykkhLBVOFLD17Dp
         0qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797466; x=1724402266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okRaO2NjndrnhHpvoryAQJD7oMur192dhTfSj5AVPe8=;
        b=tWCEcN0MZqyn7mS0WgMYAji/KwnDBLODjJhR3mAXapdGOBC1yoHarjyRH0bdZJerQD
         F0dybrQBCLbmVI+5B89KoiznTjW3OGixAFb4bvxCP2ga2w6M1AvGEc8+7NOhKC7eNYzx
         kB91JwL2BNGFSrhBvg+GUfeSaZzh8UBraU1rqIJaAvFR9ey92mZtpWn4R/vYk/ft7l9n
         5Bd1A1OA2YzUziszxN838hbdH3bMLSTivYM3t55w30006F9CFopgOwe/AYlTwriJ6w0v
         mB98GcKqWpZSghxECd8x1pitKJE4CCTQjwWZs1kXsbw9FmpQD2EgrE09uRyRvnjNAxFW
         lQLg==
X-Gm-Message-State: AOJu0YzDlVq04d1emJxhSRKoGxnUL4Qae7eIwnPbdC/pGOnpENNTCdGe
	VZXoqkT0K+TFsMYttiqb5dyeJaDOvceNIbqaW7po9SqTfSkf0o7PS7Bba79erBE=
X-Google-Smtp-Source: AGHT+IF26iEZolzdLpUFhd2gCBXE7C+mJuNCGkv8MGQMrxemlq2genccuvMjA0jgsuRvIQs/3YGlfA==
X-Received: by 2002:a17:907:6d2a:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a8394f7e0b9mr170559766b.22.1723797466029;
        Fri, 16 Aug 2024 01:37:46 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934508sm223985966b.101.2024.08.16.01.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:37:45 -0700 (PDT)
Message-ID: <13fecb7a-c88a-4f94-b076-b81631175f7f@blackwall.org>
Date: Fri, 16 Aug 2024 11:37:44 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
 <334c87f5-cec8-46b5-a4d4-72b2165726d9@blackwall.org>
 <Zr8Ouho0gi_oKIBu@Laptop-X1>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zr8Ouho0gi_oKIBu@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 11:32, Hangbin Liu wrote:
> On Fri, Aug 16, 2024 at 09:06:12AM +0300, Nikolay Aleksandrov wrote:
>> On 16/08/2024 06:55, Hangbin Liu wrote:
>>> I planned to add the new XFRM state offload functions after Jianbo's
>>> patchset [1], but it seems that may take some time. Therefore, I am
>>> posting these two patches to net-next now, as our users are waiting for
>>> this functionality. If Jianbo's patch is applied first, I can update these
>>> patches accordingly.
>>>
>>> [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com
>>>
>>> Hangbin Liu (2):
>>>   bonding: Add ESN support to IPSec HW offload
>>>   bonding: support xfrm state update
>>>
>>>  drivers/net/bonding/bond_main.c | 76 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 76 insertions(+)
>>>
>>
>> (not related to this set, but to bond xfrm)
>> By the way looking at bond's xfrm code, what prevents bond_ipsec_offload_ok()
>> from dereferencing a null ptr?
>> I mean it does:
>>         curr_active = rcu_dereference(bond->curr_active_slave);
>>         real_dev = curr_active->dev;
>>
>> If this is running only under RCU as the code suggests then
>> curr_active_slave can change to NULL in parallel. Should there be a
>> check for curr_active before deref or am I missing something?
> 
> Yes, we can do like
> real_dev = curr_active ? curr_active->dev : NULL;
> 
> Thanks
> Hangbin

Right, let me try and trigger it and I'll send a patch. :)


