Return-Path: <netdev+bounces-109502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7269289D7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C851F22903
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1715F3E6;
	Fri,  5 Jul 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="eALgaQeH"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443DB155A25;
	Fri,  5 Jul 2024 13:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186461; cv=none; b=tGI/V/Fj3UssVQWC8YeqtoQMRGZkB9fMWARoJrXTN1Huwn8qDZnVHg7YhupCL0jCUjTxUiehteVUIMHP7bxoqyA9+22QByUxQEDmWBwkZPOYiU4JrbXJRxDHbyUXcdkYqHW1KQWlv/vEY1FVzAWqwdeXvAt/9o3EOrk89L2LFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186461; c=relaxed/simple;
	bh=Ut2thkfTCY+dzcyEc4GpL/dIubksO+vlTjNGrJChsok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZBuLvH5SwVnDgTht3hnNrqPkJPFAyFzLx9wkAvSxAZTcURHcsZz9D3mTIPW7EZFVT1/Mqcsj48MDwgkNkuUr953ZXO8xKGYiz2/22LYtWCAdHLmFG98I/tFzWEOZdh1DIk6j9sxvx9oV65MuvtBagWurgDL2NKKDTrWifM7keYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=eALgaQeH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720186451;
	bh=Ut2thkfTCY+dzcyEc4GpL/dIubksO+vlTjNGrJChsok=;
	h=From:To:Cc:Subject:Date:From;
	b=eALgaQeHRk7+sykJRDVvA9e1JB4i/aKBBNB2IzOeE+oCcbPm4dxF9stDkwPKoolem
	 lnp98Z5gMjaNbgbfY7lp5xl5datEBUypPLPaQN5fACGrW9wP34EKq596iRihNN8Yii
	 nA9TvEoY7gfKJxe7JUNIZ/KuU9kCVdXGOVKB+NUsh+AzjdXpCHN1zmNuhVOfvQYmA/
	 Isf1ZPZYvPbQIowHM3Jr0oDvAYsETgdePw337ceCa64kxCrX1ZnmrOiUXGgTxsHhHR
	 23MyhIMANaNB7zxO4OCs0jQ8MnzLFaveQsw1ZBnGdoeUjnk+vxiE2xgmht08AAIqqF
	 5WTjWuo/A+jzg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E574960078;
	Fri,  5 Jul 2024 13:34:09 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 4601B20474A; Fri, 05 Jul 2024 13:33:49 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Florian Westphal <fw@strlen.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 00/10] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
Date: Fri,  5 Jul 2024 13:33:36 +0000
Message-ID: <20240705133348.728901-1-ast@fiberby.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use the unused
u32 flags field in FLOW_DISSECTOR_KEY_ENC_CONTROL, instead of adding
a new flags field as FLOW_DISSECTOR_KEY_ENC_FLAGS.

I have defined the new FLOW_DIS_F_* and TCA_FLOWER_KEY_FLAGS_*
flags to co-exist with the existing flags, so the meaning
of the flags field in struct flow_dissector_key_control is not
depending on the context it is used in. If we run out of bits
then we can always split them up later, if we really want to.
Future flags might also be valid in both contexts.

iproute2 RFC patch: (needs update of uAPI headers)
https://lore.kernel.org/897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com/

---
Changelog:

v2:
- Refactor flower control flag definitions
  (requested by Jakub and Alexander)
- Add Tested-by from Davide Caratti on patch 3-10.

v1: https://lore.kernel.org/20240703104600.455125-1-ast@fiberby.net/
- Change netlink attribute type from NLA_U32 to NLA_BE32.
- Ensure that the FLOW_DISSECTOR_KEY_ENC_CONTROL
  is also masked for non-IP.
- Fix preexisting typo in kdoc for struct flow_dissector_key_control
  (all suggested by Davide)

RFC: https://lore.kernel.org/20240611235355.177667-1-ast@fiberby.net/

Asbjørn Sloth Tønnesen (10):
  net/sched: flower: refactor tunnel flag definitions
  net/sched: flower: define new tunnel flags
  net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
  net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
  flow_dissector: prepare for encapsulated control flags
  flow_dissector: set encapsulated control flags from tun_flags
  net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
  net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
  flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
  flow_dissector: set encapsulation control flags for non-IP

 include/net/flow_dissector.h |  30 ++++----
 include/net/ip_tunnels.h     |  12 ---
 include/uapi/linux/pkt_cls.h |  11 ++-
 net/core/flow_dissector.c    |  50 ++++++------
 net/sched/cls_flower.c       | 142 ++++++++++++++++++++---------------
 5 files changed, 135 insertions(+), 110 deletions(-)

-- 
2.45.2


