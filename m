Return-Path: <netdev+bounces-144598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640A99C7E53
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 23:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3883B226F4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8C17A597;
	Wed, 13 Nov 2024 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OlL8orMj"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85FA33CFC
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731537544; cv=none; b=LFkjMIikXjTqtoT9mlufm2/vpIgXr82ifoiXvaS7TDmAF626/Xg2ySs8J9Gcmc4G/6isiM68U2l3qpVQvKN6vZyCBfcbXyYkruhizbaYdBWWg/zNDm5TwZWd7t82aAvNhqxEN4fm09cBSXOnnb2mWEpC6jtwr7s3qsaWyzq2aQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731537544; c=relaxed/simple;
	bh=1YnCSZkE94OioJl0N17ux60su9v06F7+HmGUymJhPG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTZa+MK7wfxS6++U2bXLRIck3d55CrDUeJ1YD1OoxJeyceycsXF89eBO9/gtaULND8dKQ4VObDpEogHhK2cjRjw5KnK7E6Pdw/CstkUWzs4MXeQC4V1glBcwLQubSZ1wqGwAW28uH3KtDCnUpSt8FPw4vZoKwKrusOUDiGvbz2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OlL8orMj; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <03ccdc24-27af-4b4e-baf3-40d89ae72e99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731537540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHHjKUL/kzDAlNV+4InhVEstH+waskfQsZNfc86kp3k=;
	b=OlL8orMjRTl36zRIhapsRW+bcZaso6rfs1Uf8cKK1zl6fnEiEjXGhFD3X2xNJyaCMmgB05
	pTf3ZMHp16GJsGHXarvEz4b3gkhTysNpqYaatA4lTPAAyMBR2WR1t9rF1FZ6VcOG9pFDsH
	TaJlz2QWeuLpVxr+3edUTAhO7pPY4H8=
Date: Wed, 13 Nov 2024 22:38:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 1/7] octeon_ep: Add checks to fix double free
 crashes
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
 <20241113111319.1156507-2-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113111319.1156507-2-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 11:13, Shinas Rasheed wrote:
> From: Vimlesh Kumar <vimleshk@marvell.com>
> 
> Add required checks to avoid double free. Crashes were
> observed due to the same on reset scenarios, when reset
> was tried multiple times, and the first reset had torn
> down resources already.

I'm looking at the whole series and it feels like we have to deal
with the root cause rather than add protective code left and right.

The driver may potentially have some locks missing which will cause
missing resources, and to fix the root cause these locks have to be
added. WDYT?

