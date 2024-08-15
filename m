Return-Path: <netdev+bounces-118677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBA79526C6
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 02:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18021C21257
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442FA5F;
	Thu, 15 Aug 2024 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2aksTqO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE518D627
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723681194; cv=none; b=DpLFb6rLo1jIXtZ6x/bOzQtttVPVd2+iM5glscz/q+BV2uiFlL4BXjMorNOSfc8NQ6xGvLLbRkWphCXDYOcMckNJi3Xbb5Rizeh699j54dwD8NDBuZZdiB0Mvqw4dXBLrEC4LXgvalKNkBnc8eIGa8lTW6UAV7dQyw+HRskUxc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723681194; c=relaxed/simple;
	bh=8iRzqDoYf39rgtBU1oLcruq0trBu0TN+0kpem5OBr3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrlt4KebgkilWz0Jy/gix1MhrWjQ4Q16grThqGcmydFNJxRe4kyaoknXzdDmNxboEtxxL9SSQNdUrgSyCd0BaD/6kmQlQ+lrUTqIVAfqtrlZSMuPk8s18TPwwe42xjU4lzfMH3d945M3G8j7K2nSUt3X36YHpLKIFzZQfu3Hf/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2aksTqO; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39834949f27so1902975ab.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723681192; x=1724285992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BoaaryjN+kmznsXNg0/iu0at6ootyNT2WSzfJdTBZ4=;
        b=k2aksTqO9fCosCWFYXUor3ovoAuTwveZXI30uiYEpC4zTnSoFM94aRJGxXX9FIOzJS
         I53jOaT4E0v6iRSMac0iJ+MPh+MHLvAl00z7hmmFm7RtZ9nWCA0BkYuzFOdttX8F+bf5
         2Pwt2iMzYsjM0WzRuo6raMmKx4Ap1UPrs2lBUcRy3DBQ8SVJUfQErNzZBKPEN2AyRgRQ
         s8oM90DUmiDg4YD+G22QKbEkn8tuWg7gDwWHKeS9rhwx+fh+GqKncJlAUHsrhEuuyyj/
         rOpJNvc1ag5lNTL6Wzc2zmLK3uYbaRoNLG6R3Npa9/AdFZx65kRlbhwXQqNyPnmLwB01
         uzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723681192; x=1724285992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BoaaryjN+kmznsXNg0/iu0at6ootyNT2WSzfJdTBZ4=;
        b=GDfB2JLwrf/Jmbq3wmsqn6RAZV0HeQhXBG4NI2c3VCWEVdpWmspoG9WoIN4dpihf5b
         YfH8bryDdeNAfj5+26KkboYit5r5xRvSsrL1tBWNXHwxaGD1y/sBE+s6bpGyiWQNJqRj
         HrGb6ShbMCnF3y+XU1zLOmNUwM/TIrYaBLkhMOMgM0mDd9CkgPw62kXAOKWQ9v2Ve33w
         TkjkIB16+TXxtPIMZlFO93wFYLCv/fKnqSy1wDXXVyb/zVi4O//buZJ7WFQI7JpmwNbl
         ghZ7UDQYL3YMfxaqUtgQLMDb0iw8vRdwBRjtPBUrLkpk7LmQ02LjQkHv/OnXvkEu63On
         Vt1g==
X-Forwarded-Encrypted: i=1; AJvYcCWsTbj9yptwj4FX7MD1EKhYw2Mu3WMLUdEl8f4iDUBpmx2EBkSBnSs2unsrrlCvAsYVFVa1xIQ1cXRuMPy/ytG1lo/wYcK8
X-Gm-Message-State: AOJu0YyC8V3Oi4tBDtxm9qm9umtaIJdvNB0Eq87J3V5RAOQEgkIYWJks
	sMwfcN5gwVIsiV6rLmcD6g1+iFPtM06C8qtVtV/MSQgD2TxwtpbI
X-Google-Smtp-Source: AGHT+IFVyn+FvDgaM9qfcrvEI9LQzcnVnP0CS2w58XvbGumiN4Pv5V21D8NMT1A0wMf2Y7MY6enXFg==
X-Received: by 2002:a05:6e02:1ca6:b0:397:980d:bb1b with SMTP id e9e14a558f8ab-39d12447b1dmr54817385ab.7.1723681191760;
        Wed, 14 Aug 2024 17:19:51 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ed74e0dsm1244935ab.78.2024.08.14.17.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:19:51 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v2 3/3] tcp_cubic: fix to use emulated Reno cwnd one RTT in the future
Date: Wed, 14 Aug 2024 19:17:18 -0500
Message-Id: <20240815001718.2845791-4-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815001718.2845791-1-mrzhang97@gmail.com>
References: <20240815001718.2845791-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd at the current time (i.e., tcp_cwnd).

The patched code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd after one RTT (i.e., tcp_cwnd_next_rtt), 
because ca->cnt is used to increase snd_cwnd for the next RTT.

Thanks
Mingrui, and Lisong

Fixes: 856873e362b0 ("tcp_cubic: fix to use emulated Reno cwnd one RTT in the future")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>

---
 net/ipv4/tcp_cubic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 7bc6db82de66..a1467f99a233 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -315,8 +315,11 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 			ca->tcp_cwnd++;
 		}
 
-		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
-			delta = ca->tcp_cwnd - cwnd;
+		/* Reno cwnd one RTT in the future */
+		u32 tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
+
+		if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than Reno */
+			delta = tcp_cwnd_next_rtt - cwnd;
 			max_cnt = cwnd / delta;
 			if (ca->cnt > max_cnt)
 				ca->cnt = max_cnt;
-- 
2.34.1


