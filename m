Return-Path: <netdev+bounces-212513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 567E3B21173
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B385918892C5
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A8B296BDE;
	Mon, 11 Aug 2025 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M6T5Xvji"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A1296BD2
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928521; cv=none; b=rkGSqvhjfKPH0liauUCKSnvFtUbyQqXKpt15q1eqC7+YmF5Ln2tLqx2hoAOetMqYQIAEblq2oux8hWRdclXvSUq3T9y9CxAozwo2hhzOJriPbVPEr5+clu9FT0+HNqhuzMvg+HoBJQDGPTDB4bTOg3bZcPZnRRnkyBTWesW/jYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928521; c=relaxed/simple;
	bh=cXFr1JxulH6FV98g0B9+jAlh3fk+i9iDYPkp/0Zf/ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9C2bjsuYhWhuvmfzXruWm78caw8TRoBwgfqMcM+hrFbBT/55kCttowLOGr5aIJmiCJBrr0wgY0neRpkM/hNK0e6nR/Ewz4HL6WntdwjTfKIZje25DlYh2NJHOSthcRAaER0RKZdcTwMnWCZhPrMrA9ShCKGkppR8qUTTlqROeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M6T5Xvji; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <34da824b-1922-418f-953f-99287443b088@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754928517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBTQ/TlTb6tmtqhEpFdAkTjWlfA/en264UPaQXZjsno=;
	b=M6T5Xvji5GkxwoqdFCtbl5IA5oblvaWz9wJ4eM7PN/ADfC2dQs6ANZyoGUeFUuxINIggVb
	nE0zsblmu+1Zgb02MIZ1fIGWHPu39Fg3dgiYFC8bNwGxGo42MIG3w8m6cbsZJWw7leLV9H
	T1uGmrOqtOh98ghB33C22sXf7I6HRx4=
Date: Mon, 11 Aug 2025 17:08:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4] ethtool: add FEC bins histogramm report
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250807155924.2272507-1-vadfed@meta.com>
 <20250808131522.0dc26de4@kernel.org>
 <ec9e7da6-30f0-40aa-8cb7-bfa0ff814126@linux.dev>
 <20250811084142.459a9a75@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250811084142.459a9a75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/08/2025 16:41, Jakub Kicinski wrote:
> On Sun, 10 Aug 2025 11:52:55 +0100 Vadim Fedorenko wrote:
>>> TBH I'm a bit unsure if this is really worth breaking out into
>>> individual nla_puts(). We generally recommend that, but here it's
>>> an array of simple ints.. maybe we're better of with a binary / C
>>> array of u64. Like the existing FEC stats but without also folding
>>> the total value into index 0.
>>
>> Well, the current implementation is straight forward. Do you propose to
>> have drivers fill in the amount of lanes they have histogram for, or
>> should we always put array of ETHTOOL_MAX_LANES values and let
>> user-space to figure out what to show?
> 
> Similar logic to what you have, you can move the put outside of the
> loop, let the loop break or exit, and then @j will tell you how many
> entries to fill..

I see. Fair, I can do it. After this change there will be no need to
change the code in the reply size calculation, right?

