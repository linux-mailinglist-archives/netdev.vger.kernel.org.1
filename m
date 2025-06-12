Return-Path: <netdev+bounces-196918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2341AD6DFA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EE9177BB0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC3A230BC2;
	Thu, 12 Jun 2025 10:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2pp8Lf8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE3194A44
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724707; cv=none; b=JHMDnALBPTPGAoVm2PC+TRmbqlbOjGNVmfue1+FnnkVouUbAL/slS4cisaAtS13JPu4ebMeLBHkR4Egd5uGqGwiPVXQtFPfrx/FMVFSsZcLXhpO3gyCPApoeUOsmHmV3XPN7nqOy0Gz081Yx5QLhlyeYUFuS+ZCvLg131ErI1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724707; c=relaxed/simple;
	bh=C0YxdnemTpgCIoRlkdnSMhWfet1GRoKJc45sZbQcRyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+po8FUyz6anCKBvL8o8AgnlA82ljMUNCk2UwbS1LAmBkCSLW9mqOXImBGIrZ7qPXfhjQDlM5yQjD8Yr7kz/E8yr7p5VP/g4q+tmoOM9in8fpzycgdpNGG6a4b2czOa/5XuBTFyb1lbzpQaU+/i1zDdCGjF3Xwp3iR7IZgTFib8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2pp8Lf8S; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55220699ba8so802773e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724704; x=1750329504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wct2nGyoCqXp2x3vjQbGkRa3XdgPhK3Uo0JALvLVWQ=;
        b=2pp8Lf8SYTSt1sCkDbUdhJtGNHcPT6z6fW9PxmKPGLyPl5KA3VKkcRFv6/8rfAXwxf
         zs/AxO5su9WBrAxjrUwDADM7s6MwatRhkEx/2L3ckuV7GV1JvYeoE5m+ISOL+CPEFr+j
         bqtS9XLecqqhIc14nvP8UUugTSOgm3fQn47ep6e03kKyQj2QPNcCRRr9GcGPskwoQLUd
         nmd1AxPzAFocl0NM1Dt801PWhoCT5gVwJM3RwfymaZFGP5A/eg50hjvUxddPZvGWYDNB
         XIslpB57rKSoyYcvlvOa6WkQwzmbQXxEqNgNWJN6fmVw90EepTD0aODNyiHYdA2JZFYC
         kpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724704; x=1750329504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wct2nGyoCqXp2x3vjQbGkRa3XdgPhK3Uo0JALvLVWQ=;
        b=jI+4SG4ph84ZY4mD5kKM6E58ki6ayLvrI+F/TN/gOG9B/+P9R9ZjegBdLr+16W2bF4
         KpybiTiQTDUdySIl7Hd5ozrJYaR1UH5cMnc5BRmxTbf6e3oBbwz0I7SkNw7N3CRfwaX8
         puf4eMVUImUk9r0lFINruhNlWrD97EQk2rH0Dz5IWTPJ0/cw+1Wq8h6Xxc4N1OC4JQd+
         NyqtekZfDkhy+lH+D0nvSL58fYVvUmyGRTvQLehe9meIvM7Dcn/IbToAeeKBUKO8/jVX
         MvyXU/59xzoNjqkMYHO8Wl+O8ta+LZHzOmtvbLu44N9wKPviJ1rvEhTRLU/4cvCt0kEh
         /diQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrO0Y8kxwwPTPKw1rGs65/W8G9oHKke8dwaDRd1WX7ivH1scA3zyOwM2nfr6u1aC8EEX6lhpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHIhYsASx0SZ8rctj6r5aNqKm2hNbAMhcVBBL4ziSZS3bkImtn
	OmSaRDLRSHNLGgRZsGKyrnQCrYv6OWn8Wr2UESlblBkGpooNj5HcmmZKjSyHBHYJQQI=
X-Gm-Gg: ASbGncugTibuQQylnzIkkb+jEV7Ld15dOr/KGJDDB549NT059RIGLmbccF41+o/N9R5
	vworLLm5cMacFaE48Z592+oeDABk7IfCWwKRncLLaBXzk0wXR2ll5iU/I2TzVLKcH3VTIisHYmX
	pyMwPZoG6lq2/fsmntokPDvmezvllQAb/0kaFbszvB1oh+8l+00YDxZ4gvOcN8Uvz0rHiwOKBh5
	zvTSjrqH4lI5Bnq38U40/aKHxTdyLM4KG89/Te3YeH36p/bVTmUyrLAYkjLFaSmg+IVUx2TTrCS
	v7teUNlHohWTeont7ufMsMFg90tEZyuNDBxshaZKsoF58Sas4tZkLMMHbc8aEtxfWTBT6Byf2mr
	vsk1X8Guf43HecqpTxDC20x18sASO92g=
X-Google-Smtp-Source: AGHT+IFW8TIRuuJh3800ncpzKN4iIagGqcN81CLQqAHtsQdPAIFBiChOrzfFfejUhBr9PgNXkAuPrA==
X-Received: by 2002:a05:6512:b01:b0:553:2633:8a65 with SMTP id 2adb3069b0e04-553a5553bc7mr823077e87.30.1749724704461;
        Thu, 12 Jun 2025 03:38:24 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac134eaesm70552e87.63.2025.06.12.03.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:38:23 -0700 (PDT)
Message-ID: <180d82c5-582f-4879-947b-649a4495254b@blackwall.org>
Date: Thu, 12 Jun 2025 13:38:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/14] selftests: net: lib: Add
 ip_link_has_flag()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <cover.1749499963.git.petrm@nvidia.com>
 <e2fc1734cd9437349e22e16c05fd0f4d06397fb1.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <e2fc1734cd9437349e22e16c05fd0f4d06397fb1.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Add a helper to determine whether a given netdevice has a given flag.
> 
> Rewrite ip_link_is_up() in terms of the new helper.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
> 
> Notes:
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
>   tools/testing/selftests/net/lib.sh | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


