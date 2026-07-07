Return-Path: <netdev+bounces-305572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hi5sKR1MTWpIxwEAu9opvQ
	(envelope-from <netdev+bounces-305572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:57:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D771EC93
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 20:57:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=agner.ch header.s=dkim header.b=VwgDDaMG;
	dmarc=pass (policy=none) header.from=agner.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305572-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305572-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AAF8D3010637
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB798393DE6;
	Tue,  7 Jul 2026 18:57:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E943939B3
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 18:57:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783450651; cv=none; b=VmSTqY7d6z4TKBG7NqCsRWdWlAXtSDqzPU1s1wRfx20tMoKoBAAtE0znsBg34vP0D99qkH15HCNqZe3oXwjzRS8cBjB3KxZi6+zXV28Fpf4lRxSYjAaN6pXVnL1K8btrVVoIXuBwLBOBO0HeiXyevIymIyww6gfYDHWYBbN06QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783450651; c=relaxed/simple;
	bh=SuirHauW++G4Ar/yk7wb9GuULubGuPXTLVBvK9iAPt0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AvF4fN9lNm288gxshRiLgFdSSZhCJg5K+eM4nZ4orizORqx4txM3d6jPbaEYzc5pIgLxgxZGzhOAen35Q+ITmq2++1PDCBUCh/wY1cjA0QYxcopmBUoIj8spyl5a8U/zv92zE+U165KEcQl0jVH0We1ga8igYMmmukcI8ltkodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=VwgDDaMG; arc=none smtp.client-ip=178.209.48.109
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id B379F5C53A1;
	Tue,  7 Jul 2026 20:57:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1783450646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydta7jlti9j4LmIExsQGl//hnKkqR/izt7WQIkW8wSk=;
	b=VwgDDaMGjWsUqJunxOtrOFCt44wvbqum4Kq9eG2b5+LsgfyrmGES1P+nzQLAsMnLbDZVbi
	heOXAVXP0PMW0lVmjqKmCACcMKv6fJRCvlHJT4IAoaHFh+UYMRmVoCici37dfthuAyQpWB
	qiGsWVx+hibrDeatdSYGaoS4B163lJ4=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jul 2026 20:57:26 +0200
From: Stefan Agner <stefan@agner.ch>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Russell King
 (Oracle)" <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH net] net: stmmac: resume PHY before reopening the
 interface on MTU change
In-Reply-To: <ak01QZhCKkq2FM33@AMDC4622.eu.corp.samsungelectronics.net>
References: <20260707162146.73823-1-stefan@agner.ch>
 <CGME20260707172005eucas1p2fdf3255132201e4e2c6fcc835fd2e805@eucas1p2.samsung.com>
 <ak01QZhCKkq2FM33@AMDC4622.eu.corp.samsungelectronics.net>
Message-ID: <75d9132549fce2298f581318e2d2e80f@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[agner.ch,none];
	R_DKIM_ALLOW(-0.20)[agner.ch:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305572-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:ovidiu.panait.rb@renesas.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:regressions@lists.linux.dev,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[stefan@agner.ch,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,armlinux.org.uk,bootlin.com,renesas.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefan@agner.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[agner.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,agner.ch:from_mime,agner.ch:dkim,agner.ch:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D2D771EC93

On 2026-07-07 19:20, Jakub Raczynski wrote:
> On Tue, Jul 07, 2026 at 06:21:46PM +0200, Stefan Agner wrote:
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -5884,6 +5884,15 @@
>> 
>>  		__stmmac_release(dev);
>> 
>> +		/* phylink_stop() in __stmmac_release() suspends the PHY.
>> +		 * IEEE 802.3 allows PHYs to stop their receive clock while
>> +		 * powered down, but the DMA software reset performed by
>> +		 * stmmac_hw_setup() requires a running receive clock.
>> +		 * Resume the PHY, as on system resume, to ensure its clocks
>> +		 * are running before reopening the interface.
>> +		 */
>> +		phylink_prepare_resume(priv->phylink);
> 
> Does it work without warnings? Nothing in dmesg?

With this patch applied, this is the dmesg log on MTU change:
[   56.761175] rk_gmac-dwmac fe010000.ethernet end0: Register
MEM_TYPE_PAGE_POOL RxQ-0
[   56.762769] rk_gmac-dwmac fe010000.ethernet end0: Link is Down
[   56.801327] dwmac4: Master AXI performs any burst length
[   56.801368] rk_gmac-dwmac fe010000.ethernet end0: No Safety Features
support found
[   56.801409] rk_gmac-dwmac fe010000.ethernet end0: IEEE 1588-2008
Advanced Timestamp supported
[   56.801780] rk_gmac-dwmac fe010000.ethernet end0: registered PTP
clock
[   56.801804] rk_gmac-dwmac fe010000.ethernet end0: configuring for
phy/rgmii link mode
[   61.032985] rk_gmac-dwmac fe010000.ethernet end0: Link is Up -
1Gbps/Full - flow control off

> phylink_prepare_resume() does have ASSERT_RTNL() which is not called anywhere.

I am not very familiar with the codebase, but Fable states:

> RTNL is held here: ndo_change_mtu is invoked from netif_set_mtu_ext(),
> which calls netdev_ops_assert_locked() — for a driver without instance
> locking such as stmmac that is ASSERT_RTNL() — right before calling the
> driver op. 

What I can definitely confirm is that without this patch applied, a MTU
change does not succeed, with it applied MTU change works and the
network interface remains functional.

--
Stefan

