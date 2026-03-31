Return-Path: <netdev+bounces-273706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJnIHn8CzGljNQYAu9opvQ
	(envelope-from <netdev+bounces-273706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:21:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E906136E871
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A383255BD7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88323426D09;
	Tue, 31 Mar 2026 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P80SBJGk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C477425CD6
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975851; cv=none; b=bBGCzxpn2UIOK8EPD6EOdcrLiRCyKmwNC8iMsVqG7F57ptqqPYTTOD8J/SMcZrXD513+XrWi6XZRSG8roq3aPhb2MDdlgiwP486eE4kO7UkLfl+8yE9luUBdT/sOOHEK48b66Eswtm2I34No5lURL72Rus1LafLdb2E6zLWbfQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975851; c=relaxed/simple;
	bh=uaJTNDpTTNCJjLb0T0uqnNwZs8FWXt7CgFTzh7mNsPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPuJmVenPGS9HwVh2J2pMMvCPLfcBkTc5i9f+xGP11YSHDDJbNUv671TXlv/BE22xsUxlKa4uAnLZuzf0HZiEJJnCa1ULebVKzBYXRO4StLh1u7OHZ9AomWwbUahBwrtuPtWrmvCrOX1pMSmL7QXLyoA64gVEybR88fTk0kcVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P80SBJGk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774975849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MbsngGMGgFXF4FxRKphAmfS3uQOFO0oUmRUWkib1ynE=;
	b=P80SBJGkCPaOLT2woFIIB4heO9svPrKd5lovsovDlnJtTMdqB0Pr798F727FFa487S3pP9
	zmfazY2ojYVryPmE7zGPUNJFOB/hvwPh1Z4kb9tCcV22oi1Wm1xKgfcWbi4HCCbRN8WDzC
	zB3pvl48djPXRMQ8uzYfEkPBnAyUVoI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-Kn7xVzZcMV6J3_O8pKezog-1; Tue,
 31 Mar 2026 12:50:42 -0400
X-MC-Unique: Kn7xVzZcMV6J3_O8pKezog-1
X-Mimecast-MFC-AGG-ID: Kn7xVzZcMV6J3_O8pKezog_1774975837
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22AE018002C8;
	Tue, 31 Mar 2026 16:50:36 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 99205180036E;
	Tue, 31 Mar 2026 16:50:31 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Frederic Weisbecker <frederic@kernel.org>,
	Chen Ridong <chenridong@huawei.com>,
	Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	sheviks <sheviks@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-next v2 0/2] ipvs: Fix incorrect use of HK_TYPE_KTHREAD housekeeping cpumask
Date: Tue, 31 Mar 2026 12:50:13 -0400
Message-ID: <20260331165015.2777765-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273706-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E906136E871
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

 v2:
  - Rebased on top of linux-next

Since commit 041ee6f3727a ("kthread: Rely on HK_TYPE_DOMAIN for preferred
affinity management"), the HK_TYPE_KTHREAD housekeeping cpumask may no
longer be correct in showing the actual CPU affinity of kthreads that
have no predefined CPU affinity. As the ipvs networking code is still
using HK_TYPE_KTHREAD, we need to make HK_TYPE_KTHREAD reflect the
reality.

This patch series makes HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
and uses RCU to protect access to the HK_TYPE_KTHREAD housekeeping
cpumask.

Waiman Long (2):
  sched/isolation: Make HK_TYPE_KTHREAD an alias of HK_TYPE_DOMAIN
  ipvs: Guard access of HK_TYPE_KTHREAD cpumask with RCU

 include/linux/sched/isolation.h |  6 +++++-
 include/net/ip_vs.h             | 20 ++++++++++++++++----
 net/netfilter/ipvs/ip_vs_ctl.c  | 13 ++++++++-----
 3 files changed, 29 insertions(+), 10 deletions(-)

-- 
2.53.0


