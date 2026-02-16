Return-Path: <netdev+bounces-258894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAGwNOsjk2kX1wEAu9opvQ
	(envelope-from <netdev+bounces-258894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:04:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6E214468D
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F57E302E92A
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F301D5CD1;
	Mon, 16 Feb 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JTlm2gIr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3563101A8
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250558; cv=none; b=H1xRk8PupK2vZCzHckQmMjeYXWyx/lvcCyPo72PYUqHip/ykErVlSs+DTRDVYl5uVniMkIjPmmjjDxcY42I2jfq8QgQBzq2NLqJcmQQg+LhqteEe/N+9Y/f17Flt7QFHcsCrh88X8B31ViZOPqlRUQyHYOflyRgJGg5PfQDKK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250558; c=relaxed/simple;
	bh=w/rJUNbZDQ4LZkTQf3Wc5IrMeXi7D196D4kfcUwdssI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GbDOTNCCOWG2JnsLzqhWmsahUZrUJ0+jDP/Bi9BnrzepEO4ryLk31Ye1TiWh7YtlH27ljd7zDlkbIG+Xa95D0VdQV8UbVJsaScf5dc0NJf9Mj5SwN8RCp88EImyP9Fifr788py0rp69e40RTnXdHuMJmqyvEvFcDnYDkbdo/nuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JTlm2gIr; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-82318702afbso2213109b3a.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771250556; x=1771855356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZrI/cq9OA6Htj/lnKie2T8Ev7zacatPAjgWh2a4Sg4=;
        b=CeEEcgPMUQ9mrOccL83m6ZzASd01W6RipjalSSVJE4oh8PihaOMlh3GXKzbW/3VPy7
         wHSbzbSL9riTtpfYYR0h//NOalDTe4QyJ+Ke5g4IpxZA2XgakVnsPC7ero4RV9k25Ovm
         /1ddEDOIvrVfijiQtn5VRUZjrUTk9eSOm+lRYXukzs1lCLXb4tbeq1Do1K5CACfYc8CK
         sQmVzkSM8uMrNdDzGByDZwUJ6V3A1DUqaD8x7M58BOzn5nnCGWOCCq/xc68p8SlVUcul
         pf44Q3mV/rSV65K1B1nLfHbeuCLMUEfGSYXViTJ+WwX01MW3Av0RnEOJyW0D658sUjPK
         jEig==
X-Gm-Message-State: AOJu0YyGjdbZEIXuVgwsHEtshEt73gKihD7LkC99H7vVbNtiJoJX5GDM
	EY6cYynT67dcvmWMQ5kKtMc3mmzDP0DLIplNetprlLPVKQUqoIBEbC34ZmcbSx78ifDze4dQtHL
	7ee7uYiBmLOIJNQ7y9V06Wo+I04+6HM0WYeNz4jDy0AhFVYFAbEQKNz0VMQOscHO0zHHEKyAjrv
	BRyj3W3ZGN0pjyrHkjdosS/YXcIGiqjXm7PXuRN1ZX3HZgndpMPBfEIVx2obsW9Zm0/QjXS//4I
	Pnuav9W6g==
X-Gm-Gg: AZuq6aIX9q+ZMiYCKRqgmXKCby2b6340NZBPS6O3vgYOw97gOM52jX+Gm8XVsnC7LHb
	EgDcUI3GQ/QVvaCNC++B2/gACkOJclXZzIwjfgteYION85xcdTX76D7sBJUOIglKnx/foYHorO7
	athHnuvKRX3ooeLMujLbVCV/kYQH11O/PWz1Xhk/B7H8GAKF69Bx8F7w0AsMh9h0uUrougISUpL
	EfO53uSPRHmJdPd6lG0OVWrgLNIk3vOyYx9FgTLZGA3mDh3QMP4jp0VFW1gKrNmXG4jea6lv2rX
	9V7OlhTa8VATk/q9CK3PF5B/yeIu51PVGwlJTljOeP1YTFrmSAOPQQcJk2umeLOkLKNq9kww4dz
	vCSBqMTzN2A59t4pYtzqMZdX5uaiqCJoPy9fvnlqdRPL8/fpa9FVj1QRAvYju/7uJlN+00fgF2W
	G4aWia0t844KWPIwAQwFgnWsAEDIiyTwF8o+Xc1vP3mfi3Cdh28tihaTWN0A==
X-Received: by 2002:a05:6a20:734c:b0:35c:e441:e6d2 with SMTP id adf61e73a8af0-394838fd647mr7641672637.7.1771250554543;
        Mon, 16 Feb 2026 06:02:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c6e5300ceaesm870955a12.5.2026.02.16.06.02.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 06:02:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aae0d40a47so158806905ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771250553; x=1771855353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZrI/cq9OA6Htj/lnKie2T8Ev7zacatPAjgWh2a4Sg4=;
        b=JTlm2gIrfoxEjobXDxiATtcwntcHV2ZuJL8mHnI94lObdDZrt7kJ1GNhlbUPs14XgJ
         1CMebK6Xdd9OIi33JZbQnSAw/a8Opq5oUITAliR2bqPkVHK8+KluEYkK6828MVUf/D6N
         4KuX6pSeAGte1L3DdmTdW8arhQMBbWpXb2rLA=
X-Received: by 2002:a05:6a21:1:b0:393:73e5:7404 with SMTP id adf61e73a8af0-39483a6c1bbmr7493878637.52.1771250551072;
        Mon, 16 Feb 2026 06:02:31 -0800 (PST)
X-Received: by 2002:a05:6a21:1:b0:393:73e5:7404 with SMTP id adf61e73a8af0-39483a6c1bbmr7493826637.52.1771250550393;
        Mon, 16 Feb 2026 06:02:30 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b9a661sm10342468b3a.50.2026.02.16.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:02:29 -0800 (PST)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net] bnge: Fix typo
Date: Mon, 16 Feb 2026 19:32:35 +0530
Message-ID: <20260216140235.3764145-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258894-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3E6E214468D
X-Rspamd-Action: no action

Fix the HWRM command type and use the appropriate command to reserve
the resources.

Fixes: 627c67f038d2 ("bng_en: Add resource management support")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 84c90a957719..91a4ef9e3150 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -442,7 +442,7 @@ __bnge_hwrm_reserve_pf_rings(struct bnge_dev *bd, struct bnge_hw_rings *hwr)
 	struct hwrm_func_cfg_input *req;
 	u32 enables = 0;
 
-	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_QCFG))
+	if (bnge_hwrm_req_init(bd, req, HWRM_FUNC_CFG))
 		return NULL;
 
 	req->fid = cpu_to_le16(0xffff);
-- 
2.47.1


