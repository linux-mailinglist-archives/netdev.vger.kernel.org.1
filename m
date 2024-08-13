Return-Path: <netdev+bounces-118152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA89950C3F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882E41F22801
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8163D1A704C;
	Tue, 13 Aug 2024 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLdpMmvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0D1A4F3D
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573690; cv=none; b=RLANLaPBT8G/dIYOMsORt5VCD2FGNNPOoGKdESHBnK8YtQiJcVRgEr+RLxLirgd3Pphsbw10fxVWuvEalIF1zrQOqOJpdeJg2c5Yd29Jn+XI1H+VuhvJVxymP+AhDmF5qwbU5w3XX1FOr6HILcHO4Sw3eJxCYhlJepH/zYKSCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573690; c=relaxed/simple;
	bh=wURwSNeTR3DMbnqhyCGTD2j34T/sj0viD1kYtD7tK/o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cPRefU5gFqrxLG/4OJRNSbPbtMjl94dgGBXOZRtCoRLsnWCeVHVegrcjWmUuULVBgINwT+pNGyQqLW5k4z6U0QlKuWbCfdan+/Wf6/FeODfc9+fuIw4nVsubQ0/jF3cM0bWBiiW/P1n0OXUEGxjM/M1rDOF8wQRM+yqY2YO9HkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLdpMmvZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6506bfeaf64so114723547b3.1
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723573688; x=1724178488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/Sac5m4oGMZ3mG4jh/NoF4fykuTzT6XDGolN2ik8MI=;
        b=gLdpMmvZ9p6kGYw7KvRFjBZo5FGWAuDATy2ajfatU6HKdijA/+Y3JgJ5p1gDZh8xwo
         D4lteo87NAdCWkqKciXS9Cw8cSKdiLqS9AUk5Lda1nx7zzYeISZ6VfPOXRfME4kigqX2
         M3MTO5RMM2s3Gxf/s+lDRoGxX5FMs1kH0TYhzWmOLCwmKxVdhZpRxcWDBTkTG5ZzhRWA
         Jft9yAuqeBb99y93DPqOPBXbmBsuF8hPrIs5Mu7ZNcQ8MGcMu+uBVDakOF/WA9hsY3oB
         haMQAUBmsGaHdIW2SIqX9QC/wITEJodoD3uJJLz3g+qce3GY+Dr/Squ0yDVWKvvQFihF
         4SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573688; x=1724178488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/Sac5m4oGMZ3mG4jh/NoF4fykuTzT6XDGolN2ik8MI=;
        b=k0uWsA3ajitFuBgVHNvi4sQY4A82G7hJIgowaRjetJijxKv4kOQd3ffbckv6gokl26
         TEOxdqgkdl51EC1WK7vLESc/YFxuyGM0WgfQT8uFvr21GknkPlCoOzpCVm63AffJ0Az/
         lpRJKn7bMgUBwd2ENLzCfshr1UF35XBOirZMb+q3pIA/eOrSZ1u7VDb+Jzj2paafFdoc
         x2UmEzyfKJNUYQfMlKXChEk5LBRP7rcORN159BaaBNQBcOdRtcryAG9txJOpP4mQftPj
         f/KL9zCj24MXH/Hg6oPqtE6jzy3UHbAO/8z8B6hOHoHJH2mgoNpoZZSfarqZSDrHJuVB
         LQtg==
X-Gm-Message-State: AOJu0YwNr0T8LMQgpV5y9GUYumSV8qQaa+ofl3UELTw74nHATBeCrCKF
	i73gjHk3WUq0VajeRlBCzBV7IZ4C8ldIQ7OyGA9h7yRoA7bU0xy1F+c9qY39bqQZPgA/1ZOq9Ia
	G04E1oWPa8WipE+yLfw==
X-Google-Smtp-Source: AGHT+IGMc7q2tq4LDbjY97g5fn1H9eJpq9yMVM8n/S+oYbY7lnb67UbACWQriHtyDPG5G0lfyfbpfMowGW8x+pG6
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a81:b810:0:b0:64b:5cc7:bcb7 with SMTP
 id 00721157ae682-6ac954aa2acmr70637b3.1.1723573687771; Tue, 13 Aug 2024
 11:28:07 -0700 (PDT)
Date: Tue, 13 Aug 2024 18:27:46 +0000
In-Reply-To: <20240813182747.1770032-1-manojvishy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813182747.1770032-1-manojvishy@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813182747.1770032-5-manojvishy@google.com>
Subject: [PATCH v1 4/5] idpf: more info during virtchnl transaction time out
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	google-lan-reviews@googlegroups.com, 
	Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

Add more information related to the transaction like cookie, vc_op, salt
when transaction times out and include info like state, vc_op, chnl_opcode
when transaction salt does not match.

Sample output for transaction timeout:
-------------------
Transaction timed-out (op:5015 cookie:45fe vc_op:5015 salt:45 timeout:60000ms)
-------------------

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 30eec674d594..07239afb285e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -517,8 +517,9 @@ static ssize_t idpf_vc_xn_exec(struct idpf_adapter *adapter,
 		retval = -ENXIO;
 		goto only_unlock;
 	case IDPF_VC_XN_WAITING:
-		dev_notice_ratelimited(&adapter->pdev->dev, "Transaction timed-out (op %d, %dms)\n",
-				       params->vc_op, params->timeout_ms);
+		dev_notice_ratelimited(&adapter->pdev->dev,
+				       "Transaction timed-out (op:%d cookie:%04x vc_op:%d salt:%02x timeout:%dms)\n",
+				       params->vc_op, cookie, xn->vc_op, xn->salt, params->timeout_ms);
 		retval = -ETIME;
 		break;
 	case IDPF_VC_XN_COMPLETED_SUCCESS:
@@ -615,8 +616,8 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
-		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
-				    xn->salt, salt);
+		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (exp:%d@%02x(%d) != got:%d@%02x)\n",
+				    xn->vc_op, xn->salt, xn->state, ctlq_msg->cookie.mbx.chnl_opcode, salt);
 		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
-- 
2.46.0.76.ge559c4bf1a-goog


