Return-Path: <netdev+bounces-155703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4742AA035CA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 04:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385411631CF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD738389;
	Tue,  7 Jan 2025 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij7Lt1bI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661CA4C97;
	Tue,  7 Jan 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736219918; cv=none; b=RMQmfpm2QoCBYx/MNhUcseIyo+1X0kfGYdek+Dfp6Vfoehl7nD7GvXSGkh/Dt9JN7EQCie1cRSD/8aGvrnU3HkNkCUYSBl2DkFz5Vpo2zcyVF4UZ/7ySLzIkOJanNFrS2vRsOYIgjUfFfFAAWBNoD+d3uHAknG8ImNxRwIzl3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736219918; c=relaxed/simple;
	bh=L1NbAibBqLOPigWTdi6PRLUZ9a2lcFb8oamTCrWakD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dql1LzgrHayA8ZwxyEZIP/dFrGbudou96cCj7TRt9D7/K8xoJd2H+MKYrj/+L/LZvD+hV1sg2fo4wpQ7qdFKOvrgwO3lxaTZltkHJefqmWXVuecvJFuKohP097zkqgnS9IfupU2TPO3uElGCG36iFq1ySkho3kKdJuU8N3J+zgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij7Lt1bI; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso21957517a91.0;
        Mon, 06 Jan 2025 19:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736219915; x=1736824715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lEezSRqb9kXWLV1zySolvUruwCOXdD+Pe/1KXwx9J4c=;
        b=ij7Lt1bIbEfCXSAhA9zEQInmCzavFxv3fkwtRXjQU/cKgIEQlZqCqPVRxSjZmxlHLY
         ujeIl61wD/avjovA9LQblT5ucy5FTkoS/fnrfqmlpUc0rfzbJlvUXnXy1GFt5etMX4Tq
         rbPEAt9oZmYDLObejyYbQwHlWWPYpAtvssvtBU4AGyr4j8kB5+QaVm3SGrjwwbJPdemk
         kMGhbhJkg1mK9hxIob2CDmw0bCcrRlxgF6B8mtRy2gRD+c4KUYCU/7fQ5XJZlkyW2sz5
         fqoGbS1IQZzmip/cw+P3mYInqHys2q9JQNMR6vp8HxFnMDUiLI2d0HFvbyvjceKQAB8E
         Db0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736219915; x=1736824715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lEezSRqb9kXWLV1zySolvUruwCOXdD+Pe/1KXwx9J4c=;
        b=b1DENbSEo2nM7eAA/lC44ZO/DeTH3Pt94s5dpaLTPEt6y5RwY6He3tcCTufjOfeOul
         pjPeAnOaz1Ei9cO+zrbDva9O6Qoc4u9wa5LI76iwqJONg8fAIC5EECZeBjEng/7bbvIe
         H0RaEr0fta242mEvYBTtW3F4TmBJ9Ey2Qnsgm6CLSuogX5bxrAVkVgbwBymKTOxZd0oq
         YYE+SyWNXTO9dlR7I4IcvCsLyuRBIs+NnQlQKlyLDew4WcKDMEAuaSNn/4Wp5vXVZ9a7
         k3CUoXQ1Mh9Y7qhso3/iXc60mGvt/PlFWj/+0rMcd67FxnqQ3Q5YXzNvNdUnAgJH7wSl
         MZuA==
X-Forwarded-Encrypted: i=1; AJvYcCVZrn/byfMNDlTdIuRZEUKjZW6/kttD1V1GrLrexrpLeQH+Yqwc66FVI+YlsNzUGNMytyPezTrR@vger.kernel.org, AJvYcCXud07bzBJMSS/dDyfZYDFA7KAQAcaEu1A/zG9mQTNu06NWtD6XzyGBkDEAeM2OPvPaSq7hwBXwoWKRoR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4DBKO3KSCg/ByBMLHU64MKSaDG0cY8LW2YXrVxfAtpt012iol
	kB8hhGo/GcSstUreZ+y6p/LvMTth++ghjmYNnsZcnSTzYG2Se11G
X-Gm-Gg: ASbGncs4GKRdfbLmtdjFa6m0TA174jPkgzS1nr8ljGImWAegUHuEEXwXATBohAUllfW
	vNKk6X0aIkQga+edlSqH0myiFtbBwsYrp947sVZpZoTgFbgQhlkCrNmKW9bdtrvr5ZSzRBAKpUg
	FiTI8P6mCP2EOvcepbptoourNBv1XtQsyC+TolcZ+3YxMtpDqRv83Up4Dke3v1GpbiVR7FfzoTF
	IobwXCV6vXmGUzLhkEeED3Wd7nc1HoLQ0DsrynKFeT/wpK1fzp5kWaMjAfl+UUw+3S5FkmZlNmZ
	y5CfgPNlKC8eTJwbS900rIq4k0yNlo4bn6Zq
X-Google-Smtp-Source: AGHT+IH8eAF+9AO0Qm/VLGzwhFXMh0kUgrEJ+9p12xqbC1bcnXyBh/t5i5HBLyfReLb7TkgYOcpULQ==
X-Received: by 2002:a17:90a:d64d:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2f452ee62d3mr93325685a91.24.1736219914616;
        Mon, 06 Jan 2025 19:18:34 -0800 (PST)
Received: from leo-pc.tail3f5402.ts.net (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a267dc09bsm170430255ad.169.2025.01.06.19.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 19:18:34 -0800 (PST)
From: Leo Yang <leo.yang.sy0@gmail.com>
X-Google-Original-From: Leo Yang <Leo-Yang@quantatw.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yang <Leo-Yang@quantatw.com>
Subject: [PATCH net v2] mctp i3c: fix MCTP I3C driver multi-thread issue
Date: Tue,  7 Jan 2025 11:15:30 +0800
Message-Id: <20250107031529.3296094-1-Leo-Yang@quantatw.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We found a timeout problem with the pldm command on our system.  The
reason is that the MCTP-I3C driver has a race condition when receiving
multiple-packet messages in multi-thread, resulting in a wrong packet
order problem.

We identified this problem by adding a debug message to the
mctp_i3c_read function.

According to the MCTP spec, a multiple-packet message must be composed
in sequence, and if there is a wrong sequence, the whole message will be
discarded and wait for the next SOM.
For example, SOM → Pkt Seq #2 → Pkt Seq #1 → Pkt Seq #3 → EOM.

Therefore, we try to solve this problem by adding a mutex to the
mctp_i3c_read function.  Before the modification, when a command
requesting a multiple-packet message response is sent consecutively, an
error usually occurs within 100 loops.  After the mutex, it can go
through 40000 loops without any error, and it seems to run well.

But I'm a little worried about the performance of mutex in high load
situation (as spec seems to allow different endpoints to respond at the
same time), do you think this is a feasible solution?

Fixes: c8755b29b58e ("mctp i3c: MCTP I3C driver")
Signed-off-by: Leo Yang <Leo-Yang@quantatw.com>

---
Change in v2:
    1. Add Fixes tag.
	2. Add mutex comment.
    - Link to v1: https://lore.kernel.org/netdev/20241226025319.1724209-1-Leo-Yang@quantatw.com/
---

 drivers/net/mctp/mctp-i3c.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 9adad59b8676..d247fe483c58 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -125,6 +125,8 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 
 	xfer.data.in = skb_put(skb, mi->mrl);
 
+	/* Make sure netif_rx() is read in the same order as i3c. */
+	mutex_lock(&mi->lock);
 	rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
 	if (rc < 0)
 		goto err;
@@ -166,8 +168,10 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 		stats->rx_dropped++;
 	}
 
+	mutex_unlock(&mi->lock);
 	return 0;
 err:
+	mutex_unlock(&mi->lock);
 	kfree_skb(skb);
 	return rc;
 }
-- 
2.39.2


