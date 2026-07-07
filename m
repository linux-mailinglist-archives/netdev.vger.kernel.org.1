Return-Path: <netdev+bounces-305303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6YBiGBWiTGp2nQEAu9opvQ
	(envelope-from <netdev+bounces-305303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:52:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3B771824A
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 08:52:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=R4GDgs8Z;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305303-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305303-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B92C305E3B5
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 06:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAB9388E55;
	Tue,  7 Jul 2026 06:48:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265BF3AB285
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 06:48:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406886; cv=none; b=YS8W8ScI51741qNiPjH+YcChmBkbq5woq/Q2C7r5nphZHQZdtc+OeHjmkam+n423UtS3y3tqsjZyfCT+AyfTvBad722KvpCsKUO3MT7xYopkuhPjhXgHKMACgJti/iG2sRR31RRPaHokZQWVWoJMhyG6S33nZ4u+Oz0wM92BjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406886; c=relaxed/simple;
	bh=BFtxn4X+mJFtlkHIVeC52mXm9VbFSXRnEgr35mm+F4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVifz/8iIheHUU9NrbirXwba8f7gaJ7SF4pHGSrQ2dKFILvUoDpM940BuMMsQ0udYF/kD5eckACVg7q4YYQql6f89DdjO/4TxpqAiBsuGcrm4zM/nmLiFS2OK3w/pLgYwi32jqwBb8xArXmx2210ae1Mjxjf+tZkb8JiW352h1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4GDgs8Z; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3725221a91.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783406884; x=1784011684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mV9b9qbeBEweBEXICaOG52qJ87vvXvQEsEcejPT+TSs=;
        b=R4GDgs8ZdTQhZTvgC3zLoGvn239hSGyuiq3Ex5kpf0d8+D+kQ+wnqlA0QNDaVGn21M
         nUzmkgLcrBRKanlw/z0LBqKUMbA48U76TtR70TRBmDZxMwSDHpTwOEwxi7tY5tocYhEP
         z2ApZn2uLtmWTlvmcCxKIE7hb0Pb55VoZwEI9HqUX7ljnCFuF/5x5WzbOF0icijRWGYO
         BLCA/AsTcKHp97xJ68vZSMtMfWpD3AQrMXExqxhGKUP2BSP4lrlg/Eu4zkpRLfmEdQzY
         NwXqVQfUIG+e2jmcp9IqN8iP84sQp81bsYMyU5dufdkRBOLTfvi/1EdKGxyWQ14V30gE
         ZVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406884; x=1784011684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV9b9qbeBEweBEXICaOG52qJ87vvXvQEsEcejPT+TSs=;
        b=m6a31Vzw8Rrk6jx61dsjJOJEDHPitKIy//duzL0VlXP0NklYsQiahX3kMzwExukKOx
         XrMz0oWyu46A4vSZYOrlJ2N5Kky/YyGSeY18PndoIDXp0jzCV/r2T/dK8xzUjOBX2Ec2
         UDd0p9r3n+R7ChX68q/cPao1kHjewn1vQrdkbgLR93BJJd38yu+MBqkEy0EYU0o9Yr0t
         k7uT7or2TuP+8oJiaIH2BQQ4yH43HCiwBDIOBbJaaJrHc6r7VOCsjMAsu0q9F8pbEdhn
         NCNd0S52EmYNbdhBpT0e5JufrX9pXUCa2oopY3G/dcdS9CkTH3RyQuB6R5R3NeV+X7c8
         /qJg==
X-Gm-Message-State: AOJu0YyzH0JfglicjOQcK+3Cu6Lf2pCcrdXMfFU8Mtbksd1ErTYZaEWR
	9yTWlrDw7cID/g3xeavOS4sEj3lT1exxnDS4yBy+r7nuqHrO0Wpw8rpdIjKalo89
X-Gm-Gg: AfdE7cl7VF0jWauRAjNiMnJG2oQNHwJXWiRrpvZd3JwZmj9N9TDxRmME60BCmpnNczt
	oQtx1XQDWRnNcqLSsKFhrQnSToxdm2W7SATs9lheUe6UsqF572uYsN7WtHz+FZ+PZoWdHapqzAX
	FnJFtCABtQ2D91dVULQIfaqtb6Xdw0Lia6BzXc9WHShUpF0Qi/r7weeRx7xWWBC6ZHrgdweLYfb
	3ce6mXXa7FpDB4eF0xlu4g2aEJxJGqYz6p0o0fepOpQb/Mk/nfADporWT2p1J3c5WVlqg6m6OlE
	A+N+gE34rQ4YuVzcRZSl/O2Gbs+FUC3fkiFWKtgedCyYzyXwjh828FtwWoKUgOoeTzAx8uEpJwA
	zyTd9ryaLT68ijtMGuYq9nv4DMX+dtABKecp84d2KESHTUtxi7hpdgCB2ircMW5a33g6/TL9rMy
	JuzclR7ugwtioYN/M=
X-Received: by 2002:a17:90b:270d:b0:37e:b6a:6cdf with SMTP id 98e67ed59e1d1-387573b2d12mr4124292a91.20.1783406884332;
        Mon, 06 Jul 2026 23:48:04 -0700 (PDT)
Received: from io.local ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d229a20csm537968a91.16.2026.07.06.23.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:48:03 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	Phil Sutter <phil@nwl.cc>,
	Xin Long <lucien.xin@gmail.com>,
	Rustam Kovhaev <rkovhaev@gmail.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Subject: [PATCH iproute] ss: Don't re-print an SCTP listen socket as an assoc
Date: Tue,  7 Jul 2026 16:46:50 +1000
Message-ID: <4d56e7ac2502cd92d4837d9fb16b9228aa17d599.1783406660.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305303-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:phil@nwl.cc,m:lucien.xin@gmail.com,m:rkovhaev@gmail.com,m:jamie.bainbridge@gmail.com,m:lucienxin@gmail.com,m:jamiebainbridge@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,networkplumber.org,nwl.cc,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamiebainbridge@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA3B771824A

"ss -Sa" prints a LISTEN-state SCTP sock once as a non-assoc when
is_sctp_assoc() correctly returns false, then again when we have cached
the inode in sctp_ino, so is_sctp_assoc() returns true.

On the second pass, we try to print the socket state with
sctp_sstate_name[s->state], but s->state == 10 (SCTP_SS_LISTENING)
but sctp_sstate_name[] only has 8 entries, so we illegally access beyond
the end of the name array.

If you are lucky, the space beyond the array is NULL and the argument to
the print format is printed as "(null)" by the C library:

  $ ./misc/ss -San
  State     Recv-Q Send-Q    Local Address:Port Peer Address:Port
  LISTEN    0      5           192.0.2.10:9001       0.0.0.0:*
  `- (null) 0      5           192.0.2.10:9001       0.0.0.0:*
  `- ESTAB  0      0      192.0.2.10%net1:9001     192.0.2.9:11111

If you are unlucky, the space beyond the array is non-NULL and you
pass an invalid address to the print format:

  $ ./misc/ss -San
  Segmentation fault (core dumped)

The inode is correctly cached at the bottom of inet_show_sock(), so
check if we've already processed this SCTP LISTEN inode and exit early.

  $ ./misc/ss -San
  State    Recv-Q Send-Q    Local Address:Port Peer Address:Port
  LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*
  `- ESTAB 0      0      192.0.2.10%net1:9001     192.0.2.9:11111

We cannot exit later than this (eg: in sock_state_print()) because by
then we're already halfway through a new line in inet_stats_print().

Keep the existing check in is_sctp_assoc() because that is needed to
differentiate related assocs from new endpoints.

Note: there is still a chance of double-printing a listen socket (now
with the correct format if netlink delivers us listen sockets and their
assocs with something else in between:

  $ ./misc/ss -Sane
  State    Recv-Q Send-Q    Local Address:Port Peer Address:Port
> LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*     ino:36518
  LISTEN   0      5           192.0.2.10:9002       0.0.0.0:*     ino:44485
  `- ESTAB 0      0      192.0.2.10%net1:9002     192.0.2.9:22222 ino:44485
> LISTEN   0      5           192.0.2.10:9001       0.0.0.0:*     ino:36518
  `- ESTAB 0      0      192.0.2.10%net1:9001     122.0.2.9:11111 ino:36518

This behaviour existed before this commit. I don't see a way around this
except to pre-sort the results from netlink which seems unrealistic.

Fixes: f89d46ad63f6f ("ss: Add support for SCTP protocol")
Reported-by: Rustam Kovhaev <rkovhaev@gmail.com>
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 misc/ss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/misc/ss.c b/misc/ss.c
index 14e9f27a75321556240a5f290b8bcf51c605a4c2..7e94160f7590c35aa187fe00902be8def7593608 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3764,6 +3764,14 @@ static bool bpf_map_opts_is_enabled(void)
 static int inet_show_sock(struct nlmsghdr *nlh,
 			  struct sockstat *s)
 {
+	/* SCTP assocs share the same inode number with their parent endpoint.
+	 * If we've seen a LISTEN socket inode before, we've already printed it
+	 * and cached the inode at the bottom of this function. We don't want
+	 * to re-print the LISTEN socket again. so exit early.
+	 */
+	if (s->type == IPPROTO_SCTP && s->state == SS_LISTEN && sctp_ino == s->ino)
+		return 0;
+
 	struct rtattr *tb[INET_DIAG_MAX+1];
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	unsigned char v6only = 0;
-- 
2.47.3


