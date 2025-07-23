Return-Path: <netdev+bounces-209241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563AFB0EC91
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CB9561CF6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73A27979F;
	Wed, 23 Jul 2025 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Xl8XSJqJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8190278E42
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257645; cv=none; b=HMt8EBwD9gaZxtx2VQ7E5C7fIyebxSHIQ3yFTNeLkeyENt1jPxXOxailp0u/4NLCbwMd16JoqQS7m+H61s7k/oJUY/0F0kAN3pW1fQ8FxbOGeohSj5FSN7yONSgbbvsyKky1YRJF7/gO7xp1jJVwWHeTLiVU86cSfAHmGk6MsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257645; c=relaxed/simple;
	bh=6h/h4YQGiq+M6As6/riwS99Q2iHppjX728b08ncsJoQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=reXlS6kluxV6N9XZedTOqHvQGYxSHFWWQOw7jklv1CfwELmHsCtUEGUrDE8mPxCNYR/R2jpijraFCeVDNqBxkeSfi2/jg4mqDrZ+4wUpAYDqo9E/tO0z/6FtCABQZIcct6JddyF9PKXLeBmI1QM28a1sWHgb76tGfRwlM4n5FfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Xl8XSJqJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 126C6208A3;
	Wed, 23 Jul 2025 09:54:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tb4XDXn8hvou; Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 6C0D420820;
	Wed, 23 Jul 2025 09:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 6C0D420820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1753257260;
	bh=vnVimXrI5F2EVCHG3MPSK6KPupmk4glvfrFAX29cKRY=;
	h=From:To:CC:Subject:Date:From;
	b=Xl8XSJqJ3HLmYtfwdkABAI4x4jAs5ZjFU7M9cuF37VPsk9UqhuNfxKjIoBm9uXioc
	 xwPS8NqMFTCKB8unP5rXOwiHvQ2uhWhETNET9E3vsaFQmcLF8LnzDJ4vuSmy6wpFMG
	 7NkUnHsyU3JjjoWRojfKIKUkKgQNx0XFMoO9C3hMelsk1260O5g+pjMRBHFj3MwepK
	 EKCDdpy/gGA6K2Zl7miwGW5y+5g9VCNnYmkVWKEtdyaorBTmEGmxg6c+OWRI3/VskI
	 7S67H48sXS14VkAM45EHCLWWLufMj7BB0Z2RWSh23hjtwbsJy8J47i9B0h4nmghqdp
	 vQ82CZCO5Y4tQ==
Received: from gauss2.secunet.de (10.182.7.193) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 23 Jul
 2025 09:54:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 937323181838; Wed, 23 Jul 2025 09:54:19 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/8] pull request (net): ipsec 2025-07-23
Date: Wed, 23 Jul 2025 09:53:52 +0200
Message-ID: <20250723075417.3432644-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 EXCH-01.secunet.de (10.32.0.171)

1) Premption fixes for xfrm_state_find.
   From Sabrina Dubroca.

2) Initialize offload path also for SW IPsec GRO. This fixes a
   performance regression on SW IPsec offload.
   From Leon Romanovsky.

3) Fix IPsec UDP GRO for IKE packets.
   From Tobias Brunner,

4) Fix transport header setting for IPcomp after decompressing.
   From Fernando Fernandez Mancera.

5)  Fix use-after-free when xfrmi_changelink tries to change
    collect_md for a xfrm interface.
    From Eyal Birger .

6) Delete the special IPcomp x->tunnel state along with the state x
   to avoid refcount problems.
   From Sabrina Dubroca.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit b56bbaf8c9ffe02468f6ba8757668e95dda7e62c:

  Merge branch 'net-airoha-fix-ipv6-hw-acceleration' (2025-06-03 13:04:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2025-07-23

for you to fetch changes up to 28712d6ed32028b0f2e0defe6681411496971ca3:

  Merge branch 'ipsec: fix splat due to ipcomp fallback tunnel' (2025-07-14 08:59:48 +0200)

----------------------------------------------------------------
ipsec-2025-07-23

----------------------------------------------------------------
Eyal Birger (1):
      xfrm: interface: fix use-after-free after changing collect_md xfrm interface

Fernando Fernandez Mancera (1):
      xfrm: ipcomp: adjust transport header after decompressing

Leon Romanovsky (1):
      xfrm: always initialize offload path

Sabrina Dubroca (4):
      xfrm: state: initialize state_ptrs earlier in xfrm_state_find
      xfrm: state: use a consistent pcpu_id in xfrm_state_find
      xfrm: delete x->tunnel as we delete x
      Revert "xfrm: destroy xfrm_state synchronously on net exit path"

Steffen Klassert (2):
      Merge branch 'xfrm: fixes for xfrm_state_find under preemption'
      Merge branch 'ipsec: fix splat due to ipcomp fallback tunnel'

Tobias Brunner (1):
      xfrm: Set transport header to fix UDP GRO handling

 include/net/xfrm.h             | 15 +++------
 net/ipv4/ipcomp.c              |  2 ++
 net/ipv4/xfrm4_input.c         |  3 ++
 net/ipv6/ipcomp6.c             |  2 ++
 net/ipv6/xfrm6_input.c         |  3 ++
 net/ipv6/xfrm6_tunnel.c        |  2 +-
 net/key/af_key.c               |  2 +-
 net/xfrm/xfrm_device.c         |  1 -
 net/xfrm/xfrm_interface_core.c |  7 +----
 net/xfrm/xfrm_ipcomp.c         |  3 +-
 net/xfrm/xfrm_state.c          | 69 ++++++++++++++++--------------------------
 net/xfrm/xfrm_user.c           |  3 +-
 12 files changed, 46 insertions(+), 66 deletions(-)

