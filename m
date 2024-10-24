Return-Path: <netdev+bounces-138548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F1F9AE12D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C2E1F21708
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B3A1B6D18;
	Thu, 24 Oct 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMVjnwh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7A1D0159
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762693; cv=none; b=s+D/M6Kssl8675xXLfvQX9kMSZsbSzyfDH444SNkCnNMkxJKJ9+gGHn1cUGlOpw0MAdwW+V9MU/2ONbIug5RKOB4QOcQYCzUWL25I52l0R+uB5RZvW82JYyNYyztG3S1yYk8/X9NJWMZyw5vJPe1GjuW3O/2WkUCAjjewre7yKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762693; c=relaxed/simple;
	bh=4fujO34lS/ZpxNLywuPL2mB4wBpMK6UyUQBODzkSG6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jTRUIdxUhNE/Hu2ou1luumAeqAHX2wI0C8xmA1jrZmI00jG9W54qy6V6dyBWYBdZngHqiS/2QDudcNbOg+Wbx5UrziRJunai6qCOyYRCOLvjHgpcUa4Fgsb2px7EQ6aYs2eARN04yAuLcCqdC171snfEnd4fuB8WeIYhzmGew94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMVjnwh9; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so525918b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762691; x=1730367491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6llWh5JKJcbIJuY3Q05CoEdLWUT/46CL/F3II5SRwmg=;
        b=WMVjnwh9SU7jvU9gZ7WxxBiIcx+seLWJvHxBsNN7waTKgphWCeLW1FRlPwsU4hjpU7
         Mo1tN7aP5oggTig9W+qdzg6wNhMbWg2fou+LV4wdmDGKGaWHCbmiKgnTOLehCxaraDnL
         ABER/y7jM3jOtn2vdPvGTgWBCfCrZku1NWROMdSBD7L2lNLsa3GRftRK1ifmykXG4Lv/
         c9Y7JPhEeBJ/V7wJLIMB8TSpTkA2jLdwq+SfXTrJrxVekGc7Ga1SrHlgYzjBvd2369UI
         q4SXKRzn3Ry6blBBK6U8wu2r0gr+hWJFzP1duss5G80vB9CLp53Mhe2J+lLCWi1ghw3I
         P2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762691; x=1730367491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6llWh5JKJcbIJuY3Q05CoEdLWUT/46CL/F3II5SRwmg=;
        b=qZ1Fs3I+AP/PmsLSPj/PqBJOnoz2kkilLlq+WTBfyZtxWqViyfm/G5R1H6XPX+2EBh
         sPoRak/8XEPNZHWM9tHuhpB8ZM9f66TYF0DB8/q9KnlxKjMKJAsTGxfey0f+cbDMQsW7
         Wdbp+7RP2/p7dsBqaX4+issQqpF6kPFK+T1gNAP9EBggkxwb3VowppdEZpgwmjEkvukK
         St9015+3WPBbmw7tYJ0a0dlftiNVVIUV9tSgR1D/fVpaSYlZkO3On4t8bSo62gwN38vt
         D4aV83iwyx/qI66tXT0/Tz9nciWcozOQr9AzlRQhdCNnqRPBI+B7RZNTEcSfYsTAT4bO
         QO4Q==
X-Gm-Message-State: AOJu0Yxnk2ubiVP7OxQRRe1AigU6LXmk3wWcbLAURzRaFbGGYDl1Oeoj
	QsMlCxiLZyyk4A4/sFLkGfWVO7IYInnQiD7ZKj6RwwttkHx89gns
X-Google-Smtp-Source: AGHT+IEbillmvfOzafZQAO5iopBbkzjlePaa2D1ySz4NIoZrvGGziiAlg3sf9bB4JjbNPQRisqzjdw==
X-Received: by 2002:a05:6a00:4643:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-7203097da0emr7476429b3a.0.1729762690682;
        Thu, 24 Oct 2024 02:38:10 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.134])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75b9sm7613923b3a.131.2024.10.24.02.38.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Oct 2024 02:38:10 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH 1/2] compiler_types: Add noinline_for_tracing annotation
Date: Thu, 24 Oct 2024 17:37:41 +0800
Message-Id: <20241024093742.87681-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20241024093742.87681-1-laoar.shao@gmail.com>
References: <20241024093742.87681-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel functions that are not inlined can be easily hooked with BPF for
tracing. However, functions intended for tracing may still be inlined
unexpectedly. For example, in our case, after upgrading the compiler from
GCC 9 to GCC 11, the tcp_drop_reason() function was inlined, which broke
our monitoring tools. To prevent this, we need to ensure that the function
remains non-inlined.

The noinline_for_tracing annotation is introduced as a general solution for
preventing inlining of kernel functions that need to be traced. This
approach avoids the need for adding individual noinline comments to each
function and provides a more consistent way to maintain traceability.

Link: https://lore.kernel.org/netdev/CANn89iKvr44ipuRYFaPTpzwz=B_+pgA94jsggQ946mjwreV6Aw@mail.gmail.com/
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/compiler_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1a957ea2f4fe..0c8b9601e603 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -265,6 +265,12 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+/*
+ * Use noinline_for_tracing for functions that should not be inlined.
+ * For tracing reasons.
+ */
+#define noinline_for_tracing noinline
+
 /*
  * Sanitizer helper attributes: Because using __always_inline and
  * __no_sanitize_* conflict, provide helper attributes that will either expand
-- 
2.43.5


