Return-Path: <netdev+bounces-246351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2D2CE986B
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 12:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06C9301E5A7
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6B12E0B58;
	Tue, 30 Dec 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ7ngUhg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="snZdCRfU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDF2C08CB
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767093560; cv=none; b=HIQtbjbHLpQvrR3H5gvBRcT4GlsAf4QQ8fUQHrOz9gW4kltXeHlPCNUfVkcVMTx82UCx3wHjWhL4XX/YHAAZR2OcwMKcFAdnDVtJTtihJBuSz5c0kZHI4qQh7Ss0VW7/oXmg083OHBZFbE2KBFqv1EddyMDYkw3FjRK65Umk5xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767093560; c=relaxed/simple;
	bh=Jvz1P40VPI3GI2IPAvBlpLBMAOhptp9OUvSuPi++EAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qPRNYb0sC++670C1j23bHbZfGMgnyx+Hxu/tlbFuuW99D7L361JRmyI+YTOvvvt70eXrFR1IPGFrU9w/vfxR7vFnCq9Vl/YBpyZZtt8n7wN32zwSjvMy0CyiA/xQXAlps6mpUFVJZjDQJdlzD1EavTXAMLcAswV+p2CnnbLbLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJ7ngUhg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=snZdCRfU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767093557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7hrgwbUeI2Nj9FtXzSGQZOICXYg61l+/KAfCDFoCa4=;
	b=eJ7ngUhgr/2M1jFbMnM5FW/AsIAvBS0YcJ8ZFYV2Lbkg6vo/HW58ySMxry8SAUq9y3uT4a
	0VCkx/iGR06r6FfkMc13MaZr9C8oyV9XRya83tkWCNAYvSzv9nVclDYJR3MOgiQdyzI2aF
	QRtYt+585g+h3pLmduf9hERCflNgzDY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-HLmAKoaEM9O0WXPCBQlyDQ-1; Tue, 30 Dec 2025 06:19:15 -0500
X-MC-Unique: HLmAKoaEM9O0WXPCBQlyDQ-1
X-Mimecast-MFC-AGG-ID: HLmAKoaEM9O0WXPCBQlyDQ_1767093554
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4325b81081aso5287501f8f.3
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767093554; x=1767698354; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7hrgwbUeI2Nj9FtXzSGQZOICXYg61l+/KAfCDFoCa4=;
        b=snZdCRfUVsUHphYv98uC/JZ7JVnfg2MrFWG0Wjphl/mIy9KICo13rujevSNchV8kMb
         J3FY85tzHN4rfWJfiTSqqb7IkE5nbLqxH6RCRmiHfqJJgoPcZXElZqnpq6pJjdbsxLa9
         tgjJpgCgLyUCsFwBpGFPgXNVSAEjEbT/Jv8icXS/tWr/+emX+RnvS8EehwoqImYtMp3p
         ahQnX5CJ1BiqZdT3tGkQJaA/LMEYoAgrGnShvgSx04jsnTpND2rV7gMDfWL9juKahJRz
         PqW4JSUOTUi/JpslFqHBgN3EMs6i3GQDQhh2vJ9sppavi/DmUrOw0RVOaTrM78rrOelG
         lgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767093554; x=1767698354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7hrgwbUeI2Nj9FtXzSGQZOICXYg61l+/KAfCDFoCa4=;
        b=CkIWbReb+Ieq7T4UwtHho9bQzaLxJKkCQTTdgujOZRuIQuLQK53/zx0Fnc1kopMJQ6
         z93KC+hWJVNPYqXCB7GmQL7B97iZihShrNmfQmmaRiF5cAWglysotxscqXEQePmXiDF5
         dpZ3lqVfVVRc8L8BmAEy4512n89mk7r5ubL2zw2pc6w+tsVYHxGzr1pSiD6dQdy1gED7
         AfepqaBYWMHBJSOeHNTOmsyVsvl9sTJjQ2WzEB1cZ91hSA/HSlS74ouhsW0v3lInoadq
         zT+ImnQFCcJTnfdE9fp/5mCBWpEyZAdlLtAvhBRoe9Zh+ypcjk8L9k3oMtm8BsuwPZzH
         7H5Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4sDYF1EpZfdTrbjlbOAMPBqNjICT9BThGt4FkGQB3+z9HDqb4gKYYr8HnOlcjxoo8Spk3/DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAzWYFdCDx+Fx5pH9Aje9gYXDWZfckux5/d6oBfykPjUfBLkG
	BiJzS4qeQYd/x+bAjVpEmy2a/yJB0iKsrp6V6FjpiclHI2nxohdGB1KH6IWdm61AsKvC4A+bDo7
	lIAXeneb1VYxJv9W8zEO1dtk2sW+vvdc7w/5irsZy2mg6xqu1LH7CzD/G1w==
X-Gm-Gg: AY/fxX7YUhfEKzhSYSeoqYjyfHEKp48Hd1psBTHkIvbR/6Bn2YdOSl7eFQtVbMZfKkp
	zwWxuipOYJueeS/QIIsdz4Vr+MqscJKuIlDMNl638GK51w+qSTGoPZE+YIpxeoszpZ+g63gCSve
	fO9rZVu8e4nETSm+Rm642OE5t8ODk2aC/Oh963L+dow7VKfBKmrK3ENAKJB6uk1m+y8yE1Y9l4K
	lUkSEC7ERTn4kRYvzXkn6NePBhjNWGS+yVqBb93C7OHAyUW1MF2/o4w8ZaPvW2BeZL/plUeL53h
	F0j7Drg63p67rHcBq6I1rrAQYhCRRtVHNEgw3/DKhNRjsaIOypQ/3uwWSbwXbv+FV/sR1bEm7Sl
	JLHKzfE3Cd+dC
X-Received: by 2002:a05:6000:2285:b0:430:f5ed:83d3 with SMTP id ffacd0b85a97d-4324e4c70damr45678307f8f.5.1767093554362;
        Tue, 30 Dec 2025 03:19:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHboRnDVzmL21EwUlm2sk+VKxBUKVEIOYW980hh/unpcMdOb28kmZ5YH4pTgiukG05Lr4ZGvw==
X-Received: by 2002:a05:6000:2285:b0:430:f5ed:83d3 with SMTP id ffacd0b85a97d-4324e4c70damr45678270f8f.5.1767093553933;
        Tue, 30 Dec 2025 03:19:13 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1aef7sm67972803f8f.7.2025.12.30.03.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 03:19:13 -0800 (PST)
Message-ID: <d3c7fad0-2c59-46cf-a1df-72f4fbbbe666@redhat.com>
Date: Tue, 30 Dec 2025 12:19:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] net: wwan: mhi: Add network support for Foxconn
 T99W760
To: Slark Xiao <slark_xiao@163.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: mani@kernel.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251119105615.48295-1-slark_xiao@163.com>
 <20251119105615.48295-3-slark_xiao@163.com>
 <CAFEp6-23je6WC0ocMP7jXUtPGfeG9_LpY+1N-oLcSTOmqQCL2w@mail.gmail.com>
 <4c4751c0.9803.19b3079a159.Coremail.slark_xiao@163.com>
 <CAFEp6-2NBa8tgzTH__F4MOg=03-LO7RjhobhaKHmapXXa9Xeyw@mail.gmail.com>
 <703d68c0.93c7.19b6ebaa741.Coremail.slark_xiao@163.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <703d68c0.93c7.19b6ebaa741.Coremail.slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/30/25 11:08 AM, Slark Xiao wrote:
> At 2025-12-30 17:50:39, "Loic Poulain" <loic.poulain@oss.qualcomm.com> wrote:
>> Hi Slark,
>>
>> On Thu, Dec 18, 2025 at 9:01 AM Slark Xiao <slark_xiao@163.com> wrote:
>>>
>>>
>>> At 2025-11-21 20:46:54, "Loic Poulain" <loic.poulain@oss.qualcomm.com> wrote:
>>>> On Wed, Nov 19, 2025 at 11:57 AM Slark Xiao <slark_xiao@163.com> wrote:
>>>>>
>>>>> T99W760 is designed based on Qualcomm SDX35 chip. It use similar
>>>>> architechture with SDX72/SDX75 chip. So we need to assign initial
>>>>> link id for this device to make sure network available.
>>>>>
>>>>> Signed-off-by: Slark Xiao <slark_xiao@163.com>
>>>>
>>>> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>>>>
>>> Hi Loic,
>>> May I know when this patch would be applied into net or linux-next?
>>> I saw the changes in MHI side has been applied.
>>> T99W760 device would have a network problem if missing this changes in wwan
>>> side. Please help do a checking.
>>
>> You can see status here: https://patchwork.kernel.org/project/netdevbpf/list/
>>
>> If the changes have not been picked together, please resend this one,
>> including tags.
>>
>> Regards,
>> Loic
> Hi Loic,
> I checked above link and didn't find my changes.
> This is strange since the changes in MHI side of this serial has been applied, but this 
> has been ignored.
> BTW, this changes may not be applicable because another change 
> https://patchwork.kernel.org/project/netdevbpf/patch/20251120114115.344284-1-slark_xiao@163.com/
> has been applied. 
> 
> So do you want me to resend the new changes based on the latest net baseline ?
> Any serials shall be assigned? V4 shall be used?

You must re-submit this patch, targeting the net-next tree (the subj
prefix must include 'net-next'), but please note:

## Form letter - net-next-closed

The net-next tree is closed for new drivers, features, code refactoring
and optimizations due to the merge window and the winter break. We are
currently accepting bug fixes only.

Please repost when net-next reopens after Jan 2nd.

RFC patches sent for review only are obviously welcome at any time.




