Return-Path: <netdev+bounces-272778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDt5Ekbxx2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:18:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBE034ED71
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B7730479F0
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF7534404F;
	Sat, 28 Mar 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRUtorRF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AD33F36B;
	Sat, 28 Mar 2026 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711044; cv=none; b=r6JnDmAxQhK8/T8YWjjAbGDg1nMJy7SwS0Cq00Pps0bkzcLx91eRVWzKsTiAEv3t3HsE4yF1m9gDN9/0lHKBXSLzBOoB+pLYmFCV44heT8EyN2pjRMltqA7XKTkektnk3T2KHisU/D3i3NorJX4jFm5doyhci/g+YCs3FHphXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711044; c=relaxed/simple;
	bh=tsFAgU00nGO2HFNhrQavh8VK/+87gzxnnYi+T9vQ11Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LesLCNb7C/XN/EBR3Rzjw7FRfR+t1NsMJ2Uj9NMbGG+FhofR80zQzkMG20/NQgFPApyUq3e0eilgtY2bAPTQ9XheclZ41CqaWnuP1QMG9Qj/tPIeyqPybBslvJ+4/QnkhN2FHPuAsyyRZ7d1exbulZzEB5GL3XpwzvkYji61oZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRUtorRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C3C2BC86;
	Sat, 28 Mar 2026 15:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774711044;
	bh=tsFAgU00nGO2HFNhrQavh8VK/+87gzxnnYi+T9vQ11Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cRUtorRFpXDjZrDrb4dmX5K9kDerNkvaUUvIgdCb91toBjS6IFPl6mn5S0lq6QWFE
	 oRepGBVW0mSvmNqN3mS8ZLDaAS5FxXJ7wQ+l0XMYEiagQaF5PJqovKN5AEvYL1u/cW
	 5S2nua8RgG+OkKm98tZZJHNeeYEYp8f9BqbmcTSk5EHcpiEWYqQ0lHktZeVyjIUTHw
	 6CwJLslDaOGcGzEUy1S2VL4F5xnQjNK4djGnfzMssWJQat5obd3FPspgQZroRs/gDh
	 Vmz8Us5Fbrt6TMu+maf0InRJfJBBSrqcHp7TJopLciyc3lVd/QckWtsryezQfu3jUP
	 Gu6NNDw6MbNcg==
From: Chuck Lever <cel@kernel.org>
Date: Sat, 28 Mar 2026 11:17:10 -0400
Subject: [PATCH net-next v7 3/5] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-tls-read-sock-v7-3-15678415dfc1@oracle.com>
References: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
In-Reply-To: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yQMMtVVxvd+7sxHpan6dTvbldeUZSeQCrtyDydMeLBA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpx/EA5W8Kr7auWxqe7qsVMuOR1v9Cy1ZS/VJy/
 7b1AIwFP0OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacfxAAAKCRAzarMzb2Z/
 lzJRD/wJmH2wr5H8UtiYZfvGWWTHOvDCDrYKUKHSOqcAniGJV29vccJF4t3k1PijPMWxSWpFulK
 7Tl07gWVyDFXfQxddY+q3TrjGU7gJL9Q4MSONvIyVznYO6bk96YTB2GUP/Nz/1urNB4VlXLAAP9
 6zHwjWdNl1ZXp9JpR7RtBj9MEBtEkwD7y5Y7M5JljQxUg27Qmxcr17eFyHjgNLWq8OCR6QfrcEb
 1sJYn1CqdkmLezX4WAQcsUm9G75e+VGLGlFGicxeyeoNRf4sI/o5nUr+6av8WVdQxVeXG00XNLQ
 kwCvsakncHJzL1+QURoIHdgfOjmscdCB5ya/S0bDBMndFLVb8VL1/4UIXtHlamkE16j9mGc0ohu
 fubhzWv3PJwh9IHQASmn3f4fuCWXavEZBYRcaF9Z2A/5I74DkJRaa/op6UqhMQBYw9yh6qk603C
 6M62cO2fETLT27+r/Zhz3JMGYDecNBXn2oSrUCTr5CoJ+zqTaiJFwnAdLoK89BTprYp8t7qTBYr
 wDDVItrdep3UvRDV9WPpRfonq9N13KmFxYTorS21NkUGG1blMOGbvgFT7FsgvTCYu4GxfhWSKOa
 EgX1bPyiXEqMOVsa+vQVR78D4bBBfUysn6Re1+EYRE7icQES0HE1Vq9rJpfYbUbdl3zNrxOoVt1
 lPYbml/wn/MUQfw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272778-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: 9DBE034ED71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

tls_strp_msg_done() conflates releasing the current record with
checking for the next one via tls_strp_check_rcv(). Batch
processing requires releasing a record without immediately
triggering that check, so the release step is separated into
tls_strp_msg_release(). tls_strp_msg_done() is preserved as a
wrapper for existing callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


