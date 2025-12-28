Return-Path: <netdev+bounces-246162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A0DCE037F
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 01:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0D623032134
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 00:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62A71624C5;
	Sun, 28 Dec 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWqq5o+J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E72E3BBF0
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 00:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881364; cv=none; b=jpLKTqsxkeRdVuXHxDZlp/2DqSaJsdmv8mbAOHHDjLX2wf0DMMrK+0m/36DqPjSm6aRIdWGGMZiDo2E8nv3JQD3BSnZ1MIqT4W1GAWBwBnnMjxQFi8GS+AHekwusEpsZ89pRaGDJ1GZc/GsLV/D0sRp0trH/6gOMZIYmeMz7Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881364; c=relaxed/simple;
	bh=YhNn4w1ECKW/lyR2/aN/YzV+rzqMtr3UUzPAsYAzA1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmyv2hFUg/nmW+rulGaCmYMW+hYA52zajHtJEUwVACMwmQ+k7VAZDncm7M44pu4ju2KAzMnGz2kN5ke5XuEiZrnRR0qvg5GtdddNj7AERLxOui0O/0R6v2oyi2ZmqnRQvOvWLt09K7fbDeo8A8YJiwPPWuLHiIp/yueL70/IeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWqq5o+J; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0eaf55d58so52998515ad.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881362; x=1767486162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBRm9tUjprzPhPnPDp8sMp7may6BpHKIeb7XrKLfEso=;
        b=jWqq5o+JCeVn7ERc3PxZMnWBOGbVt9/zwKAKFwCRB15omr0mXtTNEztc5jpONKDys0
         rRG37cfu6qzW4cusjnA4FLVgKQ3NMisv9++l1lCt5/oIK9IFQqhh/wdN1YL871oiuXab
         eSHmfzej34Y+jwFO72/bwJ+6kly1A2r3xRuheOFvzKTHQyIMc8ohYh6CHvbAADMkqtHH
         de22D9Hj8ZFJ+S6ZLuIXawUnPe0xRdgBxLDYbpiDrMVz5u92fQ25ua5KBblHBJue/AM+
         9hx5G+DzFhPyqUCU9tcETA/P8lvqyIeg8cyhzGEJgLgGRV1FcPLJatKbItEeFWPfvjOe
         oc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881362; x=1767486162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rBRm9tUjprzPhPnPDp8sMp7may6BpHKIeb7XrKLfEso=;
        b=ZVVkXl3g/pdxmtUItnVZhBx2uA8P8Qd8+5oILo8f0S13naEvx4LLy97TfEOQet/oeG
         EiuDQIlPE3k/ak6wx52ChDLW9t5Pjh4BEYoRiHirR5PpE1Vb9aE64u2BkIPAKtouqoI/
         EqqKs6zm9YtH1gUJ0bW+MoOnKWknO2r/Cq6bEj1WGlY+BLXNZl1y79O47clxu18Rga+K
         UiOOMEkZiQnZFL700W97B4nRC/wVOAONrU32cmF1zodReB2DbsA2+SCnu30LCtfQALjk
         8nV8TOBlSN+UFLhiYF7GrQZ9wTLAyctuVUrP8v014KNaAMSDmkjusQ60lYRWhl2nJgV6
         CGrQ==
X-Gm-Message-State: AOJu0YwLmh0C1PCX/LMFUX6g9OUfi4Z2Oqk5jA+DWrTIbUv78AXph60I
	75Nzz77KAfJOEWDkZ9vHmsVdpgYsS+D72g4MNiwyqAUsL8MhYUFUewtpitbVEA==
X-Gm-Gg: AY/fxX5hCdJhzZ0g2Ymzs8a5aLmoGWRb1PJF3VvL4+nzqrGSS80lPMjkf2v2S4aaPR1
	XTqvyYxGqpafiiYqkQN8pj/NcQ0aScxFMFvnEPvaNHrMdpPDIA2vucy35hS/RdNIOEa6w+Qt/lC
	ZhWCEuTO8uwivip+SkuB1fMFDu/R5Vq6xpVTZVFB6eE9lXVh6gY9LwpATVg11hr8lu3Xo4T4oHG
	uwgqEJsRANRR5wMr6PoQIJwkyYMGeP+iRWjxrJN4TtfrFfbhxOOzRyw0hUNn0BBKLGVEMxlpCX7
	kN/Ckz/lcdGQtZp48Wjb8Y55jsg0PdattbuvboNV6f/TfL/iSEkhb5UmOxizbZUoIOMDCboMVrh
	CXr0hHs7dB611mKfe7c7HKo5mWEynkOnAXRXefQMQTRCQCN75r1XZ62LwF3SpCfbjAYSX+QPuov
	szDNGY3IghP2XqtTlf
X-Google-Smtp-Source: AGHT+IETJfXdkKE0rml3lHAR3nUgRFVPNZNBjCIoz0gYzb9VwwEPw3nJv5rIgJ073jgVuKmhTKDQ/A==
X-Received: by 2002:a17:902:d54a:b0:2a0:9934:a3f3 with SMTP id d9443c01a7336-2a2cab4fda7mr263935185ad.24.1766881361880;
        Sat, 27 Dec 2025 16:22:41 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:41 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v5 3/4] skmsg: save some space in struct sk_psock
Date: Sat, 27 Dec 2025 16:22:18 -0800
Message-Id: <20251228002219.1183459-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
References: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patch aims to save some space in struct sk_psock and prepares for
the next patch which will add more fields.

psock->eval can only have 4 possible values, make it 8-bit is
sufficient.

psock->redir_ingress is just a boolean, using 1 bit is enough.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 61e2c2e6840b..99ef5d501b8f 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,8 +85,8 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
-	u32				eval;
-	bool				redir_ingress; /* undefined if sk_redir is null */
+	u8				eval;
+	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
-- 
2.34.1


