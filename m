Return-Path: <netdev+bounces-131266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23698DEBD
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B461F21321
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9071D0DE2;
	Wed,  2 Oct 2024 15:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O3Rsu7JU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sj7/LR0n"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2451D0DC7;
	Wed,  2 Oct 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882315; cv=none; b=PFXU3aWBWfxxziHwdm7dQxAbO3KFk2Vubpkz9HkGTGXPvkqda7nC6eT9bUeQG7ODj9SDqZL4teCpMHsNlzCgri+95ZAGEEsh9Nt+mkHvrQRggmS9m2EO4mP9e5bA30WnHwwbpKxqbM90hGCYCtgyprTTrTql5vYzidhHzs5aVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882315; c=relaxed/simple;
	bh=az54uQbUII9u2TKFXypoavPG2GEocop/x2pFhZnmmYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sCcFifU69td2kRraiGprlNbBiQAXvgz2KsTe2ryqzZSpzlTzYpx2AxwiQGpwe8ywgzmi71XTFjIxI6T5Gqzzbadt5L3LgUhzitvkfdhj4aixrGRsZEvdmEi5eTmuV3O2D8jvxkQ8+QqEdkFaK1iYj/+8v9UgmLmo8hOoXiT9KGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O3Rsu7JU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sj7/LR0n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727882312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3zVQwCiqxBvZp6eya5RF038vFKpaXYGJ8ryPke/gWs=;
	b=O3Rsu7JU36qwteWTxtMKhA9rZsHHhoOcosZ3RuYztg/DGOyNHjBevqjjOeI3q8Qkcq93AN
	qvHaD1JlJo8JCN5m+QQje1H1jSeTpVOFad/wt4Q4vGv9chfD76yOAFZTU2wAvCJx8ddk0g
	ZDypmWxqzN+7TFEA+QZcQkvtQT3YG208PMO4ET7sXTg9AZ+hJ02FHiupQJlUT7azRkFBrQ
	kP7Ibb28JyOPBFx3XnaO6LC/GpSKYhNCWnzV9d/m610tZm1eiWX7gSaG2mR0GjOOopNp0P
	F9AlAgqt8MTZPrjcGwKFV78HLNg5qHMQO5sen1Pkvvs3MoKNxfN0TzNo/2bqgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727882312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d3zVQwCiqxBvZp6eya5RF038vFKpaXYGJ8ryPke/gWs=;
	b=sj7/LR0nkYv4i5kkFSTUIEjhXPx6udW7uxolY5XzN8df7bZPFbpTZ1U+eN/pcwZq2OoyCG
	lu7ZFcBUedzKfUDA==
To: Simon Horman <horms@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
 frederic@kernel.org, richardcochran@gmail.com,
 UNGLinuxDriver@microchip.com, mbenes@suse.cz, jstultz@google.com,
 andrew@lunn.ch, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4 1/2] posix-clock: Check timespec64 before call
 clock_settime()
In-Reply-To: <20240914152318.GC11774@kernel.org>
References: <20240914100625.414013-1-ruanjinjie@huawei.com>
 <20240914100625.414013-2-ruanjinjie@huawei.com>
 <20240914152318.GC11774@kernel.org>
Date: Wed, 02 Oct 2024 17:18:31 +0200
Message-ID: <87o742wn20.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 14 2024 at 16:23, Simon Horman wrote:
> On Sat, Sep 14, 2024 at 06:06:24PM +0800, Jinjie Ruan wrote:
>> As Andrew pointed out, it will make sense that the PTP core
>> checked timespec64 struct's tv_sec and tv_nsec range before calling
>> ptp->info->settime64().
>> 
>> As the man mannul of clock_settime() said, if tp.tv_sec is negative or
>> tp.tv_nsec is outside the range [0..999,999,999], it shuld return EINVAL,
>
> nit: should
>
> Flagged by checkpatch.pl --codespell

...  man mannul

Flagged by my taste sensors.

