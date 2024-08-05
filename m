Return-Path: <netdev+bounces-115731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90F947A16
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243EB1C20B26
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF81552FF;
	Mon,  5 Aug 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EBAEC6FT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C61311AC
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722855428; cv=none; b=M9PwNRiwA6z9hk/87NR5+m1Km86ytIEfkBv2lhmgm09rRY3asK5crgajxRFPODDuW0aE8FBVIbqg727G6vLzgSlW4GNXVTcVOdCcdsky79jI/6fnO4F0E3Kl+3sqLex37gfwMJNFNpjgrlbmKwKVYRNT1bFisOQ1FuHuVSpPwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722855428; c=relaxed/simple;
	bh=SlklGaSkB1CVAnGcEiIJsuqo82vRigsMVmvwV1Rzjjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMqzxVddoSP8uLLjKx//YK3JM7EsfnoPAbQwRTBK4hjpxR++HOpNeDxxqqYKAgDYGJSb/OgHqgj8vF4FCKU+WZEePEB9bCK83vjyB73T1TjcYo1YECMKtaXrjtvk8zdMXzAZlL0KdbH3WIfNAiQji8KnTSBU9K1TD3MmNS+YIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EBAEC6FT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a1dcc7bc05so644637285a.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722855425; x=1723460225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJdRS+SiiKicF87avM76gJAE3mWhqo9TmxE70LOsA1M=;
        b=EBAEC6FTYU7l2GP3z86WI2d38sjdpYx1j9kGS3PgHwfx/+xh3+pFB/i/sgi3Sl7Sco
         HwX3GILYpYm77PybMXXQHlrt+7SWTNaJWsJCr1AWePvuVhXz618ZXtmD7a1Evr3b+1fy
         otSUglMLOLHCRr21L45lw+DigdGLbF5hAvXEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722855425; x=1723460225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJdRS+SiiKicF87avM76gJAE3mWhqo9TmxE70LOsA1M=;
        b=gyVaE0g8g64zJB1QiJuNIzNAY8eUX5c7ot1+anh3J7JP2MbNYXa33seHeGW3qKpi5/
         5Sns5l/zX1k46OEvjUYaBGaFvuQ6oWwupjUHPQK0pvp62fblq++ei0MAG2Lxakd4Avbq
         tyqoWvQN40NdmSNjLzxsrnFx4GNVuJxCHhdTPfNkL4ncey1Bheu7KePq6z/FxIl1gl+y
         VYKRiIzSfB+lr7S/c83aOJg9vYOupZs8HB0WF/m+tGvTOUZksru1gyI8VAV7TwOih74r
         43oNOI/yh5E3DHVUSBEvwlpXiTVnZ1bfG2vpC1HAy5xH83m7BJ47EOOz+l1ip8c6gDvv
         ri2g==
X-Gm-Message-State: AOJu0YwNbA+GraOlEFSj32u72BzK1XMRNtDFMql9fAFcpKdwa77siuKX
	rfiEmOzI4GzS2IVQEXHG+ccwu8pY0BGn5AIx0Zza1AqROwFwyBYN//WZNzIX7ozxF9tWEGLVtt9
	HOeALZ57wcMlztqJNg+ek20fR2MJGIRTFL0+F6RQVJ6LI2WIEZnC9aJsy8zWQBRTJQiiyB222mj
	C5RtEmz2LSR/wjA9jMA++vuIPfHlGSdOu+XG8bo5uUqnB3drJE
X-Google-Smtp-Source: AGHT+IHNCD+4Q92uNk1E58bDL60e2TUajHHvn04aZ4fx9CN6Ys5PNOwtX2Ol089UZC8vL/uOe1ke2g==
X-Received: by 2002:a05:620a:2492:b0:7a3:49dd:2002 with SMTP id af79cd13be357-7a34efe28c6mr1236419285a.55.1722855424913;
        Mon, 05 Aug 2024 03:57:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.250.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6fb785sm332890785a.56.2024.08.05.03.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 03:57:04 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] skb: add skb_vlan_flush helper
Date: Mon,  5 Aug 2024 13:56:45 +0300
Message-ID: <20240805105649.1944132-2-boris.sukholitko@broadcom.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
References: <20240805105649.1944132-1-boris.sukholitko@broadcom.com>
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


