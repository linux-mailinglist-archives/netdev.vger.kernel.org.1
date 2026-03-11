Return-Path: <netdev+bounces-266588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNWbHShEsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:30:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED2262308
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6728305DD48
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB07B3B389C;
	Wed, 11 Mar 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2WwGH3O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B3236C9C1
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222919; cv=none; b=m3ButFOhQ3RmFmPuxtWqRFm563Uy1PAmfqRariEeEBghJZnd7LCIhFJS3JcRxilaQPq6HWjtExkm1Cw4xkafUn7mOnl2+dfTSdyqdoC6kKjHrL4ZgXuxFp+rWN3XmQ7YfXreyirw3iPiVUQCBzpf+IenihO7rxIlSFTjAUFx32E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222919; c=relaxed/simple;
	bh=t3YWAFTGJfOXq166ei+fVp8S8uwUghjUXQoCv8h1vNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rjRdSCLbMRDmV42KmRz/aUVebrA5aSV8EEnVhw/QUHlPzp+wrHvtw/3Oz0IKwR97Bt2IjgHsxBN+vmdM9V2lmB5zYkw02wmszPPW6tBY+EyRKfMK5R4EpH9zu/e+yi3022Df3tik1qj5tkvJEI8wlcSPWBDDZLmv5w9Y4PKhsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2WwGH3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C79C4CEF7;
	Wed, 11 Mar 2026 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773222919;
	bh=t3YWAFTGJfOXq166ei+fVp8S8uwUghjUXQoCv8h1vNQ=;
	h=From:Date:Subject:To:Cc:From;
	b=n2WwGH3Oubl+RCowhtf7QOox4ccYXoouIKknsp9xZq+3+xkBZdXAaVPo/L/W6X1KN
	 fqlk75bWVJ4DeOMQ46Zhx2NUZL4lfKoD+hseFsPo9r58cEGlhXnTQ/W9TY5ghmPZsO
	 lvGVap6Y9V8M9Rae4s7WWRLmttsf8cPuJZpD/cTN5UEde9uPM0B2C0CRMDwlVdyGmv
	 H+R3VBIFtcbEi1d+VFdXK+KjUXTAUG10C7050EoQiYwMoqapsat47H6zt9XKjGWL3Q
	 er+gUZTHTy2Eou6nArhNIcJWW30Rbu5OjuAXLZ13m3OdGAZD7DJ6hQHJVpRqcS2q1Z
	 LBSLuG9jowyYw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 11 Mar 2026 10:54:57 +0100
Subject: [PATCH net-next] net: airoha: Remove airoha_dev_stop() in
 airoha_remove()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-airoha-remove-ndo_stop-remove-v1-1-596fe853b2e1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQqEMAwAwK9IzhZsq674lUUkatQctpFURBD/b
 lnwOJe5IJIyRWizC5QOjiwhweYZjCuGhQxPyeAKVxfeWoOssqJR+slBJkzSx12217ZqHH7KAdF
 7SMemNPP5/7/dfT+/JnIIbwAAAA==
X-Change-ID: 20260311-airoha-remove-ndo_stop-remove-1582a74baa33
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: BBED2262308
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266588-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Do not call airoha_dev_stop routine explicitly in airoha_remove()
since it is already executed by unregister_netdev() if necessary

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 3e9ec5c178f86fdd055e079078a23461edf97951..de5089e7dcd85080188641ae4c976b3d731cc3b4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3095,7 +3095,6 @@ static void airoha_remove(struct platform_device *pdev)
 		if (!port)
 			continue;
 
-		airoha_dev_stop(port->dev);
 		unregister_netdev(port->dev);
 		airoha_metadata_dst_free(port);
 	}

---
base-commit: 482aac8b56ca21d06c588517970579474d56736e
change-id: 20260311-airoha-remove-ndo_stop-remove-1582a74baa33

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


