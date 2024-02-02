Return-Path: <netdev+bounces-68437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026C846F0C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44A61F27F9B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6960DF2;
	Fri,  2 Feb 2024 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eY/NHH/S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01BA4BAB5
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706873842; cv=none; b=l8s+DYxOej9dVQsGzdqn8dP3jZuuzTwFik9uOHJyXBb1duZxNQaQ42WnYpmoWaNqMwtIwyTC9AE9QcnfP4JkrEyLP+fDivwgU4Wx0rInRHo12MdhlMAgQoi+9SlJV4JU7amm0+6FUBdsRAgnkJ+5zGgz6OpuCuaNQuAIE3shtmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706873842; c=relaxed/simple;
	bh=5ITX4M7NNZhMdZOhdloezK66zkwOnZYHAPoJGwc6d04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMJFAI52v2u5VmxqcXPsPhNa8vPDzZHc2zYCEUPp5ahNbcCAe4qC5SIZiXtb+/e7+onHJg51jhHSV8PyZAmeD+iFM6aqdtIWzyxt04xEnPaPgyOKQpkyIsrxpFBqFpE55g2/aCZAmM8R6akPbaU+vkvKQ2Le3EPD2a6T/5vHp0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eY/NHH/S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso16431305e9.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706873839; x=1707478639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUXRx/CtdVJ7bTO6O0nWj1rsj5lqnWx/R9lyMFBiJU8=;
        b=eY/NHH/SjojFPhqEGwfxTI7SOaSsOsX3x01qR8niLzaAJA1yiwz2uNciEqpgU9F98q
         Ejn0cF+5hUwyJGye7KflOy/uvA1ki9HaEpVrnlwnyfbolYV+55kr/Tz5rzh+g9oETkxD
         Xcobvy2bHt45ENSjlBnlsyeKXTzyzDtTyo/agSIbngOhj05HGhkjs89QdRyUdJHPznAS
         bROS1PjDBkGhdBnJDFGddJMC9Pe2/Zl6ZfMJbHWqnbKCtk6xjbqzx/omxB7zsHxhyuqA
         7vsxy3PcCP2kLBLFdRfmYsnDV2iJ/f2VBqvYZsn7gRDGWsm3QD1rk5wuFAHJyNYEwnzi
         lZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706873839; x=1707478639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUXRx/CtdVJ7bTO6O0nWj1rsj5lqnWx/R9lyMFBiJU8=;
        b=Rc+AbML3nsj2csimYiFQX0ku2puVmvhu+Yb6KAhuu3guy2jVy7Z/FvbLnId7muVuUR
         u8SHLDWKB8c8YxuujydzZBo2ddmgs0aJlbFt/gKuuCgGNotFCkfPLRjhXfL8C10StNkM
         7bZg6tOWw5ra8K5d/z3Mh8/uRBAcdrPvxkqLA3zSUsqrzoanliiKFArIfoYTznYdXkyW
         x+97gkI1t2lNnF9o2OEYfEIwUGslZDKtnfkb57GRTWpLYmM8CsllcvkslFeMGZVjQd8m
         FiEpmdvv4q9VUAy3Gbwe46mJTD6rCWVYfBZFGTpJEa3QtbtwcHzYBeP66sRsDuFCn/S2
         za7Q==
X-Gm-Message-State: AOJu0YzeD4kqPlRK02CFAzxu81lLB47hX13sX9gzQSy/Khx00nS8vt0D
	8xBoQ5uCJ8ixjdLO6+PEmo2nhCtPMh3aSZTkR0KVAU6WAq7TnokG
X-Google-Smtp-Source: AGHT+IFXOaX9hS5UhHFYRl4fooKM4y65Auo0ymzOHSlZKHqD2ha3wa7P75W8fiw17AHpd706oxrNkg==
X-Received: by 2002:a05:600c:1d19:b0:40f:afc8:ac6b with SMTP id l25-20020a05600c1d1900b0040fafc8ac6bmr3594910wms.6.1706873838627;
        Fri, 02 Feb 2024 03:37:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXraUY2iH95X+Vbx4mlcLHS3HBR73qkXHXcrmPUUv9r5Sl1Rt0Ag67TTUXpNfijmGEbMop8WixqO4a1qBq7vcoeG/q0gYnSmpx2pyyIR8p8OuFeV7dfGJXBZVix8QVQteZ7eskKqYVpH2fgKYAgOsft8h1usAYj3xEeRVi5nM3sB8gnvy/FeqK7KaIzKmcKfVskNd3SPjlgCMxu7CIBqJ45BoRwbdvPzJ7K2Zob63XVagsinlv+4AgE34YH/xTw1cp5dXhDJMEXQ/mvdOhcbFtZPZxTcRrSUaUwvEXsyZPiA1+aaoUNNKnDTKBMgxfzgQ==
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id u13-20020a05600c00cd00b0040f02114906sm7069152wmm.16.2024.02.02.03.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 03:37:18 -0800 (PST)
Message-ID: <2b3ec0f1-303d-4e0c-92de-5d0430470c33@gmail.com>
Date: Fri, 2 Feb 2024 12:38:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
 <9644d866cbc6449525144fb3c679e877c427afce.1706800192.git.alessandromarcolini99@gmail.com>
 <20240201172431.2f68dacb@kernel.org>
Content-Language: en-US
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <20240201172431.2f68dacb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 02:24, Jakub Kicinski wrote:
> I think you're trying to handle this at the wrong level. The main
> message can also contain multi-attr, so looping inside nests won't
> cut it.
>
> Early in the function check if attr.is_multi and isinstance(value,
> list), and if so do:
>
> 	attr_payload = b''
> 	for subvalue in value:
> 		attr_payload += self._add_attr(space, name, subvalue,
> 					       search_attrs) 
> 	return attr_payload
>
> IOW all you need to do is recursively call _add_attr() with the
> subvalues stripped. You don't have to descend into a nest.

I (wrongly) supposed that multi-attr attributes were always inside a nest (that's because I've only experimented with the tc spec). That's also because I (mistakenly, again) thought that the syntax for specifying a multi-attr would be:
"parent-attr":[{multi-attr:{values}}, {multi-attr: {values}}, ... ]
Instead of:
"optional-parent-attr": {"multi-attr": [{values in multi-attr}, ...]}

By reading the docs [1]:
"multi-attr (arrays)
Boolean property signifying that the attribute may be present multiple times. Allowing an attribute to repeat is the recommended way of implementing arrays (no extra nesting)."

I understood that the syntax should be the former (I was thinking of an array containing all the multi-attr attributes, and not only their values), albeit really verbose and not that readable.

I've now made the changes as you suggested and tested it, it works as expected!
I'll post a v3 soon, thanks for your review :)

[1] https://docs.kernel.org/userspace-api/netlink/specs.html#multi-attr-arrays


