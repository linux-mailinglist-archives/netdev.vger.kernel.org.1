Return-Path: <netdev+bounces-218480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D9B3C955
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4236D163B17
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02BD238171;
	Sat, 30 Aug 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AG9vcvX5"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FD10F2;
	Sat, 30 Aug 2025 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756543318; cv=none; b=g1WGnedxrWCWvym2XXmecrMVU14asjwxP4IkQ38FOaKINLKGgiz/TeKDpWdqtAZZVo//+DlLg4SXtNkq9ZFgi/J+4epnP5xbIn9HFANAIaDSypdcSdKoXNq1MWFQEkAg2dQ70qTqaaHhomjiBVu+cvp3/knc/d1/rNPE1kw5pvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756543318; c=relaxed/simple;
	bh=o+yIQzqvQ4d3z6N5T54GMJi/nUCGW8bOqpuNWGyTJvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGIT0hBKzbzUedoq2P2u+VVuZ9T1Cb3D4ovMCMhkFuXdsm7k3aW1p21P7uw0xnQg3kzvcVk0ni3wkaq/4YjhTZoeHzrMwdYiav5kYjnRLrCIBd/YLuGz2AoJ/vmCIkIapxj+VnZS0QupUVEOX8LwhAejt1Xpa4YZ9iFfjAmubNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AG9vcvX5; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756543306; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Wu7VQ2Nvsp7VkmmfbcK/pvzLzFPctqTJgaELSbvjv70=;
	b=AG9vcvX52bJsaJLF6ArL6HSDIUnsNkJPwYE6lm9rR0/ACmoD4e6gti19AzX/GmhptwwrZ+DZl2cewHbJRyNrYaRust33QvYSz58JREcHqr93TFS44cIeRv0bJvkGAyoPQiTeQ+/f3RfkWIBPAr0u6/BCgemDQcxcxMFBxZECPXY=
Received: from 30.221.32.123(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wmtnd4e_1756543304 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 30 Aug 2025 16:41:45 +0800
Message-ID: <b49d3c1f-6682-4230-b4b1-44bf3597c326@linux.alibaba.com>
Date: Sat, 30 Aug 2025 16:41:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
To: David Woodhouse <dwmw2@infradead.org>,
 Richard Cochran <richardcochran@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org> <aKd8AtiXq0o09pba@hoboy.vegasvil.org>
 <91008c3cd2502b3726992b0f490aac54a1efa186.camel@infradead.org>
 <b4c54718-648b-44e6-baed-2a08f287c24a@linux.alibaba.com>
 <0086c70c375089245b5abd120f22c0af8b6cf0c2.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0086c70c375089245b5abd120f22c0af8b6cf0c2.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/8/22 15:43, David Woodhouse wrote:
> On Fri, 2025-08-22 at 10:07 +0800, Wen Gu wrote:
>>
>> Hi David,
>>
>> How does vmclock work in a bare‑metal scenario, given that there is no
>> guest–hypervisor architecture?
>>
>> You mentioned "vmclock over PCI", do you mean passing a PCI device to the
>> bare‑metal? What is this PCI device, and which driver does it use?
> 

Hi David, sorry for the late reply, my mailbox misclassified this mail.

> It would need PCIe PTM to synchronize against the host's arch timer or
> TSC, which you said you don't have on the CIPU. We don't have PTM
> either, so there is no existing defined PCI device.
> 

I see. that's what I thought, in our scenario VM and bare metal can not
use a unified way based on vmclock to achieve PTP clock currently.

> I'm in the process of writing up a specification for the vmclock
> device. It doesn't really contain much information that isn't already
> in the QEMU and Linux code; it'll just be an easier way to find it
> rather than reading GPL'd code, which is problematic for some.
> 
> I *could* add a PCI transport, but I figured it was easy enough to do
> that later if anyone implements one.

Understood, thanks for the update.


