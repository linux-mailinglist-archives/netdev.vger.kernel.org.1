Return-Path: <netdev+bounces-237748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A8DC4FEA5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE1D189CCF9
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039032695F;
	Tue, 11 Nov 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HmXsGRIO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22713E41A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897740; cv=none; b=S7TZpBIY4zWt5NW1Rm9zu/QYk2lX9nY4xhctA+QwIc2d8cn5UIjTxLXLRPPHI5kaz4EzQf33limXnhtauOuues/dViBB0+DfCdaUy08dGApXSDZO5RTDF7nWvlgk5m4nuleVgoz6KI0RYhduzzzYDITmRrMH1AxGcsu9ak+bLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897740; c=relaxed/simple;
	bh=9XUk063q7ndvN+e8EzepXOfJ/4Srmc8fk4pHUuKpfe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxIUE5dbTnghfE9l57HcZVLKoUXZLHxw4FLcS31uul0qtNS/FRbwM6W88bhh+6KEIUOIedcZ41r6a7OgmcfnHGBug492T4oplLUe9uq7chaN7c53YVh/A77n8vv64s4WQUo4i/Xf+EDHRMxdUIOE9kOkJ8V1dD8Mv/tMRGqQ5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HmXsGRIO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b32a5494dso52007f8f.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897736; x=1763502536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aL3vPcTbvy8kvwbzvVRtysaYf0nKcwYmpJm4xLZlkM=;
        b=HmXsGRIOksaWhW/eXeJI7oKI7Wt9zTd7S11Pwh4tnVkQWG2YlArheYZyqN20Iz31pv
         xbRCb+57bDKuSv9Epqw2khFahlCmuJDj8C360bvrX4oyoXtuOhLx2BN2jauQKnFZ3JDF
         JT/QijHVNzwAYKf4QTsTeFS0WWOtEveziOiMgS51xzsvY8ononHzJzg7+U66bM/SZcgz
         R2furGrh0De4sMQxkuHFp32eE5L401U4bfmxH9VqxWY2Gg9kolDRrLSlwfLlM1BqFKFZ
         hQerPmAG1ocT73LwBuXPCcEL7AcHIfWmLSBdh1BC+fICytIDTKShpQfWb672HFa2POt6
         NhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897736; x=1763502536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aL3vPcTbvy8kvwbzvVRtysaYf0nKcwYmpJm4xLZlkM=;
        b=v7SvLNwPECd3cV1CCGolOHV5iIhq5TkOxJ6ZIeP8r/tTUUKbaLHRwdJXJdk14PMpFR
         hlmMlblEa3eCl2REoHRBUYdpNxtO/h7BcZL5WAWcKPCo21YIKByHlIc933Oh4s/KYOr/
         147hlOe7pQ5ijURYwA7c+2lflrOLIQS+jKfi9EtfmeAJFHY4V60iQFqMCiIdIGefasUw
         4RnlgOS17l1Dm98Nr6bQjXWq0yK940fZnphxxwbc9Adtlwz+/wzYD0NC/JZOQYiQ0LjG
         0CJFpOdSGAYZcFNOKlLscsRWEFrVC3Te+iJkFYfH4MJqsrFmSH0hFBHdRPBZ1JtW0bP5
         kcZA==
X-Gm-Message-State: AOJu0YwqpZ+jHoxaoYVRIhPK3HxqwxXJt/Is8PL66nsFH7nk6q2740Xt
	wuUW0LItirXn5Qgmq3NWKevWhwvc46LnrAt6Vyj+2eTAYxc0+wPj/O0yQvFGZQaQzSY/bhnBDH8
	Ww71UzN/em9USu8PHt4FEqzJBldylTdey//c3q4S2AAyG1ZNcCGetfxuVwIa1xwQ3UUU=
X-Gm-Gg: ASbGncuvY9UjkpG6907KNzSOD/SIj0R00yHK/Nh4jgBt2JenMJot1xk70LBh9jm1k5T
	6G57OR5Z0/vANxWqTw5jSi1GZbS7BE3ahYfx+QnGYA4TYSF+DQUx6+44VIUXdWsgAaCs3HvZuBU
	azYq45hqIYuW3+tJfbGkp18r2TF4kzVMsQezcYxVikH96SAZB8jTs0XB2QFPwAKQpWvm1UpW8Yo
	DqmIOEBq0XdL7k+MYVSu0dO2YHW73OBblJcIFxOqTDQmRwYQL7cvwXzUOILdiUKUykcL6Yzd8Uj
	BvhHYz8UdDUtJ/RybxhSG9dv0xl/eTGire5CepciR/IwJmTc15zzyodTHn2EU6WfZhXFJLLQ08/
	/44vpl541kUX82/WOI5tpEI4W4KUFu1VrVZx5RM9tvMX4nBmZTvTKiS2PW6zUy/qrECQv/lDn9T
	Sp6Qhyw8aSPEkkLqdkVDttnKvT
X-Google-Smtp-Source: AGHT+IEaWUajGD9n/6zkMVEZw8ufLv+rs7sCVShFFES44E+1dw0d+bquq6Qjj4k/I6sENQPUGQnKtg==
X-Received: by 2002:a05:6000:2885:b0:429:c774:dbfc with SMTP id ffacd0b85a97d-42b4bb8ba33mr580376f8f.12.1762897736368;
        Tue, 11 Nov 2025 13:48:56 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:48:55 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 2/8] ovpn: pktid: use bitops.h API
Date: Tue, 11 Nov 2025 22:47:35 +0100
Message-ID: <20251111214744.12479-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <dqfext@gmail.com>

Use bitops.h for replay window to simplify code.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
[antonio@openvpn.net: extended commit message]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/pktid.c | 11 ++++-------
 drivers/net/ovpn/pktid.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
index 2f29049897e3..f1c243b84463 100644
--- a/drivers/net/ovpn/pktid.c
+++ b/drivers/net/ovpn/pktid.c
@@ -65,7 +65,7 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 	if (likely(pkt_id == pr->id + 1)) {
 		/* well-formed ID sequence (incremented by 1) */
 		pr->base = REPLAY_INDEX(pr->base, -1);
-		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+		__set_bit(pr->base, pr->history);
 		if (pr->extent < REPLAY_WINDOW_SIZE)
 			++pr->extent;
 		pr->id = pkt_id;
@@ -77,14 +77,14 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			unsigned int i;
 
 			pr->base = REPLAY_INDEX(pr->base, -delta);
-			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+			__set_bit(pr->base, pr->history);
 			pr->extent += delta;
 			if (pr->extent > REPLAY_WINDOW_SIZE)
 				pr->extent = REPLAY_WINDOW_SIZE;
 			for (i = 1; i < delta; ++i) {
 				unsigned int newb = REPLAY_INDEX(pr->base, i);
 
-				pr->history[newb / 8] &= ~BIT(newb % 8);
+				__clear_bit(newb, pr->history);
 			}
 		} else {
 			pr->base = 0;
@@ -103,14 +103,11 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			if (pkt_id > pr->id_floor) {
 				const unsigned int ri = REPLAY_INDEX(pr->base,
 								     delta);
-				u8 *p = &pr->history[ri / 8];
-				const u8 mask = (1 << (ri % 8));
 
-				if (*p & mask) {
+				if (__test_and_set_bit(ri, pr->history)) {
 					ret = -EINVAL;
 					goto out;
 				}
-				*p |= mask;
 			} else {
 				ret = -EINVAL;
 				goto out;
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 0262d026d15e..21845f353bc8 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -34,7 +34,7 @@ struct ovpn_pktid_xmit {
  */
 struct ovpn_pktid_recv {
 	/* "sliding window" bitmask of recent packet IDs received */
-	u8 history[REPLAY_WINDOW_BYTES];
+	DECLARE_BITMAP(history, REPLAY_WINDOW_SIZE);
 	/* bit position of deque base in history */
 	unsigned int base;
 	/* extent (in bits) of deque in history */
-- 
2.51.0


