Return-Path: <netdev+bounces-121809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D02B395EC8A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 10:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCE81F23D6A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 08:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598181422C8;
	Mon, 26 Aug 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="frkfBPTH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmSjRlJV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="frkfBPTH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NmSjRlJV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A113D63D;
	Mon, 26 Aug 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662717; cv=none; b=Mo6tPuozXl4d4krZFSpivemiQNqz5efjh3hgDVFdWnTv5rQdVXOKlZkaZaUVdv+Sn763VVuDOBljLKshB4b/h6ExZeDPtNPxVil9Ri4QSMyP1SE970KamWS5H+ZwjGljqL4PhXG/tD8W1PNwnkcuIASdio8KABSzroUO25iS6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662717; c=relaxed/simple;
	bh=Aenp2rgBj9WT97ObxXQqYib3Tjz4Qu5J2vkfyDlds8w=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=nJ4Jz/RRU/E3Da+5uXStbJ5RwRjPWflafwQBan38gne5gTaFhgtq642q9BftBiyIh5Ad9jlkegiokmjkJIjznP25oREozvXEZCsEM5cYgmHMT7wVOdbbSgju3uhw5nIBaFyQE0OyBsbFs5Gd6idn/J6C/yW9+Q6EO/TCAxBWDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=frkfBPTH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmSjRlJV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=frkfBPTH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NmSjRlJV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42FC221A35;
	Mon, 26 Aug 2024 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724662713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LFldDIQ++8jqXOksKbyxggI0tviGzCPH46mPtl/Vd3g=;
	b=frkfBPTHZsCyiejxSourA01rRgmszp5221pEDKXuqtJVw0UQD66z25mbUIIQ554f7zjYes
	lr7mSvfa/JHAOrpS/R71Wzr3fkvsYpdDd3h6Aehk5AMuLgupEP6OUwOVgtcx+NWGVwG6NJ
	Duhb+LQneTkMN5nazc3crWkSlB9ieyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724662713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LFldDIQ++8jqXOksKbyxggI0tviGzCPH46mPtl/Vd3g=;
	b=NmSjRlJVH5I4tQ4N0vPSwJtZ4Xc9oYMpPzNijvLM6981De2bsnHp9mnVXlCzwdRu4qG9sY
	nP5e+DFhGLNsO8Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724662713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LFldDIQ++8jqXOksKbyxggI0tviGzCPH46mPtl/Vd3g=;
	b=frkfBPTHZsCyiejxSourA01rRgmszp5221pEDKXuqtJVw0UQD66z25mbUIIQ554f7zjYes
	lr7mSvfa/JHAOrpS/R71Wzr3fkvsYpdDd3h6Aehk5AMuLgupEP6OUwOVgtcx+NWGVwG6NJ
	Duhb+LQneTkMN5nazc3crWkSlB9ieyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724662713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LFldDIQ++8jqXOksKbyxggI0tviGzCPH46mPtl/Vd3g=;
	b=NmSjRlJVH5I4tQ4N0vPSwJtZ4Xc9oYMpPzNijvLM6981De2bsnHp9mnVXlCzwdRu4qG9sY
	nP5e+DFhGLNsO8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D5DF13724;
	Mon, 26 Aug 2024 08:58:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bq/rCrlDzGa4ZQAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Mon, 26 Aug 2024 08:58:33 +0000
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ice: Fix NULL pointer access, if PF doesn't support SRIOV_LAG
Date: Mon, 26 Aug 2024 10:58:30 +0200
Message-Id: <20240826085830.28136-1-tbogendoerfer@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
allocated. So before accessing pf->lag a NULL pointer check is needed.

Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
---
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


