Return-Path: <netdev+bounces-276592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG+pBLJz1mkWFggAu9opvQ
	(envelope-from <netdev+bounces-276592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:26:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C13BE2AB
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1CB630131EC
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840BA3D47C0;
	Wed,  8 Apr 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="ZdtClsO4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f98.google.com (mail-ej1-f98.google.com [209.85.218.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A163CD8AA
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661840; cv=none; b=gvOrX/hb4xUbbd7eElKuyeikx4OSF0dfpYrItz2+oAkvuq2P0ltsP+qRY3VaYJLB7lCm1UpCZPbq74gDD5LN84LhC64cAdYMfrgj1BlsdDXg1kCgnRETmhWca9XJAUFldkQc/t6d7HmntPAs37njmxcrRdHtcoGuQmewRo/I7Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661840; c=relaxed/simple;
	bh=ofB9GQFApud+PzhjyOhDkJcEq9FKMkLMKH2C+x+nHjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HAq0Yh7u5viXFhslo1TJsKNDbGjDWSs21MJyNRkFic3W8wVlD+SBG15igKjBimv+LXEtaodAWeZjpzcTkFhVhOsvwlNK3NJjDXKiGD+++gUoKBNiVMSFpVx5nUAUU5Wb5BWZE92pySTvaF/FaVQPd2xacKEtVaAAE5/6dw2llGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=ZdtClsO4; arc=none smtp.client-ip=209.85.218.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f98.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso704765266b.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1775661837; x=1776266637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B6re6038+LH/2WDCkdgR2ynajFrDPdVe3kDBN1Ta8Ok=;
        b=ZdtClsO4iBN3q598NzR/1ObDcjjJNkheHYVYGUzYUjtAb7Y4Wq9DImMkBquubDz6fa
         yv/0Q5LjU+oclWtP0ENbigpp2k757uY6YKfoeaGK/NDNMkHJ9Pv07oveVFYUyymc5ndf
         X7W9N2qmubVu1pAp9Tfo3JtJPoBtJ9PKJv3A7yvRK/JvXDZ0HQbZoAy/57hwcl6GsAil
         6hi+Q4oTG96i/HgZXwy7rhGEMawkaZGEM1BwifxInGOexJnANpW5VxqnUzfUkEyfYOCx
         2lMOgf/FEDhzItH2aIxGIbPW0fjBb3Bs8gbMi0nUnvHmjt8OmINRHxbv0Penb8PUUoTg
         OLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661837; x=1776266637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6re6038+LH/2WDCkdgR2ynajFrDPdVe3kDBN1Ta8Ok=;
        b=PjB+EyvensEcR1McH1ybEx7lcgSmC4DhAABwvQAXPliSTl4zrTEjn06eQMecANuw1y
         40LXyT06CqFnosKOQ574NgFa12EOXc9mPM/mGMYpCrizr98xUWqWtDvv5lls+ZTj5kq/
         ZfL9ymbzGUNgNEZUXCdVPdk2/p5MdQ56M/SXMTgbJw9EyBsZjGssD+Iu6sFIBjFwhmf0
         TwdBwWXW3wleUcTHlxL3QaidHJqwy5P0ucxZHxoBM+p+kGIDI/TdiOB21vj970UpKJQE
         ZZ6PHOOuRiryl1m+twd/1QPHbtSq8VPomaTAz29Bijz3FjS86a3WBj9eJ/34RXmEi3Tw
         1ABw==
X-Gm-Message-State: AOJu0Yw/PoCywZLX9rUllYiGPIH4HKdwV5ir+4HOt/j32AuURFKq1rcH
	jEg+/Ry5u+qxgXKUgPT7VCDv41U4wm7jb4RO0v0jv3mbOcHmS82QiMPVIR9P6vhz5SXk06bnKQh
	O/OQM3STLS9fNRCHR8UUQRqGp/LAn9kiZAVoy
X-Gm-Gg: AeBDievPxcGd7Ek4/7LJjjgF1sQSSMj8kjAPg1oARLnsZL7dOH2p5MlKRHw4iIHDkd4
	inIRQk9Hg9IIG5XSMeTo3r9wO+2/gyRABTN/erl4ej2vdfD5LyaC2Zcj8A3jZiLvwLZ76lVGILY
	bswYuFXZxbDdE7CHJIuEjLavb2AyQ0nPT5wIODTZOEo3bVy2hTpWeCsDWIEMVUlFQPcvbvaliZT
	u/66nKwicZuqvd2rYmnuEFeddL72ziaYaVTjQ7AnJVl7VgAYfxJTjWxKtrfvB5IRYhy5tFbwp52
	ClFqX8pgtUEYX0VwfPEWZ7xRLFmcCOc9mHTUH5qAiYHZLdb2YYMq9QStzNJqlr/nhcsMWgAL0Hg
	h3/rDHn5rJmtMNqcKddrrbV7WF0vGeZe/nFrQ/Vw//92ONnTGKVsS
X-Received: by 2002:a17:907:6d05:b0:b98:8e42:95ee with SMTP id a640c23a62f3a-b9c67b9e36cmr1061278666b.46.1775661836775;
        Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-b9c3d00eb6bsm136441066b.79.2026.04.08.08.23.56;
        Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 9983327051;
	Wed,  8 Apr 2026 17:23:56 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no valid slaves
Date: Wed,  8 Apr 2026 17:23:48 +0200
Message-Id: <20260408152353.276204-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[louis.scalbert@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276592-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:mid]
X-Rspamd-Queue-Id: 867C13BE2AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi everyone,

This series addresses a blackholing issue and a subsequent link-flapping
issue in the 802.3ad bonding driver when dealing with inactive slaves
and the `min_links` parameter.

When an 802.3ad (LACP) bonding interface has no slaves in the
collecting/distributing state, the bonding master still reports
carrier as up as long as at least 'min_links' slaves have carrier.

In this situation, only one slave is effectively used for TX/RX,
while traffic received on other slaves is dropped. Upper-layer
daemons therefore consider the interface operational, even though
traffic may be blackholed if the lack of LACP negotiation means
the partner is not ready to deal with traffic.

The current behavior is not compliant with the LACP standard. This
patchset introduces a working behavior that is not strictly
standard-compliant either, but is widely adopted across the industry.
It consists of bringing the bonding master interface down to signal to
upper-layer processes that it is not usable.

This patchset depends on the following iproute2 change:
ip/bond: add lacp_fallback support

Patch 1 introduces the lacp_fallback configuration knob, which is
applied in the subsequent patch. The default (legacy) mode preserves
the existing behavior, while the strict mode is intended to force the
bonding master carrier down in this situation.

Patch 2 addresses the core issue when lacp_fallback is set to strict.
It ensures that carrier is asserted only when at least 'min_links'
slaves are in a valid state (collecting/distributing, or collecting
only when coupled_control is disabled).

Patch 3 fixes a side effect of the first patch. Tightening the carrier 
logic exposes a state persistence bug: when a physical link goes down, 
the LACP collecting/distributing flags remain set. When the link returns, 
the interface briefly hallucinates that it is ready, bounces the carrier 
up, and then drops it again once LACP renegotiation starts. Unsetting the 
SELECTED flag when the link goes down forces the state machine through 
DETACHED, clearing the stale flags and preventing the flap.

Patch 4 fixes a side effect of the second patch caused by clearing the
SELECTED flag on disabled ports. After all ports in an aggregator go
down, if only a subset of ports comes back up, those ports can no
longer renegotiate LACP unless all aggregator ports come back up.

Patch 5 adds a test for the bonding legacy and strict LACP fallback modes.

Louis Scalbert (5):
  bonding: 3ad: add lacp_fallback configuration knob
  bonding: 3ad: fix carrier when no valid slaves
  bonding: 3ad: fix mux port state on oper down
  bonding: 3ad: fix stuck negotiation on recovery
  selftests: bonding: add test for fallback mode

 Documentation/networking/bonding.rst          |  33 ++
 drivers/net/bonding/bond_3ad.c                |  38 ++-
 drivers/net/bonding/bond_main.c               |   1 +
 drivers/net/bonding/bond_netlink.c            |  16 +
 drivers/net/bonding/bond_options.c            |  27 ++
 include/net/bond_options.h                    |   1 +
 include/net/bonding.h                         |   1 +
 include/uapi/linux/if_link.h                  |   1 +
 .../selftests/drivers/net/bonding/Makefile    |   1 +
 .../drivers/net/bonding/bond_lacp_fallback.sh | 299 ++++++++++++++++++
 10 files changed, 415 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond_lacp_fallback.sh

-- 
2.39.2


