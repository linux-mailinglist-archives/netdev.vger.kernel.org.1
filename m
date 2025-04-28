Return-Path: <netdev+bounces-186558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D68A9FA8A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADDB4668C4
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F98B1DF26A;
	Mon, 28 Apr 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="DuC/Ut0Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de [129.70.45.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00206F073;
	Mon, 28 Apr 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.70.45.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872012; cv=none; b=Gccl3Hy9JZ6VTW+PS4C/WwXq/HPl4WhJnRpC79FzT1PNkD+tsrc/mRvddcAMqWVr0eSBOrQvp1Ji+G0xeUxX8Npg9/Ooe9q2PxAs7r0mkHuoh+O4T19dXHW+A62e6Cb38wTsfCVs9sjEqDV3R44ZnO8/tAnGxlJ3/xvPXEx3vIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872012; c=relaxed/simple;
	bh=mt4nBZoFMVuazThWZili02maSuYlJhyImrdFjgf73Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7k2Pgs8in0z3U81jWpuE8p+k38zOydg3R4iWP5BgfstVUj67nTFqJFkX6XrTg3oLh67fjRBBz80tNOKNv16IzIhfmb1lZUszQemYoMh7pdQ7IhYO9ewOIQ5oV8q1iAaT7xFSA6ndyNu+Gto+/iCZzTdAd05BfgOXxP7I9OL/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de; spf=pass smtp.mailfrom=math.uni-bielefeld.de; dkim=pass (2048-bit key) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b=DuC/Ut0Y; arc=none smtp.client-ip=129.70.45.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=math.uni-bielefeld.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=math.uni-bielefeld.de; s=default; t=1745872003;
	bh=mt4nBZoFMVuazThWZili02maSuYlJhyImrdFjgf73Nw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DuC/Ut0Y5Ya0qey24ll36tGnrmNcbhDUWIG9buN/vfhikGqznDWsdjtciEFUsJERf
	 eM+xNIU+IxBQx3H5i/oUewPdeHb+qIAWVHdVl3Jnht8GqboRHM6QEpcWQsBcWr9UTl
	 Atw3grYDYMiPAjDw83xUhjmbTF1WfV99fVN5kSqZu9mbGQuFGGCVYuCxN6tL2b8T+Z
	 MG2rW1nY/mZ8jLh1V1K+W86Ff+iRDGg4EqCFxF6+FNVI+8daeFNw3H3iC+B6TRZOSg
	 9qxOx3bc9I6Fe2OdlewDd87C//T1RzcixNOlg4X52U08vwEE9K1Y7ECyiBbdgT9zG8
	 PLgxuACdhApmQ==
Received: from [192.168.0.100] (dslb-084-060-118-083.084.060.pools.vodafone-ip.de [84.60.118.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id A4B7820396;
	Mon, 28 Apr 2025 22:26:42 +0200 (CEST)
Message-ID: <b34675f9-3f09-44ca-a712-c77af5340ae3@math.uni-bielefeld.de>
Date: Mon, 28 Apr 2025 22:26:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] r8152: Call napi_schedule() from proper context
To: Jakub Kicinski <kuba@kernel.org>
Cc: pmenzel@molgen.mpg.de, davem@davemloft.net, edumazet@google.com,
 frederic@kernel.org, hayeswang@realtek.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, romieu@fr.zoreil.com
References: <8db2e1cd-553e-4082-a018-ec269592b69f@molgen.mpg.de>
 <9b822fe6-699a-4fe6-88c5-1e92e6a6e588@math.uni-bielefeld.de>
 <20250428104925.1ff7ad41@kernel.org>
Content-Language: en-US
From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; keydata=
 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
 5pwFHSz7G+1ahA==
In-Reply-To: <20250428104925.1ff7ad41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/28/25 7:49 PM, Jakub Kicinski wrote:
> On Sun, 27 Apr 2025 22:50:34 +0200 Tobias Jakobi wrote:
>> Hello everyone,
>>
>> I believe this is still a problem, correct? I've been carrying the two
>> patches in my tree for some weeks now -- otherwise the network adapter
>> in my USB-C dock stops working randomly.
>>
>> Anything I can do to get these merged?
> 
> Which kernel are you suffering on?
> The fix is in 6.14 -- commit 77e45145e3039a
> It went in without Fixes and stable annotation, tho
Hello Jakub,

thanks for pointing of the commit hash. I was looking for the wrong 
commit in 6.14.y. More specifically I was searching for the one named 
"r8152: Call napi_schedule() from proper context", touching 
drivers/net/usb/r8152.c.

But it seems the problem was solved in a different manner.

Sorry for the noise!

With best wishes,
Tobias


