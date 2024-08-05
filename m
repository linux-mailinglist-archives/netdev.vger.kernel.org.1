Return-Path: <netdev+bounces-115687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0CD947891
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A246B250D6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240C152196;
	Mon,  5 Aug 2024 09:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4472914A609;
	Mon,  5 Aug 2024 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850822; cv=none; b=IKwqn+3HjFqMDerVA62FAzstV5QJbY5tLUCqtwfiRjtGn1RFqxUnfcT9X0j4O6HP2iwg7y3qFd4b5II8PXnRr2eBPEodm4w3bumhNtkqBMBeWv5rzTfMA58bnd4LBsYgOryAJkvqRhoWoC+2AoxypRVqH/e3GvDoeOtreCtAklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850822; c=relaxed/simple;
	bh=hzNNHdL3lLQC+abWJW3QcqzEdC+eSQfbpqxItlkHD/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5SAreCbvDT4XFmzIOqWB9swgazN2sRQhMePiCvYK19hZVDfShqZivTIoZ/eTNR0sPTWO6m94W/fqzvad1Xig31gQjCKHOk3tiuPH9Qp6GFkeLakaRaelPvKHwaoS0Xg3JbS9L1FDr5TFh5zzUkbRTnDIo6VY0pSNQsrA4tT00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bb8e62570fso846849a12.1;
        Mon, 05 Aug 2024 02:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722850820; x=1723455620;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WJ9j3KL2kMnE5EsefcskSGF25QM021WNq1anmIc+og=;
        b=NuaIUb5Fl+/GmwFwAtAlPWVEV4kOclwtWJBkNa3A0AmHLRAqVk8+97HaSdPzulgH81
         37S1x1hAmLaQm0qK4z1zhUa6Kbgi3l8HEabaHhUbEjXc+J8QRH/jwWa1VypzIB1b5bKt
         8mqVibUnDzri5WK+h2QuDGjLy7bJRTDE8/9IwFsZMRfPph+VpRF2ml+lPlNzC//WzX8V
         NPStvo1/6VcKuC9lprpqFrc7GoGJu4qXJIGXYL+eSedXnu7xuV3eCItN7BpfrsBhQPNA
         BFSfYB+1I7qOYQziasobxxsedT5NVsIKGLyA5Wz/dahy0ZGDsj04/frMyaM0AT44Y7ac
         H3+A==
X-Forwarded-Encrypted: i=1; AJvYcCUsp+YD+2igbeqBFMsAp0esEqFuYgbI78mXqR+TJGIKuY6S3lDMup5n0ouWDqgLwEQSKHcG/25tRn80nR2BvZV4Nsit8AwhnFAOUTT/0DwVNFs4Iz2JWK2d2fRRxeE6t0Frv7as
X-Gm-Message-State: AOJu0YyXR71FnzaLrkhtC3/hu3WZX5CSbeOgJb22GoVzwIXMeKT4iMIF
	em8vrAhIr9fL2Q8ISBBaoAF+irBVmeOyCH9U4c45lBiRZp31wp7O
X-Google-Smtp-Source: AGHT+IFkCcSbmHH8IpgaG07PvlDbTXYvxEAf2cdUnbSji/iET2HGgRDyxtAFziKZ3T4/jm19KUsACQ==
X-Received: by 2002:a50:bac6:0:b0:5b9:3846:8bb3 with SMTP id 4fb4d7f45d1cf-5b93846940emr5179356a12.12.1722850819256;
        Mon, 05 Aug 2024 02:40:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5baff14989fsm2067084a12.55.2024.08.05.02.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:40:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: veth: Disable netpoll support
Date: Mon,  5 Aug 2024 02:40:11 -0700
Message-ID: <20240805094012.1843247-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of netpoll in veth devices leads to
suboptimal behavior, as it triggers warnings due to the invocation of
__netif_rx() within a softirq context. This is not compliant with
expected practices, as __netif_rx() has the following statement:

	lockdep_assert_once(hardirq_count() | softirq_count());

Given that veth devices typically do not benefit from the
functionalities provided by netpoll, Disable netpoll for veth
interfaces.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/veth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 426e68a95067..34499b91a8bd 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1696,6 +1696,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_PHONY_HEADROOM;
+	dev->priv_flags |= IFF_DISABLE_NETPOLL;
 
 	dev->netdev_ops = &veth_netdev_ops;
 	dev->xdp_metadata_ops = &veth_xdp_metadata_ops;
-- 
2.43.0


