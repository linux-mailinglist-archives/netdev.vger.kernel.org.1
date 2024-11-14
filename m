Return-Path: <netdev+bounces-144991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2EC9C8F79
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E4A1F22793
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E689154BEE;
	Thu, 14 Nov 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vL0DfT99"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8F22098
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600931; cv=none; b=FG3CqYJQAxkb2AbpzSOmcNWATCvzrm4yoRMaiCeqnX+vtzDD03cyhQmHUu2oA9pbqdeHBD1mdx4BchKD+MyLfedAbiotMnYrOMfxsip7ZcdtHD7sDsGUINztKttgvNYcazHZngpqkHm+VzFROuMM5j0jXt68IlXWC8NQ3GpUD4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600931; c=relaxed/simple;
	bh=889lIaoh8cyJx6WnEnFtODlIFsXaeD5DVLqZiRFOIss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8Grov2Pgy05g/NAek37VL3L80X6ykg/Dpzh9bO18aptt0PWVqzsiZ5ti7jRq7Er2gYTgG2D27C/51pYOTeeSISGG4dCdjw5XmV6ShSwTVmo8VF+Tao7B91AHMyjATk8BuARsVrdfsAskOEX/xS9s62X4pN4c0vsqWls3PDWE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vL0DfT99; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <94ef681a-a96f-41a4-bd08-398931d47987@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731600924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ph0a5hVZtOyWVEA97NBFnui489BrVg6kXaYqBXvefuU=;
	b=vL0DfT99sLbe1thpqHp4EYuY5WRG20l6S/LHHqdU39gE8E92RIWCTdSa01IwHP8Fd0aVZL
	XqI6m3UVAiaHy206hERkQd2YYbulr16TFxWJk8jjxWhQ2ljgm6vAjKkVn0ii6O9TlRqwr/
	Redlhs9cDCRUB3Py/DW/fx01BeUm4q8=
Date: Thu, 14 Nov 2024 16:15:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/7] enic: Create enic_wq/rq structures to
 bundle per wq/rq data
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-1-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-1-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> Bundling the wq/rq specific data into dedicated enic_wq/rq structures
> cleans up the enic structure and simplifies future changes related to
> wq/rq.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

