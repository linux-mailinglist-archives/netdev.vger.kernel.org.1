Return-Path: <netdev+bounces-251544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kw4CKPUb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B92D64A25A
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 20:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 57AF53EBAF1
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9319344E047;
	Tue, 20 Jan 2026 16:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ARr7Z2gc"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD444A722
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926364; cv=none; b=HweWesWwQlqVYSijxgYqVeAXzE4Ot/Y7HeghDpfgoULJF5tCGluII5Nkt8oVO8zw7PTqE1+FS8Xalhd/A9JKQcdW9l3NHeizjoooFTe+c2FBPGIwtqzwzl3YWpy+pqbfFlVqzrykh7kl1N1RsfPIvwldoVOl9L9BREkUhL9BmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926364; c=relaxed/simple;
	bh=Rngc678hNJTr25sQmCLjzdFBZY/QVlfT9rMJmXRGFns=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=IgC/LhPwl+Wn4FW/9aoTh4m9n875cEMDGy1v+twQNF3pxy52sUCJoDlJkH5DontmraGRVbucWeSeW12fvPWWnp6YvJWJIoqpuFLfqRfA1/s/uHHQjj9qiwUVx3cgdn0nQE2Y5a197rafh+ZQVnDMZkyvARkWqBUX8BrxCMuhTeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ARr7Z2gc; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5d94:0:640:92d3:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 758BF80DB8
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:25:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id sPd9gfxGsW20-y6b8st0n;
	Tue, 20 Jan 2026 19:25:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1768926355; bh=Rngc678hNJTr25sQmCLjzdFBZY/QVlfT9rMJmXRGFns=;
	h=Date:To:From:Subject:Message-ID;
	b=ARr7Z2gc0VoHHs2vvAU9uh2q8/z2SJNrVD+CwhpKYmZTwUAAdJvcvffBxz63Z94r0
	 cqqfXnYsKoVScIiZctsfCCol5V1q+y3jauj+x0dmgGylSPUg/qH9YqD5qGv7cIQ5Hg
	 /bPWnf6u/tgGVeBtfJ9xiZlI/RPcNq6VbEUO1Prw=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <68ff91a70ff77f85c655b4de4d450b2172ef802a.camel@yandex.ru>
Subject: On managing socket's error queue
From: Dmitry Antipov <dmantipov@yandex.ru>
To: netdev@vger.kernel.org
Date: Tue, 20 Jan 2026 19:25:54 +0300
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[yandex.ru,none];
	DKIM_TRACE(0.00)[yandex.ru:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251544-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmantipov@yandex.ru,netdev@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: B92D64A25A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Is there a common design pattern to manage 'sk_error_queue' of 'struct sock=
'?
I've found that some socket destructors (say, 'iucv_sock_destruct()') do
'skb_queue_purge(&sk->sk_error_queue)' but (most of the?) others do not,
and it would be very helpful to know why it is so.

This question comes from https://syzkaller.appspot.com/bug?extid=3D7ff4013e=
abad1407b70a
where the trivial patch (hopefully) fixes a memory leak.

Dmitry

