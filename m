Return-Path: <netdev+bounces-246167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1D6CE4840
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 03:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860203007C67
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 02:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BC8460;
	Sun, 28 Dec 2025 02:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBNM/jBf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFDA17D2
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 02:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766887269; cv=none; b=iQxv+OsIlFuZTDc84KVFiljjmKuBlZmiak3w6zqCaxtY3TDHUWiLvLX0tzd2kU8+NeDvv1CNZrqbKJTo1U4kSRIkXXJXlVOy5zmUZ+/WdAMRrF65c+9EqJuhuHFpIEVVyT5rIlGM4h5FUvpm0o5vBBC8FJ/dEjRcWxL1D9qMqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766887269; c=relaxed/simple;
	bh=/uyG9JXkLQyHcIhtoWa0j324fE2ibC5y8+Qj9X3PtIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/5LzqqzKtpspD9Stlui/+qdlfSDEXBd9FnaFANejV9w6NREbOMLw5n06hMIJWgA+BIzfNDt+1gC/+t2GstAFN63I5HOOPGVlXrbt8x4Y+5+CGdohxCB3TOjErtVOn5QQoANb/K1ROs2NaD7P234lQRgHnSrueoWQMfrIKGeQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBNM/jBf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47a8195e515so50579115e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 18:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766887264; x=1767492064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CGWm7f6uw+wCJESodfTeqyjz5qDHRxaWK8I849X/lag=;
        b=UBNM/jBfSCrrC8qdNUPB2Twx1Z8Oa0DVQCoR1SgIw3IgSGAGqWImuF2qzNXfib78+y
         a9XXYDm7qL66f7eu1anlanLfHma58gWHqc+HrcskXRLNLPLiM1lBsqS+71ZZf7JpEsL0
         1zVIbT8xRt2MbIjvjIBe6Xckoz8JDYT28VDCgqu+P9ojeZzxmr8UVh2hrRQnq1I3N7Ug
         c/po9yOJDYK4X3CKuhTCRg/zx/W/AnmeBTkotB0qFD/mqJbCH18XUepVbxJMPoRVrrpk
         Xqt4c7f2Y2WGoaM5QfGZasdR4qmHZgEgxdAio0mM0CU1/xeWOKuexLjTE4xQRxV4FJnY
         YR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766887264; x=1767492064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGWm7f6uw+wCJESodfTeqyjz5qDHRxaWK8I849X/lag=;
        b=nm34hlrR7kZkLlwdMwnj0bErcJO983+HOoIEvVLhImC/gwdkWu3Mw2yt2XXQia9FOE
         2U6Pzt+bJVUCU5n6HuZDhzIrccrmb3IqMHilEZZWZaqdDxxKy3GVhmgdWgYpO8K8okI3
         h4NZC+yt5A1CYu2VoiFdmkHZ59hUaycN6lMrSzNQjLHZ7F+A0zZbTMZO2Ja+J31031+e
         lg5X5YbAML3v1YZsM/MOavSzjf5e1BOlW5kT0A49h4SR2NqD9WWjU8syKDmE5y8WEhis
         HxY/5c92ckzocQI7/5diA4xhiq7JflLyXEg6SgaGVKmWdgmtfWxlZJ/geVxEkx2oeUfK
         BjLg==
X-Gm-Message-State: AOJu0YwKHgmz8HI7IjpawQx9cOQ9q/yDnXqiKkDEh/mztU+RUoJnYoz8
	8NyQxVStKUG5NP0YLIynKz7QEdQnFkEXIurDoS12CglkauR5GJr/X5CacsuqGw==
X-Gm-Gg: AY/fxX5e6IWZNlqaRLuE/IIZYzjJyodLMh8sr7r9OFQCqIpaWue/NjaI3HO6Wz+KN5g
	GbTVlOMajWwTb2myK898KQNhb6HhHMKy3yjjlXaaLE5m7LTdHabKzDLABpCvvFNUKz0pZJDJoHL
	WKtOMYIUo86eI3LPPCi6UEz8S+QLe4QT3nvkh9P0DyZ4hJTOaRk0M2TJkEBynz1Xr16MTFD6IIc
	8FRKMKKxlt7HpAwpE4m5g6idq2y16XbbaOHHX22IuNID8Z+m34/TTJnsxes6q9saL0/bKlEJ9GM
	7bQmqZnI+aV2V0pFOfXhODgtIZthUNJXy4RsB2GtOpmWUL2ZyuYvbY1nq7jLzEFY091XR6ASan3
	C1qhIx+EV+Dh7FGvuHAi+zaCuvc5cNj6EVNO7G8f4Jf9N2vAz0/RkxiDzZZQPpsA/kWUNqHnlhs
	r2UQzEFWBjsCkm0YZmvb+wP3kgz8XjIT87aw==
X-Google-Smtp-Source: AGHT+IEUkSWMS++nf45AkVJ3pb8cfwfvx628mI/2jAeSksf9uvk3Ak2ImCdT6UECWOT3W7R46ucPdQ==
X-Received: by 2002:a05:600c:4fcf:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-47d194d17a8mr293216725e9.0.1766887263690;
        Sat, 27 Dec 2025 18:01:03 -0800 (PST)
Received: from registry.mehben.fr ([2a01:cb1c:8441:2b00:c694:3c2c:878b:f4c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19346d33sm479953185e9.3.2025.12.27.18.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 18:01:02 -0800 (PST)
From: Alexandre Knecht <knecht.alexandre@gmail.com>
To: netdev@vger.kernel.org
Cc: roopa@nvidia.com,
	Alexandre Knecht <knecht.alexandre@gmail.com>
Subject: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress
Date: Sun, 28 Dec 2025 03:00:57 +0100
Message-ID: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using an 802.1ad bridge with vlan_tunnel, the C-VLAN tag is
incorrectly stripped from frames during egress processing.

br_handle_egress_vlan_tunnel() uses skb_vlan_pop() to remove the S-VLAN
from hwaccel before VXLAN encapsulation. However, skb_vlan_pop() also
moves any "next" VLAN from the payload into hwaccel:

    /* move next vlan tag to hw accel tag */
    __skb_vlan_pop(skb, &vlan_tci);
    __vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);

For QinQ frames where the C-VLAN sits in the payload, this moves it to
hwaccel where it gets lost during VXLAN encapsulation.

Fix by calling __vlan_hwaccel_clear_tag() directly, which clears only
the hwaccel S-VLAN and leaves the payload untouched.

This path is only taken when vlan_tunnel is enabled and tunnel_info
is configured, so 802.1Q bridges are unaffected.

Tested with 802.1ad bridge + VXLAN vlan_tunnel, verified C-VLAN
preserved in VXLAN payload via tcpdump.

Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and egress paths")
Signed-off-by: Alexandre Knecht <knecht.alexandre@gmail.com>
---
 net/bridge/br_vlan_tunnel.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
index 12de0d1df0bc..a1b62507e521 100644
--- a/net/bridge/br_vlan_tunnel.c
+++ b/net/bridge/br_vlan_tunnel.c
@@ -189,7 +189,6 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
 	struct metadata_dst *tunnel_dst;
 	__be64 tunnel_id;
-	int err;

 	if (!vlan)
 		return 0;
@@ -199,9 +198,13 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
 		return 0;

 	skb_dst_drop(skb);
-	err = skb_vlan_pop(skb);
-	if (err)
-		return err;
+	/* For 802.1ad (QinQ), skb_vlan_pop() incorrectly moves the C-VLAN
+	 * from payload to hwaccel after clearing S-VLAN. We only need to
+	 * clear the hwaccel S-VLAN; the C-VLAN must stay in payload for
+	 * correct VXLAN encapsulation. This is also correct for 802.1Q
+	 * where no C-VLAN exists in payload.
+	 */
+	__vlan_hwaccel_clear_tag(skb);

 	if (BR_INPUT_SKB_CB(skb)->backup_nhid) {
 		__set_bit(IP_TUNNEL_KEY_BIT, flags);
--
2.43.0

