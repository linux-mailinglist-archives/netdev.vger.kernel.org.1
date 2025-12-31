Return-Path: <netdev+bounces-246425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1469CEBE40
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 13:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 788ED3007D8E
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17B1D9A5F;
	Wed, 31 Dec 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wK6D9muq"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935FF946C
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767182441; cv=none; b=HdDBAteRVpDWNDOdFvYOBe2SCzARwahR0tgeibsV0vbn1yJboHRJPNviQAwIRDRb6vQn7jBNduH8CJW/GF1t06+I0nEvo8EsmjC0FFW1Qn/j4OPSbbTSmkjJRl6jyUloHFenpRF5tGkiYtVHkMThynTddz2mHJwADq+hXUIx+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767182441; c=relaxed/simple;
	bh=PsvHDaer44hhff3EAfiWWTw5gupPorWFshcTKMIFTP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IelvnybYSwRIdB7CusuLmtwpI6CmOnLIvNnxh1HW05SsLcq7fz0c7Lz2AT3R8Rj3TSrHbNu17eSR8VX3MPqJ9EMzHOU+X0Wzx1J/d785N6A4Gf9RJzzUPYEH0MSqCyUAZ8j+FcqVnI27o/nrp3iTClXFnAijb3k1wMeBapx4KHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wK6D9muq; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e491d00f-69bd-4b9a-addb-b60dab971bbe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767182435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtCdQuYkgOQVT9jCgzpaKlDsBG2MB3Ezb3H9D/CUgpc=;
	b=wK6D9muqP+ld2zl1UD8Zfq9vp08wEKcI7icXLQDYqzShApw60/csuWOJIYoPv1UaSre9gk
	3ipBrdqoA+YC0Ku04C9w8jP0z/P3lzpc6v7auRR9PYd42iKPaYP81RWKDo8mrWbqbb7fpY
	dsaAb1oENGmF9eEE//6QY6c8R29oOcY=
Date: Wed, 31 Dec 2025 11:59:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] bnxt_en: Fix potential data corruption with HW
 GRO/LRO
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, leon@kernel.org,
 Srijit Bose <srijit.bose@broadcom.com>, Ray Jui <ray.jui@broadcom.com>
References: <20251231083625.3911652-1-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251231083625.3911652-1-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/12/2025 08:36, Michael Chan wrote:
> From: Srijit Bose <srijit.bose@broadcom.com>
> 
> Fix the max number of bits passed to find_first_zero_bit() in
> bnxt_alloc_agg_idx().  We were incorrectly passing the number of
> long words.  find_first_zero_bit() may fail to find a zero bit and
> cause a wrong ID to be used.  If the wrong ID is already in use, this
> can cause data corruption.  Sometimes an error like this can also be
> seen:
> 
> bnxt_en 0000:83:00.0 enp131s0np0: TPA end agg_buf 2 != expected agg_bufs 1
> 
> Fix it by passing the correct number of bits MAX_TPA_P5.  Use
> DECLARE_BITMAP() to more cleanly define the bitmap.  Add a sanity
> check to warn if a bit cannot be found and reset the ring [MChan].
> 
> Fixes: ec4d8e7cf024 ("bnxt_en: Add TPA ID mapping logic for 57500 chips.")
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Srijit Bose <srijit.bose@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

