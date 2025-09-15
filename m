Return-Path: <netdev+bounces-222932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F86B570CF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9875F178935
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49E91448D5;
	Mon, 15 Sep 2025 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IvQNitKh"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D07524F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919876; cv=none; b=mn7a4OGVCOMkXXOuqyQKZJM9nVhoj8H/TMq2r6Dyp5H/C2kdga0OSMbyzhxKzl+WXCxqLTtkSADYJoVBV2Kwpeg0j3z5edPsN2YmuY+Ms7d2F/ja5pIO7gTGU/nKsrPHTP9msHxvAoJIb6tL8cNmpcHFrRla0IUiZdTpiTO8yuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919876; c=relaxed/simple;
	bh=9hQ4rmBqkQZO/5AfeXT9P0jtrIGD+aoLioNSeB14NXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=If0WFjGvGK9rHgU95TLLrOrS6BtZYS3+W5dcDWOfMH3Qj70ythXcmXloKpkpmm9UErIK5iYwiiyUzXjn2jTsEgs8+oNZQg3ajg0tnRQlXVUr0yaaZ3M47i3vBi1l12/FydcjjPMx14MMMfB9H4xmaSdeASEScKvye5evDKxnC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IvQNitKh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757919870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zyqwdhquoEeiy6S2cASjbIOhsPheEXqSUAACInxmpwg=;
	b=IvQNitKhEXGxB8YRGIUojny6JoevvyVhqx4Q7kPY+CbaSg2Ff/1Hrk5U3Qy2b3+/cXiZx2
	Vo9/BTA5lTazA+bjrWUU20YwdC3520Dk50famzjAn+N2e4Rm1nx7watSNr7w83lyN7LSuI
	G1M93U2WOOhkXInI7aQahoQx/e+LVC8=
From: xuanqiang.luo@linux.dev
To: edumazet@google.com,
	kuniyu@google.com
Cc: kerneljasonxing@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net-next v1 0/3] net: Avoid ehash lookup races 
Date: Mon, 15 Sep 2025 15:03:05 +0800
Message-Id: <20250915070308.111816-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

After replacing R/W locks with RCU in commit 3ab5aee7fe84 ("net: Convert
TCP & DCCP hash tables to use RCU / hlist_nulls"), a race window emerged
during the switch from reqsk/sk to sk/tw.

Now that both timewait sock (tw) and full sock (sk) reside on the same ehash
chain, it is appropriate to introduce hlist_nulls replace operations, to
eliminate the race conditions caused by this window.

Xuanqiang Luo (3):
  rculist: Add __hlist_nulls_replace_rcu() and
    hlist_nulls_replace_init_rcu()
  inet: Avoid ehash lookup race in inet_ehash_insert()
  inet: Avoid ehash lookup race in inet_twsk_hashdance_schedule()

 include/linux/rculist_nulls.h | 62 +++++++++++++++++++++++++++++++++++
 include/net/sock.h            | 23 +++++++++++++
 net/ipv4/inet_hashtables.c    |  7 ++++
 net/ipv4/inet_timewait_sock.c | 20 ++++++-----
 4 files changed, 103 insertions(+), 9 deletions(-)

-- 
2.27.0


