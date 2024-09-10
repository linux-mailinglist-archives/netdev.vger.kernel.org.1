Return-Path: <netdev+bounces-127008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DB9739D7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F0F1F24E92
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1281946A1;
	Tue, 10 Sep 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NisEID3z"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86A61922DC
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978581; cv=none; b=L3q8S/Lb6bQxC141135DxOqNrYfJQvyVwZYGN6PsyVDEOIcJMc4GdWDNwUWD5kJKlCQUoHDRNL/aHcieZpUQB47YCVJ9ubBdyvDBwLpK2EzJyssdUbSbyncQKnHM6U2RQJDr7r62C9RRx/4G/8wB3BH3tXy1Nv3ZzJcaIG4NGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978581; c=relaxed/simple;
	bh=NMNHk5SuzzFYllyXQY6O/Oq1dqoBby9n380xslSuvkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQbw40FgmtxvwDgnPild4vhMvM2ghBR5YrOna+dHpqNGu/ntMGXZ2lft1D9ystl2hU2Ttn/1TTTCYBh+vOu6t0WYvgUGs0KGVT7Dj9rEmj0ug59rqMcRlj4twE7AFTBjxP5X+md0GQJXqm8VSV+9KUY4Ue4WaQLN3hECzCvQwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NisEID3z; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6d5ca057-87a3-4ec2-a733-8f0c1fb11158@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725978577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U9IMq2lfBFo2EcY7C0mxiXEzI9/sn8PzYmV9lkBASBM=;
	b=NisEID3zLSvP5G84+Lss+BMuBVscZSObxXPqsbWRJJeoTPNiBzyU7zNC6eB61nO+1f2XNQ
	Z/MYCI2r4Cl5e1ecIhlmTJHnFEZi8WD185vEszGWdRnFbX9eibZp9GYkGZOpNp19wfBPGN
	CvttbhTKgqMvcT4YxJXTM3dDplyDPcE=
Date: Tue, 10 Sep 2024 10:29:33 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] selftests: net: csum: Fix checksums for packets with
 non-zero padding
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20240906210743.627413-1-sean.anderson@linux.dev>
 <66dbb4fcbf560_2af86229423@willemb.c.googlers.com.notmuch>
 <9d5bf385-2ef0-435d-b6f9-1de55533653b@linux.dev>
 <CANn89iJaXgR6c+moGB5kX6ATbLX6fMP0mUBQN=SAsZfdz5ywNw@mail.gmail.com>
 <66df2fd2d6595_3bff929459@willemb.c.googlers.com.notmuch>
 <20240909165116.1bdb4757@kernel.org>
 <66df9a6d42871_81fd3294e8@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <66df9a6d42871_81fd3294e8@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/9/24 21:01, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
>> On Mon, 09 Sep 2024 13:26:42 -0400 Willem de Bruijn wrote:
>> > > This seems to be a bug in the driver.
>> > > 
>> > > A call to skb_put_padto(skb, ETH_ZLEN) should be added.  
>> > 
>> > In which case this test detecting it may be nice to have, for lack of
>> > a more targeted test.
>> 
>> IIUC we're basically saying that we don't need to trim because pad
>> should be 0? In that case maybe let's keep the patch but add a check 
>> on top which scans the pad for non-zero bytes, and print an informative
>> warning?
> 
> Data arriving with padding probably deserves a separate test.
> 
> We can use this csum test as stand-in, I suppose.
> 
> Is it safe to assume that all padding is wrong on ingress, not just
> non-zero padding. The ip stack itself treats it as benign and trims
> the trailing bytes silently.
> 
> I do know of legitimate cases of trailer data lifting along.

Ideally we would test that

- Ingress padding is ignored.
- Egress padding does not leak past the buffer. The easiest way to
  handle this would be to check that it is constant (e.g. all the
  padding uses the same value), but this could have false-positives for
  e.g. timestamps.

--Sean

