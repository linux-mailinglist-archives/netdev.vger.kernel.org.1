Return-Path: <netdev+bounces-189021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7618AAFE81
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51A07B8C50
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7F727FD41;
	Thu,  8 May 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMSpJTWO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783327FB2A;
	Thu,  8 May 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716723; cv=none; b=GcCAEHbuxwPSpMPjwzEI22RCr3Gas5pnN+A7Zh1EJIj4ZnBvkELjvHBRcFwiYrE9K9S6HBuarU88ky1BbNwsjLRI5vE1b1oWzPPbCoH+vjgFB1Bh11j9vWD+x+vDH2hLr2X2wagPHLtKnxSqrHnshN7yYpynnnax631xZIQzbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716723; c=relaxed/simple;
	bh=UqIl0ZTfwvEolFknU9+0wREPqC6dPl30bx6eEd3N0yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGDs4nmB3IcppUG6JpNDb/NGimECEzZ2PxcFaQmGZr2sDYBGQB8lmjrVuoiTOv05XVZWJWs7P6lRRnqFShfoI+VDBLfZ9WzjT0PgoNgw4iCWvyhMwXwFQTBXIuvpW5HImY0w+dA/gD8NrCdn8FZSt40An3LMsRiO01cddKIWjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMSpJTWO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso7746425e9.2;
        Thu, 08 May 2025 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746716718; x=1747321518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5CDz5eo7uoDsMMbUayUErCNRdVz2OGs8+1Uf5yqUlPg=;
        b=FMSpJTWOqDQgcGHJ3rMAmmTRcVzmxEZ06C0nAa8VaNPneWEIuPEx0MDZyIDuTVLOi0
         Ykun36sU3XBy8Auxq96itWqGl/Mh8zMoBQxlR9R4DY3QKEajQaJkrsvLX5RPw9VfQZQV
         MIftxptJg65pbCu/rGTo0uH/iOQw4gSsfVb/qq0gI20y8zfeHHm7e3y4+ZsgqeLEeDGO
         HB+PjOSnVqKFf/GQLHXhVFHR+MEr5FuCKd/ELtsOOCLY1eCF3LmG/4KL+9URr3LfLMNF
         AqcDyXah2duU0wrOmAFNfuUK35upv2dbGG6TAMDWm9YUT3gN5u1/CtUv2gLa6ePBi98c
         Lg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716718; x=1747321518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CDz5eo7uoDsMMbUayUErCNRdVz2OGs8+1Uf5yqUlPg=;
        b=vasIJVA41rzKee/4Ftp8XOvlUAtJvjAbHXYV5vR+DxcIvYIEGQBT8NRI99r5VDEw53
         /BF6GYozT0f5701Pn7Ll0OWTcAchHInjcvWXoX8AgBSHxop3fbs2ekJmL0pU/+xWCuiK
         0xLxciD9cmtv6Lh+c9hzA4EroBUP1X9SjCOEygmtB+aePfvcA91ewfWIRWI5WhzhiAP5
         Q/SVuAhDV0Iv7d7S9v3QcKgnf/AVxG/aaZinqJDe3XybHKIUVIo8iPddPrp3K3KHlfCf
         uLfJUW90Q5d4Trl0eh4eFOfls/pFUy9PCL3ry2d+MSTyEZvMlmnufXVkxXvzyEu02fal
         jxkA==
X-Forwarded-Encrypted: i=1; AJvYcCVOISUnCeCepHc0ZxMyOzo+UB1X1HjJ1/1PTZ5Q4z/jvFHuO4yPZOkJQrQ7zEb3Q8imAgogceA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx51A7crLNzK3fAtzWyuLnNZaAUnPS7TfD/gaJJnWOCFdq+4pU1
	JLPArv2etA8wx9+C54wNJVZ8uNWvPH7SBvBsX8MUrLBrulKn8jLI
X-Gm-Gg: ASbGnctUo/nGjFnTa5Y2d+tzCsjBlExa15Ve2zW7zAHdAl8Y4demkfhLFquWBXc+vK0
	aLLwXMZB8f25GcixBkUBF1fzbwzxP3m3Tuk1sAVU3dWUHnX0lUy56z6CH0ZEfMxZ96HkSfkg4Wr
	GE+cAjPAqf3DJX8qPetIBwksIRQMpI7nzEpjgLCzu5JNWGId5an9unk9XYoxCVanGAFRqIV+FVs
	EmxYQntHQxlY2PsayIFTBnGFCTboG3olMNwRcxOKch3p97IGw2e/uNUbhz7ItnjRzRK3IMm976t
	HgMsJjouwZ6QU/ufa/2GMFKGVRrkrr71uro4MgEvomd4eo8loJzCo0TK/fnwabgj8KHxSPk2wf4
	X+w5j+tmeo2CCCuO8WF7bSPuxkmwJ
X-Google-Smtp-Source: AGHT+IEcwO92rNPhuB+PzhIm0rOo25RmAx8pXS/bjiN8pmcD7vUL4xWHihP9AkndBXWlewxk+irDRw==
X-Received: by 2002:a05:600c:8414:b0:43d:7413:cb3e with SMTP id 5b1f17b1804b1-441d44bc65dmr62692575e9.1.1746716715588;
        Thu, 08 May 2025 08:05:15 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd350d96sm39823285e9.18.2025.05.08.08.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:05:15 -0700 (PDT)
Message-ID: <8628dab8-a7b2-46da-9835-b20c7bff3ed0@gmail.com>
Date: Thu, 8 May 2025 16:05:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/22] sfc: add cxl support
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
 <20250507154205.00003839@huawei.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250507154205.00003839@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/05/2025 15:42, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 22:29:05 +0100
> <alejandro.lucero-palau@amd.com> wrote:
> 
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Much as everyone should trust my reviews...
> 
> Needs some tags from sfc folk.

I took a break from acking these as the API churn meant the driver
 patches were changing each time and obsoleting the tags.  Will re-
 review the series now that things seem to have settled down.
For this patch:
Acked-by: Edward Cree <ecree.xilinx@gmail.com>

