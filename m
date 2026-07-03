Return-Path: <netdev+bounces-304448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Gm+fLSh0R2rTYQAAu9opvQ
	(envelope-from <netdev+bounces-304448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:34:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0107001E1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:34:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=k5SzCKGO;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304448-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304448-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98D2E30E080D
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23540372076;
	Fri,  3 Jul 2026 08:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075A36E48E;
	Fri,  3 Jul 2026 08:15:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066508; cv=none; b=KCc8e5b1LS2LKkKjhTYdE8awKfbCje9/9DFjJLdKJR81mMk/G4KgYZDyhVa/wZfJzgu2SkOovooYxASmykrRzxKyPzssPPuFQhgTlxr0SY/fsi/iHq7xGsYC8DWjRpwy9Cz36V9oBCPn65JPt3GB382gaQGj5WZSIrWi4EJ4mUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066508; c=relaxed/simple;
	bh=uKklMmX/FarzYD76ncNoGsncDBQVTvDMxsz7RuvpMaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZuCW+TIwmTvqRwr+rBLWGDPp+zvRtILsTvDd9jWLr90/t4EpkRJQT0UPnpEPdyMIh85RygE3D0Vjoa4tAu0qKYy6ncHPj6V6DK9BYwbI7Rrm16UjSmpq3u2nbdlhkhv54ORxai1FmrmVKVlArRbeh70OF8JDdf+jLfo7MzLF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5SzCKGO; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id A653F138013D;
	Fri,  3 Jul 2026 04:15:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 03 Jul 2026 04:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783066505; x=1783073705; bh=L8AaH8HEaSsvrShwQdsU0LGffFk34FHqZnC
	RLR8S6rI=; b=k5SzCKGOBMEOg1CpKv6ASW03gLjL8lI06DrVhv2EvNbdSQ/kh/7
	lQT9qLXUJ0cUu+NFPuPn0GAWiGU+h6zNOKIFwDvnF8BeX7uAaoc5S2je96awYJCX
	wyCVXdrdVJ9Rz16D3FkGIP39qmaSLkcUkubR1istaW2alEOLmBqTjpkvy+7TJVSe
	jm9m1MREx6Zbgx8Vw3dNc/V2NHJcecfMBdxJaD9D0Oa6opSBZQ8OD7Ucqkihr95s
	boAyxwpz/SAXmbhW9jyBC8x7DfPwsnCRU6ZwhCHM5k3MhYi6W2ihfPJNh7NtVNrV
	8a5hueULJ9raJYwPJQFBGwp3/ohMeGpm2kA==
X-ME-Sender: <xms:iW9Han4nj0Fnx6pfhsW402Ug31szY6J7RVDEza0HzHnGGQdAz--MWQ>
    <xme:iW9HaiFMF2S4ve6fFd8DrF4AKl79cVcH9EzGS16OiLMy7rKZ_NhBrGx5l867rFK1q
    5_C2hvBeABZ8AizMoZXjlDcruS3a1D6uaBdpTGVyvWHCuWVhtcs6A>
X-ME-Received: <xmr:iW9Hah2YJ3jIbeQ6vzyRYmfoGX5ko2PHyC7_wQqzhZkFk1hle0NyTuk96_1hbgyVT8YtC_59KeDi-uIZIhzmWSBDY6koLZDrS8_IEw>
X-ME-Proxy-Cause: dmFkZTE6NBtyOFYvJtG20mXpmAN9Q+T0LNWwFE3JEIVEwC7/Pz/zlIYHrvx3tLNcd9tQQg
    AsCHjA+F31FQIOa/MdmHQqvcY7IAn7yvh9fd+Ryqr1sY1HOXChPshIuyC93WvW7n1gz35m
    pey9hVdoLBc+iUpNs++OHOY+PayYYoryPESMj85FZZtf/AKSIFyNrh2ljbn5JYPgszaGWE
    NHSA6B7AiLm/ekSqmVe6gVZURQGxsI9paM4PUXBCecQe2Tgg1aglrpMJC/f/iUZk56HxFD
    7WGuTiqnxqVqLslwIOWvF5+xBVZjM6mX6X/7g/WNj/kxEhwAlq5PsmllPXIQaozbBIbkjF
    kE8LVnrDKLS6yK4NXgnV9L1RsT6DDrPDiiU79l8FF8MstwZ4d8JcWUrFWrjKUFkIg5/Ar5
    Hq2R1XBx4tzRNqmNkB+8518sgJjGJqKUt4HkK6IKAUxf4wHWzEa7oryB1YirW612v88U3C
    1o/ThSFlwrQT2YTEkiNGQj6BLNF9KrQe/xBaj35AGH15i+9PDFN9k9lSRo9xceQgt3yGdn
    EKuHDsgbCNFmT0moadw9yqSKnDS8e0BX9DXDrizNWJ1Q0pHJUll1Q7xFUcii2GR++4QN7y
    Z6xwKVrMExl27tqLgzSDOPASITqBXnJvTgGmA3BQFrFe8AGi6cmZjWlJM3jw
X-ME-Proxy: <xmx:iW9HanoRYLph2IsaCbqYv6-Jek-isnJDvo28UfXiu3_KA_xQ140GqA>
    <xmx:iW9HamOgjnVEN6xsy5heKWTMYoscxsca_lgODEYnAPqx06-iTYsAJA>
    <xmx:iW9HahW89yfSFZjKRJ2WkJCEeOt_gU3-b-bBiceCAE8x_O-SKsd8Hg>
    <xmx:iW9HahuEjXOylJgkIY4zzOFYaeoOHROhA__lztZmrEiLSJPUBFJCtA>
    <xmx:iW9HapnnADvAyO2Q3U6i7vebWD7TWUM-rEilG_QY5zHJ4cs3nCH8QczV>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:15:01 -0400 (EDT)
From: John Ericson <John.Ericson@Obsidian.Systems>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: John Ericson <mail@johnericson.me>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Cong Wang <cwang@multikernel.io>,
	John Ericson <john.ericson@obsidian.systems>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/3] af_unix: fix listen() succeeding on sockets in the wrong state
Date: Fri,  3 Jul 2026 04:14:10 -0400
Message-ID: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304448-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:john.ericson@obsidian.systems,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,johnericson.me:email,messagingengine.com:dkim,Obsidian.Systems:mid,Obsidian.Systems:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C0107001E1

From: John Ericson <mail@johnericson.me>

Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
reaped sk->sk_peer_pid") inserted a `prepare_peercred()` call between
`err = -EINVAL` and the socket-state check in `unix_listen()`. Since
`prepare_peercred()` leaves `err` at 0 on success, `listen()` on an
AF_UNIX socket that is not in `TCP_CLOSE` or `TCP_LISTEN` state (e.g.
one that is already connected) now silently returns success without
doing anything, instead of failing with `EINVAL` as it did before.

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Assisted-by: Claude:claude-fable-5
Signed-off-by: John Ericson <mail@johnericson.me>
---
 net/unix/af_unix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..10ed9421e43a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -823,6 +823,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (err)
 		goto out;
 	unix_state_lock(sk);
+	err = -EINVAL;
 	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
 		goto out_unlock;
 	if (backlog > sk->sk_max_ack_backlog)
-- 
2.54.0


