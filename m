Return-Path: <netdev+bounces-134563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40099A22C
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B351F2486A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EAF213EEB;
	Fri, 11 Oct 2024 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hrKg3xdx"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC131E3DC7
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 10:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644399; cv=none; b=Y9FdkkVsHhB+FRuSYawzbJ06vD2IRrPR1JKYilrP48MGt7aGsF3MJmN9HNM3aKAOKdeNIWPyMDa1VHK607q3WU3nY/FKJqmwBrepyrVCVO/Rp5C3YiRVhQUTK1BLvc23bsgYJlH9YuJwWO0R0CTK1ygVdul060dv2y679TtBxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644399; c=relaxed/simple;
	bh=YLmqK8TVcBIgysEsqtqaDbl1r6RsMNdtAwPOg8VRyjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkYVL4ipoQUucO4VIrByehGF3DYSDygGwCw6xf7j7tjbJuTNXoyPKXg4b7OVv4/i13oC2ffruvrSfWZO/1S8O+qLcvpFRJmp0oZtEVdNi+j7BUEAb/RfiHpfcLckk5HuLmcbVXQ4wuatDx4YCGI/PEarm0Z0A+7fd1r4RiSDDas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hrKg3xdx; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a33cdd5-063c-4c7f-b803-36ff87ab4080@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728644394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DuNg2hOg/BdiGy5zDYpnPq1RnoVQWZ1hKIvpXV/oLvU=;
	b=hrKg3xdx8NcWW0a/Aum3as7ro/2Mxtndk9arD5s16oTSXAsDwWrrgPBG5x68fpucnyhNpT
	+OY58kTMX6EFxTLVOJAXONRh44R0oQw8NaT8pNTyLUDsNKB+EK2YN4lHXygjJoR5YYT+ks
	Jk06eLXcmMFailg6MtVFSbUNa7Kr0SA=
Date: Fri, 11 Oct 2024 11:59:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] dpll: add clock quality level attribute
 and op
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com
References: <20241010130646.399365-1-jiri@resnulli.us>
 <20241010130646.399365-2-jiri@resnulli.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241010130646.399365-2-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/10/2024 14:06, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In order to allow driver expose quality level of the clock it is
> running, introduce a new netlink attr with enum to carry it to the
> userspace. Also, introduce an op the dpll netlink code calls into the
> driver to obtain the value.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

