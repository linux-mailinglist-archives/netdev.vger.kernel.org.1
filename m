Return-Path: <netdev+bounces-213084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDF9B238E6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB87D1AA41FD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1662D4804;
	Tue, 12 Aug 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b="syHWDa0E"
X-Original-To: netdev@vger.kernel.org
Received: from dd41718.kasserver.com (dd41718.kasserver.com [85.13.145.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BD2D0C9F;
	Tue, 12 Aug 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.145.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026825; cv=none; b=lDmmimvdLmQFECEDKYJi056fWBknkB8gSphxIkFOESQAMDdwmWneFVVpYs0epVquDB+1stFeDbTcnXbshE3FBNcMJ1AN4cHIXSF9p/lvSCQbOJyuRiCbxNp+u1qcNddtQME2VZDbCh/Q7OIcrWMgJkerlZv+GDShhCZrV13yCxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026825; c=relaxed/simple;
	bh=W7XKBmcNVEkMC9KS30OOWEiJju3V0m0T2wsu2TZxlas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvub3F1HA2nkRgbPb8XhbncD/27vsRLJuersbRHz1fL8NeG4N9GRDpRDcj+UFkRhJsKENnuP0S8lzmzmLMSkLpfnvAp6xtSMRlKomi8EtFt2N5F50Xj5MRqXrCxIr8TMfKzu5mVpuwUXI7HMPaattJq//d9Y6NST/uwLUgM6T54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de; spf=pass smtp.mailfrom=stegemann.de; dkim=pass (2048-bit key) header.d=stegemann.de header.i=@stegemann.de header.b=syHWDa0E; arc=none smtp.client-ip=85.13.145.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=stegemann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stegemann.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stegemann.de;
	s=kas202307141421; t=1755026821;
	bh=HYYj4t5xcGhm716nOvNPQ3SJLJ59k6cXRav/7+WF7rY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:From;
	b=syHWDa0EZRBxctgugRlD+nXQcj5EAHw2RaQYu/8DSqGxUQhRrdWWvOoLhBx1KD9uW
	 CHWZDpJmYeQpfGifBQU1Dkc5yG/tV9x57q5SdtYQ/hEefu4n+mcDTNZYWxdfzclYPY
	 cqOO3vWJbZVh0O3MBA4KkSbyLvS1BXzKpb3osoHq1aYv0Z4xh4VC+M4EP/TzwaKwD7
	 poVVgNSuzpqGtHWGovgwWN4yhNv9ZGIs+/Or8q6gzlhsJ7UmzhuYuiagQ/L26OkT58
	 qP65NDmq4t1n8UGhF/qcSuDptXXdsnBCCFM7wnPIMQpf0O39VLJSZAseTVlJS9fnVl
	 GnKldJhInt7wg==
Received: from [10.144.2.19] (p5b2eae0a.dip0.t-ipconnect.de [91.46.174.10])
	by dd41718.kasserver.com (Postfix) with ESMTPSA id 5CA9555E03F2;
	Tue, 12 Aug 2025 21:27:01 +0200 (CEST)
Message-ID: <71c79b47-d44f-45da-9558-770690addb79@stegemann.de>
Date: Tue, 12 Aug 2025 21:27:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: kcm: Fix race condition in kcm_unattach()
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+e62c9db591c30e174662@syzkaller.appspotmail.com,
 syzbot+d199b52665b6c3069b94@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
References: <20250809063622.117420-1-sven@stegemann.de>
 <194e4774-a931-4ce4-af63-4610da7c4350@redhat.com>
From: Sven Stegemann <sven@stegemann.de>
Autocrypt: addr=sven@stegemann.de; keydata=
 xjMEZrXtmhYJKwYBBAHaRw8BAQdA3Ejzsjqv+hzfA59byjISoS/VehggsxakHVtgwKSoA9PN
 IlN2ZW4gU3RlZ2VtYW5uIDxzdmVuQHN0ZWdlbWFubi5kZT7CjwQTFggANxYhBHSSwIIEOMdM
 COsZe4gToYAVM3dwBQJmte2aBQkHhM4AAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQiBOhgBUz
 d3Dq2wEA3Y7BLtU/NzbpTu+ZnEIIVc0DuTfrinsv8qnSAEF3zjoBAOiCC+pZdO06qat8VL/O
 BUalGs5fNIVGA+udw/opviIMzjgEZrXtmhIKKwYBBAGXVQEFAQEHQGNHDhm0CMpuUnwzlf6Q
 MA34IVeba8HZ3dD1tHjsmNJjAwEIB8J+BBgWCAAmFiEEdJLAggQ4x0wI6xl7iBOhgBUzd3AF
 Ama17ZoFCQeEzgACGwwACgkQiBOhgBUzd3A7yQD/bq9BjmEfA5aRi+jPGGKccfqjo/h1cgCg
 Jhc6fNUaCgIA/1SOhP2plCGFj8xPLvhY/FfFWeE38DbrETpOLdl+NysO
In-Reply-To: <194e4774-a931-4ce4-af63-4610da7c4350@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +

On 8/12/2025 2:54 PM, Paolo Abeni wrote:
> On 8/9/25 8:36 AM, Sven Stegemann wrote:
>> @@ -1714,6 +1708,7 @@ static int kcm_release(struct socket *sock)
>>  	/* Cancel work. After this point there should be no outside references
>>  	 * to the kcm socket.
>>  	 */
>> +	disable_work(&kcm->tx_work);
>>  	cancel_work_sync(&kcm->tx_work);
> 
> The patch looks functionally correct, but I guess it would be cleaner
> simply replacing:
> 
> 	cancel_work_sync(&kcm->tx_work);
> 
> with:
> 
> 	disable_work_sync(&kcm->tx_work);

Thank you, that's a good point.

I just submitted a cleaned up version of the patch.

