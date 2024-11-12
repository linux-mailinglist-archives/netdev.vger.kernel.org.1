Return-Path: <netdev+bounces-144252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E92479C6547
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829141F2376F
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6F21B449;
	Tue, 12 Nov 2024 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="UkuUvAje"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F52420ADC6
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731454675; cv=none; b=mdIFw4VDhBU0fcLvhUVQDzfhIsylCa4jWnWKPACIjobOuY+NrJkOaRz7nliIQx6OpmSozQO1BdeqCL1zeTnY1mgL6PPWhkUXqHZELAI1W8uckvJI+fa7fk1q7nbe2SWtHas6Ah4M2rYvPeyCxN+owEKg0Do1IVAtuf/c+VHFMQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731454675; c=relaxed/simple;
	bh=NS0oEJGLQMzwsxiRqjLbzLHQvzAKQUI4puz5ttzO3ks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTKT3rwcMhFQJdb1Gq1+MxcFX4AmSvVJvz14NHtj0vMaq7zzLTkJvu2TV+hrD+SPDlHqYDjdjQjQe0b4h8u8AyXgEyp4CepHHZT+V1FPzlMpUCZs7uQ7DpbRb9ymqR/qPMFJUtiN2YFVqS84VDOwjK5l5pm1DYKFtVBeC8PplaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=UkuUvAje; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20caea61132so54157735ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 15:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1731454673; x=1732059473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YqXhkb9k4iQOMcnVT7rmgsvdL5//NXM53qxV9Inaccs=;
        b=UkuUvAjedCivHk8wUefarjgCbvX6sxpQhad9uSYvae4Y7SCA6LsaaAbncBANSPycIP
         25xFVgUpBGbzAoYX1LShImqwlWtjLW6BsyYi42Ip3HBqfPueFt0hPrBtz8HPi5Rv/tnL
         PegsAl58dcohWZUF/GkVeBrsHknReeK+PdyFF860CA376W3jNEj7qfxWfY4guJSb9NWJ
         sGS7ZDbnnm0FqzEaCaUim6ExSFfM80ZWQnUprQzBBFTcyj4sCRytd9l3670iWpn3U5qr
         u5JW2f5Q4DDPLSwh8ajthDHEo7f0G8U7XlMbMN2TxiakNZhOwwc39FfMZGL5UfBuuh+T
         Qz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731454673; x=1732059473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqXhkb9k4iQOMcnVT7rmgsvdL5//NXM53qxV9Inaccs=;
        b=KrMp8mMoPV2SEp3kXPOIVKgBmHUojoyuzmvWY2h/CrwEboTOdb/1ZEPQPBtXgqm+hj
         ab3fVT06ll/35hj56HxMNm/GnJaXvW/IOQjw2DgCIDSIfEkGPasCR+Pt8JoN5NW5rmGX
         mTOD50DvyuoMecVD2MrcqO9l9Jr24URd2141tFSNKXDWv+7kM2x8Id88fqSkoyWGje9F
         djWx2qPQKw2n190oYM/nh0/mLmycuYvF7HqMMunTowruS1Mw+crR6d+vcnDHPbUAc8bs
         1LFOxcJKrBrvLFRhbrzlumq7PRa3f8rGDfNty3uNCH0cdxrE81Tf7Jx1oVogBBRhB1pD
         DWbw==
X-Forwarded-Encrypted: i=1; AJvYcCVWYgAETgibqxWcuDClzu9XfzM3SpIm/gSEEidZXC/UVVbcyWGsrNyE6kyM6zySWFIG6E0qBd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/00ELw3Pe3Skb9j+S0W+NWz7OaWoH5alavg08/E9pEDlOeoE
	194MjTpymW+eVozZ4n3bRJxpwxK42GDBA3vSZnLdy6UN7tFjpvBl3bOiWq0jxs4=
X-Google-Smtp-Source: AGHT+IGASecOiEAWmurWKnj+5DHPb4A0So/iYD/w6/x8Nel5WVXfgUdx9n98XhVQcCgEmMcc4HQFpA==
X-Received: by 2002:a17:903:1246:b0:20b:ab6a:3a18 with SMTP id d9443c01a7336-2118350d16fmr263060925ad.17.1731454673455;
        Tue, 12 Nov 2024 15:37:53 -0800 (PST)
Received: from localhost.localdomain ([91.196.220.163])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e419a4sm99549815ad.149.2024.11.12.15.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:37:52 -0800 (PST)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] xfrm: Add error handling when nla_put_u32() returns an error
Date: Tue, 12 Nov 2024 16:36:06 -0700
Message-ID: <20241112233613.6444-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error handling is missing when call to nla_put_u32() fails.
Handle the error when the call to nla_put_u32() returns an error.

The error was reported by Coverity Scan.
Report:
CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
to err here, but that stored value is overwritten before it can be used

Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 net/xfrm/xfrm_user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f0ee0c7a59dd..a784598cc7cf 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2607,9 +2607,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 	err = xfrm_if_id_put(skb, x->if_id);
 	if (err)
 		goto out_cancel;
-	if (x->pcpu_num != UINT_MAX)
+	if (x->pcpu_num != UINT_MAX) {
 		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
-
+		if (err)
+			goto out_cancel;
+	}
+
 	if (x->dir) {
 		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
 		if (err)
-- 
2.43.0


