Return-Path: <netdev+bounces-159073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B376CA144F0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 23:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE8F1160E7D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739E11D86F1;
	Thu, 16 Jan 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="oj83f+BO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0122BADC
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737068289; cv=none; b=K3rZ26fFDLTjmRuPtGj66J2Ejdo/yrIgyH5clNDfvyerKbB11CckL+Xs9nJNMSCPG86BrhPPBVNYzdHym1JeXqmaGqGap4vgELaAngmaVxMPYutBNouP3Tk3TIV0wTFp2JRHAAvO3aPdAbuZVGv7Kx9U4NkYsDPF36bt5xTX9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737068289; c=relaxed/simple;
	bh=wG8ybrhQPlH0qgHahqRIXyGbDXwdRiujLfSLDG4DwgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJPuOxTve2IDEOX0JXW2HXrPVNs4QAVBJMzgCx8sPS603t6Ts0fgpJlmgUIxKCz/TXiYFiEDaZDQQlSiccUzqVqc34jpM/RPlwIJmyobcYn+RprwXlwLacQZqsJLbH0g6gpoEFTLdgh1C3ICr8eaj76Khl0MQu//FaqYjrbE/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=oj83f+BO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21bc1512a63so29502265ad.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 14:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1737068286; x=1737673086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAdViO412rJBSMd5ZtC7F7X2xdparF+/AAUXhyFpiWo=;
        b=oj83f+BO6Jy8/LK1H1uQAaoDdbQ2wV8wl6B1dmO2qLMFWD9Uf03I9T0PC1/1CkwCXE
         JPTb/A0+xZyRmZDMbLqNGRVNzb9o1ixGK6XtTshZol+JBpiWt2pF8BTT1IA0pjrx1gpv
         b32BRdp0X+b+w73M5pyfh4gGHMN8lKz8exsjY8zxCEJh78D0OD78oCjxhkZF7zj3Jy5v
         SnSrctEtXS8hZDwkBOCRmMYVrJoAUWw7IO6r/bEcYuLUXbT/qfMSvJLoXeR3Rsz0790d
         nk90D9JwPEkcCsRi8fOhSIsFUwA1TD9NlAC3KfyV/YtGbdAf5XorG+muWQDThZDrBktI
         0HCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737068286; x=1737673086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAdViO412rJBSMd5ZtC7F7X2xdparF+/AAUXhyFpiWo=;
        b=HM+gDVVH9NaU0s/9z0YWrhBpsz7V2GPkUnftjsoNOmtPd+VMlXuKNYOJOBGkX8V169
         ZDr8bYNGoT1pJateLjm7V1CXDjsNZAXmwaCPCjHFyL7mVT1f67o4mf7G5mVJjwLpC14u
         qanGO/V4PsgGG+HeoOJ6XH8EcIisImG9uyEqNjWntUd5L/TDO8uj9Q4PNFTqFOf/ML17
         dZhqSHUEs1Y5MZ8pFr5l4icAoItUZxlBtQb5UDmEMfmtfHCAiNPPgaK0y4+lG91YocEK
         3NqZbXxeBQWk3v5FpA4zUcllsBRkkZbIqVXonPi8o0uSnaS0za4eLaGONjjzGgH1jy2x
         zUzA==
X-Forwarded-Encrypted: i=1; AJvYcCWnL9iNgIrlOqotppsVyCXrdzDJkm1V6IMFGK+DfLYby+nEc2fRk5CbOCAausObwoHd+J3S2X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhl4YjmKqDSFPYG9rJGdqZioBx3Md5C1qn8o5rG67LJTJ5GMAg
	d4V3CzwrwRqSgX+SE2OhVspPCYsHhydpNpu49nDWkxf52sZHZx1QsCCBkyfXF0M=
X-Gm-Gg: ASbGncs5/M6xo35k4tvwMUGwBp8jucNMI8ZcqpX44AnojViu/jDR4/3MvZv/cqGL/c2
	ja/h8OY7TSx/qkflm8pMF9mW6P2gY2nAGU51ZCz71mM5Fp6tPwfvYTnRm//jbtMfhL9NT/j33Yz
	XxuaMLxFOPDOVmzIIfox2DVOaFV9D7Y+pzrCXL+iQRdz1Q/R+X+wEk2e8J8dDy/mPsF7H5U+Cqz
	7spHawrn5mF6iA1n52CJI+g8ctNrnfrLXa5T4silhmcTkbn4KiMEFFe8EAHcXE/4Jo8cTCu2EmS
	NlOWg3tcGiKs+kUvdw==
X-Google-Smtp-Source: AGHT+IE13QruiHE5aVNpWWSj1YlneuGOMx0Sf8O089Rg0cxn/Gn+XUzaYoa9zTvZqQPknrNIUV3Hxw==
X-Received: by 2002:a17:902:e802:b0:21b:d105:26b8 with SMTP id d9443c01a7336-21c3553b20fmr7413555ad.7.1737068286225;
        Thu, 16 Jan 2025 14:58:06 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:cf1:8047:5c7b:abf4? ([2620:10d:c090:500::4:b8ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3d86c5sm4747925ad.161.2025.01.16.14.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 14:58:05 -0800 (PST)
Message-ID: <08b34f6c-9516-4bb3-9a41-a547305176a7@davidwei.uk>
Date: Thu, 16 Jan 2025 14:58:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 22/22] io_uring/zcrx: add selftest
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20250108220644.3528845-1-dw@davidwei.uk>
 <20250108220644.3528845-23-dw@davidwei.uk>
 <20250115165309.52e94486@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250115165309.52e94486@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-15 16:53, Jakub Kicinski wrote:
> On Wed,  8 Jan 2025 14:06:43 -0800 David Wei wrote:
>> +$(OUTPUT)/iou-zcrx: CFLAGS += -I/usr/include/
> 
> Hm, that's the default system path, do we need this?

Removed, can still build the test. Sorry idk why I added this to begin
with.

