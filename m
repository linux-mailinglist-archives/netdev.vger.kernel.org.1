Return-Path: <netdev+bounces-281883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNimGne+8GnSYAEAu9opvQ
	(envelope-from <netdev+bounces-281883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:04:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B30A548683B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E5732D0B2A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EDD46AF0B;
	Tue, 28 Apr 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2BHL7A4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70DE46AF08;
	Tue, 28 Apr 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383070; cv=none; b=GMWFdHp0y13yxQsGQOwR1XgC95uSpCPaMbAzBrmwAOCvUwDzWpham9gNIyTiMiGrjNbDkDVws6yGc19BLNbzUHb/h45S3frjIfh1AGMBTulDUtmZ2lKFCJBEVVFO6Krw3LdRFxkwRInTxyCfuVV/lCq8RiAwvI3i4iiv22mP8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383070; c=relaxed/simple;
	bh=mGy1kcuJD9cmVfkG57MXxrakB2Cp+mC6iLjN0PrMK4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHs30N9rS8nuS84ZGM+Q5Ds6MRZ5QUnZceMTU48cYc/Wc0c1mfLqmJROSry4FCedTbffVVIR+3PZp637AzuKJiiGOznx0Kfhfx7EWYEmXQ5whAHc4Jav4atv79/AfYyi6bfs82ELndkSP+vQxj0nM0OWJsXucbndwgYgrG/OyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2BHL7A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AA4C2BCB5;
	Tue, 28 Apr 2026 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383070;
	bh=mGy1kcuJD9cmVfkG57MXxrakB2Cp+mC6iLjN0PrMK4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k2BHL7A4xiURzWBde2p7XMJkBwDbJMUDDDjx4tYF4e8jS/KCTvc/YBxuYYJcpRbmN
	 8adjHobJx9TPEii6uqMn9+cSK6SNPKjQCwsiQOYjasID2CY1hSuEWuviDtoKhNCdmL
	 9WnBzNu4Tp6FMlmg0XbvUyP2uwFRB0i/xctBX6sXIopOtuIsruUZu2pAmdM2aGtlAM
	 pgzAxREsZVhdbqzESUwg7DWtqJjcZ2P0hkP3TMvl8GCEJdUWRPCHp67ZHX4wUKI4za
	 nzGjCSTwkWoskwyi7z6NHy5XxnTv1w7O0SNaPhiI5fAbeZ66QB9IPX8CWObXbI9oln
	 o6Ekd6IdlSYJg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 28 Apr 2026 09:30:48 -0400
Subject: [PATCH net-next v8 3/5] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-tls-read-sock-v8-3-85f96c7df24c@oracle.com>
References: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
In-Reply-To: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=jrZruHoO5Zq3PFApGUlR5dlEKELnPPeSue6kxU4zJhY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8Labk12Wgz+lCaOqemapr6/pes8t0wQHw5G3x
 TWMe/VvagyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafC2mwAKCRAzarMzb2Z/
 lz8KD/91+fVMgrETp70Af325zUjgFBTLCqmjQH2/ypujTLS95jC5ujLPjODvjLu5dauxn45sTDb
 Fn9A3wbBQ3vPNYCOMRkywwrL4R5DsU/ZRzNnO1xvMar8t3fzqst0h1rXoRAwEk0ey7ciAj2qbA+
 el7aAw+1fLi2bj7vXiTllclFod7Rptz5ApHKftTIcqtEoSejikF/6S0slmYMM1mHqYUG0qrqR6x
 kI+4BcpPL2H10LR9hpZREwS9lXgPJ55lIl6PHm6+nZWTLfvT93hn9mSBeh6H44PKWBDU6RBQtUo
 A5G7kgwTMSpi+5sMRj+PVUhOyoFKwjwBGls0leCipFEsDWDobaMLWQyeUuDLk4ku5cP8+0AkB0O
 fem+BxhxmjnueCPz/x2PMTEms6ZUiRIE5la18jZj13QlnQgEuYLLjJRmkkvbMTqeQSLE0rJ/52O
 RnlzPpb+4Y7GML1wAUgrRoETggdIj4NIf8kLXx8JMum6i4diSXQMlQYBiGS+aOtw5XHBgsLNW0j
 lrxNDSK3MznEcvVUKBFHSP1bFMpWJ5dGo5Qs6nKv3C7Zb1ZOjtr5XPElesiO50T9QLlpurB9mE0
 rV5ZpTolRc/qetrflLIs+l9EIsrzchWgCD7a3f+30p2qRf/mVD98FOHu7QLhIQDoowL2Emm5URD
 9vIRy01gTuIt0JQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: B30A548683B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281883-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,queasysnail.net:email,suse.de:email]

From: Chuck Lever <chuck.lever@oracle.com>

tls_strp_msg_done() conflates releasing the current record with
checking for the next one via tls_strp_check_rcv(). Batch
processing requires releasing a record without immediately
triggering that check, so the release step is separated into
tls_strp_msg_release(). tls_strp_msg_done() is preserved as a
wrapper for existing callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index e8f81a006520..a97f1acef31d 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -193,6 +193,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_msg_release(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 98e12f0ff57e..a7648ebde162 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -581,7 +581,16 @@ static void tls_strp_work(struct work_struct *w)
 	release_sock(strp->sk);
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
+/**
+ * tls_strp_msg_release - release the current strparser message
+ * @strp: TLS stream parser instance
+ *
+ * Release the current record without triggering a check for the
+ * next record. Callers must invoke tls_strp_check_rcv() before
+ * releasing the socket lock, or queued data will stall until
+ * the next tls_strp_data_ready() event.
+ */
+void tls_strp_msg_release(struct tls_strparser *strp)
 {
 	WARN_ON(!strp->stm.full_len);
 
@@ -592,7 +601,11 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 
 	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
+}
 
+void tls_strp_msg_done(struct tls_strparser *strp)
+{
+	tls_strp_msg_release(strp);
 	tls_strp_check_rcv(strp);
 }
 

-- 
2.53.0


