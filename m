Return-Path: <netdev+bounces-304414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CtBWCrlnR2o6XwAAu9opvQ
	(envelope-from <netdev+bounces-304414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:41:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 195146FFA7F
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:41:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=gla0Vxx6;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304414-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304414-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AFCF300B507
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE72336A02E;
	Fri,  3 Jul 2026 07:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995235E94E;
	Fri,  3 Jul 2026 07:40:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064447; cv=none; b=AM1Xtl3rGaUIXcw0xX2ePyJOprZq+icj0/grQds0BYrghByfmaVu7W7J6jUr9LiU6+UDmUD6pSsSB0XdE7VbWSJPqxqMkj6AuHueP8TzUe2MrIW94cJHS82gXZqQxQz6Y5Xtq24I9Z1pewx8h1bT4fkrKdXWc0rzKnSpi/bwf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064447; c=relaxed/simple;
	bh=UkC/9lWTfRnMfDc3hEZ4ZQ6TREe4LSl4Nhy4369fS4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M+KzvNKuLayIdf2EhWb3wKen0xj2fEDljh8MHMITLYTuLaSG0ScU0Rom8bpQUOzw+C90exufPp8ZWwmVwtVm6SIzIq4Og4IuYUaS8ylDY5YqHfW9QOYQdr/AIAkqAbP7k9wn1FBAE2gjgmCiF78YjqQZXaypGtoI/POSLZk5uN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gla0Vxx6; arc=none smtp.client-ip=103.168.172.139
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id F15FC1380251;
	Fri,  3 Jul 2026 03:40:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 03:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783064444; x=1783071644; bh=JF19NxgcsBPWmdgtIv6gRC0D00KP/jPDp2z
	ZMrh6occ=; b=gla0Vxx6iOPv/O36Q/Us6WLrK7S/bGvjq85/giQOMStKp3e/lNV
	JXDqeqwQ/uL0jSlqrrv7dbT1M+T6dgDx1mSy31TJ4Kjvn86F2HP3wlY08HhS7Hno
	Uu+2O0B6uXD64vXu8j3d7yZNu6LR+so8VNac0r4PPjMnJ/Ar+25JY+PvOW2sUOUW
	/b239hlvtVMyv55+uoaMNy5O1z685OqyqSQwShiXChq41vBfrPAkQVsEeT1hUSzm
	4IR/uahtZBUa2yXCHOcfd8moYOqsPusTuG3/3LrlMSIS4MotW8AmH+6ITGWN2POK
	sTq2mgFxCKBggNr1Be9doXGY3IbtIiaKwoQ==
X-ME-Sender: <xms:fGdHanMgEqYfwtW0H2zDcLnWh4rTjltpSDg4MyPwctwClb55UTR10g>
    <xme:fGdHao6AxrfJUJyzvSLrc3emuZ7HRfBbQCqIsBEeC8qBF1itqNky2xUnYdH2s0rzW
    iYoxu3Qd7342Q3FMaYWr4gf74LJhpr6NViNRU2WPcVoIzss2je1-BA>
X-ME-Received: <xmr:fGdHarWi2-8yYbXYAlVlT115vGKMgGI5RlCxL9lrhn0WDq1JYGGiZUK0d4Hqagi0ZOtQiAHyGEcJlIUae9qU78kA6pa5NBjKKSO1UA>
X-ME-Proxy-Cause: dmFkZTFLhFZTXepdBI8JArDFM9cwh0brlSnYnyTwMTy4WTL9VHKS2KqJ4/OOCNxsY3PyEx
    pF7i4hARtfyCeqKwr/+XN//7HA14+tN/VZ1zp2FiGTNXwg3dJKqBvk52IAYe7+smVprVpH
    SVDEu6XduEfYHNA/QQaU91XEK6O5UBJqbf0NEFSr5E+fs9xPwiQLUC04NyqQAFgN4E87QP
    YZ7nRyql+Yoxp4qJSlH0+GqsC5JYMxAwxQkaKyZUenctlaJnEOp0wer6OlSeCeuf7tH3jT
    W0LTAQxQRcb1mNYS309ntLQKOta8//ALcfjwgQRCWxGhnBapNYmmzJGzHxNLi8dv8WqkkA
    dSNMI5r8uTc/ySMnND0vhmyEVGknMczHgAPkAp7LkWQ9ZlcSZ0kVV4wL4xRUAPSPnaaP59
    6ytmj7IxlikiEG9U8cL/XeAnshzXv+edQbYBxT17DoVsMCXSCfhodKfKxPHnR4QQ6X2Xf2
    16ZLcwRGXSkZhXWTXkPYdavQMMvmTUWgnmlgJdqBSVZ++Ky2VEkC4l6iKdbfmv2mU/PTcj
    BoLEOBDg+rdxNk63GgilXsv2nJ1Pnn5DB8UPUQAXZ4WkOWu6xHAxNQMflW2o7F4BcPffaE
    4FYLxw4Y2ToA2I414RjMLjDhaDlP+cCE7+2etAnZ45M1RkTUvESNWHy1uxXA
X-ME-Proxy: <xmx:fGdHai0dRY4UEVXwrIICxkB_YTzdr3CaRls9u9QR5_V2wkE9Ui78Vw>
    <xmx:fGdHaqPOfrGBornD5BMNtiecyjfByKIE13VYwOpKmlXlkNbkRB0Nsw>
    <xmx:fGdHat1EutVp8yqt9s3TF4H_obzsbzF1RwIgr_0tB_zyFXhVCOug9Q>
    <xmx:fGdHap0oNq-uTfDnLGpwdbjUg2oHU4uZ11hzcpEtoJPbXqh5D4nzZw>
    <xmx:fGdHan8Mtk4IDdjPPRssDyGN_62niVjiNTqpLsTOw9dR93ZFLpx-lt7E>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 03:40:43 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: John Ericson <mail@JohnEricson.me>,
	Cong Wang <cwang@multikernel.io>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Andy Lutomirski <luto@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] coredump, net: fix layer violation with direct connection
Date: Fri,  3 Jul 2026 03:39:41 -0400
Message-ID: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-304414-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@JohnEricson.me,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[johnericson.me:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 195146FFA7F

From: John Ericson <mail@JohnEricson.me>

In https://lore.kernel.org/all/akWxrjOl4Up02Bvq@pop-os.localdomain/ Cong
Wang asked about doing things without new syscalls for my fd-based
connect idea. This got me investigating a few things, all of which I hope to
submit as patches.

This is the first one. I stumbled on `SOCK_COREDUMP` in `af_unix.c`, and
I realized that this was --- right in the part of the kernel I was
already looking at --- an excellent example of something that directly
connecting to a socket could do better. This is not because the
filesystem would never be involved (the interface in procfs still
specifies a path) but because the core dumper wants to resolve that path
differently than the usual way.

The first two commits are refactors that expose/create the necessary
functionality, and then the last commit actually does the untangling of
the unix socket implementation and the core dumper. See especially that
third commit message for details.

I hope this is a compelling use-case for you all, that does not touch
the UABI yet, but also does just the sort of thing that would be nice to
expose with a new syscall.

John

John Ericson (3):
  af_unix: factor out unix_lookup_bsd_path()
  af_unix: factor out kernel_unix_connect_direct()
  coredump, net: remove `SOCK_COREDUMP`

 fs/coredump.c                 |  47 +++--
 include/linux/lsm_hook_defs.h |   3 +-
 include/linux/net.h           |   1 -
 include/linux/security.h      |   4 +-
 include/net/af_unix.h         |   2 +
 net/unix/af_unix.c            | 335 +++++++++++++++++++++++++---------
 security/landlock/fs.c        |   7 +-
 security/security.c           |   5 +-
 8 files changed, 287 insertions(+), 117 deletions(-)

-- 
2.54.0


