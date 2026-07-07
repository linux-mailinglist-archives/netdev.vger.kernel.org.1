Return-Path: <netdev+bounces-305577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rHFfG2ZPTWqPyAEAu9opvQ
	(envelope-from <netdev+bounces-305577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:11:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A913671F005
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 21:11:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=agner.ch header.s=dkim header.b=YImG43wp;
	dmarc=pass (policy=none) header.from=agner.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305577-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305577-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81C74300F798
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 19:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A313E8332;
	Tue,  7 Jul 2026 19:10:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4673A8747
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451450; cv=none; b=R+n5peKbVVPS2X29jQJ3ryhJq7IptYczxCNNH/j4T3u+TsWUkNnIXJdZ1k8KOeVoUtuxMP9bMYfqBbsMsThy09ht3iQXeo/xU1iDymSLBcghhDTbT0RvUcdZkjSd/MyPq+ltpOx8gKhwJghZdWga12VCcZbcc5b9MQD6O4TV/NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451450; c=relaxed/simple;
	bh=FoV3ouqOwPig5EjoPsk4ZNqHCDCi2jiG3waYcczWHbI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=pxXB/QXDxKH/fAgqwdPrUBCFTtLcEadyhStvQ65FOpox7ZWAK60iaaSHbr5QKt6f1nj74DyH9RG6kDreHr5bMmF5KvO/5U8TPPvo9gPLTJhgO0I0BuM6FcbeTB+R1/m3TiBFau0fXzrC0/JTvvaMSbREdzbm96fDkWUvCeesJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=YImG43wp; arc=none smtp.client-ip=178.209.48.109
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id BD6405C53A1;
	Tue,  7 Jul 2026 21:10:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1783451446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHdhmWw8bTLtB+4kBs5YmjWw0Q5vkcur8qe9Menb+4Y=;
	b=YImG43wpWUITLr/OqWZqVeD0BxZ2LBxvqtZmsG2DdkJaZjaMFYFxOahbnLGZK4vqI0OFpt
	O1OW00LRxTMyo+WcuEIlcf+uteIvi6l2gnCqcdx3pUVrlS4MI5n1typ7DGgKYO0NLziA/V
	eB/QJLcSHzScGvpvrvemDA6L7E1NIEc=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 07 Jul 2026 21:10:46 +0200
From: Stefan Agner <stefan@agner.ch>
To: Andrew Lunn <andrew@lunn.ch>
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
In-Reply-To: <a6515f8c-1358-4e2a-a485-2a25a7dc6313@lunn.ch>
References: <20260707162146.73823-1-stefan@agner.ch>
 <a6515f8c-1358-4e2a-a485-2a25a7dc6313@lunn.ch>
Message-ID: <9c8cdec3250eb3226d4f64ca8397cfa8@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[agner.ch,none];
	R_DKIM_ALLOW(-0.20)[agner.ch:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305577-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:ovidiu.panait.rb@renesas.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:regressions@lists.linux.dev,m:rmk@armlinux.org.uk,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[agner.ch:from_mime,agner.ch:email,agner.ch:mid,agner.ch:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A913671F005

On 2026-07-07 20:50, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 06:21:46PM +0200, Stefan Agner wrote:
>> Since the referenced commit, changing the MTU on a running interface no
>> longer disconnects and reconnects the PHY; __stmmac_release() merely
>> stops phylink, which also suspends the PHY (BMCR power-down) when WoL
>> is not enabled. __stmmac_open() then performs the DMA software reset in
>> stmmac_hw_setup() before phylink_start() resumes the PHY again.
>> 
>> IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
>> powered down, and stmmac requires a running receive clock for the DMA
>> software reset to complete (the phylink config sets mac_requires_rxc).
>> On such setups, e.g. the RK3566-based Home Assistant Green with an
>> RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
>> leaves the interface dead:
>> 
>>   rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
>>   rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
>>   rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
>>   rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change
>> 
>> In the field this is triggered by NetworkManager applying an MTU while
>> activating the connection, breaking networking entirely.
>> 
>> Resume the PHY before reopening the interface, like stmmac_resume()
>> does, to ensure the receive clock is running for the DMA software
>> reset.
>> 
>> Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
>> Link: https://github.com/home-assistant/operating-system/issues/4858
>> Assisted-by: Claude:claude-fable-5
>> Tested-by: Stefan Agner <stefan@agner.ch>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>> Note: phylink_prepare_resume()'s kernel-doc says it is to be called
>> prior to phylink_resume(); here it is paired with phylink_start()
>> (called from __stmmac_open()) instead, which phylink_resume() itself
>> uses to restart the machinery. If preferred, I can extend the
>> kernel-doc or introduce a more generically named helper.
>> 
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>> 
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
>> +
>>  		ret = __stmmac_open(dev, dma_conf);
>>  		if (ret) {
>>  			free_dma_desc_resources(priv, dma_conf);
> 
> I'm not convinced.
> 
> __stmmac_open() and __stmmac_release() should be opposites of each
> other. If __stmmac_release() stops the clock, __stmmac_open() should
> start the clock.

Hm, I see. __stmmac_release() calls phylink_stop(). But from what I can
tell we can't simply move phylink_start() in __stmmac_open() since it
does too much. So we need to use phylink_prepare_resume() in
__stmmac_open(), so there is still some asymmetry. I'll send a v2.

--
Stefan

