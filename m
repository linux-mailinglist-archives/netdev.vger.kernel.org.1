Return-Path: <netdev+bounces-214574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199DB2A519
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0345658EA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D570D321425;
	Mon, 18 Aug 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GXeAzEkR"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458D022A7E0
	for <netdev@vger.kernel.org>; Mon, 18 Aug 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523038; cv=none; b=GkYrRrm6UZ4/opE4xLg6lj2+2U6M/9FWg/RPLqHqNg07TSUPCfKfy/QjKiNUz8UnUgiUEf3z8w/N1EPNyOUGeT6ipXebmgpJ2KMqxt3zbdZXpnEO0x7/K9zJTgg0oMDwHCOR7gmVOOjQ2XI0gEjq+yjBh6G60eVYM22BovwwaHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523038; c=relaxed/simple;
	bh=MpcR6zGP1MqRWYDeExm5wewsNdlwhT9UXT00/5DHxCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4ntKScbXjc0rHWdv21IivEj0w/hSaq2t8l9VbM73mHIsSTjeOn37P5pC/6/ULqTkaoKOeHJmjukKKc0yV4CZjyy74JxuOyr62qDj9fNvffHoMUf1EseHDA4uJaRm/9KMszQl07FrTeEI1ZvcL2imCJDEGmx4JTQTJzNCeUNqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GXeAzEkR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6848f9cc-a713-4eee-abf2-e4159fea50c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755523033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSXEydqCUgpqaxK0kkyGfyt7rRcqHZdAcZzWgGGOdjI=;
	b=GXeAzEkRK+kZldwRfF/oCk/QQWo2icOcrlIxHA1H4hUrwrOtmZWBPnbfok0LG1ptb6TUhE
	f5O+IW3KgiUO+9W7xihTsarbwW8vF9ushegnmUvpeNdhILNteZ/is2ZCZFcswIMaFh7Nsg
	dSPdsr0p7U2BvV3DSVTigOg5Rmuxwsw=
Date: Mon, 18 Aug 2025 14:17:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Fix PCI delay estimation
To: Antoine Gagniere <antoine@gagniere.dev>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 jonathan.lemon@gmail.com
References: <20250817222933.21102-1-antoine.ref@gagniere.dev>
 <20250817222933.21102-1-antoine@gagniere.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250817222933.21102-1-antoine@gagniere.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 17/08/2025 23:29, Antoine Gagniere wrote:
> Since linux 6.12, a sign error causes the initial value of ts_window_adjust, (used in gettimex64) to be impossibly high, causing consumers like chrony to reject readings from PTP_SYS_OFFSET_EXTENDED.
> 
> This patch fixes ts_window_adjust's inital value and the sign-ness of various format flags
> 
> Context
> -------
> 
> The value stored in the read-write attribute ts_window_adjust is a number of nanoseconds subtracted to the post_ts timestamp of the reading in gettimex64, used notably in the ioctl PTP_SYS_OFFSET_EXTENDED, to compensate for PCI delay.
> Its initial value is set by estimating PCI delay.
> 
> Bug
> ---
> 
> The PCI delay estimation starts with the value U64_MAX and makes 3 measurements, taking the minimum value.
> However because the delay was stored in a s64, U64_MAX was interpreted as -1, which compared as smaller than any positive values measured.
> Then, that delay is divided by ~10 and placed in ts_window_adjust, which is a u32.
> So ts_window_adjust ends up with (u32)(((s64)U64_MAX >> 5) * 3) inside, which is 4294967293
> 
> Symptom
> -------
> 
> The consequence was that the post_ts of gettimex64, returned by PTP_SYS_OFFSET_EXTENDED, was substracted 4.29 seconds.
> As a consequence chrony rejected all readings from the PHC
> 
> Difficulty to diagnose
> ----------------------
> 
> Using cat to read the attribute value showed -3 because the format flags %d was used instead of %u, resulting in a re-interpret cast.
> 
> Fixes
> -----
> 
> 1. Using U32_MAX as initial value for PCI delays: no one is expecting an ioread to take more than 4 s
>     This will correctly compare as bigger that actual PCI delay measurements.
> 2. Fixing the sign of various format flags
> 
> Signed-off-by: Antoine Gagniere <antoine@gagniere.dev>

JFYI, for the next version could you please organize the commit message
to fit into 80 chars per line and specify net tree as well as patch
which you believe introduced the problem using Fixes tag.

More details on formatting can be found at
https://docs.kernel.org/process/submitting-patches.html#submittingpatches


