Return-Path: <netdev+bounces-267179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIRhL8MFs2njRgAAu9opvQ
	(envelope-from <netdev+bounces-267179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:28:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3380E27724F
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 19:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B641304AC18
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339AC3A381C;
	Thu, 12 Mar 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HicsbnDp"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E438C423
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773340096; cv=none; b=VIIa1exIESW96O74hy/MkM/JYGnYTHYATsFVNrU1SgsL89Sh2j9hpdWwm459/Tm+QymB5SV8ErL2+m++/ungIs80TXvpV9dHZN8UIC2A+H+uh3QdK0Fr+R6VoMbwuXONMPD1zkFFRFR/gpNULCeikviiPmR+ezYiXWUzxpAW3lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773340096; c=relaxed/simple;
	bh=RCae1paGq9M0BmVz+wvTtgoP5qBKQHJfsSvMgH6WdbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZrgdOyxESJGNTQUzQuQ2EfSElt4Hl1UTObn/NZ6DGl7cn3ni1aMyw0xK0crwV71NBB77+IsyV+T+c3cyY/5CaSNNLvQKX9qeD1L03CWXRekeHMXnAafPnIxB927+1QnbAJxVRFQsp8aAPVqHBExEH9xcGbkEy/Iz/B+7Zb44G/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HicsbnDp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 26FDC1A2E12;
	Thu, 12 Mar 2026 18:28:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E51DC6001B;
	Thu, 12 Mar 2026 18:28:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 784B410369547;
	Thu, 12 Mar 2026 19:28:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773340090; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=gujxDKyu6aCh39EK6Isul8rgjIK7nOMe42cmvXCePbc=;
	b=HicsbnDpp2NOFY0Vn3BjvAM9IvTWqwp+PF+sDkisrCwd09KHCy8Ri0e3EgNO+PvLYy+Yyi
	e3zPRXPmzF3EdQL+8J0P0H1trK046dg8QpidnDmWz0OXNEuZPm47OA2XLmXzdTUdjtUmZW
	rxbvDNg5QKDSPujvzeSNLpLrWVFiblywtnciP0Q0WBeaam/RYsD191Xm2daUk6KNNqy1Id
	GS77Oh3ifJGgCNC0tHOdEd+1e+VYPRlYMK8cEQ1u3/oiDpss5D9teGHl5rwVCM9IIUPAfD
	nQvkhB1reYk/gVNLBIlAbKIL6z64pXwnRaXCrL3COBE6gT7l7JuFJikZS/tLVA==
Message-ID: <cd3acaab-5b77-461e-bbcf-de475ee29280@bootlin.com>
Date: Thu, 12 Mar 2026 19:28:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 Tristram.Ha@microchip.com
References: <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
 <20260311212404.xsx55lh3gnuze253@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260311212404.xsx55lh3gnuze253@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267179-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3380E27724F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 10:24 PM, Vladimir Oltean wrote:
> On Wed, Mar 11, 2026 at 05:58:32PM +0100, Bastien Curutchet wrote:
>> In the end, it feels OK to me to migrate KSZ8463 into ksz8863.c but it's
>> hard to know for sure before actually doing it.
> 
> Sorry, what ksz8863.c? I may be misunderstanding something.

I meant ksz8995.c sorry

