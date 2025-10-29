Return-Path: <netdev+bounces-233859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D26C1957A
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A07B4E9851
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 09:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F463101AD;
	Wed, 29 Oct 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Qd33Os0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F5156230
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729014; cv=none; b=SwcqWX0F46AxTOBqrdv1CQZaJ23zbnzkf+aPunpCgamFJrxaGahuydcLB9xU6bddKSkVQE8FCwvpanOfITJCPStkvX21hmRlK38hzR1iwCql2tqDEcx/4RHC0QVLiMb2o6LDRfBea9FtJHO6RVOrFGd8RwNLsxAMpuoG/QlDwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729014; c=relaxed/simple;
	bh=2GmHdalk3MuFmANwSpg04quM/tlXjTBn/QKE/sM6KMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDH/UNBDpYBhj/9GQxWYoT2b35SLedblAWWW0kAWEXzQ0t1JcfOXer3LWpQ+69dCvPWk4lbbHamIKMymbJ2juUij9EY1ky7xfqaAAP3UAYp/BGmo4R023Eqr+jCk3RRHJVDCVUvt9eSue9C+8ujAs6vKw7h4RrUXIHU0B3Na/yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Qd33Os0h; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-471810a77c1so6557085e9.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1761729011; x=1762333811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9tu6Pbq45SqequK/vWQav9ZlOAAI95LlNmutY09dbN8=;
        b=Qd33Os0hFdn9rIRYXdf/npCqVU5fGkCkxmBieLKbd7snz1+ZmpRo8R7TpeZpoWXts+
         RbbOhfwSMeH6bXKSZvZ6BeyZgFh2mP0M3ziM75OvGMX6kjg7JexgoyhJztzIOAZ3iirx
         RP4orPazGNQ3dEJVfuzxABrYvU11HV+AdnOfGzM3Fna78Yw6l98lm5tJer+oz/s5Jk+W
         W6bY8yzdD9k0pH4ER6Hq05Ljjls0qK1P3pB95cGRMzMYdj+I0tLscZDC/KXZJeqPWYj7
         4guBFNDtJRr89RRlMZgFS50VByVGS5SC0Lo9mT8X+hCLs/yDnPjKNq9Oda5thEPSQVta
         R3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729011; x=1762333811;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tu6Pbq45SqequK/vWQav9ZlOAAI95LlNmutY09dbN8=;
        b=D4ZArGh0VcsW6iM5hqN+RyPvaZTLCEvCTNsm4G6Chmx4bLQPsVvLzUBZj5zelx+tF4
         5V+kLsNwVdmb8syN+KHBZd03hBPO/G/Et4tI08xConDy8QLh8TNPWjjL30KNYmR/dTAT
         OHv9occduW5kZPlyf2hHjcl3xBmpQ+bvOAPdiFnJabx6x8N3fguGe7GfcZ/C8C7cw773
         92QrRhiFwErjDN3uz08OXVqFxDqY1X9/EoqgVoH9PNGO9rexli5Y6+KuWnkWqT500cv8
         qYHRIOU8nKuXGL+cISdTTR3HUTw1xljvl/lshYPDG2aMxON7AF8lJYBzzaSUxRYc67SW
         jLpg==
X-Forwarded-Encrypted: i=1; AJvYcCVKRmqS9VO40TniS6pVLYSjuNotuhlPRXMg8rVCGfNI4YAAlWnL0x9ggfE4E6RdBX7MLjSLgaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJq7A4HpcAeuif5uqeHKkM9Do5v2CTSW0ozKxO2+uVkxDE2tIx
	dEc9F5aYHvvjCpmr9G6tKxq+jD7JFadWW91BzO8iIdtjRkp+ZM49bdctgisJcQhOxOg=
X-Gm-Gg: ASbGncvEBtSH2/EvQeN0AKjNW/jKq43ide0W6l6lwxqrIZywe3aYjrp0wyvLPMI3i7/
	XmnCzEpMoF0dHXU/Xu7wyAFcjyF5MBrdJVLGyMJYquRJYlDZcw4HaOkiOSLqTKBp7vtROh54NlE
	AfhPbf3mnwH39jVaKUUPbYI3HPSHToMm9dgvNxnHjgMzTXDVkuXiipXZNtD/+BhrjonRxuJ006/
	t60tMan7IQy/srysQyiOww+Zke1TDwvNntsQTNYv3keV7r30flbtoaiTi2mA/2bV7SbgLlSqBi6
	Cgz557M08h4ux7+VzSdz1SxxBMWwsXh0wB7DODOz9ioSZUUDEkM8aE2Ip3HYp/PWVR76p1BrIR6
	dpS9fIrIsR1rveCjArIX4Bo9mXrpvULISfzWUIODJXFBHZHDwZSI18WE2yTI2x3mz98xi+y8eMm
	3nRZVaD1uAwLLyqTWWhnIEkda57IrqrPidksu8HcPFr0h8YSnL1gfYk/XposUugEc=
X-Google-Smtp-Source: AGHT+IFqk4ToMqpQP9bB3P1SCAW8S6ESA+1pktajcUdB8bOXcy42rhR50x7FVTyOeCVsMCp4F3DgfQ==
X-Received: by 2002:a5d:69cb:0:b0:429:a89d:ed02 with SMTP id ffacd0b85a97d-429aefc0387mr570340f8f.8.1761729011055;
        Wed, 29 Oct 2025 02:10:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc55sm25933421f8f.10.2025.10.29.02.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:10:10 -0700 (PDT)
Message-ID: <3ccaca17-28e8-42c5-ace9-0798713a6dfc@6wind.com>
Date: Wed, 29 Oct 2025 10:10:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, toke@redhat.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>, linux-kernel@vger.kernel.org,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20251029080154.3794720-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 29/10/2025 à 09:01, Adrian Moreno a écrit :
> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
> 
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
> 
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
> 
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

