Return-Path: <netdev+bounces-241960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6A8C8B058
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 847A0355D37
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 16:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBEC328620;
	Wed, 26 Nov 2025 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpUUzUIY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D977331A6C
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175447; cv=none; b=mvvh7Dz/D9DEf5BCGG3dr2t/kiuY4uH3y9vVLcDwzp+d43e6ceNcCx8Wo2O7A+z82gcOZssjnXuEr60o6XKyMfP3YHD/4QDISAuHCQy3GDk4kOsLHJEmDo4gBp5AC2D3x9nPhIlRlRAzi9ZzIu3g81V82o68N5Ivf+zt4tGcOdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175447; c=relaxed/simple;
	bh=O8GYmXQ2pMlGHY8XRnruC03YAhoDps0uLSAKDzrjuZE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=tBHZLb8xRq/MQUQIVfl13aFoX3FeqDbUW8aN/NC2ty8yDEIibMmMwPSD+NMnXZjv+G/0l+L69Pa4rozB7p8Q8pLsMwNwv2G4QqQfJBRDmZJoJZ4ok4xbrTofjyJb5EleFaZi8ZE9C8f0XCCPNGnK+hkbDJnroDG4JTFIvkmnfSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpUUzUIY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ba55660769so6062654b3a.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764175445; x=1764780245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O8GYmXQ2pMlGHY8XRnruC03YAhoDps0uLSAKDzrjuZE=;
        b=hpUUzUIYGvHlm8IFOXuvS1lCw3XzFaBMrR2u3LNTmHCAZ+bd4sXElL4K27Pg4/W/8m
         ClXVC/ritJVDFVAaDnM01WZ8ZOWrzgG/iQUS7t0nHKQOZYWxY0wZlTQLQI/8AKFm68DY
         siFtqAfsSu3UWO2qzvmOeWh8k750C0TH+s+AUZ8F2FfFm6oRUW33o1xk5cGKSn8ZAYdP
         VGZtd9f5bFli6UCikvaZhVgwuW3ubhQqv99yG4sORlr4oefr8uzisSAprvI426wVjn75
         wMcg/lwEF8n2TbZt70SgRTsVtdDIr9gohE+ZXw4SsT9HkuKCTTKLo9DAhBhKMxRdDWU+
         5QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764175445; x=1764780245;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O8GYmXQ2pMlGHY8XRnruC03YAhoDps0uLSAKDzrjuZE=;
        b=iATbLEY0RtA+JWi68ZCpq0CaoovCrhcVUHf2C9gDTLwRWaAYDB2jJasVaMgDaumPLn
         EbAdFNtdYJlaA3h+ozO0bOmdm/C/9t8fcfb+bLyQT+Eqd6YPIoxoaGPFYS0sNjkJqEF3
         ZxyC9pHaE37HabouLtW4cwkivVDEPP99oCu1tKRPD8VFowDHywqhVpkVnN0XWMgCqnke
         1fx7nuz5qZQqG3VYa3Am5iOISqNxaF9zNO5zOYP0ie1SnjKuDYGYFv6MS4jlLG7i9Fcs
         YypRqx0Hj7nWNsqcWNfxMAtqY/KdzrGNyrIUTpn+1dEWhsWf9WR+wnihYkIQiH134w17
         vNiA==
X-Gm-Message-State: AOJu0Yx87FGa4CTOB31iRYJJZnL+iQd0x4OpOBaYXmn1t8Fj1v3QiGmZ
	FuieBtIkhpyi3bfheY9WuK7NlAend7u604idPlajfWu6aEeXK3vsMJUl
X-Gm-Gg: ASbGncugf4dzZhxKqS/RnyihHAco8RgPe1aqKYJy6k4BKpGi+H9fVK9ocXbds6R+QKA
	+dkK9j0jUdM4gwFT6+oxyZhvihqHQD6H/RJ9Rg2S+YhDjbHAEHxpxURGmqjQImw/vUYajUopvxH
	cKyaRLz8GvkJkMmLJcML0owuuwOiPwRrkSVk2bLBewPC9+ks//b42ZevvIqIAcltYm7ddgRTycL
	DA9u5r/CIxukCwqHsC+HTe5oL+RYqk+YVpdNbmRxHdgLpKAfwjQC7yIPUdnWGBKmWQWm82JCKBr
	TDFrB7AbyKpvnthr8KcMYNcRX6dkdfNPPYvZQlHvqf9gnRWVrWiSGIbetj3AdxiRWTjd21zJvbb
	RxHHfzawXVAUnc4CzinIf9gkFQzg5nRx2h7iPI9ZgMNqYUZ93IkXRHIqqPkqput2xA2CI5ierfR
	tl0ALF6WlzPR7xb2E3r76ybHzT9b5/4clMXQbxK2xxXVWzCBPdPg==
X-Google-Smtp-Source: AGHT+IFqyC0YAm+3UTdOiSmkLaC/3DzXYr7V5WETgZEnjW1RFe3ymI3RPnC9W5gCj4bP8BqTujmFQA==
X-Received: by 2002:a05:6a20:7fa6:b0:35d:be42:92de with SMTP id adf61e73a8af0-36150e60244mr21725301637.21.1764175444660;
        Wed, 26 Nov 2025 08:44:04 -0800 (PST)
Received: from ehlo.thunderbird.net ([2401:4900:1f33:7df3:e8c8:e94f:8d37:8e16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd760ac62ecsm20162173a12.26.2025.11.26.08.44.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 08:44:04 -0800 (PST)
Date: Wed, 26 Nov 2025 22:14:01 +0530
From: shihao <i.shihao.999@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc,
 ncardwell@google.com, kuniyu@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ipv4: fix spelling typos in comments
User-Agent: Thunderbird for Android
In-Reply-To: <20251124193121.6f9eab3d@kernel.org>
References: <20251121104425.44527-1-i.shihao.999@gmail.com> <20251124193121.6f9eab3d@kernel.org>
Message-ID: <5C021872-7092-4965-BAC8-FC76752F8045@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey everyone=20

I accidentally added some texts at the end of the previous reply subject =
=2E Please ignore lines from "coments" =2E Thanks for your time=2E

