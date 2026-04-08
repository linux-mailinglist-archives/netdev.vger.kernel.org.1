Return-Path: <netdev+bounces-276411-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMdDCVQn1mnqBQgAu9opvQ
	(envelope-from <netdev+bounces-276411-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:00:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9965B3BA338
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9220C303DABE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 09:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1095E37B400;
	Wed,  8 Apr 2026 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RI9k7CCA"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8E73AD51F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775642379; cv=none; b=gt2NbHx55mV94ab7xeXwJWZwq/mWgt80myA1R9jXjfuwaHxRbmVtwxdNNGZFrsNGS0hp900fyB1mmuOuW7ju6NJ/LAWK4clHvlczB9rWoUQEEggt3QmPmWsMcQ9FxJXPv8NFwQLJ1rb09yryzLy8KPU1OJVpKZzyUJKqW/do08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775642379; c=relaxed/simple;
	bh=HwJsmwGt/9wej05p8C2A/lovpKEZ89SyajICcOLt5LM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1uZ7ZQNUMXjRbzoYtIPzsh8HcXhPAuTUSsOMqjhjGLX8jSZHLfoK3ksptmljl5w0x1Bbe3F098lgtEogAPITbnQusb057bROGYw3ycwMMAWkPQY+wHnxYsEQCn8JYb7zR2aAeCoybvfYh0GsGcItAB31QNO29ufiqdNHrH2Sao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RI9k7CCA; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 964FF207BB;
	Wed,  8 Apr 2026 11:59:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BWmoPhqxZeHA; Wed,  8 Apr 2026 11:59:29 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0C36D20660;
	Wed,  8 Apr 2026 11:59:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0C36D20660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775642369;
	bh=wUq1GQIuyPsbmiJInVKHsGqLTvKrNmeZr1J9v17Pt4c=;
	h=From:To:CC:Subject:Date:From;
	b=RI9k7CCAGExOFelLjQXIYvCC3dANXh38mEEnWskqAVmhekeyLS+eS/zfnyy5r4MdC
	 Yq+lWNbtFYgz0rMhmNXkYvOicG3g6iZKJBlUUrPWJq5sHAHTNHZs9qiAwS6WM9Qh8K
	 827YNd1YM9Ey3VzNc3Yzjp94goJd2m1otF5Qv63+quqd8+lImeyhsgzKv8SyzF2KAm
	 QNKWXxmjvfDkH7dFlFqcgYV3F2deWMSbUMDtl+khJvCH9aEiZHdSJK6kfZciDM2TWx
	 vGXKE+zIS4gPOoQ9IPurpVXjk4eaSZ2+7XJeGmgRxgDLt6t3XMUsiqVfClYgXDQtyw
	 LP0sOV2S99U7A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 11:59:28 +0200
Received: (nullmailer pid 256594 invoked by uid 1000);
	Wed, 08 Apr 2026 09:59:27 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/8] pull request (net): ipsec 2026-04-08
Date: Wed, 8 Apr 2026 11:58:56 +0200
Message-ID: <20260408095925.253681-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-276411-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9965B3BA338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1) Clear trailing padding in build_polexpire() to prevent
   leaking unititialized memory. From Yasuaki Torimaru.

2) Fix aevent size calculation when XFRMA_IF_ID is used.
   From Keenan Dong.

3) Wait for RCU readers during policy netns exit before
   freeing the policy hash tables.

4) Fix dome too eaerly dropped references on the netdev
   when uding transport mode. From Qi Tang.

5) Fix refcount leak in xfrm_migrate_policy_find().
   From Kotlyarov Mihail.

6) Fix two fix info leaks in build_report() and
   in build_mapping(). From Greg Kroah-Hartman.

7) Zero aligned sockaddr tail in PF_KEY exports.
   From Zhengchuan Liang.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit c4ea7d8907cf72b259bf70bd8c2e791e1c4ff70f:

  net: mana: fix use-after-free in add_adev() error path (2026-03-24 21:07:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-04-08

for you to fetch changes up to 426c355742f02cf743b347d9d7dbdc1bfbfa31ef:

  net: af_key: zero aligned sockaddr tail in PF_KEY exports (2026-04-07 11:08:24 +0200)

----------------------------------------------------------------
ipsec-2026-04-08

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      xfrm_user: fix info leak in build_mapping()
      xfrm_user: fix info leak in build_report()

Keenan Dong (1):
      xfrm: account XFRMA_IF_ID in aevent size calculation

Kotlyarov Mihail (1):
      xfrm: fix refcount leak in xfrm_migrate_policy_find

Qi Tang (1):
      xfrm: hold dev ref until after transport_finish NF_HOOK

Steffen Klassert (1):
      xfrm: Wait for RCU readers during policy netns exit

Yasuaki Torimaru (1):
      xfrm: clear trailing padding in build_polexpire()

Zhengchuan Liang (1):
      net: af_key: zero aligned sockaddr tail in PF_KEY exports

 net/ipv4/xfrm4_input.c |  5 ++++-
 net/ipv6/xfrm6_input.c |  5 ++++-
 net/key/af_key.c       | 52 +++++++++++++++++++++++++++++++++-----------------
 net/xfrm/xfrm_input.c  | 18 +++++++++++++----
 net/xfrm/xfrm_policy.c |  5 ++---
 net/xfrm/xfrm_user.c   | 14 ++++++++++++--
 6 files changed, 70 insertions(+), 29 deletions(-)

