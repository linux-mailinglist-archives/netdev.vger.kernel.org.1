Return-Path: <netdev+bounces-192645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED5AC0A3D
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2743AD327
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 11:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CEF289344;
	Thu, 22 May 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bb6UfpyO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EBF221FAA
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911698; cv=none; b=ipPGcec5dU+jDRqZxXawTOZWBSPb5cvBqKWUE+aNmLI5dkIOJJdXbZ5ybiBJPV4JhdR2a4nuoqx/YE4y8YLieYaaNoWasfqlZF0zPfhd6V+iLFSpT4bgGYEJO71IhVWus5ukhbFbgFynZwW5lzbjh0iBB+YYVJPiOFuvB0cifDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911698; c=relaxed/simple;
	bh=gAqncjsS4nRvRmi1gYLfh9vJ5nCE78Oii/HQl+jxbbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/fVJiH20A+ztJXuPAwAzb+BdlYTjgGjVLUNIxWVDlUr+sdOY662aEAyOUuUh40aD11FyYOuq0AKrYfw5aKm5EBMLDtCM1m4dVVSjVXZOGTJVsX2NiJ3Gwobo+1BIE5XkAWvI1RT7Z6ZksnDTSCTnhMJ9wJuEgwGXJe6uy3fP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bb6UfpyO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9ebdfso14535599a12.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1747911695; x=1748516495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3enV2xknpMHN3gRCs0IuDxOL/FDnx1Gi/rcMdQRg/ks=;
        b=bb6UfpyOJtvHqNzMPuZzfc87q2tNarlo9xxJbQ8nz6nwRXw+HBJOyCGpCWg4zEXPtD
         W5EgvD0vgFIYj5SwJgt7paSEHWvdFA/of2uSQ4KLODGQCCUJjr00jH8lnYVqcDXd1ENP
         F01w4WyUsS6VEndQeNJlORld7HlPxcDF7bOIpjAAxGYZEHpBSfPYE/nINZ6ayPEJX2ao
         ru06+FcwYEjUL44exQGirMohlHcja2lHyzyEYdQY/6cgpNx+m7sqbHONRS0YRafZ462O
         uBxeZ5TrfeiS28GbwKm4QbvxsNNze6aU5QnryjJssY6Z0KPSGCaM2rLYoVszBkuYD834
         UNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747911695; x=1748516495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3enV2xknpMHN3gRCs0IuDxOL/FDnx1Gi/rcMdQRg/ks=;
        b=V4JHB0BM/GjBp57Fbx08HQj60qvBq5Qu/Fmk1SmohTdLiWqNhTFY0cWtv8Y5zkVhbG
         S1a0KDIOnafoodFdpDk6lUzPBoPAApIS2EcvfIAy+DQO7VcctPPiH93WopSkcSG0IeKH
         b8RxmbVHLweJvZo5WRCmB6iiIADOhgVow5lPbQ0Bie9l/ZdIc6tkOOvh5frkccjOMHhe
         XbwCkxmx0RrjvWJYDBtHj2guCmmmTTUNwywLPtLIdIRFrrJPCw/uQ/2jtMc40L53TMmm
         UDFs2HKk7Srxq0G16Q2OatTh+oQjQquViwqAFSArG0wc+4mWAofM42OT5F4Szxv5nMSy
         z3Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUUZlsZx3wo43m6zgm6+BP52mcvaZ8t5FmbCoxByQFtKsbSRB6jeAgIjiVYNSqFQQhAyqb/toM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb31uC44QcrSRfbLlhxScAc0KUbyCJFjlWzMigjAQ9hObSJsWn
	7f6KeMAIi1y4+Ke32xQoCd+k2bSRdP5zsIiLClH6oHEEPDoX5azi2SpKq/WIX0MP+0w=
X-Gm-Gg: ASbGncva3vyn+24APWrPKP22031V2bIgnAeWwVSBuktIYgrEmF2VCAOnHdrCUTybkGF
	7i4/py4Q994r02amEV2QxvvTWCT2tutVaU8TxHvymb5MDBKc+2yTghsKaLeyL9siivzqhKTZu4z
	m46c7AJNOF7eXhLkTzT344B/fWEkBEUu4bt8OnwMIkhqrWfizgAHAqhxTAF0SRAZH5j/pLVCEga
	qO5sc7bx5V3HKo2LTlm3jHvpb9EUdLdEtwC9Vbt5ONDKz3Z9godCyiLheocJ1y+sbyJ2Vl1KR4D
	5z4N9IkEaRMJSuS139R2C7MDWP/hfoePCQxjats/YFNT9Jwj1fHyQmeqyscYRLW9JcN9j6hAPOC
	xZpuEKsmOVp2J
X-Google-Smtp-Source: AGHT+IF3np+y1OjyI7Xt+dXZVE2wG1g79uAdoZzvgqzC3k//Lin244xNPPZqlGN3Nk/qNJTJva/Fxg==
X-Received: by 2002:a05:6402:4410:b0:5f4:c5eb:50c9 with SMTP id 4fb4d7f45d1cf-60119cc8f77mr20158087a12.21.1747911695174;
        Thu, 22 May 2025 04:01:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cc1:c3d6:1a7c:1c1b? ([2620:10d:c092:500::5:4cd9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005a6e745fsm10573533a12.48.2025.05.22.04.01.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 04:01:34 -0700 (PDT)
Message-ID: <423fd162-d08e-467e-834d-2eb320db9ba1@davidwei.uk>
Date: Thu, 22 May 2025 12:01:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] bnxt_en: Update MRU and RSS table of RSS contexts
 on queue reset
To: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com
References: <20250519204130.3097027-1-michael.chan@broadcom.com>
 <20250519204130.3097027-4-michael.chan@broadcom.com>
 <20250520182838.3f083f34@kernel.org>
 <CACKFLikOwZmaucM4y2jMgKZ-s0vRyHBde+wuQRt33ScvfohyDA@mail.gmail.com>
 <20250520185144.25f5cb47@kernel.org>
 <CACKFLimbOCecjpL2oOvj99SN8Ahct84r2grLkPG1491eTRMoxg@mail.gmail.com>
 <20250520191753.4e66bb08@kernel.org>
 <CACKFLikW2=ynZUJYbRfXvt70TsCZf0K=K=6V_Rp37F8gOroSZg@mail.gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CACKFLikW2=ynZUJYbRfXvt70TsCZf0K=K=6V_Rp37F8gOroSZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/25 19:29, Michael Chan wrote:
> On Tue, May 20, 2025 at 7:17 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Tue, 20 May 2025 19:10:37 -0700 Michael Chan wrote:
>>> They found that this sequence was reliable.
>>
>> "reliable" is a bit of a big word that some people would reserve
>> for code which is production tested or at the very least very
>> heavily validated.
> 
> FWIW, queue_mgmt_ops was heavily tested by Somnath under heavy traffic
> conditions.  Obviously RSS contexts were not included during testing
> and this problem was missed.

IIRC from the initial testing w/ Somnath even though the VNICs are reset
the traffic on unrelated queues are unaffected. If we ensure that is the
cse with this patchset, would that resolve your concerns Jakub?

