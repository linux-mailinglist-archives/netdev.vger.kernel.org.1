Return-Path: <netdev+bounces-74468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4938616CF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191831F262B5
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04D83CA6;
	Fri, 23 Feb 2024 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="j2ZwzDTn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D177081ACE
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704266; cv=none; b=bckkIlfXXLhTmNtfYVRxlZAZr/bwcV6jbr45dIhkdtnyzpLuboGy2z1MC1dQv0n0hyZyLcpCvoBtM8C0a+eot35/ajeBYJyzcdrRZhScMn0XA6HFN6zvM+BhrXaYUjIQTGTlzHEUwfg/xE7BPtPC2ZcOMMb5JUSreEJWSBEFUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704266; c=relaxed/simple;
	bh=qOTpP2DN71IpWaP8zEECCHqAvpeHNYahrUshVTWo7cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kSYxsWYq2+X2BDFfBjpw9YBMaAJqhpOARNLetb7XPwEANQhjscWNvcVWZGMHw5oyb2Z3kQFwnOzQmf5u8LbPuEfblfY4Lzhsb3wpdZdsKB7GCgih+6kFnTWl5cFd49FnqDiO5Bs5Jkc2EjDo+7wIow/SEUfAIAQWKbu0SSedzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=j2ZwzDTn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4128fe4b8c8so7175925e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708704262; x=1709309062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K0gLJSJMs4wZFxTSyJgqnPiA4C/n6gBY5Gxf2RPJfM8=;
        b=j2ZwzDTnneXxWcb910E9dLrx8PY3/Hn8z9gQHfxKz88HZ2henCOoYVE0d/0IfPqMm7
         W2CnYg6UxDgzusKvXi8lvqyB5g5DOPo4WLwogks52lFk3kFp4aVOqEuSin433M/yZU7I
         NJMIzzxGFLrYPuvnuYrae7r3Xqm1LsELcvB60bHSs6zGZGtDMFoec3looIhXMydxwayO
         EVYGprT8sSBxaOs7Hx64ENQwhEBpOkH30xE+gUBOwFZIxTRZz1Z8yxMwkGZlbSfp5DyX
         vQvCRsUvVJRibjNZXlTsHlUHNO5an76hiWCOBOlT2kd6MitHU10HAGAk8d4l/cDLTWUi
         WUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704262; x=1709309062;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0gLJSJMs4wZFxTSyJgqnPiA4C/n6gBY5Gxf2RPJfM8=;
        b=wvAOyJ2Xn7cFSbgPcgJlcN7QV8U1J1IGvumcAoVZj17G0JJFuqs7oXt6xAvYv/JqrJ
         CvoXgk0aIPp1D3WIoks+hp4cbetg/2ke4KdSu5U3looppAewybJTxaNrDJOy6QOK3wGa
         m8VdRA6U9U8/ptTkQGPSbvktfBetVNrqnltX4i4VMMr37+nmw5a1NaQr0xxJGqltfOjE
         Y9/ukTY+78Mx1uc2cOjeElCtuXjBSpJ1Cj+CNTbctNYUIDqFEMq2VQxG9ipi3HlR5eaQ
         3TcKCId0DB6Jf9n6igNJNK7IF6IH7aB0wmHi+n/zGF+Gj69omTBbnFwuFOeHzFZQWn4X
         AGGg==
X-Gm-Message-State: AOJu0YwSSFRUD7yhV19Bq1+QZ0g2Ner0oSQnJthzeWNVv2LDz+92/kE5
	fuI4QZgyx+zQLGLseOrLyIBUA/52glsP7MBXv3ahixLkN43vsDL88p1xLphcVdU=
X-Google-Smtp-Source: AGHT+IGNtNgg4Et9GfbrQsMyDwv/vKkIl14LVs2ApXf76KaMZbrGap6gPFA/uWzi0oKauGXTepOmkA==
X-Received: by 2002:a05:600c:5114:b0:412:919f:142 with SMTP id o20-20020a05600c511400b00412919f0142mr164338wms.31.1708704262280;
        Fri, 23 Feb 2024 08:04:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b0041294d015fbsm2569868wmq.40.2024.02.23.08.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:04:21 -0800 (PST)
Message-ID: <624ff4d2-b4d6-4f01-9b5f-afed92258daa@6wind.com>
Date: Fri, 23 Feb 2024 17:04:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 11/15] tools: ynl: switch away from mnl_cb_t
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-12-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-12-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> All YNL parsing callbacks take struct ynl_parse_arg as the argument.
> Make that official by using a local callback type instead of mnl_cb_t.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

