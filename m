Return-Path: <netdev+bounces-80469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9587EF27
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 18:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3021F237EE
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 17:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C5155C04;
	Mon, 18 Mar 2024 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUJ60qAn"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06655C27
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783916; cv=none; b=JczUyh6pJ5pj2GtKzBh8u5NLuGP3v9DsgZ8ILmCIg1ppOO4mnoZOWRc4gNlLJWlPN7u1RAShDs5kFd+a+1Xr4HwgBin50mtg/Oo8jzx7fKUrBIBTomjf4Wu+4xemBRNQvvAPRISdVBv64wKOcmgx506wGY5aIoweeMwTMPjCMg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783916; c=relaxed/simple;
	bh=Yaw8P7cIcZWvI09FWQm7OlGmpHB1wZjneZPbzfUnh5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQnwaxtSfsxmdSIfu37de4IA5jyPX3vYYG0btPLhoneuFl9cUnny73mEFV1RW6aMkf5d38GY6kL8YdhUjnKlhJ5fHhtMq3RRVk2nsccb1iMhJFWzDBDllUuNweZGG4LaZC0UALiXzf4frkvoVS8p1ac1XukuOTuEkFkSK/9TqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUJ60qAn; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8aa1b70e-deb9-4e49-9a6c-059330995384@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710783912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtbqcg2qKelrwJqvKUS60CjZNtxch3FLesIB/MCryZs=;
	b=QUJ60qAnL+kQMfjbv6vF+Z1I0zs3ZxOhTJsIg7qrwGMSLQy1Zl2Bkw45Nn4v3KYFesOAYb
	O+H7vHWN+GoHGI4n+00rk6nqhj4+asehHLRwhN1fjQJuUnl88t3U4COu5u4jBpgT+RRIZa
	DhmSXtsDTXsTy2DMu6SrmxeBk/rRwUE=
Date: Mon, 18 Mar 2024 10:45:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 net] tcp: Clear req->syncookie in reqsk_alloc().
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
 syzkaller <syzkaller@googlegroups.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20240315224710.55209-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240315224710.55209-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/15/24 3:47 PM, Kuniyuki Iwashima wrote:
> syzkaller reported a read of uninit req->syncookie. [0]
> 
> Originally, req->syncookie was used only in tcp_conn_request()
> to indicate if we need to encode SYN cookie in SYN+ACK, so the
> field remains uninitialised in other places.
> 
> The commit 695751e31a63 ("bpf: tcp: Handle BPF SYN Cookie in
> cookie_v[46]_check().") added another meaning in ACK path;
> req->syncookie is set true if SYN cookie is validated by BPF
> kfunc.
> 
> After the change, cookie_v[46]_check() always read req->syncookie,
> but it is not initialised in the normal SYN cookie case as reported
> by KMSAN.
> 
> Let's make sure we always initialise req->syncookie in reqsk_alloc().

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


