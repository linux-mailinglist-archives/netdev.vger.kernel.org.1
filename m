Return-Path: <netdev+bounces-100780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB2C8FBF59
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EAF1F2301A
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 22:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51070143872;
	Tue,  4 Jun 2024 22:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAi9dG4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA8199A2
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541742; cv=none; b=Gi9GLBnBDEPHsDdAGe2auuh5WZ2K1MDnSwpB4oEGragnvGqzX+eXSuiM3jdhkcdfqtMkpmQE5VBNl0TaDjc79EDRuj8JFiRTWnGGSknvcMYbhrOk5aNcMPvB6Vl9NUoeBXNsyrrrOSPMez+rob84ikpGpULJXsu/Rd0sqwcl6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541742; c=relaxed/simple;
	bh=kiv6hch/lV5NIdtjIJ0t0xl1ACtBlq7UOClYoAw/pzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cqy5EjUeHuk+wilS5XsPwKYW0Ex4eZMH+FFOPQ/oGoZjMMIwvNhQsCTiZfFon3pXp9cDO5L0UJou+ElOw7aGx+Sm6TWO2nwcarYkg0pX8416pS0yT/ZYzWGvRCS2nsHW4JpqN73kRsw1rXyDMKUgqni0IkEkmeiRosjEDttAKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAi9dG4o; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7eb35c5dd37so37462639f.2
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541740; x=1718146540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UlyyYJnIrSNrrKg+kd3T8ijiojmfhaZCHZfPi7HvlaU=;
        b=MAi9dG4oEwC1h9bBefT56Y+dZFklTuWTM7X//3a2ce/uD3Iha9q/hUtQdxfvsLCdYV
         0n//OB+HPNoleH6R+vuyK/B0k7x7KhCmpQJaV+gI7By12N2VOfT1MIZVCyhm0+LDo0ZP
         o2w2N9X5Kt/Exr4/nEJHZg+Fv5uKA9oDv3lOygcISAQ0nDVPPlMXc+B7TVdd1QoqTr3E
         fz6wYdtNXEIhu9DY+rVtc2soUvYYbXO0NAYHwOvGYc2SuXV4DKvma6Pci6xdmRxQ82WQ
         DsvgAOfNJCV7K8yVyV0EORtgpPi3Ga84sSd4jCwTfCJiXAkTTGvi2pZp1Poh88FIUyJ7
         vAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541740; x=1718146540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlyyYJnIrSNrrKg+kd3T8ijiojmfhaZCHZfPi7HvlaU=;
        b=d+/A1Ir/DKcEGR0deNNMCk6IEy/ohRhR11mWZkPKT3ePQF7hvKMKZbxlXgfoMr2IZA
         CDGpz+GsJaMZeqdwgTlAfoQsJqDwm1QuZ6Un398gVk8w3/38ENYP6dDZ/vsTB4tLnpFF
         OytoT4lefOY76I0mez/97/giqfkHRnR1u/w7rPyVdjvHV9K/tglR7+lQFR1xPDZa1ihI
         tJ+F5VF+LCMRcQzoqmtn99QBzgaAG5UWiX109TdG7PaCoxdjHoEXWAeqa/eyBsxSwnUY
         kGggGdFdroMjfyt/kTRXYtpo6XgEXREWn+uMTWzU2NkRNTzKuD2g8ujHybaNvBVVSzhw
         AK/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtnninRoKURwJHupW27adn0tApH4gBIeWcgYiGgqiPdT6hpSfB3rLTLezniOEhkYJxaimvH8BGXx7jYNBSOZLaCzEsXBXA
X-Gm-Message-State: AOJu0YzrpPJJ0Q669DyyK2X7nZznQ4Y8zqe/ik3hVJcQ6AVmP+oQkIYr
	Jid8yTihjg9aySWJSxpVFtU7XwlyNwsWQ2J9N/I2y8LwxzlTfTpu
X-Google-Smtp-Source: AGHT+IGWph0S9mWNU93lrUZuq1VGQYR7KVCiayV1qgfQ4aMESYb5X8xLMuLP4CJsFgVb12wvV2skmQ==
X-Received: by 2002:a05:6602:148f:b0:7ea:fdc6:3cad with SMTP id ca18e2360f4ac-7eb3c8fa9dfmr97152339f.4.1717541739477;
        Tue, 04 Jun 2024 15:55:39 -0700 (PDT)
Received: from ?IPV6:2601:282:1e81:c7a0:4dc3:d789:d66d:4b32? ([2601:282:1e81:c7a0:4dc3:d789:d66d:4b32])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7eafe4e4311sm272141739f.0.2024.06.04.15.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 15:55:39 -0700 (PDT)
Message-ID: <3aaecfe0-b677-4160-9cf8-fe9920c307ac@gmail.com>
Date: Tue, 4 Jun 2024 16:55:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute-next v1 1/2] xfrm: add SA direction attribute
Content-Language: en-US
To: Christian Hopps <chopps@labn.net>, netdev@vger.kernel.org
Cc: devel@linux-ipsec.org, Christian Hopps <chopps@chopps.org>,
 Antony Antony <antony.antony@secunet.com>
References: <20240523151707.972161-1-chopps@labn.net>
 <20240523151707.972161-2-chopps@labn.net>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240523151707.972161-2-chopps@labn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 9:17 AM, Christian Hopps wrote:
> Add support for new SA direction netlink attribute.
> 
> Co-developed-by: Antony Antony <antony.antony@secunet.com>
> Co-developed-by: Christian Hopps <chopps@labn.net>
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  include/uapi/linux/xfrm.h |  6 +++++
>  ip/ipxfrm.c               | 12 ++++++++++
>  ip/xfrm_state.c           | 49 ++++++++++++++++++++++++++-------------
>  3 files changed, 51 insertions(+), 16 deletions(-)
> 


> @@ -251,22 +251,20 @@ static int xfrm_state_extra_flag_parse(__u32 *extra_flags, int *argcp, char ***a
>  	return 0;
>  }
>  
> -static bool xfrm_offload_dir_parse(__u8 *dir, int *argcp, char ***argvp)
> +static void xfrm_dir_parse(__u8 *dir, int *argcp, char ***argvp)
>  {
>  	int argc = *argcp;
>  	char **argv = *argvp;
>  
>  	if (strcmp(*argv, "in") == 0)
> -		*dir = XFRM_OFFLOAD_INBOUND;
> +		*dir = XFRM_SA_DIR_IN;
>  	else if (strcmp(*argv, "out") == 0)
> -		*dir = 0;
> +		*dir = XFRM_SA_DIR_OUT;
>  	else
> -		return false;
> +		invarg("DIR value is not \"in\" or \"out\"", *argv);
>  
>  	*argcp = argc;
>  	*argvp = argv;
> -
> -	return true;
>  }
>  
>  static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)


next time send a refactoring patch when changing existing code like
this. I wasted a lot of time trying to figure out if you are changing
ABI with the move from XFRM_OFFLOAD_INBOUND to XFRM_SA_DIR_IN/OUT here.

applied to iproute2-next

