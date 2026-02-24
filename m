Return-Path: <netdev+bounces-260300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KagLN4DnWk7MgQAu9opvQ
	(envelope-from <netdev+bounces-260300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:50:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6851180BCF
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E86EC301E497
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E33C2459CF;
	Tue, 24 Feb 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lEZPnijE"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA28E246BCD;
	Tue, 24 Feb 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897813; cv=none; b=TAH0MlxR2Ghu+Ti4L0FnIXRc6Kc1TmVdEHySzqa/9pswZpPJIwR7tsUBT7RrAtsDx/aBB5OyrSFt3dX7nim2iEMoneYcm1TsSEvO0qbFrKGhIDySrya1YYPVrQApg4kD2Rl2L9An9b2ywF1V482mnvx9fhlKuVYCwmzCdgXJhlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897813; c=relaxed/simple;
	bh=zoIJ06j2IyMjGiefEEfIAsSf8FRKgtStHVyxMgSr9s4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U79cHc7FnZJ+eGP3JoLrb8pTm4f68JJfCCryYbKokkSbeytKrZFPllvwWl88KBr5tqmWu+EpSdndKAxZ0NFcefw9VkQ7svUAZAiikTM3SA7VCojoKgjyZ3qmn6iAYNJ9t4J4uM+SkOFsdf+NwOr0xcyOoowu/j9V0M2J4v/x+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lEZPnijE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1771897809;
	bh=zoIJ06j2IyMjGiefEEfIAsSf8FRKgtStHVyxMgSr9s4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lEZPnijEN7XrS8G5WZTOeNEvD+FdhKYw95bvB5hO74NOZuFtMErKEUjGqFdOJjVR6
	 ZA0TW1EeJFqLG9Ljic2m+nFfjMPkhNhJxh0O/ElBQiUCJ3FGe1XOI8svkCdf2bfYrT
	 7ReVvrHc5TgjHe4IUindHQqZDYcpsxdTKY/lS7hOZ7C/HjTZ0Mar6DiphOmjB8JlgG
	 cC38QP1ZuWh0TFeLWyjhqPac3PbypkGQ4Rg++cDT+CwY6sU5doMkVKQH8rMBgOAusR
	 rpTKpeO3dMbRONJ62I8oZ+jubEBwUfXackhS/nyTwsk++AABQ3QYC22FYyFpghPEmC
	 A4gu0K1OSq5Ow==
Received: from [192.168.72.171] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9B5FD6015A;
	Tue, 24 Feb 2026 09:50:09 +0800 (AWST)
Message-ID: <0fc4daf8261ea1b163c81c5618aba74f248bc3a9.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp: usb: properly drop the usb interface on
 probe error
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>,
  stable <stable@kernel.org>
Date: Tue, 24 Feb 2026 09:50:09 +0800
In-Reply-To: <2026022319-turbofan-darkened-206d@gregkh>
References: <2026022319-turbofan-darkened-206d@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260300-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,codeconstruct.com.au:mid,codeconstruct.com.au:dkim]
X-Rspamd-Queue-Id: D6851180BCF
X-Rspamd-Action: no action

Hi Greg,

On a second look:

> diff --git a/drivers/net/mctp/mctp-usb.c b/drivers/net/mctp/mctp-usb.c
> index ef860cfc629f..eef17ae89298 100644
> --- a/drivers/net/mctp/mctp-usb.c
> +++ b/drivers/net/mctp/mctp-usb.c
> @@ -355,6 +355,7 @@ static int mctp_usb_probe(struct usb_interface *intf,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_free_urb(dev->tx_urb)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_free_urb(dev->rx_urb)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0free_netdev(netdev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_put_dev(dev->usbdev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> =C2=A0}

Should we not do the usb_put_dev() before the free_netdev()?

Given we're in NETREG_UNINITIALIZED state, we're likely to be
immediately freeing netdev there, which includes the netdev_priv data,
ie., dev.

Cheers,


Jeremy

