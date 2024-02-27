Return-Path: <netdev+bounces-75302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34288690DE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A98C1C21489
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2720F13A258;
	Tue, 27 Feb 2024 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IHPFvnjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88A4A29
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038145; cv=none; b=ajVL4alRrHPkShRFbV6E8FioF8+Ea3P+pi0jxKEsp2ho8dIANaUWrVHRTbQdO0R3Po0rA6QnA9ZiDL5HD/HXPL3W5pXFipdRmy3261EQBkJExqpJV83ORNair1WctIbBsDcjKTWkdHCwEpt7F7gtVW2+giBz1M/Uojps0OuaEc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038145; c=relaxed/simple;
	bh=3Adn02l+rBpmLkp1/7FCYSuJsiZIFS3iVRiyxWgNBx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Rbjn8w5qVOAjp9gG0nVp0ghsspeH6/Q5NWde1LW24INPcTM3aqXl+M81IZrOKz1wxy0ZVZjb5e5B0gwJA3Ofs0n5f2K16hws+29M7Spe/PCbhp8qVr96jx0jdp6xjiH/EeZ6yv0XWuZD3YbeGLV4iaH8qewrCtS1v3nToci9LB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IHPFvnjB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5643eccad0bso6466252a12.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 04:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709038142; x=1709642942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXtalWSl1Xmf5dUHaBqDTPEoW8Q7d66X12zYzFz/gkA=;
        b=IHPFvnjBakysYw/5nkHSD37/FARkUzPRPK761t9Zd3pPzeEnZ+fCxeG7HvAVQST8lG
         P8MeBvvGEKbqODYUBFHPfOetaqHKW7ApnDtdEwjGe2qBX1FqynuKT+lBTVE+vSMQspIC
         ceFnbT8RXmcA13NaanfIenPQyt49T0dSRk2nnBwiLa07j2d2tlTHQAFrOYhj54FdM3qy
         fLlMaQ6hjLNPOwPp/6E76kZoa6zhmL43fwIAJXA8mnAuEHbAlEliEUkf9Eva4LId5ckz
         cOLXcx+pG73vdAO8Pk+LdptmWsGtpTTaHUFPaIOsGLhJVZcYag2+9Uq2HmxnPzSZpa/A
         CZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709038142; x=1709642942;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXtalWSl1Xmf5dUHaBqDTPEoW8Q7d66X12zYzFz/gkA=;
        b=u/Vr7s57Tra2p5uwlZDR4+MN9sh7g6Qnc9CiK9kEsLa7/EItvw9pd5dHVFODg8DS5p
         E8rBE2ILlFwwRqCQ/AxEAje0pgaEEeQQ8GQKEmLw+XF3/Ja1uuMfSzNIGScVsIaALyI8
         CrKnmIgsPg5u9Un1EOLHyIILip/caZHPEelv73H1Sz7qMJ9uJPBDBOdfYtW9KkuUiu1U
         rbRvladWYSHQb5DUUCZztB8gfDUBxh+/3Ce4wswUpG9bblhhFmlpELMo7bOUR15ORHSg
         0B2oQ8GJL2+0omQ3AHZanF8CoWQFz7r9SW4LIl0oIPjdDTUy/i4l5kfsyCN9yj7Z6Hxt
         Sm+A==
X-Forwarded-Encrypted: i=1; AJvYcCUNbKEdvhpMn2tUMDlgu1eyjzs/wVhkEzmhu0RDGzpGG5Gx5qcPllGwrNppBoPWuAOBLCzWlw9+iwS87sompQrMVynjDrpU
X-Gm-Message-State: AOJu0YzQeHls+fvOIPgu0C+YREYoRr6utxg8dQjO4tmAL58dAeknadZY
	OwW9lhNopTbdLJ9eYdEBHh9z4S+3gK2OvkZu8eZzNgYrMV2cGADup6HX7JENNxk=
X-Google-Smtp-Source: AGHT+IF9UQ8VJYkjYJkVCT7Ixu/dX/qeyRxPC16DhW9tk+0qgKwGIWZVw1qVVig8Z3lnVLTiiTd4zQ==
X-Received: by 2002:a17:906:470e:b0:a3f:eff9:7f44 with SMTP id y14-20020a170906470e00b00a3feff97f44mr6322816ejq.61.1709038141515;
        Tue, 27 Feb 2024 04:49:01 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b00a3edb758561sm730284ejb.129.2024.02.27.04.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 04:49:01 -0800 (PST)
Message-ID: <43822f54-cc0b-4ac7-814c-502f6f995c28@blackwall.org>
Date: Tue, 27 Feb 2024 14:48:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS
 writing back
Content-Language: en-US
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, jiri@resnulli.us,
 lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com,
 pctammela@mojatatu.com, liuhangbin@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227121128.608110-1-linma@zju.edu.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227121128.608110-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 14:11, Lin Ma wrote:
> In the commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length"), an adjustment was made to the old loop logic
> in the function `rtnl_bridge_setlink` to enable the loop to also check
> the length of the IFLA_BRIDGE_MODE attribute. However, this adjustment
> removed the `break` statement and led to an error logic of the flags
> writing back at the end of this function.
> 
> if (have_flags)
>      memcpy(nla_data(attr), &flags, sizeof(flags));
>      // attr should point to IFLA_BRIDGE_FLAGS NLA !!!
> 
> Before the mentioned commit, the `attr` is granted to be IFLA_BRIDGE_FLAGS.
> However, this is not necessarily true fow now as the updated loop will let
> the attr point to the last NLA, even an invalid NLA which could cause
> overflow writes.
> 
> This patch introduces a new variable `br_flag` to save the NLA pointer
> that points to IFLA_BRIDGE_FLAGS and uses it to resolve the mentioned
> error logic.
> 
> Fixes: d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
> v1 -> v2: rename the br_flag to br_flags_attr which offers better
>            description suggested by Nikolay.
> 
>   net/core/rtnetlink.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 

As Jiri pointed out, you should wait a day before posting another
version. The patch itself looks good to me:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




