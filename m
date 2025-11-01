Return-Path: <netdev+bounces-234841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C554C27F3A
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D11C4E925E
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD012F5A16;
	Sat,  1 Nov 2025 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXkxOZQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8051E520E
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762003611; cv=none; b=SuPBVZ6LQBoSH90sjtvsT8mnSdXiw4jIEADRbtDGizX9URr+CJ4ntqHWF8QO8Yb/fyd4blsSuWVwXCi/eYMj8g6Tw9EUmPpXHfPm5vtrjzHJ8pTdSwCg+8qrEPeZOv1GJzuVe5aIqHL9S+Vf4zVoanL7ZYNieuEruEyMg9G3N0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762003611; c=relaxed/simple;
	bh=Mgp89QAtrTjRgM6jWQFTc0jn1YY1UmGe8KsPam+6Ssk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cWFHDF1ZeHGH5T/gU+kymlz6mu7VCS0b64X+UP2eIAb9XfustQtJKNIdX2IVKySs+bkOoHEcpKGwD5DA4aFVw0upWUidFtI3iMmB7wJwduXgXW8+1XqFbgmFgxYKE+0yKiqNovI3/araP9e2PLaZbfH7EQyfdxDf+IQwcuuA/aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXkxOZQL; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429c7869704so538073f8f.2
        for <netdev@vger.kernel.org>; Sat, 01 Nov 2025 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762003607; x=1762608407; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eg53ujn5W1DedX1Vyep0yhtifcPEiIbNUDg4dfuJiow=;
        b=mXkxOZQLOo/7v+JkoergXHoljqy4zc1MzpCWRuTLPEdmhjfiTLmQPKSUbxOZA+LCI3
         Lijpx/r4nzNmIBuLh6ZtW17pykbV9+EZ1rR2r5X/OGbpiq0tYgpdTUNb9+p3tyaHmDQj
         zeZ3RyvnM+2ek/MHXY6aQVkwPXdlGB12Lbv+BjJyAkeHWU/NqicXcn/vpYHSSKSDS15N
         DWYG571c8l2HiMiXlzFU0P5FmtO6lFhn3EcRLOI0XJZJaYk83w/vljsx9Mnb/qhkCq30
         dwVDf+gxSikJiNxKpSwAu3pGRtnuK4HCWv8Af6oCjBVpJEYdA5rfh1H+1Zw/MbiuNs5O
         sY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762003607; x=1762608407;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg53ujn5W1DedX1Vyep0yhtifcPEiIbNUDg4dfuJiow=;
        b=E64y32ihel8U8CesLadQvU4HJywpuXSijuDMHRffbw2awry8QL97BC8wr5Pg499F1K
         mP/krrl0+32Bmy4oIrLOgn/eYXbv2T8mvRmkTEfLChkDJFRG8yYJyBjyO7RF3xRzUVWI
         qr/aejHLhoZy1YZat2iK/eW9ess5DopZ5l4jQzpOmywR79MP7AxcU5nUZUHduCq4CHz6
         mDYuVuNHPfXWiAdwq6grqlIcgUY3KcApYxdbTtrSmSznA+3RRzY7NsxLfRSSxsa73op3
         cyS5uEDnOjV7Frv36+fsE5tZX/20w0lRiJiLI2c2dlFHEPo8XUdzCD9h31MOHsCLWwLV
         Rbig==
X-Forwarded-Encrypted: i=1; AJvYcCUILTHBx31wQiPkz0FDGp0mqf8KfKDnq5kbh8tQpO0v6hTWo/JsyLZH5tu/2lwHIkw1tvsl15k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr28iIrBRvcPOyycPNG+BdRwpqQNbCpAgqdjevNiZvFPr2Rp1P
	8ZIWhKLAZrQl0m7lNK2G7I+L3xBn2kbG+IGFfu0V/dlWSY6CXoTVxUFtI6eSuLvRtS0=
X-Gm-Gg: ASbGncvgOI1yJbJhLOoGph8ng2IlRoHvSf8Iqoxc01I8oQmfrQDc9Bz3T0QAVOKNqqA
	1rqXSFc54WCpgaJWcZXzzz7bKE1hA6W9+DzId8Y9SYJSeuEJQkyViOumGnkjQquErlg1kX5n2Sq
	9yZ/HsEtvzVEaDWaPNKqMIOx7ad2qpoqe3jx8qKulpvqbsdIkwuVFCcDRHX5deVmmGSgIl/516R
	pvd9S4TAsdzjedLwVPPLgdrABVryQ9x4DhoICAWKJfAYHWdxDe/lS0u3cqkBKP6EOuUHD8Oi+gc
	eRXHBwpk6SDw3BBewIoBptminj8jWmLA/Nlgzim5cq5UXQzcACDzSLuZrURhWEpJunUUvAZqqnD
	xZM8It7f5WAvPHo6wFMezbOHSEippnry43dfMSUvhYOj20/TQry+ppIesggbgk1d8QvYroOptVd
	yzxLVlPiyobIuhrUtw
X-Google-Smtp-Source: AGHT+IHWklOzm9hRp2MshFHHpjAPX4YwiYbf/S/L+tv28vs/jH3gOqeBv6O9b8sMd6VBVbyb1K/+5A==
X-Received: by 2002:a5d:5888:0:b0:425:7c2f:8f98 with SMTP id ffacd0b85a97d-429bd675fc0mr5343738f8f.1.1762003606366;
        Sat, 01 Nov 2025 06:26:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c54498dfsm5711594f8f.34.2025.11.01.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:26:45 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:26:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] octeontx2-pf: Fix devm_kcalloc() error checking
Message-ID: <aQYKkrGA12REb2sj@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The devm_kcalloc() function never return error pointers, it returns NULL
on failure.  Also delete the netdev_err() printk.  These allocation
functions already have debug output built-in some the extra error message
is not required.

Fixes: efabce290151 ("octeontx2-pf: AF_XDP zero copy receive support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 3378be87a473..75ebb17419c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1530,10 +1530,8 @@ int otx2_pool_aq_init(struct otx2_nic *pfvf, u16 pool_id,
 		pool->xdp_cnt = numptrs;
 		pool->xdp = devm_kcalloc(pfvf->dev,
 					 numptrs, sizeof(struct xdp_buff *), GFP_KERNEL);
-		if (IS_ERR(pool->xdp)) {
-			netdev_err(pfvf->netdev, "Creation of xsk pool failed\n");
-			return PTR_ERR(pool->xdp);
-		}
+		if (!pool->xdp)
+			return -ENOMEM;
 	}
 
 	return 0;
-- 
2.51.0


