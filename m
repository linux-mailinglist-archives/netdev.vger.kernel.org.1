Return-Path: <netdev+bounces-128693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228F97B01D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC8D1F23E01
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BF17279E;
	Tue, 17 Sep 2024 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="H9Z1x2gW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35FD174EF0
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576223; cv=none; b=Th+/VI0V16DFYRAki3JgsYLz51IyzNRHJEeQQxluNikMgxbXWK3piJSTmpWBotCu6tKfLkSXP2zKC13x3oUtVeRQoxPH8s2gW2aIE6HN4nWVQx3riya5GYzJ6LsgLhzFhdL2TTx5tU3aXHMGbKRImwXuIzq7JpdVT0uZo1z5+4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576223; c=relaxed/simple;
	bh=ekXDHWqc9ZBjksw8YsTcE8SoqDdkPtQNf7vtyrzn0xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQsQLnDhVlWrcQku8iIQuCNeg+gEeNqrQQSl18K/wUAeYNX70GnZWxiDiIkwCYHQW73awMzgx4lR7+lJWfgB++TU0IBCrHtZbYM5aCy7Qb1I/sAP7Dkizxigulm0WFcBWT5ERjrYe1hI8wt0pyudrkjVf2WYtAVa/0ULU8/TKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=H9Z1x2gW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-378f90ad334so151332f8f.1
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 05:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1726576217; x=1727181017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NquHlcMfosB254fXF4qpGP6ZoTO/X81RcyRhZ80/NvQ=;
        b=H9Z1x2gWqanh+pwZGSW2DGJMxk9a6iLVPEc+WG5hidHNnC6zY1pwfg3TiITFv+t35s
         JuuJpe86MrhVT3pqOF8mZ1XEJIL9BWAH3D1vRsftntyZzExA9NPEDoTRq6mqV2XOL6Uq
         y330SuI1BjTEu/CjbnmPtapno3AxAMIvsdAsErOp2fU98NllZRzv1NAlNdY5qyHVyzbe
         ZqUfX9GD3I8Paw+PlsR0Tb1XRah3LOOqInqSj85u9IeRdF2neTMLaD+Zd+2Hn5IyywnD
         nCtyBtE0xpoiFBfxFBrsAJ6BYH4hRlXLiW5gCTqMgO4YeGAzGP4tV7FvZLP09tx6SDJH
         tLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726576217; x=1727181017;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NquHlcMfosB254fXF4qpGP6ZoTO/X81RcyRhZ80/NvQ=;
        b=UGRaghhiQEguQ2Y/P3k14gWBIIu3cSap4QukBUAV6J0xc1TSumk6e8grxVBtkLr9uE
         Omtp+PgeAxuR80FNvXXZeFdGc0RYu7itm4JYksknt2DF3oLvTWDxcIuoh+RYUuGh4ih4
         D/Y59YFFW7V1dhh/zN9i1duudS79El+7Mg2h5cg0u2yl2ZNDl9Y1ohxvGYpTFC9x+Wt9
         aTyTI1t/IoZ053pTPtpI49OUGQe5yfpKylVs2RshxwR10tvorPiY7mBgRBDxr57W+6Sn
         +8sQssv4sNHePY5G2VEsEY9SNX9o6mcm88nD1yyHaVYHys4XGN1sw24vPSInEo0kaH3m
         AZgg==
X-Forwarded-Encrypted: i=1; AJvYcCUsUiMsaNLKUtfBnPTSwVIrcX4yFC0FhhNyT4cFp3cas55raqGKVJIUwf3QPuE9PQfIqsJ8lAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH/E3B8sJ7uIHVZ9AdCSf7xDRpPxDgIK3a2vBvFM1A8xMB4vz6
	78XRVs3KXkXl9rr1e3d+Zr+SQnG0f1tY3X3t32Sy0BpW7sABGnmXMUkO4xA944s=
X-Google-Smtp-Source: AGHT+IF+v9SGO9w/25A3eSv756vd04S2mX5FKUZ0P2vtzRkbgu5u/sAequEeJGYGGzzwy5oDrEfeEA==
X-Received: by 2002:a05:6000:1846:b0:374:c0ca:bc58 with SMTP id ffacd0b85a97d-378c2cd5384mr5502878f8f.3.1726576217379;
        Tue, 17 Sep 2024 05:30:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:fd1c:1247:3d37:68c? ([2a01:e0a:b41:c160:fd1c:1247:3d37:68c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e81cbsm9388609f8f.28.2024.09.17.05.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 05:30:16 -0700 (PDT)
Message-ID: <06d2c6fd-6aa2-479b-a7e2-a4d369ea0e66@6wind.com>
Date: Tue, 17 Sep 2024 14:30:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
To: Eric Dumazet <edumazet@google.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Simon Horman <horms@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
 <20240916140130.GB415778@kernel.org>
 <e74ac4d7-44df-43f0-8b5d-46ef6697604f@orange.com>
 <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <CANn89i+kDvzWarnA4JJr2Cna2rCXrCFJjpmd7CNeVEj5tmtWMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/09/2024 à 08:59, Eric Dumazet a écrit :
[snip]

> 
> I do not see any blocker for making things more scalable.
+1

> 
> It is only a matter of time and interest. I think that 99.99 % of
> linux hosts around the world
> have less than 10 netns.
I agree. My target was 4k netns at the time I pushed these ids.

> 
> RTNL removal is a little bit harder (and we hit RTNL contention even
> with less than 10 netns around)
+1

