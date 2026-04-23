Return-Path: <netdev+bounces-280686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO0lC4Hq6Wm2nAIAu9opvQ
	(envelope-from <netdev+bounces-280686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:46:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8610E44FF5F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 11:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809493062A01
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EBF3DEAEB;
	Thu, 23 Apr 2026 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="e1zbgTtU"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5630E0FC;
	Thu, 23 Apr 2026 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937325; cv=none; b=arm2Nki4naTkPpjikwAxH/BblUVP6K/VYoRt0a4+EQ0wNsKv4YPKhKegqc65Aa/V/7Wqsx1WzQV6/VqS9lWNd/I1ng4TszKJCXfNdOp/PaXOxfEgj9nr0TRJO+Hg0HNouNYBtsKsjxuB5Nfa7YUqL99DhApWtqM1iymRdFOQnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937325; c=relaxed/simple;
	bh=K5B6h4jvOiXBaWEGJSipw8rdkAyiWR8VvMpAMbbdZ4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nn1UFpAl2LcBr4PYNkvHqIu5NTJf+Sj7P1U88cf/zKhD06z/max8y6AhuwmvuuLQPKbsvwmID24rvKk1uKR/9Ow4PUBqjbpQpTLKM2cWxIgqgP73iPaeu1D4MxTJpkTnIgp2FpIBmUndWUWdx8qMNK8goo9h9V60zu4+SZTk43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=e1zbgTtU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=qXCF0aavFFfE7ZlB5FKgkFDGknSyAsoXeEFzlSWap9U=; b=e1zbgTtU1uJNsx2PoECYAQm3tZ
	83C5LtvF4AuHEtq5W8xCZRcgWEfGEmCPSAQGLFFt5Jd16La7zm74JLjYaO2+sTEDJZjS8vnUMn2Vp
	j9IGBkLQGa6rUQl/Fhov5Ahwa5THvINIsib3DCeBlgOm0/8HrZjPt9J5Z7JJpsoRti0hdKJswClXU
	e8eTLbM1xvgpTrfAtgXBG8gTBoXcvOUSywMuPiqd0ezHAL4cvUt19yikY1FkgeAgmDqCiTEt5fHhT
	VzRfT/Gf6Ms5m0QIRwtuzOKjltxxdrZUNJZ2gZyHGMF9su6nTbBLzkve6vHyWvAlGhDbjLZ/kwNWG
	vjCcm6dw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wFqZL-002J42-2N;
	Thu, 23 Apr 2026 09:42:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 23 Apr 2026 02:41:17 -0700
Subject: [PATCH net 3/3] netconsole: propagate device name truncation in
 dev_name_store()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-netconsole_ai_fixes-v1-3-92b8b7de9a2c@debian.org>
References: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
In-Reply-To: <20260423-netconsole_ai_fixes-v1-0-92b8b7de9a2c@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513; i=leitao@debian.org;
 h=from:subject:message-id; bh=K5B6h4jvOiXBaWEGJSipw8rdkAyiWR8VvMpAMbbdZ4Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp6elUetzZ8CzyoTUYC2mh7clo6ll4UXOqRuleB
 2Dwg8tV3meJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaenpVAAKCRA1o5Of/Hh3
 bTXKD/4nF7/gdUvbsPWHHwLqiOf99DuX+WYvJhAfoFnxPW+XOWSQLkiTWYvvzjb00HV5O9nXgFQ
 pizFwZqGPimGOhykkexrm3sHp8D7Lol4/loulnMuuKfii64kGw2spGFQRfj86OGCpZgp1JxbuTJ
 UXA9a3C77QV509mZPPN6Wx4tXdU39QOU9u2VGcIDasav2LZm6Rwb4LDdK4HG/2vRRfoTawvOB12
 p6lpQrlOulDaI2Ugmb21fQBEk5oFG8T+r2YwEnQJY4ElmeARMnszVsXgQqOrpQQ8HcWqaNKcKoJ
 CzjMJanBjjT661yy96jYE6T4fNs8nQ5h5yZDv9IcnsATJQYKcZtt+SprTDTFpcbvw0EO/DSKVWP
 J9D2lcdFmizD939FFtrPtyGQRJLbfFS/U65WigyIWCcwTUxXGLAla7S64mRBvf82CfMA0sS/msI
 RVposd7/WnUGFFSgvsYP44oO2gw39QWyQ3swIJ48yr+9z/DStI91qptnxdamCJmDogmErYZJOAN
 lfhyb00JlIU9GQXotACdJZ0/IR3z8W7GvK7FpmHsFvaxvD0hAR4STh+ZQza+vx6PwovQhy9AyUi
 CZohUyEDhjqtt5HaCxfXqUIzSrXzWR4/fxKOs94YckpDqgWnZ1n5WhBZXoZfNt4QwP+IDh6uMBl
 Bj9LrWJ8ixU+LRg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bx.jp.nec.com,infradead.org,linux-foundation.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280686-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8610E44FF5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dev_name_store() calls strscpy(nt->np.dev_name, buf, IFNAMSIZ) without
checking the return value. If userspace writes an interface name longer
than IFNAMSIZ - 1, strscpy() silently truncates and returns -E2BIG, but
the function ignores it and reports a fully successful write back to
userspace.

If a real interface happens to match the truncated name, netconsole will
bind to the wrong device on the next enable, sending kernel logs and
panic output to an unintended network segment with no indication to
userspace that anything was rewritten.

Reject writes whose length cannot fit in nt->np.dev_name up front:

	if (count >= IFNAMSIZ)
		return -ENAMETOOLONG;

This is not a big deal of a problem, but, it is still the correct
approach.

Fixes: 0bcc1816188e57 ("[NET] netconsole: Support dynamic reconfiguration using configfs")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 4bef003d9df64..3914fb90f9afd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -816,6 +816,9 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 
+	if (count >= IFNAMSIZ)
+		return -ENAMETOOLONG;
+
 	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",

-- 
2.52.0


