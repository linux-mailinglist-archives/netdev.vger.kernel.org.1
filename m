Return-Path: <netdev+bounces-144992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF209C8F7E
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982121F227D9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F4315DBB3;
	Thu, 14 Nov 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MG/+ZokM"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D28B262A3
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600986; cv=none; b=lmHRI9mZqSFWAlxmMYodajzL58RAFhZPIquc5vMW9/fckoGFa0H+xz9RSm3ql8H+4UcxEat8FIlrFEV5i3/YmADjvzCvB9OvIT/JZQ241rATdP2EstkdnGougHIReWDdakC9P3RHy/4ZoEFVu5wDAIvR8wI19SqlnSmXUoj12ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600986; c=relaxed/simple;
	bh=mHFHn4t/EyBpmOdpPhVG84ehQfiDq556H9EMlvRdlW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvlTdORpN/hCkiEXylP5/551YXx2ZnyafoAMCR9r5UHvjNY8UpiNS8V9N+xhVUamuNIXLCfnfPtUxkaJ7bF3FjWhQt9yVbeZJZw/vLZKHBAOy4SHWH9CEI1hGrScgiP4tJOaLVgI4+A7ep53hS27qWiO+2AdbVJb9wFR+WQwWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MG/+ZokM; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <73b2b454-8897-49ff-8393-0dcb8b69d5ba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731600981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhLrL6xZDaAVGdx5FBoKq/JE8N1BZC18rNxW8cG3LwM=;
	b=MG/+ZokMHcJO11rqkIZQxRk3+tGpLIu90jFGT/9urCOVehojALFFgRaNd2/EZm7/5oq+2A
	ZztGSENBEtuhaT0zxiykSERYXyqag/e2O36FtDuK5J+Cf5DliSVLX4u4k+ns5N4RFtqaec
	ow6y3M1Bpmn/prD2yFWNIKYMqinGe7I=
Date: Thu, 14 Nov 2024 16:16:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 3/7] enic: Save resource counts we read from
 HW
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-3-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-3-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Save the resources counts for wq,rq,cq, and interrupts in *_avail variables
> so that we don't lose the information when adjusting the counts we are
> actually using.
> 
> Report the wq_avail and rq_avail as the channel maximums in 'ethtool -l'
> output.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

