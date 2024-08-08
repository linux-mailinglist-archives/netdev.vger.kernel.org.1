Return-Path: <netdev+bounces-116807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3028E94BC51
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2661F21BC7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D351015534B;
	Thu,  8 Aug 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdEySFc6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA818D651
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116793; cv=none; b=TNIpKuxZh2ZrUPtJpgxHIS/fno9RINtCk88NOIX5DB0tVCeuRA3xw6dy3DfZh6F15a0u438naRzURxVVh4AV/UyOm0EYsnzDujXsSCZQV9ENN6j3VAMQbecQgN19u5bHjX+CRcvOF39i8iL981W+QhL+3VmW8bIPgpdwhMzswWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116793; c=relaxed/simple;
	bh=mmjJXiRI2UpLgFXIEPH/VoCuyyT3l4eJ0NiF+DRX2kU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nLuSod7nL7Q6CzEs66J3E+aqBqpoEs2V3AxopTsFu6rtivQEFxAW41oN3KoY16J+a5EAYsn4HWjrGSfJCxW5+VRF1htTm9uBGgNmxx5BKdHe4wI2IU/LFWti9a+pY8p/t9cKjIjJjupA2umfLTDzaAAOk7/gJRFZZeRlWOh9xtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdEySFc6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42812945633so6422755e9.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116790; x=1723721590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eu0SEYZ0jpeIAqnQRueQyzZ54hiqWHmCWyFQNC1xE4=;
        b=bdEySFc69lJvXhVbgWB13xosDwUt0+mh1e8/7VmSXUwuOmhMtONk/FLYwVVhcZqLua
         Kv62iavvW41u85nFnXS5rbJfdkpCdkJxRHiq+alMQ7pMAtbI/kYprn+pQjAfmaGwPLwt
         MseYxSvniO8J5xZPFRfCRFyfCwPy4H8rWbM2lcEVQOY4dxHfw0FFmNIJLbje044r2Qgh
         6PJkTyKyzBlp2hAT1hjA4Ch1IIhNhfQrEMLYLHM84Hi3McL2qZjdr+YRLHu5cva9qqWj
         9zvpBo9p1GtoBNq+KLYUMaOje4/JukEgMgVuwSnbP1jrL4+13XHHWgQUqGAY/SXV2CaS
         aFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116790; x=1723721590;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0eu0SEYZ0jpeIAqnQRueQyzZ54hiqWHmCWyFQNC1xE4=;
        b=EdNY+EeruW+6pdEfK0QGruS6DVvJDXlE2PHUNeoFn5aMG1RfkJ32heeWB6ilxfBgJ1
         T4xRhKyKVySjG5jCoI679S/Dwbrq336Qx58E7qnrkJGEynQ4QrJaCQQz9uUGBaIcDFkH
         JQHRjHEMZEDIbEl0MgjKRqesJUWcxwvMYjWI47kdeJC1dbFn4BgS6NPXUwkCDE0M6YvE
         c3iZY2t1yhAh4+5x3KqIu6ekhIEo1MpI01E+lj3vQ8Markig9kkru8nSJ3xBAPdnivmG
         B4yiO4crxI39PFUk5BpbslKc4lGil3dC3ZBE0haBzIFea+JO1wgHz/DRbpJYG1zGK6tu
         1RZQ==
X-Gm-Message-State: AOJu0Ywa7LhA82UpUA8mdxpyQ+8QnhbpHNN24wYekR1+faKYRnQCBOtZ
	3LDPlp2ISdBoy6DRF90Fybqh6Q8gTvoaHNTeqJQOSkVoLCXwCcnsK5dShg==
X-Google-Smtp-Source: AGHT+IGZh10CupHptYw/Ke1Yfj3xBsbr2znAsmtasqlR6V3vSW/oNUAwRVo6k2eAU4Ag7C1juDVYAQ==
X-Received: by 2002:a05:600c:470d:b0:428:1ce0:4dfd with SMTP id 5b1f17b1804b1-4290af4f801mr13317845e9.34.1723116790018;
        Thu, 08 Aug 2024 04:33:10 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a38a6sm18349565e9.42.2024.08.08.04.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 04:33:09 -0700 (PDT)
Subject: Re: [PATCH net-next v3 09/12] ethtool: rss: support dumping RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 michael.chan@broadcom.com, shuah@kernel.org, przemyslaw.kitszel@intel.com,
 ahmed.zaki@intel.com, andrew@lunn.ch, willemb@google.com,
 pavan.chebbi@broadcom.com, petrm@nvidia.com, gal@nvidia.com,
 jdamato@fastly.com, donald.hunter@gmail.com
References: <20240806193317.1491822-1-kuba@kernel.org>
 <20240806193317.1491822-10-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <c028a2da-9844-5ddf-9e1f-0f9f1ccf11f8@gmail.com>
Date: Thu, 8 Aug 2024 12:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240806193317.1491822-10-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 06/08/2024 20:33, Jakub Kicinski wrote:
> Now that we track RSS contexts in the core we can easily dump
> them. This is a major introspection improvement, as previously
> the only way to find all contexts would be to try all ids
> (of which there may be 2^32 - 1).
> 
> Don't use the XArray iterators (like xa_for_each_start()) as they
> do not move the index past the end of the array once done, which
> caused multiple bugs in Netlink dumps in the past.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

