Return-Path: <netdev+bounces-172429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA95A54936
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AD916C301
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59D20A5C6;
	Thu,  6 Mar 2025 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY9DHOy4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF012040AB
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 11:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260335; cv=none; b=luClMkW4mMgEq4nY/EmaaflN/7l7r6MemSNOvXGY7VS/xc4cdn/mq2UfC/ZYe8S5IVd8jMCZEGumZ+RmehsrhrGJt+/su8+el14r92V6EqYpegV4P842wR77nsU2/0wWdbov3yeOexRuihlnf/ouqJ+GPcqRirkp1dGGR7P/RWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260335; c=relaxed/simple;
	bh=fT0y56InECQ7KRNKYcUeI0BksmksrDyrI8jKT8glxDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rsk6N7zE5aVdlQYdfEQuk0wQ6FNvMg1O0hdCGVrqrbqe9GGJ9yjAxMJdS7cxmJWILc4GpPJllma7MxI+Eru/IriDaJ7x7y2nMh95bRueaX4mkmXxn5Cc+bjGLnoMenVS8mjLcuePtZJL8e9nHKGxzd9Kc0w8kkoFbsvWZ5EQPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY9DHOy4; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5495888f12eso649190e87.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 03:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741260331; x=1741865131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opSZ/mVT8KzKCTYtvefRouyYpXBOkttfJaQNj6wfbiY=;
        b=fY9DHOy4WZaW2PTKVGiAabBqDWypuURCoMUTAKcUf3dHMGBdNcg49Vy+zuWTdV+Wka
         EEhme47vnwSlgm0XQTs/1P+n4u6Fy4rjA3e6LnnQWU9h6YXIvCSUytMAiHWeyGa2QCgM
         4whsc6lC8E5ctH6tDP2VxE0gZvNpXvj2x66dxe9ncGVTKXFp+jtCsruLAIZxVW2ccJRf
         wIOA7sESePMj6MEHEqDKkgwNzYHYGLzXDFFy6a098Ee2ygIM5AxOMisZuwo4h3H+WBfp
         pgb2c56l9BC+Q8L/eb058UfesocdEmkXQc3sbMai8IGXA6HP6iF6j1o+J3V/yI1oWron
         HAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260331; x=1741865131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opSZ/mVT8KzKCTYtvefRouyYpXBOkttfJaQNj6wfbiY=;
        b=GV2eZYSg0BAh9Y3S9wRi2FFxMUQLjibS7dtMPovfXovry5pvCGh6SnCqrjZQTqPt2W
         nwZjbweYzlLJ4YG9iLLKnx1Gkkt16YB4NJobVADAW7bsG8PId+ZvAvp3Imm6Dn1c1Irc
         1KzatGsxX8NUXRko+4FKLN/DIE3W2vhwJQuewLUoVmCObMyqeUlckxS1/Fm8EnbmhhgQ
         ZnWRVJcz6WKZcY+vwActkM4V6la/qSW2qxp433P29JeaQE/iR/TnjSyQ89xF9XIDRi3w
         LmxwYaEk4NdypRou8VaWCNvx1JsbI2Eai0WC5uUg1B+VJQKoKn3TzMhYIrkLoOd/nkGG
         j7Yg==
X-Gm-Message-State: AOJu0YwrNCTOj/JMcKMN9k6J0/FpSA7BtsCmCIirZ4bviFTC6/yoozSE
	UqPjOdUVo/BXYyQ9dyli20IxJC0VfTxTZF9ToWHDfXF4qXbI0PLXrXSPK1hA1oE=
X-Gm-Gg: ASbGncsgyqkEYeDypH0W6ZceyTU4rzHNvNRXfPz5KQTUtlkUtY0rZFJ0EGoY/ZEgnEV
	lZ1WXV+Csr3XF/qhoTakUS2G8fcSr9ziJUSfM0FKEl/c12G/aa+QwIc/cjEPyYNxzLPL4rxcjKQ
	MGm1kCZ2aBmjy37gySG5Rk4bG13zERxKHK7cy5LKvm2RZvIXZn/uUraLtBdkba/u2YNrR18e5yb
	iqJzjoeX7XrKbXwnudwzpSU7rBZqUDKGjDxRdsIeGTLx7xvS+b7pR3o1VF8FwPYWEZrrkHuAVTz
	oMWFmUsD8j/6rpB1lsmwL+D2ASwA4eOLj+dgSw==
X-Google-Smtp-Source: AGHT+IFik20EreQ3EzUIYR/ZgwL05azgazyKPYH53PV5qgDMmGuPLu6DK6N8jBDDS0Vl/+FpMAHy8A==
X-Received: by 2002:a05:6512:4027:b0:546:2f4c:7f4f with SMTP id 2adb3069b0e04-5497d34cc4dmr2585482e87.28.1741260331348;
        Thu, 06 Mar 2025 03:25:31 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc369sm146024e87.177.2025.03.06.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:25:30 -0800 (PST)
From: Torben Nielsen <t8927095@gmail.com>
X-Google-Original-From: Torben Nielsen <torben.nielsen@prevas.dk>
To: netdev@vger.kernel.org
Cc: Torben Nielsen <torben.nielsen@prevas.dk>
Subject: [PATCH iproute2-next] tc: nat: ffs should operation on host byte ordered data
Date: Thu,  6 Mar 2025 12:25:20 +0100
Message-ID: <20250306112520.188728-2-torben.nielsen@prevas.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306112520.188728-1-torben.nielsen@prevas.dk>
References: <20250306112520.188728-1-torben.nielsen@prevas.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In print_nat the mask length is calculated as

	len = ffs(sel->mask);
	len = len ? 33 - len : 0;

The mask is stored in network byte order, it should be converted
to host byte order before calculating first bit set.
---
 tc/m_nat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/m_nat.c b/tc/m_nat.c
index da947aea..0ec3fd11 100644
--- a/tc/m_nat.c
+++ b/tc/m_nat.c
@@ -156,7 +156,7 @@ print_nat(const struct action_util *au, FILE * f, struct rtattr *arg)
 	}
 	sel = RTA_DATA(tb[TCA_NAT_PARMS]);
 
-	len = ffs(sel->mask);
+	len = ffs(ntohl(sel->mask));
 	len = len ? 33 - len : 0;
 
 	print_string(PRINT_ANY, "direction", "%s",
-- 
2.43.0


