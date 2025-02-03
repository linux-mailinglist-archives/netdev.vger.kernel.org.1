Return-Path: <netdev+bounces-162197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B8A261C2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 18:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883B4165C5F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1A20CCC2;
	Mon,  3 Feb 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY0Dbt7P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870D25A65C;
	Mon,  3 Feb 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605269; cv=none; b=LaNHsnVd+jknl5OAgXhTIhlvfY00B2qTY4PDPgYm+beKQvFo0mAzw7YHhqBENMc3kjkV8R4HC8jIPb1PKFITqppfyJs2Gw58M0bUpkruhBK8cjDfKOkdX7TOmLtolX8Vii79cLTHCFNM8qaAlfI0VO0spA+NqTSMgOeGDKCPabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605269; c=relaxed/simple;
	bh=RskFGxgMXUxm/Kgxe7P4T6ZU5xeVlWHE0HPOMkYPP60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/7mwnf7ikBD3ZmAud5EqB3zlUlQuyI4h1XSIxKaw4Dt6fbRrUMnjAd3dqXBn7HxJ3AsEXbj2K1krgWePSzxD5/p/R3LFEFN3JGf/2KotiZAMSTG62oAEZ37wj9SoGD6lrKhb2tuex5mdor+gjEPElbbmwSXoyGabHAzMW3yI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iY0Dbt7P; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3863c36a731so3636200f8f.1;
        Mon, 03 Feb 2025 09:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605266; x=1739210066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YhHyUXmTx8Kjx+aIGTwDpZ5Q8Lg7Z71ESxIET7h6X74=;
        b=iY0Dbt7PzfoUbBGpMK4X5KJ5DGkMICiuf/qAmeBBccyA5uuN+sXKQgq3e6DCeN5kam
         lkoAEX7EjYAvjw5MDTqcleglGCqFW3xkhDvrOagmMCd9ADQehHe7ac94BrJzhWVkaPsz
         CqEgaUX6j9IH0pTEqkVlzLh9VXm96B1slKhtjbNr1ahgsXWvBrdLilTl+FcQUQ5poxv2
         Tmk+Msb4Nef6Mua6JmH87ryNhB+S5dDaWtDC8z51AVwnrUBkrGAb85+5VEOCAFBFzh7y
         6N/VtOgvyJRisjxzlEKDDuENVWSSGjkeSbxfUJ+R538WXZ5KINjQOGi8D1Iw1Uv+8vAj
         Mmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605266; x=1739210066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhHyUXmTx8Kjx+aIGTwDpZ5Q8Lg7Z71ESxIET7h6X74=;
        b=JiXnw1qfpnfC2vt+NHGkdQzQQ3pYl7W/Q/g68a/pqQECtTXKRT541WCDuKoMMUA+QN
         x91Ts62kosOmVdY6f1DGCw44Ffu1fIzOMR/Y6P0dmFPsKVJ9TS8hfrTrHZLZq7i1c2N4
         Z7Xp3rPk2VfbGGpHOgebi9Zf0Q/jOgcSogiQhk9g+D8+ueS9+CaNp4QcOviMcdrsxyLI
         KpvNm0BGxs38SawDHyJfXog/UegaEq5y7Ik5SjbAoWO218gZ75qJAqgxDOHhs12ychhE
         82kvMob9OtoiAzJyS0ZdNyku3rcYz+l/JuDjaP9C8oK5A1M4Vi0LZ8GV5Zh+2JQBn7rd
         qGng==
X-Forwarded-Encrypted: i=1; AJvYcCUGpuJF+xDaTYfdnchABU4JsaQUcX/gF2ICtePG8r38GtjXpY6fxIsaFNbOdvMHopz8swjv0J+eUWIs/y7Ok+4=@vger.kernel.org, AJvYcCUzFAWqo1YAuRNd8hTDRyFarM0zqqb170RGAUb3UjG481nA0J8ezrwazG14T+v809k/Un8m1zmVeBMkWbEV@vger.kernel.org
X-Gm-Message-State: AOJu0Yxls7VyvONGEl/HjW/5U+38LLvagmqns8UBAQLe259CiBgh2Pyf
	1KGZF941yoVslzX2sIFZskispLkAFWcAuTjZw6myycl2eYPPysmL
X-Gm-Gg: ASbGncsxkgYFc5fivEAUWVZ0ZYCFz5A+3XdPY4L8P2m2u2nqLplMUFufdAGt+K/yldG
	TV3zDvZoYK4SIXVvlEoVlc2eYSpDJUiSLyvuhOedFOuiUi+gs5rzi6KoY++7FL0B5QyYuYfWqCV
	r3S/+Lbq3rj8HgEB/rOwHxvWSGUrPQY8H9fPHQKlwXy/uVzUsUtttHMnfomin8am3N0wJGV50Ge
	TTGKtW+EdUAgFgg2SeAFrymyRMfxposNUlmf69+ETTRZG5kkErpiKixfa/NcbyJt68ZeFrE+y/A
	mpnTFiVq+KnZV3cP
X-Google-Smtp-Source: AGHT+IHdoed3XjN9J007P9D62DnvwBtD2Wey8LqfcdYMmsEr0qJT1fYybz7yCG3/8xH1JQo22zpcDg==
X-Received: by 2002:a05:6000:2ac:b0:38c:5cd0:ece8 with SMTP id ffacd0b85a97d-38c5cd0f132mr13260317f8f.12.1738605265430;
        Mon, 03 Feb 2025 09:54:25 -0800 (PST)
Received: from void.cudy.net ([46.210.194.238])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38da59470b2sm12276f8f.40.2025.02.03.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:54:25 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next] net: qed: fix typos
Date: Mon,  3 Feb 2025 19:53:24 +0200
Message-ID: <20250203175419.4146-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.91.g5f8f7081f7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in comments/messages:
 - Valiate -> Validate
 - acceptible -> acceptable
 - acces -> access
 - relased -> released

Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index fa167b1aa019..5222a035fd19 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -3033,7 +3033,7 @@ static void qed_iov_vf_mbx_vport_update(struct qed_hwfn *p_hwfn,
 	u16 length;
 	int rc;
 
-	/* Valiate PF can send such a request */
+	/* Validate PF can send such a request */
 	if (!vf->vport_instance) {
 		DP_VERBOSE(p_hwfn,
 			   QED_MSG_IOV,
@@ -3312,7 +3312,7 @@ static void qed_iov_vf_mbx_ucast_filter(struct qed_hwfn *p_hwfn,
 		goto out;
 	}
 
-	/* Determine if the unicast filtering is acceptible by PF */
+	/* Determine if the unicast filtering is acceptable by PF */
 	if ((p_bulletin->valid_bitmap & BIT(VLAN_ADDR_FORCED)) &&
 	    (params.type == QED_FILTER_VLAN ||
 	     params.type == QED_FILTER_MAC_VLAN)) {
@@ -3729,7 +3729,7 @@ qed_iov_execute_vf_flr_cleanup(struct qed_hwfn *p_hwfn,
 
 		rc = qed_iov_enable_vf_access(p_hwfn, p_ptt, p_vf);
 		if (rc) {
-			DP_ERR(p_hwfn, "Failed to re-enable VF[%d] acces\n",
+			DP_ERR(p_hwfn, "Failed to re-enable VF[%d] access\n",
 			       vfid);
 			return rc;
 		}
@@ -4480,7 +4480,7 @@ int qed_sriov_disable(struct qed_dev *cdev, bool pci_enabled)
 		struct qed_ptt *ptt = qed_ptt_acquire(hwfn);
 
 		/* Failure to acquire the ptt in 100g creates an odd error
-		 * where the first engine has already relased IOV.
+		 * where the first engine has already released IOV.
 		 */
 		if (!ptt) {
 			DP_ERR(hwfn, "Failed to acquire ptt\n");
-- 
2.48.1.91.g5f8f7081f7


