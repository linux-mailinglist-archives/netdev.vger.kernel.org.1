Return-Path: <netdev+bounces-287504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKzxCFhJBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE6530F10
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFC931463E9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372493F0761;
	Wed, 13 May 2026 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ORhkuwSu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5713EB7E4
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665423; cv=none; b=dviAllyMOra8KRVPOeepJcRqiCO4I47b3pve1d9fE/mTHFzlJmTz6vgMvXVB6uuEp/YVmAnGokpUPi0kEkGatBE/HIzy8LHVLex3A9nTSOYALQbPdI7+5OX0ayhAUgDO67c9UIQvFIOe+V+17dVqzu3lFJeqkBtMaCe6TdMuR2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665423; c=relaxed/simple;
	bh=viZXwdy5zdB3wBSfzB+Dud53THV6EDNQICF5hmV/Iik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeHjNT1CgAH+ywtN4Db47XM/Q+Et4qL+2Yqqnr4MrbTNpmo8DKB9RhPDThrXnfbvhwqKzbvFg/L7f71WbqixZ1aknxx+AI5lxo4PVKkMbnjyDMeG3dFObKNbvH17i6oS7tlaHuu6+875JXSQ4CkCMzttaTydU9jia4dw+OxiqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ORhkuwSu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9FE391A359B;
	Wed, 13 May 2026 09:43:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D1B8606CE;
	Wed, 13 May 2026 09:43:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9920F11AF8998;
	Wed, 13 May 2026 11:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778665414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=K9d4EM9iJwvUfsuSVeCdeyxgSWZHO0grg4+wXYq5uJ8=;
	b=ORhkuwSuIvEXIu8TOeh++BnE3vZJMg42hvYgL3VzcQuK0qtP0wT2DhxLK0cNl0Scbm6X3s
	r1Hu9kx9yvBRfono0WqqemQgzYYMTqyz7NeZR8QCe7asrshpawRSU9d+ItL/4G8C4UvPFy
	NUVrjlkRlX4nJPzawigXteKI8tDFRudu1ejHjnrYPWd8UL3VXZ8q22ONqp4vnbKrQxy00E
	S7eWNepfPo6GxzdPMXuMIsV+S8lbN72MIJANFJzWnAF5s+1I6HifJK+YHwDMhIUwQIbi0g
	aHsmL/J00mIkPzw9GONgJ5TRnl9NIOoI25+WA4nPnjy2/AdeLMQSgD0epqzrfA==
Message-ID: <f3280b6f-7cf1-410b-9711-6dfaae2596f2@bootlin.com>
Date: Wed, 13 May 2026 11:43:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ARM: dts: ti: var-som-om44: Add USB Ethernet
 controller node
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
References: <20260506-b4-var-som-om44-lan7500-v2-0-b8af59ab877c@bootlin.com>
 <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20260506-b4-var-som-om44-lan7500-v2-2-b8af59ab877c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 61AE6530F10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.richard@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hello Kevin,

On 5/6/26 2:13 PM, Thomas Richard wrote:
> Add USB tree description, including the Gigabit Ethernet controller
> (LAN7500). Adding the LAN7500 node will allow the bootloader to patch the
> devicetree and set the MAC address.
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
Could you merge this patch? Or maybe you have some comments to do.
Jakub already picked the binding part.

Best Regards,
Thomas

