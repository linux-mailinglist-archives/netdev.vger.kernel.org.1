Return-Path: <netdev+bounces-126390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49B970FA4
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66CB1C22230
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BD11B1435;
	Mon,  9 Sep 2024 07:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqgNyitc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994B1B3735;
	Mon,  9 Sep 2024 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866638; cv=none; b=FgBx1o8YrkfOc68bkh8rJTyLrIUSLwmNyPml/iHf96tJ3DjteE0x0r8PVj71f5CpnUBkXjR1E9ktAi7iCWMfbaWcawVucQCIanFJP+yxvU6GZ5uduyU2LT4ndEcn3M6RRH8L4Lfc1Jsyt+neyBqV/0kc46XAYFxXgc6JA5kUpXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866638; c=relaxed/simple;
	bh=toj+Zj8YiksPTFP9u5LTXtJP7WTuLxp85UOH9c3IsJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0w28da9WVh2cRB4WLgdB7CbkBPo8fii5DWWJ1MSyfSVAoSwcYTrHov04L46TXMZF+8Se0CXwd9CSxsN+e1oBqhIvg3SVbB4dXlDyCTpSK6yKzfmzQnBKSE44D33lB1Qiah7jNK5slUtME+un80YUd1rnSKXdCxBquEkjiQqONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqgNyitc; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-5e1c65eb5bbso704324eaf.1;
        Mon, 09 Sep 2024 00:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866636; x=1726471436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgqtJYbnjGs/2r/XECSuJ/EOdpL7pDrQy8nnT8uk/o4=;
        b=cqgNyitctuYKs69BjXnP4464CqOL3Fii7FXzrUVU+1X1HF++rHOHj42kfmiBNVz3Rs
         zX6qtgJ7kR3DRDGB3raOBz53LpkJSTSIaMy3vG7V9Jpe/1ojYK0u38upDEhwfN+K2/8v
         HEQsmUHKtCNIA7HMO0rD8JiXHN0s4PiVPf1npBIPuobB7/UtxQ9kVq/pPX4k6s06AT5R
         +n6mQB2DbioDOs8eS+YAmhagEueRXvMkb5c/eTAwlF0Bl2ZBL6Eh9RDKbkfefQbrEcYJ
         LP/Vp3mzG8v5m17uQ/D+BrxNFZxhbIOR6aQ8RYYPLVQ26aBuI4a4SS9DMECYeE4RX2+5
         3asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866636; x=1726471436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgqtJYbnjGs/2r/XECSuJ/EOdpL7pDrQy8nnT8uk/o4=;
        b=TBJWNyLtUdVgWqE/Z+mf9fn6uQ8LbekJTpvrTvoFkRTJgoihUv8U9bD4pswVS1DYuI
         r/V4JPbI/VrZmyYUaY6/HSEHqzcm0szp6f+SbfEc5WKgSfbAFMnuYCbMRZ0Yw3mOzOIq
         bKRd3O5odnYTytTNdVGbHaPXNsWn97kiQti3l3Q/2ppu+qmy707qE6FCu39+SPIVrEOJ
         MXRGw8fLeJs2VaCvkMyOyuG5w9edOq1+DQN7ri6PukAgkMusndxfPVyMSsG+fo5iPBdZ
         zyRAqbSX/Oiw/hwRJiTU8AkRI5rTxUMEmWijenEWIb4T7fn2SyMEEpXkU9S/v0Os3e0I
         Wzaw==
X-Forwarded-Encrypted: i=1; AJvYcCU8PdZhVXRTsM00Fyz5OzOmoVDJAAlGyacusI1wvXEDhaIcfqOFhDutPDEzaAQoUmWo1OzxRzxf@vger.kernel.org, AJvYcCUGfifwjKHgouVGwN3PhCxUmosK1OGCgfDo08xPb/8FoBflZC6LcEIOACbiHXUD4aboMYe3A7vyzTDWEFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYd7WnK2KiU8ebMDlgsd+22OzlahZplSUq8eFhRNqI1dtnzpGY
	2sSCKQkdre7R2byuOp8ylHVbzTLkQd/L/SQWERn8OXAsqHrzvYvd
X-Google-Smtp-Source: AGHT+IENdfs1+2atwumCxfhREmOidOulsOVXV2bYz8Sd43xh93QvdzUxxqpYXCxI8qBRsgWGG6I7VQ==
X-Received: by 2002:a05:6870:9629:b0:277:caf7:3631 with SMTP id 586e51a60fabf-27b9d92a835mr3095911fac.5.1725866636353;
        Mon, 09 Sep 2024 00:23:56 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:23:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 11/12] net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
Date: Mon,  9 Sep 2024 15:16:51 +0800
Message-Id: <20240909071652.3349294-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
References: <20240909071652.3349294-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 78e4a78a94f0..96afbb262ab6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2290,7 +2290,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.2


