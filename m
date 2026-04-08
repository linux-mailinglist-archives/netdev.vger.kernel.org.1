Return-Path: <netdev+bounces-276213-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Zg/Az2g1Wm/8AcAu9opvQ
	(envelope-from <netdev+bounces-276213-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:24:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4A53B5AE0
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 02:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6021F3016915
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 00:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D4B23D283;
	Wed,  8 Apr 2026 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvhB1n3a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51B32264D6
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607863; cv=none; b=cZhuxNoEoRdfXU4TD0LqVcICYFAUsR36gu/nCjnLZihex/NzXsYwI1dWpyLFhMPuVLTkD6KlE3SxxZz924AEpQPHPZNwlc5rxAldC4kfQH/udXzV/G2E8z62Gd1BKfG8q1aAh0EYsXNUUPjJXEQQ86aSk14FhUX7+godF+eL3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607863; c=relaxed/simple;
	bh=AxroPpLSjwpx8EztrdBbF9QrEE1x6q8qr132pCWFUj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/CIo99tHodV1UW7yaSe6b+xPGY3DGF84CSwUlkwnI6+6c3haZvAUi2iyb26lyboiezxrePTmC3RZtd1EvFgsRe6dzJtonBaRL1lauRpuVyPrKXzIuFMnDZSjkNoToYG0+YDAIN/387Y/AilLQiwmz6Gr3XfPXI1nzB7xLOTX/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvhB1n3a; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0046078so27493575e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 17:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775607860; x=1776212660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjwT07ANeUUsPN08vT3gc8tVpgsxlShtx8gPYpFJmfg=;
        b=rvhB1n3admCZ672bAeQgGBPmxwPTV6FFGcEI+kvL9mUq1HlQqVJwazSLMyNJRyP2MA
         /64+gxF8kiwLcIdvNA5AVEzlx2JtERjKIH3We3svVaST84GY7L/czlQRIpCs5YHQ/tq/
         IXB7xY6OlHqoXnatAJMCLXB8Hce9snmHgOSb9wN26T11U5R/b7XNWaSfGrczO/4DPgDz
         nyZ4SYvmHS785jPFposj3QBwFRnWWiPaArPXhgRl3m44pIZFapgw7sW9g96g4ZUSNaMD
         chS88F3EBF2zLjKZGvlicrvkY6qumw2INS82qcnQqdzJk7sbarzoLp4oiDXpGfMsGzLn
         0sGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775607860; x=1776212660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjwT07ANeUUsPN08vT3gc8tVpgsxlShtx8gPYpFJmfg=;
        b=Bj7miyuN4JL7UKjrJQy57FxSmDswWh+m/C2tmV2ymnTqkipLINC1m235+1jU/se9sb
         dHAxg2q6S/zb3mHoUpfQScI764T2Y2hA4Vip5BqExQnhzm70ytOLBpNNlZn98DIYPdGY
         tEquPX9KTVKEzhLQI8Vc9tNRxajW2qUWhtKr8sui7+yp653lvJPA25m6kg6EzdB4joBm
         +l60jYZUK2kIMXN+3InVVZvx88lvl0cSrb1eQZhGnoCdQvgezic64ez0PmFKE3IcLaYH
         0dvgJ+HSUa4xB6PXGxWatBob7alWD5QCcVLmCaCwyC4fMmylPTDe2oWJ3tHW7yO2PCfl
         dyzQ==
X-Gm-Message-State: AOJu0YyfOZcFso572FkS4nzQT93z7Y6F7h9ofl/dRsDNk0/nw3aG0xMh
	zEXEXfnCQ6exyEQdikdy9aZY7X/VFV4xjG3RQHkQ/5bE3WETB9kCZXdEXoMTeg==
X-Gm-Gg: AeBDiet4+qvKxq4lYvxQElqKDF/prZ//NbupnYcDh5OYpZHy9Wlf63hHQDrnf7JUg4F
	9cIq/u0Nl3K1BaXqS8ZqEk6g0TzweItJP+Dq81RH2JLDWkLW5fTcQSSPwvN9z2vipiHt1KfHRsK
	Tw2uoutxIGhoGMzNq0pi5hw7E/qCmzCi6pcTkOZXHdaNj/V4ZUcnRnuSUrQE564BlDREMLyIrRc
	31BE6e9CXfcvtfcsV+DdnEaqI9tZ+7uAv2J3Qu4sxDOW71dXZPnWUzFIK8gUixmvxn7ZiSNgymW
	wk3ZB+5ulQt222cVo1KB0FUpEyVqiaCzI5xp34freNjK68I6A6y0y4CwLCpEnh5cFvMp7AbCyxG
	DX22sa7AsrOptJnjgJrqP1YixgxNqADKGx5e8zGc7HywQZ4jqubYg6mwHn7ZpdgygsuypD8Ftew
	7K5SKxvmlAbTw/x5L5YD+a
X-Received: by 2002:a05:600c:1d1d:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-4889977600bmr255728995e9.15.1775607859630;
        Tue, 07 Apr 2026 17:24:19 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:38::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a616sm1099700105e9.2.2026.04.07.17.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 17:24:18 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	linux-kernel@vger.kernel.org,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com
Subject: [PATCH net] eth: fbnic: Use wake instead of start
Date: Tue,  7 Apr 2026 17:24:15 -0700
Message-ID: <20260408002415.2963915-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276213-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,intel.com,meta.com,trager.us,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: 4B4A53B5AE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mohsin Bashir <hmohsin@meta.com>

fbnic_up() calls netif_tx_start_all_queues(), which only clears
__QUEUE_STATE_DRV_XOFF.  If qdisc backlog has accumulated on any TX
queue before the reconfiguration (e.g. ring resize via ethtool -G),
start does not call __netif_schedule() to kick the qdisc, so the
pending backlog is never drained and the queue stalls.

Switch to netif_tx_wake_all_queues(), which clears DRV_XOFF and also
calls __netif_schedule() on every queue, ensuring any backlog that
built up before the down/up cycle is promptly dequeued.

Fixes: bc6107771bb4 ("eth: fbnic: Allocate a netdevice and napi vectors with queues")
Signed-off-by: Mohsin Bashir <hmohsin@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 3fa9d1910daa..8f331358c972 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -139,7 +139,7 @@ void fbnic_up(struct fbnic_net *fbn)
 
 	/* Enable Tx/Rx processing */
 	fbnic_napi_enable(fbn);
-	netif_tx_start_all_queues(fbn->netdev);
+	netif_tx_wake_all_queues(fbn->netdev);
 
 	fbnic_service_task_start(fbn);
 
-- 
2.52.0


