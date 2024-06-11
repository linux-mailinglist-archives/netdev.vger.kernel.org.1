Return-Path: <netdev+bounces-102765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC19047DD
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 01:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159211C22725
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 23:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBBA157E6F;
	Tue, 11 Jun 2024 23:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IHIQHmUG"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AB156F27;
	Tue, 11 Jun 2024 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718150069; cv=none; b=spGrm15DsvuY1p7FBFA/LBqD8capNIt+xN1Zfp0OqeJNQSDTxGXfrFpmTJOBOPXeeT7yJHO/KrwsMYP8M3o05l14FOEQto2sj0CXiKR6/EAYhDB6qunc/o4UZH1VQKLN1aoo8ZAsmkDrLp43nzXzIRV35QK9kZ0aSV0uTLlAcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718150069; c=relaxed/simple;
	bh=6WLbAEInjDjxdoJ59nU4KB2k9ELUpSH0unl5+CoajBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oYPxtoPP8u9fhyx+Y1URH3jsmu+4u7jmTFOM/P1zE4X91Wn4/WPCv07fAPMw70RSAjc82e80Mxl2D0ofJaQiw+zd9Av5iUALLIB1OlXIZZPSMYFvQVe35w5+FOJ4avzlH8LcwkA8cNviHZgoS2l+TF4LgiTQZh5hiX9f0jh/H8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IHIQHmUG; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1718150060;
	bh=6WLbAEInjDjxdoJ59nU4KB2k9ELUpSH0unl5+CoajBA=;
	h=From:To:Cc:Subject:Date:From;
	b=IHIQHmUGnI4B/OK/rhT8tjEPPf3KfKkAd9EHGPONFq6I4FMHrwBFTQP9FH39j1Rq8
	 m0JhA5wMmBX8Q4xp+O0rZyhNSyBlU/AEnkCe6ncBgPRb23y0IDa8xWnM1ZbnUeomis
	 Lt6BgyLMVmnUGJdrkpCUICx4M3H2IQJ1ztNuvKu7LV8ZeR2f/kJE8hawKl9MQAQz9w
	 v6p8Z9XZod2ydZqV90ymmH+UECZISXL69b/6e82//ynLEvlIO1TpvNNf/7xm1D+UbE
	 8/tNs6me4rK7CbxZ9/ya4EJ0P5ZrWUAZShtPzDf9F47nu9MeO+HyuQg9fGzxW3XwLB
	 LTZZZN43GjP0g==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 723B1600A2;
	Tue, 11 Jun 2024 23:54:17 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 55203201944; Tue, 11 Jun 2024 23:54:00 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: Davide Caratti <dcaratti@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 0/9] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
Date: Tue, 11 Jun 2024 23:53:33 +0000
Message-ID: <20240611235355.177667-1-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series reworks the recently added TCA_FLOWER_KEY_ENC_FLAGS
attribute, to be more like TCA_FLOWER_KEY_FLAGS, and use
the unused u32 flags field in TCA_FLOWER_KEY_ENC_CONTROL,
instead of adding another u32 in FLOW_DISSECTOR_KEY_ENC_FLAGS.

I have defined the new FLOW_DIS_F_* and TCA_FLOWER_KEY_FLAGS_*
flags to coexists for now, so the meaning of the flags field
in struct flow_dissector_key_control is not depending on the
context that it is used in. If we run out of bits then we can
always make split them up later, if we really want to.

Davide and Ilya would this work for you?

Currently this series is only compile-tested.

Preliminary discussion about these changes:
https://lore.kernel.org/netdev/ZmFuxElwZiYJzBkh@dcaratti.users.ipa.redhat.com/

---
If this series is put directly on top of:
668b6a2ef832 ("flow_dissector: add support for tunnel control
flags") and 1d17568e74de ("net/sched: cls_flower: add support
for matching tunnel control flags") as can be done by reverting
them, cherry-picking them, and then applying this series.

Then it gives this combined diffstat:
$ git diff --stat ...
 include/net/flow_dissector.h |  17 ++++-
 include/uapi/linux/pkt_cls.h |   8 ++
 net/core/flow_dissector.c    |  34 +++++---
 net/sched/cls_flower.c       | 103 ++++++++++++++++++++++----
 4 files changed, 136 insertions(+), 26 deletions(-)

Normal shortlog and diffstat below:

Asbjørn Sloth Tønnesen (9):
  net/sched: flower: define new tunnel flags
  net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
  net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
  flow_dissector: prepare for encapsulated control flags
  flow_dissector: set encapsulated control flags from tun_flags
  net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
  net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
  flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
  flow_dissector: set encapsulation control flags for non-IP

 include/net/flow_dissector.h |  26 +++----
 include/net/ip_tunnels.h     |  12 ----
 include/uapi/linux/pkt_cls.h |   5 ++
 net/core/flow_dissector.c    |  50 ++++++-------
 net/sched/cls_flower.c       | 135 ++++++++++++++++++++---------------
 5 files changed, 123 insertions(+), 105 deletions(-)

-- 
2.45.1


