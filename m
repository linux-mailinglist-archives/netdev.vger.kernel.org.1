Return-Path: <netdev+bounces-294469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ESeoC39wH2rflwAAu9opvQ
	(envelope-from <netdev+bounces-294469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12E63318D
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 02:08:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=eisbQNCT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294469-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294469-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48A6730F432E
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 23:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0F3D3002;
	Tue,  2 Jun 2026 23:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E01A3CF94E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 23:59:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780444747; cv=none; b=ljvlxHpqDwsmzdFsPBXPFtbFD8zSuA7eJ2FV9bVWY1PK/NUSAzJF4eBz/r7UlKP7fUwL7fpynFJ6/HdHlAe/VZsYoSzJxG0wkOH7CSXFtxTuIp73iIHpNs6i6fPcieWx8/ynMDRjCx7ScI5pgN7uYeXT/k/d4kqzrgdpWobspSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780444747; c=relaxed/simple;
	bh=pxR7nr3c9FNUnFQ6q8DOgpLaxivaEWwt6eezH4HaIMw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SiU4N9W7iwSnXtVseSOb8jYtuqdZAg+8ojZXvaVbxvpub/kUydogrMRq3cWCsxnVidoJmmRu06UTeZKkoQrS+UPS1PSynmybRZ4GFc75jxw1yv8K6Pp3gB2FOjSAJxNiYButYDvcmG9OPfcp8pIAoa0Xpl/4IX6O69cLIIA/LqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eisbQNCT; arc=none smtp.client-ip=209.85.214.201
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c0b35fa876so40133145ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 16:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780444742; x=1781049542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ylsEd+N3GUYWmq2CtHjynnzO2SghoMrBxYGLoVOsJ7E=;
        b=eisbQNCTCmd2uWgrMpN5IRQ9fftMzFOegQLou3jOQkAo72LpfATcXv6eOvsEjaqQTu
         5YO+MvEcUGEN9DMCDtMZrmzSskNzk+B8nZ2g+RhKOUQLq+uGjng0OPLSDbUdcRucJTwI
         F6nYPAgzVi5h9hrDYRi2/buG4qL0iGGCgmj9p6nQD0mvGUatvr76EVkcknO6bAW/3ntx
         dNtOBy47XRYQ9EDrkikmsBJAQflFp9P7+11nUJcEnxj9s/NGrexohsuJL6IVFiuuAwVo
         LtrRi+6NuoyZKEB9PzNl8lQJ/6bijCSUv2i9TjhUT7j2AtuwiaMggSs5S8U3s1TaO/Mw
         7TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780444742; x=1781049542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylsEd+N3GUYWmq2CtHjynnzO2SghoMrBxYGLoVOsJ7E=;
        b=FPFsZVo9M1cFPNcftqd+QLuWwQzY87LqYRz+odDNXSF4jNAWibZRGIoOhLeDANxsKw
         YgSVpplyfMlhHmTB8usWKV1WEpctL0TqjPxbbgj2m7zfu6M812NTAVCezdyeSM7BGDqC
         Zd9Il7TjZ++UKshO2Ssatd8wYCjOyte1yluFY2/SwbD0dFIUcXKZdh6jhyxsPDHsiRAo
         lE4c4WmoQJ+UjCbaJ9Oaj6oIl4pWihVMibodZb24eCYquYiEwlpN2r6BZRP3BckmNATH
         3cPbfEbbN3apaQkr0dShJ/17IARErt8uKy5x3lw0S43CiurUFmvkAuCehCSEMACrL8Uk
         lRZg==
X-Gm-Message-State: AOJu0YyFVVlvPGnBFcJcEw1xM4ZMhuV0mUE1EF65TAZ71J8F5k+UnRY0
	nV5zL4paBXup2Sz/n61minFRiLsHhdu9nAHVrlvlL98VS/R6mKpDBPPYun+9RgPkS0WNrcg6NIP
	JPgt2sca1ibkk05ES25Ip49XxkAsJsT44D8umoJuue3limd2B7lWURO6hDl7CzHnc4RnneLOuFL
	emoE4XPRPCYLHwuvtoH9u4S+lIKCsMQJbQw0rnfLh7v/pViEBmVEFaIibZy0Cw4DA=
X-Received: from pjyl19.prod.google.com ([2002:a17:90a:ec13:b0:36b:cd5f:3e37])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e992:b0:36b:bbee:fb28 with SMTP id 98e67ed59e1d1-36e30742c4emr570865a91.2.1780444741985;
 Tue, 02 Jun 2026 16:59:01 -0700 (PDT)
Date: Tue,  2 Jun 2026 23:58:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602235900.3050782-1-hramamurthy@google.com>
Subject: [PATCH net-next v2 00/15] gve: AdminQ mode related refactors
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, sdf@fomichev.me, willemb@google.com, 
	jordanrhee@google.com, jfraker@google.com, nktgrg@google.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294469-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:joshwash@google.com,m:hramamurthy@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:willemb@google.com,m:jordanrhee@google.com,m:jfraker@google.com,m:nktgrg@google.com,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E12E63318D

This series is preparing the driver for the addition of a new control
plane mode(MailboxQ) by commonizing and reusing as much code as possible.
MailboxQ is a new control plane infrastructure which uses mailbox queues.
This is a new control plane to communicate with the device when the driver
is running on bare-metal instances as well as newer versions of the device.

This series contains 2 main changes to the gve driver's existing control
plane(AdminQ):
1) refactor some initialization/teardown path methods to make it work for
   both control planes.
2) add gve_ctrl_ops structure to the driver for various control plane
   operations

The refactors are mainly around the init, reset and recover paths so that
functionalities could be moved into the control ops like 'set_num_queues',
'set_num_ntfy_blks' etc.

This patch series only sets the control ops for AdminQ mode. This is
intended as a preparation for adding MailboxQ mode in upcoming series
which will add the new control plane infrastructure and then introduce
the corresponding control ops for MailboxQ mode.

The entire list of future patches can be found here for reference:
https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/

Changes in v2:
- Rebased against latest net-next to resolve apply failure for patch 5
- Fixed a few typos in commit messages of patch 9 and 14
- Fixed a kdoc warning in patch 9
- v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy@google.com/

Harshitha Ramamurthy (9):
  gve: don't pass in unused parameter to gve_adminq_free
  gve: refactor initialization with helper functions
  gve: introduce gve_adminq_get_device_properties()
  gve: add a few helper functions to set device properties
  gve: add struct gve_device_info to hold device properties
  gve: introduce control plane operations structure
  gve: introduce ctrl ops to set vectors and Qs
  gve: refactor gve_init_priv for reset path
  gve: add ctrl ops to for queue operations

Joshua Washington (6):
  gve: simplify reset logic
  gve: add gve_ctrl_ops for gve initialization/teardown sequences
  gve: split up notify block allocation and setup paths
  gve: introduce new methods to handle IRQ doorbells
  gve: setup and teardown management interrupts
  gve: add link status/speed ctrl ops

 drivers/net/ethernet/google/gve/gve.h         |  91 +-
 drivers/net/ethernet/google/gve/gve_adminq.c  | 459 +++++++--
 drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 876 +++++++++---------
 5 files changed, 912 insertions(+), 544 deletions(-)


base-commit: 0906c117f81c2ae6e6dbfa82719f79c75e1c9325
-- 
2.54.0.1013.g208068f2d8-goog


