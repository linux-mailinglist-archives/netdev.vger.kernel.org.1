Return-Path: <netdev+bounces-118464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A63951B5C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E301F23C4D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6BC1B1413;
	Wed, 14 Aug 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nx2uzmij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447581109
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640801; cv=none; b=rxOQfbAwn/7+ASrvp4hIxKgw3vFT4gx4qgeJrnX3tmR2+cL1zDzvjDpxHXKciFWTiWr5t4pl9/8qpT8dgGOJY6MvJ5L/2HMPNKBraM0uJbF7P0dPe0GQDsZFfiDoVLql1nn7f4SQWB0vni9V0yernUosQwzmECfiL1HJ7jUDXwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640801; c=relaxed/simple;
	bh=SlklGaSkB1CVAnGcEiIJsuqo82vRigsMVmvwV1Rzjjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHqPm5BB+uIrCIqbKrSZUrZ+J2fyVt386rE8ikksdqs8/DcYy4nCt5j15oM6fjmhooXhdH6aN4jq6sFXixAxRaJcmB5q72Tc6Qgkwb+7d+nyh1U3vGiv/A4aEC9kZJ3uAxQibRAaCrG9RNVIJ5gr/Gbze+P36zpZnBiUb7E+PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Nx2uzmij; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso4969682b3a.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723640799; x=1724245599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJdRS+SiiKicF87avM76gJAE3mWhqo9TmxE70LOsA1M=;
        b=Nx2uzmijo+LP4BtzcCXQ/Ml7X2NznbCzybNcLDwUPwDw8zm5T7pgKiRXnEUEK5OujE
         qMsYXNLoRhodMvfr0dWgetuigTnm2OSRnRedGw/hrfVvqqr2A81Ta0q4eeBJlms99AQD
         J0h0pyaj4wvN9g/WNPNayVcrqpcnEFpLRv6xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723640799; x=1724245599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJdRS+SiiKicF87avM76gJAE3mWhqo9TmxE70LOsA1M=;
        b=q4PgS3pFf64ZjIINSFzRThoaRt9f4KqZA2sdrp6Lnvgg+dF0Vz7cAWGA7xYwwTdaER
         vnCSevJlkn6pTBq2u0/+MAhMf6xUBL4tcu99RmLsV8gCDyGIEU/Q6HXN4Gjbm1leJm00
         /JksCl5z7fN2s1QWjEUByyqx72SyWEzIw5//YzJ5a4pzWkY9hrUp/uLwdhB2j5v8BZXz
         TSdMkXJhdn4SOYWnXWQQHkQ+3TmZD+3P8WK2tT2SvwXQGNCmpIukH+lUFo9EIWlMxvuC
         eN3UWQuwng15LRckmdMH2A1qMAiEz3bKae7xQiAdl3WZUPcRLp2Z8/mQngf0nMLVgFX7
         1r3Q==
X-Gm-Message-State: AOJu0YyjncRMmz/KAO++QjBlNg82fuHXM0/kFSMwUIw4hp73bzBWrhDB
	JZ3RsRNN79ycFXpz2qWYVW3KlPrqgqd/OpChnQrsW5guq8pmEZPaxrOiYtbmgPVWECR1lJSo8M5
	x53isntWPgiDGmXXJ99ncauFHJzPiHI8CVY4sCvXTUu18bMYzZa8n+FIwb263wF1YPKSnfNUMna
	W4sDXRFGqP+m/aaK8RfYWVlmRWIICT+QRV6OcYn72euFDmVDJ9
X-Google-Smtp-Source: AGHT+IHtR8wc6H7BmYCMXw9Fe/+/9RGP+sY5pV/IRcBYSi6n+iwcy/T5+YA4I0mchKBGxtpL8KNJKA==
X-Received: by 2002:a05:6a00:4f95:b0:710:4d55:4d39 with SMTP id d2e1a72fcca58-712670e8635mr3028656b3a.4.1723640798593;
        Wed, 14 Aug 2024 06:06:38 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-711841effe9sm4904543b3a.31.2024.08.14.06.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 06:06:37 -0700 (PDT)
From: Boris Sukholitko <boris.sukholitko@broadcom.com>
To: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: [PATCH net-next v2 1/6] skb: add skb_vlan_flush helper
Date: Wed, 14 Aug 2024 16:06:13 +0300
Message-ID: <20240814130618.2885431-2-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
References: <20240814130618.2885431-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor flushing of the inner vlan in the skb_vlan_push by moving the code
into static skb_vlan_flush helper.

Signed-off-by: Boris Sukholitko <boris.sukholitko@broadcom.com>
---
 net/core/skbuff.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 83f8cd8aa2d1..23f0db1db048 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6220,30 +6220,38 @@ int skb_vlan_pop(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(skb_vlan_pop);
 
+static int skb_vlan_flush(struct sk_buff *skb)
+{
+	int offset = skb->data - skb_mac_header(skb);
+	int err;
+
+	if (WARN_ONCE(offset,
+		      "skb_vlan_push got skb with skb->data not at mac header (offset %d)\n",
+		      offset)) {
+		return -EINVAL;
+	}
+
+	err = __vlan_insert_tag(skb, skb->vlan_proto,
+				skb_vlan_tag_get(skb));
+	if (err)
+		return err;
+
+	skb->protocol = skb->vlan_proto;
+	skb->mac_len += VLAN_HLEN;
+
+	skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
+	return 0;
+}
+
 /* Push a vlan tag either into hwaccel or into payload (if hwaccel tag present).
  * Expects skb->data at mac header.
  */
 int skb_vlan_push(struct sk_buff *skb, __be16 vlan_proto, u16 vlan_tci)
 {
 	if (skb_vlan_tag_present(skb)) {
-		int offset = skb->data - skb_mac_header(skb);
-		int err;
-
-		if (WARN_ONCE(offset,
-			      "skb_vlan_push got skb with skb->data not at mac header (offset %d)\n",
-			      offset)) {
-			return -EINVAL;
-		}
-
-		err = __vlan_insert_tag(skb, skb->vlan_proto,
-					skb_vlan_tag_get(skb));
+		int err = skb_vlan_flush(skb);
 		if (err)
 			return err;
-
-		skb->protocol = skb->vlan_proto;
-		skb->mac_len += VLAN_HLEN;
-
-		skb_postpush_rcsum(skb, skb->data + (2 * ETH_ALEN), VLAN_HLEN);
 	}
 	__vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
 	return 0;
-- 
2.42.0


