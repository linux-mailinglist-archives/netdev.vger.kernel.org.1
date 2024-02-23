Return-Path: <netdev+bounces-74440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D586155A
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED631C2373B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F3A81AD3;
	Fri, 23 Feb 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="PZ4LQJRz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38574823C5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701416; cv=none; b=CXayQuy6150SpdOPqg0uFaOTKbCmBUIdn2ZvwAlDwEcP8YPVIZInp524c6PKzRcrgHais7UbQI/3irpfCSUQaIz2qQ7vPvzTKnoO3HQ4mudzDimPNwh+Bqpr7qLpilY1VVjNOzkv8po8EKzYQ/BvQY5kJoQl26a9S+8VpZ6Tl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701416; c=relaxed/simple;
	bh=V+eF6GOBmq4QtLwkfh53wsCcqUIk0FL763GG15CsJTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3jZDDIbqSVe4cvvgQMI7LwANnh7ZLfVTceoHAf/+EwtouZm4QzjIiSDxTGO9RIh+MTyymvh7oq7G7QFM0rg3alcOC0MXenKFOWCB0MDrZ+KXFEtbQK7/rB5TD+9qcf/an4a8A28FOXX4Pb3sVDxC/EHylO3/vNBWaJL8qenvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=PZ4LQJRz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41274cada64so3357505e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708701413; x=1709306213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XqhdxtASeJ8dx3m7DNevXocAbantg3tsvCX+1KNjwW0=;
        b=PZ4LQJRzd4t58SzzzR4PTWjCYgANXM2MC1EQQaykjBR88irgivjRmJZ2RTWWEZMlD5
         eBGhe1nMQpjmZdAkZ40g/UisOs9UFZvNTut9F3i0Ar7z44xNL2HmRxKPdOJ6SvXMpC5Y
         gpWoUcpljMmh1L5WXtCuZWq4j6amS67YII2vcIEUm4G0ddp5PTABKKVaoDIa5qikQWS/
         eAcjYBNCgXxuyCx2Kt8fC0cMmPkf7g6syyBkH9JvkNe3Nvls6nuUMD0U8YwZwiyD7dVj
         2cuaeXa5Z9RFZ8CNrr7wbdeOoNNfF57d1D0gz377A+VFXgaYLE8XPSEh8+dEh8tOu44p
         7TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701413; x=1709306213;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqhdxtASeJ8dx3m7DNevXocAbantg3tsvCX+1KNjwW0=;
        b=uHYSWYly5PV0XDk/baFXVA5hcW6DIDNRyHK6ip2IDH7qHTFS5ax9tOz+ZmkTjOhufp
         TDWLeJ3ylKkYyxt78+SK0lzNLxWu7bymIklM4tT3bvjd9ptKK19qvH44Yf/mXIAfYEAf
         /yUZsivOvCreKiaQvDCKA7LIdptcb2Wrp5MAusKXoDzKG6Qr5vl7fVaCift0RKz3Mq9K
         BWnycjtGBQ9BNPuu7T9Fbd04mCp2QFMFiPBi7FtapJqclfujpsPQ3LNN4j5G/IqJCzEW
         A3hA5ovQ5d+Cnqck4GimZiBvtZGH0XHVbnTXSoh7tb6GMsyFNQODoe6mnfUwKBaC6rni
         MZXQ==
X-Gm-Message-State: AOJu0YzYLVLXa3+JIwZi/kd7dsAByz/MY05mGR7R2Y0yGePO3LjRsGYc
	vLQ2O0TVRWROlFxslviZS7NDws/UjgD2P3IZuqfpyjBtZ6I3gjjtRieJlsHDoaU=
X-Google-Smtp-Source: AGHT+IFoFRNAeU9WAqAR3cj9V65NwpGHgsoexPBtK0VBEmdMpM8a2WMjzOndswhPgHetm1BzB1hYMA==
X-Received: by 2002:a5d:584a:0:b0:33d:7d85:9cf0 with SMTP id i10-20020a5d584a000000b0033d7d859cf0mr47260wrf.60.1708701413657;
        Fri, 23 Feb 2024 07:16:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033d97bd5ddasm3261585wrb.85.2024.02.23.07.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:16:53 -0800 (PST)
Message-ID: <70a69107-565c-431e-93cc-bd9ce1f010f8@6wind.com>
Date: Fri, 23 Feb 2024 16:16:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 03/15] tools: ynl: create local for_each helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-4-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240222235614.180876-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 00:56, Jakub Kicinski a écrit :
> Create ynl_attr_for_each*() iteration helpers.
> Use them instead of the mnl ones.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

