Return-Path: <netdev+bounces-111185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D9930338
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 04:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609811C211DE
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 02:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E63D14F70;
	Sat, 13 Jul 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="MVRaxtLh"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F02F9DA;
	Sat, 13 Jul 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720837164; cv=none; b=rW1XdYppDPj5p69/PeK9mVWLygH2usqRb1Jk9oHIa/Hsa2wXkSbDx98jOy68/i0Omn1JH62XpwYSXljWeWLunZN58qtTPVL+QNBKMBS8UbIeV6P415jngoPLgc2kpc74OBWmvjL2Nqt2VlaQertCIZtr/ANVMqVTpmouuQpvTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720837164; c=relaxed/simple;
	bh=EBZ7aRHtLYYYyPyxQmOao/9I3c3hyd0mmUgKonz52/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BHc/X1/IMZHWNiOSYcV1kRPo1AmuFD6SvGbv/DaUYIvX9wD/fsYn/9YweilnQ4NNYIlDYhiUg23K9ccieQEVtIvMZNygsVUBaEpF/ym3guDDhxY5UgMMBlN4fPtWqwkEgPpvwUrxyFG4CpkenlggeuW57DsHIbFbLuZhArABj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=MVRaxtLh; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720837159;
	bh=EBZ7aRHtLYYYyPyxQmOao/9I3c3hyd0mmUgKonz52/8=;
	h=From:To:Cc:Subject:Date:From;
	b=MVRaxtLhxRb1jC846dEkURXsI6m25jGvGVDqgccXvSFysjKeB1nSOg8YgE1rib6t+
	 oJa+VwQES2VGru1jgK0HRTpzNR0KKjPozqDq4ZOrRRXDQoFRt5tYHqfyVNoc23fnpa
	 /jh0XVlTTakcyNIfBQaPqf4m85QbIJOUKMCzJVyYw3Psqwe131dWnSP1xNpgpBycVu
	 OyWilq3gv/Yf8A0R6GUspg8koGV7//jgMurrAJTK0xVYQC6nZctwnt+rh4fk+d2NwN
	 pflW+FqlXTLjl+CiES6bFc9j94NNJSFFDp0JJ5L2k8cd5RkpT/kSt9s0GPpPs8hiFF
	 e5T6uY35O+gVQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id EF70C60083;
	Sat, 13 Jul 2024 02:19:18 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 40D522011BC; Sat, 13 Jul 2024 02:19:11 +0000 (UTC)
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
	Donald Hunter <donald.hunter@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 00/13] flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
Date: Sat, 13 Jul 2024 02:18:57 +0000
Message-ID: <20240713021911.1631517-1-ast@fiberby.net>
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

iproute2 RFC v2 patch:
https://lore.kernel.org/560bcd549ca8ab24b1ad5abe352580a621f6d426.1720790774.git.dcaratti@redhat.com/

---
Changelog:

v4:
- Define control flags in ynl
- Describe enc-flags in ynl
- Propagate tca[TCA_OPTIONS] to NL_REQ_ATTR_CHECK
  (all 3 requested by Jakub)
- Link to new iproute2 patch in cover
- Add Reviewed-By from Davide to patches that haven't changed since v3.

v3: https://lore.kernel.org/20240709163825.1210046-1-ast@fiberby.net/
- Retitle patch 1 (tunnel flags -> control flags)

v2: https://lore.kernel.org/20240705133348.728901-1-ast@fiberby.net/
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

Asbjørn Sloth Tønnesen (13):
  net/sched: flower: refactor control flag definitions
  doc: netlink: specs: tc: describe flower control flags
  net/sched: flower: define new tunnel flags
  net/sched: cls_flower: prepare fl_{set,dump}_key_flags() for ENC_FLAGS
  net/sched: cls_flower: add policy for TCA_FLOWER_KEY_FLAGS
  flow_dissector: prepare for encapsulated control flags
  flow_dissector: set encapsulated control flags from tun_flags
  net/sched: cls_flower: add tunnel flags to fl_{set,dump}_key_flags()
  net/sched: cls_flower: rework TCA_FLOWER_KEY_ENC_FLAGS usage
  doc: netlink: specs: tc: flower: add enc-flags
  flow_dissector: cleanup FLOW_DISSECTOR_KEY_ENC_FLAGS
  flow_dissector: set encapsulation control flags for non-IP
  net/sched: cls_flower: propagate tca[TCA_OPTIONS] to NL_REQ_ATTR_CHECK

 Documentation/netlink/specs/tc.yaml |  26 +++++
 include/net/flow_dissector.h        |  30 ++---
 include/net/ip_tunnels.h            |  12 --
 include/uapi/linux/pkt_cls.h        |  11 +-
 net/core/flow_dissector.c           |  50 +++++----
 net/sched/cls_flower.c              | 168 ++++++++++++++++------------
 6 files changed, 177 insertions(+), 120 deletions(-)

-- 
2.45.2


