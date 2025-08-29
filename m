Return-Path: <netdev+bounces-218298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C7FB3BD22
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5231C87F31
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0409D31DD85;
	Fri, 29 Aug 2025 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WttKghgl"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DC31986D;
	Fri, 29 Aug 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476382; cv=none; b=sSfpPrOCTmNxHUJhP+FyeWsUSukkV8yaJnmObibgnO3yeWHkiGum72kfzgRTBrs0SAeezxMe82gtVD+xtNzwrkTAGtg1uJAPeaiUwxQrdRsiB9r88r30QS1JKajdC6NzX3gENCaI40jym7btDDPIZXdb+YoaSuHHc5sXWVsEQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476382; c=relaxed/simple;
	bh=lsKwY5zRTL3tGIAhPcY5baAerauX4JihTjdNjAmFphI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U2EaMRFWZ4hf5MBBdCMMVV3m2j0C2IqzGqMlnZhnUpmmRnZfY0SSGSDkr/Y24wkJTK/mmDaY6Ad1lTUKJyWrlbFVuGnyzJPCK5vUSbXzC9TB1iSM4kSnksSAc4Lx9mCS4iqzwNYpRli2tKj5th8AJnMBfYQQDyL7mSxFGdm+b9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WttKghgl; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qn
	ZitLSeHbMXopEiqs5AnbXSPc8nVfrsZ2BrWGcahlQ=; b=WttKghgl1NS2hiGl2+
	PJXVqhQOZ8B5d+tlbcTjObtqdoYj+kf5+PQLrr4tievelxqSt2YqtnTwBt82DZId
	FYnsYvV+4MMhrmN63hX/TNDBVK2Wz3tv0/RRQhQJQjv7Uri30TgbI7zU5mDPvCFe
	mcXZXctfGzbqSoYLgcXiOxtoE=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDX+k6zs7Fo6MVjFQ--.700S2;
	Fri, 29 Aug 2025 22:05:40 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	ferenc@fejes.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9] net: af_packet: Use hrtimer to do the retire operation
Date: Fri, 29 Aug 2025 22:05:39 +0800
Message-Id: <20250829140539.3840337-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX+k6zs7Fo6MVjFQ--.700S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF47KFWUWr18tw4xXry7Wrg_yoW8ZFyrpF
	WUKwn8Gw4DCa9rZ3ZrAw1qqF13A3yrJFZrGrs5uFy5Aws8Gr1Sk392g3yrZFy7Can3Z342
	vr48GFy3AF1xZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um1v-UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiRwG4CmixsSM-GAAAsY

On Fri, 2025-08-29 at 7:16 +0800, Willem wrote:

> Overall I'm on-board with this version.
> 
> 
> One remaining question is the intended behavior of kactive_blk_num (K)
> and last_kactive_blk_num (L).
> 
> K is incremented on block close. L is set to match K on block open and
> each timer. So the only time that they differ is if a block is closed
> in tpacket_rcv and no new block could be opened.
> 
> The only use of L is that the core of the timer callback is skipped if
> L != K. Based on the above that can only happen if a block was closed
> in tpacket_rcv and no new block could be opened (because the ring is
> full), so the ring is frozen. So it only skips the frozen part of the
> timer callback. Until the next timeout. But why? If the queue is
> frozen and the next block is no longer in use, just call
> prb_open_block right away?
> 
> Unless I'm missing something, I think we can make that simplification.
> Then we won't have to worry that the behavior changes after this
> patch. It should be a separate precursor patch though.


I followed what you said, I think we can directly remove the
last_kactive_blk_num variable and all related logic. I have run the
optimized code in our project and haven't encountered any issues.
The only impact I can think of is that in tpacket_rcv, when discovering
that the next block is still in use and cannot be opened, we originally
needed to wait for interval time in the timer callback before checking
again. Now, we will make that check earlier, which may allow us to
discover that the user has finished using the block sooner and open the
block earlier. So it seems that the optimization does not cause any issues.



So what should I do next?

I submit a patch that removes last_kactive_blk_num, then wait the patch
merged, and after that rebase to submit the current hrtimer patch?

or

I wait for you to submit the patch that removes last_kactive_blk_num, and
then rebase to submit the new hrtimer patch?

or

I directly include this modification in the hrtimer patch in version 10?




Thanks
Xin Zhao


