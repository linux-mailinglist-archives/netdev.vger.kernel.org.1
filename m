Return-Path: <netdev+bounces-149663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 493F89E6B09
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308E216A5E0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F871EF0A5;
	Fri,  6 Dec 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2lIHgRTJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AC61EF0A9
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478585; cv=none; b=COqt8PgYcav96TTRsOZ8bvtiptRR1w9MVVY1WOKka1duCUt4mtdxl2GbkWmwcTyK7ZbtsvXyPcD+ucWQhADOWHOaXqIwVKrgrLUOnyv+Ri9UuuVQ0aTB3sS3RRT/06dSAtLBbGxlwjm/4lWCuo2lP+mVQOIh0T4sGo/b+PR4m48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478585; c=relaxed/simple;
	bh=PnDB/sYV9slXqwjdQ+adiYJ8G9BZKP3IlyhMW03My5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKQdUGUgM3vofCwwyzChK0Rqvl9Tp7qsQIxNLl6MraApKgBX5Rie4AbBPtZk9Noheg4J10lLagP/wHT4l8WD1fve8gZddV3mxhHyQm+in+jtArHUH0ebqyIEB2eWr9UhREhcCHeL5QuOp991WM8So0J7GzRmHkzQCxo+owZhyHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2lIHgRTJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so359954866b.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478582; x=1734083382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuGUFOb/iBY8RJKzowVsntGQmfZkIN8i8d+6WuovufA=;
        b=2lIHgRTJUVgPiu0QpHE+4HXOrfauynhMdie+Me5alzQIz1fcn1cN2iENiFkYbeFhWb
         m4gD/XVsHWz49+kem84b/hMyLqctvhisb6wwH9SHtiVHf60Yl8Au4roiDZiE8utlHPE/
         69zyEWuINXGF9nMEPzJHt7qtLXxFCi9+9ZniHfepNrVTaVcqszJKF1RrdnMchsX6/bjD
         oSAssq1/4/Y3g5ZTI/PWld9ZaYUktjQsZ+vQ7p99nRL6Le12SnZdHQ2pqxZMYIROvWnf
         L/JwqEcwMGXx9HtX5k4VQISG9AbgD0QTWSDnkmjayc4XMmQbRmxH+F03mMpkc0QYtvO5
         LyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478582; x=1734083382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuGUFOb/iBY8RJKzowVsntGQmfZkIN8i8d+6WuovufA=;
        b=In9NWFJE4bIpBbrEY640LdFpy2zh5/RDjEX1wQzS9D5XF1fM7cbvtQUoBoY9NROzIZ
         CTooxDrBok0wKGTfBGUMc+Ya1Zhgh5X4tGZuLzVieFY7Ar6a9MCiggbVi1EfUPFhiVtX
         zO/BmrIzN+rfIvxDdpCeNqrhd+TjxM3wPi2aS9WPgDSKcE8Sw8MPtao/gidebfm8On0J
         llPKrOgCPpGgHwbVbI33psc9sTm0VdGiKP9ux75zDOFylO03wk4gSJy92h0k0O7GquVe
         tHBT3ckJhRs2kIEw3QA4h2++7bdqLjPGURU2o+Wpvggkh32uDO4RRBe5HEObvYzFnC+q
         UV9w==
X-Forwarded-Encrypted: i=1; AJvYcCUAhvSOUYw2FsIDDTmHkmGQLnhBIjgEVrh1eByrHviCtt7BFFxSygwVFfnkvgM4BAX16n7sUgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCsSXyQf+MmCO+b8rBTpzxV9Jai80xwOlTdZkykKAVRQrX050
	prm0Iu3VxVPmBKhWnP9BoruRICGRPyggMLS6c5HwWNHoEgPdlq3RCtU6VpXeX2s=
X-Gm-Gg: ASbGncu4DItkCFo9f2hcIWJWyHJ3th954BDmNiNFfCot+mlkH0otWmm1PcXHQobBhHg
	y50bN0HF0pEyIx/Iv/NPzxPft3e4j8bZ1VLTQo/N9aJqNf+1M9PJU8OnJJFXXuuD19oh6LqFYJ2
	NAgIuvj3bsE5xyLYQFw3g1fNqXlGA6fVGK51za6CVDQTMYeawv4JN/xjiDiyA40WHiQEoJC6io3
	sDyCBDph4Bwpf15vKc7ONbJZXH2hCbkbVFLKQ3LL5n6M7EscizW
X-Google-Smtp-Source: AGHT+IGlZGYFgwmwFeNFQJwgjuah6WRFJxdm3tfG1ry4p/ogHPRA4+guYXrGWdGdYUv9BzFp83k3/A==
X-Received: by 2002:a17:907:9145:b0:aa5:630d:7de0 with SMTP id a640c23a62f3a-aa63a26a7c0mr170543066b.44.1733478581999;
        Fri, 06 Dec 2024 01:49:41 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e4dc8asm213942166b.35.2024.12.06.01.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:49:41 -0800 (PST)
Message-ID: <e7cb6b0b-afce-459e-a781-f78ed0af241a@blackwall.org>
Date: Fri, 6 Dec 2024 11:49:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/11] selftests: forwarding: Add a selftest
 for the new reserved_bits UAPI
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, linux-kselftest@vger.kernel.org
References: <cover.1733412063.git.petrm@nvidia.com>
 <388bef3c30ebc887d4e64cd86a362e2df2f2d2e1.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <388bef3c30ebc887d4e64cd86a362e2df2f2d2e1.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:41, Petr Machata wrote:
> Run VXLAN packets through a gateway. Flip individual bits of the packet
> and/or reserved bits of the gateway, and check that the gateway treats the
> packets as expected.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
>     v2:
>     - Add the new test to Makefile
>     
> CC: Shuah Khan <shuah@kernel.org>
> CC: Benjamin Poirier <bpoirier@nvidia.com>
> CC: Hangbin Liu <liuhangbin@gmail.com>
> CC: Vladimir Oltean <vladimir.oltean@nxp.com>
> CC: linux-kselftest@vger.kernel.org
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


