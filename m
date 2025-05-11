Return-Path: <netdev+bounces-189597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFCAB2B8A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 23:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD3D189648F
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 21:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB4014A09C;
	Sun, 11 May 2025 21:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnHuamI2"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9ED10F1
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746998212; cv=none; b=OKToAT1J7oA1AopXWrwN729xI72eoElNPwymlstRPtMSM8zS/KwgUjNzg9QVXur7zu/v7GUz5aru94vzrfxLdXTn4F3LEt2jHGHR2MuL7DLxyOn1cOPI5XflZQHlHksr67pwtbi9+CefPlO2BFSBStaQFaFKZId39AwcIOsq60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746998212; c=relaxed/simple;
	bh=DEK5x9m00WyglZdPJuAREjUOs2j3FtQ9OTtg8k/kUh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p25iJaW89B0loqflO9KVm1J865hKy1rEgzOAGfHyYysee7sMlXXxmVco6bZUTFEFPWAMTCwJkNHK9LaXhUhbU0DKHRm9ovYR6uEQMlNJg7cfx87NGKsEpuRfF6FoVyjzMjLC4Fk1gwNkf6dHM+CORlAWcE3i+O6c7vtbtrnG92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EnHuamI2; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3bbf0da2-9ac8-4df6-8c02-a552fc599083@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746998197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Sae1PPSkOP1AhspBAsozUQb8lbdc/PF6bV9NDF/DOE=;
	b=EnHuamI2I99nVCz9h3EoahcWEvfqsQIsvRijIT8RurDuXjitWTOTLSU4wu0MLyovqCpL3u
	tf3PF+h6ENGZnCq5YF5nGe8LYlcpPkBYchgzM0EWxEsuSrWutjvAcl3ZYxvy/W3FNYWZiU
	U3ozTbNLZr0fC+h88K92iLMJgFhyol4=
Date: Sun, 11 May 2025 22:16:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] ptp: ocp: Limit signal/freq counts in show/store
 functions
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250511154235.101780-1-maimon.sagi@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250511154235.101780-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/05/2025 16:42, Sagi Maimon wrote:
> The sysfs show/store operations could access uninitialized elements
> in the freq_in[] and signal_out[] arrays, leading to NULL pointer
> dereferences. This patch introduces u8 fields (nr_freq_in,
> nr_signal_out) to track the number of initialized elements, capping
> the maximum at 4 for each array. The show/store functions are updated
> to respect these limits, preventing out-of-bounds access and ensuring
> safe array handling.
> 
> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>

LGTM,
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

