Return-Path: <netdev+bounces-249528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFE2D1A7F5
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B7CA30A77FC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75F1393DD8;
	Tue, 13 Jan 2026 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="aEJQBFTL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07BB3803DA
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323471; cv=none; b=TToLGs7Qgzzn711mj6P5ssV+9emcQw2F5KY8l4IL+SskUgZu4bRVrncpoB6s637gYe9SfAhovzmN/4+R78u1cN0rQ3ytO8EGhA92K/XGPaM8AE9pmZqC6wGBkNY9gQO/E9BmO8fRiuJ03v/06th3fa5Rw7ycziOEtgplmqnmkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323471; c=relaxed/simple;
	bh=0XnufA+vKKOFM3j1I6V3PEMQn3QU8xGoTX9vlIzUKTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njCRTZBmBPBLG8NDdynLu1U0pZHGpCu4x6Jr3YGIRvsU/AygAreJIqpAg958NXTA3hErk4tKqJMe5ZweUaalowdUVSv8IuZTl01J0uk1twqdeFsC+rK9oPv7xAEZ5KXxy4w7oSToKZUC2d/ewgfGOcS6qqSmG7Al+U5l2K8B1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=aEJQBFTL; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-11df4458a85so10920808c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 08:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768323459; x=1768928259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/IWdv0aphEAVaIt1hnbRSuaugoQ1OgFL1kohFBWpHLY=;
        b=aEJQBFTL/qRglMNkawY4oTlqXZL4trWCpQku9IdjJfPVRDhx/aS6WNhSmWaZ7kD7Gp
         ztQxkanhvHVKZ301ooddDR15R7fx6GdllaEYm4EiI0xPA1XgL8J/Mg9//CY53SvjmTBF
         0f/sZUtc1Sq3pbytXfIE6m0oMrUlLX34HachD3NIczMLSPXYRkOhphJfwKQAUDzawbUO
         YTdkDPE6KTegNkuZNErSMs1U5VtqxNHuLjwA1LQC31j7JEXNNJ0WbPqPYbp5IsKXDJlF
         d4Nfn4iicsNctgS8ZbuA2E1cOock0clHgYfHw6EYpg22Vz92z4OswGKMLpQE5il9vxUg
         DyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768323459; x=1768928259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/IWdv0aphEAVaIt1hnbRSuaugoQ1OgFL1kohFBWpHLY=;
        b=Wt4wp2nZmOtWvyMBroe7IZijbfliadeBdkFB+yK/J932q65hCbrv2SwHkMMzsnszqE
         YdQMWthrIYBePlnmwgEQayQh36AGpvaV1Zh0d1pf8ps9dytaLbbK5PLWfn4TEUotMeVO
         kIZCvVe8xt6ca3eK5rasl6J4liD/HBblN/xlljh5HlU3akiRkAr1nn404CFQxZmhy4dO
         h6ueiIfLpEuP03BYnEhocqvAXbyNlGrecc2EOTBN5B5qwkaIbK5Z74A7B6VRTBvb5R2H
         9riVycVnNO8oCP6UDs2h943O0xBoKC6qmsv7nvHXQn5Ec2Fz3tN7DDVn9l7P9gLNMASa
         KCfw==
X-Gm-Message-State: AOJu0YzF8hwUxffehpYVh1rfGaFKPwDGO/lmK4HQaxE98R7ygbWRGTB9
	uwV6h3utjvY0Gk6hjffTwdO+iM2N+NyJ72unwwaYMouF22ytEa1dZktC0OqtoOLgvyI=
X-Gm-Gg: AY/fxX7byi+mq7fx5d9hDX3+F/hMssiKO9ev0K+xgO4v1oYTAZ8X1fc45lINRNBiMlu
	6qrVp/AKqgJyPZ15nAbY30EtunaEG83jv82vWVbw+opHT/KIfZyns9/sjeWfI3fnE+GyH1AiS7Z
	CQAcHh79VZICdydQ5DMuQbcYYm5dEKOBQUfAdrsdMltNdgigKr8dzwk7f70pLt7n80lwfsL6mhh
	nIuAzs4awMGaB7XjlBihX5wDSGP4wHyyFC9wShFiFqN62BhL9n0ZQJZjK2N4gKK5kZjDROfwDCv
	rxsfd7nan16t6zE9Ym1GJeUpWqH4TfABOHK+QvlC+Yorhgwp8/YoUNqbelUZR2Nlmy4rYdEQmin
	Cj1SEFydKl6GT1q007yXVvrTEnkXxaWeoBu17w8UTknrKq1yueaI5Ufwk5VQHcEVo8Tg0T7lZFP
	a52w/psz11PZPAbwbeEvfGXQrjY5P3Csyw+/ev3qGRbTJXs8fSeJ0KtFGXfgxSbNdxPCxUuEAJu
	+ufUW5HfZiuP3C8D7YF
X-Google-Smtp-Source: AGHT+IH/Z/YUd3HhJgUE2KDAOVqPnirOdWOY08BI6bWnSTC6xKDHkmgqpxkpujIvZh2zqFAbqFN1gQ==
X-Received: by 2002:a05:7300:ed13:b0:2ae:5cdc:214c with SMTP id 5a478bee46e88-2b17d30bff4mr23323000eec.39.1768323459051;
        Tue, 13 Jan 2026 08:57:39 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248c239sm23354318c88.9.2026.01.13.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:57:38 -0800 (PST)
Message-ID: <24891166-20a8-42d7-88bd-0b3f4d425c33@davidwei.uk>
Date: Tue, 13 Jan 2026 08:57:36 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 13/16] selftests/net: Add bpf skb forwarding
 program
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20260109212632.146920-1-daniel@iogearbox.net>
 <20260109212632.146920-14-daniel@iogearbox.net> <aWQPNM5Sh1QNKtp7@mini-arch>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aWQPNM5Sh1QNKtp7@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-11 12:59, Stanislav Fomichev wrote:
> On 01/09, Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
>> prefix received on eth0 ifindex to a specified netkit ifindex. This will
>> be needed by netkit container tests.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   .../selftests/drivers/net/hw/.gitignore       |  2 +
>>   .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
>>   2 files changed, 51 insertions(+)
>>   create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
>>
>> diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
>> index 46540468a775..9ae058dba155 100644
>> --- a/tools/testing/selftests/drivers/net/hw/.gitignore
>> +++ b/tools/testing/selftests/drivers/net/hw/.gitignore
>> @@ -2,3 +2,5 @@
>>   iou-zcrx
>>   ncdevmem
>>   toeplitz
>> +# bpftool
> 
> nit: "# bpftool" is not needed here?

Leftover from a previous iteration. Will remove.

