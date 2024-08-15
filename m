Return-Path: <netdev+bounces-118832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FA7952E7B
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 14:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DAE61F237FC
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEB1A00FE;
	Thu, 15 Aug 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AURHnKM3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B7917C985;
	Thu, 15 Aug 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725968; cv=none; b=Iww8BRmL6D1FI54Gnxa1JKZWx0u8C8VseSCbtUDWk7glKbMoKXDBsn+5qePlbjgcznawpLBu7E07oB6e+tulzhRgs/nA414WdDaF+E7oDiHxEk7elDCJ9eJvGLw/58Gz8ncRibSj/3TFqMi+1NX4ad8+ymuakFHGoS6cDhn1xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725968; c=relaxed/simple;
	bh=G5lLnDhHXrlF2AtjMeSYBuRCfEWiWxms1p+t2sCISTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g7+dlzvgH9/gZiD968s8yfJNc+ZOFqx+HQPNBvQAyrj6bFhwBo3CIqwEWbjtL5epQvo7k+s18NOiD49/TRPK1IF5gu3yUpme9G9ZMBhynmmPRltJOjBCQHwhBhb/N20DrSkzc0cNyrDcLzlErmJ5zps4L2Ts9QQ3uFnMaYFkbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AURHnKM3; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-70d162eef54so626378b3a.3;
        Thu, 15 Aug 2024 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723725967; x=1724330767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+/egqQWy/gMXXtQbdbR1ZUBy1BH/MhQG+mERgblVW8=;
        b=AURHnKM3kwZfBkl4dd59ApZTrhFibWi05xVUgSJo1KZCyIW3lex8LjC63LMD8yFYBJ
         NacY3Xf7ujOWTGD5PMaSfPIDYcPvYMilb//b6SIo51ORBatf9bU860ozhsHP6kM3/2uE
         gB6GPpqotRACjnqIm5oQZ7zT+fv/l/hESP9HuxXvLPi2E2oy07Ab7MTWIuMBWkH1u+pD
         K9XH4HwR/0q+59Zut9ADkRHs3FHXnwtL7tXD0STJL1jIGOOUtLDJM6Vm2RZLC2sFVyZm
         YaYUpvgKnctQ5+XbCPncClGasrFI4FbgBKeCl1Mx1dKsL4IPr9gBl4Lk4zjgunIlS4B3
         D+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725967; x=1724330767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+/egqQWy/gMXXtQbdbR1ZUBy1BH/MhQG+mERgblVW8=;
        b=XbwlY1i2NZluMA3Pzzw6rpbrQnWYwdcqPCZ7strAMEDRnqvGbiP63uLByYSzS4Ju3C
         UqV7uVX3gUuRA6kdnQ+t286kQV2aJ9ymg9QbB13DANHJWmYybT0DeKI/5VQ+tBW4lr7D
         AG6MBPP/r/YUWynOTbgwsprQYlwjJNXWyJS9s2J9xzyxJTtWeZ8iaW6Slr8djS35L900
         L2JQz5qf0rmhSsFPSqDFpUMu7XYtr7nO/PeXc9DQzK9VKDmvafP/Xgc7iS9OTwxFY52M
         6gNBML14jyU7+H5s7bI15UfZu6sCzNLFBzaC0/joTHgXlx7YEQrxUnKSqr0A03IY/7Xk
         l9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSmerQehzYLp5CmXRKNyFKzYyx6as2WAG4dDcG6hXT1dmRYvePeiMZ1Ir1mBqK4prHQWIyQcKznNihro1BiwZN0YPDGHBhw3xqcGEkFirgkVZrEseSGB8uDlV1EE0m9VaNRea/
X-Gm-Message-State: AOJu0Yyrq9/xlhLSV1mkvtJYWXw395ZQF90mGg2nnDn1nZ3B11+0aJeU
	5Ot7WK6a4bMJ9An9cM0z1NspQMk0UiSpO8PbRBN+ahweNKAxVmKt
X-Google-Smtp-Source: AGHT+IGJt70CGCmpTmOw+rSlXu92NewnfERqsmdxcVSMFyYYfy4MRPyOFgAObIqIPTcp69+4BfaWVw==
X-Received: by 2002:a05:6a00:2e90:b0:710:d745:6f3c with SMTP id d2e1a72fcca58-7126710ca85mr6890048b3a.8.1723725966563;
        Thu, 15 Aug 2024 05:46:06 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af2b942sm923605b3a.183.2024.08.15.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:46:06 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 05/10] net: vxlan: make vxlan_remcsum() return skb drop reasons
Date: Thu, 15 Aug 2024 20:42:57 +0800
Message-Id: <20240815124302.982711-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240815124302.982711-1-dongml2@chinatelecom.cn>
References: <20240815124302.982711-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make vxlan_remcsum() support skb drop reasons by changing the return
value type of it from bool to enum skb_drop_reason.

The only drop reason in vxlan_remcsum() comes from pskb_may_pull_reason(),
so we just return it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5785902e20ce..e971c4785962 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1552,9 +1552,11 @@ static void vxlan_sock_release(struct vxlan_dev *vxlan)
 #endif
 }
 
-static bool vxlan_remcsum(struct vxlanhdr *unparsed,
-			  struct sk_buff *skb, u32 vxflags)
+static enum skb_drop_reason vxlan_remcsum(struct vxlanhdr *unparsed,
+					  struct sk_buff *skb,
+					  u32 vxflags)
 {
+	enum skb_drop_reason reason;
 	size_t start, offset;
 
 	if (!(unparsed->vx_flags & VXLAN_HF_RCO) || skb->remcsum_offload)
@@ -1563,15 +1565,16 @@ static bool vxlan_remcsum(struct vxlanhdr *unparsed,
 	start = vxlan_rco_start(unparsed->vx_vni);
 	offset = start + vxlan_rco_offset(unparsed->vx_vni);
 
-	if (!pskb_may_pull(skb, offset + sizeof(u16)))
-		return false;
+	reason = pskb_may_pull_reason(skb, offset + sizeof(u16));
+	if (reason != SKB_NOT_DROPPED_YET)
+		return reason;
 
 	skb_remcsum_process(skb, (void *)(vxlan_hdr(skb) + 1), start, offset,
 			    !!(vxflags & VXLAN_F_REMCSUM_NOPARTIAL));
 out:
 	unparsed->vx_flags &= ~VXLAN_HF_RCO;
 	unparsed->vx_vni &= VXLAN_VNI_MASK;
-	return true;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static void vxlan_parse_gbp_hdr(struct vxlanhdr *unparsed,
-- 
2.39.2


