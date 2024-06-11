Return-Path: <netdev+bounces-102496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A15F9034C2
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 10:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168411C20BC1
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 08:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E94173357;
	Tue, 11 Jun 2024 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="ge4vhsmd"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF767173351;
	Tue, 11 Jun 2024 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093085; cv=none; b=NFOJi7yNYuc5YWwRf6NGlIzLlmPPy2xDfqZg1/OTT2wfWSamB5WMNNb1gNxKNdQeH4QfWBu6ea1U7AT8TEjcP9SghMB+Cifb093GHB5wOf2aeGBeNK/wuhnRwk82KXIKIh/bd0k+RDimhthi0myUqTQG/Mne0ftRSAN1lJhTh2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093085; c=relaxed/simple;
	bh=VVElxgkUIfaPWX6L+f8ZayYJBJTkUQN4WFHJZkR5/sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q60Bq9l4nyS6xNkfhLGgczIxGR3bmUXp5qmKKYC0XntxqlZO2mQgT7vriMmwYJ6lwtpMxdKdlz2C6cipxmBJ3LhwHQjj56PefGMzSqYeEaFKKWsfrpDKBZQd70E1tkIN6dJHvM27i+/8NrrmeM7vKD9g3Xs4y8CX7S//DRxlpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=ge4vhsmd; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id AC18CA0673;
	Tue, 11 Jun 2024 10:04:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Iw86xKR/OFWQyAzkNCm+
	Kk/DYTWImqwL9oSvNnLL/mM=; b=ge4vhsmdAPNxyPz6clUFsMZGShyn/2XIAF65
	TeonR0VVCwKuy/dF2fHdxr6yjidXJotjMNO9o0kKzjMg+0vSL35IpDqy3wgyIKBG
	uFNo/RrqoXhIacQiPx8ne2LdUpd/59/YooIxtuTsANTXUUuS4vx3Z6/gfoIHvvdE
	6Tkowf6Nexkm1OS+FN2HKIevPPCei2vWxs2VO4asLLWCywOMpMW4DAUM1DlpJJWX
	GDNVHucA0WHN4z5uIpAV9Chu73ybON7PcdHZXuUnVYydj3BBDrrwnWgd67+5T5fQ
	vG5A36ZFRnyrXKRGcp1TQVtzbYFF4JZlzM28fV3/6Ia4FmPL9JjyAxFLFxiakErI
	u0mHKrJHpf1ARrsQ/777Z1Gxm98cpKg//hmorenS9BcDxKAsmkZ8UYzjJGuIucfl
	90m+aA1MtqPpkWMRXPTWpye/3VXjZjWRs0T1MDDJsAOl+gkFFMZPlau/rlsOH57c
	7/1dVFjEFilqSirtFqeeXiMo61McVYjfN/XetUoblHCmbk+tZH/Ez7WFWX1icccJ
	W5QLgA1zF2c/Ps09sr1vk2h0uDTTfzKTI7Eywp7Jfg9Tsicch45eY5MDzj/5Bbla
	LLv3KGR+u+KhX+4TyOVd0WEEeVwKR0+AUuOeHa++YeXeQFBtHpjxi58c5nGC0vUs
	Y9s9ufI=
Message-ID: <d6d6c080-b001-4911-83bc-4aca7701cdff@prolan.hu>
Date: Tue, 11 Jun 2024 10:04:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: Add ECR bit macros, fix FEC_ECR_EN1588 being
 cleared on link-down
To: Andrew Lunn <andrew@lunn.ch>
CC: <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
	<richardcochran@gmail.com>
References: <20240607081855.132741-1-csokas.bence@prolan.hu>
 <46892275-619c-4dfb-9214-3bbb14b78093@lunn.ch>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <46892275-619c-4dfb-9214-3bbb14b78093@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2945A12957627C61

Hi!

On 6/10/24 21:13, Andrew Lunn wrote:
> On Fri, Jun 07, 2024 at 10:18:55AM +0200, Csókás, Bence wrote:
>> FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
>> makes all 1588 functionality shut down on link-down. However, some
>> functionality needs to be retained (e.g. PPS) even without link.
> 
> I don't know much about PPS. Could you point to some documentation,
> list email etc, which indicated PPS without link is expected to work.
> 
> Please also Cc: Richard Cochran for changes like this.
> 
> Thanks
> 	Andrew

This is what Richard said two years ago on the now-reverted patch:

Link: https://lore.kernel.org/netdev/YvRdTwRM4JBc5RuV@hoboy.vegasvil.org

 > IMO the least surprising behavior is that once enabled, a feature
 > stays on until explicitly disabled.

The point of PPS is, it is a 1 Hz clock reference. We don't want to take 
away a clock signal because of an unexpected link fault, for instance.

Plus, this patch doesn't even re-enable PPS or any other 1588 functions, 
it just prevents the adapter from forgetting it is even 1588-capable. 
I'll resubmit with more clear wording and appropriate "Fixes:" and "Cc:" 
tags.

Bence


