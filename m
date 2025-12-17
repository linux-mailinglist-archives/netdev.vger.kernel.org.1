Return-Path: <netdev+bounces-245144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F065CCC7B90
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DFEA300A6D1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9723D34F494;
	Wed, 17 Dec 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMFcY1bV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB33469FD
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976290; cv=none; b=KfRWwqCYK18ABxlJsgR5L33q73lrulk5+zFdUzBw0fxVNe3f69tTO5fAHRnAStdueEoCpXIoC2SAOi6cECRBAaV0z9ekxX17NX0oTkSVenE2NZRf0aEnuTsc6Tqhc1MYkjtvGzwtvHGWlR8IkYV/1o6SnPcEnQoaovTt9gSeEjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976290; c=relaxed/simple;
	bh=CloEhhB+uejblLuhuXn8n5zkfy2FIPc3okx6zsJmi1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HI3YWqe01ZOTEF+j1jNKLLBVzrAhyyLM4dmBYDNwzzR5Q9W74fMzhs5ZYHN4KamHO3umP0kUcEoow7rn81LLGQT5n1lzT4zPEPxh49HnGsLWPYXruRnNjVy3vWdJTKVJFpvNe+HkSMW6zuGXgFYA9wuVcqMgqzcerUr1B4nyJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMFcY1bV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so374136a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 04:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976288; x=1766581088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdG/M5hQwjEekQuQim1OPFLT3tKylIxu+drVZWp4rT8=;
        b=UMFcY1bVYx2NbabxTsP2TBO8GCD/QQphBVd0VcZ9BQfppxqwkeb6G8VQpei7ivgmoq
         0d3iry2VSThXjAduO676eJX4zbaLnIhdAtMbOi9GbzSQUgbmQORiLneGG546BjorGms4
         2uCtlMHhK4kMemTHttFwR/M5GyQqje9qPLVJypOuo+Tw08UUC/FdFcx3BMeCqi32vc5R
         9DS6Vp+nRsjNnrbgA/VB3Fp5zicHbG/vzKPEiXtHvyOq1Z8k65W18BxQGi8CkCXFxHa1
         KCRKrzIO/Hh63Xh09hjMcoBCxkN2mvY718dYXNBKjQfuPcVPK/HO4INWE4yO/ifafuHC
         E9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976288; x=1766581088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdG/M5hQwjEekQuQim1OPFLT3tKylIxu+drVZWp4rT8=;
        b=g9/HTnBDzgdrBT86tKjbFiNHyCpwbMBPhbZSU1gVa+PsXSN8t/wKPuHn78TN8C1wUb
         8msXzTqMCS842dX6ffbXAa80obgsizoJBK+OsqvKkSBhdgsi1Ak3dZTPxMQspk+6HrYf
         WUzWKivBJks8YLInJtZGtOjPycebd5VcH708+O7sywy3n8iis0jEDiiJT+Z2Lr3i8ikL
         prh27Hl72/VLQuK78gdgGpd8tFEIErFX2P1BTJQEFbWHNShnWPhBIEOCi3O3U/EC5oJ9
         xCAugaUuQsWgxyqRzXlIhQu4bANzuGi5i3K+AP7qdnec3kIFZBvHBeVKBjoQPdFzZS/t
         XmKw==
X-Gm-Message-State: AOJu0Yz8CN9PYkcN0qJbRabvJnQ25oJnAko0Ai4+SzvQrMtdHwQvwwoO
	5dvFvfRLEaKbUZI3DsAuQkhMoSIJPxIdINVMoJwe3ZQJ0/jbtrdWURujThCfuqyW
X-Gm-Gg: AY/fxX74J1SNgGnFPjc0hjmwAyXcdKCIgonF+7Xz2mPzMjt8KN6W15fqMxIWWCj5r9d
	E59Md9K+S83TVoboizSr5c5PXy62o1KDosBA7fVrQSk/R9IKGgUjNPCARDtGBwH58Wdz2uyyWD/
	iNa00nVnnC4w6bUW67Kl061iP35gVb2u4Hq2DEY2neFcrh90Iksg8+05tBe7OKxq6VOuMbgf8c/
	1dbGleedxrmwIFyon/9LR1x8j6s80bhfU/Uvoq1UkEKzhrwdiBBhS5Eh4dGKAOmDrSNkr/YcVyA
	tDSI0EgJYUBPRC41najIJQIfUl27h0WEUJUYdS4ULbUTHL9Dw/B3+XAeZeMogzZh4Pdfpp3WTQR
	BkfiW02s0yz5oKS9jgPnErPPcmg9OmX8cchzAZKCTKoqoLhIyUZ3g1Eez4IMGvj9Et5eYArBo9B
	KYTmNJ7HpTT2VYh6vOChfMJPCpVO/+5wAWeZhfRMH8VEviRORy1nGmhrrYKHTCB6h74XfVgBiC
X-Google-Smtp-Source: AGHT+IFZs9GsdtlAivxApIzkVEWP8L1/mtLGAQcCbK/sMWOJTBXjsnO6H1lzfZPhfrYX00deaC1B1w==
X-Received: by 2002:aa7:8886:0:b0:776:19f6:5d3d with SMTP id d2e1a72fcca58-7f6674439a0mr13348568b3a.2.1765976287906;
        Wed, 17 Dec 2025 04:58:07 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd974aeb37sm839335b3a.11.2025.12.17.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:58:07 -0800 (PST)
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
Subject: [PATCH v2 2/2] nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()
Date: Wed, 17 Dec 2025 21:57:46 +0900
Message-Id: <20251217125746.19304-3-pioooooooooip@gmail.com>
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

In nfc_llcp_recv_hdlc(), the LLCP_CLOSED branch releases the socket lock and
drops the reference, but the function continues to operate on llcp_sock/sk and
later runs release_sock() and nfc_llcp_sock_put() again on the common exit path.

Return immediately after the CLOSED cleanup to avoid refcount/lock imbalance and
to avoid using the socket after dropping the reference.

Fixes: d646960f7986fefb460a2b062d5ccc8ccfeacc3a ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ed37604ed..f6c1d79f9 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1089,6 +1089,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
-- 
2.34.1


