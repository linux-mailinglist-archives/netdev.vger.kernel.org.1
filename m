Return-Path: <netdev+bounces-104153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE19690B682
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 18:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D174B30EDA
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391DF13A41F;
	Mon, 17 Jun 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BT9xKqT3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D813A3E9
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638789; cv=none; b=VQZgBEDUdQR0kYaZZf9axXSbEHlpa+xgCPKaazQdoueyj99WQTCopM2mVE0B7SMlQCefDc5xcHzDfCBuHx5xdIq2QVykXQNOi5GQr78DVc2mjnqLbukR4mNzV5aGRu6JbZ2UxVeBGlo9EioENES1BX3IQQfMkTJgVHtdIyX3XP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638789; c=relaxed/simple;
	bh=sDguMWhlufB0LtQW6adp0niHF9WTZSJ/lZFez/1AIro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZq3VXk1RrrOWXOofWWbuiCpnI/jeBd4leX+XSMlVwEri5fvcnNwzhbgFKtTPQKL+7AznVG6yE0QZ3wyfPnREHhae079iDalmbTkhAsq/Rna76/KxF/krwEr7X+EUxjPvm5VyoN7GORzYZPG/bR5lm/JfBNk1uyK2mnd8QZxDHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BT9xKqT3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f1691b18fso3582768f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1718638785; x=1719243585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DkuJbIfIOavW1nO62wlY4Xk8lIaFyCYQbdVLLnZwfJs=;
        b=BT9xKqT3b0xjOUnl2g4XlyHKYlnpLdUZW/jOee127fZALsAVIHOVGIIxYhYNMW3SCl
         9hP29rEwkJBu/cw3HHI85rWxSugaigPT/2z3BvDruCpPvp1+lxbT8KB09cbU5UBa1xu8
         w+p357k62GbcgkqkMi/BGSj4Xy/JbxCYgZNSNCkkgXkJFTgngtSXj26mgXU9BA4A6kwR
         6yG6VKNpz1OgJWLGz1UfY7V4YkyCuO236mGXXuEEBzqbh4kprHoTDGLRE5ucsmSnCR75
         xSt1cYbTH+BDChJ6SCExhoAXCzbxKVwsvPP67pG3YgxIKUbl7Ot1krYQ86N36lx5Cbgz
         Q/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718638785; x=1719243585;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkuJbIfIOavW1nO62wlY4Xk8lIaFyCYQbdVLLnZwfJs=;
        b=Flx0b3ws4+5tZAFBJBOrYh7QPYVCynIG+RhjV+aku8j34NbuWS/n8mXadnV0/uBPV/
         ob1Swg35wmK/yin/o5ToLZGVAmWXuuG704+mRkrItVBbd6jHLtvHvjH6JqAqa/pusupW
         YxZ985enFrAsHI0TGnLfNMPxqHtkp83CDeqJk+zVDyxv+qOTx5Z6U1yNOe3aG+WUtRl1
         L4rn6RTYjkbKqstvzzO8k8zq1xsQnWfYoM+yhOTmxAWACcj9RyeCX+fVtYXe/aepTVx0
         GP7oBe3yXeEtIozlNu7lD35pIAzrcWxvv/KejhWzOIm4IFbx2MIenIf/PIPp5/mj67yC
         wSHA==
X-Forwarded-Encrypted: i=1; AJvYcCWRf6hCfEOAbqkZq09wL3wDZmpFhxvczY9B8PShKF55k3TXHbBKgPPG8mRq93Ck3SBDOTjY9NGKQBrnl/Gk8fDB5nRv1+qZ
X-Gm-Message-State: AOJu0Yx81JOHpVBbz3DMjSirah7qyTThuNXgy4dcPlRPtw4j2sXRxiiT
	ap6cYRzyHWMqQgmRwJVRfTaF+bQVHmJgz4P4aO2oF257zbdPfUxavPRlm77WduT2OwcKZWgbI8/
	r
X-Google-Smtp-Source: AGHT+IERv1ZIO0ntQJMtCb9v0OJfwr+tTLBeDxKsOUvLd2bYtInZaqVXZ79TKDAmejdpcB57wx3Cvg==
X-Received: by 2002:adf:fccd:0:b0:360:7092:728 with SMTP id ffacd0b85a97d-3607a7d96f8mr6702265f8f.55.1718638785619;
        Mon, 17 Jun 2024 08:39:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:3164:3835:7a95:54e9? ([2a01:e0a:b41:c160:3164:3835:7a95:54e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e74c7sm198692925e9.47.2024.06.17.08.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 08:39:44 -0700 (PDT)
Message-ID: <9f3c7667-f5ad-48b2-9f30-454c30d6a933@6wind.com>
Date: Mon, 17 Jun 2024 17:39:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2 0/17] Add IP-TFS mode to xfrm
To: Christian Hopps <chopps@chopps.org>, Antony Antony <antony@phenome.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
 netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
References: <20240520214255.2590923-1-chopps@chopps.org>
 <Zk-ZEzFmC7zciKCu@Antony2201.local> <m2cypc3x46.fsf@ja.int.chopps.org>
 <ZlB_eSJKUKwJ2ElP@Antony2201.local> <m28qzz4dk5.fsf@ja.int.chopps.org>
 <m24jam4egz.fsf@ja.int.chopps.org> <ZmftmT08cF6UTMZJ@Antony2201.local>
 <BC54C211-FD19-4105-833C-BB3B297B9BD5@chopps.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <BC54C211-FD19-4105-833C-BB3B297B9BD5@chopps.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/06/2024 à 17:17, Christian Hopps via Devel a écrit :
> Very sorry, it appears that when I did git history cleanup, the fix for the dont-frag toobig case was removed. I will get the fix restored and new patch posted.
Please, don't top-post.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n338


Regards,
Nicolas

> 
> Thanks,
> Chris.
> 
>> On Jun 11, 2024, at 2:24 AM, Antony Antony via Devel <devel@linux-ipsec.org> wrote:
>>
>> On Sat, May 25, 2024 at 01:55:01AM -0400, Christian Hopps via Devel wrote:

[snip]

