Return-Path: <netdev+bounces-105477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD091158D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 00:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9B0B20DAD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1E715218A;
	Thu, 20 Jun 2024 22:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="FXV5Q4jd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19F1514D0
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718921965; cv=none; b=ZUQKDxQdoQSyp8DsSWGUbjeDmtNFxVTCzHGEHtWDWNzYi6tTvSr2a1JdR7aelDOCs7L85PTEUSVKZwhZGKxpRzotQ2lFxIVgAJWi2k1ArSGnfcS7P4yb2h8H5qwsFuIu3Z5e6Lf1flYMKKJo6cF1M6D+rXp4eci8QCwBwoezZUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718921965; c=relaxed/simple;
	bh=67A6Ac6YQftcvhwDMNA4TWQLwqsK0VkfsMZwmQEXDgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBi6sl0iLSijF0K22snEaiQqeFe70hFaICXeQ3fMkIL6OwIyPsAmQfaPm7BepjIL9R7FS6yeIqMOOs4asTAHtiUpDvdEcWA7FHBSdLSsaNwDsCphkIuh0Sjb6OdO4ZOLy2O4TBwzBpaJ8B8ly+NFK+B9fEJ26YX3KEi6bqDzlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=FXV5Q4jd; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7955841fddaso125022685a.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1718921962; x=1719526762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OK8tYlg8joxvSAleL9jkPigjYKgVARJbZCH4f6lw/EE=;
        b=FXV5Q4jdOkNB1z6uft14vTWz7CyW1eFRmOqMlxd6/tKVLcic5MM92UAvJae65oLwuz
         3ljaedH018WXEzXjdXGH6QRGJ8Lm/GbvUPcaigyEXxxqpO3LVG3/6otkntzpp+vhlbbR
         j11sH4KX9maxjyf7DZQJZnQsvlXu3va6YZMRVU5FRu2wLFEM68FWe4L2rn3pSx6X4+rn
         kafmT5pMRV/IxdwuClcd14EFnj09FUU0Ca6UQdg/ouhTRPL0PgXJmC5wkY6m3Zh8QlVB
         Gf3f4+uckR6eCYQlvJbx5UMUVoUxi04exgWpfqwADDepHSUCnqBcutmGwhNuP1t7T2XL
         vm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718921962; x=1719526762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK8tYlg8joxvSAleL9jkPigjYKgVARJbZCH4f6lw/EE=;
        b=L9jMTsOOm2Mwdm8wIsldGT7Qrbbs5AVLUvOxWxSpw5+igAijhWr651pAUFXiYq53OM
         0PaMDgAw7i31JtF8WVAVideFdZUZtvraDK8DudU28JmvwL2zXADW9tOsZgC6VQOlZNSG
         DynOqYax6ED3LBK8x0oxOOarujmn5oIdwomZ4LgMBTSn9XS6UgaBWb3RXttPw84uEzYF
         qXTCFyaNb2ANmjgpS2ViPbjQONxZpIsRJYg051SKa/8yMaDDiLPDW/CmNf/i2bsqd5AL
         jKepxs1SHWf7jHkZGMDdVa9oG/77P//szmwvACdSkf5Rt/XiNWcevIQN049ksGs8JQ5+
         JJ0A==
X-Gm-Message-State: AOJu0Ywd/tuHrjfKra8yByMUZbn/1S1VjIVAFy3qcElFFc2VIgYmeui1
	z3905uuD5VTicc/CjkGWpIy1/2O3h9gnRvZvWgx5rXtPVgOAyh7xPPpYwzw3FRrJuTfsNVC5pAl
	qjPo=
X-Google-Smtp-Source: AGHT+IFQ0EzdKYHmQwg+zZ/JUI4tnTmadz5hANlPNEhcpyyd7GKGUXhNuPpeaqnT9c/ZhEIbyMJApQ==
X-Received: by 2002:a05:620a:2942:b0:795:890c:3f57 with SMTP id af79cd13be357-79bb365483amr1078233385a.37.1718921962113;
        Thu, 20 Jun 2024 15:19:22 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:19cd::292:40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91dc4esm17234085a.90.2024.06.20.15.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 15:19:21 -0700 (PDT)
Date: Thu, 20 Jun 2024 15:19:19 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: [RFC net-next 4/9] bnxt: apply XDP offloading fixup when building skb
Message-ID: <f804c22ca168ec3aedb0ee754bfbee71764eb894.1718919473.git.yan@cloudflare.com>
References: <cover.1718919473.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718919473.git.yan@cloudflare.com>

Add a common point to transfer offloading info from XDP context to skb.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7dc00c0d8992..0036c4752f0d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2252,6 +2252,10 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			}
 		}
 	}
+
+	if (xdp_active)
+		xdp_buff_fixup_skb_offloading(&xdp, skb);
+
 	bnxt_deliver_skb(bp, bnapi, skb);
 	rc = 1;
 
-- 
2.30.2



