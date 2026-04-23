Return-Path: <netdev+bounces-280792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL1+N19J6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E16F5454EB6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E7FD31322A2
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09923B9610;
	Thu, 23 Apr 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HAzfPSuC"
X-Original-To: netdev@vger.kernel.org
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF283B6BF7;
	Thu, 23 Apr 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960714; cv=none; b=VSwZtjoHqeU4GsvDrF//4+npTeqgYs4w98ez9aP7plxIEbRuBngSgwuZnKZDkz7Ya0C95o+xJYCiM/xKSeytrwlWhb5bKubjEaIMMp3q+fy2qpZVTDIu7DkcBh5JbBxlvkSHsS5fjJKt+Uv5bWcMpoGSDyORJsY3UK1bEsK9E8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960714; c=relaxed/simple;
	bh=PK6PUnCOy2lc1tim4ncLk3UjrNeFoUn1JFGnzmLa3lE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TryFbVYHrAmU4GeF6BvXjUe5A87f3ug+v8nP52Zbteaw4QdutAAgbeOziT9cp8Vb1qLHR2RVA9dMcfU9nBIznsFYtyMSPNbE4JXQA2NyItEALntKHiOG5Yomv2OkbyhbjrwOgivcdn3aaFFlj+nM8BeOGBy37sRQ5mD+yXwlxqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HAzfPSuC; arc=none smtp.client-ip=178.154.239.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:1791:0:640:6f9:0])
	by forward500b.mail.yandex.net (Yandex) with ESMTPS id 993D9C07DE;
	Thu, 23 Apr 2026 19:03:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net (smtp) with ESMTPSA id u3XnlH0SWqM0-0YutV12z;
	Thu, 23 Apr 2026 19:03:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1776960238; bh=YiIUy5NItGtSij5DW5uaHw7aLxvTZq/uCuSi8QxEm7Q=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=HAzfPSuCszd3LySe/vhp2y4OWw8krw7xWgAP850hAWS2oNPgjXmmCU6scY7SzjenB
	 jqpf3J6QxtkzbveGJja9TTewgieCQTciPvJh4NVkLR4yAzh+5UG7M4S3i83UhXsCaV
	 8+7KQEYRbWKDxeJPnDEtRjMYkA479O0LqmqNUUYc=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <65872064c2ab5fbf47a743f2dcd72182ea8296a7.camel@yandex.ru>
Subject: Re: [RFC PATCH] net: skb: on zero-copy formatted output to skb
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org
Date: Thu, 23 Apr 2026 19:03:56 +0300
In-Reply-To: <8ed4f473-9c7b-4f77-911c-85cfb2fba2a5@lunn.ch>
References: <20260423073638.778334-1-dmantipov@yandex.ru>
	 <8ed4f473-9c7b-4f77-911c-85cfb2fba2a5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_FROM(0.00)[bounces-280792-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E16F5454EB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 14:40 +0200, Andrew Lunn wrote:

>=20
> A quick look in drivers/bluetooth suggests that none of them care
> about truncation, at least they don't check the return code. Maybe it
> would be better to truncate than return an error?

Hm... I'm not a fan of (silent?) truncation and assume that user who wants =
to
detect it should be able to do so. If a (bluetooth) driver, or a subsystem,
or whatever else, doesn't care too much, it can wrap it with something like

#define bt_skb_printf(skb, fmt, ...)				\
({								\
	if (unlikely(skb_printf(skb, fmt, __VA_ARGS__) < 0)	\
		bt_warn("output to skb@%p truncated\n", skb));	\
})

> I would also try to make the behaviour consistent with the normal
> sprintf(), or snprintf(). You want to give users some idea what it is
> doing based on its name. It is well known that snprintf() will
> truncate, and does not return an error code. sprintf() will just
> overwrite the end of the buffer and not return an error code etc.
>=20
> However calling this skb_snprintf() would be odd, since you don't
> actually pass size. But it hints at what it does.
>=20
> So please add some kerneldoc describing what it actually does.

OK, some more neutral name like 'skb_fmt(...)' may be better indeed.

> Please also annotate the const char *fmt, so the compiler can do
> format string checks, parameter counting etc.

Surely '__printf(2, 3)' should be used here.

Dmitry

