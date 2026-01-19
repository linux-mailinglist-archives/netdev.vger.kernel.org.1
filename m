Return-Path: <netdev+bounces-251316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5CD3B932
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD51C305A2DB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE2B2F8BF0;
	Mon, 19 Jan 2026 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="feYFe0Kn"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E112F9C2C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857241; cv=none; b=e2P1ZOXMqpvdHx618ud16LRxx9P4OlzwGPCShn0vvSz3zVzqKRYAOdaaWfTdPFLu1In+oKfNJ3hhOHCyUPzAOk98RllvwAEi9f+naEU3xcIFn1UobTsOcY3nJ/6EBgxqBvrJSYZO6qQbKccUVgaqRIuihWVuQCdZNZdNrkYMoUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857241; c=relaxed/simple;
	bh=60zxQ8xxDpXFwWGAQWrIv2OAyCUotk6YgSsieV0lJR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R9BtoBbx7480Zu0e+sYvgd9lJ4cLCOXz8cOyPZLrZDyYS/1/hid4/aWs80imIh08U6XXJsSNWLOrm0lL3/iS8aViFbHNknsjx1WMEISyrPUsR48jLk7fFnYWrKCua69C1l6bUk+cQwupFGFtwn6x9ML9XSurUPsxqlh1ZQOaAU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=feYFe0Kn; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c115ac23-9c22-49b9-81c4-c3f4ec987603@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768857236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6SFUW184cVVumUv4hRIYHX8aI8jWvRFpSJoaiWRWhxo=;
	b=feYFe0Knd/StuNKjJtLEeBca4CchTz7Pneh8nmEE52n08QtnYTxdVn5vyG+93LJ6lvbbBQ
	G0QvH7JvPf+KycVZaL0N7yNHaccakyf9izlGunX11dknezEs/J37MLpaprK5MzEseSp229
	25/xwH46VYKFR2LCZoHKXLjP36DjDWg=
Date: Mon, 19 Jan 2026 21:13:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] be2net: fix data race in be_get_new_eqd
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sathya Perla <sathya.perla@avagotech.com>,
 Padmanabh Ratnakar <padmanabh.ratnakar@avagotech.com>,
 linux-kernel@vger.kernel.org
References: <20260119153440.1440578-1-mmyangfl@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260119153440.1440578-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/01/2026 15:34, David Yang wrote:
> In be_get_new_eqd(), statistics of pkts, protected by u64_stats_sync, are
> read and accumulated in ignorance of possible u64_stats_fetch_retry()
> events. Before the commit in question, these statistics were retrieved
> one by one directly from queues. Fix this by reading them into temporary
> variables first.
> 
> Fixes: 209477704187 ("be2net: set interrupt moderation for Skyhawk-R using EQ-DB")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

