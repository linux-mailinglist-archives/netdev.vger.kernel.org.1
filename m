Return-Path: <netdev+bounces-259568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NpGAlJcl2lexQIAu9opvQ
	(envelope-from <netdev+bounces-259568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:54:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC31161CD4
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D5A3010212
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFFA2EC0B2;
	Thu, 19 Feb 2026 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HxuJsXAd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783F2E973F
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527228; cv=none; b=IzFRL3wrpui/wFZsysb6Xl+xL7rlmq8x2moRYzHOmQUoziXBeB+7nAeN2aGaXSmzpkKQ+zLUWNVo8g9tA2C+GcrxOsqPA2WvoI9dwDgiZG46jDQIsGyHO6UJgAMBrDC98OhJA8CMkubccdECbcDLB7RC7/X5hVFO7oDOmCyf6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527228; c=relaxed/simple;
	bh=+kXNg2EdTV0iX9EI/Ocql0vn0TZsI8Nqmxm4o7iz/uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKAScsJUc8VYreqzJCF+rq1nl2jKvEHK5Mu8aFzjNfcGMaYLxrmcnh/AyYpsHgnJDyQxfSAZTIGE7fVp2iooshljjZmWd+6PmRy38O/50snXl25zTHFH3ZWGl+BNm8cZ4EYssYQZHHrq7TItZxbBLmkMw27ri1F1tcspL0QcqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HxuJsXAd; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-8230c2d3128so608763b3a.0
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527227; x=1772132027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nb3Mlx1aYmKkbqKqMlQR+LYS6CQTP+vCTRcInTm0f4=;
        b=k7PfoxRbC0tb6RnXcH+A/bMw1UrDbeOWXp8jk4pjUUvKky3TgD8ScwzLQsgQMpwEmi
         9zgMipySHphMQDz9sVI8/jeASl/eBOIr8tXKqVjq6s43xRjIzkhAFq2029nbjXio+4sL
         jjIL8E/Jgtzbl4YkNu6cgRMB224CR2g+M14nBUoA8eILravE2u+DB4Muk5xqW9o5tYvv
         v/Qym/yqBlC/XbWCBzvrWagNA2yOjTHUoHpYVfAgA7xOHtStRZDfZo/mF4Kd8CltjYn9
         vq/kU1S6g97AJMRMeK1Cm87fIsQOuD+lDqThn1XG66ScIb4DWlM/1+X20F6eQ5Zhwj7i
         fahg==
X-Gm-Message-State: AOJu0YyHcI0KFjEedd9hdf77Os1FaVmLOIa1sYvJSL5J37DrlHMbvdjz
	dLAE3BoTEA7HVHX2ujC1WS2NKR21XGmuPn2AlLpLlKJAFn4ZlpkeDPsuCsUoLETFZXUru2Gii3g
	My86JGJD0/V0pWIbkw5wO7dD1Z/qkslzz/Vv9EDijeoUzZqxmFLbk5zwzHOE53iZCrOcZmyIrNf
	nirAJkO0j7W5UgTa2njatxHSOch71CBBB2CGpJRtTwOrgSBZ9FErSFiU+YoKN9rrG2WXdkqlhwc
	kcKHTrLws0=
X-Gm-Gg: AZuq6aLamsGEiBXLYIAEt+mpk7El8h/Hh5vSudiBWZMqibIVWd+3aTuVSrlbBvn9UJL
	QcwGsR0mggP7mirnwueD1qIAgENe77V+XqphXyw43Xv8qjl49ctMc4NQfr+I12zpqT5mDbl400a
	CVtX7gn5d/5GFsfCKDQbYBSBklPuTyN9QcS7dEvw2sqVdNXTxbOV25nNEwgtl4MMJT+OlbDsg2U
	KKprX8L6cV25t2e/bd0JJmDlxP3mv3/bfOei+ubpP21QYRr845se7yQOMYdaHWAm50Hne/lMlZY
	vRF/GnbZ0KyOP0/at7O/3FUWT0rf5nYKOf7c7O0DcrArNnmRowILpSX7OlcuI1W2+igljFQ/wPx
	ts7yQjrE05q+fbZZzsy++BuE48xTbOzIsnmbom9a1BShbsj50eUuhaKdHn6QbJ27EaW0YWMzaf9
	R82eWfwNehqal2LGFnWCWf8aGTR/QgFnRE7JdEKcKv3RF4hr3C3Hh1hxw3MSE=
X-Received: by 2002:a05:6a21:33a7:b0:394:2fbb:bc72 with SMTP id adf61e73a8af0-394fc21a0ffmr6233052637.17.1771527226610;
        Thu, 19 Feb 2026 10:53:46 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c6e52ed8feasm2298288a12.0.2026.02.19.10.53.46
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2026 10:53:46 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b9ea5408fbso1570354eec.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771527224; x=1772132024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nb3Mlx1aYmKkbqKqMlQR+LYS6CQTP+vCTRcInTm0f4=;
        b=HxuJsXAdoSjtJGi8YkWTGi+CnWTLxv/GRy/M67suN0yf8H+WOm7qrjOv747AfVZDQE
         ykGn+iX+Se3cIVnnQ5gmySW6KuLV2iv/RNIyVCHkxwgCeXT41E99vtTfbBEOCWv7cuGJ
         PM4QBti6sz8g5ZLxttRCOHcqLsvKLpYAiuAsc=
X-Received: by 2002:a05:7300:641b:b0:2ba:77a2:2589 with SMTP id 5a478bee46e88-2bd50147752mr4624880eec.25.1771527224251;
        Thu, 19 Feb 2026 10:53:44 -0800 (PST)
X-Received: by 2002:a05:7300:641b:b0:2ba:77a2:2589 with SMTP id 5a478bee46e88-2bd50147752mr4624852eec.25.1771527223660;
        Thu, 19 Feb 2026 10:53:43 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb6782e5sm21488155eec.29.2026.02.19.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:53:43 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org
Subject: [PATCH net v4 2/3] bnxt_en: Fix deleting of Ntuple filters
Date: Thu, 19 Feb 2026 10:53:12 -0800
Message-ID: <20260219185313.2682148-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260219185313.2682148-1-michael.chan@broadcom.com>
References: <20260219185313.2682148-1-michael.chan@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259568-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CAC31161CD4
X-Rspamd-Action: no action

From: Pavan Chebbi <pavan.chebbi@broadcom.com>

Ntuple filters can be deleted when the interface
is down. The current code blindly sends the filter
delete command to FW. When the interface is down, all
the VNICs are deleted in the FW. When the VNIC is
freed in the FW, all the associated filters are also
freed. We need not send the free command explicitly.
Sending such command will generate FW error in the
dmesg.

In order to fix this, we can safely return from
bnxt_hwrm_cfa_ntuple_filter_free() when BNXT_STATE_OPEN
is not true which confirms the VNICs have been deleted.

Fixes: 8336a974f37d ("bnxt_en: Save user configured filters in a lookup list")
Suggested-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4: Simplified the fix to address the NULL vnic pointer bug (flagged by
AI/Simon).  The simplified fix now works for all ntuple filters including
DROP filters.

v3: https://lore.kernel.org/netdev/20260213074503.2302046-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7768d9753e2d..8c73a723d23f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6240,6 +6240,9 @@ int bnxt_hwrm_cfa_ntuple_filter_free(struct bnxt *bp,
 	int rc;
 
 	set_bit(BNXT_FLTR_FW_DELETED, &fltr->base.state);
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state))
+		return 0;
+
 	rc = hwrm_req_init(bp, req, HWRM_CFA_NTUPLE_FILTER_FREE);
 	if (rc)
 		return rc;
-- 
2.51.0


