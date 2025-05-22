Return-Path: <netdev+bounces-192501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA4AC01A0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 03:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E933A7F63
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198FFEEA9;
	Thu, 22 May 2025 01:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CE12B94
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747875665; cv=none; b=DJPlbR3Q6eUpdJHBDZSvAsrntlnjiirOISsYz7xo8aW+WVAw2GDpZCmWqyOP8jf7fKg755I4lnjFdzdKAZODcH5yJmDDzdfa+XDuZNxCgL2sitImMZYBOBQef37M66MQSj3jbpexVhaDaiCfwAzuuveccXez5X2BE2VB7ysL5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747875665; c=relaxed/simple;
	bh=72WJzJACfpPSxvTBob7ClAB1IDFf4x+ZU4cshj01bVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2KEIlXcgdVrJ2bsuRBUAhDJS2zrK3OOm3IEqIU+hQh2HfXgBKmhWtRTTFCq+xFXmnI8haVP9FNdzdqNUhxFTB8CdixYq4LJS83kV+tHZ+XuRhTUq1vuMI3qTE4Voo5dVkJx7S7VlrFU242++QXG3yv3kKzBp+g9WH7C7hGF4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 54M110ln077287;
	Thu, 22 May 2025 10:01:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 54M110sH077284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 May 2025 10:01:00 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ec84752c-1e3d-413c-9c2b-6d83e48470ef@I-love.SAKURA.ne.jp>
Date: Thu, 22 May 2025 10:00:58 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250521110024.64f5e422@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/05/22 3:00, Jakub Kicinski wrote:
> On Wed, 21 May 2025 22:38:55 +0900 Tetsuo Handa wrote:
>> syzbot is reporting locking order problem between wiphy and team.
>> As per Jiri Pirko's comment, let's check whether all callers are
>> already holding rtnl lock. This patch will help simplifying locking
>> dependency if all callers are already holding rtnl lock.
>>
>> Reported-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
>> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> 
> I don't think Jiri suggested it, he provided a review and asked
> questions. Suggest means he is the proponent of the patch.

I think Jiri Pirko knows better than I, for Jiri is the maintainer of
TEAM DRIVER. I just tried what Jiri commented:

  I wonder, since we already rely on rtnl in lots of team code, perhaps we
  can remove team->lock completely and convert the rest of the code to be
  protected by rtnl lock as well

> And as he pointed out this patch promptly generates all sort 
> of locking warnings, please test this properly.

I didn't get any compile-time warnings, and
https://lkml.kernel.org/r/682e6b1f.a00a0220.2a3337.0007.GAE@google.com didn't
get any run-time locking warnings.

What locking warnings did you get? Is there an automated testing environment
(like https://lkml.kernel.org/r/66a4b1a7.050a0220.12c792.8f9e@mx.google.com )
which I can use for testing this patch?


