Return-Path: <netdev+bounces-135482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A1899E110
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C831C20C87
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6C11D9A45;
	Tue, 15 Oct 2024 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gERxb1hA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF71D5AC0;
	Tue, 15 Oct 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980953; cv=none; b=nXbdA716opLzQGVTz9gSKxJvM3ecJik8ieAoD8l+flJrkrAYQFrwEmfjaGSKThjS+2bwYFABunIge6GDa+ZzgZaO/Ima814I3cTQZtd4QYc3ksXcy68jqKCYPqcBFmlOib99FRgmJttw9FRwZ+0HPh+ZEuOFrFOOUe3vV2RfjlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980953; c=relaxed/simple;
	bh=4LcEGxdt1RrkLz4bv3qr2V0k7GnVFca0cynmiSPO1r4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J09kwAnhyLPqz7QLFFIXkQyS/iRh5jSPTZpdC8+sZPsb9j2733Tc0aJNlO1MbX4vo7sQsOIs/0pzzAqqvFFNC1aI8vUaqjRiM4VxTquFfhWQAL3PvMlX3HaZKKpPOWrkE3mw/akr4LdIoXgjD9ZIjhzfv6FXY5MKdvuawSvvs9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gERxb1hA; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20c70abba48so33147455ad.0;
        Tue, 15 Oct 2024 01:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728980951; x=1729585751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hD4sXw2oQIO63uT3+cbcMmwkiQ0b3X0XBEuwM9efjPI=;
        b=gERxb1hAVAVwzBnxmbrsOv8Vyfx68OoT014y6SMsHfVn9b4R5/xcs8jspdaLlg9Qd7
         Bo9Po6WejUPOnZNg7dKbS0dxsZ+Ad/bVlIm2HZkQJBDlUlpaZVIVSQZmI7cuXplXSk0D
         7mb1B9rZXGJMH2ml6npoVKW+K/olXF/zslsOghSs2OBChI15iNx5TJrck/dqOdt5Fg52
         omBe6gmwbKpeA0HTWt5/dmgUzOZ5CT/VGH7ZqTzcwrSTJJ/+ecotU8jHHp7SSQVRQ8zy
         aHFM/zc3jycyocXfnxI1rT8uheYRDyG4kkK/5X3k7GA+kSeoX+/T+xJqSIkH0TrpdcZB
         ARKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980951; x=1729585751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hD4sXw2oQIO63uT3+cbcMmwkiQ0b3X0XBEuwM9efjPI=;
        b=Zk9YbtlnhVR2DIZP2dsTkDz87jgrCCPTXRxhI4nmk9RoxTI/dpXX1/Dy6YcDD473Va
         0Mh5uNfnKmXCDY99zCIa8x6WjdOR8Qh5ThFzZYEoTTBHmSgaRyFB1dyW/j8vmIU6mQiy
         /U5wmwIP2U6OhXQSFJSdoJ7xRHgp5d5nqDsdLtTq+RGhartLleDd66mqXHjAMjiUSJYW
         66kS5ULGqlpbfE+GwP12rhggI9oTPyZWUsKoEAigwX2UhLeOpMEPhRmEjeGsr5zFd+Rk
         FdABPKzvZd4cfs5Xid+88Oj+9TwyY5lhBKAtipu8PnB4qIRgvci2i4iAcKd2F07iT2DI
         uUzg==
X-Forwarded-Encrypted: i=1; AJvYcCW+pu1FsWUJuX6s+fpBCQs3zIxhX+2WRLfXJKMLdKGKuVjuQXNbGNuZ+OdE6noUzSzobYCSIyzE@vger.kernel.org, AJvYcCWFWACp2VDe7a/p7LvlWB/pK/hJkJF3fF0H1QMF2W7h8NQmFHLwhNyMLwH/wNmf8MHzZPvLWlipyGx+KCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6u04bGnSxhKHRKnFb3Sh8EZvgizx65AEaUMVuP4M2H4Vb0tIM
	gnxydKanxAAHqdoXZKw5dwEja3uzLbHhskemFXnzeqwlTwHQKtnF
X-Google-Smtp-Source: AGHT+IHEG/VC+yVh/uS0VtxQ/EqWvPx4wSevYNRNSEWSKulaKnwkNhFewXt7osct/EZXBUNQHaUlqA==
X-Received: by 2002:a17:902:dac9:b0:20c:a0a5:a181 with SMTP id d9443c01a7336-20cbb1a482dmr152416035ad.19.1728980951223;
        Tue, 15 Oct 2024 01:29:11 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1803669asm7177445ad.159.2024.10.15.01.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:29:10 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	dongml2@chinatelecom.cn,
	gnault@redhat.com,
	aleksander.lobakin@intel.com,
	leitao@debian.org,
	b.galvani@gmail.com,
	alce@lafranque.net,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: vxlan: replace VXLAN_INVALID_HDR with VNI_NOT_FOUND
Date: Tue, 15 Oct 2024 16:28:30 +0800
Message-Id: <20241015082830.29565-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the drop reason "SKB_DROP_REASON_VXLAN_INVALID_HDR" with
"SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND" in encap_bypass_if_local(), as the
latter is more accurate.

Fixes: 790961d88b0e ("net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index fd21a063db4e..841b59d1c1c2 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2340,7 +2340,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVALID_HDR);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND);
 
 			return -ENOENT;
 		}
-- 
2.39.5


