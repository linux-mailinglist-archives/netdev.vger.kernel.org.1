Return-Path: <netdev+bounces-300472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jzdNHSwLNGrALwYAu9opvQ
	(envelope-from <netdev+bounces-300472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:13:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD886A125C
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:13:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LHxTbuLq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300472-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300472-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 497203092D4B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1163F3FCB3E;
	Thu, 18 Jun 2026 15:09:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0B43FBB47
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:09:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795383; cv=none; b=NELwNTMRvlkIapJCVVriD6V3ERskTaWu2a6VGpbOiaTg07RARggCAruHCsGUCRwjRwrDTXZqkyt+Z516Uo3tFEg2yyn9GV7nCpqjWja+Udxxa3GCmXBPZjn7c8iGgXtiVh8jx2y+LaJYLaS8nIi2PmGgvZPWWiDQ6C0Bcn0slhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795383; c=relaxed/simple;
	bh=P4a5L+pxLj9M6no31bX83R77apuWeXqglYwceEj3k0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNW5LxlZIDtQ/Us1rogbPdnNgjh+3e50mRnPIS3qxCLtDkj78aHXZgxhcmYyJ8oAqWP18wszgm4LY6ctWkQpzU8bL+ARux+wuJWZtQAab88Q3+ds02RyfhPJZvO6sky5lzN0MzrHRLqlPM4vfKCBABGvK6pVSVYZQtblQfoaxPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHxTbuLq; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781795380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8kwvym+FwOGhsUuGGMnEIFmKIYJtNtuISVIci+MTjJ8=;
	b=LHxTbuLqtmCg+oEWs+mWuqjCJy5zYHly0JNPyizYQ4S+Et/59ccoqoWwOHQ4pB8XW2AKYj
	ecX9psZp/WWD7a331Wka23nM/5qV2W/Mn98KHYNXhAicAKHfGLnRrB5rVUa5T4Z9vqZ3Lb
	tjewLRl8uXe64FaSnjW/W80QSuHGiDs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-m3J3Hl3jPxeOh9tBvIrBbQ-1; Thu,
 18 Jun 2026 11:09:31 -0400
X-MC-Unique: m3J3Hl3jPxeOh9tBvIrBbQ-1
X-Mimecast-MFC-AGG-ID: m3J3Hl3jPxeOh9tBvIrBbQ_1781795360
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A5011800595;
	Thu, 18 Jun 2026 15:09:19 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.243])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1ED91800664;
	Thu, 18 Jun 2026 15:09:14 +0000 (UTC)
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
	Alice Michael <alice.michael@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 0/2] ice: fix DFLT Rx rule handling for promisc and switchdev
Date: Thu, 18 Jun 2026 17:09:09 +0200
Message-ID: <cover.1781786935.git.poros@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300472-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:poros@redhat.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:alice.michael@intel.com,m:jacob.e.keller@intel.com,m:ivecera@redhat.com,m:michal.swiatkowski@linux.intel.com,m:grzegorz.nitka@intel.com,m:intel-wired-lan@lists.osuosl.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFD886A125C

Two fixes for the uplink default VSI Rx rule (DFLT) on E810 when the
netdev is in IFF_PROMISC.

Patch 1 drops the redundant per-VLAN promisc expansion that exhausts
the FLU pool on a wide VLAN trunk across several PFs.

Patch 2 keeps the DFLT Rx rule across a switchdev teardown instead of
clobbering the promisc state the operator asked for.

Lab tested on E810-C: functional, VLAN isolation, IFF_ALLMULTI
regression, stress/flap and switchdev-toggle suites pass with no AQ
errors, and the FLU pool stays under its ceiling with all four PFs
loaded.

Petr Oros (2):
  ice: skip per-VLAN promisc rules when default VSI Rx rule is set
  ice: preserve uplink DFLT Rx rule on switchdev release

 drivers/net/ethernet/intel/ice/ice_eswitch.c | 32 ++++++-
 drivers/net/ethernet/intel/ice/ice_main.c    | 90 +++++++++++++++-----
 2 files changed, 98 insertions(+), 24 deletions(-)

-- 
2.53.0


