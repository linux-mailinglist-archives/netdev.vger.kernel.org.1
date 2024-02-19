Return-Path: <netdev+bounces-72999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D981985A9BA
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969572864FF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524F446B6;
	Mon, 19 Feb 2024 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="dfdSzZzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D555446A1
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363103; cv=none; b=GDzMzXtkriZhlts0MwkmbKkwTdBCioMP1/80QkakqyH9+maiDQcbq7U+K/yQ/LHF2ayEMb8zlrXcatngq8Sl1BQJbNIy/ohmAdfB9QMZhycVROKVy/hgUX96uwAKUPdcFqrEQahoN3C7bhe3fYvZWzAVQ2oUiutYx7ugHGIg80Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363103; c=relaxed/simple;
	bh=rX0Ly4Bj2RUWP+6yTiLSUuW2APbLjgOlitB551W+SQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L+D2QGjVs7/Ii+33NT0VVewLqyf1uGhbvjod+yV0mg0EBZqzisGngQ5sk9w9hZR4R+VrONjCsRjNnY4st9Q01W2zt0k6RRRu/LiV133RCGuEEw5PyfpXDqWZRybJZzwsPoZn0grGt9JMdeydPnl4RA6d0Z0W+EhS+9onVeYypx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=dfdSzZzz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33cd57b7eabso2473784f8f.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708363100; x=1708967900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XWsPgCjTfloUriBd5XlsmdmtMlI+nCeA7RMTomFu2Gk=;
        b=dfdSzZzzeDCm1bzraYCxg/1oDbg3i+MZSo30p8HD9d2kse+FTTuJldNAL695sQIMk8
         NwKk/W5l3BGDFx54bkZ/EWDeFrusWUHj3pFCZqbUhcu8n9z8tCzw7U4QDPOLB0hzEi4Y
         4a9s/T2zbz/Ez+u7QtahA97+T4sCsMAL5iYoJSSuAz5o4CaWAu4iNhMxU37dFOubfaAI
         4pmBf2k8T7cKJI6IUwcwPFJMYm8evEzyWkZzKiocxDdkL0+Xb57c4q/PfTnOa5plrCKz
         FZCdbQZwFhVZGq5wubCeKeYi+XkDJu12RIrad1LG9CSkRP4KJDqWmcfLC35pIzF5XGBg
         6hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363100; x=1708967900;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWsPgCjTfloUriBd5XlsmdmtMlI+nCeA7RMTomFu2Gk=;
        b=ujl7YFqLvtUifDlHgjUycvTwzsha7IJvA7dQ/a6H5dHr0U9DsEFBZfsIDnUQNOKLV+
         z1UcJg23bcSeYyi5QbhCDSq3Nv0IV77A3XWVw1frh1bt/BJPQmeyfBUcSL8nVJKNzn79
         wJ9O0eSBHVYaoZ5WXKl2hwKLLFzZSfXY8x/U4wttvzvlMYwhkHBkwvVuAQ8ed4IO0Ul/
         Uswoc0JeEEI7/kABvH8NVNrYFdAoGqkk9tGJ0KO/wvFCHDi1KS8DC10J4nlUsOIcRMoV
         y7XrjmnX+gAI+ftwioIlB83DhB2iNC7H9xp+TF1pAkAVHQsi3kXA7pHSf2F5FK7l6KlL
         C5YA==
X-Gm-Message-State: AOJu0Yy7HRxragPo6q+uqgLTchsJEtn7Y99SCt1m+inpbruyqA18aJwE
	lrWB1PoLUX9A2x+2NXLo8PbgBl4dTBlWxLi0NWDmE4pTF0mzs4MWwrMxgTkHtrU=
X-Google-Smtp-Source: AGHT+IHjeOBDl8NJE+lmBxlN0aPoY35Fm79gmq5Mi6jSHZS+ayU8BPnItJvhiUjvJd6dAbzsltfjNA==
X-Received: by 2002:a5d:5011:0:b0:33d:a76:e3e7 with SMTP id e17-20020a5d5011000000b0033d0a76e3e7mr8473435wrt.66.1708363099724;
        Mon, 19 Feb 2024 09:18:19 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:31d5:8fa3:ed75:9794? ([2a01:e0a:b41:c160:31d5:8fa3:ed75:9794])
        by smtp.gmail.com with ESMTPSA id bs20-20020a056000071400b0033d449f5f65sm5213087wrb.4.2024.02.19.09.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 09:18:19 -0800 (PST)
Message-ID: <bdf192b9-5489-4f3a-bf91-ec2a1dec3dcf@6wind.com>
Date: Mon, 19 Feb 2024 18:18:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 1/3] tools: ynl: fix header guards
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 chuck.lever@oracle.com, jiri@resnulli.us, willemb@google.com
References: <20240217001742.2466993-1-kuba@kernel.org>
 <20240217001742.2466993-2-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240217001742.2466993-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/02/2024 à 01:17, Jakub Kicinski a écrit :
> devlink and ethtool have a trailing _ in the header guard. I must have
> copy/pasted it into new guards, assuming it's a headers_install artifact.
> 
> Fixes: 8f109e91b852 ("tools: ynl: include dpll and mptcp_pm in C codegen")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

