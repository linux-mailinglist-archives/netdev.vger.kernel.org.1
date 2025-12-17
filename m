Return-Path: <netdev+bounces-245143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49855CC7B8A
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14F30300A348
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517E34F278;
	Wed, 17 Dec 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkZMk3Rf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A534DCFC
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976285; cv=none; b=qKc7bypoC8lCpJikTCPhMilkRqRz5eSDFHV11MCOHYwi7H/B7/E65Al8NpQauv9oOK3j4wBTG3hzu1mX4LjDa4rMGWJOzUj7xcwxZBz+tflLhCmHYypkmYycZPxENQWiMc5j2qnZUlyQ0bwyDSeazi4VG1KHONOt6Svoz2DB2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976285; c=relaxed/simple;
	bh=SZnCdTyKaSLAbq/w5ae+5W9P3TCfTqARU6rrGxRItYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2NS6OkJDMR0WQ8UDBE8WdBveuVbt9cGAmtq9Lc0GCaDcl82rOaJliLxKSE2ROQU9HkJD4rPIIF97Vtx/L3GpXCknfXMzCwPMpHjbqKddaUp1bg61ED5MB5S49Y482PPmTBEjnPHGj0izssJ+6yegAz9Nh5KhuqB786Uq1bAdmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkZMk3Rf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b90db89b09so546353b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 04:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976283; x=1766581083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19nxpEKwGS7FQgHQH9ItvDMFClxV8pWJ4CiL9LfKCs0=;
        b=YkZMk3Rf8izIZxEypeYZRidmU0DRh26aCOQdpNYkAJR5mf8MvE85JHAugxt+0oW4Th
         ess1vSGrfjA4QpvytxbUmIH0Zz4X/Xk2ei2edGtd4d7rjGgZdFEViQwPUStyJQFe7oGE
         WHHojGbQ1ux3IWz7XzFbgN6L85YgZAMy5jK6rVmIYQOoOMwPv3uUb6I2cVpihF8Jqn32
         vCGzXfawokhnUjt8roT4qDLEPcI25azrhRtZavDi6Y7b8T4/wj7yuBhEGv7+8XNahwid
         /uvxeV26d+58ms5GUQfrNtbn9j57mb0+IoIL+WODETwpauyhRXw/kyh4y6qsc9OE7cOt
         RVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976283; x=1766581083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=19nxpEKwGS7FQgHQH9ItvDMFClxV8pWJ4CiL9LfKCs0=;
        b=tOgrAPVCMId9qL35ENEEk/HdzaoGzb14NAIDtfXwJBfKzEcvS2FMwfF5XuewuMwS6j
         16csf46swkyPtjBIioR+cCpM8cHGuOGYP3613KrM8OlCfk1KV+5u8zNldlT4Me7w0BGf
         yTBmsvABxMS19x4SWvK1k4gs81MKifj6w0VJwGq97W3/xEt+P7cl38iD2ZWQETB8j0fc
         pciZafRkFUOyR3YTuOH2NB/nHFN1TrGzr27VsS+ZhwJHepWgshbtWM22TCGG/njelaKa
         rpyP4gJ1IBa3KZoJwSh1BP72/K0hJYqidZtUs3WiPSekcHNMkqo6dRHd69bWrulW28WI
         hu9Q==
X-Gm-Message-State: AOJu0YzVHp1QzmBaFMpwsuZmVEUt6eDAr6uM07BtT4PwVRI3GYSGtkng
	lv1WGWe6mXC206+WPnK3Ab/KBgG1jr3W95AFOmbLMrb+IxrsMXnB35KtR1CACPie
X-Gm-Gg: AY/fxX7qJ3MFj6bTHBRNqwVZEnj2BxMoHLW/8+plQ84cNvorpyZzABA/fJqrUIq5uPs
	LcAWpRXTZ/ytMobyBKRYUwSDJmrQ9DLBIWOdmuHLcysKN7v+C9LnkaZRNT4FSzFEiETJk1whgbr
	dY/ND3KjfbUGkcv4o26CsKJklwn4W4/UXsKXkPKXRKp1aaI7DmUlSY55QPJGqvOoifZnTlo4eug
	hH4IQ6dIwk0vG58clKiPu5oK3Qpqr4HSiU4K5Ixt8nUGWEMYPOp9RaP03Neu1qAnP2c3stTONq4
	1gr9o5/OoAs978GZxLB0SFdEeI+Se4sDaW/P8ubwers5F7kb6+4eHv5gmGYtaXnto7novfz34LE
	qBcwe6W/rDYspaqq+LcGG2kWilNyiBuskkPXArm2g6TQAoJmX2kWOIH1dezGSMfUhY+tOQHGuDh
	c3HJC998AmDBR8cmV1SFfjfGMgSRfww/iT1AkARgYVFMP9rsWtuBQYJSi0CmOicPnMuSs0DyEUF
	F6+JseNZRQ=
X-Google-Smtp-Source: AGHT+IGljT05kcE0gnGjJhZSXdc45btqsT9idbNMlheRL+reQ+D2Cuw4RN6rf32Fhx0ASJ9iIYpshg==
X-Received: by 2002:a05:6a00:929b:b0:7ab:9850:25fb with SMTP id d2e1a72fcca58-7f667731a61mr12221010b3a.2.1765976283395;
        Wed, 17 Dec 2025 04:58:03 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd974aeb37sm839335b3a.11.2025.12.17.04.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:58:02 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 1/2] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Wed, 17 Dec 2025 21:57:45 +0900
Message-Id: <20251217125746.19304-2-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217125746.19304-1-pioooooooooip@gmail.com>
References: <20251217125746.19304-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state, the
code used to perform release_sock() and nfc_llcp_sock_put() in the CLOSED branch
but then continued execution and later performed the same cleanup again on the
common exit path. This results in refcount imbalance (double put) and unbalanced
lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, while
keeping the existing DM_DISC reply behavior.

Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


