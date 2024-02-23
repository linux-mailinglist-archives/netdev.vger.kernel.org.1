Return-Path: <netdev+bounces-74381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF3B86118D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2677B223C1
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CDE5D73D;
	Fri, 23 Feb 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPJXdZQe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D98C0A
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691781; cv=none; b=XF5hnHtlXkKnbwiflQJfq/tbH3oCbgTdhvKtYBpX7Lmvd5ZjmjA25Uxb9OQJSD9LuaTgFfXXSdiC5ypgP2Pbvt9QDbaTz5MAnl0+D8IdSV/b9ohzPpf+WmO5/dHOYLatTpH69QqIn3Kbm/RAJO3oZqzW4sYElRyfO18nfOrq0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691781; c=relaxed/simple;
	bh=UPRTJ+JhzEN/BgU+cWSgPpDGXYtDTzb3Bjjthb/rV20=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dPI5pVngXWUIngrZgD9GswFBxTed00TxDLgS78vGGcVV0rgEKFtPSJEEFGO9bP4XmK2Xjjr8uy+dHRLJVfpxtg7SzlxIGITQvG6j1lxt4FED6hudE1m+rjlXUQnyQKi1nDuDqXqy7yDIHjShIs5VqDb/KpA4Shu6diyGgF2zuqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPJXdZQe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d8d5165dbso216046f8f.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708691778; x=1709296578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EvQjauMeFWR9GeMAjT6lfNpL1FnEYX7bB3gNyq2y5Ws=;
        b=fPJXdZQeMjeT2rN7CR7o0CC0l+BBKCL6tKR9B48Sc6prC/NtC0IiIY2QeK/P41Qn7S
         JFipIlK6pZOyWrJEvis750VBH+BOwgVAkeDEUTsQYofj6P+cMwQoOHmbQjat35g6aGG2
         +74+kcMFTFdpIVvKhwSgEse7etJ3a3efqodF2Pc8yg5/SaZ+gMtcIw6uHXFY+Kya0aFt
         QIfkwCtQFnn0lysd1lHMXCTK/a31u7T6Junixm+UBYDCWVhSriXtJ6FY/EKj9XBZlDSR
         p6aCEqP2xf0h7cEFkGM58UVctzX/ULn+Y+l85g+81wWMwkRKThZN4ljLGJd5YlO2oqDM
         sV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691778; x=1709296578;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvQjauMeFWR9GeMAjT6lfNpL1FnEYX7bB3gNyq2y5Ws=;
        b=r6+j/SkxqvrQpRl5i5jucJAoaQQBoummbtWykArV5vAVkOLb4P5sMxS+MwVctqAv93
         BiwkzpzGUKIfJg3QWH55AKynuvNCpHBL9uLQxsVz0BRMKZ53yGfr9bSQSGe6l22Rl02/
         Z6OZAxkM0HwFpdw9728/o4kGlDbprqcxBhesn79y/BVRoqekp/gQnKr6CUXHTaVM8BFr
         HLcrUgjPqsRY22X84yCxNkaquLLvSBDKejVLgXj9z+UQAH+8gokt6zzvU6QB2Ksh+u3u
         fZouHwUxDsHtMXTjBB4HSHTpy3h2wiUc/SO6rmnZNzKBrEbjwsTQsHbpn197KkBWwyXh
         wTEA==
X-Forwarded-Encrypted: i=1; AJvYcCUlGxifE8WMSSZp2SuKGEAYHPfuJH8rbHwgeRtndel1o9E3DjBlfAHG5/zHkudBkFhML0Yeie3l5F5pF1rpBOIQ/R4GS80n
X-Gm-Message-State: AOJu0YzTjeWhgE4dg9yNSn4ow5Cz5viqOBbMeocGsWoeELWWsdell8dH
	DRFlhxZF68z8o6CuAcl+pcDea/DxjFYVDn/DIOFprkmBqQ3nexzx
X-Google-Smtp-Source: AGHT+IHjkorL2qh5fOZ7JFje1AR0cngeykypEY7We55CKAhWMEQVEXbZ2uMXXIQ2VCOvrUJNktCZkQ==
X-Received: by 2002:adf:f58f:0:b0:33d:731f:b750 with SMTP id f15-20020adff58f000000b0033d731fb750mr1466781wro.54.1708691777972;
        Fri, 23 Feb 2024 04:36:17 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id r9-20020a056000014900b0033d2ae84fafsm2618683wrx.52.2024.02.23.04.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 04:36:17 -0800 (PST)
Subject: Re: [RFC]: raw packet filtering via tc-flower
To: Jiri Pirko <jiri@resnulli.us>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, stephen@networkplumber.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, corbet@lwn.net,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 "Chittim, Madhu" <madhu.chittim@intel.com>,
 "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 amritha.nambiar@intel.com, Jan Sokolowski <jan.sokolowski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <5be479fb-8fc6-4fa1-8a18-25be4c7b06f6@intel.com>
 <20240222184045.478a8986@kernel.org> <ZdhqhKbly60La_4h@nanopsycho>
 <b4ed432e-6e76-8f1b-c5ea-8f19ba610ef3@gmail.com>
 <ZdiOHpbYB3Ebwub5@nanopsycho>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <375ff6ca-4155-bfd9-24f2-bd6a2171f6bf@gmail.com>
Date: Fri, 23 Feb 2024 12:36:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZdiOHpbYB3Ebwub5@nanopsycho>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 23/02/2024 12:22, Jiri Pirko wrote:
> Nope, the extension of dissector would be clean, one timer. Just add
> support for offset+len based dissection.

... until someone else comes along with another kind of filtering and
 wants _that_ in flower for the same reasons.

>> How about a new classifier that just does this raw matching?
> 
> That's u32 basically, isn't it?

Well, u32 has all the extra complications around hashtables, links,
 permoff... I guess you could have helpers in the kernel to stitch
 'const' u32 filters into raw matches for drivers that only offload
 that and reject anything else; and tc userspace could have syntactic
 sugar to transform Ahmed's offset/pattern/mask into the appropriate
 u32 matches under the hood.

