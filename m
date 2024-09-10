Return-Path: <netdev+bounces-126825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4C9729D4
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445D61F2530F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6D617B50E;
	Tue, 10 Sep 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZQl4SBes"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4617ADE8
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951325; cv=none; b=f3Q9INPslWHuL2N75pbLK77tArmS7DXxZEc1J4NDLxCdb8Y7r/nPSIkvThP132u2hpHC+cIsjBGEtEjolIVMFEdygJ/19yg26VZBlRbKF8pNWDlM53NTu1BmS9B+ChSwGwD46dt5g17kR6kFHqSrOr2n5ZlM0GR0LIsOtfGqTfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951325; c=relaxed/simple;
	bh=J0nger6qbAN2vAoS5REi9A2XWqrz9YZeIbL8SFDs6ic=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oIDds13wSD0o0gMM2HRsbJAKKruI7fhQpefAKelBucQmTwKVqrzaRuCgZSLp4z6hLVa72MTLzQqxor4ZZYqnQsryimAfnIHyEdpjhixro4yIKgH1WkeRtb2vev0t5wLJVPdzxrLmOrXoQndKjvrlcdD9YdatZ0SGAdqcr+CtZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZQl4SBes; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 839472088A;
	Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N9w1DRNIEGby; Tue, 10 Sep 2024 08:55:21 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EB7F82074A;
	Tue, 10 Sep 2024 08:55:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com EB7F82074A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725951321;
	bh=S+w/4P3hTCW1lvZtd8txTUp4PwDg9Rn+JW4mb3wly2I=;
	h=From:To:CC:Subject:Date:From;
	b=ZQl4SBesayWQY65rqe5v8XoffTbxJPHDNewcCowo+w4LcpbRy0gIJrDiVrhfLd0GU
	 MENjfAHLZHh9ZpV6CigWZanIaykRu3+eovMq0/ByCg+j6TTCj1AWh2ql4BMnBhhC4q
	 6JnBJoDyG+GPkKrAFnOiK2FwInsSsPB5085DOhjbpuYWVqGErG4tJt1XNvHRfiwx+A
	 JKcGeelRDSPakW/uQq2Ct8/4JfwYz8kQ8AFPpyQh7Wrp2fdSf3dLeEvquoMcoCqDeF
	 1O87XDCkdRjdBOuV++R1roi/lrkDzXWY5dfqx3iQARUq+gsq0jbByt4OAtVqRRCg32
	 RU9/laQvsFZrQ==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:55:20 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 08:55:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 06B403181C6C; Tue, 10 Sep 2024 08:55:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/13] pull request (net-next): ipsec-next 2024-09-10
Date: Tue, 10 Sep 2024 08:54:54 +0200
Message-ID: <20240910065507.2436394-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

1) Remove an unneeded WARN_ON on packet offload.
   From Patrisious Haddad.

2) Add a copy from skb_seq_state to buffer function.
   This is needed for the upcomming IPTFS patchset.
   From Christian Hopps.

3) Spelling fix in xfrm.h.
   From Simon Horman.

4) Speed up xfrm policy insertions.
   From Florian Westphal.

5) Add and revert a patch to support xfrm interfaces
   for packet offload. This patch was just half coocked.

6) Extend usage of the new xfrm_policy_is_dead_or_sk helper.
   From Florian Westphal.

7) Update comments on sdb and xfrm_policy.
   From Florian Westphal.

8) Fix a null pointer dereference in the new policy insertion
   code From Florian Westphal.

9) Fix an uninitialized variable in the new policy insertion
   code. From Nathan Chancellor.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 8e0c0ec9b7dc2aec84f141c26c501e24906ff765:

  Merge branch 'ethernet-convert-from-tasklet-to-bh-workqueue' (2024-07-31 19:05:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2024-09-10

for you to fetch changes up to e62d39332d4b9400a69ba902797aa17a1a0037e7:

  xfrm: policy: Restore dir assignments in xfrm_hash_rebuild() (2024-09-09 15:30:44 +0200)

----------------------------------------------------------------
ipsec-next-2024-09-10

----------------------------------------------------------------
Christian Hopps (1):
      net: add copy from skb_seq_state to buffer function

Florian Westphal (7):
      selftests: add xfrm policy insertion speed test script
      xfrm: policy: don't iterate inexact policies twice at insert time
      xfrm: switch migrate to xfrm_policy_lookup_bytype
      xfrm: policy: remove remaining use of inexact list
      xfrm: policy: use recently added helper in more places
      xfrm: minor update to sdb and xfrm_policy comments
      xfrm: policy: fix null dereference

Nathan Chancellor (1):
      xfrm: policy: Restore dir assignments in xfrm_hash_rebuild()

Patrisious Haddad (1):
      xfrm: Remove documentation WARN_ON to limit return values for offloaded SA

Simon Horman (1):
      xfrm: Correct spelling in xfrm.h

Steffen Klassert (2):
      Merge branch 'xfrm: speed up policy insertions'
      Revert "xfrm: add SA information to the offloaded packet"

wangfe (1):
      xfrm: add SA information to the offloaded packet

 include/linux/skbuff.h                             |   1 +
 include/net/xfrm.h                                 |  45 ++++-
 net/core/skbuff.c                                  |  35 ++++
 net/xfrm/xfrm_device.c                             |   6 +-
 net/xfrm/xfrm_policy.c                             | 222 ++++++++++-----------
 tools/testing/selftests/net/Makefile               |   2 +-
 .../testing/selftests/net/xfrm_policy_add_speed.sh |  83 ++++++++
 7 files changed, 258 insertions(+), 136 deletions(-)
 create mode 100755 tools/testing/selftests/net/xfrm_policy_add_speed.sh

