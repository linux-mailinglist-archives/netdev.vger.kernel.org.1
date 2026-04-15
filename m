Return-Path: <netdev+bounces-278659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MWlN2gn32nmPQAAu9opvQ
	(envelope-from <netdev+bounces-278659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:51:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE540099F
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 433A030DF6BB
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B83381AF4;
	Wed, 15 Apr 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kKqqsml3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9C537F742
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232171; cv=none; b=MtgtyVXOZZrv91vY00jaEDqNIaqkBRfGEEsUjIyC8G0MNHWm1tOmORrrCEbmxxZOSkJO9tCN+T6B9SeVynUlyNj/nMtnXLzVsi0aoqXs/VXVZgxIIWk2yJ39cR2Omlq2l97VCMYGkQPdch4Gqau4DgnOScRvQzIAMus9/KA3hzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232171; c=relaxed/simple;
	bh=q8dZwXxASxIX3cHhM6hVyNT/1WwrfsS3pFzHGyjkifs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q8qNf89XyYgbQs1qM4+wx8dzf2ePdSvrf+W0k2YFzhHsPqdh5BBGQnHZwe7teNkcoBKtgeDvnckkIr9vjpVJrpaOYqVZ5S+8jkcympjsH9qO4e1SlA+FFzett44G7ejXri+YAbMFiPa2c9d09KHQsJ/+2JjAy4ob4gfRbVKjS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kKqqsml3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232170; x=1807768170;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=q8dZwXxASxIX3cHhM6hVyNT/1WwrfsS3pFzHGyjkifs=;
  b=kKqqsml3kH9BBNX50siICZw9UTWMv3RZjdy07Z+J1Y8qZNbrZcIfYsuf
   vaSALCdYgc0NLc4XbihtkgpvIHVHeMPBiF0Dt85ZM8EE0TT03oE3PjVXw
   y6DCzIlNMBWKZ2QhG7ydIH6gpQe9KOBl6CRIIfkSEuvG3dLljlLPzD1+e
   tZi0Ke0izV8Yl1KOSMIXC3SRi1fYqraace/dLYjx5LRLVP9yTX6/MZZxf
   ror9i4Gsv8uuNjDIVjaxtr8ZjhlCafULw1Mw2+us3sBWFJktpw/iABVIJ
   XYzoSFb5nQ4OSnSQmm7ujZ+CXCEMkxATKZMaQY/lllBDZavX2N/wpYMVC
   A==;
X-CSE-ConnectionGUID: 332CY0hQSMSp97435recKw==
X-CSE-MsgGUID: 6T/FpcE1QdSikbcSET3VTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105959"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105959"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
X-CSE-ConnectionGUID: noATG2ToQy+hxhI3Gn5Aag==
X-CSE-MsgGUID: RPeyAtg1QmmKc7Jg8jwiag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714813"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:48:03 -0700
Subject: [PATCH net 08/13] ice: fix potential NULL pointer deref in error
 path of ice_set_ringparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-8-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Kohei Enju <kohei@enjuk.jp>, Paul Greenwalt <paul.greenwalt@intel.com>, 
 Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1676;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Yz2QAcHH7onHa01cH617TlXtGrplBta+01Dmpl0752Y=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ao/2PJset/PG67Sdb1Ni16k/XHHJ86JE0V9H1/WC9
 ad7fwtYd5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRjiJGhu3acua7fdj5NjGt
 jPm35Xd9z4t1rNZR4jlTNp1/LeQ9MZeRYYvLsu3agSuTOmyrVW9Oe7A0Qf6W9Aa9L3bhGfP2se3
 xYwEA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278659-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,enjuk.jp:email]
X-Rspamd-Queue-Id: 57AE540099F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kohei Enju <kohei@enjuk.jp>

ice_set_ringparam nullifies tstamp_ring of temporary tx_rings, without
clearing ICE_TX_RING_FLAGS_TXTIME bit.
When ICE_TX_RING_FLAGS_TXTIME is set and the subsequent
ice_setup_tx_ring() call fails, a NULL pointer dereference could happen
in the unwinding sequence:

ice_clean_tx_ring()
-> ice_is_txtime_cfg() == true (ICE_TX_RING_FLAGS_TXTIME is set)
-> ice_free_tx_tstamp_ring()
  -> ice_free_tstamp_ring()
    -> tstamp_ring->desc (NULL deref)

Clear ICE_TX_RING_FLAGS_TXTIME bit to avoid the potential issue.

Note that this potential issue is found by manual code review.
Compile test only since unfortunately I don't have E830 devices.

Fixes: ccde82e90946 ("ice: add E830 Earliest TxTime First Offload support")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index e6a20af6f63d..f28416a707d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3290,6 +3290,7 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		tx_rings[i].desc = NULL;
 		tx_rings[i].tx_buf = NULL;
 		tx_rings[i].tstamp_ring = NULL;
+		clear_bit(ICE_TX_RING_FLAGS_TXTIME, tx_rings[i].flags);
 		tx_rings[i].tx_tstamps = &pf->ptp.port.tx;
 		err = ice_setup_tx_ring(&tx_rings[i]);
 		if (err) {

-- 
2.53.0.1066.g1eceb487f285


