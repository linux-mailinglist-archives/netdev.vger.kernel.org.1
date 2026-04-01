Return-Path: <netdev+bounces-274212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAuaOhhkzWkHdAYAu9opvQ
	(envelope-from <netdev+bounces-274212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:29:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970E37F473
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 20:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BA6302A6AE
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 18:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC4935AC25;
	Wed,  1 Apr 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqDxpVoT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F22E62C6;
	Wed,  1 Apr 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775067992; cv=none; b=lCS/0m7V5zvQzBcs/FtcdAMt1wzqqcOgad08gJ5XC2Wq4BrRvFn3rnNCoAZMaPCLRUl+DD9C1la5A9PaoAHiH2At7yb4AIkXMYCrHbahRRqbL8OuEZl95OPD5uLcucYrdbuiHl6hs4Ka+VWDMTNTQ4ht78R/1Llx0INzZBf1Wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775067992; c=relaxed/simple;
	bh=76gV41/mAXFYVbweMSrf1MZ3p4NcRgYn0MinbuKkCUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEC/4SYY4AV1a4lwvXcMob4rl5Rk3/kznRSudku+6xQnQ4SRCA09BxArXwvCYM+r9OdIh4uKYt+KFSsmP/Z6xmjZSOYyQmMwku+0ONtq1kGBeGZ7uYHfj2CpMAXeKERCm59Y1MsvnlJwHAeN5YPuu1ZpkqjpNuyMsQkjOwlOe6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqDxpVoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF72C4CEF7;
	Wed,  1 Apr 2026 18:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775067992;
	bh=76gV41/mAXFYVbweMSrf1MZ3p4NcRgYn0MinbuKkCUU=;
	h=From:To:Cc:Subject:Date:From;
	b=XqDxpVoTLSNU70kQKXnvDrJAYNM2xdIIdXnk4muRimx8W4s5ibWKS021oBG9cNTPe
	 Hr08r23JsXhOi/6UVxXNp6KDQ56HYEN/M3+QlA1kDRhZjwqheFSB2Mqgz6zSk4OGxw
	 QiytFo6w8U/O71tTHPCtNogPKbEnb8QFVwTkbTnY8unyOJZBj0VFFfvIWGxzd3H7YO
	 3ROWEu0NlGuYdSucquyjc1bNUFG5cEPH5/hN0c5l0llhCNF/U4JmkOiUjFTYtOb3zI
	 EzV4yf1PQ8x9vhJUkjYuHZJUv3glQ44zMLt5bm9lOaSIXTK4HEN+B3ciy+Ag8kgbP0
	 +d73qiaw2+gBQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/6] selftests: drv-net: gro: more test cases
Date: Wed,  1 Apr 2026 11:26:19 -0700
Message-ID: <20260401182625.372605-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274212-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7970E37F473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a few more test cases for GRO.

Jakub Kicinski (6):
  selftests: drv-net: gro: add data burst test case
  selftests: drv-net: gro: add 1 byte payload test
  selftests: drv-net: gro: always wait for FIN in the capacity test
  selftests: drv-net: gro: prepare for ip6ip6 support
  selftests: drv-net: gro: test ip6ip6
  selftests: drv-net: gro: add a test for bad IPv4 csum

 tools/testing/selftests/net/lib/gro.c      | 171 +++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |  24 ++-
 2 files changed, 143 insertions(+), 52 deletions(-)

-- 
2.53.0


