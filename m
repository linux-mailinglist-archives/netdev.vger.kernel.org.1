Return-Path: <netdev+bounces-276277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEkAOZbY1Wlo+gcAu9opvQ
	(envelope-from <netdev+bounces-276277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 06:24:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159843B6BBD
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 06:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B64E301080B
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 04:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804F34D915;
	Wed,  8 Apr 2026 04:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGcnwAf3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C663019BA
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775622284; cv=none; b=gifs7wTUd83L6LdmWIJCbtbg2SUJDeEx9FRBPqaXBIEaXpEko+QPrbERrYxXsfL91RHmbL+dj1oKmKq3UOp78jDeig5gzewa8D5uT3n3whkAS8gJKwvKhgXoZjm//3e6WraWsPjoZrco+6uFEgtq5m4leoRgT/0y2SEUMnih92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775622284; c=relaxed/simple;
	bh=GJKMVETSDrkUzIUb3FcAj0CzYf7hahpuCpzS1v8Qvl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mtuC8dvK+c3kHJtnXwDCl124J0dTS6V1gvsBfvx3+z8lNJlwJDfR7diKf9x4PcmmPR6CS7lJbHcHNM0ChGXRwnn8zCS53DqIfuR4yGbXPh5ZauUN8rokci4xfcryMkslNbLi0Wv5G1UhqZOb6ZbHIfGq1An8UPROllSq1AbHWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGcnwAf3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so3792305a12.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 21:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775622282; x=1776227082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eqmEdkwfgVOE9RljrpN82ejevmAUygMZ1xKqFBwMsdw=;
        b=HGcnwAf3//74eHRuCUrwE+p4ot9su5hRE/ViVwiaFp3Xa6qFcVLu+34n9RvsSMSqle
         8sA32ahnj/tQj2oO4Mq7iiATthkdF8eQB65eo9uRtTsxWjtdcbo5Co3+oqFKSwVwHvQa
         c9vYK+Mek51atFw8OrZsXCf743kXjHxqp/kpQva6lDSlMSVcWKLteWtRwOW0DFbnGOSj
         Xn96/QUvth6yRIbXAgZUO6T0XcvhMkuCACaZW6ZNx3HFr905e8GtCSxAGyvE1aNXQGJQ
         fkxQsW3HYd+VwDfPGEylIdYR1KK6J1EKXnLlNJNy7UCjpgDqWt4xyylVHBi6JlEZ9ei3
         mY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775622282; x=1776227082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqmEdkwfgVOE9RljrpN82ejevmAUygMZ1xKqFBwMsdw=;
        b=dRHJx71aCWxcdvEYpoCBaR0vVJCvbhr4MfpB3LFzrk3bp+idsJ+YbxE9H73T8bmoJA
         LOBereDJYG05YnmexOL5Sc4Wx+rDDYUSPkHT6IAWkVOEMuouzukJwe2BRVUQU+R1ntk4
         QAC43gda6w1n4ueWK9mKDHH4yz4weaMzUxivBke6X+Tt8Ogk1SXq2CQwFcQKPeCqN0RZ
         XJ/Z67eSnBMLNHDVGUvf5HawwhYnxj1ZcczuY5MmV9ffQjpCzOIc9py0Gn709b39IT5H
         9fGk54iYxsWVijPQUX6KGvslNY4fwJK4IxstALwT012dRA+OhYj/Tohym8GuHLjHgnAQ
         eRFQ==
X-Gm-Message-State: AOJu0YzGais/rm7OFhC41xfv/olBj/AST++9HAZmLj6LRWLO4bjhuEGQ
	dyYYgyZLpy3q0VV5BBkdFRcE5nO63qMLwgdf7h+AiX4Mv1DYV5+FcYpUMIyJjf7M
X-Gm-Gg: AeBDiethAgSbXgCti/w0BDYUJl/AzJaJBDdOLErnOJQE3KRrFHpp88cHOqPpN0VjxZr
	BksnxY+28iYEwhppDG0WNDsdxBzSC3/UcrYD+/ARlVKnE3Jaze/+VIbGTxJ+n9XEpVTOdkhpwfy
	zCRobVVrIV5wTBIS363B+4L0nhTsKGFFdNm/pSSFcpsip6hGyZE1M7R5LqvcNJbwqE+Obv7usim
	brlhiV7d0YLkh7knpiJyYEMek6VGL2PNbPc/1piUAfZXLjXaPdEG07uIKXU1tp5B6goKzhioekr
	DhcCFXCvJe0hqAA3kdmJY12WvSm/p6kCH91reIP0TA3bVxYs57I1UyiPz4YPkA3mm6v6TkxQaP2
	CCcdRPOqN4duckTmdl1cqjJDOhxeMHicn0EfrbfLWs77z2zzwTnnw0du1nSsnN8Ou4E1aXJuvTf
	wTLl4GfFPxclfEFrDyZ2jeeQaayB+xou8EFUOgkMrjjcs8K85z
X-Received: by 2002:a05:6a20:12cd:b0:398:a1ca:7a2a with SMTP id adf61e73a8af0-39f2f0ff7d9mr20959180637.48.1775622281575;
        Tue, 07 Apr 2026 21:24:41 -0700 (PDT)
Received: from dbdd95a60758.tailf10b76.ts.net ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65812f4sm17363258a12.25.2026.04.07.21.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 21:24:40 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-ppp@vger.kernel.org,
	qingfang.deng@linux.dev,
	gnault@redhat.com,
	jaco@uls.co.za,
	richardbgobert@gmail.com,
	ericwouds@gmail.com,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH] ppp: require CAP_NET_ADMIN in target netns for unattached ioctls
Date: Wed,  8 Apr 2026 13:23:45 +0900
Message-ID: <20260408042345.1011-1-hataegu0826@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,redhat.com,uls.co.za,gmail.com];
	TAGGED_FROM(0.00)[bounces-276277-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 159843B6BBD
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
Reported-by: Taegu Ha <hataegu0826@gmail.com>
Signed-off-by: Taegu Ha <hataegu0826@gmail.com>
---
 drivers/net/ppp/ppp_generic.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index e9b41777be80..99a8557188c0 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1059,6 +1059,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 
 	switch (cmd) {
 	case PPPIOCNEWUNIT:
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+
 		/* Create a new ppp unit */
 		if (get_user(unit, p))
 			break;
@@ -1073,6 +1076,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 		break;
 
 	case PPPIOCATTACH:
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+
 		/* Attach to an existing ppp unit */
 		if (get_user(unit, p))
 			break;
@@ -1089,6 +1095,9 @@ static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 		break;
 
 	case PPPIOCATTCHAN:
+		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+			return -EPERM;
+
 		if (get_user(unit, p))
 			break;
 		err = -ENXIO;
-- 
2.43.0


