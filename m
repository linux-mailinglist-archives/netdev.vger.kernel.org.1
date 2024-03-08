Return-Path: <netdev+bounces-78877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D47876D46
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 23:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE261F21FB0
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869FF2D05B;
	Fri,  8 Mar 2024 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="w83WA+6L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5964D2747F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709937785; cv=none; b=EKp1Ys0pEfEsTQCGGZIYnr2akb/k4j6g2oy3zO50LnN8GcUqe6ZGDoO7AcQrn/OdMktYWad41jmBOM1NRaozSeIYkDLKmNS9HN+q/ImRVd0mOt7RTCXjP08L/+Bs0JczXom2edH9HKdAp7gteLwbPmeZqfGEzYcAsqK6JADiOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709937785; c=relaxed/simple;
	bh=8YBEaFFQoOWNvJW6Vi7307jpuT4v1kzjypgdoMW9EPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I4ONcpjG4y/cAMlbx1lYHrXNdLDuO8tVa2PRH39/Tfyal/sUoSoJJ2vLEDzkjcEa/yuC/vieku5jWLO2t4qPxWasqp31U/hG0oPZeTudTRVT9xNnBROuPlsGBqOWfrjsm1c8j9Ffp8hj2TxWlq3uAY96jem6uvccSZ2Ljz9P4VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=w83WA+6L; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d288bac3caso16622641fa.2
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 14:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709937780; x=1710542580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxTbh1S9LNXvBZm5HAEJ6i2YSyuHJ0RHO3jNupLKblY=;
        b=w83WA+6LOVIObcnOE9oQ8+KD/Kt5gqXaX+hIZ6Oc3v3Kga9jyNHvNkIdaBHvUyoYu+
         PaldD+YUg+8ide7ZOi+6uS4qXE3muuahloue92pjEWlb81Zje8AociJqiaVreD4TWbWY
         F5cnQRuDN7he/QYZEr55rVZGnRsAJcgaQSmunU6jEmRd6e4tMo/SbeYAz+XkKOr3uFep
         2MFaMKvYNFaQars6WE9KHLIwM9EDYxFAAkd+2Yqo86V5c6rEKsERKmxyO0JsIFhSBIkC
         nokNaD0/RnOqNNnBz7dHJXNIzqxRgwbcGplpcJlHq8eIZkjcQllaCbmDh1vQezLo60Lu
         lBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709937780; x=1710542580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxTbh1S9LNXvBZm5HAEJ6i2YSyuHJ0RHO3jNupLKblY=;
        b=v9t3+dDhK0wFpuOSCbUqTcXl1SIY+meE+vp74enkL1CTgpUMC5y20oB7A6b0A+xZ6/
         iLpHvQTMcejr9p2umjbzt1IuekmYe0Pn+QFAxMqUx68erj2MXBue/Ma99k+FFnOCB0H3
         Jf0jAWMOlq1PoRRLVC5OPBMRwIpkJsdzA4rd3apFkEFa4t+iUjN7QVNk49DVxV6oszw8
         ilmybCFi56S2sojJR1xKwRhfAyjogy0SmmTjoV7gjylFi4o/3v3xqE4fyu/xTv1XJbwv
         L6fHyoqA2+jaZeh/oxNkxT4qFuxkS9RkwnKaPsjIyXP+C7z+6ecEflBhL6YSReQk4jpZ
         RIjA==
X-Forwarded-Encrypted: i=1; AJvYcCUx5/5uHzKWLWxXUrE1RdBCNBca6djPKv6gnX2hXXS9/OohgGHdl7qIbPLRdwjgeI2v2nVig5PlewSe8z3E0x/BcwL/sglJ
X-Gm-Message-State: AOJu0YzDX1tzlq7/XB13E4CMLg9Lt5wW8A0hJL1I4O9drAXz2y7mqkXH
	R6MmoT0rDRouwjNnJj0NdH6CeFWcocob2nojfIY2Oi8BMlr3jZY0L4/X7DkXnnI=
X-Google-Smtp-Source: AGHT+IGIrGIXdjscwoUnyV2KB3k7UIcz0Ljw6JSdc+MRgKxeFC0To5M/gOskkCIDD/HIWU4dUVpwCA==
X-Received: by 2002:a2e:9c44:0:b0:2d4:2958:6daf with SMTP id t4-20020a2e9c44000000b002d429586dafmr68310ljj.20.1709937779842;
        Fri, 08 Mar 2024 14:42:59 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id h12-20020a50ed8c000000b00568299df7f0sm207043edr.1.2024.03.08.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 14:42:59 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next] ravb: Correct buffer size to map for R-Car Rx
Date: Fri,  8 Mar 2024 23:42:37 +0100
Message-ID: <20240308224237.496924-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When creating a helper to allocate and align an skb one location where
the skb data size was updated was missed. This can lead to a warning
being printed when the memory is being unmapped as it now always unmap
the maximum frame size, instead of the size after it have been
aligned.

This was correctly done for RZ/G2L but missed for R-Car.

Fixes: cfbad64706c1 ("ravb: Create helper to allocate skb and align it")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fa48ff4aba2d..d1be030c8848 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -979,7 +979,7 @@ static bool ravb_rx_rcar(struct net_device *ndev, int *quota, int q)
 			if (!skb)
 				break;	/* Better luck next round. */
 			dma_addr = dma_map_single(ndev->dev.parent, skb->data,
-						  le16_to_cpu(desc->ds_cc),
+						  priv->info->rx_max_frame_size,
 						  DMA_FROM_DEVICE);
 			skb_checksum_none_assert(skb);
 			/* We just set the data size to 0 for a failed mapping
-- 
2.44.0


