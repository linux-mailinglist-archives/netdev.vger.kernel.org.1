Return-Path: <netdev+bounces-281383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LbGHHlz72kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0783C4746C9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D3E8300C0E9
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071DD282F30;
	Mon, 27 Apr 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eEIHxUV8"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEC62C0F75;
	Mon, 27 Apr 2026 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300270; cv=none; b=MoU6rpxDNd1jpvSfxwMtfvglOy8rxmqaPEVuGd1vAw/YQcZbjWeZLn1nOLmgL7r9tVyzva+59jNiUmsv9x7Bul9JtB1mI1LSuiOWHBWwAroOEqIt6yksC6UZeEfKRaSmWW9zpRzpm/Z7hkqwtwTss7DkqEQj0Lu/Ob8PJJHsag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300270; c=relaxed/simple;
	bh=EQtgOJ5IHiKp+IAO11NZ8ST4+IXE+twkle0BsyIVcWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kiq5rAfvKb4ogI/CoT+X5J6vMgy9jP4olqE0pdgoi0mSEIg1zk1HWs/6VVqz9tPDJ3WyMFO5NQVdcYGVSvrfbfOuwmMeLq1RgvStieY1Xzd92Z/XkYLzGXZcfxdujosFwTxHOpV8A61arduv961ZmWFpmXIgBEWe+1OcC1ALCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eEIHxUV8; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=hWVr3gs672tukeyy0Zsxw/jNhU8JNzM+TBCpGKY/YI8=; b=eEIHxUV8MtYAhhzOxMH2Fw2S21
	4ou1wxlcmeGH7RiBSt7YArf8NRh3Xv8+NBL9mRN2LvgPomDVqXbyE9/ddheqMftj1kDMGiiPoLfqJ
	j4p9DBHiWTM2LMcFEuF7dLedAXlz8HW7Wm+hEV2Six+WK11r4ki85KP2wL0bdTW0pcUVj8wbregGw
	fskaFw19lZcktai6zQ969+Jcr3uGrmisU/FEiGlrKhpKVKumcw6WtZqZbQGdHlMsLBecu0HnfRbrq
	e0tzV3jlo9Sj3b/3idZUiYFhMpqq0GaLnOesIsU+oF1VZHpQudlW20CDf3G0Nwm9E72wX2TnzY0c0
	ep++J3mw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHMzL-005XxP-15;
	Mon, 27 Apr 2026 14:31:07 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Apr 2026 07:30:38 -0700
Subject: [PATCH net v2 4/4] netconsole: restore userdatum value on
 update_userdata() failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-netconsole_ai_fixes-v2-4-59965f29d9cc@debian.org>
References: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
In-Reply-To: <20260427-netconsole_ai_fixes-v2-0-59965f29d9cc@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Keiichi Kii <k-keiichi@bx.jp.nec.com>, Satyam Sharma <satyam@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wood <thepacketgeek@gmail.com>, asantostc@gmail.com, 
 gustavold@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2450; i=leitao@debian.org;
 h=from:subject:message-id; bh=EQtgOJ5IHiKp+IAO11NZ8ST4+IXE+twkle0BsyIVcWU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp73MS9mmTIYHP8vc5QV5Voz0rA5K4AfRwDpbfP
 d2hUob1rEeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCae9zEgAKCRA1o5Of/Hh3
 bQ4QEACNKjzMdA48Sy9nzothEqkBmSdmG705YUP6JBnogkO+Excb+BOfO8C5iWU3AzlbZ5946Wj
 hbAt+QN1efNAPgY9aQNJ4aoCXUgUYv+3YpR3DiOYD7sMlfzRaInuPNIiGuldTQvWeksEyP2t8Xa
 jFx5drMFN13al9LmWxtHeAOBkbo9caV/nwaDTSdD6MN1KK/qzUd8aESHLmoyd9f5zJBsDXRHK3I
 ffnbC8Facbm0hrfsAhKjHsmJAYPwZnnF/ziXNQXYhpI8bmJNfov9uJsz6ISfgvio5Bgrz+UulFl
 sClETnBZRwR0iOPq6UT6ZD7OmfR9iSrf2rxWd8o14mXLDZoNZFPZoah+SVGqT5Of55q0Bdc8Ejp
 BAF4huJgfyzB0kUPoq+kojigVuUakva7lx+J1DAtBHVPOvtEhhXLRzVDdE35OjegqtzNkfLAS9l
 wSjKEudcvYgNRt/7LNUpb2kSB5oJe3siFoJpDnZzZGlGC04cECH0YXM6IJImcug5w8Sy4yrNgZn
 y8gTfXOpUaJ+k8ZqCysjd9L3oUtoTZjUDHnSIiFEWsN3s5bKaYSFkx65atCfeYPj2Wq7lX+x/s9
 N6vMvPLkPQqaYFp8idwWn5sHT2M/MdBDQaaByv0apEh4+FRgVIKST9IuS7hazHlXse4fRgoH3dF
 +Pw0tslNfZM9kww==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 0783C4746C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281383-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

userdatum_value_store() updates udm->value first and only then calls
update_userdata() to rebuild the on-the-wire payload. If
update_userdata() fails (e.g. -ENOMEM from kmalloc), the function
returns the error to userspace, but udm->value already holds the new
string while the live nt->userdata buffer still reflects the old one.

The next successful write to any sibling userdatum on the same target
will call update_userdata() again, which walks every entry and packs
the now-stale udm->value into the payload. The failed write is thus
silently activated later, with no indication to userspace that the
value it tried to set was rejected.

Snapshot the previous value before overwriting udm->value and restore
it if update_userdata() fails so the visible state and the active
payload stay consistent.

Fixes: eb83801af2dc ("netconsole: Dynamic allocation of userdata buffer")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b3b36e3ddd03d..57dd6821a8aa9 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1079,6 +1079,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 				     size_t count)
 {
 	struct userdatum *udm = to_userdatum(item);
+	char old_value[MAX_EXTRADATA_VALUE_LEN];
 	struct netconsole_target *nt;
 	struct userdata *ud;
 	ssize_t ret;
@@ -1088,6 +1089,8 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 
 	mutex_lock(&netconsole_subsys.su_mutex);
 	dynamic_netconsole_mutex_lock();
+	/* Snapshot for rollback if update_userdata() fails below */
+	strscpy(old_value, udm->value, sizeof(old_value));
 	/* count is bounded above, so strscpy() cannot truncate here */
 	strscpy(udm->value, buf, sizeof(udm->value));
 	trim_newline(udm->value, sizeof(udm->value));
@@ -1095,8 +1098,11 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	ud = to_userdata(item->ci_parent);
 	nt = userdata_to_target(ud);
 	ret = update_userdata(nt);
-	if (ret < 0)
+	if (ret < 0) {
+		/* Restore the previous value so it matches the live payload */
+		strscpy(udm->value, old_value, sizeof(udm->value));
 		goto out_unlock;
+	}
 	ret = count;
 out_unlock:
 	dynamic_netconsole_mutex_unlock();

-- 
2.52.0


