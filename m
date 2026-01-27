Return-Path: <netdev+bounces-254020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MB+DMuQ8eWkmwAEAu9opvQ
	(envelope-from <netdev+bounces-254020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:32:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC289B14B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 23:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0533055819
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769125487B;
	Tue, 27 Jan 2026 22:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6NL3ikA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A292D660E
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 22:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553058; cv=none; b=guKkOPZ7xaCy4d6Dej77PGdHc2tyJq/bLn68930oEFFSsrD+WEXRBylALNknGEzffUlzQPR0gi+3AutFk4K9tkTO8AgyjnbDApZog/NnB6CO67L+XxeZkHBLjUe/Gg/jgtEjwFoa5jegHoWZf91xOMGowgJGGZpzFsbIzigfM+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553058; c=relaxed/simple;
	bh=e0I4SBy3yMZHfTqRdAw1mnt5JfamU2pL9w0ooXrEd2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANZlB0AvxBYluPyLCX2hkbtppjeTQ0LHDnKDy3k4u9wwQI9vOiy1T6iXoiYh2W1tPbF2e94nnWA79f4BVb50oJL5wYCxSht8x/DGmBFmVouirtHPYPjkxvLg6g5iG24efDnIOFcKEzE6WAokYyxdrxCwmhqmEeTgKitc0M35nkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6NL3ikA; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769553057; x=1801089057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e0I4SBy3yMZHfTqRdAw1mnt5JfamU2pL9w0ooXrEd2g=;
  b=B6NL3ikANkFsydmTIv61eVCV6+lgZvtfAcSdWLSlRgISfqUJm6a+/xSw
   A+WYoHKrCqsKTqf5UZVogYd7zSikA9KrZaKGx3nYY0gIFoJzLacEF2NnJ
   YdDmaPhNyWjcUcgGOXQxlOAhlgjt/i5yd20UIJVQZjmYj3WtSPq9riUuZ
   qq3RBCpSl9tHXwdRyRpSKDb1S5EeVRsFMdGBi429LKyeGAzNX39SMcfsP
   J1CPCiEf5F3ahy3dHhfblfaHxji/VtkdrdrAkRGl8WMEPk8XBSAq75vsL
   MNJHemQC7PqFGPpbc28Y4wg7UkiQv7UEUNnzkCwEzjl+d/wU68qA5UkOd
   g==;
X-CSE-ConnectionGUID: b2NR2q5PQiOqatJhAye7FA==
X-CSE-MsgGUID: gecsZAEaQseeXBxAwS2d9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="93418613"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="93418613"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 14:30:54 -0800
X-CSE-ConnectionGUID: iXc07w0xSmWb2XTHdNCqtw==
X-CSE-MsgGUID: HeeSEK8US9GfyhSRPNODhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="245714648"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 14:30:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	anthony.l.nguyen@intel.com,
	jbrandeb@kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	IWL <intel-wired-lan@lists.osuosl.org>
Subject: [PATCH net 4/4] ice: stop counting UDP csum mismatch as rx_errors
Date: Tue, 27 Jan 2026 14:30:45 -0800
Message-ID: <20260127223047.3979404-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
References: <20260127223047.3979404-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254020-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,intel.com:dkim,intel.com:email,intel.com:url,intel.com:mid,osuosl.org:email]
X-Rspamd-Queue-Id: 0FC289B14B
X-Rspamd-Action: no action

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

Since the beginning, the Intel ice driver has counted receive checksum
offload mismatches into the rx_errors member of the rtnl_link_stats64
struct. In ethtool -S these show up as rx_csum_bad.nic.

I believe counting these in rx_errors is fundamentally wrong, as it's
pretty clear from the comments in if_link.h and from every other statistic
the driver is summing into rx_errors, that all of them would cause a
"hardware drop" except for the UDP checksum mismatch, as well as the fact
that all the other causes for rx_errors are L2 reasons, and this L4 UDP
"mismatch" is an outlier.

A last nail in the coffin is that rx_errors is monitored in production and
can indicate a bad NIC/cable/Switch port, but instead some random series of
UDP packets with bad checksums will now trigger this alert. This false
positive makes the alert useless and affects us as well as other companies.

This packet with presumably a bad UDP checksum is *already* passed to the
stack, just not marked as offloaded by the hardware/driver. If it is
dropped by the stack it will show up as UDP_MIB_CSUMERRORS.

And one more thing, none of the other Intel drivers, and at least bnxt_en
and mlx5 both don't appear to count UDP offload mismatches as rx_errors.

Here is a related customer complaint:
https://community.intel.com/t5/Ethernet-Products/ice-rx-errros-is-too-sensitive-to-IP-TCP-attack-packets-Intel/td-p/1662125

Fixes: 4f1fe43c920b ("ice: Add more Rx errors to netdev's rx_error counter")
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jake Keller <jacob.e.keller@intel.com>
Cc: IWL <intel-wired-lan@lists.osuosl.org>
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index de488185cd4a..71c6d53b461e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6982,7 +6982,6 @@ void ice_update_vsi_stats(struct ice_vsi *vsi)
 		cur_ns->rx_errors = pf->stats.crc_errors +
 				    pf->stats.illegal_bytes +
 				    pf->stats.rx_undersize +
-				    pf->hw_csum_rx_error +
 				    pf->stats.rx_jabber +
 				    pf->stats.rx_fragments +
 				    pf->stats.rx_oversize;
-- 
2.47.1


