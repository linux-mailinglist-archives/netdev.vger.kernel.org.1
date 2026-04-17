Return-Path: <netdev+bounces-279307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAWtNyYk4mlX1wAAu9opvQ
	(envelope-from <netdev+bounces-279307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:14:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609F41B23A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6175E3088F75
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE63377EBA;
	Fri, 17 Apr 2026 12:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F723101BC;
	Fri, 17 Apr 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427726; cv=none; b=W8pZpzaDjXQq9Pnpb1uFhwYAW0eMgXbWmFSBVV0oSS7xjtE1VdOg8ZSsBvTn5KCODEAaORU2CPx9xwK1D6Dj2brFmmkcnuPv/kTnisYP/fO+HV2rrD/yPbIxWExdnLosoyaD0N57znI8+POVvOWYkcucAn/pbvGEBsLSmzxStOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427726; c=relaxed/simple;
	bh=Fu7cBTVm4EUD/2LDczIxEyrLvsmxg0Mr0T2osrZ0MyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wce1yNdBqXAxgEh6ciSsiFgFTTyWF76ZMEBQL6MMcG2NT+JLdBko5iHLMM03UvgA6Ww/YIVUJsDAuqKUCHGGClHlJtwpHEs+M1r0qsTTdgK6EFTKK/pQt5m513nzBl2kNhhQ8+z0FX1rifjRSmNiVnJIQOBruyXM8TuUd5tAEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wDhzt-000000004Gm-0SZ7;
	Fri, 17 Apr 2026 12:08:33 +0000
Date: Fri, 17 Apr 2026 13:08:29 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net] net: dsa: mt7530: fix .get_stats64 sleeping in
 atomic context
Message-ID: <aeIivb0AwRoCOezc@makrotopia.org>
References: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
 <C88911FE-2012-4D29-B7F2-6BEA28122854@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C88911FE-2012-4D29-B7F2-6BEA28122854@arinc9.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279307-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,public-files.de,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: 3609F41B23A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 07:35:46AM +0000, Chester A. Unal wrote:
> On 17 April 2026 04:55:57 WEST, Daniel Golle <daniel@makrotopia.org> wrote:
> >The .get_stats64 callback runs in atomic context, but on
> >MDIO-connected switches every register read acquires the MDIO bus
> >mutex, which can sleep:
> >[   12.645973] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:609
> >[   12.654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 759, name: grep
> >[   12.663377] preempt_count: 0, expected: 0
> >[   12.667410] RCU nest depth: 1, expected: 0
> >[   12.671511] INFO: lockdep is turned off.
> >[   12.675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W           7.0.0+ #0 PREEMPT
> >[   12.675453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> >[   12.675456] Hardware name: Bananapi BPI-R64 (DT)
> >[   12.675459] Call trace:
> >[   12.675462]  show_stack+0x14/0x1c (C)
> >[   12.675477]  dump_stack_lvl+0x68/0x8c
> >[   12.675487]  dump_stack+0x14/0x1c
> >[   12.675495]  __might_resched+0x14c/0x220
> >[   12.675504]  __might_sleep+0x44/0x80
> >[   12.675511]  __mutex_lock+0x50/0xb10
> >[   12.675523]  mutex_lock_nested+0x20/0x30
> >[   12.675532]  mt7530_get_stats64+0x40/0x2ac
> >[   12.675542]  dsa_user_get_stats64+0x2c/0x40
> >[   12.675553]  dev_get_stats+0x44/0x1e0
> >[   12.675564]  dev_seq_printf_stats+0x24/0xe0
> >[   12.675575]  dev_seq_show+0x14/0x3c
> >[   12.675583]  seq_read_iter+0x37c/0x480
> >[   12.675595]  seq_read+0xd0/0xec
> >[   12.675605]  proc_reg_read+0x94/0xe4
> >[   12.675615]  vfs_read+0x98/0x29c
> >[   12.675625]  ksys_read+0x54/0xdc
> >[   12.675633]  __arm64_sys_read+0x18/0x20
> >[   12.675642]  invoke_syscall.constprop.0+0x54/0xec
> >[   12.675653]  do_el0_svc+0x3c/0xb4
> >[   12.675662]  el0_svc+0x38/0x200
> >[   12.675670]  el0t_64_sync_handler+0x98/0xdc
> >[   12.675679]  el0t_64_sync+0x158/0x15c
> >
> >For MDIO-connected switches, poll MIB counters asynchronously using a
> >delayed workqueue every second and let .get_stats64 return the cached
> >values under a per-port spinlock. A mod_delayed_work() call on each
                 ^^^^^^^^^^^^^^^^^^^
Just noticed I forgot to update the commit message when changing the
implementation to use a single shared spinlock for all ports...

I'll send v2 tomorrow fixing that, and what ever else comes up, if
anything.

> >read triggers an immediate refresh so counters stay responsive when
> >queried more frequently.
> >
> >MMIO-connected switches (MT7988, EN7581, AN7583) are not affected
> >because their regmap does not sleep, so they continue to read MIB
> >counters directly in .get_stats64.
> >
> >Fixes: 88c810f35ed5 ("net: dsa: mt7530: implement .get_stats64")
> >Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> >---
> >This bug highlights a bigger problem and the actual cause:
> >Locking in the mt7530 driver deserves a cleanup, and refactoring
> >towards cleanly and directly using the regmap API.
> >I've prepared this already and am going to submit a series doing
> >most of that using Coccinelle semantic patches once net-next opens
> >again.
> 
> Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
> 
> Chester A.

