Return-Path: <netdev+bounces-251179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78403D3B1BF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE1FD309E391
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA423904D1;
	Mon, 19 Jan 2026 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcghoNoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4885838F946
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768840099; cv=none; b=MEOZjYBptgnmUHqIi+B2bb/IxcUqqKiYf+bBzqBZrBJBvE6mCCOb/LPmRp0qvmkcjaWOvi5uE6+XkRxREIG5cLf8CdYQF+kHb9sb0IJSTZ8DkqKtP3UM9AeMqPR3V+toG3LdTRQapKsFfSnTK8oFDh+VdBkXY63vf8mBHbgCwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768840099; c=relaxed/simple;
	bh=IwaCHerlMxEAkW33lvIFKASVMCVwnEgMKA9VlAKNCgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaphDp1wBLT+2F0LVb5/ePF52ipBCUbjJFUNNKQwZvgk8au8s/9ul5xmcAoO8duWcNI6RLPpYEJ8pmDaVBLnUuWFShF4ypoTZzTi3rmJWTYODtVZv0ML4i8Ig1BXKH5/bBggXxIQw54ZOYjuIxJfUofS/MiQKADykTF0r7FCq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcghoNoK; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81f4c0e2b42so2253834b3a.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768840097; x=1769444897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qavOGxN9mVcoUoS6WgbJ7acocVqABCcFByd5ApUfjsU=;
        b=DcghoNoKBkQtWzNWJKANq1E7dqgs17fmYlg+DTwJ/3EF/y6xsB7GGSTBTP5rrThPtz
         eyHUV5LwojUfkfCTRjH94OXMQaCLdgsv7NuMJFF515Mg5RPLSnfltLnE+t2zCWoDaPjl
         f5Yu6YGqQGoWsU8UMyxEAfkyue/FXKxk0z4uqhm3DbrH32iWYj8W5al5wLlH6aGCWBCV
         Uf/r4/jX2n4KX0JKc65XiORkzbQg73t9X79tCjjm9yX/OERFOdv/WjIbH0le7jWDoOFL
         cTrjAMTltIVJv/jIFyeOSvAmHblxXnmzUD6QfzTYZ++NtmBtof9VcOJqUgmfoZJG94dJ
         jxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768840097; x=1769444897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qavOGxN9mVcoUoS6WgbJ7acocVqABCcFByd5ApUfjsU=;
        b=C1Ma86isWaNI8hzH72JeFtVUIGDhJ8PAdhvsngMdGx7dsM3qRsI34GXfXXaEpQCxqw
         msyAUh81Gvwm/opCNWMbN/HnJ9XQlMnXEK+74tIslYPLNi4mBxFpGFX62c8tE+wkN+m4
         FgpvLUaO4+VgNm3BlB/l/p2pqDXQfvNKXjWTiKvinViTd4o5ivkbdqilRoZT4Bf8nzEc
         R3WJWqSBP25IrJ9fiTF5q1cD8Vl25qlVLcOKxbtmWXyB3iV5AfkAqPrWu8PeQb8BD7KK
         iUsuGfaiaJlxv7ifhQ3RWDerPEm+7k06pam+omY3sJo4LUcDa0AdncusgjilExee9cjE
         cmcg==
X-Gm-Message-State: AOJu0YwviQ3Y45uZNa/plBHjrssC3ialmwgqFewmUZJUYw39ObMfxVzF
	/QE4N7ExS+t5Umvc4VTmjDKc3gPRSes22plAHNOOi3dNMKlXXQay7oM5XOb8+w==
X-Gm-Gg: AY/fxX7VQubUFjWZJSIPBXJQlbusq2hfVsniv2JsJVCdceTH6dgU+oaWI8+rl1+60q2
	mEpRim0RZJHee1zw/88yQPWr/ruqJsSktAKliWmJ7Clw+wL1ThRXMLyytfPr5fcn/wHC8D/ZzwC
	OY68sl6qCzZP8OHugLk5ulTBOkmBvZVVcBbv74y6R+xvqrbO3IbTP4i0zYl+G/8g1Lhp9hI+bGn
	5KekFAhISGlnNVd+vHbLtBYeM6mclk0FGFThrTjJDUCzT7tiIIeRg3f3oHXK9Rr/eYrHP7B9jKR
	zYLJKi3CTAejbQeIVZsTyWGyGWM4PP0W7NYcOll6BdTYoVgseOAZbTDd5QMc3C4V7Vq5u9yJzi3
	PQDPjeLr1DgBC5nMDKZvQVlGu49DQbmL/CBzgjUl7PCys1+6VguG6LwtfoBBS+X7yf4dux2+EWC
	OFCEsb3ii9PavTQAJQ4/9P4cI0ehSTQgCDNNhurO/KNnMNODaDFdVAwA==
X-Received: by 2002:a05:6a00:2e20:b0:81f:45ff:48b0 with SMTP id d2e1a72fcca58-81f9f68f9c5mr10820529b3a.13.1768840097295;
        Mon, 19 Jan 2026 08:28:17 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291fbcsm9644981b3a.55.2026.01.19.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:28:16 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Alan Brady <alan.brady@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] idpf: Fix data race in idpf_net_dim
Date: Tue, 20 Jan 2026 00:27:16 +0800
Message-ID: <20260119162720.1463859-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In idpf_net_dim(), some statistics protected by u64_stats_sync, are read
and accumulated in ignorance of possible u64_stats_fetch_retry() events.
The correct way to copy statistics is already illustrated by
idpf_add_queue_stats(). Fix this by reading them into temporary variables
first.

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 97a5fe766b6b..66ba645e8b90 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3956,7 +3956,7 @@ static void idpf_update_dim_sample(struct idpf_q_vector *q_vector,
 static void idpf_net_dim(struct idpf_q_vector *q_vector)
 {
 	struct dim_sample dim_sample = { };
-	u64 packets, bytes;
+	u64 packets, bytes, pkts, bts;
 	u32 i;
 
 	if (!IDPF_ITR_IS_DYNAMIC(q_vector->tx_intr_mode))
@@ -3968,9 +3968,12 @@ static void idpf_net_dim(struct idpf_q_vector *q_vector)
 
 		do {
 			start = u64_stats_fetch_begin(&txq->stats_sync);
-			packets += u64_stats_read(&txq->q_stats.packets);
-			bytes += u64_stats_read(&txq->q_stats.bytes);
+			pkts = u64_stats_read(&txq->q_stats.packets);
+			bts = u64_stats_read(&txq->q_stats.bytes);
 		} while (u64_stats_fetch_retry(&txq->stats_sync, start));
+
+		packets += pkts;
+		bytes += bts;
 	}
 
 	idpf_update_dim_sample(q_vector, &dim_sample, &q_vector->tx_dim,
@@ -3987,9 +3990,12 @@ static void idpf_net_dim(struct idpf_q_vector *q_vector)
 
 		do {
 			start = u64_stats_fetch_begin(&rxq->stats_sync);
-			packets += u64_stats_read(&rxq->q_stats.packets);
-			bytes += u64_stats_read(&rxq->q_stats.bytes);
+			pkts = u64_stats_read(&rxq->q_stats.packets);
+			bts = u64_stats_read(&rxq->q_stats.bytes);
 		} while (u64_stats_fetch_retry(&rxq->stats_sync, start));
+
+		packets += pkts;
+		bytes += bts;
 	}
 
 	idpf_update_dim_sample(q_vector, &dim_sample, &q_vector->rx_dim,
-- 
2.51.0


