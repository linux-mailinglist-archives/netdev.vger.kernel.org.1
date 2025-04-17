Return-Path: <netdev+bounces-183553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3DDA91011
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 02:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4837C3AD2CC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E527713;
	Thu, 17 Apr 2025 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="tE2pPCbz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB703208
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849096; cv=none; b=sOZUsrhQAydeRnfZb25gdkMfWzpjoFULNlrlSGP9SYTP4HY9Tw/SM4MkPlvE0DD+LsqQSXJ+vrva8vXtv2QrUN9SuK8a85N5xFJU+998pGTTvwAfwhFr4uFSd4hFCYSJE/KL/idWHD9OX4sEnVWXcRnNc43nVd7xm72+kgT6O3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849096; c=relaxed/simple;
	bh=wtUv4jgVDn7k6uYYUw111Dd/ofUvkUj1rxerPLwXq8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=S7qOFgdTSssoKGgkFidcTF7z2zEGyBLRRutK1tCfCBkxuZVpiFFHYuoMKg+YAM2UcUkNjEiG/rV+xpkGDcFkEgRE0CCY2H34Fc7iqMmQOz7BovSyXMlTol304r4ZlHgestO+GGZJRepWDC3ZRJiPeQV8+nnpB6MrZvETSE6PRok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=tE2pPCbz; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-306b602d2ffso163098a91.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744849093; x=1745453893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFnbYVRfijJM7EhIXjmCfa4K/EhOgZaxyBwgi+V0Y/8=;
        b=tE2pPCbzs4SCkRR0V851rIBGSybWSsi7H5BHVYg4hIuWdmnhHLugJ71JBq9uK2Mn4H
         HO2Q1BU15Qfs3IDHH/VOLX9EocsxRsUFO75NW69ZId8nvICkmoNSGX/qw+EbvTpE3uld
         JCrPaa9i8dM6CcjmFEJj8CGuAVUl6gOLLUDcp6Zd2Fc3UB/IKgIEuzj5U+Y6LoVp7TdK
         i1O+Q4aDx90y90UOTl+F2KNVUcV/B7puKh+cYeAfRmxwbvZnYquY4PyMbQW9kX5B9iJe
         R7i6O7iTP5qFffXTets2jKnSaIVxNwnTTTUs1RNtBdqdCA5zSn2QPMC4N/C/eOQNkXnV
         gGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849093; x=1745453893;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFnbYVRfijJM7EhIXjmCfa4K/EhOgZaxyBwgi+V0Y/8=;
        b=Y8vaFuZMKC7yjcaKcbX4llgLQp8tZvyKPvQE4ix9iADU3RLhoBL3CjYyvS9KBr4DT2
         vpTTVsrGBEZrPktaHW2FukcFTstjcpAgKszPSPvhjncfq4o4WLKdX/lSDX3ZgEiZztgP
         ppEXm07TseHVhJujQyiMPD485mHwat3El5lhZswdspcmAtkXBrzgrUS8ap6mzV7hFRru
         cKyDqo9Bczu3cgxzlva1msmUYZ0EwB93j+6oBktMbyFaDmKVpeDcVLdCVRtZ2PJIUaN3
         Qg05KVYvGjJRWBgYmV0D7ra7JtTCm3Ik128S+SOD5LrfNFe5QuQklakFKaOVR/EHBPTs
         qZCg==
X-Forwarded-Encrypted: i=1; AJvYcCWdOZIjYolRXHhw8Cja1qVVMI0lq8LGCiIw4OOPFQwNRowD5fbcHWQoxXPV1c9+pRPxFc2qleo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsDM5KVjCJIdy3ebKlVb73NoE4+zo+wc09Dh4RObwKMAaRKOT
	anCPBm9NyyBDSSSPhkMU2imMFj8a18XeymTr5kTvlWaom0ZTpbg+9WTKgq2kTw==
X-Gm-Gg: ASbGncsDZO7QickVQ65929lL2v5CE2oZ5Be25vDmyfzISAjV5hsDcb6SBQ3UPZtSOCI
	X46f1wr/QTagGNySpN8eXDTY8owPlzgXfRX38Sl/GY9/8i7AIVSW3Jjb5ZJ7wmlcWpCbhektm2T
	VX9XooS2T0k4qAp0EqLhxZu9elOoKPsJQHv93AVrT9CTk3nFVqLCaLP0Zshba7dTnP92iRpyU4p
	zs5P+1KHjxuUOALgDER1GLjJzj3C/9dOdThY3dPHi/Bz5bGBsN0nsy5x/gy5pC3KzELe82gYDgU
	GH86banz+r+GzUqK5gTXpUn7EUBsU+C74uBBuK+hPFyYylutmRm9UGlU7iDRv2pNK5y+cekkxvh
	Qi+sTb5AtXyg=
X-Google-Smtp-Source: AGHT+IHnH6Y1E7p4ssRi7QK0tiCZmG+W/EN1joUT0J1of7/edoyGfP1Or//0E9f6JD//os7gN90AwQ==
X-Received: by 2002:a17:90b:3a8d:b0:2fe:ba82:ca5 with SMTP id 98e67ed59e1d1-30863f1a484mr6127122a91.11.1744849092746;
        Wed, 16 Apr 2025 17:18:12 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861229ecbsm2258408a91.34.2025.04.16.17.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 17:18:12 -0700 (PDT)
Message-ID: <5f534856-657d-40a0-b61e-d0ab77f5a13f@mojatatu.com>
Date: Wed, 16 Apr 2025 21:18:04 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 net-next 2/5] selftests/tc-testing: Add selftests for
 qdisc DualPI2
To: chia-yu.chang@nokia-bell-labs.com, xandfury@gmail.com,
 netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250415124317.11561-3-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 09:43, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Update configuration of tc-tests and preload DualPI2 module for self-tests,
> and add folloiwng self-test cases for DualPI2:
> 
>    Test a4c7: Create DualPI2 with default setting
>    Test 2130: Create DualPI2 with typical_rtt and max_rtt
>    Test 90c1: Create DualPI2 with max_rtt
>    Test 7b3c: Create DualPI2 with any_ect option
>    Test 49a3: Create DualPI2 with overflow option
>    Test d0a1: Create DualPI2 with drop_enqueue option
>    Test f051: Create DualPI2 with no_split_gso option
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

