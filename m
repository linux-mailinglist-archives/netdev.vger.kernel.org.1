Return-Path: <netdev+bounces-225036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFFEB8D9F0
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 13:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76D33BE565
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22C7259C93;
	Sun, 21 Sep 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+BHYOAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315908F5B
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 11:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453898; cv=none; b=VT9fraEw9gvGPbvQDU7zBDfbnuMScxBkdGdoBbwEoT3aIguR6MMj0gxOzRmsokZePv6rG8arWam9EhX+I9iUE01WkDbfqXoN9rxMT1emcJ5opGp+71MJFuyPNMarxEiKuiOvG1UclnA2svGcWJFDq6FxWTGkXTylqAX53Gf6hNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453898; c=relaxed/simple;
	bh=P2khDDn/G+6oVOugbUsDXxGtt+CufsbX6kA4FmUk7g0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cioZJIsvTMP8pp9PG0BNQOdfDETvL+uP0gnDfLiBFModBIj/G9BBpVECz70y68VS4Ttjrha5k8/NliNl6F10zPHIjZP85P0/uD+Jh1iqxZHGdZZIA6AToHRrh/zpGddSvVTqq1ja0tGgs3rnV02BWmG37nxlcRLebSgm9uvJEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+BHYOAj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso3749651f8f.2
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758453895; x=1759058695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LpqXVMdBPXLDB8/wzui/VoVUAw42bntrHFhuBKSPIgQ=;
        b=O+BHYOAjfd0COWp47RYgNSsnsSuwDXyR9KY2rBvjH/W+ypgiYku+RT56XfiAuRVpnw
         v+W47X7cLzkPOyfUgcLIxV+6y4PnYC47fJEsncuu8Qcu0mCtLtj4ibUHBR7TbnoZNGa7
         c9tn6jnLQWkT/tqljs3On8SAAGtGc5lj39mRvheAjw9U39+Y9IYO9Vw+vxcYvynVwXqg
         xmoYj3al/Kfm7hb/sFRWXG1P7oCf6AmR7Yvb8uabmf04YD67eOcEc9APTqJNKEsdB15P
         7jN5IbX9oeLYC15kj2AMwwJQPn//ZKzEdcFXcoI7K/FQ45oeS7GAYd658M/spX846IG/
         NwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758453895; x=1759058695;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpqXVMdBPXLDB8/wzui/VoVUAw42bntrHFhuBKSPIgQ=;
        b=mR4eoezpTW4AAjY4TepIkQCo4B7BOuDU6dXElVchAzQaiKwuL7uyAtehyDvZb6uqQC
         F2oiQ0H5CceEMyNiTrpVxbpqmAydHwb0H9QTGMpemX1uoPjkoax0uJIb2DWUFzLwGBdP
         dS8wUnqf7oQChWrKHDFoziJs45Ov/VU6Lneyo3ShD+qEKxoY5/YT2EWh079PJc4Y1g0p
         w2UoHCheLbmtKkrQo6umRdtXoKxtFnVU3HIGd4454xZ3n5JR56Q9oUwvIVv2YfN+f7kS
         IHWWBTDtUzo5LA5/CvQ1WDPCXq2uTsvVFivue/QBY6Mp5W9caESf4udVMIlojS3wQF3x
         QueQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmvHXGqbDDkarZyLUKIT2ELmu/Wrd4DfDBSSLAvKzSWn2y2kIa7UpNpMTpWQfhRnyLFeNhSa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgDPx54WsPH9z4VvosMWpCf6FOCV7xAT+OtZ9/rk8wNc7iaSS/
	yNFCVF1T8gLPQY/G6GM4LfAHuDAulxMKmU9oQeUBD7k3ngpt/srIKAbZ
X-Gm-Gg: ASbGncufPCf6fjwXB7+godr4rzixzzrZyvxod3ItdlUA1SCSACty4i1atPBL06gkhYy
	nCnnHfQAbgp8mNAQVueAZMaBe1BhjW8e9jpKc35fvoPU3mHDe8u1Xm3AcqLEGeVs8JMZLWAmu6B
	tlcAUslUaea+eJdqn9BRwmynJDQfAJ4a+aJLaMrAFtDKfBvrE847gYmuJE1V2XWt8M2GfbRTqmo
	I4CSrsL+ywX8xIl6Zp+chwG+zRIy49fo4RAW/saHIIIuAC723gFQaIPjrmGkVnTzPksj+MRbOoV
	De+p+GtS4rJMINfyHfF4RZNZtckP4AWaWqYYG8L5rNlyxTr8k/0yWTa4pdjJSFGIxQgBHCsoqLs
	AlTj/ih91e7kzoVviC+vKVENXxaKvokiY4qjB6w8w2u0pjnc=
X-Google-Smtp-Source: AGHT+IH0ZuZXXPjniEqaRqXv4QdY/ExU554pUIFqdmbqSw1xbaLHEJm2846zI5N46LR7fz3DTPaVRQ==
X-Received: by 2002:a5d:5c84:0:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-3ee85769a18mr9563158f8f.45.1758453895193;
        Sun, 21 Sep 2025 04:24:55 -0700 (PDT)
Received: from [10.221.198.215] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm180429735e9.12.2025.09.21.04.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 04:24:54 -0700 (PDT)
Message-ID: <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
Date: Sun, 21 Sep 2025 14:24:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff
 for mlx5
From: Tariq Toukan <ttoukan.linux@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com,
 kernel-team@meta.com
References: <20250915225857.3024997-1-ameryhung@gmail.com>
 <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
Content-Language: en-US
In-Reply-To: <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/09/2025 16:52, Tariq Toukan wrote:
> 
> 
> On 16/09/2025 1:58, Amery Hung wrote:
>> v1 -> v2
>>    - Simplify truesize calculation (Tariq)
>>    - Narrow the scope of local variables (Tariq)
>>    - Make truesize adjustment conditional (Tariq)
>>
>> v1
>>    - Separate the set from [0] (Dragos)
>>    - Split legacy RQ and striding RQ fixes (Dragos)
>>    - Drop conditional truesize and end frag ptr update (Dragos)
>>    - Fix truesize calculation in striding RQ (Dragos)
>>    - Fix the always zero headlen passed to __pskb_pull_tail() that
>>      causes kernel panic (Nimrod)
>>
>>    Link: https://lore.kernel.org/bpf/20250910034103.650342-1- 
>> ameryhung@gmail.com/
>>
>> ---
>>
>> Hi all,
>>
>> This patchset, separated from [0], contains fixes to mlx5 when handling
>> non-linear xdp_buff. The driver currently generates skb based on
>> information obtained before the XDP program runs, such as the number of
>> fragments and the size of the linear data. However, the XDP program can
>> actually change them through bpf_adjust_{head,tail}(). Fix the bugs
>> bygenerating skb according to xdp_buff after the XDP program runs.
>>
>> [0] https://lore.kernel.org/bpf/20250905173352.3759457-1- 
>> ameryhung@gmail.com/
>>
>> ---
>>
>> Amery Hung (2):
>>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy
>>      RQ
>>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
>>      striding RQ
>>
>>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 47 +++++++++++++++----
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
> 
> Thanks for your patches.
> They LGTM.
> 
> As these are touching a sensitive area, I am taking them into internal 
> functional and perf testing.
> I'll update with results once completed.
> 

Initial testing passed.
Thanks for your patches.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


