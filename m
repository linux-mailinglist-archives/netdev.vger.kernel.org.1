Return-Path: <netdev+bounces-95166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0DF8C199E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C993E1C218EA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39A912D20F;
	Thu,  9 May 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TpMvt0Rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124B86245
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295451; cv=none; b=GZJmm9OZ7ca59IKYvYzD3FHRpPUwbknRYtcNEZjKh9Go6WCbNg36Qot4yMNU3x0z2GUQEgoeYzvh5ar2s3kr7tA8XeX4w6CyKrwxjNWnsh1MPLoqHN+NtuK4d1xZwN4xcPLD1UARFe1Rniuwup7wsFg+Pb71HIaZHXq4Hw4ZmNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295451; c=relaxed/simple;
	bh=uiL7tsWYwrlh7fw6jqps72CQNxzNakd76Qcq3x7pifU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSosWOApPjngS4ILXPtFGbzS7arBGAEo7LoTxaEePg+PQN8SxE4Y5w2dIKdMG8WCn/W3KWqF7inPqOFnDm+IFs1D+i7zQWYI5uoVBUUjIcA8ZeBuQI5XajEaOxA45wucfJQRdPEPaKAFsM6MOe0ygHO+me338m1OduhYeapW+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TpMvt0Rk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so1190670a91.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1715295450; x=1715900250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilb5Zzj/rMc2xfxLCKhyEqQhug1Rqb3YSQDWbnIpur0=;
        b=TpMvt0Rk7EPdP++brMqlFjTX1QSsJpbQxmH6kghKNIg1q7zqRxaTeli63AZkVhL8no
         woIKbUxcxq3YVNwdGux4jTc2RGq5bXanosKUXHo24E6nv3wXsARh0CADvEeafgl8KKL8
         sAgQ7v1y+rvYAU1R1f+tuebjRsvow91U5lo3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295450; x=1715900250;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ilb5Zzj/rMc2xfxLCKhyEqQhug1Rqb3YSQDWbnIpur0=;
        b=u22lx5Ime3F0zydAQhO/5U5h8A+akcbpcdHMLQBJ/ymFCd0a4AvILp2/VGkKBGs4HO
         CsNLBMJ9BPhHLcVuplm4+LjcZhLEPjqTbvV+4DliSzPRyLvWU6ShbGhYTxr2DsWgSLhJ
         K50GUOKv2FHibMVvYK/igaglCJ5363VEnG7pzhsLftUS/FIyvv5hOjO4tI8HWEX/oLin
         PkYScx0x0B1HW5AlijeHC0OUhegJl043JJZh3wCv4Gct7nTdcXFhQz6nJbt1APEBYdLp
         KyDILO2V7sWPIYY9GTQ9rTBwZEFrJMlHGxLlTGPERNYPHoMpxVyI2IH6RjJk2vJ+G8YM
         0mBA==
X-Forwarded-Encrypted: i=1; AJvYcCXHrGvjpVnQTJ+E6czo+DHuNElwTUUZvDgCvK/4i29Me1/wF2IOiAKRnSSJVu0pNI7dwJXA1pLh0oLOYPIIfJ5LR1i9alrV
X-Gm-Message-State: AOJu0YzXkgmZOD0BiFCLBpDwdVob8oECfF3n41LLUU8y28ETvaL5PFM2
	qdnyzGRPpphLTRjK/PS2ACJlaeMg5F2Uc8+keeo5sObU2rczZ+wU/bp0x7zAow==
X-Google-Smtp-Source: AGHT+IH5vOP57x3V1CiZy66ayl1ctIudQSQY6XNjhzRbK0HQXXM6WPYJ1nKRuqnzXEdfc1QIL40KYw==
X-Received: by 2002:a17:90b:2252:b0:2b1:8210:56bb with SMTP id 98e67ed59e1d1-2b6cc342e4amr894347a91.3.1715295449675;
        Thu, 09 May 2024 15:57:29 -0700 (PDT)
Received: from [10.62.14.240] ([128.177.82.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67178353bsm2016548a91.56.2024.05.09.15.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 15:57:29 -0700 (PDT)
Message-ID: <53ff9535-d4cc-4d72-9e60-f43aaba5485c@broadcom.com>
Date: Thu, 9 May 2024 15:57:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/8] x86/vmware: Move common macros to vmware.h
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de, x86@kernel.org, netdev@vger.kernel.org,
 richardcochran@gmail.com, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, zackr@vmware.com,
 linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
 timothym@vmware.com, akaher@vmware.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, horms@kernel.org,
 kirill.shutemov@linux.intel.com, Nadav Amit <nadav.amit@gmail.com>
References: <20240505182829.GBZjfPzeEijTsBUth5@fat_crate.local>
 <20240506215305.30756-1-alexey.makhalov@broadcom.com>
 <20240506215305.30756-2-alexey.makhalov@broadcom.com>
 <20240507091424.GUZjnw8ErpQT6XJLVM@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240507091424.GUZjnw8ErpQT6XJLVM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/24 2:14 AM, Borislav Petkov wrote:
> On Mon, May 06, 2024 at 02:52:58PM -0700, Alexey Makhalov wrote:
>> +#define VMWARE_HYPERVISOR_PORT		0x5658
>> +#define VMWARE_HYPERVISOR_PORT_HB	(VMWARE_HYPERVISOR_PORT | \
>> +					 VMWARE_HYPERVISOR_HB)
> 
> You can't help yourself not sneaking in any changes which are not code
> movement, can ya?
Indeed! My fault.

> 
> The purpose of a sole code movement patch is to ease the review. Not to
> have to look at the code movement *and* some *additional* changes which
> you've done in-flight. Just because you felt like it. But which is nasty
> to review.

Agree. I should not claim it as sole code movement then.
At least moving macros from .c to .h file requires changing 
vmware_hypercall_mode variable visibility from static to global.

If you think this type of changes is Ok for sole code movement patch,
then I'll continue following this path. Otherwise, will change patch
description.

Thanks for the patience.
--Alexey

