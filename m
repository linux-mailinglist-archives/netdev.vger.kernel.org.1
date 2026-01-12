Return-Path: <netdev+bounces-248992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DF9D1259A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF6FD30A1EB5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD3356A2B;
	Mon, 12 Jan 2026 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lV/Q/faM"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FBF3563E8
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768218154; cv=none; b=gEidDJn5oa8rS6WkPOC3S5bU4kjrerxQTMV8G0rDl99GH0n7+bj3azcPy01tfT2N8hkpy2DLbWcuDbuBfMJU3d4j1y2kPdHep3S6cv+/TdwbaUcD2G5Jxd/88ZaLtrcUw4PRskum87pDOKx9NCDMST54BQI7jQgIFwQlJJlcyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768218154; c=relaxed/simple;
	bh=z/ArGWZ0ymurQ9RwS25hqPmwVaTuHQEKtYq863o9s8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rw2INbCgILZr6Zhw8aVmJe/gfvfJFFrn+7q2l5qfMP5nCgyoaUyCdOJuQjZKFVlLR0tjTWy0yYYVKGUeUul2IeCbSUeRxWBnm4k1dmpDPmnAZRVRMVJRY4DIuFRMk2tz8XW3/BTCywVnOUlybsXJLJ941jmoSbWoGuxelau1Ro8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lV/Q/faM; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e500a519-8277-4ddc-be7c-529b64b24860@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768218141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkpHsuvE6V8Bk7Pqpm7Lok7WPhoO3vgdm1OBWx3Et7o=;
	b=lV/Q/faMYufFVo58zKJkIRqEafbT+KpNpulx33db8hdn6J4sI1BWiWOosUf6Ek/cCRBIhO
	KU9bhvsHMYKsn+fdylQwyFXHyi5w0X61+ohFK6XC7nvYu5pGLrGcavFqRxf0SDTOhENyR8
	tRwZyKGE09xb+1e6XCUHMbGgRSSiehM=
Date: Mon, 12 Jan 2026 11:41:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] wireguard: allowedips: Use kfree_rcu() instead of
 call_rcu()
To: Fushuai Wang <fushuai.wang@linux.dev>, wangfushuai@baidu.com
Cc: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, wireguard@lists.zx2c4.com
References: <20251005133936.32667-1-wangfushuai@baidu.com>
 <20260112031021.81853-1-fushuai.wang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260112031021.81853-1-fushuai.wang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/01/2026 03:10, Fushuai Wang wrote:
>> Replace call_rcu() + kmem_cache_free() with kfree_rcu() to simplify
>> the code and reduce function size.
> 
> Gentle ping.

I believe you have to resend the patch as it's not going to be
automatically re-evaluated. And you have to rebase it on top of current
net-next. While preparing new patch, please add clear indentification of
the target tree, the subject should look like "[PATCH net-next v3] ..."
in your case.

