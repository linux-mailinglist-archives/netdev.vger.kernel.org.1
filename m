Return-Path: <netdev+bounces-192307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18ECABF6AA
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 15:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A312117028A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178A714F125;
	Wed, 21 May 2025 13:54:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE71426C
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835695; cv=none; b=CK/1SwlR21UyHdB6H4bVnAT+683vlhnj1esT1FppQO4tfy8LlwdixWt3cFuKbZQBHx5B8PtFqSR4rHDPxz4c3cE7XPKolq6E7nNZDwFpOfG1tIOr1EPuhOiKThZVEcguiwPcBCsmjRlcHM2vCiqCCZ2xDfTBmH1xeL5XHdmm0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835695; c=relaxed/simple;
	bh=z08PMtqSrBQZd4pp/+Wz7IFnlYem0MKhXsAjZ0N8B3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQw2tt3KpQEbx7maRYADbCSci0VMvcw7d1R0qQSLRrkStdnYR7Z9u2xOgaAn50nO7+r+7wNsJo3eEduEfF6N+Mo9hfy9+4IyIxn/envmfjfDFcZdzaZTi5WJI7UQ4lstnInEuadUjKoCGRGs0ujmcPxjxS98Z3FK626620eBcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 54LDspVD010893;
	Wed, 21 May 2025 22:54:51 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 54LDso40010890
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 21 May 2025 22:54:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9a12cdc9-1332-4ae5-8639-c71c91336b99@I-love.SAKURA.ne.jp>
Date: Wed, 21 May 2025 22:54:51 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH (EXPERIMENTAL)] team: replace term lock with rtnl lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Network Development <netdev@vger.kernel.org>
References: <ff1d684a-22ec-4ea2-a6ee-fe9704a6f284@I-love.SAKURA.ne.jp>
 <20250517080948.3c20db08@kernel.org>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20250517080948.3c20db08@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav303.rs.sakura.ne.jp
X-Virus-Status: clean

On 2025/05/18 0:09, Jakub Kicinski wrote:
> I think this was a trylock because there are places we try to cancel
> this work while already holding the lock.

I checked rtnl_unlock(), and it seems to me that rtnl_unlock() calls mutex_unlock() before
doing operations that might sleep. Then, rtnl_unlock() itself won't increase possibility of
rtnl_trylock() failure...

> 
> FWIW I'm not opposed to the patch. Could you wait a week and repost,
> tho? We have a fix queued up in another tree - 6b1d3c5f675cc7
> if we apply your patch to net-next there will be a build failure 
> on merge. Not a showstopper but we'll merge the trees on Thu so it
> can be easily avoided if we wait until then.

I reposted https://lkml.kernel.org/r/d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp
also as a fix for a new report ( https://syzkaller.appspot.com/bug?extid=b191b5ccad8d7a986286 )
triggered by 6b1d3c5f675cc7.


