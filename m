Return-Path: <netdev+bounces-205187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55758AFDBDC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 655E53A6B32
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE85021D3FB;
	Tue,  8 Jul 2025 23:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R6/vCxZh"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423921507F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752017430; cv=none; b=NMP3kBhHmsdyEZktmp7XHXIK+v14jh/F3x9yTSSGblymJVmMbcnTA5y7oOMJASdhuPNJEc3m/Fia1D3MvLzUG7S5H4cOhTb+IRCTQymglP2KRSZRp38NP8OcC8QDodLPSVS9KGxhwcyMJxshkDVF89fUTtMB2egWkfVafPFvbaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752017430; c=relaxed/simple;
	bh=d4W6Hw8mCw+qOd3RX1XWTGnS8beCypnwsTbFXBMS8Xw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V6gPfOuJBxx/DbEgp9mCztTXlbkkWouvLRrKVvzqu7NEA30Q2aDyYFUOb/G3BjuN9GXXzE8RggrvdnmLWUTbBJ/PDTZOYsxKnPtNWkQW8a8n6vOmAO+isHceNokNJxkAdMxUCF7Zt+PNnrOMsYi3wqm/mYdfRwQ+j7sFG7Vlmd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R6/vCxZh; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e96aabd9-1519-4bc0-a8eb-776d3d224398@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752017416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vDiXk0pU15EXqulmH9aLX8Igv2nZEowTnBxXp3f2pG8=;
	b=R6/vCxZhOvVnNsKLM0wkdB1ZcFHLFARzFcrAM80A3O7OV/FOsAioYls/yuYJEK1tNYUPRL
	I8ec4Xf3MbjfHxtQ+x/MYWzTTe4i49dDQefBfpI90AgLjk2RzD24+tw+fm1soKpJ2JqlVJ
	L6MkkT7xAh3+7Gc//1VMDRNxYGG35E0=
Date: Tue, 8 Jul 2025 16:30:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 02/12] bpf: tcp: Make sure iter->batch always
 contains a full bucket snapshot
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jordan Rife <jordan@jrife.io>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-3-jordan@jrife.io>
 <88507f09-b422-4991-90a8-1b8cedc07d86@linux.dev>
Content-Language: en-US
In-Reply-To: <88507f09-b422-4991-90a8-1b8cedc07d86@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/25 4:16 PM, Martin KaFai Lau wrote:
> 
> How about directly figuring out the next start_sk here?
> The next start_sk should be the sk_nulls_next() of the
> iter->batch[iter->end_sk - 1]?

I take it back. iter->batch[iter->end_sk - 1] is not enough. It still needs to 
do the seq_sk_match() test. I can't think of a better way. Agree to keep your 
current approach.

