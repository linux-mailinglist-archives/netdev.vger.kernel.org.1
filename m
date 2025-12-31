Return-Path: <netdev+bounces-246426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F6FCEC013
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 14:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5C06300A575
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C91931079B;
	Wed, 31 Dec 2025 13:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69721C160
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767186362; cv=none; b=V+zYxbVQxaJ3PgX1PYCjQMlKit1U+NL7cYjCHrOu/gmyVA/fXW3j54cOKx5kAfoBD97DinlUOz6p1hgYYMD3I/K4neUM7E6m8mnxxxLthClLIdckeMWMaV+JV/MX/dmkWxKH9AqUN9K+OBc95/GCUfCQyPA7CXWadM7cs4WTjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767186362; c=relaxed/simple;
	bh=MDcd1bGhccG6X9ai4kuqFpZk9zpxTDM/8y4BfsTO1bE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hRlJpEkLdzPVVUc2Y/thKne+zfzZB/RYUltZaPQmn1QIgJGhlnvh9/e4gd6zCLgyUfp/BLbnkpQdjHcbCb/9Pu2nUCx/SI6sGmRE6oQ08+XWGW3DxBUbB+5Dmh2mPCt7SrzTtMsFhq2diivSLrvJLu1I6LIAvVPvlpa7ZF8klnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c6e9538945so7761332a34.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 05:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767186359; x=1767791159;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbnElRqbRnD4WG3UkShPsEoYZpnGixbcSQcdBWQX0Ew=;
        b=W6+mvtkov5IHQUwNKVvbVG+bMbUBR+1oDA3GPWHlEXqlQFkqiYjBc0PDE6ahF4BYEQ
         xF5FRxuRzu2F5V8HIUhvlXK/ZIXguE1ARzufWSBwOPvM5WUliR22EduBCNCQjBphmlZE
         bn1adviE2vONfKK8AgFPd6X61LWPoQ9uTgCOhEpI8gbSPP8n7i8luty7SMBU/3V157pF
         eb+SOSLTM+jZMGVi+6C6r5wYQeMF8SnY/DrXi0EubMatwNYya2bwBWX/frUuq5SHWfPV
         HQdVDdjkNRJxhJg6B85aclWN7AQ7Xp3h+0f82DgFQCZ7t6PK//J6pFn/1/+AbuadNx3r
         h9Xw==
X-Gm-Message-State: AOJu0YxqgjYnDnOSR957WWyOk9kE6hXJT1dGvtKaxqKsY96B4yMlo8PU
	0v8i8VtZ/PbEpcc+1UoI8ItPecgCj3iTxt10Q7YqjsdTmMXx49hyFAO/
X-Gm-Gg: AY/fxX5ChFGMg+XookmVEilJCdfznWGh5vvGVktmXVkXgA0K2A5QRwCYgvrQy7pE9ws
	St7J8XS5ybUtoKpyUs7M+iD5dlVdP5TVizLrv4IckL/6IktAdka73Bdm3IFRWO2PZTgnPYE8ch+
	w5xdY2PflBB9tBXOhN45w3uBAd2MREezAEI8pZ74Y83a/TjgkB+lrah+ZQLLn9S+IuQVK08063C
	jY2eQPqvjVEY9X5YLXydCpU5kt53+4e9v4bLzzGmll7J5z+DoWEB4jRTwUBFRYz1hnSNcK4kv2e
	7YtN1pfSW6pSfvj4Z1R3qcnsWNAqKB5wDe4e3oIuzlJebgABrZruFWN5iAABTmzy5qT+WTcZxHG
	/1JppBhv601eZGEe9OaOY+os/eFPKArPWqZfJT1L9LVl6WbLnTUIXdz4jeigZkcDdsX+gykhIIW
	r/DwsCI/e3ySxaVQ==
X-Google-Smtp-Source: AGHT+IEYrzaVvZv/bIMY6srXwLcMFuv6qqbv2T7g2ZyO0CjurEzavAPpm4aq7O+Bni2FRGchzZfHgA==
X-Received: by 2002:a05:6830:11c2:b0:785:6792:4b3 with SMTP id 46e09a7af769-7cc5926f15dmr16552158a34.10.1767186358781;
        Wed, 31 Dec 2025 05:05:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667281fesm24446233a34.6.2025.12.31.05.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 05:05:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 31 Dec 2025 05:05:34 -0800
Subject: [PATCH net] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-bnxt-v1-1-8f9cde6698b4@debian.org>
X-B4-Tracking: v=1; b=H4sIAJ4fVWkC/yXMQQqDMBAF0KsMf22giUpLriIuTDLqdBElSYsg3
 l3U7Vu8HZmTcIalHYn/kmWJsKQrgp+HOLGSAEswL9NqU2vl4laUb5tQ63f4uJFREdbEo2x30yF
 yQf9g/rkv+3IFOI4T3nSalG0AAAA=
X-Change-ID: 20251231-bnxt-c54d317d8bfe
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2910; i=leitao@debian.org;
 h=from:subject:message-id; bh=MDcd1bGhccG6X9ai4kuqFpZk9zpxTDM/8y4BfsTO1bE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpVR+1FiLsstnJScE9knBwtFyXA31Y5m9+ra75Y
 GxF3pU4EnGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVUftQAKCRA1o5Of/Hh3
 bfaJD/sGSpBK+ivtrCA5bmOPt6CGYezAsTYL2EcFDmCkdYSp2NUHIj0RjAiRmCHC/YEONVg5xWJ
 KUGiQ0kfwVmtB8IpXO7iBxKtvM1JLBscyF88FzpqWhf5xqL2xBgTKgQXMdtXuysYDY4/EiEyAp0
 M1i5v0IKphUqV9O19F01GkikQuYLO/J6F9a9rjRaQBh6SDm+WKP3eVqGuP3Pb64zWRTqSwmFQrU
 svD+BFYUjaetg9RHd7yrPih1lX29NejtU33VEGdodZS4zwBr+vIMkY8CE4sAdahzyLb6PRbwQLB
 ZdmRWNkjfsqi3qpu9G9N9Di4KspHFeWPepVXtI0j7hjbFBERJNHWkPXQKBKyHDI0VAVAA8eVTW6
 T+AL9arnKOEh0EKK/qhI76SgIQWSGVTSar0XP7E6y9nFgdihoBQ1YvYTKdn7beRBZqcyHI676iN
 w7zJaUPhDpoSMpnstQ1Ol2skw1P2w+54CNfKY4DZTvjrZ4x/F+KLXQdWmn+U6YbJK5s9mhMC78k
 blVyeWf+5SDHCU7KG1P/RHA2LBKyPBuSC7O3aUniARJnNqC3cDKwGcAzHmu4vgluHgBCTAN+9I5
 1SYLzAzKlbikZmbTtbnHNzt1P/+J9IvAwpKcjEZ1HCnva3EoV7jngH4ojExALGfhRqsiG44bMvJ
 Gx3RixyKlyf/dTg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When bnxt_init_one() fails during initialization (e.g.,
bnxt_init_int_mode returns -ENODEV), the error path calls
bnxt_free_hwrm_resources() which destroys the DMA pool and sets
bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
which invokes ptp_clock_unregister().

Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
disable events"), ptp_clock_unregister() now calls
ptp_disable_all_events(), which in turn invokes the driver's .enable()
callback (bnxt_ptp_enable()) to disable PTP events before completing the
unregistration.

bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
function tries to allocate from bp->hwrm_dma_pool, causing a NULL
pointer dereference:

  bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_int_mode err: ffffffed
  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  Call Trace:
   __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
   bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
   ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
   ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
   bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
   bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)

Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")

Fix this by checking if bp->hwrm_dma_pool is NULL at the start of
bnxt_ptp_enable(). During error/cleanup paths when HWRM resources have
been freed, return success without attempting to send commands since the
hardware is being torn down anyway.

During normal operation, the DMA pool is always valid so PTP
functionality is unaffected.

Signed-off-by: Breno Leitao <leitao@debian.org>
Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable events")
Cc: stable@vger.kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index a8a74f07bb54..a749bbfa398e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -482,6 +482,13 @@ static int bnxt_ptp_enable(struct ptp_clock_info *ptp_info,
 	int pin_id;
 	int rc;
 
+	/* Return success if HWRM resources are not available.
+	 * This can happen during error/cleanup paths when DMA pool has been
+	 * freed.
+	 */
+	if (!bp->hwrm_dma_pool)
+		return 0;
+
 	switch (rq->type) {
 	case PTP_CLK_REQ_EXTTS:
 		/* Configure an External PPS IN */

---
base-commit: 80380f6ce46f38a0d1200caade2f03de4b6c1d27
change-id: 20251231-bnxt-c54d317d8bfe

Best regards,
--  
Breno Leitao <leitao@debian.org>


