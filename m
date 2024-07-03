Return-Path: <netdev+bounces-108803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC40925A4A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F6C1F2186C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CB3187332;
	Wed,  3 Jul 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="jm0wtU/j"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFEF186E53;
	Wed,  3 Jul 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003646; cv=none; b=A8lQLqQrcxIb4mTyDXsPNt361xSYuLsGbbvnaH6VOmZ+J0DzVd7DT3zQyfv8GKe+8n0Ebw2ece+G/8Si+LNdEGScJlmSeke/T4idbmtRD4ND/Cp+7lDe/nM5TGrdmvT+03fLIZz60TcamOsx0MLnN17tmbPKPLxkHAzkMXXH5E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003646; c=relaxed/simple;
	bh=AbAAw28QoG6NoGsNEmrB3VhpwTU54T25hTZDA9eIpb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cRWTIjsP0VZV2W/kVJzyDV+fimX+CG0lLB8m78rr1l8u69FAFf1SJNqRuGhVd9UrkaCl8ORIyFY5QowttbgtwNfxfCGTu9sBLmf1i6e2/kH5Lw3iyfYmdfLmLJhEeio1EQfJxvh5dM+LoCfV0eWDLrBhPjVCviAy0Lq9663wjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=jm0wtU/j; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720003635;
	bh=AbAAw28QoG6NoGsNEmrB3VhpwTU54T25hTZDA9eIpb4=;
	h=From:To:Cc:Subject:Date:From;
	b=jm0wtU/jWhXCDyz4lmlpTRpLFg85SBk/He3u2uMG18a/592ckn8IiIQUQQjSf26yo
	 4w2vGj3Nr7rWcDPqyK+ZH0uPs9XRCk2+CVDWF+FgCXbkMgGuB+f3w9Gi4hiPdtM0OM
	 KG3oWqrhSvZVBeLbVk6L45vzlXdFFb3VSrw6r87keFfs+lKxEnJetSDv5iSvd9PzAH
	 7nRSNE1yGQFoaLlBan3A/tPv2qcsSdB7VUgH7BbcvZPcp7zcF7pvqiuoe5Kfy7TTb3
	 8eyB9Ce+GZywJjZ21ypNBgAHgXMSPQT5W/wUUzkRFEzZpssPvFQ3W3rc1w685pkniJ
	 9aIC9NxR3+vsg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 3A7A36007E;
	Wed,  3 Jul 2024 10:46:59 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 01E18201B92; Wed, 03 Jul 2024 10:46:06 +0000 (UTC)
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
Subject: [PATCH net-next 0/9] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
Date: Wed,  3 Jul 2024 10:45:49 +0000
Message-ID: <20240703104600.455125-1-ast@fiberby.net>
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

iproute2 RFC patch:
https://lore.kernel.org/897379f1850a50d8c320ca3facd06c5f03943bac.1719506876.git.dcaratti@redhat.com/

---
Changelog:

v1:
- Change netlink attribute type from NLA_U32 to NLA_BE32.
- Ensure that the FLOW_DISSECTOR_KEY_ENC_CONTROL
  is also masked for non-IP.
- Fix preexisting typo in kdoc for struct flow_dissector_key_control
  (all suggested by Davide)

RFC: https://lore.kernel.org/20240611235355.177667-1-ast@fiberby.net/

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
 include/net/ip_tunnels.h     |  12 ---
 include/uapi/linux/pkt_cls.h |   9 ++-
 net/core/flow_dissector.c    |  50 ++++++------
 net/sched/cls_flower.c       | 142 ++++++++++++++++++++---------------
 5 files changed, 129 insertions(+), 110 deletions(-)

-- 
2.45.2


