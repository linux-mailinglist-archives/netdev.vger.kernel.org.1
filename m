Return-Path: <netdev+bounces-279306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACbsJPYj4mlX1wAAu9opvQ
	(envelope-from <netdev+bounces-279306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:13:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 124F441B214
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA0C3051CB2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D961932AADE;
	Fri, 17 Apr 2026 12:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6UQYiMQ5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFF32720D;
	Fri, 17 Apr 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776427624; cv=none; b=D4P7XKZeUpPZFcSP2UHiEjNrp5X+egkRwyiJkksIl+VtMpV5vkSwo8WGvHM2mIRlLqUqjd6N35vEBvqbiHklwZCRQvxBWRNLwxw3auMjvm+nCbz9pzD4bKQHDCkC5Ipk9lUn10OmtXT+bzwpe+atrUUzWPN4ddVWhd4klsoaUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776427624; c=relaxed/simple;
	bh=cL8gLpW+1epVEX9ZVG8kF27eASqOm9KAl/vRG/sHVTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llmLo+3M3qNd4AKEgmvv/saFKcf0Z30VLKC8Dp1v5XwR+TpjOrVBU3grUvptPn2Fm13/s086rySOPoiMSS9oYQAp2S5g4qaQRVV2jSKCVx2R784dYnyLQs3Mqj6rWnaGV1DHr9BmPf6shceyzy3FFByhssNqfGJZv6Low+TrvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6UQYiMQ5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wTHSH6uu7em/XyG5vJUzJuQqtbjE+m45vOUXrzdH4tM=; b=6UQYiMQ5q8vCBsc1etsvXiiZo+
	XHP5/l/O13WqgPPglFsZA8n+lLA2OgvtXkz9xqLt2XDPMawwrnCZmdZIwgycvme1QwISQAq4FHJPX
	iF2e04DdPggqG02XWXXUoCyR9so6m5OROZ3czMlDdrgOYnn9YwvuJD6vyDJlyD4qSfPw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDhxv-00GPFd-4b; Fri, 17 Apr 2026 14:06:31 +0200
Date: Fri, 17 Apr 2026 14:06:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Vladimir Oltean <olteanv@gmail.com>,
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
Message-ID: <fb8dfd82-9e11-4cdb-936d-46b7ababcb3f@lunn.ch>
References: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79dc0ec5b6be698b14cb66339d6f63033ca2934a.1776397542.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279306-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arinc9.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,collabora.com,armlinux.org.uk,vger.kernel.org,lists.infradead.org,public-files.de,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:email,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 124F441B214
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 04:55:57AM +0100, Daniel Golle wrote:
> The .get_stats64 callback runs in atomic context, but on
> MDIO-connected switches every register read acquires the MDIO bus
> mutex, which can sleep:
> [   12.645973] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:609
> [   12.654442] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 759, name: grep
> [   12.663377] preempt_count: 0, expected: 0
> [   12.667410] RCU nest depth: 1, expected: 0
> [   12.671511] INFO: lockdep is turned off.
> [   12.675441] CPU: 0 UID: 0 PID: 759 Comm: grep Tainted: G S      W           7.0.0+ #0 PREEMPT
> [   12.675453] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
> [   12.675456] Hardware name: Bananapi BPI-R64 (DT)
> [   12.675459] Call trace:
> [   12.675462]  show_stack+0x14/0x1c (C)
> [   12.675477]  dump_stack_lvl+0x68/0x8c
> [   12.675487]  dump_stack+0x14/0x1c
> [   12.675495]  __might_resched+0x14c/0x220
> [   12.675504]  __might_sleep+0x44/0x80
> [   12.675511]  __mutex_lock+0x50/0xb10
> [   12.675523]  mutex_lock_nested+0x20/0x30
> [   12.675532]  mt7530_get_stats64+0x40/0x2ac
> [   12.675542]  dsa_user_get_stats64+0x2c/0x40
> [   12.675553]  dev_get_stats+0x44/0x1e0
> [   12.675564]  dev_seq_printf_stats+0x24/0xe0
> [   12.675575]  dev_seq_show+0x14/0x3c
> [   12.675583]  seq_read_iter+0x37c/0x480
> [   12.675595]  seq_read+0xd0/0xec
> [   12.675605]  proc_reg_read+0x94/0xe4
> [   12.675615]  vfs_read+0x98/0x29c
> [   12.675625]  ksys_read+0x54/0xdc
> [   12.675633]  __arm64_sys_read+0x18/0x20
> [   12.675642]  invoke_syscall.constprop.0+0x54/0xec
> [   12.675653]  do_el0_svc+0x3c/0xb4
> [   12.675662]  el0_svc+0x38/0x200
> [   12.675670]  el0t_64_sync_handler+0x98/0xdc
> [   12.675679]  el0t_64_sync+0x158/0x15c
> 
> For MDIO-connected switches, poll MIB counters asynchronously using a
> delayed workqueue every second and let .get_stats64 return the cached
> values under a per-port spinlock. A mod_delayed_work() call on each
> read triggers an immediate refresh so counters stay responsive when
> queried more frequently.
> 
> MMIO-connected switches (MT7988, EN7581, AN7583) are not affected
> because their regmap does not sleep, so they continue to read MIB
> counters directly in .get_stats64.
> 
> Fixes: 88c810f35ed5 ("net: dsa: mt7530: implement .get_stats64")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

