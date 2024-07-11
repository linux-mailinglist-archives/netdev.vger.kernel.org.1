Return-Path: <netdev+bounces-110776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6692E437
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7C91C215DC
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09C91581F8;
	Thu, 11 Jul 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gjoeeSQC"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACF157E93
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692541; cv=none; b=WVkh2kqBG7WHps9XPZQ46QudUr1Sg1xmKc+NMrJN7QM0tBKsm5vAnp/ZFfIJNXwp+WgDWrVO2aWx9LSkvTtKmcbSElkMMFdvDh9ANh1E3wlfGmbP9BM7LrGcy8m+AzdSpG7UCQBraJuya7MDv7+dHMwaOOui4BObdkVYiLz22Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692541; c=relaxed/simple;
	bh=m/qx3mohRVLuLERC3a8qS8IO4AwVEpKzVJ5Tob+muC0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DAN2ZKFLt2XzGiPAZo+5Ea/EtZIfAOlbhCbJBRJrb4MB0YAUcwrZaPolG9fmy6YpYllDv8oq/lehhwFAyRzptlIGMRJILYfIes02PwAJwh+N0uI9qS1SGfZ458NicljvnpJLnBOlRxgw+VXT+Yq46pHtTs2hXFss8WTNKK1zEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gjoeeSQC; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 5A83320839;
	Thu, 11 Jul 2024 12:00:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gQeMtaSEjrxt; Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B7057207A4;
	Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B7057207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692031;
	bh=6Dl5hSkp/2wKrhGmyIcbrvPin5Vyz1u/P+plVcTpORY=;
	h=From:To:CC:Subject:Date:From;
	b=gjoeeSQC/hK5xbzqHKep2RcYQLg2RnWWYkt5L69Rs5Z0d2goN7djpHYXvEwqtwOWR
	 zptlLkGFR8vE0D+8DFJgtCHr5dk89m2r3JiTo4CFxavpKzjVI1UuP1V62VplLqBenC
	 YD92PtcAZiRQA1LNXsNu4alq2jWocWn8fUXgdIOHN8T1Vp2XNmPFXYStkuIC8iP7Vu
	 4rKcw/r19XAqmwwpQq0eCS2gF5X1ErRfDkY36X//8eOpUF1K6B/AnQhUafBgUIp45H
	 rVqu7jT3DaS7ITxbT/U5zaRKgrHajeBonfBA7Agn88A+r4KU5qDYfZZm93ZdOwtay1
	 m8VjOF6LYIWgA==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id A691180004A;
	Thu, 11 Jul 2024 12:00:31 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:00:31 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 12:00:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id EFC12318162A; Thu, 11 Jul 2024 12:00:30 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/7] pull request (net): ipsec 2024-07-11
Date: Thu, 11 Jul 2024 12:00:18 +0200
Message-ID: <20240711100025.1949454-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

1) Fix esp_output_tail_tcp() on unsupported ESPINTCP.
   From Hagar Hemdan.

2) Fix two bugs in the recently introduced SA direction separation.
   From Antony Antony.

3) Fix unregister netdevice hang on hardware offload. We had to add another
   list where skbs linked to that are unlinked from the lists (deleted)
   but not yet freed.

4) Fix netdev reference count imbalance in xfrm_state_find.
   From Jianbo Liu.

5) Call xfrm_dev_policy_delete when killingi them on offloaded policies.
   Jianbo Liu.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 9c91c7fadb1771dcc2815c5271d14566366d05c5:

  net: mana: Fix the extra HZ in mana_hwc_send_request (2024-05-22 11:17:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2024-07-11

for you to fetch changes up to 89a2aefe4b084686c2ffc1ee939585111ea4fc0f:

  xfrm: call xfrm_dev_policy_delete when kill policy (2024-07-08 13:24:13 +0200)

----------------------------------------------------------------
ipsec-2024-07-11

----------------------------------------------------------------
Antony Antony (2):
      xfrm: Fix input error path memory access
      xfrm: Log input direction mismatch error in one place

Hagar Hemdan (1):
      net: esp: cleanup esp_output_tail_tcp() in case of unsupported ESPINTCP

Jianbo Liu (2):
      xfrm: fix netdev reference count imbalance
      xfrm: call xfrm_dev_policy_delete when kill policy

Steffen Klassert (2):
      xfrm: Fix unregister netdevice hang on hardware offload.
      xfrm: Export symbol xfrm_dev_state_delete.

 include/net/xfrm.h      | 36 ++++++++-------------------
 net/ipv4/esp4.c         |  3 +--
 net/ipv4/esp4_offload.c |  7 ++++++
 net/ipv6/esp6.c         |  3 +--
 net/ipv6/esp6_offload.c |  7 ++++++
 net/xfrm/xfrm_input.c   |  8 +++---
 net/xfrm/xfrm_policy.c  |  5 ++--
 net/xfrm/xfrm_state.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++---
 net/xfrm/xfrm_user.c    |  1 -
 9 files changed, 92 insertions(+), 43 deletions(-)

