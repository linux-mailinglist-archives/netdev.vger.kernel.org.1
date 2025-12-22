Return-Path: <netdev+bounces-245684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AEFCD5694
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 626A230726CE
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 09:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139ED26ED2A;
	Mon, 22 Dec 2025 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIHrlTWG"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89330F551
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396850; cv=none; b=Y5/cHiRctdmLNmQcCV1F5pjZxfOYIM+xPeLduwpS7XiJGuIOUn136bmdicIGVkg8DT+3qPbBbRAB+81Htyml4UyvAxrmYP6u7Ix4iUQya8q4PgDcj4Woyja4wJ70Fn696ht9g3g724uPyUBFbl6GaCGIPhvqpR4hFcKaXwJm1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396850; c=relaxed/simple;
	bh=93Zz3354BHI3jM5m4o0Mr2ghv4l2B+zGOjcGpIsIS8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHFsaj4DeYoQuy33ozEmvoI/MMedqTLxXj7wIX0ffiPPh8qqofLKeqlX0of7T6qpQ2+JmwfPmpMx8RFWJNy9JhjHqIoTxpfFWk9adv7G7ITwdU2zXQACRuNe7LFH0bhArZiE34u1PX8+COx2AFifSmT8wnO3vDmlMjjB+4Zwb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIHrlTWG; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ab8135d-75b8-4aa0-b5ce-f917e4a34e18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766396846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NqDkL+AFsWXO5jQITqF7JZzCY4uwrX0O+H/jMAMEuMo=;
	b=aIHrlTWG7s6PI6su2cDgK92uGHjlh7AQtO+JKk1yLeLcmVn3m/NlJMEL+o1bKqYfkhkGbW
	t2/3B2r2GwWzxB7pEzPuAwlD7JYQt0nHT2qO5+XNmiFwDNYATOCMhjg9WFLmy/txBIDD51
	+bpYNa3Dfvsl8pLG1Fw8LdVhR1Bb5R0=
Date: Mon, 22 Dec 2025 09:47:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net 1/5] arp: discard sha bcast/null (bcast ARP
 poison)
To: =?UTF-8?B?TWFyYyBTdcOxw6k=?= <marcdevel@gmail.com>, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, dborkman@kernel.org
References: <cover.1766349632.git.marcdevel@gmail.com>
 <99815e3b40dccf5971b7e9e0edb18c8df11af403.1766349632.git.marcdevel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <99815e3b40dccf5971b7e9e0edb18c8df11af403.1766349632.git.marcdevel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 21/12/2025 21:19, Marc SuÃ±Ã© wrote:
>   
>   /*
> + *	For Ethernet devices, Broadcast/Multicast and zero MAC addresses should
> + *	never be announced and accepted as sender HW address (prevent BCAST MAC
> + *	and NULL ARP poisoning attack).
> + */
> +	if (dev->addr_len == ETH_ALEN &&

dev_type == ARPHRD_ETHER ?

> +	    (is_broadcast_ether_addr(sha) || is_zero_ether_addr(sha)))

RFC says that neither broadcast, nor multicast must be believed. You
check for broadcast only. The better check would be:

!is_unicast_ether_addr(sha)

> +		goto out_free_skb;
> +
> + /*
>    *     Special case: We must set Frame Relay source Q.922 address
>    */
>   	if (dev_type == ARPHRD_DLCI)


