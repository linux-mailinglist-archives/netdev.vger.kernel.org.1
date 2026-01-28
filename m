Return-Path: <netdev+bounces-254186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEXyIwnjeWm50gEAu9opvQ
	(envelope-from <netdev+bounces-254186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:20:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D89439F626
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 11:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E71F53013AA9
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318128469A;
	Wed, 28 Jan 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="o5vNP1hT"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CFB2E1746
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595633; cv=none; b=lsLSOKQ2I1v5j9kRNHQjNUJzLrQyURjEBg/9knlqhW6qkk77b29hRLlLqZZEBUVbjqA3IZFwPyZS1uFco0OTMPNGNFtDZNa3JtiGtdQSjcU5TZJ7nYZlKvuwOiQ4OT+sahy01zUXRVpCO55A0cgVKr9gl1ZhxWQY7SegT4Fwtqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595633; c=relaxed/simple;
	bh=JkBweBxm2HAhLcGJgGSj5cvprWUfy7b/KMqb9POYtVs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oyIk7fmOmB3eqTp7HhmQTyUWRaUQtKYOErZKeq5M8zN8pTj76RGnjW0xoCPhyHuP8Cpv4NVz7h7AzF3hUF2MjtXVlzbvKVl/y8eHbyruhuaGTXyuoc7zt0yY2l/SKqGOSwPtCar+5L6U5ujmx1TQkGm8uTp1vqYEsiqQkTF4ztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=o5vNP1hT; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C75B8207B3;
	Wed, 28 Jan 2026 11:20:26 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g2Z4mTlRCwV3; Wed, 28 Jan 2026 11:20:26 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2E34A20728;
	Wed, 28 Jan 2026 11:20:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2E34A20728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769595626;
	bh=aGnwEkuBvAaPLDZZGErpKQKygDIV3BTCK++EBWFY4m4=;
	h=From:To:CC:Subject:Date:From;
	b=o5vNP1hTOrM8Q9wrjJHkymeMJF7JUJVgLhcJr5D46DutzY/PyIzh7ZRH2DCsPhjjT
	 wvD9q0uC7bzCvKf0mglpqPJrR21Fil9M+jqwyYVQXb0aQy1qStEvUpMxcGr8KJ5aHQ
	 9SX/AcX76rvtSk0Jql9oNCDBAD6Tg4Pjsrs1npL3+QYA34Bwpknqjd+RzL/P23Txb1
	 vkiT3nqg50yyehjhhBxsBpEAAHZh3++vhDlNi1asdOTXdJadRQF8HqyTwIXFFu63NE
	 aGCt8bq8/Lf28aA3Wdk3DLbJcjfEFTB/0stYwaneExBGe7lGC4rtOZmxD66aqJ4wPp
	 u9EW0fWc/dQiQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 11:20:25 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Jakub Kicinski
	<kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
	<shuah@kernel.org>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 0/2] icmp: Fix icmp error source address over xfrm tunnel
Date: Wed, 28 Jan 2026 11:19:06 +0100
Message-ID: <cover.1769595011.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254186-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D89439F626
X-Rspamd-Action: no action

This fix, originally sent to XFRM/IPsec, has been recommended by
Steffen Klassert to submit to the net tree, since it changes ICMP
behavior.

The patch addresses a minor issue related to the IPv4 source address
of ICMP error messages. The bug only occurs when xfrm policies are
configured. It originated from an old 2011 commit:

commit 415b3334a21a ("icmp: Fix regression in nexthop resolution during
replies.")

Submitting to net-next with a selftest.

Antony Antony (2):
  icmp: fix ICMP error source address when xfrm policy matches
  selftests: net: add ICMP error source address test over xfrm tunnel

 net/ipv4/icmp.c                           |   1 -
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/xfrm_state.sh | 578 ++++++++++++++++++++++
 3 files changed, 579 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/xfrm_state.sh

---
v1->v2 : add kernel selftest script
v2->v3 : fix test script.
v3->v4 : fix test script based on reviews
     - clarify commit message
     - Changed subsystem prefix to icmp: since fix is in net/ipv4/icmp.c

-antony

