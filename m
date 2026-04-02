Return-Path: <netdev+bounces-274638-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD+7DEanzmkgpQYAu9opvQ
	(envelope-from <netdev+bounces-274638-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:28:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B038C83A
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A33613024325
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 17:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A019D396B96;
	Thu,  2 Apr 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsmSrLL/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF63D6462
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775150914; cv=none; b=UVoDKjlB1iKwurPy5aai4y1YFKauOUmk55671Iz1H5Ljdxv+McpQtDJIewi6qlDQHYRTpJLQe0GAlrZhVhYwhAs3hxhjxHI2omwCKuNHDfaoROP8pLpue1NAsYCCinp1rBLMH+E6ssj+PLAMCbO2tOZECvZQGcuVAU8wy3QaTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775150914; c=relaxed/simple;
	bh=w9Up1fKB2GEY6om9s47lJMNvXz+5zEdTXVEOI5jkmIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvM783LdLJsQ0ltGSXSBWlGm4wrfExDT5+IcrCjVlnc3Rs8w+QMnhriZtY5VrZRQRqtVoPTXnhWLr/5Dwop/50NxUdEAaZkQ28Hj81kVugKSyiFLSSPfoXtEiBQYFRAMrl+/srwHnpKOUnF4j/1LsU4r+hLL7kqqCaGuU958bkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsmSrLL/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfbd17589so945638f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775150909; x=1775755709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVf762eS5hmMghaQTstY0t0CTwtXlUiAW2YdJ/qH4Y=;
        b=gsmSrLL/qyh9kxG2HGpnDLpH9GENXHOhmBeO5rRcYFjGVAtLysi7vjB1z8cWYjkLl/
         pTOW8ZF2hTDF+kecUtDr5V5ANPiD5ZEgOWd8q6ltyHQV2YeCJrSeY7UHY7MjWWokPx5p
         OuOJonzTUuA5GjEjKJptRe8q/s2miAWVdskOMJBe25SyR618aE9GyYozHSWwdd0YzzP+
         5QK8BbTTjdLDG6rTvwiHddfv9PApJ+LQ85IrJ5I9dnzn6ZT6CuMgEOmYeqC6g2AGnbZQ
         lJwV5vFA7B4ZjBgOMcXHdqJ2eNUK+Kotr3EbD2xCctoK+XUkXwA83KJ3vMYT083DB58q
         HBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775150909; x=1775755709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFVf762eS5hmMghaQTstY0t0CTwtXlUiAW2YdJ/qH4Y=;
        b=AKIiRio2eyjVuTCn6ubDB4KYuSjl/hixmZo/uXJxMHpakrIm4Q/Lrol72Vxxj2YQ+R
         YY0IKT7HipQK339wNf+p7wv68FJaPkx81jd6LWlSDn5ij+vOyM/ozuFWS7oWnbQUPirS
         sec+adGTaaxh2+PtDeMJcwQUDJ6yBl40GpSmuE3TGes3+inDvo9BZn/6lskBkQrIKL2H
         IjEQ8X63/Thdx4rKhKDX0nDjt/iz5EEANyeLHqkHlet5iCXYHh71yZgk1rKAKBTKzr0x
         3fckssVRlGDobZ4nvim9dlIb98ShT2+ir2jxWl+1kYaiJZcLN6ffkOSzrBS0zBMwjDky
         21Uw==
X-Gm-Message-State: AOJu0YwoqPvc37fHiT3HhIze8Br4yZgCPhcwxyxBPW6JXumRIh11calU
	yL3ysIZlypu/rMPTs+D5ybw0uX/QAeRTQMZJQutI7PyWdbc/QWdiIurK
X-Gm-Gg: AeBDieuT2na7YD5ARuV+/rikZVNdzmxpGJNQyIfQn26Hg4xBSF+C7hGgjK8a1yUh1x7
	7/wcocieV1Z4ZF5oOkD2UqbCH1JAERpbEWFaUdGtfN2CJbZnKMcGGiW1gnM3z40A8JpneRir0fq
	atcleQ43odFZUGDMJWQwj9kmHwKLVAoAeN73GSrPGS5k0SKRFv8+c0rn8raDf624wr05p2ABRsf
	AspVxgJR/YBcbv4zpV0dABv6OTq9PNyHp2fxCjBfXa9FeUGoufAqpFUYhQoNrH67NjZzh8ktmQo
	TArvdKtH940niq9u3BtRHzZYQcTIG2a4LKtYvvup4lKyM+JE38P/BDQ8MidF5SYcpG2Zi8U33V4
	vFmgwhe2j5zkO9CP1/OrGklaoQ0fLqPhMTHpGsJgPvxlandKoVz1nMAm6vPeL4sEvixggIJloCs
	gZ9h6DUyc2taEsU/tqz/Pf9fcoydRXIlPgr4Hbkesw7wTPeTxHIw35B6InQJvtqc8V1Rcu2r78F
	O4c5bGVgZlA
X-Received: by 2002:a05:6000:184d:b0:43d:2be:e54 with SMTP id ffacd0b85a97d-43d150ea521mr15893913f8f.39.1775150909175;
        Thu, 02 Apr 2026 10:28:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c637asm9021482f8f.14.2026.04.02.10.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:28:28 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: lan966x: fix page_pool error handling in lan966x_fdma_rx_alloc_page_pool()
Date: Thu,  2 Apr 2026 18:28:23 +0100
Message-ID: <20260402172823.83467-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274638-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE4B038C83A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

page_pool_create() can return an ERR_PTR on failure. The return value
is used unconditionally in the loop that follows, passing the error
pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
which dereferences it, causing a kernel oops.

Add an IS_ERR check after page_pool_create() to return early on failure.

Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
index 7b6369e43451..34bbcae2f068 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
@@ -92,6 +92,9 @@ static int lan966x_fdma_rx_alloc_page_pool(struct lan966x_rx *rx)
 
 	rx->page_pool = page_pool_create(&pp_params);
 
+	if (unlikely(IS_ERR(rx->page_pool)))
+		return PTR_ERR(rx->page_pool);
+
 	for (int i = 0; i < lan966x->num_phys_ports; ++i) {
 		struct lan966x_port *port;
 
-- 
2.53.0


