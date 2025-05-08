Return-Path: <netdev+bounces-189098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8CCAB05CF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01511C0741A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1455224AF0;
	Thu,  8 May 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Fvs9jJjC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747F12222BA
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746742024; cv=none; b=bLJAckeenb/hO7AoYr0E9D/CaRMI+3ymW+5M9O7Yer4oeDMldxucqdqZjGDvXm6rMBkT1FHC/bxdgs+XYGNCmO2LW1bdiTzoGlrCtyGrt9oTfThjmzjsuXRrQRznhsyxboZh9tVK8I9fFsgitOdAzDHOVQy+BErsod9144zz+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746742024; c=relaxed/simple;
	bh=383tmOsOwIYI+sEuL4lBtsooiMu54rXi0r4rNmVC88Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1aXaWGRj4dDH/UhIcdGm+QVOYN7dMqO2QeBioRQBfbZcQDgQGPNV2tqXhsMOVy9JUNV7GgvXE1f6rGOoznGHQVQTGSZLaRLc7otTqMHveuqIbljV1/InL8TIdLIVjimRjlpasijnKzfBt0LqpCXfRJ38FqNQyg0exaMLTFV5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Fvs9jJjC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b074d908e56so983482a12.2
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746742023; x=1747346823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YygRvJatc+ZX+R8V8t/EbZhKaAFDzTF1VLryimoeTCY=;
        b=Fvs9jJjCZA4qvkKIwgp/yztqSEnSgTkFenWluSNhjWThIue+Fx0Wm8LjHVcCnJTNIq
         l8ckVV7njOMFoFJboaaUMW9kePx/pQVy05RuXebXf+bpTP2M87dKmHAZqPgPGe9WmPBm
         UTOAhhtnzuPMaphYuaPZvOQMr7726Cfh8IlsiyUgrSn5NcRnE1qxe/8bxC/ywng42qGg
         nio4h6jRGlDHtctDpZjwoKu/dEMG8QtnmwJVEcf071MELCu9eiexqPvcn5XYJtLePOMv
         1xoNR3RIb75M1BkeLTXLLDi20laF2E03c9g308INwolink5IO/4wiOKjG7eNw38ayo+a
         uYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746742023; x=1747346823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YygRvJatc+ZX+R8V8t/EbZhKaAFDzTF1VLryimoeTCY=;
        b=kMHXQPXaIei7P8d7DHHPY0FRzdBsuCSNqL/QSMu0YpeHmyzJ5SoiV/B0C/SeEidK5M
         LVuoasOMDtbHmkwxatVoWGHXQqTZkzoKVtx8b10wMI4P5zyS0X910zn+R4tPQMXcTc4R
         Ij+3wWhtoxBRrczcoEnOS2UOBsZBZd91s54GNcCn6mQgfYX9qVLFLJLkHRUpX9935Ub4
         PitkpCkmpKBnyU9UCFNMx5FebW+WrtjxJ+5FDrHDm1Q39YqRSOyU6quqDzezSPgAbJmt
         MUnGgNb25qkLqM0+ZDOkEXf8qOHO+eTf0OdmClkWlakOZUPWxhBRMNshwxwb2rfFjy+C
         rxEA==
X-Gm-Message-State: AOJu0Yzqf3ejSI8qiENKwpnLmFJdm/Zq75WVTQ51tMvdkl2T9DL+JkLr
	246m4FLnxsz78MOGUxCSgIMVHZproD/zsuKLTKKY/6DD3Zat9LMKYR59kOVKUdg=
X-Gm-Gg: ASbGncuqfrSWGQf59fXZhkNnAbfXHAarz1VuqL2tg7l6T6iZlBulNGVJLrQ7YD2Y/R7
	yDR+Vf1M2GnPgTy7HBzNGTD9eaROlblUAEI4DHySDqHsxjawrIXKvqbhT8zfejGCVgmyicXS70G
	Q73+FVN1+gc+kOT+B8TpzWQQu6QjGSTdoqEw0zIv5KHRQlYdO61UbvUJu+azpFq89yByZOhAliT
	1g7CgJ51Owe7Y4+nPgmuHcyGTvtr/cATj9rgnLIwRjwyJS7RoUyoHt/uTj7TIvmCQfXVAMnj1I6
	ra8vIYafPzkK7rcekWs8kz0n5fwXp82IWDb8X1DIVs5W0Utt178ysW8Gqf2wANeFeMqqpnvvkX4
	qoQc=
X-Google-Smtp-Source: AGHT+IFDbySgvmGLH2XmHKIsynb+ZCgAYVd6wTaGIi1rv2a6LbtUmPB+B0JLB6XZqjrHPFrWey94Vw==
X-Received: by 2002:a17:903:32ca:b0:223:f408:c3f8 with SMTP id d9443c01a7336-22fc8b41077mr14475565ad.14.1746742022673;
        Thu, 08 May 2025 15:07:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1079:4a23:3f58:8abc? ([2620:10d:c090:500::5:2fc5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7540056sm4813755ad.23.2025.05.08.15.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 15:07:02 -0700 (PDT)
Message-ID: <6f40402c-dbef-4eed-807c-dd0ea5438732@davidwei.uk>
Date: Thu, 8 May 2025 15:07:00 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net-drv: remove the nic_performance
 and nic_link_layer tests
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 willemb@google.com, sdf@fomichev.me, mohan.prasad@microchip.com,
 petrm@nvidia.com, linux-kselftest@vger.kernel.org
References: <20250507140109.929801-1-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250507140109.929801-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/7/25 07:01, Jakub Kicinski wrote:
> Revert fbbf93556f0c ("selftests: nic_performance: Add selftest for performance of NIC driver")
> Revert c087dc54394b ("selftests: nic_link_layer: Add selftest case for speed and duplex states")
> Revert 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")
> 
> These tests don't clean up after themselves, don't use the disruptive
> annotations, don't get included in make install etc. etc. The tests
> were added before we have any "HW" runner, so the issues were missed.
> Our CI doesn't have any way of excluding broken tests, remove these
> for now to stop the random pollution of results due to broken env.
> We can always add them back once / if fixed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: David Wei <dw@davidwei.uk>


