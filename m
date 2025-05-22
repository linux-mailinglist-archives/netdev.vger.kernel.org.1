Return-Path: <netdev+bounces-192681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D107AC0D26
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AB57B4C73
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6351A317A;
	Thu, 22 May 2025 13:47:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EE1EA80
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921651; cv=none; b=EuDRDTa8ZFfoYNP549u1mRMEKXNnq+yfTuLzeLEt9mtlaO3AyfuElat0qaRA0E141NrDneF/sVe61IIwXk4I+d+h/6Lmq23Yh+WYXrMGrDANICYBwVhoOFIHwA1eAFwpHEqanI04hQbrrKzFDayVtVBJjtVci/dW6wuclRBedEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921651; c=relaxed/simple;
	bh=Dfar01OCdaFLlpDzJ964oduX+wvJ/hu2QZx7ly9Z9dQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I8ziDKmIi/Nvnft1bIwGBg3nll3dnTVsXlFgVOZ1rDOyRdlJcxh5y9mYxhPMqF+FX+IdyIwIFACC4ljPP9WW09B9weoQS4pfN+BuQqvjE5MPF5JrjcZKtzwsWDmLUHCcFB+Md72NtGhH+KVy6JAIMWShoDrcAuqctsf6mfxWQms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 54MDlK5g025212;
	Thu, 22 May 2025 22:47:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 54MDlKKp025206
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 May 2025 22:47:20 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ae7e9800-e395-4b9e-9878-83a5e768cc98@I-love.SAKURA.ne.jp>
Date: Thu, 22 May 2025 22:47:19 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Network Development <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Stanislav Fomichev <stfomichev@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
 <20250521110024.64f5e422@kernel.org>
 <ec84752c-1e3d-413c-9c2b-6d83e48470ef@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <ec84752c-1e3d-413c-9c2b-6d83e48470ef@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav205.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/05/22 10:00, Tetsuo Handa wrote:
> On 2025/05/22 3:00, Jakub Kicinski wrote:
>> And as he pointed out this patch promptly generates all sort 
>> of locking warnings, please test this properly.
> 
> I didn't get any compile-time warnings, and
> https://lkml.kernel.org/r/682e6b1f.a00a0220.2a3337.0007.GAE@google.com didn't
> get any run-time locking warnings.
> 
> What locking warnings did you get? Is there an automated testing environment
> (like https://lkml.kernel.org/r/66a4b1a7.050a0220.12c792.8f9e@mx.google.com )
> which I can use for testing this patch?
> 

Ah, I got which posts you are referring to. I was failing to receive Jiri's mails
because my spam filter setting was sending mails from .us domain to trash.
Now I removed the .us entry.



Jiri Pirko wrote:
> Sat, May 17, 2025 at 09:32:20AM +0200, penguin-kernel@I-love.SAKURA.ne.jp wrote:
> 
> [..]
> 
> >@@ -2319,13 +2301,12 @@ static struct team *team_nl_team_get(struct genl_info *info)
> > 	}
> > 
> > 	team = netdev_priv(dev);
> >-	mutex_lock(&team->lock);
> > 	return team;
> > }
> 
> 
> Why do you think this is safe?
> 
> Rtnl is held only for set doit.

I assumed that the caller already held rtnl lock.

> 
> 
> > 
> > static void team_nl_team_put(struct team *team)
> > {
> >-	mutex_unlock(&team->lock);
> >+	ASSERT_RTNL();
> 
> Did you test this? How? Howcome you didn't hit this assertion?

Tests using syzbot's reproducer did not hit this assertion.

> 
> 
> > 	dev_put(team->dev);
> > }
> > 

Anyway, we can't remove team lock. Too bad.


