Return-Path: <netdev+bounces-190485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEE4AB6FC3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB46160E4F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B0F219E4;
	Wed, 14 May 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="faZGfs+V"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884013C3F6
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747236355; cv=none; b=RA3Heqslnixi9XKSkMoL5+i+CerWX5LKWgrvW3TUWa4Vfwz+IP0ZBVdqNRT04C4CxKmCGp2RRTepo7eS+G10azsFs5x33RYlf+ZXsixbxUuLXg58dxbfr7+n+UYqnlcA5stp7liYpnP5BiYmqgs+t6CzSWU43EWDXcYwYyANgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747236355; c=relaxed/simple;
	bh=CBr3S/y5LhzyciBlH6r1PxR5BG5UxI5VcLXXtJkCPgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMZgTGcj/2ZNJiKYMEpkwrPTaqNNu5M9K8XJSpiAHfhQ7ulIgMLnbiEz3Ct/2NXNy9APM9bVAW12Zt8YEsD/BEAnzoVt9nBaK4O3eVdk/ieb2Kiw6ROixLOqhw6KIKTRETHmRDWgH0cX55NyNWEty6mykS94w8kjPH8xxYoh0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=faZGfs+V; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c2d4a2ce-8af6-4dda-87e5-2cff14fd14b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747236349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yQSYDWezbNV21vgdWfdVBPv3c/3Kd+d9bLVRsIUhXrU=;
	b=faZGfs+V8H5XPMlWt1phf2/UhaDQZY5DJDC3rzmEvYEcxX6N+GvbMOLAZqClO+b6vee89T
	0YBcxZO2VgGsIGBPkhFjWvp7Peg2QGSYBgIKJfP+65Ec/h4wFjOuX9gSVo1UOmRurolwPt
	sFsGppo/n4BqFOOKIQY5SNBtAIRrXVA=
Date: Wed, 14 May 2025 16:25:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: Add sysfs attribute to show clock is safe to open RO
To: Andrew Lunn <andrew@lunn.ch>, Wojtek Wasko <wwasko@nvidia.com>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org
References: <20250514143622.4104588-1-wwasko@nvidia.com>
 <64de5996-1120-4c06-9782-a172e83f9eb3@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <64de5996-1120-4c06-9782-a172e83f9eb3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/05/2025 15:54, Andrew Lunn wrote:
> On Wed, May 14, 2025 at 05:36:21PM +0300, Wojtek Wasko wrote:
>> Recent patches introduced in 6.15 implement permissions checks for PTP
>> clocks. Prior to those, a process with readonly access could modify the
>> state of PTP devices, in particular the generation and consumption of
>> PPS signals.
>>
>> Userspace (e.g. udev) managing the ownership and permissions of device
>> nodes lacks information as to whether kernel implements the necessary
>> security checks and whether it is safe to expose readonly access to
>> PTP devices to unprivileged users. Kernel version checks are cumbersome
>> and prone to failure, especially if backports are considered [1].
>>
>> Add a readonly sysfs attribute to PTP clocks, "ro_safe", backed by a
>> static string.
> 
> ~/linux$ grep -r "ro_safe"
> ~/linux$
> 
> At minimum, this needs documentation.
> 
> But is this really the first time an issue like this has come up?

I haven't seen such kind of discussions previously, but it's more about
netdev area only. The original problem was kinda hidden because all
modern distros had udev rules preventing non-root access to PHC devices,
which effectively means no strict access checks are needed. I cannot
find a good example of device with the same issues quickly...

> Also, what was the argument for adding permission checks, and how was
> it argued it was not an ABI change?

The original discussion was in the thread:

https://lore.kernel.org/netdev/DM4PR12MB8558AB3C0DEA666EE334D8BCBEE82@DM4PR12MB8558.namprd12.prod.outlook.com/

while the change has landed in:

https://lore.kernel.org/netdev/20250303161345.3053496-1-wwasko@nvidia.com/



