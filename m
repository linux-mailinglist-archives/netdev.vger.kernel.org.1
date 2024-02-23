Return-Path: <netdev+bounces-74469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26817861706
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 17:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC0BB27A49
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B6784A4B;
	Fri, 23 Feb 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="RFMmpTpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462383CD3
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704364; cv=none; b=r4tTeF19J4QebVuHp42vDRYTyItR8VI5RITSUzXDrgh0Yyi6X4b6aoarPJzrcrOUU032Ac/GrNVPKx7KDwdttopTgasrFhKANXDJ/NTUjYKvDoNAbZuBS+1YDuYKbf/SVVLQzHL9esjsXHuAeBQ1G44EZBb+JfU7fcoDi5Ow/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704364; c=relaxed/simple;
	bh=v0M5Pdj1TrtRLMNG+hRP4zjl3HInrGc2vaoBXEnUvC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EB41sqteauDTaeRIX85LVk3VhShUjZDDBYFMHHC3fi452BG7oMmVOGHVDaurpnHdGidhY72Swbk8YmTWOskrynpr0r1JL2k6Q766X3JT27CcUMSPpSczx94O2PgLXQLNLRWxdrpYwqcY53KNwOecRLY1fnpf5Rv+Kwkv9tz/ixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=RFMmpTpu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d220e39907so15853951fa.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 08:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708704361; x=1709309161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iZRgzwblB5XOi7Po4wH82K1DlEfJwQeZSXl8R3Hu1R0=;
        b=RFMmpTpuTQiKSU6V0l9SjZLC19Hobf9xIxqN8DLz+bG4u0Pl48jX6S3ebfeh+/trTE
         +HycnzFi5ltMYYd3ZpqNZlL7CAWAyttqB3QlRQahBgh1B2JhB3dOmDCPv0aUYYbOVgv0
         JjynlP2vGp8ZbfjVidFVcUfwICtKyYgBtdnkeid0nc1+O/BnuvRftbvrgzfMVY3mONPI
         W/Qd6A0WLDZnCujpzlztUGY1gP1mxomSmKekJ4Sn4+UCSR0bfEM7cKrcQUz5SC+cdUrH
         5lY8+cdRUksl4ifytX2hlFEjOW/jDBuTCNaIozEWavdBMLGw5MiYofsbGRMM2xSzxzJb
         ctYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708704361; x=1709309161;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZRgzwblB5XOi7Po4wH82K1DlEfJwQeZSXl8R3Hu1R0=;
        b=pyUdmXKAujczEn+x+wPJcpWFzIwY8Cl8p5frbQ/3IKh0EJ+AacM4uOoMnhPkKROkea
         VH6c9D/OWLDxfiYHbUEWFsPpwhSL78OpNVVKO318ZmzOCI15W7F9nOQOWylygr6SOjVt
         0mp6RNDyi4KsfjOf0fdd40UbaaHOPy9bmkSz4nsR+XwPQc0h1toMoE1bXdMREABUxECV
         uPm5xiF9AD6WZkmz5427x9asaMDyABGLGyMYMd+IGnaATjCi2y1ldrpwqLSiePoCC3Tx
         FbBvmlMC2bI5pW4YFuKJ2BgXZolC/jg2dFvPjAXiLQ+2aGddFdMtiNC7ocMZIh0+ifj8
         Knvg==
X-Gm-Message-State: AOJu0YwEp+HdaIrIy3eavERRhK0fZ+71SbmFeWEt2MY4kM9RUptyxaN/
	hfK7kOlTPP1NQHmQHhFKzWPMAvFdt6GS/M9eJWRcL+ENU58ehoJZH17dwt4pM+E=
X-Google-Smtp-Source: AGHT+IFPTArpl7Bf9WB/LqKQwlOjOY9O1B9ti2lVwY85as/sOHIKzC0JwF3bhsTqHqHm7UTpQ/L6lQ==
X-Received: by 2002:a2e:911a:0:b0:2d2:3f06:5343 with SMTP id m26-20020a2e911a000000b002d23f065343mr217739ljg.10.1708704361160;
        Fri, 23 Feb 2024 08:06:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600c351000b0041294d015fbsm2569868wmq.40.2024.02.23.08.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 08:06:00 -0800 (PST)
Message-ID: <a62e029c-a467-42ce-a44d-5d320bff364d@6wind.com>
Date: Fri, 23 Feb 2024 17:05:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 12/15] tools: ynl: switch away from MNL_CB_*
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-13-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-13-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> Create a local version of the MNL_CB_* parser control values.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

