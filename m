Return-Path: <netdev+bounces-283753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BSRLjpb+GlStQIAu9opvQ
	(envelope-from <netdev+bounces-283753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:39:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 183344BA56B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5D9D302DB5F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 08:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B254340280;
	Mon,  4 May 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Em5IiFMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f101.google.com (mail-qv1-f101.google.com [209.85.219.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFC1A9FAA
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883771; cv=none; b=QMLON0kPopDTeK/o3UAW/BTyyEhFUSqsvGYCNyefX8EUyXY84JMaIn0CYShMG0KnfO7PZQDZFTpPEpJol5fOvlJi4CHOG8YtNg2DtN+O9QmsHogI+oHFtSJX5bbChvS2Quz2WYcfGSAA2rlNpbBX6lXaJflyQM9xnJjPQ0LqXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883771; c=relaxed/simple;
	bh=sGqS5mF2cOpmDxl3fUd+W1l9K6uToiV/Z8nauLdbows=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vn/xPzcASwBBV2U9teP42peDhV4aC+BB318WSI0f4zHsLGUDr9BQUPH6YKjXpA5+rWR0MtHRc1WH1Qyd8fU1i0Ec/wYgPMPUJ2X3uAJGICMr8jZ/zKdZX+PV18N8jVsfKZuN8dxrEd1MvVNtSVkOHxjFxy4lhDfTWHG/3cSU2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Em5IiFMp; arc=none smtp.client-ip=209.85.219.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f101.google.com with SMTP id 6a1803df08f44-8b7f937ef44so6542646d6.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883769; x=1778488569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSGQ7PO4j5tuIS9cpnvwLxEgLr1qvnvaqrgcBGftpMo=;
        b=opsgoGE1ne8Y7l6/yuTSVM0xS2h8KXpy67+pc9t/1gT2iDk4aTT3oR4EdpA/LTXRqH
         /O0xaR2mXSxu28+vrhHIpsGNTEx+5ZPsettoIJbXp/IlM4PhWXS+ceAW64Sl8aH4VUgm
         8RAYi4xS78XHlKX4CreLTFA4sv8qwY8nZ6gXXIZo+YipG5m3dyGnaUc3O+fRPQpJ5ays
         w9dWEPh1zkmmVcrgJ8qCwLQ0bP8/X1VEDaDyssyoV3z5TuU/cQ1Y4u6CLL/52uZ9a5tC
         5YAze/5MIf1ugUScJjjOVT3gOaJ/3UkYqa5IMGWelb2weVFVoXulhW8k+NU11UAUly2d
         B4Ow==
X-Forwarded-Encrypted: i=1; AFNElJ95J3YesQ7jUCqF+o9XfD/byIikA3vSSCyOkFW/HEnYwmBhFG/j9ppUCwIsWBMDrap0x+jsw9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxG0oKIE7wtzOs6ySND55wOB9q9OOEONFIjJNDQOonw2KVTJX
	d75Q5TEL/BNV9TyBdoAiPSauLMWneH6yt0ZLYOZ3OEFOfRq6WzEbhOYZRiIcHxCpdrkpFv8ssAM
	ewJTphnZlZxPxXI0M2Nn1XCP/MGns2x9fvVLh/9NS13HKYUB0NgtMtrTV0qA6LFsmi5uagW24Ag
	WB63xRsDFm/bGRTz0+0UkrQ1AAGi5v1bfIl+irn/8XbUX39wfKAspEJLpBC18FDFUL8nDdgky23
	bXEOLAMFVw6/A==
X-Gm-Gg: AeBDievDd5vhCk1FK9OEzfgJgClp/3d8aDOzQZ4dRonP87C6tSr/mBC6gElDWBDqcsw
	ezC05MOkU0PatGuI0HgJuc2UXA0whugFgqiYnFlcGXd1USBW65l4lsEOjrc2+Adc0ZO1CkCoXqB
	X8PQVlGl+SKAuJNrXcV3X3LtxN/1rBwU2J+CPaRM30JFV3/QsUxG1K6b5MAYoIanF0xgAd8iPhv
	9CDFS9XPnxEokL/9zgM1BPu5DLTH8fxUJ0OhKptkwiLZrA0ZKDHdwLv+VQMP1j6ifcTu2VAMp7p
	6zGHfjKDWPtp9PNx5Of1LKmzWnD+32rJnQo5ou1rbX8dtuJnJn2ngY6tYTZS60dxHnE2Cfnc9ty
	22RNyI7oOCwo033pggQGGkXVKe/HBTbi1ItHGwBDW0GvOU0uS8Evaf6tODkKgGfqIryqL0dJstR
	saeKkrlRbKFXkefxCq9fa37pkz/zL1iPohZ6JltPekkugefz/3JsVhoJLRI4GlDstAO94=
X-Received: by 2002:a05:6214:1d26:b0:8ac:a87b:c81c with SMTP id 6a1803df08f44-8b6696dba87mr136226286d6.44.1777883768869;
        Mon, 04 May 2026 01:36:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b53b918614sm8841056d6.20.2026.05.04.01.36.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 01:36:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7989b7cdd0so4436116a12.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777883767; x=1778488567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSGQ7PO4j5tuIS9cpnvwLxEgLr1qvnvaqrgcBGftpMo=;
        b=Em5IiFMp9boKlx7Pg8VSH+wl7jFA0Z6ieoPItcwu18j5JY1DZMbly5/XgXtHrorNZT
         ASEn36Ez/QBCpbuAAICP4EFp9Ssd1D3pbyLiydlbQvw74igD7uCE8AONvd2LhF7CM89e
         weqZ7J8G1/uOXkofmoxbMdE1u8f6eh/4XJEQs=
X-Forwarded-Encrypted: i=1; AFNElJ+aj58Aq28rHxY6YAEf1nHsbbsMvXQYVb5mSQIa2/y7B5ePPAhZQT2stGmrmOhX9oTGYEZSrxM=@vger.kernel.org
X-Received: by 2002:a05:6a00:1748:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-8352d2ac0a2mr8298028b3a.45.1777883766819;
        Mon, 04 May 2026 01:36:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:1748:b0:832:e65:ddcd with SMTP id d2e1a72fcca58-8352d2ac0a2mr8297999b3a.45.1777883766270;
        Mon, 04 May 2026 01:36:06 -0700 (PDT)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0183sm12539773b3a.31.2026.05.04.01.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:36:04 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	edumazet@google.com,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net 4/4] bnxt_en: Use absolute target ns from ptp_clock_request
Date: Mon,  4 May 2026 14:06:11 +0530
Message-ID: <20260504083611.1383776-5-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
References: <20260504083611.1383776-1-pavan.chebbi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 183344BA56B
X-Rspamd-Action: no action
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
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,broadcom.com,google.com,vger.kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283753-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

There is no need to calculate the target PHC cycles required
to make phase adjustment on the PPS OUT signal. This is because
the application supplies absolute n_sec value in the future and
is already the actual desired target value.

Remove the unnecessary code.

Fixes: 9e518f25802c ("bnxt_en: 1PPS functions to configure TSIO pins")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++---------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 53f336db4fcc..5d41dc1bc782 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -419,31 +419,13 @@ void bnxt_ptp_reapply_pps(struct bnxt *bp)
 	}
 }
 
-static int bnxt_get_target_cycles(struct bnxt_ptp_cfg *ptp, u64 target_ns,
-				  u64 *cycles_delta)
-{
-	u64 cycles_now;
-	u64 nsec_now, nsec_delta;
-	int rc;
-
-	rc = bnxt_refclk_read(ptp->bp, NULL, &cycles_now);
-	if (rc)
-		return rc;
-
-	nsec_now = bnxt_timecounter_cyc2time(ptp, cycles_now);
-
-	nsec_delta = target_ns - nsec_now;
-	*cycles_delta = div64_u64(nsec_delta << ptp->cc.shift, ptp->cc.mult);
-	return 0;
-}
-
 static int bnxt_ptp_perout_cfg(struct bnxt_ptp_cfg *ptp,
 			       struct ptp_clock_request *rq)
 {
 	struct hwrm_func_ptp_cfg_input *req;
 	struct bnxt *bp = ptp->bp;
 	struct timespec64 ts;
-	u64 target_ns, delta;
+	u64 target_ns;
 	u16 enables;
 	int rc;
 
@@ -451,10 +433,6 @@ static int bnxt_ptp_perout_cfg(struct bnxt_ptp_cfg *ptp,
 	ts.tv_nsec = rq->perout.start.nsec;
 	target_ns = timespec64_to_ns(&ts);
 
-	rc = bnxt_get_target_cycles(ptp, target_ns, &delta);
-	if (rc)
-		return rc;
-
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_PTP_CFG);
 	if (rc)
 		return rc;
@@ -468,7 +446,10 @@ static int bnxt_ptp_perout_cfg(struct bnxt_ptp_cfg *ptp,
 	req->ptp_freq_adj_dll_phase = 0;
 	req->ptp_freq_adj_ext_period = cpu_to_le32(NSEC_PER_SEC);
 	req->ptp_freq_adj_ext_up = 0;
-	req->ptp_freq_adj_ext_phase_lower = cpu_to_le32(delta);
+	req->ptp_freq_adj_ext_phase_lower =
+		cpu_to_le32(lower_32_bits(target_ns));
+	req->ptp_freq_adj_ext_phase_upper =
+		cpu_to_le32(upper_32_bits(target_ns));
 
 	return hwrm_req_send(bp, req);
 }
-- 
2.52.0


