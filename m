Return-Path: <netdev+bounces-281381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDc4DQp072kcBgEAu9opvQ
	(envelope-from <netdev+bounces-281381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:34:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE7D47474C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8E5F301491C
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 14:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B8283C82;
	Mon, 27 Apr 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RL9hFqx5"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27757282F1F;
	Mon, 27 Apr 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300262; cv=none; b=nARkeze7xahyDKATOGAFBXQHsteqnpL8JS2geLVRLIp3XEDD2Ij01O0UYDDBByOBA0nYy1nrTIvHjHA5K0i3+5iMV2xf8+179qCH3wLMXQrGj3jkf4BE4PpGCLh/crYR4pSWfqURKaMQFw1q4IncyBA0CVzrA+sozT942V4Hm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300262; c=relaxed/simple;
	bh=KodAU0o/aW0JCiBZcsROyi5m2eOF+XjRMGBypL+/zD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pm6iwuAvwQcZgh5p6GRkOTLl1EEXDQZQ7aDnSNzxWvkQ97la38GqbpXh/M01mLm/A6mnrqtbxqXz+y+EuWJddzSpxjdloQNBmPHwBbl+nBWHfqJIJoqomCK7p31qlk011tv9pl5zWDRXcKu2ZMAL30LPl74LvQBD6zvN9QJC8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RL9hFqx5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=j0xnknkesHHx8SV+c+ZI5NY+iZi0FGFf3mY5i0W0UW4=; b=RL9hFqx5piroLnJXixEK2PB7YO
	uceTmWSu5wvamHi4+tnkiWS5mSUmT/BgfhLhMK7P9t7lI8qG2FBmvPj5h25klLhumJKhdWkoDRPLN
	kZZ7BfIZIY0ZVMl+73smVv6RObS2D660PfWyFcVXMJtkyN+T9Ox652nxxyzjw2EanRPPS+K2KXQQ0
	BVhIfI3X579885kq5CbB4UjDFc6PMiPVNHaPbQXnyqJpq/9+Fm3vqAPI+fMopQrEeTLwjPwBfs7lv
	QrZWVlr1cONSCxWxZSq9XRiBzJvhGjXLWxnZfNE88c/wzVXjVUQZJM+RsqhJJN3ZADYZiVqjellIj
	RO3d6FMA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wHMzC-005Xwx-0m;
	Mon, 27 Apr 2026 14:30:58 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 27 Apr 2026 07:30:36 -0700
Subject: [PATCH net v2 2/4] netconsole: avoid clobbering userdatum value on
 truncated write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-netconsole_ai_fixes-v2-2-59965f29d9cc@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2347; i=leitao@debian.org;
 h=from:subject:message-id; bh=KodAU0o/aW0JCiBZcsROyi5m2eOF+XjRMGBypL+/zD0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp73MS1rz3v3CK0J4q7uWpLFO0EIiyB72ZJ4yyL
 RtswfSIWZqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCae9zEgAKCRA1o5Of/Hh3
 berLD/94YtC0AXkMBmRO4Adv1No23X90jb3eDdVmgExuTXjsCI0MiQePRoqyxQA5NjbI2jEwSyf
 Z59wKpU54dJ9WYWyXuVwse74PMzF+T7a6mOsB50GPFb4FJngPWgYSW21rZl/87qRvfmqaTSnO7f
 VbsUzp/raE4/JcCb96Vy69uMF1qeF8TB4IPyF0LSRT4sevSKzwq6AMR1nKOgNkSH/Zyg3SlTj4+
 tP1IvJzaQhJNNRfZDDZePlJXaPxNa7pJr5oa4/0NDqS7VakUZyl4zfRPSoET8xc2kTLDCMFs/wg
 F1WTm8KcDx6jWLCL/0xqtHHFpINfI5cbtfX9djVD8obBaWttv0yQUudXcGlVPTMH8Omz2Y5aQRE
 e7If274l2DNf9z/WuQIF3CX9Rw1mxBSBYlFmwZxWruwg5oQWOliakpAMHIi68NZFb4fRB9pm2nU
 GCCpFG38GWC/roCOW62bMMy2qKNddyOZzRSybUUMIh6pXfNx7z8rkgvvRekrOj/LaJmPxfXxnIQ
 HDmKbsKRen4Frv9YQrrZ7YI0/dzLaiUTL0W9AUc3ayOsWaUCJCKXGOLALINrG/gBsc8RaAOvIek
 h2UwmneTgKBsxU1EwEJDkhWTz0YvhP1Dzb10p+J6D8F8NyRZPotx9k5TNkeZNHKadAxVmD84roD
 YJYjZJLo5xqkq+g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 3CE7D47474C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281381-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

userdatum_value_store() bounds count by MAX_EXTRADATA_VALUE_LEN (200)
and then copies straight into udm->value, which is itself 200 bytes:

	if (count > MAX_EXTRADATA_VALUE_LEN)
		return -EMSGSIZE;
	...
	ret = strscpy(udm->value, buf, sizeof(udm->value));
	if (ret < 0)
		goto out_unlock;

If userspace writes exactly MAX_EXTRADATA_VALUE_LEN bytes with no NUL
within them, strscpy() copies 199 bytes plus a NUL into udm->value and
returns -E2BIG. The function jumps to out_unlock and reports the error
to userspace, but udm->value has already been overwritten with the
truncated string and update_userdata() is skipped, so the corruption
is not yet visible on the wire.

The next successful write to any userdatum entry under the same target
calls update_userdata(), which packs udm->value into the active
netconsole payload. From that point on, every netconsole message
carries the silently truncated value, and userspace has no indication
that a previous, error-returning write left state behind.

Tighten the entry check from "count > MAX_EXTRADATA_VALUE_LEN" to
"count >= MAX_EXTRADATA_VALUE_LEN". With count strictly less than
sizeof(udm->value), strscpy() can no longer return -E2BIG here, so
the corrupting truncation path is removed entirely.

Fixes: 8a6d5fec6c7f ("net: netconsole: add a userdata config_group member to netconsole_target")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 76d7fbf9e1883..595e09bd1ccfc 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1076,15 +1076,13 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	struct userdata *ud;
 	ssize_t ret;
 
-	if (count > MAX_EXTRADATA_VALUE_LEN)
+	if (count >= MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
 	mutex_lock(&netconsole_subsys.su_mutex);
 	dynamic_netconsole_mutex_lock();
-
-	ret = strscpy(udm->value, buf, sizeof(udm->value));
-	if (ret < 0)
-		goto out_unlock;
+	/* count is bounded above, so strscpy() cannot truncate here */
+	strscpy(udm->value, buf, sizeof(udm->value));
 	trim_newline(udm->value, sizeof(udm->value));
 
 	ud = to_userdata(item->ci_parent);

-- 
2.52.0


