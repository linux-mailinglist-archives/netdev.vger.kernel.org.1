Return-Path: <netdev+bounces-180047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE073A7F423
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B459318987B6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 05:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13C226170;
	Tue,  8 Apr 2025 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tCFgNK+0"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B892116F4
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 05:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744089848; cv=none; b=CK33BgseA2RgL9Sua+7VloGLgFniFhIC2rNTF//g3YN5Gfr9xx9hgsOupRVecRV04Ny9Y3EtqEUujjAFTM3b4wUbpoBPEn1BLsFo7bxZqyObbr4o1DrfgSnNdML7darYPLx/cqjjL2czIkMH05Jq6OaDsHUqLare2S/bLFG49Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744089848; c=relaxed/simple;
	bh=ImsvRoDAy2Ur9jItjKFW9euORH5r9NVFyr+isPigwOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1PEJhybc0ua7IgMe+UFT/ykdK9Xi6VsZYJqQCC+kBiizDMij5av2D0zI8XpRocsvTMHnss+66+fZ1/qvzSiIvyLbI5Az8K4fG43boNHJtUe2jtty9NvWh//5WikiOSJQ3HCWbXdxzaGyS79Mbzzt+iQPcdxhdZeCPGMqM0IRfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tCFgNK+0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <da0e43ef-4861-4541-951d-8d576fbaa069@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744089831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1laiUd4FjAcV7GBskzehdOpYcoxnge7IVbp62y0no8=;
	b=tCFgNK+0uEzi7nyqFmCSqGiNqqHwol7bsE03sP0+0yecnZWF+LaJPPzD9tsvB12XLR5fER
	hfz8Ol4Oubt2B9FrbHCRohBLBHd923Sv62w6b8/bilzh42hd4vP50ZZCq2S+PLcc9MDby8
	OaWNIogdWcxG8eSFq1I82o7e5dN71pM=
Date: Mon, 7 Apr 2025 22:23:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 2/3] bpf: udp: Avoid socket skips and repeats
 during iteration
To: Jordan Rife <jordan@jrife.io>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, aditi.ghag@isovalent.com,
 bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com
References: <CABi4-ogLNdQw=gLTRZ4aJ8qiQWiovHaO19sx5uz29Es6du8GKg@mail.gmail.com>
 <20250408001649.5560-1-kuniyu@amazon.com>
 <CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CABi4-ogUtMrH8-NVB6W8Xg_F_KDLq=yy-yu-tKr2udXE2Mu1Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/7/25 7:39 PM, Jordan Rife wrote:
> 3) If vmalloc fails, propagate ENOMEM up to userspace and stop
> iteration instead of making the tradeoff of possibly repeating or
> skipping sockets. seq_read can already return ENOMEM in some cases, so
> IMO this feels more correct. WDYT?

Agree that this is better.
The stop() may need to take care of the start()/next() may fail. Take a look at 
the bpf_seq_read() in bpf_iter.c. Please check.



