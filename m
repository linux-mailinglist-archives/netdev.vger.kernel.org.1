Return-Path: <netdev+bounces-147077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9706B9D7714
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A333B221EB
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488952500AB;
	Sun, 24 Nov 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiRmmF3k"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EAF163
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462878; cv=none; b=KVG8f0tgfgekpXdWvQxfXEEP0ZAs3nc01LzZInuI+S5PJZJHIspEmUjjS9Of/Vr6+t4y9tLh1ig69y5bL4oRMfIHvoDTJsnfD3z1d3Lji0bwEytO1OzOQ5ITmJzQEBnCuCftBmM8bdQ4/Al3sZtpFCaZglbxs08z4sKO/bX2Ahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462878; c=relaxed/simple;
	bh=EnqMQK8V+ibB/xD90DCg4FpSaGbMF/gH2c4hflIoTBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4XsE0mtQB3aHoyVHt+MiOHP4gJhHaezlnyj/xWRe1TX3po9SpxLabiE/mA52J7X+3kRcO7L+/4jPNw+W7GKii2HESKwhEPbPKHZZWPsjWtAjwXAKRz4Q8GVpp9W8EumlVgwYpwu8VvjUJMGKff6dm0GRVsIxeGV52U6FyQ33sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UiRmmF3k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732462874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CVEm09tc+N9ZNnxoz1I43B8hzOsoZcsHpyevI/PhxN4=;
	b=UiRmmF3k86Dh8B5m3Jj7fDg2ZZS0h1U+nZg0tfB+buHtZyWcjocO/yH8VqiqFIPsXi7fyg
	EJDVJSR6rfoNqKSheGi62nOxx3uVWd7Y6FGxZZvK1d8l0xO52EPL6Lcb/GGMPaFOS9cNCs
	Ijdask46mvD3EAsnZxR38ACbMOpNRKw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-MXVp3urRP8GKUHvzIEZu8A-1; Sun,
 24 Nov 2024 10:41:09 -0500
X-MC-Unique: MXVp3urRP8GKUHvzIEZu8A-1
X-Mimecast-MFC-AGG-ID: MXVp3urRP8GKUHvzIEZu8A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E17AA19560AF;
	Sun, 24 Nov 2024 15:41:07 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CCA41955F43;
	Sun, 24 Nov 2024 15:41:05 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v2 net 0/3] net: fix mcast RCU splats
Date: Sun, 24 Nov 2024 16:40:55 +0100
Message-ID: <cover.1732289799.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This series addresses the RCU splat triggered by the forwarding
mroute tests.

The first patch does not address any specific issue, but makes the
following ones more clear. Patch 2 and 3 address the issue for ipv6 and
ipv4 respectively.

---
v1 -> v2:
 - fix build issues in patch 1/3

Paolo Abeni (3):
  ipmr: add debug check for mr table cleanup
  ip6mr: fix tables suspicious RCU usage
  ipmr: fix tables suspicious RCU usage

 net/ipv4/ipmr.c  | 56 +++++++++++++++++++++++++++++++++++++-----------
 net/ipv6/ip6mr.c | 52 ++++++++++++++++++++++++++++++++++----------
 2 files changed, 84 insertions(+), 24 deletions(-)

-- 
2.45.2


