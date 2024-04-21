Return-Path: <netdev+bounces-89894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355EF8AC1A6
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 00:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612081C2037E
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 22:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA4B44C8F;
	Sun, 21 Apr 2024 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ld1+ShtY"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135BC1BF20
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 22:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713738258; cv=none; b=JZciQOUKxmJgjUPl8R+zI/R4A2QZ1YQMIidKYJBuvKcDKk2SmGL0KyKBMDAOsFA++D51jIT2+ZEMMkTvXhFpV6FydGu+o4e84KdcrL3Msb3zDGy1dUIIaBaPmdJ1GC7XapN9k1m2qp3GjHlBsLRDr38NLNEJJUUDiJaIh0mhCBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713738258; c=relaxed/simple;
	bh=tbBToUBW7ASfmQb482Xw0OA5sI3Gobuk1JxT8IdVDpM=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XscdkjpsGM30MlqgiB4Dzr2X0QJm55msioZKgrz3hafj0YlTpICyTUlu+U9c2/u1xznS8k0FeS2OCBvBW0k2qwVWkptg2WzpQHvN9zT7flwlg/bwMZyrr8Tm8zuZxwb6SXZHB0h2XxN7QjQlouIW29xh8kP0RtF9PuBjNN/lnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ld1+ShtY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DEE21206F0;
	Mon, 22 Apr 2024 00:24:13 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PopVbPdc1QY8; Mon, 22 Apr 2024 00:24:13 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4C9F820518;
	Mon, 22 Apr 2024 00:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4C9F820518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713738253;
	bh=SOTnz9kgeqKogdPOqibboMsgPv8VwH3mUYk7k6BHbdw=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=ld1+ShtYGYRBjkCrJzvvZ6oIJAwXJc9fvGwDxwKxYXlhlgTO8N6jxVf+zghrzq0fQ
	 QGXht0pkBoFXe++X9+mMwrRoliUCUDBuzBn4A/gkse+EWDeMSlxT9dQ3F6qMKXtbRl
	 AnB/OKg7rTY3Luhj15C0XdTHWuRHbJjiQa/xIRbSB4IEkHc3ruACCvb/uuHBME74Ja
	 SLwqTn7LEustlFsYtywvwUGR+vpXSwhr3VtFNBWuJqOazNa/nPOMpx22SZ8qSVtkfS
	 fPpq2is7pdDtHznoWufsq0lVh9fkjxE6cWD+OKhwV1iHk0Ynw0od2MCyQNJ45tGr07
	 Yq5NPITM+yN7g==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 326C180004A;
	Mon, 22 Apr 2024 00:24:13 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 00:24:13 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 00:24:12 +0200
Date: Mon, 22 Apr 2024 00:23:58 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH ipsec-next v11 0/4] xfrm: Introduce direction attribute for SA
Message-ID: <cover.1713737786.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)

Hi,

Inspired by the upcoming IP-TFS patch set, and confusions experienced in
the past due to lack of direction attribute on SAs, add a new direction
"dir" attribute. It aims to streamline the SA configuration process and
enhance the clarity of existing SA attributes.

This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
('in' for input or 'out' for output). Alsp add validations of existing
direction-specific SA attributes during configuration and in the data
path lookup.

This change would not affect any existing use case or way of configuring
SA. You will notice improvements when the new 'dir' attribute is set.

Antony Antony (4):
  xfrm: Add Direction to the SA in or out
  xfrm: Add dir validation to "out" data path lookup
  xfrm: Add dir validation to "in" data path lookup
  xfrm: Restrict SA direction attribute to specific netlink message types

 include/net/xfrm.h        |   1 +
 include/uapi/linux/snmp.h |   2 +
 include/uapi/linux/xfrm.h |   6 ++
 net/ipv6/xfrm6_input.c    |   7 ++
 net/xfrm/xfrm_compat.c    |   7 +-
 net/xfrm/xfrm_device.c    |   6 ++
 net/xfrm/xfrm_input.c     |  11 +++
 net/xfrm/xfrm_policy.c    |   6 ++
 net/xfrm/xfrm_proc.c      |   2 +
 net/xfrm/xfrm_replay.c    |   3 +-
 net/xfrm/xfrm_state.c     |   5 ++
 net/xfrm/xfrm_user.c      | 147 ++++++++++++++++++++++++++++++++++++--
 12 files changed, 194 insertions(+), 9 deletions(-)

--
2.30.2


