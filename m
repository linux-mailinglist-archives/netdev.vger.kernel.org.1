Return-Path: <netdev+bounces-99204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D808D418F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 00:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12120B23CF4
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 22:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705F81CB31B;
	Wed, 29 May 2024 22:52:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD2177998
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 22:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023156; cv=none; b=dLczbnkchnByoKuUzNpsJBKwVSB7k5tKoenNK+q18Q8OdamQIt5gf8iBI5VrXot0yx2RHLL5dRjlaKMjrmfBBAcCDq0fQJGJbLnXURGhkZ5gf2SA/UxyK63KV4j3VA7WTcCuUEyyBfkwJvl89afTA6RMYUdM//+iBJe8/JQEwfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023156; c=relaxed/simple;
	bh=vqkyHHW4PwgHBGmkIZoxN/e0NEz8SOdRvMtxc1UfDSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdQIsgqFQ7jJm+KSpQvCsLmBntLzAxts44gXqNioTVooZ/FYTflccEyt4+RBLqUglnWfCe3F/bgr2GTg3NF7tWuaoWKrVcN7Vxd1Llctre6Sh9mIFO56kT4tuCTc3ExUIeF9mZfytViDBnRE8WnvOy0rPLpdpmXhu7wFwWEhI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.5])
	by sina.com (10.75.12.45) with ESMTP
	id 6657B1A800008D7B; Wed, 30 May 2024 06:52:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 53405531457760
X-SMAIL-UIID: 60F0618A0EC44D0B8A2E020B17212CA5-20240530-065226-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Radoslaw Zielonek <radoslaw.zielonek@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in packet_release
Date: Thu, 30 May 2024 06:52:14 +0800
Message-Id: <20240529225214.2968-1-hdanton@sina.com>
In-Reply-To: <0000000000007d66bc06196e7c66@google.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test Vlad's patch [1]
[1] https://lore.kernel.org/netdev/20240527153955.553333-1-vladimir.oltean@nxp.com/

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  main

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -1847,6 +1847,7 @@ static int taprio_change(struct Qdisc *s
 		return -EOPNOTSUPP;
 	}
 	q->flags = taprio_flags;
+	taprio_set_picos_per_byte(dev, q);
 
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
@@ -1907,7 +1908,6 @@ static int taprio_change(struct Qdisc *s
 	if (err < 0)
 		goto free_sched;
 
-	taprio_set_picos_per_byte(dev, q);
 	taprio_update_queue_max_sdu(q, new_admin, stab);
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
--

