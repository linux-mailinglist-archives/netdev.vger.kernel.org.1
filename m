Return-Path: <netdev+bounces-122153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5576C9602DB
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F61B22566
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F688154C0A;
	Tue, 27 Aug 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OT9jpMe0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G89gdgRI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Bni3iWdf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/dOcZIIO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ADE15359A;
	Tue, 27 Aug 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724742969; cv=none; b=odt5tnB7RwtWWQ4NpERfmDby9oLCD8GwUdMDR1eJo8qN6ir+gzEk0cIqy8YYgrOA+/Z1K5PyLFszVf6ifz7XiGIILMjytHSfD27aWEJiSZ7+ePKGJyqpMrf8E2q1NiK+rSdo68/pG+0tkVARIYJ9/elpe0F1x1PBcVSaracUzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724742969; c=relaxed/simple;
	bh=HTZJ74FmZIBsDfiAHYUyfjBmDTIwi+Qt0iPcceQn19U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=twov1pYy1M5ZQoWtB1YzAqwx0IEof+zh6NR0AqpL0KIKno5vWFT9ebU5ds6yGOrKP7i+TI90cYnt5QubBamgxXJGRgvSXNgbSv2BC1OGhJB+dKPdrwCQm2n4xCmMfj386L5FEGZMDveXVa7TpDRE+yM0PXxkMB7giTFuqLtDRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OT9jpMe0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G89gdgRI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Bni3iWdf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/dOcZIIO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4ACF421B00;
	Tue, 27 Aug 2024 07:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724742965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Valuq13x6BKJNYuKM8Olhcw2C+1XdqQL75MkmBSgmsw=;
	b=OT9jpMe0IsDYHG7f6vVpr6Gf+09w4SsQp2pSofrFunEvh7Dyj817wK10I+ZXk4TVV0D/AZ
	ToZNrzsTl8lIcjqElvXRUZmUtUGr+t1TlM0aJZVRSds7tmK6OuoBKheNr5S+o565hgXOk4
	tiFaluvS/6IBPcH8R+17RAYkBzvydZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724742965;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Valuq13x6BKJNYuKM8Olhcw2C+1XdqQL75MkmBSgmsw=;
	b=G89gdgRIYjTJYS9O3A8A68gljo/6I+oYULyfflS3wzrzJvh0XnJsiPiK9bVKgP1Jw5Hnxj
	iZU3Ly4zgt9IRMAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Bni3iWdf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/dOcZIIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724742964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Valuq13x6BKJNYuKM8Olhcw2C+1XdqQL75MkmBSgmsw=;
	b=Bni3iWdf9MfRCrw0YvSI5pQVMxrOJwZWmnZkasxwqtPvA9NY+Ln28Do11rhU0/JJ07WHzk
	fCQT48bQi08VhtTmkvYIyNuOpFNx+UbG1YffqOveqJZvSoLp50G3iSul2AroTLW8vT4XK/
	qXYjRrwCcKLmFXxv21lyu/4UX++UloA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724742964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Valuq13x6BKJNYuKM8Olhcw2C+1XdqQL75MkmBSgmsw=;
	b=/dOcZIIOMQbBANkIbMXgFYrCtEvXrY/PIxR20K8ZhwJQ2JEOMcgRfCJ0LYiBE/VmBazr6Q
	CVh/3xlsAYh2lhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3417B13724;
	Tue, 27 Aug 2024 07:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qhuQDDR9zWaIdgAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Tue, 27 Aug 2024 07:16:04 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] ice: Fix NULL pointer access, if PF doesn't support SRIOV_LAG
Date: Tue, 27 Aug 2024 09:16:02 +0200
Message-Id: <20240827071602.66954-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ACF421B00
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
allocated. So before accessing pf->lag a NULL pointer check is needed.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
v2:
 - Added Fixes tag
v1: https://lore.kernel.org/netdev/20240826085830.28136-1-tbogendoerfer@suse.de/

 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 1ccb572ce285..916a16a379a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -704,7 +704,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
 	lag = pf->lag;
 
 	mutex_lock(&pf->lag_mutex);
-	if (!lag->bonded)
+	if (!lag || !lag->bonded)
 		goto new_vf_unlock;
 
 	pri_port = pf->hw.port_info->lport;
-- 
2.35.3


