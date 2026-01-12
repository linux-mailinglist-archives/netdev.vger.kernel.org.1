Return-Path: <netdev+bounces-248999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9F2D127EA
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E11843000E8E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82762D8383;
	Mon, 12 Jan 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P/osox+N"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3502D063E
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220177; cv=none; b=S1X32VzVYNGMMERmBnBPmAs0YdLRGXmrwChwsNNXD/dT8FvVo/05NKHtNGyR5Mwg5IwFGKYhweotxUDH8NlIvRd3bLOlZrZtP1L/JOMYPgKsn2uXhOS8OxNcCwbsoRAphdLx5Nyd17SmjFmUSWpraKqkRHYG34Bi9cvnVXZ0ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220177; c=relaxed/simple;
	bh=Wby5pbdHdinyNuXLsFl325fcmFwTqK/T+r+vbQV3SXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0ru0vzHxQ93m00VbCTQVqCu12GltS3JIBi0LxWNfi3RQS+QrOML014g8T2NsH9dF8qR0OA+rbeu8ALNgDTNiI/P6j0A9DG7peM+qyX/GzFo67OMgJhyB7aupinOCtAg0DkpEJY6qrALliCRaqV3C78RteA4qiFrhsetAPSTnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P/osox+N; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a32849d-6c7b-4745-b7f0-762f1b541f3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768220164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kQOVXHvilFwT2FBnezNb20RaGtDqm9YgbZmZmrCoGto=;
	b=P/osox+NY4xQtjyJmj+VCJmeEbGjsEtbj77i5VxoBNeSBT8EvnUzJSMpKnDoSsn4WaC6bl
	mtClrW/QQkhq72pJC8M/u2erWIjlkVE0zrbVLc33Jb5ArL9AU1kwNoCVw4XdOU3Rxf+5JE
	gefLsSj51b6M6XmEy2c9A+BDgCSUy6U=
Date: Mon, 12 Jan 2026 12:15:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] Defining a home/maintenance model for non-NIC PHC devices
 using the /dev/ptpX API
To: Sven Schnelle <svens@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, David Woodhouse <dwmw2@infradead.org>,
 virtualization@lists.linux.dev, Nick Shi <nick.shi@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-clk@vger.kernel.org
References: <0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com>
 <yt9decnv6qpc.fsf@linux.ibm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <yt9decnv6qpc.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 11:00, Sven Schnelle wrote:
> Hi Wen,
> 
> Wen Gu <guwen@linux.alibaba.com> writes:
> 
>> 1. Reorganize drivers/ptp/ to make the interface/implementation split
>>     explicit,
>>
>>     * drivers/ptp/core      : PTP core infrastructure and API.
>>                               (e.g. ptp_chardev.c, ptp_clock.c,
>>                                ptp_sysfs.c, etc.)
>>
>>     * drivers/ptp/pure      : Non-network ("pure clock") implementation,
>>                               they are typically platform/architecture/
>>                               virtualization-provided time sources.
>>                               (e.g. ptp_kvm, ptp_vmw, ptp_vmclock,
>>                                ptp_s390, etc.)
>>
>>     * drivers/ptp/*         : Network timestamping oriented implementation,
>>                               they primarily used together with IEEE1588
>>                               over the network.
>>                               (e.g. ptp_qoriq, ptp_pch, ptp_dp83640,
>>                                ptp_idt82p33 etc.)
> 
> I'm fine with splitting paths - but I would propose a different naming
> scheme as 'pure' is not really a common term in the driver world (at
> least in my perception, which might be wrong. How about the following
> instead:
> 
> drivers/ptp/core    - API as written above
> drivers/ptp/virtual - all PtP drivers somehow emulating a PtP clock
>                        (like the ptp_s390 driver)
> drivers/ptp/net     - all NIC related drivers.
> 


Well, drivers/ptp/virtual is not really good, because some drivers are
for physical devices exporting PTP interface, but without NIC.
Another way is to split physical board drivers to another category, like
drivers/ptp/hardware. The main difference to virtual is that these 
devices can output signals on external physical pins as well as
timestamp inputs on physical pins.

