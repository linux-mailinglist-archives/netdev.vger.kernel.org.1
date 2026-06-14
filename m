Return-Path: <netdev+bounces-299118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sto0AL0GLmp2ogQAu9opvQ
	(envelope-from <netdev+bounces-299118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2566802F6
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:41:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=aA0axU2h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299118-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299118-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21AC2300B75A
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96B27A10F;
	Sun, 14 Jun 2026 01:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7E7263B;
	Sun, 14 Jun 2026 01:41:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401271; cv=none; b=H4jRE0puvV/fsVH3F/BgPJGbH+pISfLa9ytINV5VL/Uak8iBzvBZGTbGSax9R2cFt3uVVNDXvvYtXMLT9DG6toulAMJ9wHaxuC6VtNrbM4LblRZjYl4J3PZUyIaOQeU+k2OelSQBHMlhDT5iy72j7eox4P/3ETJfsphvtSDXzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401271; c=relaxed/simple;
	bh=JbZdSQrPsoMtCoCsQlptOjGGwGXcWES02t3ZM4IaYqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WN30PHUTHIn1a5sLy+6yEFwM609MtpkRnU6Sdo80qH9ctFfDRo7yQKUlIT8fxabu5GGnOAwkqc8U7Eu2rBjlFRUyA/fCwz6/Kp3jWKHmP2BA+D1ad0MfI4PLeTUv4npScTgd5I9C0avg1cuZrt1OqTsDy/XkWKD7GarivfsLGKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA0axU2h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9749D1F000E9;
	Sun, 14 Jun 2026 01:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401270;
	bh=H2kWOLsf3qvRadBE6Tkjq3oEXqykXbMUDicFB5vUenA=;
	h=From:To:Cc:Subject:Date;
	b=aA0axU2hVYwip/24PcDgxNB4zkkKDLjFpi3oqBAVMNDaoAyAr7CkCLj1ALyhA0IXV
	 Er4wWr2AOOt4cIVmYRzM0oqy/q9lIYElntDWfCuPPEZxXhqemZyYiXf08ZloeEyKm8
	 QT9fSjIK83svkl/gTFvq7nJ8+fXmbf9tRGFmU8UqBkkoGSNrbiwRJOyL4BXoAp5p/S
	 TAZ8ZMnBBSmvbWRqtv+XiQfaMu5SN4IDRB2Uh5uh2y8APd+QrH7SSlcZdjMFM8AfSG
	 IE7MCr0HpzwA1ecIOyijMraIfuAj+eAXvkpKR9ClAxonpTXc7TVnmQE0hxfpaMbi6Q
	 mmIvPf+l7Gcyg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] tls: reject the combination of TLS and sockmap
Date: Sat, 13 Jun 2026 18:40:55 -0700
Message-ID: <20260614014102.461064-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,cloudflare.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-299118-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A2566802F6

There are no known TLS+sockmap users and it has some known
hard to solve bugs. Let's reject this configuration as we
discussed a number of times.

Jakub Kicinski (5):
  tls: reject the combination of TLS and sockmap
  tls: remove dead sockmap (psock) handling from the SW path
  selftests/bpf: remove sockmap + ktls tests
  selftests/bpf: drop the unused kTLS program from test_sockmap
  selftests/bpf: test that TLS crypto is rejected on a sockmap socket

 include/linux/skmsg.h                         |   9 -
 .../selftests/bpf/progs/test_sockmap_kern.h   |  56 ---
 net/core/skmsg.c                              |  52 +--
 net/tls/tls_main.c                            |  19 +-
 net/tls/tls_sw.c                              | 399 ++---------------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 420 +++---------------
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  61 ---
 tools/testing/selftests/bpf/test_sockmap.c    | 250 +----------
 8 files changed, 119 insertions(+), 1147 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c

-- 
2.54.0


