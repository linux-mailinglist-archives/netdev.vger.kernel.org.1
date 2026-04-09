Return-Path: <netdev+bounces-277043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZZ/tINDF12n6SwgAu9opvQ
	(envelope-from <netdev+bounces-277043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:29:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D701C3CCAEF
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D26DF303FACA
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383403C3C0E;
	Thu,  9 Apr 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P9GyPh1R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B162E0925;
	Thu,  9 Apr 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747486; cv=none; b=azVAGQP2l5cdX8vulkP+NRU/h2vLANIyz8297AazHkCFFDyudFXagb1bcezWEgB6VvW8LwA/cBLt+sO5WWwDbbK6nRhyuTal7fTvMEmigwG/poSGrHlpupXM+2F2s8K9kp1DmmGYe/NOLQB4ccQBMcm+2Csd4G+AbF+5M4447hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747486; c=relaxed/simple;
	bh=ld3ezbMvVsNELdIRgsT43RqN5vGdmDKDso8u1ZYLZMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=co+3/mAI1TGc3SodnjY3xXBMNBum5RLQkpYV0RqMuVhAY/hejWF6k1Ns3AXQG2QNMOr4x2/j0msVlThOWGnNKL0s4xDT7oxkWhnQm95sb7hkzYpcaBgNfQ0l0EwDq8Ty8FJF5IUmNO3zEf/2teWVmd7jDUL84uNXT52z0TliB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9GyPh1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BDEC4CEF7;
	Thu,  9 Apr 2026 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775747485;
	bh=ld3ezbMvVsNELdIRgsT43RqN5vGdmDKDso8u1ZYLZMA=;
	h=From:To:Cc:Subject:Date:From;
	b=P9GyPh1RHg21nZpKuzGezt9h1an5z7/4COuTMcsxGjmPs58NwXcbZkSyaeJE9mwU/
	 8Ce9H6ftVM1KJNnMgzs9ZvlLrwxka9Z7m3oECpk0GY+xuAxylFEuKy1DCBPa+RD3PV
	 lIuZ1EKyRHq0+MiGcCWhKx87i2Fja0CPxlCDe24w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] ice: fix double free in ice_sf_eth_activate() error path
Date: Thu,  9 Apr 2026 17:11:20 +0200
Message-ID: <2026040919-junior-glue-10d0@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 47
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=ld3ezbMvVsNELdIRgsT43RqN5vGdmDKDso8u1ZYLZMA=; b=owGbwMvMwCRo6H6F97bub03G02pJDJnXD05fFnv6UNmHJrlpXC+r/93mOC14dpthbqKszUIHu cVp3GbeHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRnkkM86O+Mf12sp4Z6hch cP6zTt0xxacTghkWLLw+v0Z2V8rEAoPLYR3rgqxl5uswAAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277043-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,lunn.ch:email,davemloft.net:email,resnulli.us:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D701C3CCAEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When auxiliary_device_add() fails, the aux_dev_uninit label calls
auxiliary_device_uninit() and falls through to sf_dev_free and xa_erase.
The uninit invokes ice_sf_dev_release(), which already frees sf_dev via
kfree() and erases the entry from ice_sf_aux_id.  The fall-through then
double-frees sf_dev and double-erases the id.

This is reachable from userspace via the devlink port function state-set
netlink command.

Fix this by returning right after uninit because the release callback
handles all cleanup correctly.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Piotr Raczynski <piotr.raczynski@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Simon Horman <horms@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Fixes: 177ef7f1e2a0 ("ice: base subfunction aux driver")
Cc: stable <stable@kernel.org>
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 2cf04bc6edce..6bc8aa896762 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -304,7 +304,9 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 	return 0;
 
 aux_dev_uninit:
+	/* ice_sf_dev_release() frees sf_dev and erases the xa entry */
 	auxiliary_device_uninit(&sf_dev->adev);
+	return err;
 sf_dev_free:
 	kfree(sf_dev);
 xa_erase:
-- 
2.53.0


