Return-Path: <netdev+bounces-125566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E096DBBF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77301B2641E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7040D39FC5;
	Thu,  5 Sep 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RUUKKGQn"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CDB1F93E
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546431; cv=none; b=Vm9yBkMGzGa0P9FIhcqvaYKMDSfhIIRWAqmb+yl4+lSNMP6IQYMzrkg5LiRdy3V/fFlv7HE5xc0uMw3EwRNi3HMgXJhcUS0Cb08EC8GmNp21pL+HXqhgcALChYXJ2f3Wy8mj1dE7SXydwUV0YfI+qAtt679nUBBn8h1F+52BX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546431; c=relaxed/simple;
	bh=3k+74O6+/02mugm3J4gvCVu7ZvKYOuy9N/M3e+OyQvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUAqIvE8knRbxmYaPA5QM0sBzYtOpOVLwrioXR3Xx8s5t2bx9VrEbnSKrC9hPmDy8ETQM5aamfKKAIKFkmRE8+0noYfqU2ZJ7jnm+VQIukBVz3Xhclr8W/xeojhC0ErTEhJpqEOJsCoPTVDLYnnxhuMmCtodNkG69E2PM4+ikLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RUUKKGQn; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d2470924-78a2-4905-a24f-afb127644d70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725546427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsQk6z3HEBxGfR6MpE4YothAxzaD5ug0Mh6OH+yVUjs=;
	b=RUUKKGQnv8uB849iNLPKm92xmx+iHZQGUdonlJPhlHsrZGhB88iEGJxyTUgD4ep038lnYY
	GpCnrHfPYjGvgA3LyGULP0yZHo7emvAjajdrgD7emlR8G9RorkEE+XgXcIiEa5vLwRQ+fd
	z8ml8I3DYTkosQCLArX5FmQmft9p4oQ=
Date: Thu, 5 Sep 2024 10:27:00 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/2] net: xilinx: axienet: Enable adaptive IRQ
 coalescing with DIM
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>, Heng Qi <hengqi@linux.alibaba.com>
References: <20240903192524.4158713-1-sean.anderson@linux.dev>
 <20240904163503.GA1722938@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240904163503.GA1722938@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/4/24 12:35, Simon Horman wrote:
> On Tue, Sep 03, 2024 at 03:25:22PM -0400, Sean Anderson wrote:
>> To improve performance without sacrificing latency under low load,
>> enable DIM. While I appreciate not having to write the library myself, I
>> do think there are many unusual aspects to DIM, as detailed in the last
>> patch.
>> 
>> This series depends on [1].
>> 
>> [1] https://lore.kernel.org/netdev/20240903180059.4134461-1-sean.anderson@linux.dev/
> 
> Hi Sean,
> 
> Unfortunately the CI doesn't understand dependencies,
> and so it is unable to apply this patchset :(
> 
> I would suggest bundling patches for the same driver for net-next
> in a single patchset. And in any case, only having one active
> at any given time.
> 

Well, I would normally do so, but that patch is a fix and this series is
an improvement. So that one goes into net and this one goes into net-next.

I've been advised in the past to split up independent patches so they can be
reviewed/applied individually.

--Sean

