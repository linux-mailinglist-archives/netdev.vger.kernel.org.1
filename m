Return-Path: <netdev+bounces-221362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CFEB504D1
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35ECD16845B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C67322A33;
	Tue,  9 Sep 2025 18:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="oN6Uv685"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF316911
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441060; cv=none; b=tEnbbdHfkSK0rbZ+oONs5LgCvM/Nl8LpYstiWyF7eCZJ24ifPxJcbLwH9aPj2UtGbm5tMWMP+kzaD09hLhChu78NAaTNFN/xCZ0PLA/IyXaf4kk9DaACSLSnz7/absYkUQIUfLf8yUufwyjBTMRE5IbKpdvcKQ+pfBg62HCrF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441060; c=relaxed/simple;
	bh=t3ogoGwsEbOcnF5MtnKBQx4qwSAUc3CpJnoXYCI6bn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H657Ps0tOcvPUIw6zYOorUOZbIoaEV+hzewxRMHCjO6lwzIED3EbbACJAW12b5yBeKcDxKIK0PJtM/QiVfwz1qYhYQniaFj1gAZvZgpLx2G+0/cvq/YRmPe8sQBInUoF9f4UVf2P5R/2tnBI22aH2N/JgBcRhnkyiWmIuNB4uYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=oN6Uv685; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55f6ad5146eso5547424e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757441056; x=1758045856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mWafMalxy8wlFhvbjLhYh9NfOkuAzkFOgJG++XNgQE=;
        b=oN6Uv685UPfB8gWZE8GzBLT2aFISIiVbAkync7DzbQvYrugqDJ3FI/H/IFiajRXwNW
         qGu0ffuFAaCldV5+JqFttec4BWOWr57lGT3vowbke/yPngSpzj0YfZ+uFwFVjYqNZCPL
         TciRtZyPo4tIbW5cj4O5Sp12YJ+FIS4kLYlK79H94P6dW+45Ni+RWtLTc+ieOxNP7MSU
         KO5nDJuH68QNJAgVhHr6kKT2LzYx3JJX6PRzoOa1rPBjJsp9xBLRhgp83r3bqTouOu78
         u8b4i/9cQQ8difebaBtRxM2h7qDvzrGGB7UMRQnA6wA2TBCXlHFTA5wgY0+jyQ6/h8vp
         XXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441056; x=1758045856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mWafMalxy8wlFhvbjLhYh9NfOkuAzkFOgJG++XNgQE=;
        b=MnEq8xgf0sKIBs9ALaPaJaLyKSSGehYEPdh07modfuHtYlMeTgZSDppg6uTJU92s4L
         PdJK+SB5D6jvQLeqILHxcOZgSG9YZCcMjP/yofcGv9XSiV9EbCRN1FWtzoCFAhX129tI
         c6ndQs+PJGCah7IP4zQ/QydMA9CaFYoYnKq551AcVaxswkE456vujeKmT83nhWNE+kht
         4o2+Woyoqcs7xtsgaf2jDwTIyqEvP8k2Ea2iJ8C+BMgewRRMK9mR/bjDVdcF61g3vhar
         yR5YY8C+YNdKf2fzAnC86tbfE9wnk6gB7rVRfhrbvZzSTHf5l6P1tfyozEehh1DIeGR3
         Vazw==
X-Forwarded-Encrypted: i=1; AJvYcCUO8ErRZgK0Vu6srDS3I1SdCbmKBHf6Pi3pK0tEEFL3scpsHkRjWMCPUMEughhABwVd15hlZjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYd74loIZca+WSki3wKGgpkg3Y71VThyzgvWIUIWJSHYUCeg+B
	nGCTFgrsPhIdTRr2/Qi+Xarva9PhyiGbgIp3suL5lRFLNzFVKKpDNcgAtIBePr43UyfRvBZPVSE
	QpA3oAXU=
X-Gm-Gg: ASbGncvLuf1iaiL+B9t5fLCdME3CrzFjT/3w0Y23PAeBINgu3dol8ngqqO0IGmtcWF2
	42uzUsuMOcTcQdWLrhSktMfo1z7Ink9XrrXTU1tk1JpibJR93xOBb5hAAUicXi6DPPUURc3T1wg
	OxBD49wt8ErqLfrEwDAi4NI3IHIzqXdPyJ+C4Pr9DU/XnC6pOrPNQl6BdLtPYJKEAkaWxss7/p3
	BlzsfnIy9sMCugRIE+OwuIDrUH/CuHLMD3upkDwbGlyRYAwxGVMoVacQPv4/21mBZl4vpw4mDiz
	K72UAJ45iuL/KGIXIJXxzYFf2v7w79WylGH/IQuG/W2eHTrcKjcGkV/Up34ogSBIfa0jlmZyuLJ
	7XH5mkPOfwLNhwJHu94iLOy0CpoXg/2noLPO7SQxmwyaP2ZKPmnVZoMhCr8EVyUugLfINnuFsXT
	hJrw==
X-Google-Smtp-Source: AGHT+IFLKXXysXcQom38PnJvRWBySHQ8xWVUiuVQVjh30YG9bS3tYptEZfDy/BNujJBJFXXkYttkCg==
X-Received: by 2002:a05:651c:b09:b0:336:e15a:25da with SMTP id 38308e7fff4ca-33b5f38f065mr37952451fa.39.1757441056073;
        Tue, 09 Sep 2025 11:04:16 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c4ffd5sm39016961fa.14.2025.09.09.11.04.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 11:04:15 -0700 (PDT)
Message-ID: <e9291d48-dcf9-405b-8246-1f44544c2e6e@blackwall.org>
Date: Tue, 9 Sep 2025 21:04:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/7] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
To: David Wilder <wilder@us.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "jv@jvosburgh.net" <jv@jvosburgh.net>,
 "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
 Pradeep Satyanarayana <pradeep@us.ibm.com>,
 "i.maximets@ovn.org" <i.maximets@ovn.org>,
 Adrian Moreno Zapata <amorenoz@redhat.com>, Hangbin Liu <haliu@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "horms@kernel.org" <horms@kernel.org>
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <9a0ed3dd-d190-4d89-9756-9b36976665c8@blackwall.org>
 <MW3PR15MB39136CC2656428F35D2CFD6BFA0FA@MW3PR15MB3913.namprd15.prod.outlook.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <MW3PR15MB39136CC2656428F35D2CFD6BFA0FA@MW3PR15MB3913.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 20:55, David Wilder wrote:
> 
> 
> 
> ________________________________________
> From: Nikolay Aleksandrov <razor@blackwall.org>
> Sent: Tuesday, September 9, 2025 6:54 AM
> To: David Wilder; netdev@vger.kernel.org
> Cc: jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Liu; stephen@networkplumber.org; horms@kernel.org
> Subject: [EXTERNAL] Re: [PATCH net-next v10 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
> 
>> On 9/5/25 01:18, David Wilder wrote:
>>> Changes since V4:
>>> 1)Dropped changes to proc and sysfs APIs to bonding.  These APIs
>>> do not need to be updated to support new functionality.  Netlink
>>> and iproute2 have been updated to do the right thing, but the
>>> other APIs are more or less frozen in the past.
>>>
>>
>> I'm sorry I'm late (v10) to the party, but I keep wondering:
>> Why keep extending sysfs support? It is supposed to be deprecated and most
>> of this set adds changes around bond sysfs option handling to parse a new format.
>>
>> IMHO this new extension should be available through netlink only, that is much
>> simpler, less error-prone and doesn't require string parsing. At worst sysfs
>> should only show the values properly.
>>
>> Cheers,
>> Nik
> 
> Hi Nic
> Thanks for the reviewing my patches..
> I did originally extend the sysfs to support the extension, but dropped that support.
> The only remaining change related to sysfs  keeps the original support working with out
> the new extension.
> 
> 

Ohhh my bad, I need better glasses. :) I read the cover letter and saw the new format, missed
the part where sysfs was dropped. Sorry for the noise!

I do have one comment, but I'll add that to the respective patch.

