Return-Path: <netdev+bounces-119180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4D2954847
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBDD2835DE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC271AE04F;
	Fri, 16 Aug 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="2JxkzdTy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BEA1AD3EF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809082; cv=none; b=K+DSmq4Fxi5Y7OT8014n83U5cZNtPHq+xpv7Dnk4fEb36+2hX2BH67fqp8q4VYUZ6ExjP51GOGuU3ONPnG9DOrv8Xw6eEBmbA2zDGYbiX+GoJMCjEqDK3iQzX+zsH3L5Vhu8WRAqq8N4P6j1rphQA8x/1DI/aFssgFcnlK3MlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809082; c=relaxed/simple;
	bh=Xkbzi/UxFj0mtxCXA7fLuLqNIKDKx7Shm7l6a3IUs14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHjZbgr2zbrhfb7W2qGmTDLncHicsJ2VE/Vu3nG9nsmN9OoDb3udaGWSnf7+u8hBF40ZEvoWJn9XS8KOT2165uT37BBHByW41+Mq1q7ZNtdk8XkSOUWaaye/zFV5oBeH6B7tGRX6fxh4HzwA8G1jFYCERAURDQTM1NPM8go/K58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=2JxkzdTy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so1996975a12.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723809079; x=1724413879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou8Kfu9k+15Hd/VmyVXRlFZQLlHIVY7EJ/iMOj0jNJg=;
        b=2JxkzdTyc8lOxNLjnxzEAuME9NFgsq/SJRp3072F8Gj8x4eR3cxF51esnStkOZZtXv
         P8Cwpj03LJApX6X/SAn4pxPYonQ/PP36KvkOf1rGIeR7vvsWJQUg2gCbvyJQfX76WCnb
         I3fF20qiPL3syeeoqF6AIPcvned/WvnHytbB+rCQ7chQmnuv11DbayFeMphmANUAg7EI
         LbnC597pQdTA2FkOBNT/Y1te6QYUqZzhnmlRomYsj4haDf9fIOPmkE55GI3HMAxEnrnV
         bsBlv25Gq+qVD7KKXmla3JZt0ZD1IwPMHVQBPN5rF+DiOMZWx6Jz9eBRmUn8t6WSnF7b
         WO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809079; x=1724413879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou8Kfu9k+15Hd/VmyVXRlFZQLlHIVY7EJ/iMOj0jNJg=;
        b=BZ3vtIQa0rlG60ynglCSUNapa2kNhI+GJfbMSjC0SIz38Zo1fXom82w1NA4KnFSKk0
         Ktmzxo6XzTWsnzaGhMRNyzYlUvmxl/NmrMQmso/m2ez6AtEzdWSAHVR62Ks+LU7O4rOP
         GeEmoqP6sY41B7RsXePjlxEvfznuOMktJrKJ/QSmM4Q7s/wuJq90VEbLRn3IEjyq9za2
         C/lrXzTReV+jt8cBzcCHHGP060X1dwAecuxt45kg3TDAhpHQjtqxx/QMiHekrtqgHIa7
         18LLieLvInrkHz4fwuHLViL3FnF9AttYKcS2KKd7Hcs6vMYtvjczAXxYfVlvqvXI0FnA
         LA7Q==
X-Gm-Message-State: AOJu0Yz9ZmfbuBjOSxwDxbRF66OExHpElmNtBm2XMLsg+Da5kf/RTRjE
	5rlWe5tCdOKs2p1vkBJOxk0y42HOpCOKMwMXBd6SfN2/JAGCssim3dboBaOoUVsjjJJiwNu3V+K
	A
X-Google-Smtp-Source: AGHT+IFdmBrIZTNRP7qVRuqYUDV/iuxap7POx2Ksg3Tr2SE2qbGfT9XeM+oPjanbL//DES9NJ8DweA==
X-Received: by 2002:a05:6402:5206:b0:5a2:1f7b:e017 with SMTP id 4fb4d7f45d1cf-5beca4da60dmr1881346a12.4.1723809078563;
        Fri, 16 Aug 2024 04:51:18 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde7cd4sm2152845a12.39.2024.08.16.04.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 04:51:18 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net,
	jv@jvosburgh.net,
	andy@greyhouse.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jarod@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 3/4] bonding: fix xfrm real_dev null pointer dereference
Date: Fri, 16 Aug 2024 14:48:12 +0300
Message-ID: <20240816114813.326645-4-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816114813.326645-1-razor@blackwall.org>
References: <20240816114813.326645-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We shouldn't set real_dev to NULL because packets can be in transit and
xfrm might call xdo_dev_offload_ok() in parallel. All callbacks assume
real_dev is set.

 Example trace:
 kernel: BUG: unable to handle page fault for address: 0000000000001030
 kernel: bond0: (slave eni0np1): making interface the new active one
 kernel: #PF: supervisor write access in kernel mode
 kernel: #PF: error_code(0x0002) - not-present page
 kernel: PGD 0 P4D 0
 kernel: Oops: 0002 [#1] PREEMPT SMP
 kernel: CPU: 4 PID: 2237 Comm: ping Not tainted 6.7.7+ #12
 kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-2.fc40 04/01/2014
 kernel: RIP: 0010:nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
 kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
 kernel: Code: e0 0f 0b 48 83 7f 38 00 74 de 0f 0b 48 8b 47 08 48 8b 37 48 8b 78 40 e9 b2 e5 9a d7 66 90 0f 1f 44 00 00 48 8b 86 80 02 00 00 <83> 80 30 10 00 00 01 b8 01 00 00 00 c3 0f 1f 80 00 00 00 00 0f 1f
 kernel: bond0: (slave eni0np1): making interface the new active one
 kernel: RSP: 0018:ffffabde81553b98 EFLAGS: 00010246
 kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
 kernel:
 kernel: RAX: 0000000000000000 RBX: ffff9eb404e74900 RCX: ffff9eb403d97c60
 kernel: RDX: ffffffffc090de10 RSI: ffff9eb404e74900 RDI: ffff9eb3c5de9e00
 kernel: RBP: ffff9eb3c0a42000 R08: 0000000000000010 R09: 0000000000000014
 kernel: R10: 7974203030303030 R11: 3030303030303030 R12: 0000000000000000
 kernel: R13: ffff9eb3c5de9e00 R14: ffffabde81553cc8 R15: ffff9eb404c53000
 kernel: FS:  00007f2a77a3ad00(0000) GS:ffff9eb43bd00000(0000) knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 0000000000001030 CR3: 00000001122ab000 CR4: 0000000000350ef0
 kernel: bond0: (slave eni0np1): making interface the new active one
 kernel: Call Trace:
 kernel:  <TASK>
 kernel:  ? __die+0x1f/0x60
 kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
 kernel:  ? page_fault_oops+0x142/0x4c0
 kernel:  ? do_user_addr_fault+0x65/0x670
 kernel:  ? kvm_read_and_reset_apf_flags+0x3b/0x50
 kernel: bond0: (slave eni0np1): making interface the new active one
 kernel:  ? exc_page_fault+0x7b/0x180
 kernel:  ? asm_exc_page_fault+0x22/0x30
 kernel:  ? nsim_bpf_uninit+0x50/0x50 [netdevsim]
 kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
 kernel:  ? nsim_ipsec_offload_ok+0xc/0x20 [netdevsim]
 kernel: bond0: (slave eni0np1): making interface the new active one
 kernel:  bond_ipsec_offload_ok+0x7b/0x90 [bonding]
 kernel:  xfrm_output+0x61/0x3b0
 kernel: bond0: (slave eni0np1): bond_ipsec_add_sa_all: failed to add SA
 kernel:  ip_push_pending_frames+0x56/0x80

Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/bonding/bond_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 65ddb71eebcd..f74bacf071fc 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -582,7 +582,6 @@ static void bond_ipsec_del_sa_all(struct bonding *bond)
 		} else {
 			slave->dev->xfrmdev_ops->xdo_dev_state_delete(ipsec->xs);
 		}
-		ipsec->xs->xso.real_dev = NULL;
 	}
 	spin_unlock_bh(&bond->ipsec_lock);
 	rcu_read_unlock();
-- 
2.44.0


