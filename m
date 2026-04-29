Return-Path: <netdev+bounces-282511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIaONcN88ml2rwEAu9opvQ
	(envelope-from <netdev+bounces-282511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C949AB59
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE83130131BA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB883AE199;
	Wed, 29 Apr 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz9+S5KR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2E306486;
	Wed, 29 Apr 2026 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499306; cv=none; b=QyE9mCU+m+w6O7UztCHX5L7fwhgsymvlBHOskf74pXP7mmmgSO7mP2Np/4JD3zOBotXX3I5OfbPyokq75PPMi8JTYfdt6cVGJ0xEz8NEZHcB1BWoUVpEadHzFnsdQdex4YAIBd3ROiAJP2qFFsRXNovFNZGfbtuCYYHx1DCpFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499306; c=relaxed/simple;
	bh=mGy1kcuJD9cmVfkG57MXxrakB2Cp+mC6iLjN0PrMK4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0FTtptNl37/yIquixgot6fTwCuWu+750aelQxAe/lbVg2Ud31F2wdMd2z+WQYb+OoVpBMAcqt8QPhEsreZ1cShalpTGIk916MMIT7kUsfM2YDtKUUiBxy4g5zGiFCZO3UEVHgOmzI3xMYHhIyrFfWPy4x06AC/39/ahTJrAXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz9+S5KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6773C19425;
	Wed, 29 Apr 2026 21:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499306;
	bh=mGy1kcuJD9cmVfkG57MXxrakB2Cp+mC6iLjN0PrMK4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gz9+S5KRt/epHBS7gjdC+j77SmIJn39/kqwkO/AdrK3Mij2se/0QPBnrpEdjzIEtG
	 QecwCLwQibsEURv+R2kec56fXCAmX33pcOl6LsCSrEHIhhfFp4PcJXTk4JYVAjoQgu
	 HHD7+pnkNvpmWiT3Nafnv/ZAQG1L3edov1c1n89yhGmFS0WZaDwM/nUOpwNbqJl7ga
	 A9n06f8B7YMonlAzFzayY00CIZP3L8Mh4ebB8KC1fOjnSuK/Cnp56ttQUcCLJ+gVQ1
	 EXPqfSA5/py8gXsX3AGOFAADKNDOmKE5GTwz7EzjhcTESy9HU7f6Ga5inBnbWvhniq
	 RgJUNIDV2WiNQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 29 Apr 2026 17:48:10 -0400
Subject: [PATCH net-next v9 3/5] tls: Factor tls_strp_msg_release() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-tls-read-sock-v9-3-39e71aa7810f@oracle.com>
References: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
In-Reply-To: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2254;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=jrZruHoO5Zq3PFApGUlR5dlEKELnPPeSue6kxU4zJhY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8nym/oWKzAS2JDZ4voV1ytM8yxqJXd6xm7xMf
 MrdL9ntmGyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJ8pgAKCRAzarMzb2Z/
 l2/3D/9UBw/CFYFc3kXphok47b6kGYqIZSKlIK7KMqUb5HyXXivvFQif6q+VazbbqrNA+RuH2fw
 yDBq6ePKIb2yEq6Q4hD3k10JVm39VUKyovrys4TNzDLqP+JEtE04EfliLC27L1UGddJHGRnQSvs
 VOVzqr2Tem+uVLyM027qU9HI5rpAkQ6jZx2+tcy2+o/9XlcEfmpnHjFGvl8jR9nOwSDNhlh1lAR
 ZenYNSxqcPunfIwbP0TBtodQ8DYI6W03S0xhfQYe2SoHWLrrUwpz3CqbJZxkc48HWc895G/Qb0X
 k6L9daR8WlmVSH7gH9FZV+jUV+DhfchlylQGcx6cH02G0mdkugvSezsv0RkouiJbbTsTrcRc5Ze
 z09YMqBOPbIeQ+vMwafmnAbzG99pTVMzHu8LYi0uDODYvWlW1autEQxe+9rcNWS0UqwDsMRu2sx
 KE2gIjCgxiDPWvE9vrlsnEGY97YbZhTZ5ONdl+otZB5Eyts+PEw570QmOadZLfuvwpw8RcW0Yqq
 J933/hHo8W1BmLg5wvH8F77gb2n4LQzGX12FYkpy1nxHwypx5M63dTNz5zrN39ot203UFtSIHGH
 LUfAREzMsVRYDbwg7Zz74x/c/eZdlScBDEhUAqcIn0uIWCTQtl3IET8cnTRp3NYjCaKycAWNJsP
 fkra71FFkmBI09w==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 191C949AB59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282511-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email,wdc.com:email,queasysnail.net:email]

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


