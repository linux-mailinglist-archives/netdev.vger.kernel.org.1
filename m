Return-Path: <netdev+bounces-272886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJl/DOAbyWnGugUAu9opvQ
	(envelope-from <netdev+bounces-272886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCE8351EA3
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A68C3013A7C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ED135AC10;
	Sun, 29 Mar 2026 12:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F5C2DF14C;
	Sun, 29 Mar 2026 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787549; cv=none; b=gWVI6ssxg/6rXmh0cR+dWHL7JfOPX5JP69IyDC7BPMpefzJ75qagMJqemIMw1CWn9fX+32Q7keChtZqUhex36TMOvCp7E6i6UfITOO5R6eDJGtLA3MLNQI7uyZ36fIErR22y+9ZlqDJ5u01/tPXhMoMyb2YKhFdqg29vOREq/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787549; c=relaxed/simple;
	bh=n6AudPinwzF+PoAcpbD8rWgYmTs3P0AQRN0xUrqvZTs=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=LQgHUG/XdCmypBCmpnWsD6Mm5Jr3jY1RPLfBSCQi2+qm0RfGzET9q13pCfhc7gp6HiZ4M8uZidwBIm+VRPTtYXwtiomD5qKvSfxC9HXEvnsWY84Hpyugtiu1IKLfP7tVRcNeZHas67H1jEoQk5oJs6D0Va59d9RuohUWysUoIso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8D27B92009C; Sun, 29 Mar 2026 14:32:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7E5F392009B;
	Sun, 29 Mar 2026 13:32:25 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] FDDI: defxx: Rate-limit memory allocation errors
Message-ID: <alpine.DEB.2.21.2603291236590.60268@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272886-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orcam.me.uk:email]
X-Rspamd-Queue-Id: 7FCE8351EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prevent the system from becoming unstable or unusable due to a flood of 
memory allocation error messages under memory pressure, e.g.:

[...]
fddi0: Could not allocate receive buffer.  Dropping packet.
fddi0: Could not allocate receive buffer.  Dropping packet.
fddi0: Could not allocate receive buffer.  Dropping packet.
fddi0: Could not allocate receive buffer.  Dropping packet.
rcu: INFO: rcu_sched self-detected stall on CPU
rcu: 	0-...!: (332 ticks this GP) idle=255c/1/0x40000000 softirq=16420123/16420123 fqs=0
rcu: 	(t=2103 jiffies g=35680089 q=4 ncpus=1)
rcu: rcu_sched kthread timer wakeup didn't happen for 2102 jiffies! g35680089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=12779658
rcu: rcu_sched kthread starved for 2103 jiffies! g35680089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_sched       state:I stack:0     pid:14    tgid:14    ppid:2      flags:0x00004000
Call Trace:
 __schedule+0x258/0x580
 schedule+0x19/0xa0
 schedule_timeout+0x4a/0xb0
 ? hrtimers_cpu_dying+0x1b0/0x1b0
 rcu_gp_fqs_loop+0xb1/0x450
 rcu_gp_kthread+0x9d/0x130
 kthread+0xb2/0xe0
 ? rcu_gp_init+0x4a0/0x4a0
 ? kthread_park+0x90/0x90
 ret_from_fork+0x2d/0x50
 ? kthread_park+0x90/0x90
 ret_from_fork_asm+0x12/0x20
 entry_INT80_32+0x10d/0x10d
CPU: 0 UID: 500 PID: 21895 Comm: 31370.exe Not tainted 6.13.0-dirty #2

(here running the libstdc++-v3 testsuite).

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/net/fddi/defxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-defxx-ratelimit.diff
Index: linux-macro/drivers/net/fddi/defxx.c
===================================================================
--- linux-macro.orig/drivers/net/fddi/defxx.c
+++ linux-macro/drivers/net/fddi/defxx.c
@@ -3182,7 +3182,7 @@ static void dfx_rcv_queue_process(
 							       pkt_len + 3);
 				if (skb == NULL)
 					{
-					printk("%s: Could not allocate receive buffer.  Dropping packet.\n", bp->dev->name);
+					printk_ratelimited("%s: Could not allocate receive buffer.  Dropping packet.\n", bp->dev->name);
 					bp->rcv_discards++;
 					break;
 					}

