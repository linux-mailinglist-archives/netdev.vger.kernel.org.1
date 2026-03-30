Return-Path: <netdev+bounces-273163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGmNHvJxymnG8gUAu9opvQ
	(envelope-from <netdev+bounces-273163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:52:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B735B50C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1149305BBB4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2863D16F9;
	Mon, 30 Mar 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UQb9qx6x"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8430E84F;
	Mon, 30 Mar 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774874793; cv=none; b=nkbMx6zfqY3BqNu7QgoYxSgzRaSzg3K98OLfjLe2D7dCzFsmXP/2EYit6sy+iM1sUJMDluzXpsCsi/tmxOshHoG7zJz6VEdbOYbCqAHjliEncii/y86ryAi1HSkx0zbQ7HWX5HpEXeniTcF34l6NpzVXn9k0KXILBtY+o1gxppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774874793; c=relaxed/simple;
	bh=+JI1lyVpwmCdQmV9IzVwmr2ini/KIrHwAFCVRT27qCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5EYa4msTpfHbCDDx9FBdcxaP1O9zYvfCPwpPRE3RnDUjL+XO95k+uR45Jh/9A76enknBLjpFXlSJOnOFiVfVroOPUniBCHll5TndnvbgpX6uwY42Y8JWiK0nqHotnoMJqcHDLpA8zFQEl2iwp2dUjGoPDEblizaL98DQl0DYoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UQb9qx6x; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=X22xCMJmu+cCZa6SjDViytKlQGgWoaHzcMM/4kRa0lY=; b=UQb9qx6x0SumTYNtBWwA3KVjak
	SJbzjiC7revnqpS7MiEnD7lPS11/w0KZnO9LKnxQrXtU7xGOlXHuMk5qmjxMMyk7SoVr9JOP+yQ3S
	ipZziRwBNBl0+CCrMtZepHXdUfRQ3VRCtbECSYt6wE/j5ZPEfOjy0i6JrsDEYNS3aR8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w7C0e-00E22J-42; Mon, 30 Mar 2026 14:46:24 +0200
Date: Mon, 30 Mar 2026 14:46:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] FDDI: defxx: Rate-limit memory allocation errors
Message-ID: <6f38637b-87bb-48ad-a6f9-8eec5f33ec93@lunn.ch>
References: <alpine.DEB.2.21.2603291236590.60268@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2603291236590.60268@angie.orcam.me.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273163-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,orcam.me.uk:email]
X-Rspamd-Queue-Id: E07B735B50C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 01:32:25PM +0100, Maciej W. Rozycki wrote:
> Prevent the system from becoming unstable or unusable due to a flood of 
> memory allocation error messages under memory pressure, e.g.:
> 
> [...]
> fddi0: Could not allocate receive buffer.  Dropping packet.
> fddi0: Could not allocate receive buffer.  Dropping packet.
> fddi0: Could not allocate receive buffer.  Dropping packet.
> fddi0: Could not allocate receive buffer.  Dropping packet.
> rcu: INFO: rcu_sched self-detected stall on CPU
> rcu: 	0-...!: (332 ticks this GP) idle=255c/1/0x40000000 softirq=16420123/16420123 fqs=0
> rcu: 	(t=2103 jiffies g=35680089 q=4 ncpus=1)
> rcu: rcu_sched kthread timer wakeup didn't happen for 2102 jiffies! g35680089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
> rcu: 	Possible timer handling issue on cpu=0 timer-softirq=12779658
> rcu: rcu_sched kthread starved for 2103 jiffies! g35680089 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
> rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_sched       state:I stack:0     pid:14    tgid:14    ppid:2      flags:0x00004000
> Call Trace:
>  __schedule+0x258/0x580
>  schedule+0x19/0xa0
>  schedule_timeout+0x4a/0xb0
>  ? hrtimers_cpu_dying+0x1b0/0x1b0
>  rcu_gp_fqs_loop+0xb1/0x450
>  rcu_gp_kthread+0x9d/0x130
>  kthread+0xb2/0xe0
>  ? rcu_gp_init+0x4a0/0x4a0
>  ? kthread_park+0x90/0x90
>  ret_from_fork+0x2d/0x50
>  ? kthread_park+0x90/0x90
>  ret_from_fork_asm+0x12/0x20
>  entry_INT80_32+0x10d/0x10d
> CPU: 0 UID: 500 PID: 21895 Comm: 31370.exe Not tainted 6.13.0-dirty #2
> 
> (here running the libstdc++-v3 testsuite).
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

