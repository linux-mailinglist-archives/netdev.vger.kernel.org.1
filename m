Return-Path: <netdev+bounces-304449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ki2qEpRzR2qpYQAAu9opvQ
	(envelope-from <netdev+bounces-304449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D50700174
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:32:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=qCwgzMhK;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304449-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304449-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0C8B31193F1
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F93064A9;
	Fri,  3 Jul 2026 08:15:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C9374731;
	Fri,  3 Jul 2026 08:15:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066511; cv=none; b=uxCZsVl53SYjGrK41YDrhRi8QJhQ71VvYNXEiRNKI/qe1MjDsm/TKFQqnubKxybf3tb77CC0Z1kVyDmpiTKYtR4Z455Yw7wG4d1fjoqo4Ij/ny40w/KEW9CfGpvtdJdEsSTKuelcbN9otOC8sDoV5In5MWCmyIfI1enbGAH49Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066511; c=relaxed/simple;
	bh=iyaacdr356EoOA8EbB7v4RVsLV5oEECsX5TksqNYQDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dk4khqukDLwvVuj3/6YFmJAKWwBDOzTCOehvq0JnUJTAr6m9FbExdRHN/KHOmhkIzbF3w97ONytRMhVHY/YItOetD/eVfRMfL91ASS8m+Hdj+8soN1rCEsjVnee2e9fRlEwlmbBR7/sPU99sKyqKuwoHraxH6YUlYTn0w9hDmn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qCwgzMhK; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 58B06138012F;
	Fri,  3 Jul 2026 04:15:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 04:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783066508; x=1783073708; bh=9
	gE+U0sqLNSGSMM+YTabj5jX+4/WFgFZYv750hERq0U=; b=qCwgzMhK4+ZeKgYEu
	LzCQgEpzpVokuDgTr+a0YBSuc0Byhv/whyTThkhflOpb4zouBRnwWb6MSAj55XXw
	B0bwzzDOTK+LoVOFlLZfPN6+zlE7L4OdQ7Gan3nc1Zu8aUy4+5kSlKY41pLJoxRw
	bU4Bi5CQmCvWcSCybyohjg6/qtaZBMvKpso4nXrEIPVNoQQ7BjuKf/2a35OrERJ0
	+sMQoCcJGmIg4o8df6qTq/R0ErUAUG6rs4TXy+TMKhFwZZCwapAjNs3I3Et1EHxa
	f36lTsAoRuHFQVuszshnJ5fp/B74xE28HXNWXkpGEq+SPcXSYbtnEa524WKAMeCZ
	RwdrA==
X-ME-Sender: <xms:jG9HajicNdprfT7NmgD5GuKwyXEgtsGlWfhkj92wL9z37JrCWPb9hg>
    <xme:jG9HalMbTtc-j4XmgzNjLjw9jKgLY03JrgvJYlf32_gFeJ2ZWPrmKa9YKjmmHkXbA
    qRFuyPX0RNofImwdVlBY-abReOZCK00uhkyNaqjvoc0VXsLFc_YS2E>
X-ME-Received: <xmr:jG9Hame8vCJc4du80sMYI2-6xQZR8ZdZPTePC_8O6dKNzyHEL6m9TiWV6EeQeLv4Vfu_nfPFKt51De3fKFxU-UmBYgs8Mp5WG60Ktg>
X-ME-Proxy-Cause: dmFkZTGdjcoCT24gJYMv4sMjEKjI3E13qPXIIYBE2q2umpXoIJbYBY/m+f2QVHs/xDfpIr
    6knRmUMD/PWmQg8B93n6jtNoLQx8QKQ+RMhZ06xrrg7ys9WRrzJCXW+xJfk0M2wt2m5YWb
    1v4GrkV8sK/993605PwVdXKWjIS87aNxdjfCv0M/jJmJXVlgA5kofZc+IkHQhl8/RJSfZC
    lF5/jyowpDtxV+hFi9yvvSzru+7EZx96UH/5t4ooGDL6cAr+DgLKCmLxWdBLrUe7abyOa4
    PQ3KhJNA+c1VEZgqBum+1PZFNg9uW2SyaLC35zymCYpyi1Bls3hC3N5kWIEJqoHRuhjqhF
    QFsa17+ZtYFhV40/3POfawndfSNfkj5bgSHtB8zQ3yOgz6Vf3KhUg/3825BDKpABgE1k9x
    x8LuUH+HuyibvLr447fiDowa2mbSPt3Kw5ndnyGioTkosrpx5KVnxmRn1aUQ+CqVaot6xn
    4OBroW5Sp3cheX6wkm79D+IRDxVljQugLCFdxt9MnN/ntF3Tdglhnu/XLkDiDSsWMAkRqv
    F1RIV3s5Rw8AGC95evqPlQDe4oVPXQqye2iKFPFBq05UpY4FTedVMBYc8apleNAKFO1xHm
    dIR6HavdUCStOaFOUmv5Q+YV1cRXzUGymPB7RUVzxJ5C+o5nF4u4DQZi5N4A
X-ME-Proxy: <xmx:jG9HavwAs_outNUVIWbdwTweTcRwGEbOsyuE_yKbRnI-4XNxfvCmwA>
    <xmx:jG9Har1m5eMsfm8h3fCygXpMV6QUYb66vvxxC963_z3Xl3om4iw_7Q>
    <xmx:jG9HamcMFwBdUSfS8MU9q79l-reCvisG1VjaCcNiv2mnPqK0C-xcRQ>
    <xmx:jG9HagVjpMKtvdS50ITtknReRBclSMyxSGHzV3zM1PnvMLJoymgbqw>
    <xmx:jG9HaqO1jCzgZeTBoh1Gc7Wv6iqSrSqSjH-imQpQLmt_HNNmI_4esJce>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 04:15:07 -0400 (EDT)
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
Subject: [PATCH net v2 2/3] selftests/net/af_unix: test listen() rejects wrong socket states
Date: Fri,  3 Jul 2026 04:14:11 -0400
Message-ID: <20260703081416.2583118-2-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
References: <20260703081416.2583118-1-John.Ericson@Obsidian.Systems>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304449-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:cwang@multikernel.io,m:john.ericson@obsidian.systems,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,johnericson.me:email,Obsidian.Systems:mid,Obsidian.Systems:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89D50700174

From: John Ericson <mail@johnericson.me>

Add a regression test for the `unix_listen()` state check. The key case
is `listen()` on a bound socket that has already been connected: it is
no longer in `TCP_CLOSE` or `TCP_LISTEN`, so it must fail with `EINVAL`.
A `prepare_peercred()` call slipped in ahead of that check once left
`err` at 0 and made `listen()` silently succeed there instead; this
guards against a repeat.

The neighbouring outcomes are covered too so they cannot regress the
same way: a bound socket in `TCP_CLOSE` listens fine, re-`listen()`ing a
socket already in `TCP_LISTEN` is allowed, and an unbound socket fails
with `EINVAL`.

Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Ericson <mail@johnericson.me>
---
 .../testing/selftests/net/af_unix/.gitignore  |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/unix_listen.c       | 126 ++++++++++++++++++
 3 files changed, 128 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/unix_listen.c

diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
index 240b26740c9e..973176644103 100644
--- a/tools/testing/selftests/net/af_unix/.gitignore
+++ b/tools/testing/selftests/net/af_unix/.gitignore
@@ -6,3 +6,4 @@ scm_rights
 so_peek_off
 unix_connect
 unix_connreset
+unix_listen
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 4c0375e28bbe..57d159803a3a 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS := \
 	so_peek_off \
 	unix_connect \
 	unix_connreset \
+	unix_listen \
 # end of TEST_GEN_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/unix_listen.c b/tools/testing/selftests/net/af_unix/unix_listen.c
new file mode 100644
index 000000000000..7b5264c97f52
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/unix_listen.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests for the state checks in AF_UNIX listen().
+ *
+ * The central case is a regression test: listen() on a bound socket that
+ * is already connected (i.e. not in TCP_CLOSE or TCP_LISTEN state) must
+ * fail with EINVAL.  A prior change accidentally let it return success
+ * without doing anything, because a helper called in between reset the
+ * error code to 0.  The neighbouring checks (unbound, already listening)
+ * are tested too so they cannot silently regress the same way.
+ */
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stddef.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "kselftest_harness.h"
+
+/* Fill @addr with an abstract-namespace address named @name. */
+static socklen_t unix_abstract(struct sockaddr_un *addr, const char *name)
+{
+	size_t len = strlen(name);
+
+	memset(addr, 0, sizeof(*addr));
+	addr->sun_family = AF_UNIX;
+	/* Leading NUL selects the abstract namespace (no filesystem entry). */
+	memcpy(addr->sun_path + 1, name, len);
+
+	return offsetof(struct sockaddr_un, sun_path) + 1 + len;
+}
+
+FIXTURE(unix_listen)
+{
+	int sk;			/* socket under test */
+	int server;		/* a listening peer, when a test needs one */
+	struct sockaddr_un addr, srv_addr;
+	socklen_t addrlen, srv_addrlen;
+};
+
+FIXTURE_SETUP(unix_listen)
+{
+	self->sk = -1;
+	self->server = -1;
+	self->addrlen = unix_abstract(&self->addr, "unix_listen.sk");
+	self->srv_addrlen = unix_abstract(&self->srv_addr, "unix_listen.srv");
+}
+
+FIXTURE_TEARDOWN(unix_listen)
+{
+	if (self->sk >= 0)
+		close(self->sk);
+	if (self->server >= 0)
+		close(self->server);
+	/* Abstract addresses are released automatically on close. */
+}
+
+/* A bound socket in TCP_CLOSE is the normal, allowed case. */
+TEST_F(unix_listen, bound_is_ok)
+{
+	self->sk = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, self->sk);
+	ASSERT_EQ(0, bind(self->sk, (struct sockaddr *)&self->addr,
+			  self->addrlen));
+
+	EXPECT_EQ(0, listen(self->sk, 8));
+}
+
+/* Listening again on an already-listening socket (TCP_LISTEN) is allowed. */
+TEST_F(unix_listen, relisten_is_ok)
+{
+	self->sk = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, self->sk);
+	ASSERT_EQ(0, bind(self->sk, (struct sockaddr *)&self->addr,
+			  self->addrlen));
+	ASSERT_EQ(0, listen(self->sk, 8));
+
+	EXPECT_EQ(0, listen(self->sk, 16));
+}
+
+/* listen() on an unbound socket fails: there is nothing to listen on. */
+TEST_F(unix_listen, unbound_is_einval)
+{
+	int ret;
+
+	self->sk = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, self->sk);
+
+	ret = listen(self->sk, 8);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+/*
+ * The regression: a bound socket that has already been connected is not in
+ * TCP_CLOSE or TCP_LISTEN, so listen() must reject it with EINVAL rather
+ * than quietly succeeding.
+ */
+TEST_F(unix_listen, connected_is_einval)
+{
+	int ret;
+
+	self->server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, self->server);
+	ASSERT_EQ(0, bind(self->server, (struct sockaddr *)&self->srv_addr,
+			  self->srv_addrlen));
+	ASSERT_EQ(0, listen(self->server, 8));
+
+	self->sk = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, self->sk);
+	/* Bind first so the unbound check does not mask the state check. */
+	ASSERT_EQ(0, bind(self->sk, (struct sockaddr *)&self->addr,
+			  self->addrlen));
+	ASSERT_EQ(0, connect(self->sk, (struct sockaddr *)&self->srv_addr,
+			     self->srv_addrlen));
+
+	ret = listen(self->sk, 8);
+	EXPECT_EQ(-1, ret);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0


