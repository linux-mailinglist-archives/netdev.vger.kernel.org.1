Return-Path: <netdev+bounces-126391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D88970FA7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 09:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630E81C21D69
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669651B14E4;
	Mon,  9 Sep 2024 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrCNGhBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1751B3735;
	Mon,  9 Sep 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725866643; cv=none; b=if0eCbDw4ki4U+lwC20pUusFPQYN7m5xc+BwDZnCDPCUcp626yITwlBg3TTWcyDSbCm12yk5dRuckMbgJmuLCIdXAfocOepkgvMpWx1Acy32Vc3QtVSEDbMinqZrnlsmG0MW3nxCZzAFIv/pIqmOtSTTI83JFceLMz0Qhaut4NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725866643; c=relaxed/simple;
	bh=jiF6CyhLka73EUOdLzXLuUlOl0s0Weqg1Sd3NCize58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hy1jp2c5qSC1sT8m3IvoXyG81hc0exHHHnwFN8RDL+EnGYOBDrpt/iK6jn/LAJC5aay8dtudfXZWbHcAyXH6VaetKLkY469ibPYAfGDq39T/XdFN9dGHCDCx/qKH49TUPtGh8fpDr1XFrBfi8R1Vq0W3g0kpl9QfN1h5vF3olrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrCNGhBs; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71798a15ce5so2392453b3a.0;
        Mon, 09 Sep 2024 00:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725866641; x=1726471441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otE1G91dyHMa4xtnfM+kI4eXxOz0ijl9lZp21TWYDmA=;
        b=jrCNGhBszKSqp2QK3i+J9glQt2PLN00ctYpJMS4+8TJF4SXVYxGUSxQzBYxQ0GITVD
         EzPlS9u9zU0JoA3mQ5/r2sYj8rYdlE+KOEVQCIi5s3GFJn/8tQCll7Z39/mQLaxF6fCr
         89vB7OVCYquv6Zu9bxEjl6xm22vxkoMG6Mu7k7fhqMFEzCu0cQNZ8G8p033sG28RzmyI
         TLk7zbDS1WE6QKoljZjNhYoxlazk0R2oC7QAai46cDIhytNZtpHjPbbtvKCvxaApUq4B
         wrG6H25PI+pdPifz9q4DYgG7J6QQSshRUcnTIQraaDs1FOczxehg201cHx80shYNPY9v
         L8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725866641; x=1726471441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otE1G91dyHMa4xtnfM+kI4eXxOz0ijl9lZp21TWYDmA=;
        b=Og4PDLcbbZ9d9ULnbaBf62CSvzFSHXInclqq21nQ/zKUmk1hno6pwxYKvmRc2SZYJf
         yaLRyiH4UJogeNfpqlZ6kT4ydwl5yaV7ZxPZ76VBD45XpqKCAOYcVVjevT5J48BwSvu1
         DIywoNxPzaMvbguQ22pUGLNhP2pjOd8oRJqSUI00y38J+2077dFwvxddqhDvsZlkUwk/
         I6trPcvCyk47p+g+kbVkKENOaWSupgqF2pFWU/MDRgjQ5NYcLQRg+6tnUHKv0jzZQot/
         mj3dx1A1+m4z57NfQRan7Ohmep1HYE9m8AyqDIA3JZaM7solCrRVqO8g+aRNw6xqTRwJ
         EbxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX4hAQA6EVH+MxT1ypG6m6J3EjJ97T4JAN0qXs3RirT1JbmBd4/mkkEw6XzH8QgYzZgXGJFFsr@vger.kernel.org, AJvYcCXMGDBVHEE+QcIzkmSZRhIkxkUr5XJzgcofkNBkMvv2Y+ZeIv6ymXVisEFKT68LacW/0rREPHHS9tOrRgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPE2fSRdODPfmESzfLMnKIwnOwSwYgoMLY/oAPNZMJ7EsOm3OM
	AdM/sNl8molAvprdfK7At4BO8VJvP6A3bg+ozVVJAaLI4OqRcJsx
X-Google-Smtp-Source: AGHT+IF9OzXb53y6BQ6KJT9aZMh959GCMp82oKXHRCNaPLq7vK+/5XzXhDFOWY9kTmLyZvP0nCpvzg==
X-Received: by 2002:a05:6a00:4f84:b0:70d:26cd:9741 with SMTP id d2e1a72fcca58-718d560aca0mr15979300b3a.12.1725866641373;
        Mon, 09 Sep 2024 00:24:01 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e58965bdsm2962094b3a.29.2024.09.09.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:24:00 -0700 (PDT)
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
Subject: [PATCH net-next v3 12/12] net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
Date: Mon,  9 Sep 2024 15:16:52 +0800
Message-Id: <20240909071652.3349294-13-dongml2@chinatelecom.cn>
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

Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, and
no new skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 96afbb262ab6..554dbb65a209 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2341,7 +2341,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVALID_HDR);
 
 			return -ENOENT;
 		}
-- 
2.39.2


