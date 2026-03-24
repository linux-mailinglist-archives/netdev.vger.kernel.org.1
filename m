Return-Path: <netdev+bounces-271132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNVNE1WwwmmRkwQAu9opvQ
	(envelope-from <netdev+bounces-271132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:40:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E806531838E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11DEA3087585
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F334070F4;
	Tue, 24 Mar 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKuaYiRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF83D4135
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366247; cv=none; b=SaSdGIxrYPNu5o4xmW80Zdwnsfa4JBELQNAwiw+8MDFgRnJUGVSyoi9Ky4MI+waIlScXo+ZlVWcgKLY/5QOycDkunsxgMHaS5p+GloaIihpqGNiQbb6xhnn1SsGsLmusgtxAC1qNc8BDEeMGVBTy4gJL4lMM5TQsxC32ZbY1/6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366247; c=relaxed/simple;
	bh=qAMA6Cx9mPQhYM79N+NXd1PhapKY6/Vo4PUKqwiUNQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuDnwLAMPB+5wiIgqFN7RNquJaxRUgEH58nQISKMgz7q9zOnkZeZhPmrcs+ko3SIKL2Z9QDHsnrmhlrIkL3yK8Xvapy9Z4Sl/fzpafr6PSAbRgJPXWeCfvEX1KDuwr7rtVfySn46kaP01awh6jwXx5dopOwIVrgnhEzA+jju8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tKuaYiRk; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-127380532eeso2671376c88.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 08:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774366246; x=1774971046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a51ClirKzzDenotId8TaR0Ai/wpNXRaf05Y+a91QSjg=;
        b=tKuaYiRk+cxcCX6z0Qlv9X3Izs3U7aB5/7JdtX6m1M0bcx7my0viXz1yXOtX/ZYmDp
         bVgAtpRdHGjba7Rr7zydc8KAp1FRmBhVd1orwr8j5IkvrnBMXt/+HiwgLMr5kWYpLQMO
         uPwePo9O2ZAkxi5xfa8SjFhdR2MAIz4fcoz/6l4R0DZqsdHMwnWYMNq+8tegl8A5P6DB
         1WL+D0wcXUQRFAd1KZOtYk/TtDBjDTtpCddO1mA+/gIU4nThXlLKOyKu0IDPXvIj42gQ
         F9KzIUa39GNTaerYMrqbM/07xLj/YOEakeFvPN4x142z4tP4F3RJz4MVEbeniCucmryH
         yBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774366246; x=1774971046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a51ClirKzzDenotId8TaR0Ai/wpNXRaf05Y+a91QSjg=;
        b=PMxvo4k1OjouxUnpP0iTgurfG4JwWkSt4KuVuVGRNYXrAiJUi22AJVa94CI0rcZ4cd
         qsTWPf6qSybNbecLRCGDsHqVKwDjYulSTvxXFjotfsnZZmZYvjLnb9Zavu3VLGw85XPd
         mX/xAyBcvLWpiIAkvb5bWsPpEnkJIfxFqS3Su8bmV6pXpw4Licq9XAWSox2kr6QlUJ4t
         /SKndoCVloGbmdSWElGvTK7mScWzylNt0GXJTZmzVwIX5mzrHiLDOG27tkTAuFX/pQXO
         qv1txdnRwlEB0lWcUjt+rbh7vj8FbsQnp/kCIWd/UvnanHbY+Z5Mq5uybkU4HiuR4L8p
         eSXA==
X-Gm-Message-State: AOJu0Yy9BbRo0pbL77MCnbbUi5Kn6kpl0YOQ1eRDISSAftJ0bjePXrWH
	Kxuqfo+83KSxX0u3mtjehYiolyB/NtnTDnBDMA/oJdYdP44qIvM9rmpv
X-Gm-Gg: ATEYQzw2I9/4yAg5qMNjkSN8Zv62wZnZIDMZmliDBudkeIapkfDa0uZEkTpNm4uRDK6
	IgJX0a21vCss7Alpg4sW47/XuDakw+UfLNUDkWacD8T8Z54xI6/k4HmZmleZzfU6ObNONhk88LR
	+G7wYUboSUCFbtVK6aNFvrMFb2RbnVmwmHHR3j/tALi+Qb0evZqN1vZh0ebFVhtEeHwMnK0tqEG
	VEvJ0AOvB3zL5UNo4uWefDiCVKN9rbg4xueQrDX08yfYzZPtY/N57/i0vjFYec5EbmFfhJYC2jw
	HkkrE0ptYYfWyeci7pnD3vefiAx7nzb8X/h1HT1VqLBeKvAeoLHSt+ixvA0k1hSXVzFGWDaQusR
	29a5Rz8P+SRTBo5nCr0CBzWfv3S6wxrHvti2XomYHqkeHGcsWai6Q3s/+e8x6MR2e5aUAtM+DsC
	C36QFqphEwP4ndFBWN3Fj8YQ/lrXRNhyOSyqWliVO16SB0x+NXufDoDSPZViiqLEj4iHGi0+MAZ
	UuCCKjh
X-Received: by 2002:a05:7023:b82:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-12a726572bcmr8336993c88.9.1774366245659;
        Tue, 24 Mar 2026 08:30:45 -0700 (PDT)
Received: from localhost.localdomain ([38.244.25.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b952asm11668865c88.12.2026.03.24.08.30.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Mar 2026 08:30:45 -0700 (PDT)
From: Eric-Terminal <ericterminal@gmail.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH v3 1/2] net: bridge: replace deprecated simple_strtoul with kstrtoul
Date: Tue, 24 Mar 2026 23:30:35 +0800
Message-ID: <20260324153036.86901-2-ericterminal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324153036.86901-1-ericterminal@gmail.com>
References: <20260324153036.86901-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=ericterminal@gmail.com; h=from:subject; bh=avaxbwaSm85gGcPuo27n20U2dgBtXUVQ3RMKsRhQtJ4=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQeWqs1bb9Ey5Gr+x/pKgr3LCp5/vneVZF/CiX2D1l1o ud6rNH17pjIwiDGxWAppshy9/++ublet+Zc5z6cCzOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq GRrpGOgYM3BxCsBUb1jO8FfauSe2uLLf7f8uoStpv5b4bSmct4+HsUC+TVelpqz+Qisjw2yVJXX V/MqyrN9THi1/cTxo87vF2Vahc3gnPZnNb/+LlQkA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-271132-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericterminal@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E806531838E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yufan Chen <ericterminal@gmail.com>

In brport_store(), switch to kstrtoul() so parse failures and range errors
return standard errno directly before taking the bridge lock.

This removes a deprecated API and improves error reporting consistency.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
v3:
- Split from mixed series into a dedicated net series.
- No functional changes since v2.

 net/bridge/br_sysfs_if.c |  5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7..cdecc7d12 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -318,7 +318,6 @@ static ssize_t brport_store(struct kobject *kobj,
 	struct net_bridge_port *p = kobj_to_brport(kobj);
 	ssize_t ret = -EINVAL;
 	unsigned long val;
-	char *endp;
 
 	if (!ns_capable(dev_net(p->dev)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
@@ -339,8 +338,8 @@ static ssize_t brport_store(struct kobject *kobj,
 		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
-		val = simple_strtoul(buf, &endp, 0);
-		if (endp == buf)
+		ret = kstrtoul(buf, 0, &val);
+		if (ret)
 			goto out_unlock;
 		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-- 
2.47.3


