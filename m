Return-Path: <netdev+bounces-214544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E18EB2A116
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 14:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBEDF7A78FB
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 12:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3D730E0CA;
	Mon, 18 Aug 2025 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWT3lwTh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21872326D60;
	Mon, 18 Aug 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518783; cv=none; b=ksIOnXXx+8iA5IGF7qiy0Pu+vJpAEFMEIkXYMb176dhd+W1d7AgRuNjw3rAET0WETRFVF8R2UJ8mmn4xStkWbKPmJ6FKJyE0DyYy404LaLpDEbGGR5J4zaywh6QYQBN1cSfL5JrDOD+huQWRh69k1Qjvc40xoy6ay+ff2vbi97s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518783; c=relaxed/simple;
	bh=GTdPbxOAUIj0UQ663l+71swyoJ6SBF+WaldINZCOuAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewo05IqfewU/rhLvDmhFW6pFi8E686nBdO5IWDGqlWbF61gyvb6aSnbXYToAacYGmQzs+nQQBGQibXrxGrvpqMFQiWXLWO0TuWXt4Gm2PLCmW28SSqmCZIo2w2ioek2fRuVWpR/KZwIHfvSEpVjGsUOdBikIfqCqieRShXlmTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWT3lwTh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so19531695e9.1;
        Mon, 18 Aug 2025 05:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755518779; x=1756123579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVY/BYMC3g5VTkHAYMuYNu4qOgKDUpRTvI8bp4E93Bw=;
        b=QWT3lwThcDyVOaAePXzL16uG2Udjp0CfLakmS0I7nRXy46RA7//6neC+9Bzx6YScQ7
         HSgwvzcGxd+gaFPWbNaG4PmHHvEAJC37LO6KnjiNWmg3XoraNhlwYZTcdKp7yEqO2usD
         AtD2qepGrzxD1jOvGrh95IXnbl3F2Ms8wUVfxi6BOUN5Qw4gbj5wyEPW1gyOWCHPeH1u
         TZ0paZEW5a3OLE+88ki5Sy9FWoF7XHSng4xHaKgu9LSVDqFFLIHGQtO9VhuJjmMlzZa6
         ARRX+MEyEyRILpSaKGaduba7l1QpW8m1stj33GSWWKVx8E32/59YJT3g1sCwX4X2Mz4y
         bfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518779; x=1756123579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YVY/BYMC3g5VTkHAYMuYNu4qOgKDUpRTvI8bp4E93Bw=;
        b=A0EK4ftxwr7J7zooK/sMWXK9JtIn1h+A+M9RKU3ALIh5EWmYmc2cqppIJMZPFCQN9C
         Vobh4qgNWfPKP8rIwoofJuSxnEyjRrp2InjpcLD3ajHYAda77ksMy+RBPcsLdRDaaG5X
         9hqYIxmvFHV4NrBuE0eO3K/zqc5C8Bllt9wAvH4/xjRyXNvZ3HvmxWLvG7Fn19l4D3ZX
         VIOxRvewn0etI6LwhUNmAP1Flh7SEytcOc0RxqtVT340aYhNOj95rHdirZfIyFW5duqZ
         grUbgbwrQNQp4nzqRJRkKyr618ZBSxx7nckKA7ePk6FVSi8R6S2GYf55seNJivndU10k
         S3bA==
X-Forwarded-Encrypted: i=1; AJvYcCW0cRykbed8tih8riOTVdaj9Uj0Nj02izN+/5K9x3lBrf6CtqK8YMeWJn3nshkYFFS3mwaiZ1XAalXHx3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW5fDyLt6aoI1l3GIctpFm8Wcm9nSC2yb+Vw9BkYC2Hqx5stAs
	TXZAaBGa+KyRnS6CRiq6FHbvrIZ+QeEDGPnHP/QmznxZan/EJYpOaxck
X-Gm-Gg: ASbGncuDfZ9akhAA9cf+LkuIOYioBDcvCV+9a9CBpD12RaozVcYZmTd0LVqk3NDzIgv
	uDokKXsZxOv4L/ytyETD2mv+yHRAgHj5tP1+0PCSZFZy005hFK7xJQpCLrPcNJJUPSbm0mdznll
	pB1WT7S8hyKRHoioGEieJBxstgpiLLJsgMWujqmCPGv0sIPqVB33lTik2kSkUdaclJF+pG76abX
	zg1MbrfptaxowM3YevGFiViowdt6BzRuJLF5M626IiFnli9zT5uPAm3Xtipvz0pFv5Edu0EKmKN
	p0japqPwuo/cz7TjBceixd3Eg5TBQaE/aZ6jvW4uLdBMcE9pydAK9eSHmdsE96qhvBg2DavLSff
	clwsv1vJE1U58wf6iH7hSRFyAOPhU98PVfx/z/mdkadSi
X-Google-Smtp-Source: AGHT+IHyJ1WkyGUJmwIj7X0HoDAmZxd/AQfZoLZGTHU3YxZw4apNVH/dJuuAwMoc5NAA44knh73t3A==
X-Received: by 2002:a05:600c:8010:b0:459:d616:25c5 with SMTP id 5b1f17b1804b1-45a267496cbmr80041745e9.12.1755518779015;
        Mon, 18 Aug 2025 05:06:19 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22319780sm131213285e9.7.2025.08.18.05.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:06:18 -0700 (PDT)
Message-ID: <a803b83d-26f3-4127-8502-64b2b4eac3a5@gmail.com>
Date: Mon, 18 Aug 2025 14:06:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] selftests/net: test ipip packets in gro.sh
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
References: <20250814114030.7683-1-richardbgobert@gmail.com>
 <20250814114030.7683-6-richardbgobert@gmail.com>
 <20250814124209.699478a5@kernel.org>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <20250814124209.699478a5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 14 Aug 2025 13:40:30 +0200 Richard Gobert wrote:
>> Add IPIP test-cases to the GRO selftest.
>>
>> This selftest already contains IP ID test-cases. They are now
>> also tested for encapsulated packets.
> 
> The series seems to break the test when running in our CI:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/253062/25-gro-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/253062/25-gro-sh-retry/stdout
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/253241/18-gro-sh/stdout
> https://netdev-3.bots.linux.dev/vmksft-net/results/253241/18-gro-sh-retry/stdout

Missed this. Turns out the test does not generate
IPIP packets correctly in some cases. Will fix in v2.


