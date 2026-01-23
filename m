Return-Path: <netdev+bounces-252838-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI/MCYZnc2mivQAAu9opvQ
	(envelope-from <netdev+bounces-252838-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:20:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD975AC3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 13:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 771A330488CE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042D28EA72;
	Fri, 23 Jan 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Gk/+q+sx"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8B32EA48F;
	Fri, 23 Jan 2026 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170721; cv=none; b=bpovezRK+fswVH8e6a45qdejFkzUTqq4fjRY6wm6Urci7n3KAF6cusmWuWICXl0f4R/Dwn+Pa5UCzgU8O3E9qfYzRO4yk0s3Yx9B6Lwvhif+wS3Ma1kmGElec8BRJ/kqEqVcmDI4w2tWMNRqlsDl7IIca6UIMzrWT2F5yT3vwZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170721; c=relaxed/simple;
	bh=dvHwqxrLBLwCTlBxNIo+6k7Ecmhf7CkQ7kkK2Nih2fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DahSp7kcabqremmVyGnPIttpwvfeVmk/Y4mJsHpeEg4fcPgygUCAh+NiUZVmCoWd21h4CGzifOxhq24zmRS0hIARc+Xd1+1dQ+pX3vr+4xrrYJ87AB55npqx9mbSQsByM5MYNg28F2Ge+y1LV/ueLQvSZIuKT0fULe+eiK1A82s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Gk/+q+sx; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=XOMQs7uBcrIY8f02bUmgzj9wshp3hn8MD7+FpRXarZQ=; b=Gk/+q+sxp8BS2Ac9nq89sptlkD
	00QSVstIPT3rSMUgWq/bYVjLdP47AuLoDSv+RolyM0tP/vX3xBpl7thHnvQb1ZXVrJzTvUro0GLsa
	rz+I2N8lRCWrIwu1CkWiFgniRjPefFwkE0YhN9G/PjZDGkCOILFBwg0qCX1Ep61j3Z9eOwYT5xjbT
	S4WH8mjY8olhO6g+8Qfw3pFlEVtZB8oNlY9LoEcTiSGkJRA10f8FeKB0Sep+a1uSTKb5i5iD/dvt+
	4ORoeRDnMrjetz9iyLmyix06gBXNmzSLi38lg0oPXFVY5e6fuCtz2m9J33Zuv1XUsBiQl1PVO9Kc5
	My9Kh6Ag==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vjG7G-00DpfN-Np; Fri, 23 Jan 2026 12:18:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 23 Jan 2026 04:17:28 -0800
Subject: [PATCH net-next v4 5/5] netconsole: pass wctxt to send_msg_udp()
 for consistency
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-nbcon-v4-5-46a5cf567926@debian.org>
References: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
In-Reply-To: <20260123-nbcon-v4-0-46a5cf567926@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 pmladek@suse.com, john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
 gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, 
 mpdesouza@suse.com, kernel-team@meta.com
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=leitao@debian.org;
 h=from:subject:message-id; bh=dvHwqxrLBLwCTlBxNIo+6k7Ecmhf7CkQ7kkK2Nih2fs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpc2bqXrY/3mib53itDkUm5uPhwNKOQR3cLoIad
 SG5B+9jtJOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXNm6gAKCRA1o5Of/Hh3
 bVTMEACUNdjtkxJNGvvRIg4uwJndv3BotXB6Gn220gsshi43CbiagGl3I0a1Eda6Tpq8JNLFa/e
 DbdObDuQbLl0LaeGEx7ukgAM3y8wdHGKsHiYq5Gbkc5sJZEIz4EYryDcD4vTdN0iCYp51IKIFrK
 m4JPXTyMTewPLqdVxlA93nG9RfdlSVDe/Xh4T+uYhHF8rYCG0clqgt7/us2CDvMzG8ATTIJzY/l
 IRX7R035D7/VGdMZiT06WEi3xV/rK0trJPeWk6kRMFHFfbhtmLRCAe9RZ/c+XBiBNdxo/Fd0dSe
 iMNe6gBQVi07BIxPwU1sdOqjBnUQlM24/XcWy3B02K4PuTyP1mlbDd30zYqugtnSJTIndQJPXZU
 7McHXkjNTtAIzjJz67hE9/Ud25pMePCPbwFFw/WrHjOyNlWssqnIEOxPaxKf7vQjqjrHz4MUoxM
 tgh+Yp8WRcxCZ24kcoRCRt37/tqF0SU9ls6yeTbJayT/tKP7f5d8J4bvpWzqCaDIfuYyVkR5ZSB
 7uWf+UB0hAjZTGUqVLLk/10tZGT10sV9FeloRdL0WatkguXOYJORtw3+mxNpGvuhfK2/tgBTmEo
 ursckJ7jFQFElzFKDdMTdu4bRFWj7/jA6ly3vJ3AkpiJ+Q1MP8XTp8zB6sBOgesFIsuuh0tzZMa
 qhKAWw+xdJzaElg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252838-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D2BD975AC3
X-Rspamd-Action: no action

Refactor send_msg_udp() to take a struct nbcon_write_context pointer
instead of separate msg and len parameters. This makes its signature
consistent with send_ext_msg_udp() and prepares the function for
future use of execution context information from wctxt.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0f44ce5ccc0ab..d1dadb7e0350f 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1865,16 +1865,16 @@ static void send_ext_msg_udp(struct netconsole_target *nt,
 				   sysdata_len);
 }
 
-static void send_msg_udp(struct netconsole_target *nt, const char *msg,
-			 unsigned int len)
+static void send_msg_udp(struct netconsole_target *nt,
+			 struct nbcon_write_context *wctxt)
 {
-	const char *tmp = msg;
-	int frag, left = len;
+	const char *msg = wctxt->outbuf;
+	int frag, left = wctxt->len;
 
 	while (left > 0) {
 		frag = min(left, MAX_PRINT_CHUNK);
-		send_udp(nt, tmp, frag);
-		tmp += frag;
+		send_udp(nt, msg, frag);
+		msg += frag;
 		left -= frag;
 	}
 }
@@ -1908,7 +1908,7 @@ static void netconsole_write(struct nbcon_write_context *wctxt, bool extended)
 		if (extended)
 			send_ext_msg_udp(nt, wctxt);
 		else
-			send_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			send_msg_udp(nt, wctxt);
 
 		nbcon_exit_unsafe(wctxt);
 	}

-- 
2.47.3


