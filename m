Return-Path: <netdev+bounces-267901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOroMd+btmlAEQEAu9opvQ
	(envelope-from <netdev+bounces-267901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 12:45:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B36C2908CB
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 12:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15A01303B175
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F8D27603C;
	Sun, 15 Mar 2026 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmmRNjP3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FABB189B84
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773575122; cv=none; b=AuSNK63mJgbTe8ShQ2ev8PWgiKgTsaZMJKFZv22TmVSbKRu9le15by5rAQTmCfFAiEjMFLcewx98DQ9AG+SgBs29cLwaTUvrP6W1FHplEVZ5jQNkznBNYXKhSu/S3qu9NT7Haa3prMd74gav5us5vqLt7F2WYP7GB/Yt6WuY6GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773575122; c=relaxed/simple;
	bh=8bPFnhY7tQqaL5zZHskvDQ4FmvGepBE1Y78yLnz1ntU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jn6rH5GSwecPyAfQGdGI0Xjg8EixcY5pQ4EBU/lO1AdljPodnIStL6KzyV701+8nP5HH/HChmV/oMNW1aS9Luk/VUBR9inZB6EyLh57WEPAXEkjAuFyIP11ht252v85bix2wu4faSpwY9mXcKEBVU7PiDQNV859Nqft+62bqTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmmRNjP3; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899f27df3d1so36695306d6.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 04:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773575120; x=1774179920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLh7q5AdHkHCZ7wZDBQLFKaEBePVPR7WoVRwRYcrgFE=;
        b=GmmRNjP3qHwpZ0oP9Ot6j34+dS5y2wJU+DfRH6AKCUC1Ly5jNv1nvfbX0pkTW3hQVX
         HLtb1FqX7XidX7DU9muAZaik5aXnIWshCe8iNYR9fUI1Ne3vPlZW+rdt1H665sb9r1cj
         bWMNzHRleaqRQzJy6WEBLp8OXx2JlX/JpK5Gxl4T3LqZIHYPaa+rYB2tWxVkDLMyQvmX
         98p7qcw+h95vo3rcRIdkrN1qvNzo6XumY/ZSbUZ0BNdKQhIfZpUFtsBRPL8nR1ldJ/3n
         zOya/7LkQh/y49315e4Drn/k7zjuC0997pkL0uiIW7mpbsCsYhvILHJE/8OOJ7/d7G91
         tmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773575120; x=1774179920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oLh7q5AdHkHCZ7wZDBQLFKaEBePVPR7WoVRwRYcrgFE=;
        b=EBvWuuRDLI1AzwgeRp/St90I5GEneO/KSsiSOvL1EPY6X7ezfFiKAHafIyHUX/4WAX
         P1hAKl49NjS92KI6zBNsmnd4oG6+4BK9WiBYhl1lahVQE/sEnjR4KxET8AeSXJEzewtv
         e6NNMlLA3wdhOYCnFcF4n7X6MrOcFKNmzVgmouAodOQ/Mm1FskSc3skp/yQDo7fJfjww
         Y7MJl+5QW5XeDK/6cA3GFN+HgQKi/HS4XfG6hkU0LTPtip/DpxX9Eq0y9NkJ3dpmzUqs
         440NmabdEr4rZf/aFu/HzRFZiUQFimKrlZC0HHuyMVar2TRgYXTJZ+qRASdzvPn/yVT+
         05IA==
X-Gm-Message-State: AOJu0YwfnlddAw/fiKAajk/z18STm9jg4jmZRGJoQxHE2lMGVwMHmBwv
	TmrQRQ0ODjd6xzWUBxJyN+RJDY/tFeUkl1gu9LgIUHwhrQVT8JBpRFkO
X-Gm-Gg: ATEYQzwFjKNQzLx4eX1j5t8uuSfiaBqAqmFnXPRMSEhvXFG9dHl2aTzU2pOSiiNO3Y0
	JTl7jKmmgENNThrt3qwuxCgxTJHjaqCFwoOWjyJ4OTn4fPHKFXLfQbzCC3A8r6VujI8yxZ+6UPg
	W5eVUlM0kX9DxmYv6YjwRw+a2gclcvraHyn0znEXfnVBefcznqpFjiApGMrYxntIjiD2PWX1FMt
	/R1EmGydl6lj8RQ7YHjWLcmdygRHDX5BEF8IB9O9oMXDDu9tMIG3fPghR92Fy1i5Q2Z7IiKLBQp
	eNWlV4KrlAYjzMzOBgyrR4/+T/y2lMYbNxOfhcZaZ/a3/ZOKHrlXquunvHFHWMAKD3S9wBKqs2Q
	Lu6XnB+6DEryCLJX6yBn1GOKV93ANOf78JlbWbDUVwtWeoO5qVKNQLCxSrrrB0cy/3GCuBgrEuX
	Z+1SBHvh80YW5tSSxEcDgqxgsy6zgmWZSL
X-Received: by 2002:a05:6214:495:b0:89a:c09:aa8a with SMTP id 6a1803df08f44-89a81ec24b4mr129741436d6.41.1773575120390;
        Sun, 15 Mar 2026 04:45:20 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65ce339dsm98261896d6.26.2026.03.15.04.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:45:20 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Date: Sun, 15 Mar 2026 19:44:27 +0800
Subject: [PATCH net 1/2] net: macb: Move devm_{free,request}_irq() out of
 spin lock area
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260315-macb-irq-v1-1-0154104cbf61@gmail.com>
References: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
In-Reply-To: <20260315-macb-irq-v1-0-0154104cbf61@gmail.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, Kevin Hao <haokexin@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B36C2908CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The devm_free_irq() and devm_request_irq() functions should not be
executed in an atomic context.

During device suspend, all userspace processes and most kernel threads
are frozen. Additionally, we flush all tx/rx status, disable all macb
interrupts, and halt rx operations. Therefore, it is safe to split the
region protected by bp->lock into two independent sections, allowing
devm_free_irq() and devm_request_irq() to run in a non-atomic context.
This modification resolves the following lockdep warning:
  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 501, name: rtcwake
  preempt_count: 1, expected: 0
  RCU nest depth: 1, expected: 0
  7 locks held by rtcwake/501:
   #0: ffff0008038c3408 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0xf8/0x368
   #1: ffff0008049a5e88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xbc/0x1c8
   #2: ffff00080098d588 (kn->active#70){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xcc/0x1c8
   #3: ffff800081c84888 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x1ec/0x290
   #4: ffff0008009ba0f8 (&dev->mutex){....}-{4:4}, at: device_suspend+0x118/0x4f0
   #5: ffff800081d00458 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48
   #6: ffff0008031fb9e0 (&bp->lock){-.-.}-{3:3}, at: macb_suspend+0x144/0x558
  irq event stamp: 8682
  hardirqs last  enabled at (8681): [<ffff8000813c7d7c>] _raw_spin_unlock_irqrestore+0x44/0x88
  hardirqs last disabled at (8682): [<ffff8000813c7b58>] _raw_spin_lock_irqsave+0x38/0x98
  softirqs last  enabled at (7322): [<ffff8000800f1b4c>] handle_softirqs+0x52c/0x588
  softirqs last disabled at (7317): [<ffff800080010310>] __do_softirq+0x20/0x2c
  CPU: 1 UID: 0 PID: 501 Comm: rtcwake Not tainted 7.0.0-rc3-next-20260310-yocto-standard+ #125 PREEMPT
  Hardware name: ZynqMP ZCU102 Rev1.1 (DT)
  Call trace:
   show_stack+0x24/0x38 (C)
   __dump_stack+0x28/0x38
   dump_stack_lvl+0x64/0x88
   dump_stack+0x18/0x24
   __might_resched+0x200/0x218
   __might_sleep+0x38/0x98
   __mutex_lock_common+0x7c/0x1378
   mutex_lock_nested+0x38/0x50
   free_irq+0x68/0x2b0
   devm_irq_release+0x24/0x38
   devres_release+0x40/0x80
   devm_free_irq+0x48/0x88
   macb_suspend+0x298/0x558
   device_suspend+0x218/0x4f0
   dpm_suspend+0x244/0x3a0
   dpm_suspend_start+0x50/0x78
   suspend_devices_and_enter+0xec/0x560
   pm_suspend+0x194/0x290
   state_store+0x110/0x158
   kobj_attr_store+0x1c/0x30
   sysfs_kf_write+0xa8/0xd0
   kernfs_fop_write_iter+0x11c/0x1c8
   vfs_write+0x248/0x368
   ksys_write+0x7c/0xf8
   __arm64_sys_write+0x28/0x40
   invoke_syscall+0x4c/0xe8
   el0_svc_common+0x98/0xf0
   do_el0_svc+0x28/0x40
   el0_svc+0x54/0x1e0
   el0t_64_sync_handler+0x84/0x130
   el0t_64_sync+0x198/0x1a0

Fixes: 558e35ccfe95 ("net: macb: WoL support for GEM type of Ethernet controller")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/cadence/macb_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ae5f0c95cf9b5df17aa34333175400f1bf1e2621..f290bc44020e76e681f403306cba998e540a4991 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5962,6 +5962,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			/* write IP address into register */
 			tmp |= MACB_BFEXT(IP, be32_to_cpu(ifa->ifa_local));
 		}
+		spin_unlock_irqrestore(&bp->lock, flags);
 
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
@@ -5974,11 +5975,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				dev_err(dev,
 					"Unable to request IRQ %d (error %d)\n",
 					bp->queues[0].irq, err);
-				spin_unlock_irqrestore(&bp->lock, flags);
 				return err;
 			}
+			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
 			gem_writel(bp, WOL, tmp);
+			spin_unlock_irqrestore(&bp->lock, flags);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5986,13 +5988,13 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				dev_err(dev,
 					"Unable to request IRQ %d (error %d)\n",
 					bp->queues[0].irq, err);
-				spin_unlock_irqrestore(&bp->lock, flags);
 				return err;
 			}
+			spin_lock_irqsave(&bp->lock, flags);
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
 			macb_writel(bp, WOL, tmp);
+			spin_unlock_irqrestore(&bp->lock, flags);
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
 		enable_irq_wake(bp->queues[0].irq);
 	}
@@ -6059,6 +6061,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 		queue_readl(bp->queues, ISR);
 		if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 			queue_writel(bp->queues, ISR, -1);
+		spin_unlock_irqrestore(&bp->lock, flags);
+
 		/* Replace interrupt handler on queue 0 */
 		devm_free_irq(dev, bp->queues[0].irq, bp->queues);
 		err = devm_request_irq(dev, bp->queues[0].irq, macb_interrupt,
@@ -6067,10 +6071,8 @@ static int __maybe_unused macb_resume(struct device *dev)
 			dev_err(dev,
 				"Unable to request IRQ %d (error %d)\n",
 				bp->queues[0].irq, err);
-			spin_unlock_irqrestore(&bp->lock, flags);
 			return err;
 		}
-		spin_unlock_irqrestore(&bp->lock, flags);
 
 		disable_irq_wake(bp->queues[0].irq);
 

-- 
2.53.0


