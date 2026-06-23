Return-Path: <netdev+bounces-301365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QzORLf6AOmrk+QcAu9opvQ
	(envelope-from <netdev+bounces-301365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:50:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6D06B732E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codethink.co.uk header.s=imap5-20230908 header.b=bKfYRKzj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301365-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301365-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=codethink.co.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A38D23015C9B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4995B1A3160;
	Tue, 23 Jun 2026 12:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27A370836;
	Tue, 23 Jun 2026 12:49:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782219001; cv=none; b=eHzfRCexl8OclPwMmaOtd9Xzk9bKTWgdSjDYBTyhUmPeAp5FTqtN9AnD+qwFTY3eclf0e4hNSxPDcnBi047khEicRt2ddOGb17Qmx4nOxMvCnbrCWIHgakM4KYzKyq+C7sSFIAQiPE4Dbs/2YdomEEh5HHR0+wdRCmPFwSibiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782219001; c=relaxed/simple;
	bh=4eJvxUFSnF+t+nCfUF/DRuBZ5U1aFM/SVBOL62oDVMY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKKw5b0drJZOlGHEHs0HF23MBakkkygOKuxjPN06yYrK8btJ5SfRk1b88mLr+3X+oBMwwbuVwQOGcDIRTsk+Gxpn0nLeG+qQ9Lm3FDs4xw4ML5L9g0RgDy2XtGDNz7FDOW4EzUZUrXtNKTNo3xB8g3z6lsaqnfkdmhdwpampLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=bKfYRKzj; arc=none smtp.client-ip=78.40.148.171
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=eph+6inJ7SuUxT31iR5t9WooZcKPpfJY4dEugCNlNcM=; b=bKfYRKzjh35D+n
	Iza5xoRQXM6ZQ2sOv05HM9hM23ki8qxPcSSU6xR84OLtX1OmFjCOreNBcoSiGEKHmReYfIzVvLb2m
	mHaWgnVPnbtGIiUtJOrWYYOw86p+Mgw1+zm/NbUvwa0c16sW06VDyU6tW/Vlc2wJUx05meBoBRp2X
	ds0TEkfTP8glezxtGHFBVCpPbqXoD7QXJ/Q8UzYKbQq7yi108/Z/5PwbfelQd5Sw+n0db3F3mMvwp
	fuBpuaA4G4QI6p4tayA0OqPU9u3gKWquBQF3CVCW2GZCbgbPqIfimidcbwNgo26o2p/bOd2sxgpbM
	9aYWAc6Huc82USyVoxZg==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wc0ZR-007GQj-8B; Tue, 23 Jun 2026 13:49:41 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wc0ZQ-00000003Jpz-3v3p;
	Tue, 23 Jun 2026 13:49:40 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] af_unix: move proto info out of CONFIG_BPF_SYSCALL
Date: Tue, 23 Jun 2026 13:49:40 +0100
Message-Id: <20260623124940.791230-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[codethink.co.uk,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[codethink.co.uk:s=imap5-20230908];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301365-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ben.dooks@codethink.co.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.dooks@codethink.co.uk,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ben.dooks@codethink.co.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[codethink.co.uk:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,codethink.co.uk:dkim,codethink.co.uk:email,codethink.co.uk:mid,codethink.co.uk:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA6D06B732E

These two structs are defined even if CONFIG_BPF_SYSCALL but
the header does not export them, so declare them anyway and
move the check for CONFIG_BPF_SYSCALL lower into the file.

This removes the two sparse warnings:
net/unix/af_unix.c:1060:14: warning: symbol 'unix_dgram_proto' was not declared. Should it be static?
net/unix/af_unix.c:1071:14: warning: symbol 'unix_stream_proto' was not declared. Should it be static?

This change is less complicated than trying to make those two
structs static based on the CONFIG_BPF_SYSCALL configuration.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 net/unix/af_unix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
index 8119dbeef3a3..2a6a26b3a2db 100644
--- a/net/unix/af_unix.h
+++ b/net/unix/af_unix.h
@@ -55,10 +55,10 @@ static inline void unix_sysctl_unregister(struct net *net)
 int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size, int flags);
 int __unix_stream_recvmsg(struct sock *sk, struct msghdr *msg, size_t size, int flags);
 
-#ifdef CONFIG_BPF_SYSCALL
 extern struct proto unix_dgram_proto;
 extern struct proto unix_stream_proto;
 
+#ifdef CONFIG_BPF_SYSCALL
 int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
 void __init unix_bpf_build_proto(void);
-- 
2.37.2.352.g3c44437643


