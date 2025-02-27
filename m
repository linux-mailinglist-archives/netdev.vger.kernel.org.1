Return-Path: <netdev+bounces-170409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EEDA48949
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 20:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD9F16D80E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519CA26F462;
	Thu, 27 Feb 2025 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlzmiiCk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425C1E3DD7
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740686062; cv=none; b=uSuipAzYkgOVuMHcNKOdtviE164YQ2joV4CLfJmYtqlIztpjyr/wnu7DJ/XPGCAXfd4Htz/KuMDJzFywXyX6Qd7ax7U8QhsiG5HtE4iHOHWJNvqCrcCKvL1VDKjL7bYqUaqyAEQ5jzJVL1sIZ60kcu8uvOI6Gr+GiCkhncBEhIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740686062; c=relaxed/simple;
	bh=fpmz9TxgYoPHauye3q5xpCZiqO15uzV0X85juHs9ukQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TLnF8xoycThB+wLicVBSzhU1cASpiKi/ho4KNAunar8S6/GLnGyASOA1dDAzJxB06zlvuykS2WgM8ctwL1d0CCi+S0dMwJ3O/YLXaYZaxXzwy/UqhFvkBW+B9EW1n8csACsOR7yb8lMuPnhHTQKUzQ2pasq0TrH1coZZVxiAVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlzmiiCk; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so2182707a12.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 11:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740686059; x=1741290859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVx+M8ps2yONWKePyuV506c2UoijLLRqmgS3tRVD2ms=;
        b=MlzmiiCkciRWT7zKENEVlNphtMOHTUyEA1RH6gNnNW9V/hykpw/fBbTtUBAQyNihql
         ZUAZHXgSkm9kLnjNNpyQAd4QZ4Q+ZJCxVi7Z9KD2vyK1mDpMg9EuKRmUHtcSbW7MjgPc
         rgsPYcO+11IrBFZNDh4fJxYjiamiCdD+QwihcXycvmlPfx0DKkNpF4Ys8LyccdLJgofh
         P393lvifomyCUatnbsovSGKbKnWIYDhGXsTbKJp1xFRWDkRNgGt9y6nwOQBdxgZS+ToZ
         FXcPDyPdkFQpxGAy2OPv8n+vOVJymsO119nhjc29mvyW51Fn3ZX1zHqncjf1KHkkAytA
         FFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740686059; x=1741290859;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVx+M8ps2yONWKePyuV506c2UoijLLRqmgS3tRVD2ms=;
        b=sG2iwWz3HRJ9dv9GuJ4mJaQ4DWFZLGMbkttHMfYHovLdtTQ/YkkjGlCb8iEirI8WJD
         H/aDqs9cAMBj4VVevre97zxQYy3sUDIiTu7KnA5zR2SkjG5kGqGBDfx2iROOKvhnehox
         8fcLHMtxFA7OV0V35HQW79FosuecnudXOCjeQImXY+7BCQFzMdM7KTz1fz9XHa4egH7J
         HV9Gs3dJDNTl0BdVeDTLFPwjSVbswkLh31itwrgSYf8gQptOArt8LWXHkU53Z9YM4Wqp
         +N0X9+Fu0nE/EpNL2naTL6r5+xRkzZvPu6UH9FzsTHhktaV3XXrHN+14EBMw7ifvqZ7Y
         6shQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUSlFpLKDwHWVfu4JNPI0veEhMscqMKJ2/fI00hH5wJ3m9sfaxtJSl/JLUA4QQhjK5M1fR2a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwssWqY2T4gjU38XHqzZWeOZRgw9iCI9DaAyKcBJj3v5XX96fVz
	Gcsom6SL1fEHUvtK9VyWj3vOSqeu8rxF8xfDxFRLiEtSh9/QsXYt
X-Gm-Gg: ASbGnctWF/Zyv7FwvgDWbbug7uknZQwGG6l35g0W0hGk1oArdynk/O73/nAhiif/DQy
	vaykXnNunKUO+eAsPcHRObeYFqgd4dK/NBnMq6+I1XZbuQM7QCCBMA06jw7G/Ro6aCDEhVgBAeD
	jwFZf9PyPMo3MIMsHbqB16Cg+hsTEInC4azquJ6B2+X/BbJxfm1BtD2UqHNRa7Du7M8e+Y4FLM9
	ho8jxVNXiXyOrLrOxqqhJA+cJ309jwayj607GP9DDmZLA0ZHZluYSap0eDFAJO1LlRh0aLqtsrk
	240LBbFgm83kFGK/t4vVxNE+hMm37JOzDnh6iL6YrC71JRisTsW4vFQ0BiFgzM7HMzCEfrHs9uv
	Btjti2h1+sejwXA==
X-Google-Smtp-Source: AGHT+IHd7oIEvhsBMP3mppCA676zTmgH+2a3BIufkIgbZz61zYRrJmTL1f7XhRihdhWfC+/BU8dTvQ==
X-Received: by 2002:a17:906:6a22:b0:ab7:844e:1bc7 with SMTP id a640c23a62f3a-abf261fbb40mr68540766b.32.1740686058818;
        Thu, 27 Feb 2025 11:54:18 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c755c98sm172500466b.142.2025.02.27.11.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 11:54:18 -0800 (PST)
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
 <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
 <20250226182717.0bead94b@kernel.org> <20250226204503.77010912@kernel.org>
 <275696e3-b2dd-3000-1d7b-633fff4748f0@gmail.com>
 <20250227072933.5bbb4e2c@kernel.org>
 <c034259f-ec9a-2e78-1fc0-f16981cd4e54@gmail.com>
 <20250227085608.5a3e32d7@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <cd0b748b-fe7d-86ac-098b-0d6ec78a04a2@gmail.com>
Date: Thu, 27 Feb 2025 19:54:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250227085608.5a3e32d7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/02/2025 16:56, Jakub Kicinski wrote:
> On Thu, 27 Feb 2025 16:24:52 +0000 Edward Cree wrote:
>>> I never uttered the thought that lead me to opposing. 
>>> ctx 0 is a poor man's pass / accept. If someone needs a pass we should
>>> add an explicit "action pass".  
>>
>> To me 'pass' is just a shorthand for whatever specific behaviour
>>  happens to match the default.  I.e. if you can already express
>>  that behaviour directly, then 'pass' is a strictly nonorthogonal
>>  addition and therefore bad interface design.
> 
> I presume sfc matches only one rule. For devices which terminate on
> first hit and rules are ordered by ntuple ID, the following rules*:
> 
>  src-ip 192.168.0.2                 context 0
>  src-ip 192.0.0.0   m 0.255.255.255 action -1
> 
> implement allowing only 192.168.0.2 out of the 192.0.0.0/8 subnet. 

Ah, so the point is that "pass" wasn't expressible before RSS contexts
 came along, and may therefore be surprising and new.  I get you now.

> The device may not even support RSS contexts.

I think in that case the driver will reject the first filter because it
 doesn't recognise flow_type == FLOW_RSS | WHATEVER_FLOW.  Unless the
 driver writer has deliberately added support for RSS filters despite
 only having context 0, which seems like a signal they know it means
 'pass' and explicitly wanted that.

