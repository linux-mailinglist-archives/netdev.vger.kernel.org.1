Return-Path: <netdev+bounces-65406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29783A61E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5270FB2D253
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D234182CA;
	Wed, 24 Jan 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBa7QcOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C1182A3
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090308; cv=none; b=B5eFbfAQgyHvnbOmshtKLHyHFCfsZxJlBdt/C0e7fYIwguMIlzzKsUt5E7xfBIfaU6nl4CqcYlmiYIZjVEmU+YyKmh85TCA4y/e8BgBsZGU3nv9eUDdedHFghWxzxINKO+PoekgGmRvNjIx8LqZAGlqn8lNw1NQ8FXOrvfyM/24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090308; c=relaxed/simple;
	bh=JxIsGELBHrHirnkCBFZCx0PaXMg88UftjkeVSsKg1D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJGWg5mJ9HhtCmaIs0wTDmkhl8vEwB4TaPgTgn9l53EVCvS7sOpxKRN0BKDas17n634ZE3d+7edfDGbidVPWZTRyECowCFPV2pGzGTfL8YZpRn1TcvTrT6UZM+68Rh/VHvpyGIkX2EojijzDhYNk1v+X1/fOpiO9Bn5i/N5DQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBa7QcOG; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29051f5d5e8so2493213a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706090305; x=1706695105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdkdHYV/bTjRaswBV7ZNXiCyuFi2PRnts3VTOVvrO5o=;
        b=nBa7QcOGNWKMwYTAXF1cdWzBlp+f5DnWlXkOXL/Gtkomo+FJhOqJDOaO2eFePcEsXa
         Wb1zF37oGC42PrzC5U2smlsumGHejldQ7aCyZx2mkB1FRu9PzE213fex90l/EvHyDELW
         ViIJX/tX3XMdfP6EiEx3r6usjhrj8JjjhALgYBWQ1pJzqliLvjQ9bvxhJcv8uKciLu5Z
         gI2ve0xMfA7N9s6bJMn5qHJbinjeQY1iV2GbMlz5ekjWfoszorHFwYS72wa3KmPw+UkH
         buEjfAunQ9Y9wvbCSEb3hclxitflYeCQIG7Q+tUygNd2HsbmURSJPNIGBgJR9YxNxGdA
         2XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706090305; x=1706695105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdkdHYV/bTjRaswBV7ZNXiCyuFi2PRnts3VTOVvrO5o=;
        b=BkuBuicZ3qnwSBps/unB5WFx2Ez/1EJSbMMutxpiPZri+/QlptWnFiBW6pH+MROfTV
         COFi3jvJrZySQqImDTvFMGEl/ZG9j8Zwr5pSizaOGiAvNw2pegIuJ7KSadNW0RGNozHQ
         hU+Q7XBkJkhxQLRX0IzZD2jVpL+nKSOTxLIo4kw9iAiGu4YswdD3uMLVq++Ki7FkJksT
         2p3o1Y2JCc1tZyXVYR6e0ba03lKttmp6nMFoRgCpYf1DAfiM8mL/aKX8rUMZ/ldWLvnY
         M8J9dKUcsOjQs93g0kmyersaF90FX/JKkskADnq0TsC7FyPywo6kdCtyN7+uRRMjvDnC
         Vgxw==
X-Gm-Message-State: AOJu0YwdzXUDN1up9rVEYgetrxmlDEndiGWSliYPDsgXBGjQv3oskHic
	VZpqyFjzmlf54UgMBsUimzVYYtDYwY5riNt8dAGFYCeHj+JiDMDZjxDxTid0KXrc1rzV
X-Google-Smtp-Source: AGHT+IEZSH80eRimV8iBLfCDiR4LERHRv4IHjraVXccyM+4qysGMfyi3Ly79x1p2lX0pORGy/d8W9g==
X-Received: by 2002:a17:90b:f13:b0:290:1a95:2c5d with SMTP id br19-20020a17090b0f1300b002901a952c5dmr3360692pjb.92.1706090304640;
        Wed, 24 Jan 2024 01:58:24 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so12-20020a17090b1f8c00b0028dfdfc9a8esm13055367pjb.37.2024.01.24.01.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:58:24 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 1/4] selftests/net/forwarding: add slowwait functions
Date: Wed, 24 Jan 2024 17:58:11 +0800
Message-ID: <20240124095814.1882509-2-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124095814.1882509-1-liuhangbin@gmail.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add slowwait functions to wait for some operations that may need a long time
to finish. The busywait executes the cmd too fast, which is kind of wasting
cpu in this scenario. At the same time, if shell debugging is enabled with
`set -x`. the busywait will output too much logs.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 8a61464ab6eb..07faedc2071b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -41,6 +41,7 @@ fi
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+# timeout in milliseconds
 busywait()
 {
 	local timeout=$1; shift
@@ -64,6 +65,32 @@ busywait()
 	done
 }
 
+# timeout in seconds
+slowwait()
+{
+	local timeout=$1; shift
+
+	local start_time="$(date -u +%s)"
+	while true
+	do
+		local out
+		out=$("$@")
+		local ret=$?
+		if ((!ret)); then
+			echo -n "$out"
+			return 0
+		fi
+
+		local current_time="$(date -u +%s)"
+		if ((current_time - start_time > timeout)); then
+			echo -n "$out"
+			return 1
+		fi
+
+		sleep 1
+	done
+}
+
 ##############################################################################
 # Sanity checks
 
@@ -505,6 +532,15 @@ busywait_for_counter()
 	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 setup_wait_dev()
 {
 	local dev=$1; shift
-- 
2.43.0


