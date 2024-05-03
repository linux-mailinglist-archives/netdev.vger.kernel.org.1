Return-Path: <netdev+bounces-93198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0BA8BA8B9
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D398D283197
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2A314D446;
	Fri,  3 May 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="glp9Kmxu"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22314A094
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724868; cv=none; b=OC3L2W1d6V6JdhvK9QzBYOScEOxyO3qDvEeEDG46Xo+T08H/Q6iKn7515d9Y+fv2XJwF5JpBHnZaA2z9nnZjRX7+E1i2G8TfXAUHl9s/U+hH7lRTQa/wsKYDfgJnxj3WtwLXjI5E+xFTn2OoDOeOZR8EEAN2ZUyIzt2/qPrAkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724868; c=relaxed/simple;
	bh=o2WKBSQbJSQJew5ixe76lsEdRNmZ+XY4JSaYn7yJ2CE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YK/L/+FrJ8oh4F3M8m5FVBERG7QQBRAu28w7i49xLnaDwiaoHi9LhP1JMdJokQ4Mz5aPgpHs6Q389UeSi9UmlH49+xJIkfPBKuAfgVy1/VIzTLn6SDc4nLQbX0eP7j+h8HPIBxE8ElGYHxlunv7yHoleaXIQ42jgWtTVdrZ5Gpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=glp9Kmxu; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 15BAB2076B;
	Fri,  3 May 2024 10:27:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bDVwYUkH4Mmb; Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1EBE72083F;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1EBE72083F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1714724857;
	bh=DTXZEPvLtWrBkfjFgwZm3rhfaJZlo/jwztZuVifXXto=;
	h=From:To:CC:Subject:Date:From;
	b=glp9Kmxuk1TVoUddwtfl541oMrexfH2Z0kD/HG6l4Xe8Oughynb8Bi4Nk5hub4MSC
	 yuXFkk5VcoH69qEsOuGxLj7X9wyrHsP+J8v94mdDi6hjdGc3UpDO9xbboj9Z6UNjzx
	 qVIf7aZQC8xI+pjlSZlOONPWXB2HN9t0GrdDrMEDtsgu4AtpLttAYgW6M5Ft+pk4Gq
	 BTKklmrN89yYYlGQR6OvyuA2Kp2uRn3/NlfQk8zg1suZIe0atsD+QwDEigw0qeaZA/
	 kwLXFJaRN5zH34/71vE8MCZnAFMUD6zrRbNb5eNMbKfZtXQWEWdo8L9K9t7TLj7lRP
	 iVnmqiCaPprnQ==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 11F0280004A;
	Fri,  3 May 2024 10:27:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 3 May 2024 10:27:36 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 May
 2024 10:27:36 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 09F1B318406D; Fri,  3 May 2024 10:27:36 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/5] pull request (net-next): ipsec-next 2024-05-03
Date: Fri, 3 May 2024 10:27:26 +0200
Message-ID: <20240503082732.2835810-1-steffen.klassert@secunet.com>
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

1) Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support.
   This was defined by an early version of an IETF draft
   that did not make it to a standard.

2) Introduce direction attribute for xfrm states.
   xfrm states have a direction, a stsate can be used
   either for input or output packet processing.
   Add a direction to xfrm states to make it clear
   for what a xfrm state is used.

All patches from Antony Antony.

Please pull or let me know if there are problems.

Thanks!

The following changes since commit 267e31750ae89f845cfe7df8f577b19482d9ef9b:

  Merge branch 'phy-listing-link_topology-tracking' (2024-04-06 18:25:15 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git tags/ipsec-next-2024-05-03

for you to fetch changes up to dcf280ea0aad87e70ef1646d579d11f8a52f8b67:

  Merge remote branch 'xfrm: Introduce direction attribute for SA' (2024-05-02 10:05:11 +0200)

----------------------------------------------------------------
ipsec-next-2024-05-03

----------------------------------------------------------------
Antony Antony (5):
      udpencap: Remove Obsolete UDP_ENCAP_ESPINUDP_NON_IKE Support
      xfrm: Add Direction to the SA in or out
      xfrm: Add dir validation to "out" data path lookup
      xfrm: Add dir validation to "in" data path lookup
      xfrm: Restrict SA direction attribute to specific netlink message types

Steffen Klassert (1):
      Merge remote branch 'xfrm: Introduce direction attribute for SA'

 Documentation/networking/xfrm_proc.rst |   6 ++
 include/net/xfrm.h                     |   1 +
 include/uapi/linux/snmp.h              |   2 +
 include/uapi/linux/udp.h               |   2 +-
 include/uapi/linux/xfrm.h              |   6 ++
 net/ipv4/esp4.c                        |  12 ---
 net/ipv4/udp.c                         |   2 -
 net/ipv4/xfrm4_input.c                 |  13 ---
 net/ipv6/esp6.c                        |  12 ---
 net/ipv6/xfrm6_input.c                 |  20 ++--
 net/xfrm/xfrm_compat.c                 |   7 +-
 net/xfrm/xfrm_device.c                 |   6 ++
 net/xfrm/xfrm_input.c                  |  11 +++
 net/xfrm/xfrm_policy.c                 |   6 ++
 net/xfrm/xfrm_proc.c                   |   2 +
 net/xfrm/xfrm_replay.c                 |   3 +-
 net/xfrm/xfrm_state.c                  |   8 ++
 net/xfrm/xfrm_user.c                   | 162 +++++++++++++++++++++++++++++++--
 18 files changed, 219 insertions(+), 62 deletions(-)

