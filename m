Return-Path: <netdev+bounces-102070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BE2901529
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0575B28331C
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58654D520;
	Sun,  9 Jun 2024 08:29:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635118EB0
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921752; cv=none; b=Ob5LQyt9rVnSPRSSvvOV+752xPtSIsFQZa6Dj3bL8WscU0OnLFvZrSXLzxFA6qmE3BP3HqhMBJxJHf1AfTFaDsJNIb2BonfeFaCqKaLHKcA+zeQmokw/vkX5pw8fA63NzK+du+1UMjASI3de0qJ3h1rwjVjMLlp/9BYiLXLdfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921752; c=relaxed/simple;
	bh=PgLtKB0Flcsp7lbTudt3pU2wFfHocXN5o9cXHqw0It4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kmRmYq0EaiecJ5CdUvxHjYDwUTGrKjQEP8Id2BK7mKxERT5u9/Fcaoy4Gs8/m07BhxuZUgO4Q0ngiR0h6L45AVUV+ZQNZA/hYliDtxeJJ8kmROVLIB1f/x1bqcrYWnVrdT7u/ByKPTEqllNEYQQytqT7zUxItmDAlGwSjdl33BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4598T8RU003695;
	Sun, 9 Jun 2024 17:29:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sun, 09 Jun 2024 17:29:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4598T8XY003692
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 9 Jun 2024 17:29:08 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <628624ea-d815-4866-9711-70d096ea801d@I-love.SAKURA.ne.jp>
Date: Sun, 9 Jun 2024 17:29:08 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 06/14] netlink: hold nlk->cb_mutex longer in
 __netlink_dump_start()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, eric.dumazet@gmail.com
References: <20240222105021.1943116-1-edumazet@google.com>
 <20240222105021.1943116-7-edumazet@google.com> <Zdd0SWlx4wH-sXbe@nanopsycho>
 <cbbd6e2d-39da-4da3-b239-1248ac8ded10@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <cbbd6e2d-39da-4da3-b239-1248ac8ded10@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/09 17:17, Tetsuo Handa wrote:
> Hello.
> 
> While investigating hung task reports involving rtnl_mutex, I came to
> suspect that commit b5590270068c ("netlink: hold nlk->cb_mutex longer
> in __netlink_dump_start()") is buggy, for that commit made only
> mutex_lock(nlk->cb_mutex) side conditionally. Why don't we need to make
> mutex_unlock(nlk->cb_mutex) side conditionally?
> 

Sorry for the noise. That commit should be correct, for the caller
no longer calls mutex_unlock(nlk->cb_mutex).

I'll try a debug printk() patch for linux-next.


