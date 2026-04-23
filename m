Return-Path: <netdev+bounces-280665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id v18aMBDb6WmNlwIAu9opvQ
	(envelope-from <netdev+bounces-280665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:40:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43344EA69
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 748E23003BCB
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD43630A5;
	Thu, 23 Apr 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b="sB1oYQCM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1911A23A6
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933641; cv=none; b=UMzAguqg1DV/STIH4KC2ETYoC6MVNsQplHOR2ap+TET9frPBzuMKr4iIEv7I+v+6OEv3xbEBkq2ySU7neyfyFP2UodskVeAFR+xpfnLe2FPF04rR0/m/8cSrza91LQ1FLv5YxzHiANlRyP7l2aR1hQuJ8gjMEaDeOnp8K5U2cJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933641; c=relaxed/simple;
	bh=F1zHL6A9kY1EbpiIa7b2qPRhPe4nM1+qtQYCVb08+rE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ca7zftmIbB/CPKZC91WdfYbN4UtjqH4SW52VkOGgPzMCZHx+H500RuYp5uCSaUlhAwVpvwbJk7K6Qo9+5ZbGDirTY5isXHYrq5DCb32JCRqt32EQBdEgvQFJL8mHBcdbXe2lvvi7kz01IUglwxKNCHnucXbhWpmW58ZHUqCxmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info; spf=pass smtp.mailfrom=leavitt.info; dkim=pass (2048-bit key) header.d=leavitt.info header.i=@leavitt.info header.b=sB1oYQCM; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leavitt.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leavitt.info
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leavitt.info;
	s=protonmail2; t=1776933635; x=1777192835;
	bh=fGdNDvIMSmYo0TLgMYF2iLQnDdqamGW0X3WpxsfTCX8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sB1oYQCMMXu6wuNLvpmD39sBl2vz1BdB6I3KZdOhZwKjTexfURZ5T8lxbIeYrUuwD
	 SGcEnfcu5ixY2asKLqOaZl+sNO2S1lukvdztADeWyVBP7wTKKJLa9H0XzMQ/1SJla7
	 KImcFECLFyMb2rhPzU4a+M8edWaJmvz8/+f14K1zi1x1/+YVTyVhddGv1tK3dB269F
	 iCUaC2tgAzqbpxawFbaMTLAu10o/a49nybCklsYud73A0QWwoHDRJxHAUCi+iTnYmO
	 gdPPjR67gpIqSjFF++C1ib6fXW4lTMcNlH93pbnHBUv9SldCM0kiaFYH4lRqhBqGzB
	 e16CN5EXEP4tg==
Date: Thu, 23 Apr 2026 08:40:30 +0000
To: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
From: Corey Leavitt <corey@leavitt.info>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Message-ID: <177693362253.84762.6848519898058872632@leavitt.info>
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-7d4856f686f6@leavitt.info>
Feedback-ID: 22087991:user:proton
X-Pm-Message-ID: 2857937825efa94d9a5fc03cd176f762008c1d6a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[leavitt.info,quarantine];
	R_DKIM_ALLOW(-0.20)[leavitt.info:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280665-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corey@leavitt.info,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[leavitt.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD43344EA69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Apologies for the noise -- this series was inadvertently sent twice. The
first send went out through an SMTP path that stripped the patatt
developer signature and re-encoded the bodies as quoted-printable.

Please disregard this thread and use the clean, signed copy as canonical:

  https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed75=
0a9d62@leavitt.info/T/

Any v2 will land as a reply to that thread. Sorry for the extra inbox
traffic.

Thanks,
Corey


