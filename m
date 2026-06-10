Return-Path: <netdev+bounces-297481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z7DFCvYEKWqoOwMAu9opvQ
	(envelope-from <netdev+bounces-297481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:32:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 745AD666452
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:32:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ga2VMQG7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297481-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297481-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E02BB31A0F56
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE94372ECF;
	Wed, 10 Jun 2026 06:26:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E38371CEE
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:26:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072768; cv=none; b=X4EoRdzwdpGZ/ElQ5bdePCwA+vWEc5ST5CIbwgGSpdZjX973EFCihR78msWOjH8+8BK/q14eFramTuJe15asXSjUITExqdw8PFsIIlMbE4l6rXhpoGuayn1L8ODidgOPOvIiDP5niL5Snf4mLOA31C3StLL+FvxzZeqnOxF8jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072768; c=relaxed/simple;
	bh=h45pT52EPx2ta3MD+3g+TRsu3+ZTleexXuztW90zkP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twrTPMVp58gGSO62PhZ/vJBMj1RrBzZ7OI3sPZExfxz+HV4X78Xmc2F2g2NCTX9Jes72z77YxCIjTrkRvTGGZej6GlfnvHHjCdSI4+jOajKUXHL8Ca+4dWOJWUw4lrj6umQw0zPtQDuWf5FiQANVJc5yZ4DYKgEtIYc3S7reRJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga2VMQG7; arc=none smtp.client-ip=209.85.210.176
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so4274146b3a.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781072766; x=1781677566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g5w1euadnhBYPuN7UzzMmiECS/TDsQi5eyq7F8os0pk=;
        b=Ga2VMQG72SqzDiWQlvFnG+4Do/n294hxfGo3Eu4xn6AicPSkVuWi7Nf9gssO9IAfPl
         6yh6a54UWCSHpKHD85076mdtihfv1ptIlw6BFlceJejpkzKZyvUW29dHyaYpsFXrelT3
         oyvzgFsh2MyyLxyMYZ46SUYobXjaATfPrxJWY/mhLimZFVVhYlcuQYTSBe0pTIYqUTbH
         JwQvI/AGp2u9KaBkHIgIm+YtJmwovokt4u2MDQn2MzIuI+eyFU4zaaXU3lW1SbSgXk+e
         AQlYNciRA5uUwVqpHh+b8H2bpvmgvAqmm3r3jfGfvVsTqXOhvznAhyCRlTN+k2S5/Ah0
         /WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781072766; x=1781677566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5w1euadnhBYPuN7UzzMmiECS/TDsQi5eyq7F8os0pk=;
        b=a/lvBhF0wcS7G8C7e5GFfUVi3N087r7u+YJj1COjVY2QfQucIqJa2WxgvprzsGzPe6
         b7gGwwufgaBeL25LDrYbm8IPtziaaVj6U2ZeyiQdFL9WHfQhGUkSzdxoZuFvejzdiHFl
         +4LlfHl5MkD8PTGRo8rlKKR3AG107BhHB28S/WJvK+zqsL+jMbwgXe6IT555ihU8It9B
         jzmrpPRbSS7wrb/3yZzlicNQ3NUEEhyh5eY9ut0+hZEBBU/JRqeFiV0qJVm60sj6SBVT
         gW7/NUg9w6HLQq76HRL/ddP5MmGWNPFWNrsXpT6t1bT1V8zaQnfYq6JEl8cR9L0Z/a89
         W7jA==
X-Gm-Message-State: AOJu0YzQ9QIr9O3o8zml3tzuNO5C7x2BvKF3iXERFdqch/9mp+pYglc3
	5KDqDCnw8Ca30R5WIr4TQOhGfEYFin2mGF8RmBttbEG4aeDx2drJ6/ZGnAR5Y06EDZM=
X-Gm-Gg: Acq92OHobJkozUSPg8ANuum0EnNkrz74s/kTqFA+R2TC+N+Z5GZ7wDqOZOZIk9r6ajq
	jsQKac0e1A8h0ze8uc8m0DUIhciIcB8TD692Nc5fjxNdx3PkJ8FuFYARmcBdul5FDIHQASbz0t4
	sluT4dyCQBZlZbGkBnZDAEs8Q1puPHfJ9bFAy4f0iZc8vVPrchhpM52tfbd6kEZ7l+dIgbeh3qK
	OWjY9w6JCcZwql7i6ibIp0Sa2PdTgRcDee8JCPTN5fNUxecbJjM9WUc9QJvGBa3oQNMbcgB0v57
	fnJXS/1orDm9Jn7lJ2dRrQFpG6xw8kM1XasW4RseIUJxvP9GznJhaZ5d+sFMlecKOVjfaHNoQYU
	4176imNxVXoXZEJPzANp1C1jp+oHqX3MiVvScgT3wLfn1DvN27fQiUKmlBhIIz7Q4unHh1+2Yha
	61JXS5v+iqo9e34Iu1WQsm24X3m1qwwfz7O1g7IW6UnhJqtZwSH5mMf1Khw1U=
X-Received: by 2002:a05:6a00:2914:b0:842:6ec3:2352 with SMTP id d2e1a72fcca58-842b0d5d3a8mr24589877b3a.18.1781072766399;
        Tue, 09 Jun 2026 23:26:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282910d1asm23649277b3a.56.2026.06.09.23.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 23:26:05 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: loop: Fix devlink resource ID
Date: Wed, 10 Jun 2026 14:25:45 +0800
Message-ID: <20260610062554.769892-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297481-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:mmyangfl@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 745AD666452

Fix collision with DEVLINK_RESOURCE_ID_PARENT_TOP (0) by keeping the
real resource IDs in enum dsa_loop_devlink_resource_id starting at 1.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/dsa_loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index 7058faf23592..9497c84fb249 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -75,6 +75,7 @@ static struct phy_device *phydevs[PHY_MAX_ADDR];
 static struct mdio_device *switch_mdiodev;
 
 enum dsa_loop_devlink_resource_id {
+	DSA_LOOP_DEVLINK_PARAM_NONE,  /* DEVLINK_RESOURCE_ID_PARENT_TOP */
 	DSA_LOOP_DEVLINK_PARAM_ID_VTU,
 };
 
-- 
2.53.0


