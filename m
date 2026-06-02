Return-Path: <netdev+bounces-294144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA8VN/y0HmrZJgAAu9opvQ
	(envelope-from <netdev+bounces-294144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:48:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7598162CEC4
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211B530777D0
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6933D5C3C;
	Tue,  2 Jun 2026 10:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uu56T2d5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7781737FF4E;
	Tue,  2 Jun 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396523; cv=none; b=DfNsw30zNmV78bSEBmwNQRNT7pfFyn6D9AJhBL0o8PC/1ndl6l+Ys/2FkALZXRSe/9sagYsIz4ON+2Ahxg9+ut7J1kUn2+/nfdC1w/p/OTA8fA7iXJtJxeq7IXJK5yJjN3S7ptN7XJP00hAKZUGXubXJ0tB691haiwU4TgEcDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396523; c=relaxed/simple;
	bh=7fs/Ea2xnzRuG59u8rGS1g7Z3TJFNLOo7lJohh/sZWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPxKvwhbk9fgJhqyZJG1eTSB2yCZWW3xzP8IwNry8aMtHaoZqG2/bcjArdCIZA3L3LM3BzDuHuZROnchfIo8zMk0X/L5LUVqcj04aw8OgQuWWjMVknefKQtd1BXkm/PP5Ax2Pioj2Ww3oSJjjlXrHhjr6NEVLMkgUCoxnBzfIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uu56T2d5; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 38CC2C6247F;
	Tue,  2 Jun 2026 10:35:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3F45603BC;
	Tue,  2 Jun 2026 10:35:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 206C11088838A;
	Tue,  2 Jun 2026 12:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780396518; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7fs/Ea2xnzRuG59u8rGS1g7Z3TJFNLOo7lJohh/sZWI=;
	b=uu56T2d5YgNJVXUPff3eP585cqUQLhOxT2qCEPxRjavLP7bnKePVomqANOhLXHIhL1U3sY
	Ho+JgdHH8q8YJo421XNOeygddbsv+uD3e3k7n6kDOlO+VEzVNJn5P5luXwUymxETNnB4C8
	TeRiFEDs2HM1rDYvobbwNHjJn6iujBf05zfw2ILIfbx34etJA2ITdRL8qHMJsFx++yj4i0
	+lBfI9G0nzZRPyAHolNhVVyT+Uw2pjV2hQR16rmPviXm9ltIIWMU62wI1jzUBiA/9PTNx1
	MvbZunzeY6p6vQMdq/AIOpyQ6HcIDQM+/iLhJxpVS6f1HlXcInvbdfYTYpzdCw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Robertus Diawan Chris <robertusdchris@gmail.com>
Cc: alex.aring@gmail.com,  stefan@datenfreihafen.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  horms@kernel.org,  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org,
  skhan@linuxfoundation.org,  me@brighamcampbell.com
Subject: Re: [PATCH] mac802154: Prevent overwrite return code in
 mac802154_perform_association()
In-Reply-To: <20260602054133.470293-1-robertusdchris@gmail.com> (Robertus
	Diawan Chris's message of "Tue, 2 Jun 2026 12:41:33 +0700")
References: <20260602054133.470293-1-robertusdchris@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 02 Jun 2026 12:35:12 +0200
Message-ID: <87ik81mdr3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7598162CEC4
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294144-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linuxfoundation.org,linuxfoundation.org,brighamcampbell.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Action: no action

Hello,

On 02/06/2026 at 12:41:33 +07, Robertus Diawan Chris <robertusdchris@gmail.=
com> wrote:

> When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
> return value assigned to either "-ERANGE" or "-EPERM" but this return
> value will be overwritten to 0 after exiting the conditional scope.
> So, jump to clear_assoc label to preserve the return value when
> assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.
>
> This is reported by Coverity Scan as "Unused value".
>
> Fixes: fefd19807fe9 ("mac802154: Handle associating")
> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>

This is correct.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

