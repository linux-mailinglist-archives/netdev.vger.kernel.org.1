Return-Path: <netdev+bounces-293292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MtWLdwxGmp+2AgAu9opvQ
	(envelope-from <netdev+bounces-293292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD660A353
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A903022568
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 00:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB52BE655;
	Sat, 30 May 2026 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ownu/PJH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73D2641C6
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101592; cv=none; b=jBKtZluIf6DQRNoUOeEHrTHkanygNzKMI8X6Bl7ZErrPnaomm4MbzeJ5d0aRWMb5uASMQ1KDVcaV35sPBY/XEV5cBdIcj6hUOGnKzPMjk33kZrqoghWT6gvcwgs45qDs6cmgbB5t6nY3V7chlciJO4DZMrFrALaGmRPoc8Y/+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101592; c=relaxed/simple;
	bh=kIc3TIE4Ubelo0wkpsHjs9AfK3UYLECixyGEY2hat7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ncj3qpoYkJfDh3Hks9PBNRl8x5H6Vu3H98CZQ7vONJ0GvlhFi+hJyFl8jInEGH4jaAwzoEOH2twYfWmHNTfUmpHpC3/hDeuiiM8R6IVdZjsdGh25Z3dI/ruVTceAPNuKriNsc5L+ZiZh7rHvtL9sAX7KxWRBNT7H8ZNbSQjNVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ownu/PJH; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8571b55c62so536578a12.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 17:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780101588; x=1780706388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jz3T0O0wpFH1RVLbyXQa7kC8pmRBVcVcaLsdI51nwCQ=;
        b=Ownu/PJHnBTubVoQbJOVqdaCOqePTCDta6NStB/g1znCPcSZO68dfbBZXg30cLJ4L0
         pzADimegM3ST1S3BNxJHEl5s5rrEfgMNi6JT/XHk1a1MbwXmlogZWWDIjxx9qcMwB0ob
         r7SxDYYPPiHN/sVYABL4n8496ekceiE3Ff5vTpYCoBg9hBuR3jf1Av8yy+0mw3OsmA1j
         Rym8L/kP8ZhXXLJuFuSKxvL0fhTmPs6tFcBEO6ywP1UflGdqmZ73lzzTSMJpWYpyaZ46
         JLlHIVOKzA38wcUtIy/NgbrnwJInT0fD05wEaloiAPED+Sz1Xal6qW5YnaadSlWQpLtZ
         lyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780101588; x=1780706388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz3T0O0wpFH1RVLbyXQa7kC8pmRBVcVcaLsdI51nwCQ=;
        b=pVuJKFZ3xSwXCCPcJ4WU1zYDJ/LxA+Sha5ddrHuvz2sWAGllHCPGUO1laht40Hxr4m
         5TfLOFj1r8fifSNUe0yBMBkZDLHZpPC3lxqQeQwqkEjfm04+BN2R2K5xZwvhctmc1mvf
         kQIW0EZDLUVj7qIebkflFdCrZFPnY0sM8W+i0yD0fI2j+CkLy7R7pa4dCsEHqliqdq6p
         SwGs/7Xe3OvppMiXxVJ0WYkaPvU5T28S/PdYWtFj2P4l7hcWogoLUleULAIlei5JWlIX
         nyjMA8gptLfSWnpeorlvFz3EzmvL0M5Tpyu1xCDbutb4qr7F7OWd7E2zCwS8+a6SYSiq
         Hm4Q==
X-Gm-Message-State: AOJu0YxOe7PjmSh+zeuCZkayc2XZWReASV8eEJ4qu/XbYfZifsmu63Sl
	Vyrid84hc82fi09mXna2grhjOaFLzH2NFHioj49MPYMTAlQ/hgnSEFbsm08hB0tZ
X-Gm-Gg: Acq92OHElB/tils+KMeUrg4LRDTMhlHvjPOOmzlJ1MVI782yginIGIG3uUVUZoE5KBf
	LvPADcTZwsXYie6x7oR0gqvCWJerbbtY9OHMTdS+I50Zf/AjE+zEq59STUOfsyidHOCgKSv1aaI
	KDbMzSpJ6onNdfXD8A9f2glJ0bm0LfuqV8+GCMLHRrkN2brjCGE3rXG8Vz8YdVqk/hqcFO17VN8
	eRXKeDpnlEzoq8sfTZI7vXo01FixSNybEOp5UHlFBqpLdGNU8kogzfqifXf2L8ntfkTQl4MY+7G
	/ubPPws6S+dL7Ir/ZVybiZ5o3lrZFOv2PpTRVJ//HDjvPNKssDah7tlBSQsph9G2e8aXytlPbUC
	926l5udd4QFclREfAj9HP0jgvcVsNf6hw/b3i+lS2c3r+AvjjTwLrwSyn4yiAy9Tf5iGPpzva4V
	E48Wy0XnV1H3vFkzIAEeVqxmdgXera+5grOv1QubK16K/bqHlX+Wz2Gd0y6HtQD3ccws3SxA==
X-Received: by 2002:a05:6a21:9f07:b0:39f:acae:f12e with SMTP id adf61e73a8af0-3b4280696a4mr1664403637.22.1780101588408;
        Fri, 29 May 2026 17:39:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:38])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214cecce5sm3504930b3a.57.2026.05.29.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 17:39:47 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: dsa: sja1105: flower: reject cross-chip redirect
Date: Sat, 30 May 2026 08:39:14 +0800
Message-ID: <20260530003940.2000994-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-293292-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 37CD660A353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dsa_port_from_netdev() may return a valid port from a different switch
chip. Programming another chip's port index into the local hardware
causes redirection to the wrong port, or an out-of-bounds access if the
index exceeds the local chip's port count.

Apply a minimal fix that adds a check to catch this case and adjusts the
extack message. When cls->common.skip_sw is not set, the operation could
instead redirect to the upstream port and let the software or upstream
switch(es) handle the forward, but that is not addressed here.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v1: https://lore.kernel.org/r/20260528203549.1918040-1-mmyangfl@gmail.com
  - rewrite commit message
 drivers/net/dsa/sja1105/sja1105_flower.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_flower.c b/drivers/net/dsa/sja1105/sja1105_flower.c
index fba926f85b47..7547999a113f 100644
--- a/drivers/net/dsa/sja1105/sja1105_flower.c
+++ b/drivers/net/dsa/sja1105/sja1105_flower.c
@@ -391,9 +391,9 @@ int sja1105_cls_flower_add(struct dsa_switch *ds, int port,
 			struct dsa_port *to_dp;
 
 			to_dp = dsa_port_from_netdev(act->dev);
-			if (IS_ERR(to_dp)) {
+			if (IS_ERR(to_dp) || to_dp->ds != ds) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not a switch port");
+						   "Destination not a local switch port");
 				return -EOPNOTSUPP;
 			}
 
-- 
2.53.0


