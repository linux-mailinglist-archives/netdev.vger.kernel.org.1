Return-Path: <netdev+bounces-126325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD46970B92
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B21C1C21979
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4831A716;
	Mon,  9 Sep 2024 01:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPJKxqVp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4817BAF;
	Mon,  9 Sep 2024 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847002; cv=none; b=jTaSOn1Hg30vYeVY+8WwUX0BwoH+LPcg+iBd5EezTmLbcBnoouGz5j+HyD+FLOtX4Y7pJwq/2hACBclPHCJkppqs58Ss8sRAAtmPRpFM2eU3C0DeW0ZULjGWOMLGQawA6RvOJ31On5XF4LG3Rlf7wGx/Q9mvqeEWeRfItXd6WqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847002; c=relaxed/simple;
	bh=uxJr8HI575cU2I9eRQ0A18f0JZR5HN+ogm4wbuf+hzo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gi7nTPmScNgDXDy7g0ZHycyPBSdAdFMKAGWqYLhWyYYfw1//MLb8yvLtcZIkEwJvPmzLCdUCI6p05/04TY1unz07RvFL9weiEojEgYAgSVH3LZYW7LXzLdg20tbPgM3R4Ne/cFsvGlKGSqiEJxHoMYJrKJL1NWNC1BBRtcLYxVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPJKxqVp; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2781cb281abso2418763fac.1;
        Sun, 08 Sep 2024 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725846999; x=1726451799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyyARlWipjDoS0SXZOFTgBRApilxAcItlWIAe+irTHY=;
        b=cPJKxqVptBcHzeRpBiDZinvN8295d0xWN0Mxo8d0XRdZNInwLDpba3mJnY0sYaLdbi
         esa9hbO1PjLDHgBFagEiNsAARRDtF5xcwCvyuPw0ksghKEDfnqKdEiUU5NjiDy9awLQe
         ayflvc/Nl2FAeKcrMEAGLwSs/sv6hSxEjPCCpg+YVXAUkSAAxeNk2g25q98oxoZTDzWJ
         LE+1Dlz32Dnp0sLsscT9LzvlTkP+m15j4hQleGzzi5h4hKv2Xdqx4PpLE6393rWAIP4O
         t6kujlbKTqCF24ojJ/trhsaSD7zpZWpHd0cz/P+32DAWsCoZQZFKwRzX+8K/IF4rXi65
         08BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725846999; x=1726451799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyyARlWipjDoS0SXZOFTgBRApilxAcItlWIAe+irTHY=;
        b=YpAfWjPsWYx02VGElAS0JpAWhurXKsArNfoK9T/DM06l1WDcgdeiv9qzpUok47PVC7
         MWw5qA9Alj0kPCWSF3ZltzKPZiVdQnFvwKkL4BedX+TOMNhB7Cxs3eookY6MhKRCBYYy
         I98Qh7/VrjYl/Not9iQlBwgsgm7zF1MUcxdOBGxx1dDMHn2bvARlcmNVnizeWs128DeS
         Z5xtdeonBJ64h5VPB5P9KLArECXLFTFhhRCftpUu8wcyTf/DBvb6NhMhCLAerkTn4ego
         FLxNmDVaNvKFE/dHE3dfIjs4zPySOygJZP5lKNUnE14UVDQ0OMbTIc+tI1f6PhGzNUEj
         Rlvg==
X-Forwarded-Encrypted: i=1; AJvYcCU4Ls3eVbh+TDL4Db+wwaUJAm5kU6148PqmBXTw9wqLDqnlWiUxXEZJOCWu9kMqhea5uAIKNaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cXnxTSF1gSbBV9bSo3p0JiA8DI1hysxmmwChOfcpQBwH0pP7
	YITdVCBKvKrpcOFV99JsdtfENNLKwuMxE904z3bTcpl1dvDLePdydgReSRgvk6w=
X-Google-Smtp-Source: AGHT+IHIcMfR6tKoVLZBNHKv5FNTdutQDAsjuGdjLHy/AfrRBRx6UpYJw5MYPopSaUWwp5GeoCS4kw==
X-Received: by 2002:a05:6870:b4a2:b0:277:f9d5:e85 with SMTP id 586e51a60fabf-27b9d8dcd2emr7760897fac.22.1725846999599;
        Sun, 08 Sep 2024 18:56:39 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982f09sm2645616b3a.149.2024.09.08.18.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 18:56:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v6 2/2] net-timestamp: add selftests for SOF_TIMESTAMPING_OPT_RX_FILTER
Date: Mon,  9 Sep 2024 09:56:12 +0800
Message-Id: <20240909015612.3856-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240909015612.3856-1-kerneljasonxing@gmail.com>
References: <20240909015612.3856-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Test a few possible cases where we use SOF_TIMESTAMPING_OPT_RX_FILTER
with software or hardware report/generation flag.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
1. add a new combination test when both flags are set at once
---
 tools/testing/selftests/net/rxtimestamp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/rxtimestamp.c b/tools/testing/selftests/net/rxtimestamp.c
index 9eb42570294d..16ac4df55fdb 100644
--- a/tools/testing/selftests/net/rxtimestamp.c
+++ b/tools/testing/selftests/net/rxtimestamp.c
@@ -57,6 +57,8 @@ static struct sof_flag sof_flags[] = {
 	SOF_FLAG(SOF_TIMESTAMPING_SOFTWARE),
 	SOF_FLAG(SOF_TIMESTAMPING_RX_SOFTWARE),
 	SOF_FLAG(SOF_TIMESTAMPING_RX_HARDWARE),
+	SOF_FLAG(SOF_TIMESTAMPING_OPT_RX_FILTER),
+	SOF_FLAG(SOF_TIMESTAMPING_RAW_HARDWARE),
 };
 
 static struct socket_type socket_types[] = {
@@ -97,6 +99,22 @@ static struct test_case test_cases[] = {
 			| SOF_TIMESTAMPING_RX_HARDWARE },
 		{}
 	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_RAW_HARDWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{}
+	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{}
+	},
+	{
+		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
+			| SOF_TIMESTAMPING_RX_SOFTWARE
+			| SOF_TIMESTAMPING_OPT_RX_FILTER },
+		{ .swtstamp = true }
+	},
 	{
 		{ .so_timestamping = SOF_TIMESTAMPING_SOFTWARE
 			| SOF_TIMESTAMPING_RX_SOFTWARE },
-- 
2.37.3


