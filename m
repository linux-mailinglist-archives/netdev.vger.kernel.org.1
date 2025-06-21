Return-Path: <netdev+bounces-199990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77216AE2A4C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1434018941D0
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE41DDC1B;
	Sat, 21 Jun 2025 16:27:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7FF30E859
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750523272; cv=none; b=uhD/7iTFOKujMI8xLYDfpTEXG//VJqn7/l8UmB7v06tF9Oc0fvQY58ABbagbLfhYRpcJnfZbLlSwm5T6PKmhuIz7cEMm0jvn4giSouRknAiyHssdpaOb1uokCqE6ghjVcyn6HOeUohFwLl5X6K6kiGWqxk8UIR4P3DkcUDw3Al4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750523272; c=relaxed/simple;
	bh=zJQ6bHePg3UDmU7HRBrddEZghzDa4LC7XuqY6nh+KOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQhpFjj0AFGgL1lR2uKyb09RRicRTCVbGA/0OauECr3EtexRLzE6QMASgkRgUbcKYE2e+IcXtJu3G2EAr7Sq+i1CAfuQFrnAWh/SJP3W6ONh1aF0M0+LJITV3zofoMx1MS/VgfMmRvSEoH7rdQSvQ91Rq7CttnqAoAElka5zsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 55LGRmLO037957;
	Sun, 22 Jun 2025 01:27:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 55LGRmNi037954
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 22 Jun 2025 01:27:48 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e6f681bb-40b6-4393-9e80-883f06e33b7b@I-love.SAKURA.ne.jp>
Date: Sun, 22 Jun 2025 01:27:45 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
 <20250521110024.64f5e422@kernel.org>
 <ec84752c-1e3d-413c-9c2b-6d83e48470ef@I-love.SAKURA.ne.jp>
 <ae7e9800-e395-4b9e-9878-83a5e768cc98@I-love.SAKURA.ne.jp>
 <aFXsyoJ1ZIULrC3w@mini-arch>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aFXsyoJ1ZIULrC3w@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/06/21 8:20, Stanislav Fomichev wrote:
>> Anyway, we can't remove team lock. Too bad.
> 
> I was hoping to see another revision, but just noticed this part. Can
> you share more on why we can't remove the team lock? I can try to
> give it a stab if you're not planning to send a follow up...

I think we can't remove the team lock unless we convert to always use
the rtnl lock. I don't have plan to propose such change. Please send
your approach.


