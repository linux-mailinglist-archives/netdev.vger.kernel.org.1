Return-Path: <netdev+bounces-246446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AED9CEC633
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 18:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB54B300A85D
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6F28505E;
	Wed, 31 Dec 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhEA8nbn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cti02kjO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A12A1DE4DC
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202575; cv=none; b=BvQWOfrD9FYq2TA1ulnkQYbO7qU65hdsWW7VoQ+XrAuDJvIcwhxDkm5cC/YfFt7LBPgwSr2Kx0I0uMjV58VgkQlZxcWXrIRbFLJczrwft/4qJmzlaUYvrHN8UyjdQ/MJfT/GMx5+NRYx2FDVh8vnAr9XLgbVfUUOUjFK9kWswOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202575; c=relaxed/simple;
	bh=Umu9Z5T6MB1JXXj1jGYkaLwvHPYFQEVFOey4XNHOi0s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KM6zim0ZWW1rsyhq/ByAwfUcMSzuPELJqIBEIOORzH9ZagHEla4w3Tm2CytwRrF/CGCxhFx8P12uHjUl0igziZ0wl/pzO0rYuvJA0eezODOlYiZd8Iay3T0HyTOsthBuvFMzggaLDm9+uKyZefiEu6WR3MoBtDB8ZY7cumwiLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhEA8nbn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cti02kjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767202572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
	b=HhEA8nbn9UWwWoZyM4JqS2xnw6abFiB3ahOgYCASsH26V9WIniV0Vle2XCqMRzfaYJHiLv
	AKObA1E2/qtWVYmjow65o0FuGw3s31FzGanA59WBdOUlOmjkcyIkSNlevS5BEs0yddbKU9
	ymbSaJFatceRe/i1Mgn/DvpVY/LSpYE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-kXls4H06PIaH6jEsmoxBrA-1; Wed, 31 Dec 2025 12:36:11 -0500
X-MC-Unique: kXls4H06PIaH6jEsmoxBrA-1
X-Mimecast-MFC-AGG-ID: kXls4H06PIaH6jEsmoxBrA_1767202571
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso18267132a12.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767202564; x=1767807364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
        b=Cti02kjO/vgsLYU4FS/iI8NjqcKbjB56kjURtridVO3ayOiDjBxg8pdBjsIisF/WOh
         xqXbYXyJON1ojfFoxF6BtzA6LhBZ/hJAHFmCUyaoMGjUXq/A+1BBiHwmsy2yt5Gfvo4T
         B2D50vU6f9233HSk9+dJiEBbBUwXG5lre/xfzhN0/fKMdYinzINCUIJFROTydHoxPKmB
         z11gigJEhjmgkv7BMr5JuHzYLCEF08iqkAtP03sBME6qtMho30QosEKBy7pq8zJQ6Rch
         2LfHjkuaQcxejJwGs3De5GLlYtFHU8im9mIlKcHSriDMWjhTRFvmBzAEq1xKzaXPDB++
         asWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202564; x=1767807364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
        b=DNRPI0EoCumTW25Gg6A9iu3+MvihXiIrR8rIcIDrEwnscoTy5I74iuuWawJ/RZsCCz
         jWIuN0FiIqU7+ltVLUIsJ0hT/+3HC53hQ14TWUIYSuJ/SAHiTrtbyO81vtwMCPhKG1/4
         BuDhp51bLlIjZCSi9wNtuhaqdw+lE7e7QmCVvjxcnYLYUn36mxZ35C5xr34CfSiFMroD
         iDXDVtBKZy7HXqQbxukHR4aTf3Ol9jizvTPA4ssF5J4eDciwBEwCFnCadeu4HBHTeoVP
         wqKoL4ILznUWhvMpsbiUcT2IdZASYbD08G9/PglDNzhpczgvBUGM8OI/WLBMeW037r4A
         mLEw==
X-Forwarded-Encrypted: i=1; AJvYcCU5FzO0I0twHVmfC3m19Dnf0IRK9mXjMIgOZH3IkPPq8DGU8OmE8+hK/izz3p91sE8vYE5k3lk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59ylpb1K3a37fGHT8ImnAwk2YfYxXGjYQZkGSZkOp1Qstr79t
	5lgyu1OJEUAALzyy6Fi/tPtvUeHheIro8LiZwwmmYjtAWEhp6HxXF+UdSTT5QC8RZ+n7qK8asBe
	DHFVZsJiA7pogeAIE+ZLtJHChz0sie5od8oWFNFuLJHqk7ps5lZcISE/p2Q==
X-Gm-Gg: AY/fxX7f2IstsDLo98bsxyQSIajoOpQFoFBal2lrW7lq0COhtfZw+gSn/94/nU5vCNm
	VsNBcvqjb+Yt+iB7t1qPYOO5zgnjB0bjdQ1elt5VBN6yqhIdYOhAROR2HFYH1KXv7Yd1SOQwCRT
	CyjzIn2qCIRxElUY8R4Y4kT7/RiX+q7Uz3cOmFLEcfmunlrY5ViBv/jdvONdulDA/ldKUSnaAlF
	ReCYRGGshNozrSXebjEtoWsIRk2WhMTHJv60Hc4ZakQz3mAfE6YBhbRiIkVpirmZjlSVoA4wmbu
	UIVno/Sagnbe6faElp/v+ujYTruNZbBjscG/kbtOreaIMymsYJIazA7HYXiaDC4y0VMJrnHhJsr
	91qrwt96NRhJw+asqgHPtWy6FGtt7vULqLuqkFTG2dqFSdfEJ
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr33784145c88.2.1767202564075;
        Wed, 31 Dec 2025 09:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi3paBF328Dvc54FaF7ePmfKoOt8e8CqfUvXWomZaBGFhC0nmzfA+IqOZP166rR45yxweuTA==
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr33784129c88.2.1767202563623;
        Wed, 31 Dec 2025 09:36:03 -0800 (PST)
Received: from [10.61.55.87] (syn-184-074-098-043.biz.spectrum.com. [184.74.98.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm87792829eec.3.2025.12.31.09.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 09:36:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f4228e20-62ff-4701-b6ce-59c99188d7b5@redhat.com>
Date: Wed, 31 Dec 2025 12:35:49 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] doc: Add housekeeping documentation
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-34-frederic@kernel.org>
 <370149fc-1624-4a16-ac47-dd9b2dd0ed29@redhat.com>
 <aVVAfb2eaeyd7l-h@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aVVAfb2eaeyd7l-h@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/25 10:25 AM, Frederic Weisbecker wrote:
> Le Fri, Dec 26, 2025 at 07:39:28PM -0500, Waiman Long a écrit :
>> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>>    Documentation/core-api/housekeeping.rst | 111 ++++++++++++++++++++++++
>>>    Documentation/core-api/index.rst        |   1 +
>>>    2 files changed, 112 insertions(+)
>>>    create mode 100644 Documentation/core-api/housekeeping.rst
>>>
>>> diff --git a/Documentation/core-api/housekeeping.rst b/Documentation/core-api/housekeeping.rst
>>> new file mode 100644
>>> index 000000000000..e5417302774c
>>> --- /dev/null
>>> +++ b/Documentation/core-api/housekeeping.rst
>>> @@ -0,0 +1,111 @@
>>> +======================================
>>> +Housekeeping
>>> +======================================
>>> +
>>> +
>>> +CPU Isolation moves away kernel work that may otherwise run on any CPU.
>>> +The purpose of its related features is to reduce the OS jitter that some
>>> +extreme workloads can't stand, such as in some DPDK usecases.
>> Nit: "usecases" => "use cases"
> Are you sure? I'm not a native speaker but at least the kernel
> has established its use:
>
> $ git grep usecase | wc -l
> 517
"usecase" is not a proper word by itself, but people do use it some times.
$ git grep "use case" | wc -l
694

Anyway, you can keep it if you want. It is not something that is worth 
arguing for. :-)

Cheers,
Longman


