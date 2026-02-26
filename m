Return-Path: <netdev+bounces-261276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEciDPkgoGkDfwQAu9opvQ
	(envelope-from <netdev+bounces-261276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:31:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A51A447A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57DAB309FCB1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C890A3A1E9E;
	Thu, 26 Feb 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="VHkOSePR"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D3306B21
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101809; cv=none; b=N8jP0O0/Pa3D7Sh1a5PP/05YY92W3GPIUh6q9Gr9xmAYvzftdwlYdo5lbGyrJ4JCJrAKiigcT0cHKkVngak23OFKm6q1mLEN6D2nZXD/duShxy57HWP1CmQNVYeeGWY/CLyeQUYvP+Db92OCbQHN5WTRysujtFmntiVHife2a+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101809; c=relaxed/simple;
	bh=KDP+0cuTHeTx7lGCoa/n85lP6YYmj8Jic6OhIZFcWA0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hj9gAGsWS+VQl4ROkJSnwTUQGOZHF233EBag7OeH/QwmiF1Rw7fTBMuFzX96amy1EUP277kQtLYzgOfrv+oS0Bvbwxekg2GKyFrj+huStxydA8/d/5j37uZ94KTkUE41NZseX/N4z9JuBx0Pp0Hciu1nBtMyjUViOcUmaSUEAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=VHkOSePR; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 53458207B3;
	Thu, 26 Feb 2026 11:30:06 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E6RH0j8FLa1C; Thu, 26 Feb 2026 11:30:05 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 11862205E5;
	Thu, 26 Feb 2026 11:30:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 11862205E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1772101805;
	bh=jkUt4jM727hJC1aRcBFJPoh0b3Z7p8cpiNkeyYKZ5LU=;
	h=From:To:CC:Subject:Date:From;
	b=VHkOSePROh6xM8NfR7zLJ656k2v+CaM27/zKZVh/r7XWVdSHMDi15W14ugTtfmVmc
	 p9/zfGBtFuGMWKt4bN6hINhzUOI4vGxzunT95es8LFzoi/eJNBmTitjf3tk1TeyP+M
	 54poTkW/x010HG0S+3xxQvsY40Wf0cFhlIvnkJrkRh/6XsnoIgfBmpACsI5Seq0+DN
	 p6U4dEHvf8AONavCGEiJ/pzOZYSHXS7qcnVX/fr9lEQCHmB9KP3O/SOEQsKutIr0uv
	 GszwylvazX6pVUKd7Z2F5BEgo5gEd0fIHsRWLsY1gW7Qf17dHTRO3L58+bAM8CRxSD
	 74+EOkccsjhcQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 11:30:03 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Jakub Kicinski
	<kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
	<shuah@kernel.org>, <devel@linux-ipsec.org>, Tobias Brunner
	<tobias@strongswan.org>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>
Subject: [PATCH net-next v5 0/2] icmp: Fix icmp error source address over xfrm tunnel
Date: Thu, 26 Feb 2026 11:29:51 +0100
Message-ID: <cover.1772101380.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-261276-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 851A51A447A
X-Rspamd-Action: no action


icmp: Fix icmp error source address over xfrm tunnel

This fix, originally sent to XFRM/IPsec, has been recommended by
Steffen Klassert to submit to the net tree, since it changes ICMP
behavior.

The patch addresses a minor issue related to the IPv4 source address
of ICMP error messages. The bug only occurs when xfrm policies are
configured. It originated from an old 2011 commit:

commit 415b3334a21a ("icmp: Fix regression in nexthop resolution during
replies.")

Submitting to net-next with a selftest.

v1->v2 : add kernel selftest script
v2->v3 : fix test script.
v3->v4 : fix test script based on reviews
     - clarify commit message
     - Changed subsystem prefix to icmp: since fix is in net/ipv4/icmp.c
v4->v5 : fix shellcheck warnings

Antony Antony (2):
  icmp: fix ICMP error source address when xfrm policy matches
  selftests: net: add ICMP error source address test over xfrm tunnel

 net/ipv4/icmp.c                           |   1 -
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/xfrm_state.sh | 613 ++++++++++++++++++++++
 3 files changed, 614 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/xfrm_state.sh

--
2.39.5

