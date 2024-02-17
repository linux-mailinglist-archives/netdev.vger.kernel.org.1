Return-Path: <netdev+bounces-72609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB8C858D01
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 03:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456002851AB
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 02:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D62171D1;
	Sat, 17 Feb 2024 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="lNuAlxdX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484B23D0
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 02:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708138389; cv=none; b=UxJPg3cK+DyxnqISgyEUikVkMqo3zPuvlp+/hvUO8vpouTh5dERxYiwBxIG3EJ3MVmhhbamoCmeVDMKYPqSbc36b3iUtUi9bTmKCt2XtDKdWTfrPZKc63nDc7NdPcepk/bfr5B1B9x9+cfrhndbveAfw44u+378kA43HutUNMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708138389; c=relaxed/simple;
	bh=xWedILKpA8swNFdXJCxMZL5Wmx8ikAWc9clk3Wc56iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGEdB1RY8Mv3+f9tpOhbyuIsemHVR5DVXWn4ARGlEGbSFiNEV95hXOFiq/X7d/IDibDES7bB10XSuNFY97sYznVVKloL38METVrwVnNg12ZmgJLhyTHR77I+gtnaCrp90x5XoQeCNUeU7zL0h7G6dxYEjLiCZa341VcbyiXgbJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=lNuAlxdX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dba94f9201so11407825ad.0
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 18:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708138387; x=1708743187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kE8XebWoZx41+yO25UAJXmvFKFZab2wApIilugYjFUk=;
        b=lNuAlxdX4RlOMwY382ooS3dbwOCkWt3kc5RHg8pjO73yF5UFsd+aqNk4sxy3jsg/BD
         ZbT3l1+pOYaAyg2gaHZs/w7ieTAhxpQlMH9va1lWnpsAULMtdR8uggGHq6fmBQ2/Vkqx
         CzM6w2gqpUAv9X+oX/h+Cjc3U8qursiNMXbPhWp9E2RTxI3elObof0VnusUPJiObAhZ2
         GOUpHyrl+YThHrR40k1kAbGomwkgzBPyl/WsScTn+6aLQKaE7thLJsIERGZbJTvCwXKl
         yGx0vZPa8cIe2ng9ovBf3xcOdjUBHUL44Vi0r9AGq722x1ZHrExvDt8Kfg69LW1/OxAs
         mHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708138387; x=1708743187;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kE8XebWoZx41+yO25UAJXmvFKFZab2wApIilugYjFUk=;
        b=vsz+IowUl0svR63aRomqEY4fsXSofTZeOqgm/LsYuGUT8Wv1gg17uMwB0RolM2x+sX
         CTpNcVFEWbImE4y4DDUCk1hjpdvMMu8/+7FM2UVn3x3u9UyCCbrqgApXaIMREF371Ilf
         ml4KrjVeP6cs/52IuZsMabyc4L3hDC4fyC2BtTPmsMsLiPuC3FZwSkBm1+uhdAERAOKX
         M4Jm9h0HpVJuSMbC6IDZ8Ox32+3bJH1Nfu/jV+tSfR29FZlJU4pzm6TOMyTHtlflg4Pi
         vHpmwSXLx1/0Iv/pR++dT0MeTUkz61UpdEiDVJAWICwY3DFomJcLZy6iGC2zkLco3pdx
         AfpA==
X-Forwarded-Encrypted: i=1; AJvYcCVeOFLaiKxbLAN470PMLAD6xIwipcTIAPoPpxORYMJ79T3I5hp84pwihdAKJuSoR+vSz/SLUOIuJHQD68lXXnRHlkIZZ/eT
X-Gm-Message-State: AOJu0YyBIhrpZ/GPnpZxa2cIPS1FWGW49jzUe8FrH8Wz9dyHIWpP2PcW
	6wfDvNWv3KpZsUh9K2Rwh3JxFNj1/enceuJetE3KWtumbikaV/bqphId3cuXYcs=
X-Google-Smtp-Source: AGHT+IHIFFw9xBbbr3xhSDRYIGOv2u+RC2kxyt8iQuFPfJG1QgLXHHVOylfxXJJwnuFolxnAdzcrbA==
X-Received: by 2002:a17:902:684a:b0:1db:730c:c077 with SMTP id f10-20020a170902684a00b001db730cc077mr5609139pln.58.1708138387163;
        Fri, 16 Feb 2024 18:53:07 -0800 (PST)
Received: from [10.1.110.102] ([50.247.56.82])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902e18500b001db499c5c12sm509452pla.143.2024.02.16.18.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 18:53:06 -0800 (PST)
Message-ID: <82d0bfd2-2b49-47cd-b91e-b5e749682537@davidwei.uk>
Date: Fri, 16 Feb 2024 19:53:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/3] netdevsim: allow two netdevsim ports to
 be connected
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240215194325.1364466-1-dw@davidwei.uk>
 <20240215194325.1364466-2-dw@davidwei.uk>
 <20240216174646.6a0dd168@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240216174646.6a0dd168@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-16 18:46, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 11:43:23 -0800 David Wei wrote:
>> +	ns_a = get_net_ns_by_fd(netnsfd_a);
>> +	if (IS_ERR(ns_a)) {
>> +		pr_err("Could not find netns with fd: %d\n", netnsfd_a);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ns_b = get_net_ns_by_fd(netnsfd_b);
>> +	if (IS_ERR(ns_b)) {
>> +		pr_err("Could not find netns with fd: %d\n", netnsfd_b);
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = -EINVAL;
>> +	rtnl_lock();
>> +	dev_a = __dev_get_by_index(ns_a, ifidx_a);
>> +	if (!dev_a) {
>> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_a, netnsfd_a);
>> +		goto out_put_netns_a;
>> +	}
>> +
>> +	if (!netdev_is_nsim(dev_a)) {
>> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_a, netnsfd_a);
>> +		goto out_put_netns_a;
>> +	}
>> +
>> +	dev_b = __dev_get_by_index(ns_b, ifidx_b);
>> +	if (!dev_b) {
>> +		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_b, netnsfd_b);
>> +		goto out_put_netns_b;
>> +	}
>> +
>> +	if (!netdev_is_nsim(dev_b)) {
>> +		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);
>> +		goto out_put_netns_b;
>> +	}
>> +
>> +	if (dev_a == dev_b) {
>> +		pr_err("Cannot link a netdevsim to itself\n");
>> +		goto out_put_netns_b;
> 
> You need to fix the gotos here :( You're leaking the references 
> to the namespaces on error paths :(

Sorry about that, should check every time I move code around. :(

