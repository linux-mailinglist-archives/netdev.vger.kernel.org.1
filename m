Return-Path: <netdev+bounces-307706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eoO5Cq5GV2r0IQEAu9opvQ
	(envelope-from <netdev+bounces-307706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:37:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61675BF1D
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:37:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=linux.dev header.s=key1 header.b=gMvU5E+B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307706-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307706-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=linux.dev (policy=none);
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8780D30137BA
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0C23CC334;
	Wed, 15 Jul 2026 08:27:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EB53CA4B3
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:27:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104049; cv=none; b=iA/Zg5do4HGzeqAwJ6hV/4YKi2ud3ux1lFIDQG+SoFfgVsURpXmHVYO7Ulm8kxyiwI6LnkA9zrcAhhluBB1bTDP55cxg96saBeBd2M6JtORB/An5SoexgigdWSBGxkk+F9TmWZ/S/yV951mcCLXpXW7f2q0+Egl9aLD5VsE/szE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104049; c=relaxed/simple;
	bh=EFTvZ/fJ5V0Q3f11qDtI+bniAlV3kStsISFGyiORu3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvHfMhKHUTSqeVpi0KMYw/2QCeirhB8cCzzSnlZhGnKQ9KKHS9I0TmqNJlYqoIkyiGOHYkGOx7gBgxWik2la/D0oqmg6cMPK+0H2bU4PNVgB8a4W0PS4VQ5Lm4rDN6Ivoze3Dp6ckFA3vZOweMlvr/mYz4np5zameUWGsuozLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gMvU5E+B; arc=none smtp.client-ip=95.215.58.188
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784104045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/i/S6+I3OZ6MoEmGhUzQo3sY9bpnI/3MGwofuQD07JM=;
	b=gMvU5E+BoQXinDcxY0VE9NNWOgIOTiXhFBa0QAVqn2HVe2M2IdvyiKn2etcgQ7QO6ijOTf
	IxQsp6m2F5+VgZSYoZjITzsWJrfmmuXRq7eq2LN3NCJjKCKL5TXytUNCrr/KfeSQ8MrAdp
	Nb7QxbQ90AQ//0ugFSg0gorNv/46jdU=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jagielski@web.codeaurora.org, Jedrzej <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v2 1/2] iavf: fix ASQ command buffer leak on init failure
Date: Wed, 15 Jul 2026 16:25:47 +0800
Message-ID: <20260715082548.56687-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[linux.dev:s=key1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[linux.dev : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:Jagielski@web.codeaurora.org,m:jedrzej.jagielski@intel.com,m:intel-wired-lan@lists.osuosl.org,m:andrew+netdev@lunn.ch,m:mitch.a.williams@intel.com,m:gregory.v.rose@intel.com,m:sudheer.mogilappagari@intel.com,m:netdev@vger.kernel.org,m:luoxuanqiang@kylinos.cn,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307706-lists,netdev=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanqiang.luo@linux.dev,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:-];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD61675BF1D

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
unwind path elides cmd_buf while freeing the other allocations.

The ASQ count is not set until initialization succeeds, so the shutdown
path cannot reclaim the buffer. Free cmd_buf in the common unwind path.

Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 6937b7dd44cbb..40f76f9507f4b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -60,6 +60,7 @@ static enum iavf_status iavf_alloc_adminq_arq_ring(struct iavf_hw *hw)
  **/
 static void iavf_free_adminq_asq(struct iavf_hw *hw)
 {
+	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
 	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);
 }
 
-- 
2.43.0


