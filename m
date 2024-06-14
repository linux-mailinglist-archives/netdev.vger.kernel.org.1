Return-Path: <netdev+bounces-103437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A54A90806A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16251B21554
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9DE801;
	Fri, 14 Jun 2024 00:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11894A11
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326763; cv=none; b=dc9v02pjP4Req1NnTkc2p+WROutlzefekxSGpcLhvABJwHNIFMKanmC6Gowk0iGVA7BIuT/TCh1nWYrjNfn0e4uu4pU6zwdhk+XznLX5sW0FlH+46TOs+Dw8sM7M/h0ztgBRRiyYSjvJZUOR8pIOqSoQSXXr9Rkz/fOttpb93y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326763; c=relaxed/simple;
	bh=CfF7rEHXphm3s130Ro698JtGqyNjF3kYHAoHL1WeLSg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Yof16kFk6+3LX3jyh3GJ/Q2oljX6GfiemPD9ppsgv5ZtwKiM48uHE4iAuRbhGrGHbiiIpRyTdwoKGjSrpKltc35Ni1jjhcyAlKt7buw+lCKUrGMHWnhwg92dMpVqzTGKnS8a8L7J8CyaEQfGSm6rKUL0A2StBpepljF3pYxZ1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 45E0woAe041804;
	Fri, 14 Jun 2024 09:58:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Fri, 14 Jun 2024 09:58:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 45E0wodJ041800
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 14 Jun 2024 09:58:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8d61200a-a739-4200-a8a3-5386a834d44f@I-love.SAKURA.ne.jp>
Date: Fri, 14 Jun 2024 09:58:48 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development
 <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [net/sched] Question: Locks for clearing ERR_PTR() value from
 idrinfo->action_idr ?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

syzbot is reporting hung task problems involving rtnl_muxex. A debug printk()
patch added to linux-next-20240611 suggested that many of them are caused by
an infinite busy loop inside tcf_idr_check_alloc().

----------
again:
		rcu_read_lock();
		p = idr_find(&idrinfo->action_idr, *index);

		if (IS_ERR(p)) {
			/* This means that another process allocated
			 * index but did not assign the pointer yet.
			 */
			rcu_read_unlock();
			goto again;
		}
----------

Since there is no sleep (e.g. cond_resched()/schedule_timeout_uninterruptible(1))
before "goto again;", once idr_find() returns an IS_ERR() value, all of that CPU's
computation resource is wasted forever with rtnl_mutex held (and anybody else who
tries to hold rtnl_mutex at rtnl_lock() is reported as hung task, resulting in
various hung task reports waiting for rtnl_mutex at rtnl_lock()).

Therefore, I tried to add a sleep before "goto again;", but I can't know whether
a sleep added to linux-next-20240612 solves the hung task problem because syzbot
currently cannot test linux-next kernels due to some different problem.

Therefore, I'm posting a question here before syzbot can resume testing of
linux-next kernels. As far as I can see, the ERR_PTR(-EBUSY) assigned at

	mutex_lock(&idrinfo->lock);
	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
			    GFP_KERNEL);
	mutex_unlock(&idrinfo->lock);

in tcf_idr_check_alloc() is cleared by either

	mutex_lock(&idrinfo->lock);
	/* Remove ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc */
	WARN_ON(!IS_ERR(idr_remove(&idrinfo->action_idr, index)));
	mutex_unlock(&idrinfo->lock);

in tcf_idr_cleanup() or

	mutex_lock(&idrinfo->lock);
	/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc */
	idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
	mutex_unlock(&idrinfo->lock);

in tcf_idr_insert_many().

But is there a possibility that rtnl_mutex is released between
tcf_idr_check_alloc() and tcf_idr_{cleanup,insert_many}() ? If yes,
adding a sleep before "goto again;" won't be sufficient. But if no,
how can

	/* This means that another process allocated
	 * index but did not assign the pointer yet.
	 */

happen (because both setting ERR_PTR(-EBUSY) and replacing with an !IS_ERR()
value are done without temporarily releasing rtnl_mutex) ?

Is there a possibility that tcf_idr_check_alloc() is called without holding
rtnl_mutex? If yes, adding a sleep before "goto again;" would help. But if no,
is this a sign that some path forgot to call tcf_idr_{cleanup,insert_many}() ?

