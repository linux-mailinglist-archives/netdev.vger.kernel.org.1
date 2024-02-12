Return-Path: <netdev+bounces-71101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDECE8522BB
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 00:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2302841DF
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059244F8BD;
	Mon, 12 Feb 2024 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qip8qF1T"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4041D4F8A3
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781499; cv=none; b=d+B3glaBHH99j2btIni6DqcDnwgGiF5FYwelFChRo1rp5O4TQC1SRtD8GVhbQBqoT3bFGtjQeJBynv7gLnH9Pagl3K1TueEPWYfWIS3OMLJ26gQNvTdlntdj+3FLQMhVav+mdfP5Yg+ZE4q3ENT/8UUYdNkfNWSZI1EUSt+5XoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781499; c=relaxed/simple;
	bh=Z28MLzWIq6XhmaHA7O/gZ4XRNwcXR9VOnUBc70YQUkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayM8nSpVT4z8G4iQr1mgUJviMbJB0PPd8ToWhHaJWz3n/Zsg6p4WS+e4JtbueZLwUCJ2U8ZuWZg4jl7zkA5LjhdY2FUO0PP7i59p4piftPXlk3F0LOp3j7Fz5b2WxlxrTWPUCqwI6XBWI5F8igeHz1FdbqOngOMvRjtsSGLIBJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qip8qF1T; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <567a7062-9b4a-42dd-a8da-e60f948a62f0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707781496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wRkwZ5e0EGBB2t3Z96d6Oh7/l3VVZPOYz80fjbC/Cw=;
	b=qip8qF1T5txVvbFI7QQ1eHN+VP7X/lcaxG04p1A/SSYyeJLO5eNuJX9YPVEd8+dpcwwU/j
	dlT+keu5q9ra7DgvcurnV/HCGrfhtl8ulV/7kOBDfv5aqwMLvz6sc8xCAhC6dquS/Ar6hV
	Re5kQpcQUECQtomU6vXhKICFY4KuwQc=
Date: Mon, 12 Feb 2024 23:44:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net-timestamp: make sk_tskey more predictable in
 error path
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Vadim Fedorenko <vadfed@meta.com>, Andy Lutomirski <luto@amacapital.net>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org
References: <20240212001340.1719944-1-vadfed@meta.com>
 <65ca450938c4a_1a1761294e3@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <65ca450938c4a_1a1761294e3@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/02/2024 11:19, Willem de Bruijn wrote:
> Vadim Fedorenko wrote:
>> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
>> the sk_tskey can become unpredictable in case of any error happened
>> during sendmsg(). Move increment later in the code and make decrement of
>> sk_tskey in error path. This solution is still racy in case of multiple
>> threads doing snedmsg() over the very same socket in parallel, but still
>> makes error path much more predictable.
>>
>> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
>> Reported-by: Andy Lutomirski <luto@amacapital.net>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> 
> What is the difference with v1?

Ah, sorry, was in a rush.

v1 -> v2:
  - use local boolean variable instead of checking the same conditions 
twice.

