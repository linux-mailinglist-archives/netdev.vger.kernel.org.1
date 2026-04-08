Return-Path: <netdev+bounces-276300-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ELdAhv71Wn4/gcAu9opvQ
	(envelope-from <netdev+bounces-276300-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:52:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AABC3B7BF3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 08:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCBA301174F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE90835F5E7;
	Wed,  8 Apr 2026 06:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLB1ZoSv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96B2222AC
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631124; cv=none; b=cEyYZqtUnDjPSrZskCiVMubM1j0ngrdUmLfVVtpXM2kZPwoBfnRecsLyByqKkx7sizGt5meQ5e42+GtqlzCFMLm2JT9P4UoQkI/aFm7J6ykCTdbzzXCWihSQGgM6q237cBIyM9ZoOSh8ZfmdmkaYd6XK1WPfwZ9dMg+WnhU4duo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631124; c=relaxed/simple;
	bh=ZhJ2C4i05VJJKYKlWpoOsC5SBwrL02o4l4S63ok/n4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gnuk4UzCzEruFx5aRCHBK1AqZlGFrE5i6Oj4lQczCE84nwrgTOKzIe6cr6dupi6gCK7kJRIMnfktz029Z9MZmDPGp4vwpLrvbERqj5Fhzkhpg17rG3rko1PjNVvruDw/osYX0wFMNn4v0lUTm2sVToqS6jhAmZP6CKaKTvrY9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLB1ZoSv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c76b9efc299so2440456a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775631123; x=1776235923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEuFyu9HReY6kQnHy14CWxk4PsZgUkyDSOCBp7sb1MQ=;
        b=iLB1ZoSvGUy07wclc6dYXGHXd+v5m+VLF0lkiZuq3V55FZzn8sLidpYwfHqaVpZuQa
         LyrDdEhw6paYotoJFCxgpUWi87YLE6TxDg1lkw7BE/QhwDpzE4sm5/2q33rs93xG9otd
         MWjL4HGaVvJmlhUzRtmNhRpMxTHmesML3JVR70vOYz0xY3ofouwDqX8u/6HFwvlX6zSq
         pOpUSI6nubTBlY9DciSo3BJ9M8RaC4fWtRcRWZqVOFArenIfv9YXtx09pvv50IYMz+cK
         88DXyQ+FgvGP9OJZSBKEdsRwm1M1ZuBgOsM2e6sh+ndTVHTeA9mKAyunXyyJk8zKa6B7
         txwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775631123; x=1776235923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oEuFyu9HReY6kQnHy14CWxk4PsZgUkyDSOCBp7sb1MQ=;
        b=iNi2CK+nWVh7uWKOwfbrxhry4OcNuDer9ivBfHPtGfisG5SCpJhkI6xI98EsVqeZ8a
         5lFwcE0BF7EYPLRoDMkjUBgmCicqe8FhMQ5eisS7eKifqyjBG242TlPkdMttEttPwjgq
         0ZkCVp2a8rziGlXncRzYzVdNtHr87/WcWNcv+ZYoSfW/BqTNxS/4yGTaSYSXcrVQAiqN
         zQunZaa1Zs0I145O8CCE/hL4GYFzkJtexGEn7njuP5j6u67fVyGGnp0/HfyTK7+80b0W
         HT5EX65PJfTtM4uzqurIqg3bqYn6j7DfkPistZOyyCeIbpG1g4NP6GvzreJ20GPcmV3w
         F3mA==
X-Gm-Message-State: AOJu0YxtUfhlGhl7C46wV5kIEofLcV1ArbzFrJRGGsPGIGwBzcNA8kOE
	eBZ7DHRmD5e7akYRBbj8v+Bw0hx8H4iZnRVEHBP/6mMIi8q0mru0ut7RsXzWhc14
X-Gm-Gg: AeBDiesDIggennboeUE3jUq0fbByexTrYAQAuvFlMoTkuZuAha19Rs+l0GgZoGEHhNt
	KDg1sTKMvO0c/02YVu93jCRouyfh4ZihqzS6EB3O8sDw+lrGm2C8OcE5ylyvNILjbz5Piiy7q5L
	CQeuyQ3kym99mWCn2g7/eATQRzd6bysO8K2+ZmKMSlopSG40u3yeZOc58NF11aSkRZib7eBjxwu
	9GNMJcp5Z28eoBI8RDr0XNkKVuR9OXfgdLo+yDraBEr0GJm57gYFxkOD3H4qJwKYIFfZ4GkdgPZ
	1yhvWiQbZFNkET19dBr4U3euTP+Ix/pKVNHXe2jKflJmZsYT0lx+jshpGANu7X3mG+W6SzgeoPS
	G2Z5n4BdFHhUyJgew6+agkwEZrphpHpAH1EqfXWDG/ZDtUcnI0FA+v3GLZ2waQCv4jbN++s5i7M
	qsMFJ8k1+TlhD6Jxu+xCqquAeFipD6/Fjd0NRq6tZuWdFLeFJd
X-Received: by 2002:a05:6a20:7346:b0:35d:5d40:6d79 with SMTP id adf61e73a8af0-39f2edaaa55mr22041288637.12.1775631122694;
        Tue, 07 Apr 2026 23:52:02 -0700 (PDT)
Received: from dbdd95a60758.tailf10b76.ts.net ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563aacsm18076671a12.19.2026.04.07.23.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 23:52:01 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-ppp@vger.kernel.org,
	qingfang.deng@linux.dev,
	gnault@redhat.com,
	jaco@uls.co.za,
	richardbgobert@gmail.com,
	ericwouds@gmail.com,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH net v2] ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
Date: Wed,  8 Apr 2026 15:51:09 +0900
Message-ID: <20260408065109.2171-1-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,redhat.com,uls.co.za,gmail.com];
	TAGGED_FROM(0.00)[bounces-276300-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hataegu0826@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AABC3B7BF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

/dev/ppp open is currently authorized against file->f_cred->user_ns,
while unattached administrative ioctls operate on current->nsproxy->net_ns.

As a result, a local unprivileged user can create a new user namespace
with CLONE_NEWUSER, gain CAP_NET_ADMIN only in that new user namespace,
and still issue PPPIOCNEWUNIT, PPPIOCATTACH, or PPPIOCATTCHAN against
an inherited network namespace.

Require CAP_NET_ADMIN in the user namespace that owns the target network
namespace before handling these unattached PPP administrative ioctls.

This preserves normal pppd operation in the network namespace it is
actually privileged in, while rejecting the userns-only inherited-netns
case.

Fixes: 273ec51dd7ce ("net: ppp_generic - introduce net-namespace functionality v2")
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
---
 drivers/net/ppp/ppp_generic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index e9b41777be80..4435c594f587 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1057,6 +1057,12 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 	struct ppp_net *pn;
 	int __user *p = (int __user *)arg;
 
+	if ((cmd == PPPIOCNEWUNIT ||
+	     cmd == PPPIOCATTACH ||
+	     cmd == PPPIOCATTCHAN) &&
+	    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return -EPERM;
+
 	switch (cmd) {
 	case PPPIOCNEWUNIT:
 		/* Create a new ppp unit */
-- 
2.43.0


