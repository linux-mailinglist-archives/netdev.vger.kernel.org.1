Return-Path: <netdev+bounces-303675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hUC3CekfRWq27QoAu9opvQ
	(envelope-from <netdev+bounces-303675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:10:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767DF6EE8AA
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 16:10:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NT9QN1gU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24D25325D253
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6448C8D2;
	Wed,  1 Jul 2026 13:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B096226CFE
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 13:36:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912979; cv=none; b=sXLBt3RKtkVZDnMUfy58dS/3rc25Mtj6rVwhE+yg+lrHTu9ovwGJ6TcIeX2fi1iaxmOFqKAO2zoECl+hKut6ps101WZqmlMmVo5Qla4bt+7GDgICHT8U0IAPsXFaOZD5DRqETe/isOLNA1fK/L7TJyQa83DkIs+4CIkk5/v2WII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912979; c=relaxed/simple;
	bh=6JvXEFSFR7caNPwrbqfA3y8Ay2ADdCyx3aRppBs+Zrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQ07TgYXPTbXodQ6x/Ws5swE79tNCopyKRJob32jk1kP9vZ/2bEWWgM0/LUUDoXPk/Zq5OBS9/Ki7unwuyjUNxNsBOzxiBRCmxJKxlKPEM8CUDN83uj+hTVv+EKB3siX5uRzuyhCJvRRPmfh28lZ/gRJAxPjoqb7gbYDO5mgjAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NT9QN1gU; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782912975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bxNSXwEfd2C9VIxBjMEbeHul80x6G0tO5M0XauZwaxQ=;
	b=NT9QN1gU6K6NmVk3i6WS0yChoL0TJhHcttN9tOmKmPmvP3BvYuUFlCLwUPdg53qP694VND
	Q5y6SXIWPEkbL5BPLfo42t1lQyCu7q9fxlEiDe6K6m66HxcRJjZMoVTz2ALUQSuxQHgKgU
	CL/bYhh3qMeEt0qdP3G1g9i6dwXGvlU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-Q5LFiP8EMGCGnLR0AFbI3g-1; Wed,
 01 Jul 2026 09:36:11 -0400
X-MC-Unique: Q5LFiP8EMGCGnLR0AFbI3g-1
X-Mimecast-MFC-AGG-ID: Q5LFiP8EMGCGnLR0AFbI3g_1782912969
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FA311808978;
	Wed,  1 Jul 2026 13:36:09 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A076E180076D;
	Wed,  1 Jul 2026 13:36:04 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v3 0/2] ice: fix DFLT Rx rule handling for promisc and switchdev
Date: Wed,  1 Jul 2026 15:35:59 +0200
Message-ID: <20260701133601.2118382-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303675-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ivecera@redhat.com,m:jacob.e.keller@intel.com,m:alice.michael@intel.com,m:horms@kernel.org,m:martyna.szapar-mudlaw@linux.intel.com,m:marcin.szycik@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 767DF6EE8AA

Two fixes for the uplink default VSI Rx rule (DFLT) on E810 when the
netdev is in IFF_PROMISC.

Patch 1 drops the redundant per-VLAN promisc expansion that exhausts
the FLU pool on a wide VLAN trunk across several PFs.

Patch 2 keeps the DFLT Rx rule across a switchdev teardown instead of
clobbering the promisc state the operator asked for.

Changes since v2:
- Patch 1: dropped the two vid=0 ICE_SW_LKUP_PROMISC <->
  ICE_SW_LKUP_PROMISC_VLAN recipe-swap guards; each swap is net-zero and
  guarding the demote stranded the vid=0 rule when the last VLAN was
  removed under the DFLT rule.
- Patch 1: drop the now-redundant per-VID multicast promisc rules right
  after ice_set_dflt_vsi(). A bridge join raises IFF_ALLMULTI and
  IFF_PROMISC in separate sync passes, so the allmulti pass expands the
  per-VID rules before the DFLT rule exists; the cleanup keeps them from
  lingering and exhausting the FLU pool. exit_dflt_promisc() reinstates
  them on promisc off.
- Patch 1: issue ice_set_promisc(ICE_MCAST_PROMISC_BITS) whenever the
  netdev is promiscuous, not only when this VSI installs the default VSI
  rule, so multicast promisc is not lost when the rule is already in use
  (owned by another VSI, or preserved across a switchdev session).
- Patch 1: hoisted the combined VLAN promisc mask in ice_clear_promisc()
  into a local for alignment. Dropped Aleksandr's Reviewed-by since the
  code changed.
- Patch 2: corrected the Fixes tag to 5c07be96d8b3, the commit that made
  ice_eswitch_setup_env() use the idempotent ice_set_dflt_vsi(); before
  it a pre-existing promisc DFLT rule made setup fail with -EEXIST so the
  release path was never reached.

Link to v2:
https://lore.kernel.org/all/20260622113428.2565255-1-poros@redhat.com/

Link to v1:
https://lore.kernel.org/all/cover.1781786935.git.poros@redhat.com/

Petr Oros (2):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release

 drivers/net/ethernet/intel/ice/ice_eswitch.c |  18 ++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 111 +++++++++++++++----
 2 files changed, 104 insertions(+), 25 deletions(-)

-- 
2.54.0


