Return-Path: <netdev+bounces-212222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9390B1EC17
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B23718843B3
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619BD27990A;
	Fri,  8 Aug 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="0Yds9pAB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E13283C90
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666860; cv=none; b=LkyZLkjIF0mzlRC6TwJTTHggdTHK9Nw9IpgwMBpIWWy7Qwu/Je9+QKNe2MWAwydLu5+yBIogNNOI32c/mKXdEv0e1umxjE2cWnaUT9M+g4cszUwGxg5RJabI0JLjl/A0fUaWbuQqGr9W6tuCglZvnH0aC92NuvHrYd85sPrmvhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666860; c=relaxed/simple;
	bh=4t8msaBVgUkmaVN2L8z2i/VlUwqqFe1rWYYu/ZCt5uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0PkEMBG+Zg9E+nliABWXAByTkPzbBwfKH3AktQ1CkvnHirrg18YPOSUEh9krhnq8dSeAA6X1hmuSpaamdBn6NC4qrdHO7qDu1HCu/adT8VnahkHtW06IstTtiLpdDUJNeFlTXoJo5tk2Bw+PcvYh1zH5GCSBbTeqJ2XpMf1ODg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=0Yds9pAB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31f3f978cd1so460361a91.2
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1754666858; x=1755271658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd5QA0/uPh92ea5alhlb4TcCs4dDLGLbN0YRHZShzYo=;
        b=0Yds9pABqzsmyn+K6k45xiKHiWpsQP+98GKErwwaxF5HHPtWmrIaeyLWM/OBCy8kLm
         qgtTfjABvQCi+BukTMTDY8ji/8xrWQs6mS5FdwZ6fDjiOGMSwrfjXjgYj/tDnC21/Lmz
         UxchhdLVF/GDOEP9+V9YE2cnNtwTktQsihY37OTsT6RrdRDU4wwrJOSXbSiFKiC+7ThU
         vUETP3jrfZFRHO6j2rta21KvNuG2OMiF6V47lLL1xbjK7GCiSY3MWnd9gcdyzHjIDsD6
         C3QqgPn7f9gHbtic7Gl/8rt3cU0r8AGuA9WmulutcYowoRQC3kRbPNuhVVTzlBoh/362
         1gQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754666858; x=1755271658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jd5QA0/uPh92ea5alhlb4TcCs4dDLGLbN0YRHZShzYo=;
        b=NO1UBVTRCvMQB6ghNtF3qoP/QR2pVvjkpraNIOVpSeZu0+URGQlfDRk3ZdP4ten/ln
         Nc7J801+rJMQdFwfAu0SvCgTxvtuhL8CQY+VGYLb9z92FZ4XntDC5MEZu7fnbr+5Q79f
         v06nw398Vh0kSw/AxDO6hFi5Y1GuGT6QMgOLsuFo12U2mehxnIzhqtjLkTa027Yh90xe
         4T/a29SDMn8+YsOIQOpCVebuVuqHRodO/NCIxUkUNjNSp1PRlAs9nmysgXLgaxpXYeHu
         YfY9eLeRlcmQZ6G5QVdGZktleKBZKckN2gFmcbuf2PoQSx5tJX2/OsAwy5M4N3H8rnYP
         TldA==
X-Gm-Message-State: AOJu0Yy/8O37vMRvFkv4kSO4TGVkho32zi5LB6ac9LoejqEumWUHMe5J
	KPLg4j5RYk6I12rHCt5Uu7jYF7gxPqXNUgT6+RyXdNAUCOLQaQW+LErxYqM12KJX5lG8yDtbiNr
	4rGzo
X-Gm-Gg: ASbGnctGIVjLyEP/n6VsOmUd24JdNKTcwclQxpw+5Ia0DkU7Im4woDmKFzJNxaobd14
	tT2EjGZQpfYr8aI4P9clwjuCwOQhDrhNORLV7HMeVVqoS3HUTPcjFGSp1j61/VETzf5hPu5nCzM
	MnIKlGfyPyqtG+13EVhhfMPzgOcfe/LitFdERdV2SBX/HkzTULiIC3pemWVq6BP2hJBuw/r8Ncz
	bpWoOwAus0ZrRrH76iCXHjx2sBEOiyhbKmBUL5DKPNJpLKYsSw2Z6c4ErF0/gH47coRpeyJ1o9O
	cOi4lNf/u2Og+eoKRurHQjxfGAJEAfBWZy0/xfUE/qy27ybYNyuZFxeEp4ZHl28bU7eDjaXBGpu
	oVrebtwZofAmh6gFv7QWz1w==
X-Google-Smtp-Source: AGHT+IE7AisudfhrjtmZ8/XzRABhre5cpUkwJtQT/Peqr8JcvNYwui5dSUdTH83jcRJNuYrIYjUvNQ==
X-Received: by 2002:a17:902:d4c8:b0:231:c9bb:6105 with SMTP id d9443c01a7336-242c2380410mr26553315ad.0.1754666857517;
        Fri, 08 Aug 2025 08:27:37 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:a6ee:dea7:7646:6889])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab185sm213111295ad.164.2025.08.08.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:27:37 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 net-next] docs: Fix name for net.ipv4.udp_child_hash_entries
Date: Fri,  8 Aug 2025 08:27:25 -0700
Message-ID: <20250808152726.1138329-1-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_child_ehash_entries -> udp_child_hash_entries

Fixes: 9804985bf27f ("udp: Introduce optional per-netns hash table.")
Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 Documentation/networking/ip-sysctl.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index bb620f554598..9756d16e3df1 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -1420,7 +1420,7 @@ udp_hash_entries - INTEGER
 	A negative value means the networking namespace does not own its
 	hash buckets and shares the initial networking namespace's one.
 
-udp_child_ehash_entries - INTEGER
+udp_child_hash_entries - INTEGER
 	Control the number of hash buckets for UDP sockets in the child
 	networking namespace, which must be set before clone() or unshare().
 
-- 
2.43.0


