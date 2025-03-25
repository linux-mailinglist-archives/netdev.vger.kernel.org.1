Return-Path: <netdev+bounces-177410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD41A7018B
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D093B41C4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD0264A81;
	Tue, 25 Mar 2025 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DDalLAdL"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B8264A77
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907116; cv=none; b=G5OkrjKRGwPUU1QG68FyfgJ8NHrf40iqwNls+pJBs9Jgf4Ey/G9JbkzsIE9+emrPWrtjcqse7KmQdN4BVYibxs462RCPjxEIVwB3eBEfnb6/VgyuxxVGy6WtiBJ/EObObamM3+AFr0CxkqHRjzpuu8lX9RLqTt8mZfppYGsfR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907116; c=relaxed/simple;
	bh=04WyPtnaqXX/qjdJRYC16LNgsnbV5owsAL6ATqenmEQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gQJHiL9YgUxAkkKWAfBlP0+ERY/rAoobvh77ELXoi74LfBVMkPYVAXzYj9MYn3KzVEXOcvOGvOQCucqhhg/gkw8EgpGFYyU5YOywBwWXieH+opjOIqBbgV1XU+GKwEW8QgLAG7G/Je8i23JjlN1NmQrkbnUoCUumP1SdkEz6dto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DDalLAdL; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742907102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOe5X9hTl3U+JuiEs3iaGAEn3PxEP3IbrqzHiKu85PU=;
	b=DDalLAdLc1qsrGojQfDv+X25eSAk9RrKF+RV8ZtD97V3nbAiMOhFWvAKek/ziJqHzxMzFo
	KJioyNTcyN+0FbwfqSSrxT75ynzhZo4+MPlOXhd5HPXdxqB4Wikq7M2pfZZDVSuWvz1Y/I
	zUOfOR9vV5WiNaEJvdDw1tUNIAN6BT4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH net-next] mptcp: pm: Fix undefined behavior in
 mptcp_remove_anno_list_by_saddr()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250325053058.412af7c5@kernel.org>
Date: Tue, 25 Mar 2025 13:51:28 +0100
Cc: Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7EEE7001-CCD4-4A5A-8723-3AAC3A88F6FF@linux.dev>
References: <20250325110639.49399-2-thorsten.blum@linux.dev>
 <7F685866-E146-4E99-A750-47154BDE44C6@linux.dev>
 <20250325053058.412af7c5@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 25. Mar 2025, at 13:30, Jakub Kicinski wrote:
> On Tue, 25 Mar 2025 12:33:11 +0100 Thorsten Blum wrote:
>> On 25. Mar 2025, at 12:06, Thorsten Blum wrote:
>>> 
>>> Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
>>> removed a necessary if-check, leading to undefined behavior because
>>> the freed pointer is subsequently returned from the function.
>>> 
>>> Reintroduce the if-check to fix this and add a local return variable to
>>> prevent further checkpatch warnings, which originally led to the removal
>>> of the if-check.
>>> 
>>> Fixes: e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---  
>> 
>> Never mind, technically it's not actually undefined behavior because of
>> the implicit bool conversion, but returning a freed pointer still seems
>> confusing.
> 
> CCing the list back in.

Thanks!

The change imo still makes sense, but the commit message should be
updated. I'll submit a new patch for after the merge window.


