Return-Path: <netdev+bounces-304415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UzFWIdBnR2pAXwAAu9opvQ
	(envelope-from <netdev+bounces-304415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:42:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 185886FFA9A
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 09:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=YSav2lUu;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=obsidian.systems (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304415-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304415-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 077FD30363FA
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 07:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4636E468;
	Fri,  3 Jul 2026 07:40:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10D136C5B2;
	Fri,  3 Jul 2026 07:40:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064450; cv=none; b=dROGTEctu253Hm7TZEIP9Fbn48SxTzt5Z4GbrK2kUYiXQc3CGSpQvcH4k1R5epLRPknWTdgl2hbCicE0lw243B5iWnZntMeCr8b7fl8PUpKFZOooozFvrV1ifRCCs/X3/Gg18gZDVUufV55CJUAoCo4sdSxeHQe28Y7/RLGqSu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064450; c=relaxed/simple;
	bh=OSsltn6C8Y+HlW4BoHwDSZlQaiPRN6a0rtCzKaj8jfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXfv3oMiZlU4i/77w4bOeR1yxH++wmF2fqlfoM/aRmC3bwOxaqilApaSuWyS6zhBpgGIpU5HG/Q8TaGyjTliHxO4t5j8DhFstYJAGdNedgdiqTrSk3yfJXufpEhybRQHQQ5jGOOT5RUFju9vUwLCYjqQPsx/UTtyckSMOvi7aJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=Obsidian.Systems; spf=fail smtp.mailfrom=Obsidian.Systems; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YSav2lUu; arc=none smtp.client-ip=103.168.172.139
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id BAFC81380253;
	Fri,  3 Jul 2026 03:40:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 03:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783064447; x=1783071647; bh=4
	+aC6fyl2+Dcw5IobpYCoGaBRvN4wZAwBc+FpvB5LZU=; b=YSav2lUu6ivZcgXec
	cQS8bIJjbwwWeNgtibLGgGu8U5mL1P1+Hf5nFNMz1/JsKzTLHrTkKVefAmnwJihm
	kNZxKh5rKbTqYf52CV66ct9RcU0L3MsEsbwSIRBv6Hwksx/guVZM+zL1aak9Kz0Z
	asmMKOIbyG2Dng+cJvKxS7hnnRC6jHcjsde78ey36iuAg4ALXZnvfwd4y8S6bj/P
	wkxwogBy9hIu9XaCI0F+KPWx/l6FBpTA0dTRKKkCzLIMZsLC81T0pkI7rsdIwHyQ
	9LdoSEcaXF/FKw98XUkRzTevrlWCDL5KcDLyMM3xI4HPSdmxhjXdlAXYFGat3laK
	fwOrw==
X-ME-Sender: <xms:f2dHatuFsvFEOCVSEOnw0ufqSojPDwCTEwEPCsrBfJLqVBz2bWO-Nw>
    <xme:f2dHatYdDbIDrDHywWrPUmpK3jziV_Hu4nNlBxzj96cp51r_j3PjTIrP8GOlbcCYI
    1ptOJpr7PyBrUHzHgreZBCqS7kGVDpWXun1pfMlZashM8cnIm-8Ow>
X-ME-Received: <xmr:f2dHal1Km1-pNskO_ZKFHgskPJ-egg-h7WxpVvqTpBq34sQsLquEFwEllr5QdnS76hgnQUP9Rfp2x7duAliJ5BLBNemul0IATHUA_A>
X-ME-Proxy-Cause: dmFkZTF5O/McLRsZCRxt94kSPLWv/pg4aIqeyt9N4Y8eJW/YDo0plxRm4srEqsmG5fka4Q
    UqwAbE5NnbduvPuBt0/76VGhbEfyxrPlr3N4jUUYTAI2UNYThU5TjW7C02DyKqwKuwlZV0
    XzAXlMuu/Q38Qv64ImOJDhrGFPwaALkKvo1cPMYCcGxDoCeD3sycEQTBJts84tGDedkbqc
    q4O68AaKqKH6xDkVovBW9IqWYwQWOX0Nx0mmP2dSZoZehjCH90aM4ftx3bOGjiAbi+vWov
    qHx+jugGkI/Xp8WLPbaj8OIoEnMxi6ux498zRQGR2b74FNxT+Hrvc3d1N/KWiePU9+F4r0
    LNPRam/e9FfMnPqmHIOxFG/Ko8nVFUByY4DRf8I4zPrhqRttRNOVt/n+/JQczNlSJKJq2k
    OsNwm8uR5xEyniWAtKGA3kthy63iM4MB2mU1XX7flLyK1b0xVOaXRmNpLhMxG/cNeZKtBr
    eFvXfjMoy7PHxIGuCGjd5rMwdGpNbRkof/VWmkmzbcO+3ERccqn4mXtMsioMDu8KcC3tAI
    5Qc94ItrCLgNN8cWVnXQwtMr6YJh+WXKvhNsu5k0JY3G7kexxix94R0K3jD0CvL9u2UgSJ
    RyZj9QMtzSzx/9hd9OP6n8XZhQ4W0fAYiS/F9+UDKwTRwxaoBwfPv036MWBw
X-ME-Proxy: <xmx:f2dHarVvYJJ5nJqsi1figAijOageQY2TELAQzN7CG4aD9JBsU-HwsA>
    <xmx:f2dHaosipwLTm_19Oxgxn3luLCWyT_bboctABONiuaE5i_Q46Cxx-A>
    <xmx:f2dHaqVuKClMl0t_RYX7vWhy7Ilkgou2pvS769uRDP1XKs5XDMw1iw>
    <xmx:f2dHasWiByMf59HHOog_mQD34-vssNwPEvKMO3HJsLPfkp6Z9lepqg>
    <xmx:f2dHasffMH022COSf5HWA7KnkVovlW3tbyv3Cs-YFqI3fUbhyAepeC0q>
Feedback-ID: i91b946ab:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 03:40:46 -0400 (EDT)
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
Subject: [RFC PATCH 1/3] af_unix: factor out unix_lookup_bsd_path()
Date: Fri,  3 Jul 2026 03:39:42 -0400
Message-ID: <20260703073948.2541875-2-John.Ericson@Obsidian.Systems>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
References: <20260703073948.2541875-1-John.Ericson@Obsidian.Systems>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[obsidian.systems : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-304415-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[John.Ericson@Obsidian.Systems,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mail@JohnEricson.me,m:cwang@multikernel.io,m:kuniyu@google.com,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:luto@kernel.org,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:mic@digikod.net,m:gnoack@google.com,m:paul@paul-moore.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[johnericson.me:email,messagingengine.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 185886FFA9A

From: John Ericson <mail@JohnEricson.me>

Split the inode -> sock mapping out of `unix_find_bsd()` into a new
helper, `unix_lookup_bsd_path()`: given an already-resolved `struct
path`, check it is a socket, look the bound socket up by inode, and
check its type, returning a held `struct sock` (or an `ERR_PTR`).

`unix_find_bsd()` keeps doing the path resolution, the `MAY_WRITE`
permission check, the `security_unix_find()` LSM hook and
`touch_atime()`, and calls the helper for the lookup.  No functional
change.

The function documentation anticipates (in an example) the way this will
be used later in the patch series.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Ericson <mail@JohnEricson.me>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    | 50 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 34f53dde65ce..fe4547508af1 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,6 +14,7 @@
 
 #if IS_ENABLED(CONFIG_UNIX)
 struct unix_sock *unix_get_socket(struct file *filp);
+struct sock *unix_lookup_bsd_path(const struct path *path, int type);
 #else
 static inline struct unix_sock *unix_get_socket(struct file *filp)
 {
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..3270299238c4 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1185,10 +1185,43 @@ static int unix_release(struct socket *sock)
 	return 0;
 }
 
+/**
+ * unix_lookup_bsd_path - find the AF_UNIX socket bound at a resolved path
+ * @path: a path the caller has already resolved under its own policy
+ * @type: required socket type (SOCK_STREAM/SOCK_SEQPACKET/SOCK_DGRAM)
+ *
+ * Unlike the connect(2) lookup, this performs no path resolution and no
+ * DAC or LSM check of its own: the caller is responsible for having
+ * resolved @path with whatever policy is appropriate.  Used by kernel
+ * callers (e.g. coredump-to-socket) that must resolve the path under
+ * their own root and credentials rather than the current task's.
+ *
+ * Returns a held sock, or an ERR_PTR.
+ */
+struct sock *unix_lookup_bsd_path(const struct path *path, int type)
+{
+	struct inode *inode = d_backing_inode(path->dentry);
+	struct sock *sk;
+
+	if (!S_ISSOCK(inode->i_mode))
+		return ERR_PTR(-ECONNREFUSED);
+
+	sk = unix_find_socket_byinode(inode);
+	if (!sk)
+		return ERR_PTR(-ECONNREFUSED);
+
+	if (sk->sk_type != type) {
+		sock_put(sk);
+		return ERR_PTR(-EPROTOTYPE);
+	}
+
+	return sk;
+}
+EXPORT_SYMBOL_GPL(unix_lookup_bsd_path);
+
 static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 				  int type, int flags)
 {
-	struct inode *inode;
 	struct path path;
 	struct sock *sk;
 	int err;
@@ -1219,18 +1252,11 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 			goto path_put;
 	}
 
-	err = -ECONNREFUSED;
-	inode = d_backing_inode(path.dentry);
-	if (!S_ISSOCK(inode->i_mode))
+	sk = unix_lookup_bsd_path(&path, type);
+	if (IS_ERR(sk)) {
+		err = PTR_ERR(sk);
 		goto path_put;
-
-	sk = unix_find_socket_byinode(inode);
-	if (!sk)
-		goto path_put;
-
-	err = -EPROTOTYPE;
-	if (sk->sk_type != type)
-		goto sock_put;
+	}
 
 	err = security_unix_find(&path, sk, flags);
 	if (err)
-- 
2.54.0


