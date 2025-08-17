Return-Path: <netdev+bounces-214360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250CB291AB
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 07:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C52A1D18
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 05:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D827A13E02D;
	Sun, 17 Aug 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOtbclsR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE306881E;
	Sun, 17 Aug 2025 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755409556; cv=none; b=OE+pWb1hbPED4vhgVbXXqaqfSiGGzT9NlY/Hx3om2urmVuD/LmIFxHK13o+qUX64+SlT5jlY/yuWwlSuJ/38n1EiX0s2ouJ9FW2fCRumWA3g+E+HoKWeMw13ZK65VylCLD7AlxX7zR5udSu0UyH7a92EdkhexErwHD5vG1yLrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755409556; c=relaxed/simple;
	bh=ttZ6jtkkRczJ0axAm9jZ0bwV4tHP2+ZyMJp+BLvzgMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZ6p5UxeVh01bw6YziY6z57pLdLZBmQFce71qSRfp9HBg75fmggTpJuSTEKh2iNpVu3Si45idMWok0jhlnVXL5VegJtrzg9z+bTjB4/E/4y/vf/aUdvYR8WROsQ/t1mxVnMR/inNy1GUXSi6d6tK+0gAj+LID8gUPtUCowpWZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOtbclsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DBBC4CEEB;
	Sun, 17 Aug 2025 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755409556;
	bh=ttZ6jtkkRczJ0axAm9jZ0bwV4tHP2+ZyMJp+BLvzgMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iOtbclsR3JH/yiCq9pAi1a+x0lWzJk7D8Y/T2R50hJ1WKoaktUJLiayU7r1jOOBz4
	 xiCxAu03lmMI7AqhXPQ2zxutlhl+gr8bnJ+Tl/QaMjLTYDmmI1fxUMqHOWyvmDvfqg
	 WFd8D/GnMNU8d9AylcbDhI0m1Q7DlJ+pMXNbMKDYT1nrkhoa/6LkahAv2K7cMLpy25
	 bb/SgExzEAiQJhY7SYGKbQe8NKNicgEqmpKuJ60067SPm5/8eoZSqVhQUjTmFJuzi0
	 8oNvHtWFClLH+tvF6Rn5Puxg/ihB+Z3lq0b0SX0yNfp2WDqHc9Jd5TH19mbPDR52rm
	 46K8D0IxjNFXA==
Message-ID: <7b6ff2bf-c2f3-411d-ab4a-a907d8edbc57@kernel.org>
Date: Sun, 17 Aug 2025 07:45:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/nfc: Fix A-B/B-A deadlock between
 nfc_unregister_device and rfkill_fop_write
To: Yunseong Kim <ysk@kzalloc.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
 yeoreum.yun@arm.com, ppbuk5246@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
References: <20250814173142.632749-2-ysk@kzalloc.com>
 <e3cfdd98-6c51-479d-8d99-857316dcd64b@kernel.org>
 <b8dc1074-725f-4048-9af5-6b62bd2150a3@kzalloc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <b8dc1074-725f-4048-9af5-6b62bd2150a3@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 10:23, Yunseong Kim wrote:
> Hi Krzysztof,
> 
> Thank you for your review.
> 
> On 8/15/25 2:55 PM, Krzysztof Kozlowski wrote:
>> On 14/08/2025 19:31, Yunseong Kim wrote:
>>> A potential deadlock due to A-B/B-A deadlock exists between the NFC core
>>> and the RFKill subsystem, involving the NFC device lock and the
>>> rfkill_global_mutex.
>>>
>>> This issue is particularly visible on PREEMPT_RT kernels, which can
>>> report the following warning:
>>
>> Why are not you crediting syzbot and its report?
>>
>> there is clear INSTRUCTION in that email from Syzbot.
> 
> I wanted to clarify that this report did not originate from syzbot.
> 
> I found this issue by building and running syzkaller locally on my own
> Arm64 RADXA Orion6 board.
> 
> This is reproduction series on my local syzkaller.
> 
> WARNING in __rt_mutex_slowlock
> 
> #	Log	Report	Time	Tag
> 7	log	report	2025/08/14 20:01	
> 6	log	report	2025/08/14 05:55	
> 5	log	report	2025/08/14 02:31	
> 4	log	report	2025/08/12 09:38	
> 3	log	report	2025/07/30 07:09	
> 2	log	report	2025/07/27 23:29	
> 1	log	report	2025/07/26 04:18	
> 0	log	report	2025/07/26 04:17
> 
> The reason this is coming from syzbot recently is that I worked with Sebastian,
> the RT maintainer, to fix KCOV to be PREEMPT_RT-aware. This was merged recently:
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-linus&id=9528d32873b38281ae105f2f5799e79ae9d086c2
> 
> So, syszbot now report it:
> https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3


Syzbot reported it before you pasted patch, so it should also receive
the reported-by credit, even if you discovered it separately.

> 
>>> | rtmutex deadlock detected
>>> | WARNING: CPU: 0 PID: 22729 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
>>> | Modules linked in:
>>> | CPU: 0 UID: 0 PID: 22729 Comm: syz.7.2187 Kdump: loaded Not tainted 6.17.0-rc1-00001-g1149a5db27c8-dirty #55 PREEMPT_RT
>>> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
> 



Best regards,
Krzysztof

