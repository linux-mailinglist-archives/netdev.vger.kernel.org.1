Return-Path: <netdev+bounces-301072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T2BvNxAfOWqanAcAu9opvQ
	(envelope-from <netdev+bounces-301072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:40:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438786AF2B4
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:40:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=OhhnndO9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301072-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301072-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D000303D13A
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B52C1594;
	Mon, 22 Jun 2026 11:34:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993502C0260
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782128079; cv=none; b=u6ckHVTykUSSfHdtIjVM60A2l5EPWCmJ7HUCSBmUoTGKP/eE1eQNgFi+ndDLV3ZwHuZI58El+8sVSoEPwONV4EmmEuJZDoDlkI3V2or5MsrzPH5X72rbj31Doh8Ov1HEiLGg89v8BHiR6h7MeAqQbPBSsGcT70ZwQLvixa3sr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782128079; c=relaxed/simple;
	bh=7AyaE7dlqIpv+p4UqSjjUZWRBDykwn+W0zrWfjRjJ68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g05Vy1xq2SCHN/iZ2dAs/oHbcigRda61tEUTIamKL1BE3fNpVLap2ajC4o0F9wZp9nPrgLR2WEMxdgNK3/l+gx4wsmHDjAMKIbaR3jcIyYBFMoYrTbbpgFrTqgAlXfYPJVxyNBWnpZ/OAhn4wRnE2c+a3z2UvuYpkNb9XxU8XWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhhnndO9; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782128077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XOFM6abGX4+5COwBd2vN6B30fcL12g1ozNGw26r98DM=;
	b=OhhnndO9x1PP7XB0EYyNtpsrdjczMg8of0iUb3HB0m1y+7+oWzZls7EMqjranKafhoa1zK
	5MRHu4t0Q7V66FRW5K3RbtED1S5KyQHNc+OmHGLRpZvinVCgl+fAm4E482R8lB+PAo+YLs
	1IPQsaUtQX0tHsfyYj73Mi3wAKAxF9w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-tBkleTrwOwOrqfiWQtDVOw-1; Mon,
 22 Jun 2026 07:34:36 -0400
X-MC-Unique: tBkleTrwOwOrqfiWQtDVOw-1
X-Mimecast-MFC-AGG-ID: tBkleTrwOwOrqfiWQtDVOw_1782128075
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD991944CED
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 11:34:32 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.33.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 79557195608D;
	Mon, 22 Jun 2026 11:34:31 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>
Subject: [PATCH iwl-net v2 0/2] ice: fix DFLT Rx rule handling for promisc and switchdev
Date: Mon, 22 Jun 2026 13:34:26 +0200
Message-ID: <20260622113428.2565255-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301072-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 438786AF2B4

Two fixes for the uplink default VSI Rx rule (DFLT) on E810 when the
netdev is in IFF_PROMISC.

Patch 1 drops the redundant per-VLAN promisc expansion that exhausts
the FLU pool on a wide VLAN trunk across several PFs.

Patch 2 keeps the DFLT Rx rule across a switchdev teardown instead of
clobbering the promisc state the operator asked for.

Changes since v1:
- Patch 2: reworked to avoid the service task entirely. v1 scheduled a
  filter sync in ice_eswitch_disable_switchdev(); that work could run
  after ice_remove() freed the uplink VSI (use-after-free) and was not
  guaranteed to fire if ice_set_rx_mode() never ran again. v2 keeps or
  drops the DFLT Rx rule synchronously in ice_eswitch_release_env() by
  testing the live netdev->flags IFF_PROMISC, the same value
  ice_cfg_vlan_pruning() already keys on. No service task is scheduled
  and no symbol is exported. Dropped Aleksandr's Reviewed-by since the
  fix mechanism changed.
- Patch 1: no functional changes, collected Aleksandr's Reviewed-by.

Link to v1:
https://lore.kernel.org/all/cover.1781786935.git.poros@redhat.com/

Petr Oros (2):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 18 +++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 90 +++++++++++++++-----
 2 files changed, 84 insertions(+), 24 deletions(-)

-- 
2.53.0


