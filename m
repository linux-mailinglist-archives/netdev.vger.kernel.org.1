Return-Path: <netdev+bounces-201352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629C7AE9184
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7177B3713
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 22:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06351FF1A1;
	Wed, 25 Jun 2025 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSYOkaE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E1199FBA
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750892473; cv=none; b=K7XEsNt0QV8hr84tfxVTXG0LyTwVu3TFwrcXtRSx20ukusWsCFjXvnDiiNM8KBXyP15n1Q629QnSfNiXPe4zjn/sof1g64MVlSXa3ANlqwKAx/0cooD0XtzFcAc5Jzw93IggJVvUGBUNZyS9LInEf22fvNCfNNOtzBRDzRQHIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750892473; c=relaxed/simple;
	bh=7cSn7O+8zGBZUofGSGR93Mq1qNwsjtjpapDij9GlU6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzIlw2Zx9lziIZC4htuAgLNFVT6/9tmAApv5kAW3KCgRydxrV9khErXoHVIk8WouLYdxp3sApJCHZ3CTBIkm41ly6DluaAjGDNnfoYg1aBNSzGtbHlvizgk/8BbRE1k6J0kPaCeqL8Mmf6P2FkTrCy2ive27d1wjekw6zKO2+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSYOkaE4; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so7203106d6.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750892471; x=1751497271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTXpNsd/yfZXovdY0a5/egN+y7T7ROAy0wEtFPkDay0=;
        b=KSYOkaE4Y6VQx3BZuvsuR8dtSxnDD/pP13A+j/n9yzpGiagZfleTBuv7HPaPqAuRHY
         JnZdd5LAvmmXWQIanoWWN2Eyu0QnqRMhJx7cO18MCYWz6MWtpCF4wjqHqGcTBPRKDRU8
         H6jv22q9RNAqyRLOYVM7vsOPzalyz6/DpuEQXE3WXMGG4T6EcxA83eDsAUPV8vjM7VQc
         M2Tv9WaaWeLRuw3dnMLDWmAStv66eyVfHKFC0wgBHawNfBcwedS+G8P+gSDKPEI9ctIA
         I9ZLmo2oh9wSqFG+Xz6RhMDK+1Mbz4i1z+j3kJ4HGRqN959uAnNUjhVCdVBRd/wunsAM
         wN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750892471; x=1751497271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTXpNsd/yfZXovdY0a5/egN+y7T7ROAy0wEtFPkDay0=;
        b=TNzrN+y1BnabFGeRIhKUdBZhRhMXQjrNfZWYMw3oAz5o5BdnqPw2hJwsD5bhEfEoh8
         htBfEEalA7r6CQmfhFxxrOHnHDAYryh+dzIhZBWfcBWn6fPCw+JCfa/oRqefcDMl8ZjG
         aWsCBQDj3fwd2RMGtc4bmAoGZwSz2Uqhkz6KOuE5V0xX3OrIMYlCLG9VUs/m5BBIqQj7
         F7lG2QnSqXbzv6I0g3+gmdKAVe5rGlNY++hcsC/FZtoM8h20fx/IIeXGF3zuNTT7ieg0
         dpMlHgdrlUsRBDLeSLYaWrZKDgMhmReNW2O5LPLwSPGLRDJVz8YjK3HjicJlS3ajd3x/
         UdNw==
X-Forwarded-Encrypted: i=1; AJvYcCVsuqUChfV9tOTJU9MvmaCcnF+zhIxB8mrY4aNcgz7R7Mh5SyYPOvwSSlJiJU+p955643nwBLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVc2ptouEYGKFGKpSQGbuvThiW+GtboAqjKrw//U/1pleR+FO
	grERGxXeLiaSRrn46hoo7fhIe0/EmrvgxbpgRwmos3RrM6C6J7EgJhtA
X-Gm-Gg: ASbGncvv/aGBNW4gGtIoj3cwxxHFnDiVkACwQsderV02sY6yjyGkG1TCHadOi07sTh7
	7EJMv5IVhpKv7qSFCkSiI9balIzr2/NxPW8LkzeJT5Wc7qTSPeDdHRxVRIewHXh98nmztl1NkFG
	wdkt8EierSjXsjzO5iOOG6dcnL59UojbignM6LN4WabSLJ2EfILzqzLiqWvvT23Qzgb9SDibj+J
	h6EXzCWT8khPvK1ZvmcrSMyO6MnkWckMJ/K+PPG8wnicOdv5PMMvtTeDyUAeUu8DzCRWwhBi1Hs
	u1Q/8kfAHR4Lhh9arV9U4+gMtoCn30J0qnTERvqx7MnchJLbPM3We7Q5Wyho8sYY0ErWdWZr8hA
	iC8v+UhjMGJkNR95eSMkjPInUy8Nny4QUJwdClbpk
X-Google-Smtp-Source: AGHT+IGnQDsmU5MJl/kntwlmAFLMi8fkUuSIjg8y+BHtloSXrs2In8IarEwoD2GPYrXHB0YB+Sc1eA==
X-Received: by 2002:a05:6214:3f8e:b0:6fa:cb97:9722 with SMTP id 6a1803df08f44-6fd5ef94223mr84004516d6.34.1750892470956;
        Wed, 25 Jun 2025 16:01:10 -0700 (PDT)
Received: from ?IPV6:2600:4040:95d2:7b00:8471:c736:47af:a8b7? ([2600:4040:95d2:7b00:8471:c736:47af:a8b7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd772e434bsm786596d6.67.2025.06.25.16.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 16:01:10 -0700 (PDT)
Message-ID: <66271ce8-f0ce-4d9a-acab-5cbe881c2a38@gmail.com>
Date: Wed, 25 Jun 2025 19:01:09 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/17] net: psp: add socket security association code
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Patrisious Haddad
 <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>,
 Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-9-daniel.zahka@gmail.com>
 <20250625151826.48cc600b@kernel.org>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20250625151826.48cc600b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/25/25 6:18 PM, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 06:51:58 -0700 Daniel Zahka wrote:
>> +enum skb_drop_reason
>> +psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
>> +{
>> +	return __psp_sk_rx_policy_check(skb, psp_twsk_assoc(tw));
>> +}
>> +EXPORT_SYMBOL_GPL(psp_twsk_rx_policy_check);
> This is just for IPv6 right? Let's switch all the exports for IPv6 to
>
> EXPORT_IPV6_MOD_GPL()
>
>> +void psp_reply_set_decrypted(struct sock *sk, struct sk_buff *skb)
> And this one needs an export, too

Yes. It's just for IPv6.

