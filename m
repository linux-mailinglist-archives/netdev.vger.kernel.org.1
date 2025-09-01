Return-Path: <netdev+bounces-218774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33CAB3E6D5
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C584408EE
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F39204096;
	Mon,  1 Sep 2025 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FkpsTFsj"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC97E301001;
	Mon,  1 Sep 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736219; cv=none; b=itiRxwrdlRH428GgkdryWgjeD8MOyEN1gHw04zZrcD/wRZM8k33/F7k4uALDmz91kLlfcMuD23fSs3pRe4i4jnZBubJE2yKgbSf9srU9V5EkBr+Cfa9OHxHkHztOgImgp85zfrv2LeeAyOkPSkl2x/XIcE6xzyFp+8h7Ttbjgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736219; c=relaxed/simple;
	bh=lvJp8d/vJkaDjrnQJ0rvEIJTuGVqMTazZ6x0yMILjhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t/ROSjF897bC6WwuVUtii3DBaFQfxNIG3sforIb3QtUiyYp14d3Hz8DCdBmtY9+S+PBckCXZMlj2Mwmq4Ezv869EqeNlNeeBJNCYoqxR+VnVQ1DV/fUeEONHSNOSiMJ22mVQ4Zk8o9BjrUqQggK2CEM7U+wV2GdYX6UMe78HyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FkpsTFsj; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=SX
	1UAp7DPjAe6HBJmAAgwIpwP8jORmH1BtvV74eABEg=; b=FkpsTFsjPcnN3TiVk6
	3Smm/pWolLGEsCYEcGnadp1Af+Lkk57IA2HMdQJDtnpm3hWuf5PybTbHhTc+RHWa
	yi9TIfBYo7d/ZDtrYmK+jwolvyj9KEX7nUwp2bspXvOhHIwcg52xcY1NWVMVHJoA
	Er0Bjf+Q8fuBUZsCDAJNXBWq8=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3xxWsqrVo581UFQ--.14928S2;
	Mon, 01 Sep 2025 22:16:13 +0800 (CST)
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
Subject: Re: [PATCH net-next v10 2/2] net: af_packet: Use hrtimer to do the retire operation
Date: Mon,  1 Sep 2025 22:16:12 +0800
Message-Id: <20250901141612.2232833-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3xxWsqrVo581UFQ--.14928S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1DJFW3Gry7Cr1kGryUJrb_yoW8GF4xpF
	W3tasrtw1kCr45uw42gryxGF4Fv3s5KFs8Grs5WFyUCr95tFy3AFyjkFW5ua4xCrs7GFyx
	Zr4S9a93ZFn5ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPR67UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbibgO7Cmi1mCP7mAABsY

On Mon, 2025-09-01 at 09:35 -0400, Willem wrote:

> > On Sun, 2025-08-31 at 21:21 -0400, Willem wrote:
> > 
> > > > -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> > > > -						req_u->req3.tp_block_size);
> > > > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > > > +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> > > > +						req_u->req3.tp_block_size));
> > > 
> > > req_u is not aligned with the line above.
> > 
> > I have some questions regarding the alignment here. According to the alignment requirements,
> > req_u should be aligned below the po variable. However, if it is aligned below po, the line
> > will become very long, which may affect readability. In this special case, can I align it to
> > prb_calc_retire_blk_tmo instead, or should I continue to align it to the po variable?
> 
> The (minor) issue here is with the second req_u. Which is one space
> off from the argument above. See checkpath.
> 
> In general, the line length and break rules are documented in the
> kernel coding style page, which checkpatch follows.
> 
> > 
> > What should I do next?
> > Should I change the alignment, and resend PATCH with the reviewed information of version 10?
> 
> I did not think this one space was worth resending, so I added my
> Reviewed-by. Others may disagree, but so far no other opinions.

Okay, I will not resend the patch if there are no other opinions.


Thanks
Xin Zhao


