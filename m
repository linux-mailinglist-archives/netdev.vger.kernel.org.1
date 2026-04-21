Return-Path: <netdev+bounces-280057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC0JKHQ+52no5QEAu9opvQ
	(envelope-from <netdev+bounces-280057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:08:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB766438A35
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97A053034E0A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA53A4F30;
	Tue, 21 Apr 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue7+Jk+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575A39FCBA
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762055; cv=none; b=iJTDn17JFM2z/utHbUaVijZYYDBUkWrTTLmYUWV4wJrX94G6jhRVUJ9fIEKWKkZKBeGfyktiFptjp4x22I2aJxTJsAmJw7bw7ZX+VrR2h/v7S49SD6CyelkxyM4Au/ILDJjxjDubEOZNm58oaYEyyisbB0rWf23ltEq1wryGAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762055; c=relaxed/simple;
	bh=BjutMcIEH3kbQHlv3u1kc0EHf31XPA5x+6cvpcO5yEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK78sK0eMtKzzARsIvU9kWLfbbvE5gMIx6M8qvI0Ejq60qojplndyqTJcxgVvYWD+YOQZEAvUhwfH6TIOzsRSbeTaa3wTozDYXF3FAdh6pFlFmDG7AMdtJg5ynYTkeC6O8b8s/LprtM4L8S/79r1gQy3HxebSB6AfgW3FU7M86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue7+Jk+l; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38e7b0903cdso35909981fa.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776762051; x=1777366851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dthsqIm/Cpxg0B4QgCoO1C8r6BeVrJ1ExMuPMtumgl8=;
        b=Ue7+Jk+lTAUjZaDV8JrNC5bHrQWgfjBDDODcJIZIQtyZmBYDXW5qk+nZzgjoRMnmXi
         40YWmB3Ug/qpARNBJ6di3TId8Y1A7X4bJDAQ2dGii4AD00P5rf810FMugH3+iqxhbJez
         lyIrO+YNA/WwYfyegTF84av3KM9pLiCVpH4yBdSRAeSdN3g9XIfqmMQ94PPvrNHkACAI
         pHEPjfEePp1+qM16HYu3EfMsfoPtpBynu+H3z8+IQiL9ZHN2eivHvylJOma1p5Ofk+Z9
         vqmZPP9pD9oj20wc4RyXd/p2GPXPbWpJ+lNCLVdTYUje5CfhQnZgaDyvoGMjYF9rjIwL
         QeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776762051; x=1777366851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dthsqIm/Cpxg0B4QgCoO1C8r6BeVrJ1ExMuPMtumgl8=;
        b=U4vdL+VtedsPoVxP1eOo8qorp9xkftr5DWGK1sthYla1/79UeQe+qBdtqHU13Kd4Lq
         J5NsL+UDj4joX1MfM9zEPX7h33dxUK9yz5c8Bwfh9Re1VQkLW3kfUv+lowGv3rl7wSfy
         DDoN8LGNJBKfFsAo7buqVc6PGu3R9CRCKNbkgZMe2eYxhIJqSDFLHjTVeUDUV95gdvyR
         0CwbcYSTGG0WRRUeUAFZ73DgMMYI6iEAhTlTMnXfDjp7S5XcRyfvI8dBm5MdFnSSS7KK
         fuBHq+/ElUbTwL52TEEco/gerj43XdbkexxfuZEUdP+8GZxrxPVojRv4eLQ6WTSvwFsO
         fXjw==
X-Forwarded-Encrypted: i=1; AFNElJ8aoxarhi+6wnfX/ytZ7cPdd6MtIMpIMZIuQNaf+ttZ60zhVRf1HLY6ds/koYhqyziWB0XATBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzsI89qUT+Dv0eHT4mcyfDhMZs5UQ3PhZQHK45Zif1Xm9+Bfqr
	/6LlNzdSqJOL5EAwHFurmtLgcpjLyLEtF8T+QRhJquFhIpMwsLO6iypO
X-Gm-Gg: AeBDieubzDOkaV9eKMbia7gCrADRjVW8d+lnUOETe4cOFrbVGoAKBz8HYx1DPBIqNLi
	i8gw/qj7FND+nHbVfZJxzfiNfm+LCxYMfnzuQLRX7vdRPDspLsoaq+IGDzj4/Bq7DDnamP6fgtq
	ex4tJkb3AaDR8Nnn9nybW7TyfIFGIf/QYdTCXBgbU01cYTCu+a8gsyf9BuCTd8IDR9/zRIyTUqY
	RAdVocDinQ8Y1EjQBdKYWF7UoDmyMfcvC3oCch2UL6HzO0ZvgAhcGYvW+NMkKdh+NJi7UYknwUw
	KRnBvlZg/EI+t26FLhxdmXkYyVl6tSgl+zg6rtKih45QNbF9hyR+n3VxQ6xdPFHvXJNpSRVn2Jr
	r/k+hMqWbibqTa4ClGoSNuvPU4wZ408DVNl6HEuEb229/5wiOLNwZQMu/5DqszEo/t7E2j6dUXC
	bPFCG7arFg55otkSIAmVlVTn/bOrAaHuQ=
X-Received: by 2002:a05:651c:1551:b0:38e:d3ec:4fac with SMTP id 38308e7fff4ca-38ed3ec5605mr47926221fa.3.1776762050707;
        Tue, 21 Apr 2026 02:00:50 -0700 (PDT)
Received: from thinkpad ([178.205.156.194])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb75b033sm28583931fa.39.2026.04.21.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:00:50 -0700 (PDT)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Min Li <min.li.xe@renesas.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 1/2] mfd: rsmu_spi: fix page register setup
Date: Tue, 21 Apr 2026 12:07:09 +0300
Message-ID: <20260421090710.395591-2-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421090710.395591-1-dev.mbstr@gmail.com>
References: <20260421090710.395591-1-dev.mbstr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,renesas.com];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280057-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devmbstr@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB766438A35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix writes to page register in 8A3400x family (Clock Matrix).

All calls to rsmu_write_page_register() have resulted in early return,
becase all addresses in include/linux/mfd/idt8a340_reg.h are less than
RSMU_CM_SCSR_BASE.

There were 2 separate patch series which have to be merged in one time:
mfd and ptp. The latter have been merged, the former[1] have not.

Link: https://lore.kernel.org/netdev/LV3P220MB1202F8E2FCCFBA2519B4966EA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM/
Fixes: 67d6c76fc815 ("mfd: rsmu: Support 32-bit address space")
Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
---
 drivers/mfd/rsmu_spi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index 39d9be1e141f..55c5698e7e77 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -101,11 +101,9 @@ static int rsmu_write_page_register(struct rsmu_ddata *rsmu, u32 reg)
 
 	switch (rsmu->type) {
 	case RSMU_CM:
-		/* Do not modify page register for none-scsr registers */
-		if (reg < RSMU_CM_SCSR_BASE)
-			return 0;
 		page_reg = RSMU_CM_PAGE_ADDR;
 		page = reg & RSMU_PAGE_MASK;
+		page |= RSMU_CM_SCSR_BASE;
 		buf[0] = (u8)(page & 0xFF);
 		buf[1] = (u8)((page >> 8) & 0xFF);
 		buf[2] = (u8)((page >> 16) & 0xFF);
-- 
2.53.0


