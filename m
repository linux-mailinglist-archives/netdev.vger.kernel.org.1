Return-Path: <netdev+bounces-218594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAD5B3D6AB
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 04:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D433BA6C6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17D1D86D6;
	Mon,  1 Sep 2025 02:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F2vF3KTk"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FFD1B0439;
	Mon,  1 Sep 2025 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756693707; cv=none; b=C59IiHSxz8sjyY0MuXwLcAfDXbXH6A8xAZifPrTdpDaY54PgR+EWM6T1PcKDSyw/4YqwT9A7n8bPra4L6iHt+RFpbplEc/cMT86Hl+hwKwZCLck5z1T9EXf8qtSId5guQ9xheiRZzPESNlmKNg71Hh5mGS1vVwS3GMza2Q0rZlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756693707; c=relaxed/simple;
	bh=uUPlUExIlKRhAtvLIIpliPVEKGfcpLui5vbKyVY14TE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gXCqTol6x5xdhnhx5Pnq1gS+ciGURMwYsiJXw7zOi0LejmxceGimwVU1741gue6qBmPa9J31DDYhqDeZ7fk5ZtRm6yb/Lkt165AGBnYG1gRaPrdf9oOtvTQgjChDpgpIkw85y5FvgTk82MKJhcXGHqzFUmsWOUFaS24hWLPCM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F2vF3KTk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=L4
	6rO0ap7fdHOhhsZy5f9zN9QRWddSPsjWbT2OnXFT0=; b=F2vF3KTk1xV3BxC9Sm
	Opb5RYsK6K4LYEsWNxahLI6WbVhV9Ybo+tIkFHev+zOm+kOy7b0rTOHl8XBkDJm2
	+SDYzfQ9152iGADDe0cpyygS3MoMMprCWeUjgdGUg+Da8vLNzM8XqDiR8wMMhXb5
	YuWPFqhWVxzJiQsC45i8wSdhY=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCnvZCgBLVoxnneFA--.15055S2;
	Mon, 01 Sep 2025 10:27:45 +0800 (CST)
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
Date: Mon,  1 Sep 2025 10:27:44 +0800
Message-Id: <20250901022744.1794421-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnvZCgBLVoxnneFA--.15055S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4xArWUtF1xZF45Gw4DArb_yoWfXrb_ur
	WDXw1vqr4rCr1rGFn2qF1UCrW5Kws7Aa4UGayrZry2q3yDZF9rGwn7ury5ZF1fGa18Zr43
	GFZrt3yfAa45ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb73vUUUUUU==
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiJRm7Cmi0-6iNVQAAse

On Sun, 2025-08-31 at 21:21 -0400, Willem wrote:

> > -		p1->retire_blk_tov = prb_calc_retire_blk_tmo(po,
> > -						req_u->req3.tp_block_size);
> > -	p1->tov_in_jiffies = msecs_to_jiffies(p1->retire_blk_tov);
> > +		p1->interval_ktime = ms_to_ktime(prb_calc_retire_blk_tmo(po,
> > +						req_u->req3.tp_block_size));
> 
> req_u is not aligned with the line above.

I have some questions regarding the alignment here. According to the alignment requirements,
req_u should be aligned below the po variable. However, if it is aligned below po, the line
will become very long, which may affect readability. In this special case, can I align it to
prb_calc_retire_blk_tmo instead, or should I continue to align it to the po variable?


What should I do next?
Should I change the alignment, and resend PATCH with the reviewed information of version 10?

Thanks
Xin Zhao


