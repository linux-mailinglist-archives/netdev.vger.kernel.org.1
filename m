Return-Path: <netdev+bounces-258845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBizNxDhkmknzgEAu9opvQ
	(envelope-from <netdev+bounces-258845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:19:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A14141E98
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 10:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C435C3020D45
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 09:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409D2BE056;
	Mon, 16 Feb 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MTcBImxV"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D0280331
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771233470; cv=none; b=C2Gxv1B7zVMhkOmWUDFvRN+OaTPWYiUrdpQgsKQ0am0jhBjkNMTAal+aSjvJ2ZKWDFgr+3CWZfnfBt8Uu0LaugHm+D5eXX6uJ5qArFv8zyFEyeL2JEGZtuR28oo0kkj82S0mStA5SklEyLiiSGp0kPniRGOGHiJPQT4eJUb6X/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771233470; c=relaxed/simple;
	bh=DUj1q3S9plQ/ik7kavX5wCg3EzXWkwMftLCre1+2IxM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=Bwe/Km3uJfgNhMOljc3U/YsIOKGlbSIaa+C7IizyYd/Q+d8pXwkwTMc/LiYb/jbMCpc++QARgXvRx1J4KUgQFp6Cm3GbVeQP4IoCI2GNSc/SrN1Upb2XrDn52b8acVz8Z8JrTzEtQH2RFhT5JmZInyiNC8fdEorfa6yvW6Dvs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MTcBImxV; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F0EB9C17B7B;
	Mon, 16 Feb 2026 09:17:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E25B606CF;
	Mon, 16 Feb 2026 09:17:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B9081103690D9;
	Mon, 16 Feb 2026 10:17:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771233465; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l3TO8n/wRyQGCJy/aBsWiJ+MfIrq3l6NUOGJGd+lfvU=;
	b=MTcBImxVR80dswiYnsKAruysamVC5KsDeJG9hk1Vp/PH4El6aG6cH3RvP+rtDeS3kn1zui
	8JSm2JQ47SMnqqCoXOlm6t+6ulB9S2AsP+1pEdvJSybP0XPFTJzXEtFZoUwujfv7tWM1JM
	DWHWWVaGqEbKdgUY0QfKqzWPImPL/1j2e/UgiFdu4q/TJpkD6M+Qd8TL/5FN6dbZuFdSPx
	kHc9vtbJUYGouqMQb4TafJzX1ZDqtTF1iDTGhMOvSbc/TfxL5QTJ/4gZHkgPloGyQJEcHY
	onE7AHYXh03XL9tduCYkFXOo8fpLsb1HVYWWKfh3HrhBXy9rIur+PSljYpbCDw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 10:17:39 +0100
Message-Id: <DGG9UYCB17KB.4V0H8BECUV57@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, <netdev@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <DGDZR8L3E9WI.2MEYVL01KQ2YN@bootlin.com> <874inj72uv.fsf@redhat.com>
In-Reply-To: <874inj72uv.fsf@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258845-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:url,bootlin.com:email]
X-Rspamd-Queue-Id: 65A14141E98
X-Rspamd-Action: no action

On Sat Feb 14, 2026 at 4:37 PM CET, Paolo Valerio wrote:
> On 13 Feb 2026 at 05:57:17 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>=
 wrote:
>> My XSK series (based on top of yours) is ready.
>> I won't be sending it while net-next is closed, of course.
>
> Nice!
> Same for this series, will respin when net-next will reopen.
>
>> It starts with a few cleanup/rework patches that have no direct link to
>> XSK and touch code you add in this series. They could be appended to
>> your next revision or even squashed (with the right SoB &
>> Co-developed-by trailers) for most.
>>
>> Some contain bug fixes, mostly related to stats accounting. I expect
>> some amount of discussion as well, mostly regarding the page pool DMA
>> direction.
>
> I quickly looked at the patches.
>
> As we briefly discussed off-list, in my plans stats were considered as a
> follow up. I intentionally kept them out of the series and to keep it
> smaller.
> Given you added them, I guess it's perfectly fine if you include
> the patch directly in your series (unless maintainers prefer/suggest
> otherwise). The same should apply for macb_tx_complete() rework.
> That being said, IMO, we should account xdp stats separately instead of
> including them in the generic ones.

ACK so I keep those patches in my series.

  [PATCH 4/_] net: macb: account for stats in Rx XDP codepaths
  [PATCH 6/_] net: macb: rework macb_tx_complete() processing loop

If my diff related to statistics grows bigger, it'll deserve its own
series. Until then I'll keep it part of XSK.

> The one about DMA_BIDIRECTIONAL is already part of this review cycle
> (see bot's reply to 5/8) and already incorporated. I'm also considering
> the possibility a change that make this no longer relevant anyways, but
> I'm not sure as it was planned as a follow up.

Yes indeed, Jakub's LLM pointed it out. I looked into this for a bit and
couldn't find any good solution. In the end I couldn't find any
measurable performance improvement so no need to worry about it (on my
platform). I guess the only valid option is to reopen
if `running && (!!old_prog !=3D !!new_prog)`?

  [PATCH 3/_] net: macb: always use DMA_BIDIRECTIONAL on page pool buffers

> Regarding the patches containing simple renames, I don't think they
> require a Co-developed-by. The reasoning follows the same logic I
> applied to the patch you authored in my series; while I addressed a NULL
> dereference, it didn't seem significant enough to mark the entire patch
> as co-developed.
> The same goes for the style change patch, it doesn't change any logic,
> it's just a cosmetic change that normally go through the regular review
> process, but if you think it requires a separate patch, feel free to
> follow up on this in your series.

Yes for sure! Squash the remaining patches as if they were ordinary
review messages. It was simpler for me to send those as patches along
the other three.

  [PATCH 1/_] net: macb: rename release_buff() -> macb_tx_release_buff()
  [PATCH 2/_] net: macb: drop two labels in gem_rx()
  [PATCH 5/_] net: macb: improve Rx refill error message

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


