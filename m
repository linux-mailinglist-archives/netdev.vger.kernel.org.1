Return-Path: <netdev+bounces-124482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F8969A96
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AB81F2408E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE841C766E;
	Tue,  3 Sep 2024 10:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="WIq9I6/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F022019F420
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360483; cv=none; b=XTaGMAJBEwUFJe1+2R0nnuXhjNpENsjoW9Yd7mfEKjclyQwgmJ4d/59DsXvHa1ZZ4DcdLZ9PgC5ckJ+a2Cj6R1InY0lsK13T05ftanUCoDgHk+pl/G0+GEly3WIbkqoo6kbE8GrtPsk8VH1PWdZUuO8JkeknVAOPMAe76zOoUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360483; c=relaxed/simple;
	bh=5sVtSvQEtuBso82m1XCUkNDtJZezFYdITQgE7+gzWP4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=IC1MJce86pd9xWHzQDET+z9cin4Q01o+rNO8WixhOE/srNfxqNynb2dPyZL7uEufTUSzwVLCKJMalPG6JxF1vQiS4BLYBYpRFwCSp6YjCN6PzfezOZaJjgyVPx0GqWqpIGWtbZtnsn+mUKC8wMuVlgmqL2ewDmISoqyEgPgv8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=WIq9I6/O; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:34e6:741b:7236:5ff3] (unknown [IPv6:2a02:8010:6359:2:34e6:741b:7236:5ff3])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 8C1737D9AC;
	Tue,  3 Sep 2024 11:48:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1725360480; bh=5sVtSvQEtuBso82m1XCUkNDtJZezFYdITQgE7+gzWP4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<1dce7949-58de-ce8b-7123-3c2c2dfef276@katalix.com>|
	 Date:=20Tue,=203=20Sep=202024=2011:48:00=20+0100|MIME-Version:=201
	 .0|To:=20Dan=20Carpenter=20<dan.carpenter@linaro.org>,=20Simon=20H
	 orman=20<horms@kernel.org>|Cc:=20netdev@vger.kernel.org,=20davem@d
	 avemloft.net,=20edumazet@google.com,=0D=0A=20kuba@kernel.org,=20pa
	 beni@redhat.com,=20dsahern@kernel.org,=20tparkin@katalix.com,=0D=0
	 A=20kernel=20test=20robot=20<lkp@intel.com>|References:=20<2024090
	 2142953.926891-1-jchapman@katalix.com>=0D=0A=20<20240903072417.GN2
	 3170@kernel.org>=0D=0A=20<332ef891-510e-4382-804c-bc2245276ea7@sta
	 nley.mountain>|From:=20James=20Chapman=20<jchapman@katalix.com>|Su
	 bject:=20Re:=20[PATCH=20net-next]=20l2tp:=20remove=20unneeded=20nu
	 ll=20check=20in=0D=0A=20l2tp_v2_session_get_next|In-Reply-To:=20<3
	 32ef891-510e-4382-804c-bc2245276ea7@stanley.mountain>;
	b=WIq9I6/OjMSWuxOZhor8qtNpaRM954jDT563NSUizfULOSWI5mQIlM9ul0rPBLijA
	 hqZ1kkXyMjtZwZRqpo2ZtWNA9d/o+gXV96Xbqkck8kYHJqIj+OKrQulx61DqnNPJUW
	 /hmkmvUu1QGCpHrLBZgjrKLHQR7JBI9vtmF/j9/nZBGsJh22eJfLc9yl6Ogj62KueZ
	 xphFYk8RzN0bBvUPAqFfPI67iw8W3N7hVWgouwI9RW6q/wf1BQJad3fzGouZ5JWyu4
	 5NxHW9/0sBuNbvRGnKsls3f1EQocHZrNwmtvWxMnGy7h491Ov7CF9Mz8rKuq5yjOJv
	 57Vf5071ZQTPQ==
Message-ID: <1dce7949-58de-ce8b-7123-3c2c2dfef276@katalix.com>
Date: Tue, 3 Sep 2024 11:48:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com,
 kernel test robot <lkp@intel.com>
References: <20240902142953.926891-1-jchapman@katalix.com>
 <20240903072417.GN23170@kernel.org>
 <332ef891-510e-4382-804c-bc2245276ea7@stanley.mountain>
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [PATCH net-next] l2tp: remove unneeded null check in
 l2tp_v2_session_get_next
In-Reply-To: <332ef891-510e-4382-804c-bc2245276ea7@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2024 09:02, Dan Carpenter wrote:
> On Tue, Sep 03, 2024 at 08:24:17AM +0100, Simon Horman wrote:
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/r/202408111407.HtON8jqa-lkp@intel.com/
>>> CC: Dan Carpenter <dan.carpenter@linaro.org>
>>> Signed-off-by: James Chapman <jchapman@katalix.com>
>>> Signed-off-by: Tom Parkin <tparkin@katalix.com>
>>
>> And as you posted the patch, it would be slightly more intuitive
>> if your SoB line came last. But I've seen conflicting advice about
>> the order of tags within the past weeks.
> 
> It should be in chronological order.
> 
> People generally aren't going to get too fussed about the order except the
> Signed-off-by tags.  Everyone who handles the patch adds their Signed-off-by to
> the end.  Right now it looks like James wrote the patch and then Tom is the
> maintainer who merged it.  Co-developed-by?

I'm probably using tags incorrectly. When Tom or I submit kernel patches 
to netdev, we usually review each other's work first before sending the 
patch to netdev. But we thought that adding a Reviewed-by tag might 
short-cut proper community review, hence we use SoB to indicate that 
we're both happy with the patch and we're both interested in review 
feedback on it.

On reflection, Acked-by would be better for this. I'll send a v2 with 
Acked-by to avoid confusion.

Thanks!

--
pw-bot: cr





