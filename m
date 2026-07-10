Return-Path: <netdev+bounces-306440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I+TdL6yDUGrZ0QIAu9opvQ
	(envelope-from <netdev+bounces-306440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:31:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF9373758A
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 07:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=M48KARnE;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306440-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306440-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1C3B3011103
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCEF379C29;
	Fri, 10 Jul 2026 05:31:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE143373C1A;
	Fri, 10 Jul 2026 05:31:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661473; cv=none; b=pzCCZZhpo6gaNyQx0qcsOJrNfSEZY3KOK2qaSkg++ofDCE1KwfKWXRPYGsfakMt5ZkgXlkD/8lKaZT6/IBy9vQoFwkPfyn0+U48xmRsrX9fDHWOwIXPoABzl2cwW3/6MOWgUrix8CgMAvw+/wFeNiHXlQMIjc33tlK2C0nufMzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661473; c=relaxed/simple;
	bh=l64JcjzWCpSBdRWQ5UQ77z22/husDJbhXILYRBfevxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uil7ZyQR+Iu3n1fFi4FeK9gSvz89pPlgTwKmxoz4diYsI+vziob+wu9jlMfJtvsRZcBQqlU0L/8SseQK0flzR6bzjMisrd/OBvXpXdsNAZQRofakxbhNB5Ekdc9ZN8wwjRKsZmRt9kS20eb5MhwAMz2PJqq0St2xC8w+u312w6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M48KARnE; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n+w8axshVAu6c1a5VUZtVU0qgvR+7v+S6dNFZ+LAmUs=; b=M48KARnE+IQDuByHhqcRsuStTJ
	uaoOZGJqBBTEHSfLhRcgZWNAAWRTrt96ZDkLyuckTlox0YbOs7xPfoDqzxMDK6rFMuynGR66wd00Y
	eXATv3QpStXCvgVzftfwFEFFqb8ekxvAq2907tfVyxMFqdkHhfvcnH9FeV8Wf2p9bAM4C/8zV+L4j
	b5fO2Rvp0UUfS5yZ54WjIcXvbHZbB84x7J+AYoemznsMNPihDDzLeOm4NIYy+sKts/LheijO9jEuC
	IhDo2/tFdDjpKmLDPw7nOpDRFoaezGkEfUjsGgXl4+l57dNPZ60XIFLqotMFKacQOMoeK9Le22c+n
	1mh5f+kg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi3pK-00000004CbL-38e5;
	Fri, 10 Jul 2026 05:31:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"chunzhi.lin" <linchunzhi0@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	linux-acpi@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH] docs: ACPI: DSD: motorcomm: fix docs build error
Date: Thu,  9 Jul 2026 22:31:06 -0700
Message-ID: <20260710053106.730399-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306440-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,vger.kernel.org,armlinux.org.uk,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:rdunlap@infradead.org,m:linchunzhi0@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:linux@armlinux.org.uk,m:linux-acpi@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,vger.kernel.org:from_smtp,infradead.org:from_mime,infradead.org:email,infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EF9373758A

Separate the title with commas (since they are all run togethe in the
produced output) and add a blank line before the descriptive text to
avoid a docs build error:

Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst:70: ERROR: Unexpected indentation. [docutils]

Fixes: 28f431eac1e5 ("docs: acpi: dsd: add Motorcomm yt8xxx PHY properties")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: chunzhi.lin <linchunzhi0@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-acpi@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>

 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linext-2026-0708.orig/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
+++ linext-2026-0708/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
@@ -64,9 +64,10 @@ defaults as [motorcomm-yt8xxx]_.
   Enables adjustments related to ``motorcomm,tx-clk-*-inverted`` usage; see
   [motorcomm-yt8xxx]_.
 
-``motorcomm,tx-clk-10-inverted`` (boolean, optional)
-``motorcomm,tx-clk-100-inverted`` (boolean, optional)
+``motorcomm,tx-clk-10-inverted`` (boolean, optional),
+``motorcomm,tx-clk-100-inverted`` (boolean, optional),
 ``motorcomm,tx-clk-1000-inverted`` (boolean, optional)
+
   Per-speed TX clock inversion options; see [motorcomm-yt8xxx]_.
 
 ASL example (illustrative)

