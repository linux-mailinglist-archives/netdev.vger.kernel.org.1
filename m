Return-Path: <netdev+bounces-134761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C3799B072
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 05:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1448CB20E02
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 03:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F3114286;
	Sat, 12 Oct 2024 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YYah/0i6"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AE139D
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728703977; cv=none; b=lgKOR6j/K3NLb7pfeLdDyvCpE5y1PDVqaHkJI9DAdw2ii+g0Wv/pq6DfOsGxdJyihKN1kOWHTEZZyFCeX9uNoK20laVkGWrqXcPByrf/tRUTso+LLjnj+y+lliMvKfXkg9lvKHTKHsyxMNEMQc9bl1dSDzGJiqogl8Ovsu4DnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728703977; c=relaxed/simple;
	bh=N0qJ+wn1fElSxU8qsWpqFsFdHRJwYTc6/QLcAqm3M2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZ9pBiqiufOd2q8YtwDx6T5/2KdXETVR3SjIa5Au0YOheqY1CgSndfurIwceZibcUQCSulf06Dta5vCRFfBHk1s3z0hAslNcAjmxSdCIVSsvVGSR1/wkRnxmwBosou/ZeS6e8BB8F3oCR7osDp4nq0txva7W6WoYpeeBT24eBdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YYah/0i6; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81741c6e-52c7-4384-afc7-ad3ccaffe3a9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728703974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0kvkytFNZfH+DGlBJ3tbwQKE0zOqYmN8G+bnASRXgA=;
	b=YYah/0i65HHmO6/S8str/xPjdCY7ht3w8MyK3R9fwPL9o2lOGmJXABf8QT9paBMoH1tFx6
	vz/PNRXZAK0tmsmxiCRSbw1CN6jCRcIIyDTIUnASAizv3mLdtFk/29+tf8mUeCsHTTqqci
	PUmT9Ia9O7KknapOr54JYfP4J1MFyYs=
Date: Fri, 11 Oct 2024 20:32:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to
 sk_to_full_sk()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Neal Cardwell <ncardwell@google.com>,
 Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20241010174817.1543642-1-edumazet@google.com>
 <20241010174817.1543642-2-edumazet@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241010174817.1543642-2-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/10/24 10:48 AM, Eric Dumazet wrote:
> TCP will soon attach TIME_WAIT sockets to some ACK and RST.
> 
> Make sure sk_to_full_sk() detects this and does not return
> a non full socket.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


