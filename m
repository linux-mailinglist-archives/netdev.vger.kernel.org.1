Return-Path: <netdev+bounces-97576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F93A8CC2C9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17451F227CF
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1413FD69;
	Wed, 22 May 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XzEk2P94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0281411D8
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386843; cv=none; b=rboMzTT0Oahs/3btwqjU5Zk4bY4B5V5Pn6kEbA9+8SFNuJBNqHvPRopPZB1BO5IW0Ydab0qJSnkupL6J27M4LI33msPPSgmxUM8pdn7SNND5ANnpGUIZyWsO711x4zxL4QVqWrJZK5sKD1/LfqLfoQjK81e7n+3zByRhpY771V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386843; c=relaxed/simple;
	bh=aO+uQecAMdaZ/THxejYY522XM413nUJjLWjioDy6Soc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C+4/p3RBDbtlxwsSaqN+SQsagAboMc7DghGIquunNu2278Een0aYdlbLej9BI3sdP3gkSwDWXHntXmrf7oEn1eRyDiuQuhXn0HuXQtDgczFY18FlwjIulyghZ9LA82mSI2pDJRbgk6e8gMoBJuaU6xoKr0Kn+/N9gObR0csulgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XzEk2P94; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-420104e5336so5141815e9.1
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 07:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1716386840; x=1716991640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca0NNqSqUZywIvSdbj+1pcee//cZzTWOi+A4n/eRTHY=;
        b=XzEk2P9451HkfMOxL4QYvU2MyK6b2XiVIgjX5O0pNqIyKx1J7LYGDP/zSY0YeD4KBi
         AcIdzTrzIsISLlwkU5DsBmd8hZMNy7fh57JqLhIdWlstC31E/bH2iIwk5atQUQNROc+E
         qrrYoSYq5zuh+lcfZ0tT4y8L8eJhE/54/6k+QAxUIwqS+W40Cjc2XQy/gHPag41WDs7M
         yeSsM7yKL9nOT3QemzNlkKFI78Zk4K2TEK0B8MSIZfsI31h0gpscIxrkoKPq+MB3mt8T
         qu18WcPOMAAUTN/Is2o7lqKSDbwFpkjS18hDU69M2uvDSOhKrEft9M0P2o191lFWDiyu
         2NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386840; x=1716991640;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca0NNqSqUZywIvSdbj+1pcee//cZzTWOi+A4n/eRTHY=;
        b=bMpSGiUaGfM+w1MJ/7KInKNQrrdZoPJiTZwA598/3zCEoAGFDK1WdVR9n7wQ3j4U/W
         cJ/olYO+fTKirJjpW1HeVu5S0mzRqa1IwJIorMTKY5gxuADZYAe++/RLqx/PU4FpwbOC
         u8p9sbnJq4XdYW5pgDaNn2Yu8McFDmc+xonzMXmV9hz9JiUa3CtS2CrufZOBarn3nJrW
         5CUZbYRvB+iDaUHhYLfrifqssrqxnzcrHYQJLhllVzEJXEXPmi4VzMDzPi7HVo1Tm1Jo
         qSa+pkFsle7PAk5qg5DfQQD/RwzBUDLy9IjpCrZe9uiTFHVhC1s/WhWh9xEJ/zIQiqk3
         0Fmg==
X-Gm-Message-State: AOJu0Yz08FLrVjVp4eaoSGEijiftRFy24oeQXDlNU0+3SZUh6XNU89hp
	jpefS0GYToAkuTUCFfpK8Pe1OuGkIBYFDwc69asbxcsAqL9TlFIk+HCd1a3gxsjWfIyTtRigI2h
	b
X-Google-Smtp-Source: AGHT+IGFHrSUAmgisqTD/dgrVALqZX89w2CnYwSlv6AP1qk72wd8WDV3vX9k+D6TWKQAFTh8Zkd3Dg==
X-Received: by 2002:a05:600c:4589:b0:41a:8035:af77 with SMTP id 5b1f17b1804b1-420e19f0868mr103482865e9.12.1716386839511;
        Wed, 22 May 2024 07:07:19 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6af1:c0ec:5522:71e8? ([2001:67c:2fbc:0:6af1:c0ec:5522:71e8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f881110f9sm538215895e9.37.2024.05.22.07.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 07:07:18 -0700 (PDT)
Message-ID: <26aa4e16-a7d5-462a-8361-624536715214@openvpn.net>
Date: Wed, 22 May 2024 16:08:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/24] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-12-antonio@openvpn.net> <ZkCB2sFnpIluo3wm@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkCB2sFnpIluo3wm@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2024 10:46, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:24 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
>> index c1f842c06e32..7240d1036fb7 100644
>> --- a/drivers/net/ovpn/bind.c
>> +++ b/drivers/net/ovpn/bind.c
>> @@ -13,6 +13,7 @@
>>   #include "ovpnstruct.h"
>>   #include "io.h"
>>   #include "bind.h"
>> +#include "packet.h"
>>   #include "peer.h"
> 
> You have a few hunks like that in this patch, adding an include to a
> file that is otherwise not being modified. That's odd.

I just went through this and there is a reason for these extra includes.

Basically this patch is modifying peer.h so that it now requires 
packet.h as dependency.

To reduce the includes complexity I am adding as many includes as 
possible to .c files only, therefore the dependency needs to appear in 
every .c file including peer.h, rather than adding the include to peer.h 
itself.

This was my interpretation of Andrew Lunn's suggestion, but I may have 
got it too extreme.

Opinions?

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

