Return-Path: <netdev+bounces-171370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D336BA4CB17
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 19:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B421896449
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8124F20FA85;
	Mon,  3 Mar 2025 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="M09gxUM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558D20DD54
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027174; cv=none; b=n/jUwDSU0yulJEmkNVGMTOYojjITk4dd8IwOge/RJrF3+xKCAFhV4S4oeH1ciCTRcn3vJMo6U1b6O053ljvqtDGunFwYUxS+V/auzChKm5MFimLeKb6nIzxnTN7h3r+/NW92f9mBXbs9VtptEjL8DMO0JpxJVOsccleO4YjjuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027174; c=relaxed/simple;
	bh=znGyjoh1i+0MiNkFFGxOWQzln4M09SO8G0cb84uYR2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHOCItqArvT1A47DVHaZbCuiNdR/5NDpzXEPOD1+CigqDLmg2Omiy15k2UtVbfbH3M74wvDtf3FcfTjQpvD4Qv/qw/82gCMj38B1ESPlBHFPoqySy+oIhAeh9hUBhbxnyxoWYLR3VfDV5hIXu9e3xwZJ1OKUy3IlRkgk9GpAm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=M09gxUM3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2235c5818a3so54105035ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 10:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1741027172; x=1741631972; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QWcQCnohAW1QZN6tiIPZA9hwMP/L8UyX6cpB0fsWP3M=;
        b=M09gxUM3MgPWa5yM2/xQeGqb/vGevR4vFAIMGFWaj1wbVb/coFMpQLkSgfUH9hv/vN
         89EpP5hNHuvYV2EW0P8VXqeMKcCmnV7L7bq/OIzkc7wN6krd27Q8oGQA6XGr7ISk9xSB
         zmBCCvVg4oBgwbYNWSvCXlNJarMxEjjK9ihyfcHFy2ryh/eGZM4QHM3zBdOgDLIh86VG
         BZl7FE4UH1e35HH1dby0Jk8FM1gAm/vyGSzNs2k1ZxS8zYdySsfpQQ4ntiuGPiV4Uaof
         wbS6j0jBmFRMELJu54rYWazxgMEt4x4aYnT3yHtJqYc7SGMrURkgtOYVZ8QVwULs80oO
         mEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027172; x=1741631972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWcQCnohAW1QZN6tiIPZA9hwMP/L8UyX6cpB0fsWP3M=;
        b=kDkJUEnPrgljA2ut32s0yYdnBby7hYeUhx3olv1DzO/6Ia8VXklJMOZ/uK+T7Gi3Bh
         1fcpl08tQ88U9WIEITx1P5J3iFJ8egc3qxPceptSdvGot0rxJudlQMTcoJtf8Vjc8Kxr
         QTCbLvg9JllDq0sdJIcpEWIczaG+xPR34f1/yi2znAsEiNhbzJMqy+sh2yBvVEMiaYG4
         Q8TMPXWezLhbncbysyAK2seJrQ9qEXo//+/R3UXdCxAN6IIqtTJEnl1lIOU9ISC8OISs
         VGDq06xg4g8VfebNREJJT7tUPnw2mWPcBY5KL/gFS6gprl1f3U6c8T2ZVpcYAtGbCHlc
         E3Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX3tgfZnEcil8LnvrbBzY0fWBLFGHk5ga35eKPSEv7ghiTmi7xDNQP/yCUxga5xmmRFzGlV/F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnNfBOAtkc53h1Zva6G+WjrsV8QY0TuErRXMzOJrZOR+9xrgZF
	p86yLqwygXM+Q9tlt+1JD4sMIeDY43Q61wNesA2Tf6UDmk9w9Wlimwfl1H5aXg==
X-Gm-Gg: ASbGncueHGnDCiBKUOkvasXJoHV4O5R1XifsXNku7IbaGQb/mN5ABXOomOhJmUKnBPR
	t5VxrXbxNKXE27A78Rxwp6ySrxYZxOZxYtoXhiDF32ymRBtkK0UCBIeuyhlXmd8vFcW1e/JrG1T
	s1ClbbOHOBwiO52oPSy0u1U3PPE2Jh1hlLt7HoY80NLE9HXHJfykhPloVxEoc+yq3ZmVxl4hYqz
	Tia2SBM2LoRauO7dZbEdXuRDm7TrCX3GE8xXBSyIdVywSB530SQ0Zrk+IPnJFiVFaGBuS/MD5te
	5Jx4JBvq6UPyESkvBpFJJolrJIkub3cr7bsJnSkwYnIHOoQcOfFDtw==
X-Google-Smtp-Source: AGHT+IHAF/uO1KySV0Rb1OWMO7D1BDS1ZIQc8t0w9Ov/CQAdYMus0dJWwt7u7esnAwV/azSFxg5TXw==
X-Received: by 2002:a17:903:2b08:b0:220:e1e6:4472 with SMTP id d9443c01a7336-22368fbe982mr184758795ad.13.1741027172198;
        Mon, 03 Mar 2025 10:39:32 -0800 (PST)
Received: from [192.168.50.25] ([179.218.14.134])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fb004sm81161115ad.64.2025.03.03.10.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:39:31 -0800 (PST)
Message-ID: <a377cac9-7b86-4e13-95ff-eab470c07c8d@mojatatu.com>
Date: Mon, 3 Mar 2025 15:39:29 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v3] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
To: patchwork-bot+netdevbpf@kernel.org,
 Jonathan Lennox <jonathan.lennox42@gmail.com>
Cc: dsahern@kernel.org, netdev@vger.kernel.org, stephen@networkplumber.org,
 jonathan.lennox@8x8.com
References: <20250226185321.3243593-1-jonathan.lennox@8x8.com>
 <174075783051.2186059.10891118669888852628.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <174075783051.2186059.10891118669888852628.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 12:50, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to iproute2/iproute2-next.git (main)
> by David Ahern <dsahern@kernel.org>:
> 
> On Wed, 26 Feb 2025 18:53:21 +0000 you wrote:
>> Currently, tc_calc_xmittime and tc_calc_xmitsize round from double to
>> int three times — once when they call tc_core_time2tick /
>> tc_core_tick2time (whose argument is int), once when those functions
>> return (their return value is int), and then finally when the tc_calc_*
>> functions return.  This leads to extremely granular and inaccurate
>> conversions.
>>
>> [...]
> 
> Here is the summary with links:
>    - [iproute2,v3] tc: Fix rounding in tc_calc_xmittime and tc_calc_xmitsize.
>      https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=d947f365602b
> 
> You are awesome, thank you!

Hi,

This patch broke tdc:
https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/17084/1-tdc-sh/stdout#L2323



