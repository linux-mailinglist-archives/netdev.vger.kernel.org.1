Return-Path: <netdev+bounces-216973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC49B36D02
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 17:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16BB01C278B1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62091233D9E;
	Tue, 26 Aug 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ldKK1vKN"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03978F29;
	Tue, 26 Aug 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756220073; cv=none; b=s7FkQ1lIaml6ZTHA/PE5EyQXDNOuAo2eBhnAZMPf9KPdIm9WW4UdtFqc23wZQIkh4P99w9WMn4FIb2TgFCHxMxJDYvfYgBlrpcHUvamhelYubNPR6NGSgPD6U+2oKkwIBvaDsmwEHCtHy3oST/r2BQeL8Hs3/FXZ3S7JPJZwLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756220073; c=relaxed/simple;
	bh=MvRfvUf6abYymRc7lUVYGV4GWw71Ybb08AnP1PVsQ9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kaQx2SN/x0ix2YPsXpOhRhkYrIw64HqugYkysIhiWDKRCPCbCuRO3sXiKzkWJ3oU6k87BInk+CcDHxn2xUngdmVFDOziJbEe2jv0lEs0UNESEZqZPN4fuwsJ3tXig7obHh6922iZfWhfAemJC96MSQD/bYxCnMQOoOLWv/IdnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ldKK1vKN; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ys
	6LaHuKZ2z4U/Mf0q0mRUxc7aDl0tLNA35Pm60bUKI=; b=ldKK1vKN4NVDo2z5Vo
	L7YFDoLaQ+cb43eXXr52ipytSaRBF4WW1zt4xiCZdS7qR0yrwjF6+RPqG5RHrdox
	5C1W1nBXVLNpPX9fBzqZmrYHxFKhnWyAjCwHRNl605jOesFwjMUQ0rdHsR0ubjUm
	b1y4iSpMfQIsTmcE9CI5xOv4Y=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3XxV7yq1osnesAg--.35194S2;
	Tue, 26 Aug 2025 22:53:48 +0800 (CST)
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
Subject: Re: [PATCH net-next v7] net: af_packet: Use hrtimer to do the retire operation
Date: Tue, 26 Aug 2025 22:53:47 +0800
Message-Id: <20250826145347.1309654-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3XxV7yq1osnesAg--.35194S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWfuFyxuw1DurWktFWDArb_yoW8GFW8pr
	Wjg347Gw1DXw1Igw4xXFs7uFyrCwsxJr15Grs3Wr4SkF95GFyUta1jyFyrWFW3C3Z8Kw47
	Aw48ZrZ3Aws5JrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPR67UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/1tbiJQW1CmitwjvTYQAAsR

On Tue, 2025-08-25 at 20:54 +0800, Willem wrote:

> > I understand that the additional in_scheduled variable is meant to prevent
> > multiple calls to hrtimer_start. However, based on the current logic
> > implementation, the only scenario that would cancel the hrtimer is after calling
> > prb_shutdown_retire_blk_timer. Therefore, once we have called hrtimer_start in
> > prb_setup_retire_blk_timer, we don't need to worry about the hrtimer stopping,
> > and we don't need to execute hrtimer_start again or check if the hrtimer is in
> > an active state. We can simply update the timeout in the callback.
> 
> The hrtimer is also canceled when the callback returns
> HRTIMER_NORESTART.

In prb_retire_rx_blk_timer_expired function, the only way to return HRTIMER_NORESTART
is that the pkc->delete_blk_timer is NOT 0.
The delete_blk_timer is only set to 1 in prb_shutdown_retire_blk_timer which is called
by packet_set_ring.
In my understanding, once packet_set_ring is called and prb_shutdown_retire_blk_timer
is executed, the only way to make this af_packet work again is to call packet_set_ring
again to execute prb_setup_retire_blk_timer. At that point, hrtimer_start will be
called again. Therefore, I feel that there is no need to perform the check in
_prb_refresh_rx_retire_blk_timer. Only let prb_setup_retire_blk_timer to hrtimer_start,
is that right?


Thanks
Xin Zhao


