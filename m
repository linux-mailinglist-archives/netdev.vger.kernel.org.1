Return-Path: <netdev+bounces-240939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5761EC7C48D
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 04:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B908834F6CE
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 03:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1C26ED53;
	Sat, 22 Nov 2025 03:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bf9kLBjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19324E4AF
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 03:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763782142; cv=none; b=FZwJ8MCaFeSjHZc62+7DCLZVbY5OMMR3I46RuHzaJ6KPyLxH73v3/ASDrMQSPNDdPLxjdxFrFP90pGpkj8lLSsVQxCL+tObbVCM3RLvCVd3hMm/TKYM45pqKdmGrZoiq7Iq/XQ+TyAinQUDeJvHw2IKfd+OW1GPrl3SUY6cClOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763782142; c=relaxed/simple;
	bh=Uumd+uRyjBXT7nweb32JISZlGAMJ/S9/rd62zEKzjV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odiy5r89hVsvFbFAp/MjkMpO8Xv8uYrMZQv7gE4EfJzmSIO9UUDu9v7BCrY0b4NXngAS6tXFu1nwL2Q4lfcOfqxmbx1V2l/mIpy/TyZo23qOqYZsUcXANKfipBs0UKZM9qlpBAYglAQFunmsjEgo3lFsgciHrDBktqzf/WGCwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bf9kLBjB; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7ba49f92362so1639494b3a.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 19:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763782140; x=1764386940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SQ+Lwj5SeU/KyVliRV0URLwWE+SK6v/+Rn04l49kMcc=;
        b=bf9kLBjBMB/GnTDAdgraEFBvq+0yPEWJXQ0IKmeG8ZpGx+/vxMWfixMOSVjn3h8Alg
         /YZUeY07WkisxtzYaEvcsFTXbeSvyEJ4K6T4xhSncqQfr8uI5oisw0vkmaeZ0YyrPwvy
         HwXa/T1it1moGW6wsV0cbvHjKPdkZR0Um4sXoAPLL3P/hYBGVX7MYoDoru3BvKKRnKXq
         o78bDWXgCHqXRJwpGAS2bJM1noEK0NTJXI+Du4om3Es50iSJACS52DHl2RK7nf5TyLF5
         aEPyjr8FD2W3gzpq31yx9vcBSKsJGDgU+StTPBPGQ6agTfOoau7JgQG4ftgNZ/7nlJr+
         HTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763782140; x=1764386940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ+Lwj5SeU/KyVliRV0URLwWE+SK6v/+Rn04l49kMcc=;
        b=afQQYtu4wQwcQcFPHTuZbQ8LIFBPmAkcF3oPvR9V+uwPQ4r8MnNDGJl9Kfi5rmOIgV
         RyIBDb4ct7z0pVR6Vep558nFdiPf1AgETYAFk9ctm6ymOFktU+9mgeonmyb3DVEBAUYQ
         YgFZmYUIkh2q9f5gx7mgWHIIxnD0w9KRH7raxRZ5y30yEbvvFZgDbziywQGcLkWsNL/F
         XqtcyeknSzRGS+TDzSd4Kk+Uh/DqHy+6/7U3bLh8uRalGPNHEmyq26IR2Yp1AnGj+fpA
         LQLRpDaRetjd7AzlkW3VzayQBf21bB8OZY+xHPfc2ktDv/G0fLImRk8X0cxBbPvcpVxw
         wjWg==
X-Gm-Message-State: AOJu0Ywr6KVBuVzn6tygjHRMGOaQa0r4d3ZzpoIzNRJl0tYeDRQ6XTE6
	yEA+SBNZdee0VF56eIFz/U2XXima2rm4GqZ5xf102xNPtbwIo/4smHVfS1Eg1SxQthU=
X-Gm-Gg: ASbGnctPjAP/z7L+6PfZHROcGJ5Jff3UfZ/kUlkVgdcd4SVJOUWlgiOkUPH88A13FEd
	INxASS7wbUAlqwd5f4ajFJJou/yaMKaLcBbMMX0fWTZ82vHC8Y1dRtw53GXzGxgqLnoWW3SfzsM
	849v4Xr4iqZDKlR4kTPhPt9WSK2OAg0ffzapyh3/pEVgpihwMKBCncuT5UDanv+2mf9PboKgJRy
	PG2nh5xvCF1rHseMiZVGDhHZb4N18KqD64LAmgnsQHebsOcLvBwsoK5w1Pf83bax/fpBKNdWD9u
	mtcHkgeFnlzF8poiPqirkKDcpYiZKTvWkvJI/xI2DgrJO01MVLpheXUXUTynkxuM3gLKqxrDHzK
	exlDtS3E7rOFwkB0PD9oUULdTOEueZ5JTxGKrFc23+1udyii4nWAcKk09Qx7aACTYRApCUNYt66
	U+74eeyIZMwDCmFca/QgSavUtxYXHd0n5dtRdLLHk/Je2YlSde2Q==
X-Google-Smtp-Source: AGHT+IEhvwheOAYPloSMMBEpzYdJ7/d7FTAum9UUG1r0sSkitEBUtkQyuw+pCARID2YN3nGd9Ti5kA==
X-Received: by 2002:a05:6a00:6581:b0:7ad:8299:6155 with SMTP id d2e1a72fcca58-7c41dd0af44mr6480935b3a.2.1763782139655;
        Fri, 21 Nov 2025 19:28:59 -0800 (PST)
Received: from [192.168.86.109] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7c29asm7496374b3a.9.2025.11.21.19.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 19:28:59 -0800 (PST)
Message-ID: <0a45fd61-b80c-4943-b614-6fe3c12f33a4@davidwei.uk>
Date: Fri, 21 Nov 2025 19:28:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/7] selftests/net: add suffix to ksft_run
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20251120033016.3809474-1-dw@davidwei.uk>
 <20251120033016.3809474-2-dw@davidwei.uk>
 <20251120191324.1384d419@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251120191324.1384d419@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-11-20 19:13, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 19:30:10 -0800 David Wei wrote:
>> I want to run the same test cases in slightly different environments
>> (single queue vs RSS context). Add a suffix to ksft_run so it the
>> different runs have different names.
> 
> Please TALL at 6ae67f115986734bc, does it help?

Yes. :ChefKiss:

