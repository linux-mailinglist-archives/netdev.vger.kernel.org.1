Return-Path: <netdev+bounces-304245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m7fXA/WtRmrvbQsAu9opvQ
	(envelope-from <netdev+bounces-304245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:29:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A886FC0AD
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:29:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="uUye/Yfp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304245-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304245-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 685FB3010F47
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6227F349AF6;
	Thu,  2 Jul 2026 17:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FB35FF6C;
	Thu,  2 Jul 2026 17:35:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013742; cv=none; b=OiVkc9lntak+0zHLlsXdHdLca8IQ3YAxIrOi2M3VEtxmtRRYc7yUu2ayTfo7DNgmUn/9AqhugnjhiFNqdO09lQdUA3xp9OLNQXFhwoVO1kLWAix8WJ3046EH/NLTdrbVnAYY6V6MiUxOv3lY/en/DQS30DBCKLfRo1JgRyqYHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013742; c=relaxed/simple;
	bh=avGu4IKziAyDJgW08rAHM4Td2vBUWc8qt6JC9PD6t1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6yY1pyrGv1p4Jdc2AAsVKbwdYXQ9cfzbX549rYcggGz4n9h9bAe37+BiXM4AC2ZfpGy9ffY5BZwlEABH7rmnlUVGRZEOg0e6teh558Exn1upj7eD0sceAE5s36yJg/suyFEk2whb+1zceAZotmeFMHUtK3XP+5v3sJEST64cSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uUye/Yfp; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3BB9E4E409FA;
	Thu,  2 Jul 2026 17:35:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DF68B602EE;
	Thu,  2 Jul 2026 17:35:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 032F3104C9590;
	Thu,  2 Jul 2026 19:35:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783013737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DaEsGQyA9lchO5J2AFHDiPCEx3TudYnthel4tv0857M=;
	b=uUye/YfpNoN/FMZ4X1Cn5/O4LhI3ptQAjczCfgJX3Bgk4hJuMyoIOcI0vKjJFYSg4hta1o
	NueV4e13bB7rgP9zShZjzGVlRgHXl31jmbYmC490Y5gAkRP2hr+Te8eqPXQrEsPsv0LcOk
	i0wP3lPGzw8jKCoXv99iRmQKTa57dYfQwlxKM5hpRBGwWZe7z+AWr3aE1dxEsB+riUbAOi
	cjEd2M1+miyQmR7++DBBR/jO8ubnNEQVvFGttwGquZNFNlM3CtpTmuCodM/r1++YovdfRz
	kOSQB8asI5ks9XwqQ9/PmKCvMR7wB/YFw4S23LaDauAsQ0sfRIBYg8kIvdWnPw==
Message-ID: <11de0ecc-17af-4f64-884f-e1b146d80aaf@bootlin.com>
Date: Thu, 2 Jul 2026 19:35:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 08/14] net: enetc: remove invalid code from
 enetc4_pl_mac_link_up()
To: wei.fang@oss.nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
 <20260702025714.456233-9-wei.fang@oss.nxp.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260702025714.456233-9-wei.fang@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304245-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wei.fang@oss.nxp.com,m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:xiaoning.wang@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:wei.fang@nxp.com,m:chleroy@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-arm-kernel@lists.infradead.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nxp.com:email,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05A886FC0AD



On 7/2/26 04:57, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> When adding phylink MAC operations support to the NETC switch driver,
> Russell King pointed out several pieces of invalid logic in the
> .mac_link_up() implementation (see [1] and [2]):
> 
> 1) Half-duplex backpressure is not supported by the kernel, Ethernet
>    relies on packet dropping for congestion management.
> 
> 2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
>    not supported.
> 
> 3) TX and RX pause are disabled in half-duplex mode, so there is no
>    need to override them in .mac_link_up().
> 
> The same invalid logic is also present in enetc4_pl_mac_link_up(), so
> remove the invalid code from it.
> 
> Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
> Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

