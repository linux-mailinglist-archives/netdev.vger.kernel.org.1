Return-Path: <netdev+bounces-298486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +AsKNwO4K2qMCwQAu9opvQ
	(envelope-from <netdev+bounces-298486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:40:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC767754D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:40:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=brNAh9+t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298486-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298486-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA4CF301D335
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A383624D4;
	Fri, 12 Jun 2026 07:40:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB43D524C
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:40:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250037; cv=none; b=E8mpKxpK9CHsllsaX7O7MXfBX/gqu8t7RqBKyLFV91ydZKjDUGr16bn/qOQpE50YGT1gXgPQ7LVqwblbIYzgK+FU6lucOoGkuMOWsohdKil8+go84RU73krItD+jZmpjFo7mhZfZjCGjUdh6X4DYLH8BYxqfjCFmCsnnYFnwd98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250037; c=relaxed/simple;
	bh=aelshhmUSP5fJlCfVhIpUetRmNDtYzaCxKZxMDQFPX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p48RsNTFgoyP+VDgA7ZJv/nEPSnYBf0d8sdUyxSjSDpubwf1JH8XcBQ+mCi24PyzyPG49dcrT5lvxfe6T5xxbB+g/Q0L1fF2XnMg1Etph14Kz2c5B1mQV3EHsBw73Jvx+oOle7hsibnbMNPv61kk4lydJhBitsuP3Owmqb3dm6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=brNAh9+t; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A76944E42E40;
	Fri, 12 Jun 2026 07:40:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78CB960012;
	Fri, 12 Jun 2026 07:40:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07DD4106C8014;
	Fri, 12 Jun 2026 09:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781250031; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aelshhmUSP5fJlCfVhIpUetRmNDtYzaCxKZxMDQFPX4=;
	b=brNAh9+tk55k13XzQnSmC5mvHnlM6LSyahm1NK1EkKPvwXe6nT/+xzxSLosPvf8CtplnSY
	+EYXPe77kVTa/aCIfnpBqC89XczsOK4WUce6qHvBzLjcYBzcZQ/DnPVM0VvSHQvzfKRAF0
	CSmbzym46G3X+qtIu9Rite9RHv/qv5SbxFPwMa4cej1qkiMX1n9Qrzx/+hZBR+5vM9W0Fh
	Wbhf4kR1o4619aLastkx7ymuE72ziRSC85yKgTaQGIdvSmKYnY2kOKroP2L7r4rUDVFWZ0
	JPkA1l9JtBhQOROFH4L2dgXSJ34+za6jbtePrRb7/YYXpua9txBdmv2z4IYOaQ==
Date: Fri, 12 Jun 2026 09:40:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 gal@nvidia.com, jacob.e.keller@intel.com, sdf@fomichev.me
Subject: Re: [PATCH net-next] ethtool: tsconfig: always take rtnl_lock
Message-ID: <20260612094025.564cca68@kmaincent-XPS-13-7390>
In-Reply-To: <20260611200355.2020663-1-kuba@kernel.org>
References: <20260611200355.2020663-1-kuba@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298486-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:sdf@fomichev.me,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:url,bootlin.com:from_mime,kmaincent-XPS-13-7390:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48FC767754D

On Thu, 11 Jun 2026 13:03:55 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> mlx5 throws ASSERT_RTNL() warnings on timestamp config, because
> it tries to update features. mlx5e_hwtstamp_set() calls
> netdev_update_features().
>=20
> I missed this while grepping the drivers because tsconfig goes
> through ndo_hwtstamp_set/get, not ethtool ops, even tho the new
> uAPI is in ethtool Netlink. We could add a dedicated opt out bit
> for mlx5, but NDOs were not supposed to be part of the ethtool locking
> conversion in the first place.
>=20
> The mlx5 features update is related to the "compressed CQE" format
> which lacks timestamp, apparently. See commit c0194e2d0ef0 ("net/mlx5e:
> Disable rxhash when CQE compress is enabled").

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

