Return-Path: <netdev+bounces-119137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803A954524
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2B11C20C73
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857E613AA41;
	Fri, 16 Aug 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="jCEp/m4s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DD13A26B
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799064; cv=none; b=sVLqQKRyw5duGHwegMbXVneOMVH3l2wtRwpxXukOzp34YemoTpe+WlIVKYOAq3vWxWJj3uQbxFc2XUTXjppOBnlhTZmINTZGoJWUBmkm6msbaQxDOmV1uaynKSa1kxJFGlTyeGaby02VSUi3vubCl+W6aNEtC+L/8vEevKgO2Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799064; c=relaxed/simple;
	bh=pDX6GMhW9bZ2vuYczaKu3+W4VoVHLRhJrw6tRP+aUMI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kQPD7DRjWZpc1jhQDfD51tY+q9NDM+Ht8oXYcXx382NyWUJmpBNaw/Klm7CY0aZ5lyGGnuY9MpgUtjJ942ppf45ESQsKAaLc6bM55oQtQlYAGXyclOdsbk7JbdzrI6lN/PsmJo73/DllE6R1fRh1x4jspzbAYyKQ4IckttBubyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=jCEp/m4s; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7aada2358fso439371866b.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723799061; x=1724403861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yaglbcQRS0B8CMCIbUY+hOynPS1WVyIRoX0QEvCxDUs=;
        b=jCEp/m4stSM/WpsLYWuZV+WlkqSlNsqatWAD6u2/jty8dBBUzjIGkF0yFN36vq+Yzj
         nDXG39gM0Mx31mALP3meQ9Uu409vP6kVKzcOBaWDA3eneDZwyKGXFAx07OsRcMjgFvNn
         um+5ZetUup9Lm+39/fqH254yUaHIUhsDgqkzS6epccu2uVgA/cZjaZo4TTOysRf+vzjF
         XQmqh7EAa6fhTk2CeOCJakJ/msN8lFyg2kNruBjkiWRmbsbUtwoPXZrNaVrikeL+F0NB
         +6f9q1oOnZNwlR/3qLff7ZsugaCcAKGPc6M6Sp0f56Gnw4nK/XFFiCiha7I0dkobwQaN
         ZSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723799061; x=1724403861;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yaglbcQRS0B8CMCIbUY+hOynPS1WVyIRoX0QEvCxDUs=;
        b=TdcKbZYm9yMgHXqbcL6CGcG0rjmRdqDat4qx0uLrCcH0xg0JjvqNvWJdhiAUik4fr+
         YMpsrfQEt0TbrCNKPIgwCrU55odXxb4ip4pnrQ0qdWbDCIQ1Wh+tELmOhUtwjK7gZh1P
         muqZmjIDnmdKvPItZu1yORjv3Dyp/0IlwhOA8R93nEoHo+hqMwx/S9bnbNQCD9GP0Vaq
         c22fAbuV/DAHFDT78s0AGPtQl9Q3K0N7OBTggi8xmLHsKk4A0TPA/4TwY+LNXyKYUXE3
         KOI412lVN4PxH4cFEgM/QfD2ukJp6KtzBoPyLN3+CXP6cnK6D+f/MvXSYP0wO0ExiMQx
         /zcA==
X-Gm-Message-State: AOJu0Yxthxabr/O5qoBfoECGt4CP85xTJCsBlPD3+MRLkW6zQmryzttB
	LgJI7jZ1Ja1CHLtk/OjXHEsBfmapLkUD1s1RqggQQ0GTmuRledmA9YRmGDxJdDE=
X-Google-Smtp-Source: AGHT+IEeN/gntW4tr96gv6yur4/odQE4uF/VHstTDrCj9PpmmffdRibKRmlLQbI5/PF52jrcXSTYpQ==
X-Received: by 2002:a17:906:c107:b0:a72:7b17:5d68 with SMTP id a640c23a62f3a-a8394d69ff4mr154060966b.3.1723799060291;
        Fri, 16 Aug 2024 02:04:20 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d380sm221817466b.216.2024.08.16.02.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:04:19 -0700 (PDT)
Message-ID: <bbb2c180-d38d-4bda-bc24-9500eb97cd65@blackwall.org>
Date: Fri, 16 Aug 2024 12:04:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
 <334c87f5-cec8-46b5-a4d4-72b2165726d9@blackwall.org>
 <Zr8Ouho0gi_oKIBu@Laptop-X1>
 <13fecb7a-c88a-4f94-b076-b81631175f7f@blackwall.org>
Content-Language: en-US
In-Reply-To: <13fecb7a-c88a-4f94-b076-b81631175f7f@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 11:37, Nikolay Aleksandrov wrote:
> On 16/08/2024 11:32, Hangbin Liu wrote:
>> On Fri, Aug 16, 2024 at 09:06:12AM +0300, Nikolay Aleksandrov wrote:
>>> On 16/08/2024 06:55, Hangbin Liu wrote:
>>>> I planned to add the new XFRM state offload functions after Jianbo's
>>>> patchset [1], but it seems that may take some time. Therefore, I am
>>>> posting these two patches to net-next now, as our users are waiting for
>>>> this functionality. If Jianbo's patch is applied first, I can update these
>>>> patches accordingly.
>>>>
>>>> [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com
>>>>
>>>> Hangbin Liu (2):
>>>>   bonding: Add ESN support to IPSec HW offload
>>>>   bonding: support xfrm state update
>>>>
>>>>  drivers/net/bonding/bond_main.c | 76 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 76 insertions(+)
>>>>
>>>
>>> (not related to this set, but to bond xfrm)
>>> By the way looking at bond's xfrm code, what prevents bond_ipsec_offload_ok()
>>> from dereferencing a null ptr?
>>> I mean it does:
>>>         curr_active = rcu_dereference(bond->curr_active_slave);
>>>         real_dev = curr_active->dev;
>>>
>>> If this is running only under RCU as the code suggests then
>>> curr_active_slave can change to NULL in parallel. Should there be a
>>> check for curr_active before deref or am I missing something?
>>
>> Yes, we can do like
>> real_dev = curr_active ? curr_active->dev : NULL;
>>
>> Thanks
>> Hangbin
> 
> Right, let me try and trigger it and I'll send a patch. :)
> 

Just fyi I was able to trigger this null deref easily and one more
thing - there is a second null deref after this one because real_dev is
used directly :(

I'll send a patch to fix both in a bit.



