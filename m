Return-Path: <netdev+bounces-286279-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BDiFU5rAGoyIwEAu9opvQ
	(envelope-from <netdev+bounces-286279-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD9503C9A
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 13:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A263009FA7
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EC3378823;
	Sun, 10 May 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZ0viJyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EEE33A9DD
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778412363; cv=none; b=JwD6BoyBosDmZb8U+rYTiv0yRcSmFrUO/fYIJuh3IzeLrLP28r2Z/IhkrW2vSiN1fkWmG89v8Qmv641VvNdl+vVlK63I2A25el2/tbJZKX9ex5ZAFQI6bT73chA5+DIk8Mbvv0a8wZBnE8ItioINN30x6ZswCu2BpOfJAvKyiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778412363; c=relaxed/simple;
	bh=kWundYsSA1TJvK+/u1cdL3QMlOTJF3BVADcVgUgb70Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPm1RpjhbqDJhLsrWpAsz1PYlPySHUJyaiY17QAmBuCgdKJAVqVmLIbjAURrZYxcNRbL7CZGs0jTRHHQX+k6xX8tZpl6U0iU9FwN185CtqbacNE+dn1Gm1maE/giG/nYpYTcLRSIaVhL1wH7rZp/zTjlcWTrQsfdHVTlnm/tXkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZ0viJyT; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80167f56cdso1248570a12.3
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 04:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778412362; x=1779017162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIl8H8lFysWE5ij7aLpKADHwKQH42nKkHoFfcSIfoNA=;
        b=WZ0viJyTyb6lN55EJyZH7Tt8pt8NYNK1xhzGFuX4kHsGA7zh7RkM2hMjqsXYItFxDE
         oom2IYBmg7S103oObghhJvVFu9oRDnO8LgFueWf4f3/qN3XtrFzgVZEyMt5wNqRCajNu
         q1l9E4Jpw8EHv/3xQYdkagEUqm9lkWnitfPBu4tZXI8jHZkDuaJkmXmI6tS+q4Mz0qyj
         N5EFqZNpjE8aul0wnGGikpG9jhr/Qli3BCgTU5FG0QJrm37CTjs37shglgEQMc+75r0J
         BcRCp9eWXxutE7sakTNWBt8xuMssumdqgEXKB6FDkXPsdy12cYl75di6QWV6mEEN3gEW
         vRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778412362; x=1779017162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIl8H8lFysWE5ij7aLpKADHwKQH42nKkHoFfcSIfoNA=;
        b=qYnj+uXkW8t+3qhwBqdm7d7Tv2o/382fNeNuuBYUxNrqTzZ3kixWYB0MmfdAcWky98
         Ve+qWVFUHbXZvBgqi6BnWEgq5zbW5v2DrUIY8wxEqU9m83j1pYb+RWbtAS+SUyKwrTL9
         3KEujyMG9ugT3IyIRY8zF7zv4WmjeBx2ljCKX76iZsD17CU12jiq1k5Tog8n8gQ3Kg4J
         cM8+fYyCAGBtGDOtavpTgCxjUoQypw+3ZJ6XU439/Gf223BOv2CnivSxSP03f4CiaeY7
         M+kJa+fR0y4mvBdRE5fMW+PmVD8CB/3Qxt847cChcfOcYvYwHkElhR0aqPZE7M2wiOmC
         IbZA==
X-Forwarded-Encrypted: i=1; AFNElJ8RFOl2ykX2k7VogbY0QULNqy9ozU1SltdjV8QQ/m+O0NhkLt8TBWR2rgWPHrwIchfLuAqmXWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfra6h7njiGlkVoV3CxI9NL7OE9wYIs/f9F9hmPzvSg95LgQLX
	lGrdy+k+6BnDYDoJseusf8UVoSV74an8XTD5w+H3pq9lybQt6JZqYeSD
X-Gm-Gg: Acq92OGcgZrYArl5Pmq/3dH5HDDNNJ+L3V5UjQF9WD512TDRXX0k97kB9Y+HoN+xqSf
	+bkfgNz2gUDKjfvUEBbIkrXXB4nC3OVb+yjmTh5dsat82vxi3p5t/rNrhzIlt/aERA6npxb7F41
	p4ArGlQ6fI52wjunHB/2E9zbFOlQ+n1yNf8PWM2QVYJaDE72DNdzVRzk5VToO8ENWytDzla+uh9
	6yNJfGEswM7biVSHb3rN4+VZiZKkXYGbDmkpH5RaCjFL+4Cz8xo8k/WE0R2rvIaQrusujsSOE1c
	ZHsTDjlHwdEmC1sR9W0jhx/QHzI+SAs1xmwGP062DcQUw74Uij2VRt6roOdS2erU8kq7YqTP1/v
	YtSC9l3tUz8hVoeuW2m6VggnYwHb3stOIMwZ8wuZWon9ZwST6Z/Y/xlrFCLNjIU4AdQaPZjK9C6
	UaQRxiO7ozHtcw56Mxr8Qn94FK8EYWIziR0MxABkqJ9bgWox7xZCtONL73tKA11HPi9Q0QhrQX
X-Received: by 2002:a17:902:f78d:b0:2ba:ba5c:2524 with SMTP id d9443c01a7336-2baba5c26d4mr142806315ad.11.1778412361580;
        Sun, 10 May 2026 04:26:01 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35e9dsm75362185ad.39.2026.05.10.04.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 04:26:01 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: ajay.kathat@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shitalkumar Patil <shital@cambiumnetworks.com>
Subject: [PATCH] wifi: wilc1000: fix dma_buffer leak on bus acquire failure
Date: Sun, 10 May 2026 16:55:20 +0530
Message-Id: <20260510112520.977360-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4BD9503C9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286279-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Shitalkumar Patil <shital@cambiumnetworks.com>

wilc_wlan_firmware_download() allocates dma_buffer with kmalloc() at
the top of the function and uses a 'fail:' label to free it via
kfree(dma_buffer) on error.

All later error paths correctly use 'goto fail' to route through this
cleanup. However, the early failure path after the first acquire_bus()
call uses a bare 'return ret;', which leaks dma_buffer whenever the bus
acquire fails.

Replace the early return with goto fail so the existing cleanup path
runs.

Found via a custom Coccinelle semantic patch hunting for kmalloc'd
locals leaked on early-return error paths in driver firmware-download
code.

Fixes: 1241c5650ff7 ("wifi: wilc1000: Fill in missing error handling")
Signed-off-by: Shitalkumar Patil <shital@cambiumnetworks.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 3fa8592eb250..4b116fe6f9ea 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1265,7 +1265,7 @@ int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
 
 	ret = acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	if (ret)
-		return ret;
+		goto fail;
 
 	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
 	reg &= ~BIT(10);
-- 
2.25.1


