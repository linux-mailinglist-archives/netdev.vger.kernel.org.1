Return-Path: <netdev+bounces-135531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6D99E3CA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358771F23120
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330D11E3788;
	Tue, 15 Oct 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tHCiwZhd"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CA515A85E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987917; cv=none; b=GgjKl0dhaw1OGcLXkZeELg8nflIB5IoFvsCcLa3urv/qSuEfDRsZEQoFbfZB3FHYpBgYlYuWp57xjJE3Ow2l3vgAYj7oIvVv19lIEkQebsqtIbnn+5fFPyrVYwMCHnejvzPe8vrR399rbEBPQF8xI34GZqzly+ne7s4Ueeuj0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987917; c=relaxed/simple;
	bh=i4v1sv+uYRzLEWhIe4dGBUhDEq4X8qWDXWTBvP+rLOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRpBhP3Gxxa61enHaWSdcgibLZ0mHYJcZNt929hGcxAWB3Jktnq/jToy2rwax85g9OatNHGXQMzgglPHTaBPBD8XeMqbVHlcBN7j+OPja4a61nE5TCetGqUZHr4RX5w4jwwEeiseCfeMlD7KzTPoMYBzQ2bFmcrS3HpAaprs1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tHCiwZhd; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f6119ae-128d-48ba-b7ef-d5a610df8a7f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728987912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCRnz3LRfAOPha6Xvf0Xd1177L5hSwQXbV9Ym+UfaL4=;
	b=tHCiwZhdYbl8BYCJ53EBCE40sv4UizgFbmChJSh0O5P8xHSOHjb40gF1PyBXauH+rUua69
	t/od/Tl4pBXhbVWTvywzBjK0khsFFjb3cZtJm9XH3KyuckaR6LRL0WmSk4HKJs7h98A+TM
	sek/PR9TKvCGNUdCFPFmmRNxMM080/Y=
Date: Tue, 15 Oct 2024 11:25:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: replace PTP spinlock with seqlock
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20241014232947.4059941-1-vadfed@meta.com>
 <20241014163538.1ac0d88d@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241014163538.1ac0d88d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/10/2024 00:35, Jakub Kicinski wrote:
> On Mon, 14 Oct 2024 16:29:47 -0700 Vadim Fedorenko wrote:
>> -	spin_lock_bh(&ptp->ptp_lock);
>> +	write_seqlock_irqsave(&ptp->ptp_lock, flags);
>>   	timecounter_adjtime(&ptp->tc, delta);
>> -	spin_unlock_bh(&ptp->ptp_lock);
>> +	write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
> 
> I think when you adjtime / adjfine (IOW on all the write path) you still
> need the spin lock. But in addition also the seq lock. And then the
> read path can take just the seq lock.

I think there is a spinlock in seqlock_t which is used to prevent
multiple writers.

> This will also remove any uncertainty about the bit ops.

Should I use read_seqlock_excl_bh()/write_seqlock_bh() for the bit ops
then?

