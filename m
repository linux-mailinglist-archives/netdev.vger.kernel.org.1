Return-Path: <netdev+bounces-183616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819BA9149E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937CF19E033A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1932153CD;
	Thu, 17 Apr 2025 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="PdLuvDQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549671DDA0C
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873254; cv=none; b=aKKXXxvSJAXqrzwU7sqokYtlI+KiKeMMcYxj4+ScHTatx5AO23QvLTpSdEjwIpwHmszIF/eo+Pgsq5Dpy4a/wyYmCMWU7K9U/la1PA/9LB0/N88ST+VdQFjuhRwgQ49/HQGUh9LYhFMlgQJrAb/jbczBUhalSyP0u7owyRSUhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873254; c=relaxed/simple;
	bh=w5PRKU5sdEGDHRp4fP0Y606LJOfqnZ6orvNNl1CuqY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANcor5iapODWXBgzbPHt8mRCB3NA5K6Ck7Feklii0g4w1PuO8XVgLeaSDMPWJhqObyen6kiVBZrykWeV+Y3SKjZIVLEzsPsHngNFa+sDK6I5vBHhmvH4Y3rwOBOgcbPYD4uxNpUtk3jfLqHWunnqfstMthFe2CFJ4rM0+ro/hpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=PdLuvDQ3; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 022091C0E84
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:00:39 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:subject:subject
	:user-agent:mime-version:date:date:message-id; s=dkim; t=
	1744873238; x=1745737239; bh=w5PRKU5sdEGDHRp4fP0Y606LJOfqnZ6orvN
	Nl1CuqY8=; b=PdLuvDQ31t8mLtMkmrs/NTfYcHICtXlo8nyDwX06bM0Sp8AK/DK
	N6rrVwdgdzdPmKmAKhGXFKdAXD0Mb3mIWHQw7/AION0eNrN0ONMfjfvjKDpjmLt7
	kafQyqRLeZG5bu1+aG3+NCyW9IdowXePwZu+inkN0yy7/yoBO6nOhIpA=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O4qj5SkdPDPC for <netdev@vger.kernel.org>;
	Thu, 17 Apr 2025 10:00:38 +0300 (MSK)
Received: from [172.16.0.185] (unknown [176.59.174.214])
	by mail.nppct.ru (Postfix) with ESMTPSA id 8B6BC1C08D8;
	Thu, 17 Apr 2025 10:00:23 +0300 (MSK)
Message-ID: <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
Date: Thu, 17 Apr 2025 10:00:22 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
Content-Language: en-US
From: Alexey <sdl@nppct.ru>
In-Reply-To: <20250416175835.687a5872@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17.04.2025 03:58, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 18:34:01 +0000 Alexey Nepomnyashih wrote:
>>   		get_page(pdata);
> Please notice this get_page() here.
>
>>   		xdpf = xdp_convert_buff_to_frame(xdp);
>> +		if (unlikely(!xdpf)) {
>> +			trace_xdp_exception(queue->info->netdev, prog, act);
>> +			break;
>> +		}
Do you mean that it would be better to move the get_page(pdata) call lower,
after checking for NULL in xdpf, so that the reference count is only 
increased
after a successful conversion?

