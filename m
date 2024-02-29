Return-Path: <netdev+bounces-76003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBBE86BF48
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 04:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B42E283647
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 03:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3144364C7;
	Thu, 29 Feb 2024 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sJSfyDKz"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01232A1A5
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175999; cv=none; b=ck19eeieBycTlB/JMC7PBBMuqmottB8YWp331qhyMWVHH9vjZ/4lglzSnn5/hI4i34kUXAAjZqUF/bUXXxj373vq9p3aqIm1Rs3LzCthKrBJHr5sfjwQ0/K4dbgYprfqYcedzct/jkfc0uZOJteKEEzeml44YHM4gMkyDjHJU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175999; c=relaxed/simple;
	bh=ty1kMhuT2FR/GBsEDJ7Eklj35xsmQK65l81VuCcmH5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcDFd+eiAj2B9TRawTlS4DU05/igrRsGWLqvmS0SjeRIvITXDAXM4Yya50prgheg1cBdcL9Ib8sK1JBXnZ+/MC7HaZ1H869JtwUfFtLF5yokeyXQubHZwCMca905XT4CL6E6z6RKtUakkTD2uF1G8GVdVkVrHfSwxzXv5aN8H2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sJSfyDKz; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfd6d590-2bf0-45df-97a4-f9359b5d454b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709175995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWuYF1zX+Ht0lPV+8iqL2NPLxTc4uLQckEYNbea20LE=;
	b=sJSfyDKzSxitsSg35CsI8l673N7isxZ8JjGczFlQqtFwQifs68QpMOjrQ6FJ/yyr6fUfF0
	wDEDzjyDqWJ+WaLujLwfFspjQfQh/JlpvNRwllWFNV6p/gh5L65dxnmubwEz3/XhmWgtee
	KUqHiUKWyBz8Jm0CpN16sTMimqNhFLs=
Date: Wed, 28 Feb 2024 19:06:24 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] net: Modify mono_delivery_time with
 clockid_delivery_time
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: kernel@quicinc.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240228011219.1119105-1-quic_abchauha@quicinc.com>
 <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <65df56f6ba002_7162829435@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/28/24 7:53 AM, Willem de Bruijn wrote:
> Sidenote: with sk_clockid, FQ could detect when skb->tstamp is not
> set in monotonic (i.e., set by SO_TXTIME) and drop the packet or
> ignore the embedded timestamp, warn, etc.

Thanks for cc-ing me. Sorry for the late reply. I just catch up to this thread 
and the v1.

I think it is needed to detect if skb->tstamp is monotonic or not in fq. The 
container (with the veth setup) may use sch_etf while the host usually uses fq 
at the physical NIC and expects monotonic skb->tstamp.

During forward (e.g. by bpf_redirect / ip[6]_forward from a veth to a physical 
NIC), skb_clear_tstamp() only forwards the monotonic skb->tstamp now. While 
sch_etf does check sk_clockid first before using skb->tstamp, fq does not check 
that now.
or fq_packet_beyond_horizon() is enough to catch this clock discrepancy?


