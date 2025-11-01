Return-Path: <netdev+bounces-234870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E25DC28581
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 19:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C277F4E0F80
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16327EFEE;
	Sat,  1 Nov 2025 18:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCW4y7dR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65386B652
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762022142; cv=none; b=sCxXVuOYiKZ4H5xbtH4KBI593enSbbKfOCa9BrkBNxGDADAyp2aKNV4VfBGLjqa/t52txzMu4VevcNAZlHN0oKQUVW8Zf20VUCFAIA4F1Gcjgw73l1OXCWvKYSDbxXMZcp1cI1CSwYI59gwBSe9kEX80SSoiTCXg273HlC2oufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762022142; c=relaxed/simple;
	bh=4sUqxa80eDuptdCLV+9yUlpRXQVSwLs4Gf5XQWScT+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S+mxWBqQuSMjgJFjKmKEZcUFZvc9jHuOd2KJBsNzlkrsBjZ7joeDA1imlLwnLVx3hyIYWibQafFM+qp6qsorvbsPpe0B/RzdksaY06zrdZ2eHZa8l+SvJ7BptxYYuchnZadfFrQ4VdD0Ct5BY1a9WPk5vgX0Iu9lWZKXWPkuADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCW4y7dR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso26467885e9.0
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762022139; x=1762626939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lFcBnQWmGxUHkWuOHMhhl9sQofbkx4ng+ZfaT543MNM=;
        b=WCW4y7dRv2fMFk5KQolOvjP45emeJn8LXvKQUkBbPyl2W882te1oSPRPpLnxC3qXqX
         waU7vZ2g1Nx98CMpO72FHFDoVeY2GYOr47wUSXzSAr3ouhY1smGZhx2SJl47oWtKxFXD
         /wCPLw5Lha9Ucs4OKFHJ44RJewakowUuVt/W+pkyObPjyd3XQquuPlzB3KmLu6fG0pqt
         /eUfwrLtguJKDARBbewCVujxAnOBfAZEEZjqhEpRRtp2mkdlfqtuaheCYqm4UFtl8Mef
         Sv6PollxLXtLTtITTl6cAqe9PyX/cOq69j47v9s6rCwWeaRfDbRj28Uv99uljRTkvLOC
         QcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762022139; x=1762626939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFcBnQWmGxUHkWuOHMhhl9sQofbkx4ng+ZfaT543MNM=;
        b=geHnGLXnBhEPP3voy65/Ov2gwYfR8+bevSqtG1oA1DZ2z9YtzfK3EiUMQSIvYLP9to
         lcMdfAa6bzNF5K5Mh4nkITrtAU/Z/Qht0Tm9pRNokQPDPvy2Le3aJgwBKapmhLHw6HPW
         IczrgLMKWtkx5X5Add47YFUevTKT9HTKHdIEFRXjwfkjC8jls4eItGRArKLO7uN8naxX
         3EgCHWrre2VZGwI4Llj/2MDKhObJkRzZ0jDc37ESy9L+FlXLWxxnTl3rV/HKjLxs+6YG
         cdPH0aDbvX9PDaoqMr/vxqt/+Y3+2UFqrt/CHHx6BSlMOTjgHZahnc99kGeeGA+US2V+
         qKVw==
X-Forwarded-Encrypted: i=1; AJvYcCUmcgNl3XVC+rbx1hr1CNHoYkk8erUilygtDYmCxl0djyH9ZbUDy2GuQ+sXXbzkqjO8+ShKHKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU/RdPNstZVrwsC16+WWqGGOLiYBzG4TuP9Y4z8chAD7KpQeLl
	wrYE3aHgjSEJv1wxQ/eoDgoJ9sB+1f2D9gz5bEev2gRd0ZxRzWUV734SWY2SAdZk
X-Gm-Gg: ASbGncvv45x0UIKclnMSVx87Ug+RGNcqeqDS8WH3wpAeEIswkxcJAtjEtpmX42NnvST
	/Ot1YULnVZ+5F1H1bjjIjtl7To/oBYeyz6J4CZPamzNj2FFyouVipW/K0DL3/6V/TTEiodNXUT2
	9wvtA99S3QQJGQEBSxHiT4kyZTTZ/aqkSDW6gqwAR+OyXYfDZ2n8cCVuS2K/ygK0cn1c8lUq2wp
	OyD8jv5XEmBnT4MHXsn6dONERxyzmUfIKiOujm1zJ5x8LRE7BJV/O7j+z4qmPQ8GyonIGlo5O/B
	TJzie/M7YsEGCdA1nmnc3E3GVbXy7T8yMdsbWZ0z93OJEioWSkME8ky5PI4b3pFoqRCf1ZUM7ry
	GZTJNa/MP6KY31+l80qPLEQRTjrNloEltdmTNQz9KMZOUCoGOgCYTWw8onvIuHqRqKsJbgXqd/3
	fW00GsICg+MQ==
X-Google-Smtp-Source: AGHT+IEv2HySmX9ZH4mesehdWb7wgnujM5Ajti5lbRw0Mrtv6PqNuhJysmW3Q3uyqD2pSUVf7SrbXA==
X-Received: by 2002:a05:600c:45d3:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-47730813642mr73186695e9.17.1762022138469;
        Sat, 01 Nov 2025 11:35:38 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4773c4a812csm68881265e9.6.2025.11.01.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 11:35:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: yt921x: Fix spelling mistake "stucked" -> "stuck"
Date: Sat,  1 Nov 2025 18:34:46 +0000
Message-ID: <20251101183446.32134-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/yt921x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ab762ffc4661..944988e29127 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -1131,7 +1131,7 @@ static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
 	res = yt921x_reg_wait(priv, YT921X_FDB_RESULT, YT921X_FDB_RESULT_DONE,
 			      &val);
 	if (res) {
-		dev_err(dev, "FDB probably stucked\n");
+		dev_err(dev, "FDB probably stuck\n");
 		return res;
 	}
 
-- 
2.51.0


