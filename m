Return-Path: <netdev+bounces-230944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A2BF2306
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3209D4E69F2
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C1274652;
	Mon, 20 Oct 2025 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6bdbHiw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78763258CEF
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975133; cv=none; b=FUkD0IWj5O8fnKZHaCnAB/k7HDl2h9ZnZi5jqgkB+Y3N0qnOxwLEvQS+7vBTpj1Md9VXTvvelrHCfdJXtejWUPS8Cyb+KqEZpmOD0qs3eeuGouVXHAoqdRlhudOTPJeOU33g7WkD9aezfgLkJDVuTQa45uNigQxsqUnymrgQ77U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975133; c=relaxed/simple;
	bh=rWlIEOfLt4QSbEFCHlWSDOc4rlXWOXGgHbTI9+CTFCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giC6lP+m2osPfUzPsGvhA/wM/xBBqyhHlUNEW+Upb2UZsYpq3NGJQ2TEygEaozcjh2kn5MqZ92agv+q+Kjbxr2Gn5o7H4u6RAWiRxfijnhbXAnkCcv7cJuRaGkkQ0lRphJwMNTwTCvl2ViCiGARTYkk92uQImC4nbm7v5G4sGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6bdbHiw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b404a8be3f1so103531866b.1
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760975130; x=1761579930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLVd96XUXQkv2BukfYJUOUjTeSFa5/2WoKAq5E06sq8=;
        b=Q6bdbHiwrRq1zIGsJJWe2QJyedChhIdxEnYcqcecYhUr/u7zNukFYIRP/wSG8+p+Si
         vh/YBRGNZPu2iqKjLw5opnGX9IXUA6oIwVf83m+NB5Hz292YMSrSEgyUjYUweK9Q2icO
         b9Gk4/gpcJUEyn9KVR2Q5pe0QEitnb2nQdfeIghptNLusMdQEZ/mpPVSm81mTVb4jzeq
         7wNwHiargEKo++DVi49ic1NpMWbFsCXlzXJi7oI11mtG7/+00aCx6BS5md952OKX/hmI
         uSeB5niviOsCIBxyj+LJcOhpEvLjKYhTH9wlQldit4KMuIGAnp8r406ks9uZvNWqkJGn
         Lcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760975130; x=1761579930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLVd96XUXQkv2BukfYJUOUjTeSFa5/2WoKAq5E06sq8=;
        b=mNnXApzRNmK6MuICY6RXnUFTOV5IunvKiR6Ew5gsUYl71ZSoroR5oRNAGhRV/Fpu1e
         hPlHl8LFLFMpTEXePmL4OvZgDc/+R9KB+Zp8lAyj8uT79jJpdzwqIxNsEKXLKzlsxNUY
         F73gg9sowrHbdCv/jAs2mVqmx2LuqoYwH6czUPkFkhOiXWjRApaHwFWxlbA9CIAssk0A
         B47MJcSIlwUEIOsZfpxoKAraGs+/OYikFZ+6xqhEUtJJKLpiBxbi6YVn6Dj6AXKW0ekl
         rdoVoBiz7ih02fRvOpcA8iW8dOdYSHX8xpsnDLQxdhrgBP2mKduKpW3WYEU2/5fmByYl
         eQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhCF0eexGYPkOg1MoqlU7W/TlNTw7iiQ952/uC7x7pxPfRWZ7BDyq5TJJbJg6U/kSpSdS52Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC879GdFYCUOy8VYfYuldTZmx6hCgjnUdlrvQ+cv62+n7VgX1C
	W2ZZ40YcMPH+JrpIb1IMgSVy2UX7+vAEmVZcgxTv4H23hgR3WwuVpYxs
X-Gm-Gg: ASbGncuIZJPQH33z0p7rteTpLNrcItEsdtGEQeV3ZDBacBdU/n0VM4jOE8w6oiQBAG6
	wlJnKBftOQLZTLBMlmhOumweT8u6JWgh24cntHlIlIW7nsWaHQifWVYLCUPhDSjwr2lujCLj1Ma
	PL77jvr67dpOlMVJtiM4lVziGOSintCq5ms3suihM0H1AGeS2SaMe00fsDkruDIXdvcoFwU71tx
	A2SwFfzc8oIJBSM/vz2z2oDQ+q+xSkdZw83Y4yukI+UWQTHuY+LvV8qmPtAXQAsZC2ni8HVZUdm
	mP8G93ppRl4wXPPPqb9EINenvPW4oiuoSF9jskNfTFU5PfVP02jBvPHGNmmbMVhZU7VEEJkeYyW
	P9K1NsSrNLbOoNwwMq7eC1sveLymCrt1EB3v2AqeTrwVOUKlX9rLWYaKJuZdB/61eeE14LRpkQ8
	nYv+9JDTmtnYyccfgZ2NTw/rvb+W204A==
X-Google-Smtp-Source: AGHT+IGbvK/f+EyST6/Ou/X1/Otr+t9j4IgsCu8YzzEolwEyyl33v0jG1ZAXlIIZiPmx169QmFhW2Q==
X-Received: by 2002:a17:907:9708:b0:b04:2d89:5d3a with SMTP id a640c23a62f3a-b6475505d94mr884342366b.7.1760975129544;
        Mon, 20 Oct 2025 08:45:29 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.86.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc474c6sm808850666b.78.2025.10.20.08.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:45:29 -0700 (PDT)
Message-ID: <d9819687-5b0d-4bfa-9aec-aef71b847383@gmail.com>
Date: Mon, 20 Oct 2025 17:45:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/cpumap.c: Remove unnecessary TODO comment
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251019165923.199247-1-mehdi.benhadjkhelifa@gmail.com>
 <42b9b376-897e-4984-909b-218bd1e3214a@intel.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <42b9b376-897e-4984-909b-218bd1e3214a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 4:41 PM, Alexander Lobakin wrote:
> From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> Date: Sun, 19 Oct 2025 17:58:55 +0100
> 
>> After discussion with bpf maintainers[1], queue_index could
>> be propagated to the remote XDP program by the xdp_md struct[2]
> 
> But it's not done automatically, so not aware users may get confused.
> 
> Instead of just removing the TODO, I believe you should leave a comment
> here that the RxQ index gets lots after the frame is redirected, so if
> someone really wants it, he/she should use <what the second link says>.
> 
Logical,I will send a v2 soon.
Thanks for the review.

Best Regards,
Mehdi Ben Hadj Khelifa>> which makes this todo a misguide for future effort.
>>
>> [1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
>> [2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
>>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> Thanks,
> Olek


