Return-Path: <netdev+bounces-179934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618D8A7EF1E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB8C18884C1
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72082218591;
	Mon,  7 Apr 2025 20:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="kASzJbDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DA19B3EE
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057228; cv=none; b=H79/G+7y3T9z/KqjblrPGHIKQSx+3louC52zggw4RDwx2bS+Lv6Suj1xcRuJbFI6xHLBXH2NuZV5z6r0H8B6i2+QWF3Oh+5tCA3Z7nSwtme6/LA7HwO2KYUCeayMsiVBGKfuqccozApDXUmfysfEHwiPBc2S3bi/Lo3hwTQw2dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057228; c=relaxed/simple;
	bh=RKsZRqe9vLdoxArYPsvm1LoDJKDd3Nqf7W7neQE9NG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7f2zKv/ShA05ytyo2NBG+g/1uSJ4azJ0Wj9oVdRcZZaGpaV2UrN9JjJqE40p5zDWb0SngCmxPbZB8H5J+Rqaj7hBWRbQtm/xmKcOxM3K8SNXJEW4OWwVBmvNoZ+WMXoUiTZfDI6FsffSABIIOjRns5CQk4Gp7nJFq1hbEUWE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=kASzJbDi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af50f56b862so3278140a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744057226; x=1744662026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+h4jVowC7a2d/H6Nr81b2Xg8HSBiDZWjPd0q9/g7P4=;
        b=kASzJbDicC4EL+u2jO0HoddW4h0m4Eu5Th6AJucHSJqjxet6L2KW+TW4Yl6/iwWpuQ
         CkckiL0k43NWbJrdliczWMl+hU5dAsLz0J4UR/CTheiJnB/5XRDySSqKlacIycgb3RcA
         ccfr6vKy7OLiWWyQQNrYXLAM/4GYd+e1OX5Upn7/ZpAycvKg84Wv48BWdJ1zlVhhOmu2
         +StuD2MzRenOKCelZP6lhgDahwW0xdipfIQlWxWjHztWi7/tapsGGhZj1lr4Titabynd
         4Zm6Zc4bNoQe0as/GYtOAvTgAo7huF8z0BsYVv4SOVlGrkMedChH8g9XN44tb7wY1WPc
         f9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744057226; x=1744662026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+h4jVowC7a2d/H6Nr81b2Xg8HSBiDZWjPd0q9/g7P4=;
        b=KOOhKM5h66TrAcZGgVyc6ZtunOa2kCpcUjIpjqiAR9Vp4wHVi5uV1RIACpvYh36MPu
         124gNwpFAYyMFIcqNQyhlLyAgnU4fBxOPkG6hDguafq6hEi0vA4EVDnaKkAz4dUOoi/T
         uBpS0vctFEGssWJ9Mhukrjf8AJUDooPcXBCtgPj6os3FyI/e7EQkbH9rVtNdMwM3VPfF
         LxdWNyzPqIOOAOibpj4XFxoVmIOkt3pW5zIA6Q+534QB0EQCg5/y17OT+CQpXy5/wNIb
         ltQF1tF1StyhOtod8CFF0aUsYs80WXpkL5WFjlYmDkxls3jjPaKYI0QGwifPxZwGBjwE
         G+rA==
X-Forwarded-Encrypted: i=1; AJvYcCXPT+4IKPMjo0tQs0eGLk+UbZZG517L/mLHHBvUURyg9OdZbdXCtIMxiX1ciZySTmvT38k1wYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoORy3plYT4scPkVI7n+xjj/5UyJuakQDxoWByegVZDsG6FXMc
	ZcjXueFlUsWu8KaFJAbG2zYGXkbr7U93HuRyiyDUY2zGCxrhlIPaadkNqg95Ow==
X-Gm-Gg: ASbGncsb5U0D9076Stt1WFYZz3KP887izi0ka4nBF0wN95p3k7xKqpAbXOYgjlaN02U
	BBacEhU/NVqFaN1cJ39PkN1eFPG2ZdtDMuVHyXqGoWA5cB0CavKaW+fWf0Ik8S2ITgRP9a3Dp0S
	tqSASPuw7yE3l1ub/MemVHLCOB2DbvCWBANGgsDe2Lz7q96gxVAZYphjGBVeORm/hLmM3Zv9y94
	kEGS8iZyLF97383gLHpr88xs1bbpRM4n3LPOa+l1Dy1HokB/Oz9My4UXBzARjZ4tffLDHCkxuB5
	M7zdHeR1M9Zpuqq8Y//k3XACZ2EuzLt5XibD5tEAPJNPPnwqaR2Gqd1qnO1wZip0NaGv6vrfSE8
	J5eh4DFiNWQ3Bjcc=
X-Google-Smtp-Source: AGHT+IG0J/nBMOfNw/WKPZKQwjt25jGdbw5Jwtkr6iax/SpH3xHEokAvtKFxpoXBn9fhAEkB++21RA==
X-Received: by 2002:a17:90b:2f4c:b0:2ff:7b28:a51a with SMTP id 98e67ed59e1d1-306a48a4b89mr23704385a91.17.1744057225955;
        Mon, 07 Apr 2025 13:20:25 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:b109:bcd7:b61f:e265:af16? ([2804:7f1:e2c3:b109:bcd7:b61f:e265:af16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305983d865esm10450610a91.44.2025.04.07.13.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 13:20:25 -0700 (PDT)
Message-ID: <e909b2a0-244e-4141-9fa9-1b7d96ab7d71@mojatatu.com>
Date: Mon, 7 Apr 2025 17:20:21 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 11/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with ETS parent
To: Jakub Kicinski <kuba@kernel.org>, Pedro Tammela <pctammela@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-6-xiyou.wangcong@gmail.com>
 <8bd1d8be-b7ee-4c32-83a9-9560f8985628@mojatatu.com>
 <20250404114123.727bc324@kernel.org>
 <00bd48eb-eb2d-4194-a458-6203aeba6a81@mojatatu.com>
 <20250407130951.454b2760@kernel.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250407130951.454b2760@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/25 17:09, Jakub Kicinski wrote:
> On Fri, 4 Apr 2025 16:03:26 -0300 Victor Nogueira wrote:
>>> Any ideas what is causing the IFE failure? Looks like it started
>>> happening when this series landed in the testing tree but I don't
>>> see how it could be related ?
>>
>> Yes, I saw that, but since it succeeded on retry and, as you said,
>> it doesn't seem to be related to this series, it looks more like
>> those IFE tests are a bit unstable. I talked to Pedro and we are
>> taking a look at it.
> 
> I dropped this set from the queue temporarily, and the failure
> went away (net-next-2025-04-07--18-00).
> Now I'm less inclined to think the IFE failure is not related to
> the series. But since the retry passes I'm not sure if Cong will
> be able to debug this.
> 
> Could someone on Mojatatu side take a closer look please?

We reached a different conclusion here.

Went through it during the weekend and today with Pedro.
IFE relies on some "sub-modules" for it to work (like
act_meta_skbprio and act_meta_skbtcindex). The issue is that
when running tdc in parallel (with more than 16 cores), the
act_meta_skbtcindex module is not loaded in time, which causes,
for example, the failure in test 219f.
Likely there might be a recent change in rwlock? not sure.
When we fix tdc.sh to pre load these modules, that tests
succeeded again. Will send a patch

cheers,
Victor

PS: It may have worked for you (in net-next-2025-04-07--18-00)
because we applied the patch we are going to send earlier.

