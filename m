Return-Path: <netdev+bounces-116766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640D94BA16
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A5CB22326
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909C4189F48;
	Thu,  8 Aug 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="X9L6VYOo"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88D41494BB;
	Thu,  8 Aug 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723110582; cv=none; b=e1FPsPu6rkC+SHkkb6b2qmsnpD3pgKwFlVqAoHK3zK4LXSiW2MotHDyE7pkxEVipdzj7M9TnE0SNUoirdlz8EW9aLdHXogSxFbHqcpiLv08AgKzSDE9cCI6YZP4iS146lzBQwVm4EsBruMu9DCN7h5707oSPLf/rfGkr9fUSbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723110582; c=relaxed/simple;
	bh=5HH0jUt+vlEiSEtkkhsfiu8TgAtJzkrWtdL9zWUfeiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hXhFMHZYJuP0rH9jou4eYBEI3QxEoIL5ZXC5NVrrduMk5Ht2sW+IhWGNH1isYlwhxvhiksb1lqkNqLUBBWNQAQfjvnjgqRrRwIFV4oSlhTNI6mdgzmMl3wzPCCDsVkkJzZQu6ih8mknmE2913dHz93X80Hu/ci/KBMPoMxOYCIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=X9L6VYOo; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id ABEFCA02FA;
	Thu,  8 Aug 2024 11:49:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=HWgcu+nMnNfMlqErSxKS
	w+bBbNvWeyDcFJmtJSZ09OM=; b=X9L6VYOoifxEl0w25j90b5+e0aZnnGBrWMeM
	CssyWqVmzsy139dNo7l4zUHb+lkx9FM7rt/OLX36H91SXSsW+zAV5etCo0fEJbll
	7eF4uN3NFcRWROTNFw9LAr3wmi3NutSiDlh0l920jNrU+Lt/Tnw7Xp/x/NEH++u5
	RMBjjC+J++u2MFVSAZt9p1UBUlRaMEwefnRMK+IKIuydDpuA7eSh6aHnDZgxz/VZ
	QGvnv/hUV6Kxr1eBzkclom7FQHogY559IJImZmOBLGSRV/3tNS8oJMhscvItgqD8
	vzdOLSN7mMlTdHqewmqpeSwwls/sZBwwS+x/16AfUuce6NM7Hihs55PdfkgiHoD8
	zNAsbwQt/3HMbU6VuY1EsDFIW/tWnLR+frm/C6v0qEYp7LJ7qlKikaDCo4lfSz+y
	mV5G1tMdK/o3a4lZa5jLqEiZySWZfyiSdkBAKADSLdKc8HgXaRO/okrBJIwPGyao
	9NMoMsKzuC62WCUJFvCGScrkeZYfV0vB8y5zhVzt8uQhVupWcA6v6a87Dko7/l0y
	GXDR3aTuG+0d8hFoDC84oT8H/h/I3J7cplmv5PqnGBnacFhdpQ6ztP8FiETbU3le
	D8ujiOp/yqmRU1kVXMFIjBJ7f52yeksHRmxYnzx9chs2RSvUXHiA0Rw6YbAslv2x
	1j0hn2g=
Message-ID: <449a855a-e3e2-4eed-b8bd-ce64d6f66788@prolan.hu>
Date: Thu, 8 Aug 2024 11:49:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH resubmit net 1/2] net: fec: Forward-declare
 `fec_ptp_read()`
To: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Frank Li
	<Frank.li@nxp.com>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
References: <20240807082918.2558282-1-csokas.bence@prolan.hu>
 <1d87cbd1-846c-4a43-9dd3-2238670d650e@lunn.ch>
 <20240808094116.GG3006561@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20240808094116.GG3006561@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94854617767

On 8/8/24 11:41, Simon Horman wrote:
> On Wed, Aug 07, 2024 at 03:53:17PM +0200, Andrew Lunn wrote:
>> On Wed, Aug 07, 2024 at 10:29:17AM +0200, Csókás, Bence wrote:
>>> This function is used in `fec_ptp_enable_pps()` through
>>> struct cyclecounter read(). Forward declarations make
>>> it clearer, what's happening.
>>
>> In general, forward declarations are not liked. It is better to move
>> the code to before it is used.
>>
>> Since this is a minimal fix for stable, lets allow it. But please wait
>> for net to be merged into net-next, and submit a cleanup patch which
>> does move fec_ptp_read() earlier and remove the forward declaration.
> 
> That makes sense.
> 
> However, is this a fix?
> It's not clear to me that it is.

Well, it's not clear to me either what constitutes as a "fix" versus 
"just a cleanup". But, whatever floats Andrew's boat...

> And if it is a pre-requisite for patch 2/2,
> well that doesn't seem to be a fix.

It indeed is.

> So in all, I'm somewhat confused.
> And wonder if all changes can go via net-next.

That's probably what will be happening.

Bence


