Return-Path: <netdev+bounces-196852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76CAD6B16
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1ECA3A3DBD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CBF23D2A3;
	Thu, 12 Jun 2025 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2SABpia"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F923C50A;
	Thu, 12 Jun 2025 08:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717492; cv=none; b=GdUkrj8h3poYwU8xQyMnSRgbvoevsy927NMT9pmbkZ4UXbJQxg8dDZ4roOngyudx87D6Us0jdFDLnI9cmNI0uhFlpZ39aRLlSv7HS+tywENnOZ/c0PCDZ2ECDVhBd9zQbvn6YFQNPweST3rkXH7F/GAbbAiT6ynfrKTzgV43+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717492; c=relaxed/simple;
	bh=Oc3K9Qj3j07VPt1MMG6hbezjf1/0Bckv/wKKw681Bf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nASO6PkGrYoZ6wi730lT9W0K3NRbRuQhSw7aOFc8QynEJYTU6OJTTfbuaDNhSxIcLzHeKNe5nuV1vmwFx5KYh5pmnrwvOh4MEXTS9KegiTU0bPo5EqGTopSonD4Xc4KD4pcXHG7seJHmvgJr3SCEwMRtyVVCFIUrclpJWuisal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2SABpia; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so7514445e9.2;
        Thu, 12 Jun 2025 01:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717489; x=1750322289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUsIyz0LM6FC1UIezR6DWbKPfstHdTwXyFgsLht6qok=;
        b=h2SABpia88XzHjVJCCP0cu9ZD5wGy2A0PkaMZKBl6PA86Rubx0GyjJyyr2N0EGKjsg
         Fq+Qa0TN7BHUFDELjH9rIBwfVtXKqTG91USD2eQfTLn2WSZf+vGZWjG8NKYBz35+PbSy
         Cd6x/q/vtZppefZpr1B783h6R8Wj96ERtQPzYovB9kjD4v3vOrGCa5H88TD42tOjbBfC
         CWeb4okKmRlt8vaGjzhtjr0qK3quYuxRW8GjQvs2HpXjcbPvgT0OZRb8LaB/lTxClwnC
         k6sQimk5VAW6mlFaQ2opMJA7ywcyBvN+e+HK5Q81/t2sJXMExft8sDN1cHvExnmvIE82
         3mAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717489; x=1750322289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUsIyz0LM6FC1UIezR6DWbKPfstHdTwXyFgsLht6qok=;
        b=jajVMLTxxpu9ZO4TSJesqvJiysgGGEvpIjBZ/axtyE0Vo3oCoko9mSMfqc5lbjorW1
         N0RzVqJgGc/Jjtkupbs7b2pGhS3IN2tA1bp61ARxjaWLzKMDR8D6J5WArvAgnUvR2PgM
         6e7McPIjNkzFLVf1x9vd9kqZ84uEKFDBFPV90FzCk2aKWz1rGjByI0UDZ2CwDSHqC12h
         YG3cNvh4+fd0EOGcjoRCgaJR2ZYxoC7DfXjSJc9mAEdeSiqfwiqv6XCmA841pfPlRCQi
         2iV0BUKarBwrfgTtHoobkcjudQQ8VGXtYY2x6rQ+ht9qeI0DErYwpCCnC7q1Ys9ipLQR
         rjfA==
X-Forwarded-Encrypted: i=1; AJvYcCVkFNP92mj1u+agG49wrRTwnSXayy7JkyvWp9luzkTOu3lENh7MvuPoodTf0+bxrErLB/9DIJFTL/6FFJE=@vger.kernel.org, AJvYcCXle+0IsX0sss8XJt5F2gPzI9WWVtY+ysrhVRkUjY1hNSyvVE6che4Bl0CF4yG9GJtO1HfMyjxF@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxq4eav8KGEkKdI2O/ft6z+fFECsv2cLNpXhvVsZkM+ThW5Aiv
	2ZUyrnQa44o34UH5/G6Td+ISDgvASVBpdilIbJHYfsyyQX+MiL6if+66
X-Gm-Gg: ASbGnctfL68PpcfZhvphLxFMM0FPf0HE4oPJXW9aWMtGGh80IQoQRS+6W6V+56Lr4nD
	HnxvLTFY89H8BHQyTp7aV+rgilU6PvxVWme5jvIHhzfgjnOxQmPMuO/XnoF58iCON3POPXa7RUG
	3enoRzIH7bNn9KP2EeWMMOr3pr+tmpL3yG7NdpEdjhT/F3cFIfwobYcJvvGMDwDlJD43wjTc+KD
	J52Ob6Ia+MoVGsZyuOz/Pnr5P7QEl2MiLSNk0l6CXyg1cQ8+29lhR/N/4ul7u0cY27I4f+DLhLI
	iqi8rSlrX17oA57sKl9lcaET6Q1xQE451vM+K4Far+XYnq59btixFO4dJvi4S+f1xFwedwn3cGi
	3sTdm5EpyLeoQRMfqussxMDQzMgUfstBWiehKwuDA/k1BW0MokVc5QNyja7kOCCrf/q/x+K/SAs
	P/lw==
X-Google-Smtp-Source: AGHT+IFNp58Cc7Q11rPQcj5sMp9yXP/vONjBIqfnlEC9zjGjdel/UlozNPzGqMkNeI7nxEo4qpqg0Q==
X-Received: by 2002:a05:600c:c8a:b0:442:f4a3:9338 with SMTP id 5b1f17b1804b1-4532d2fa8a1mr18472735e9.21.1749717488604;
        Thu, 12 Jun 2025 01:38:08 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:38:07 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 13/14] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
Date: Thu, 12 Jun 2025 10:37:46 +0200
Message-Id: <20250612083747.26531-14-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
B53_PVLAN_PORT_MASK register.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 409336d380bcf..3503f363e2419 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -543,6 +543,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
-- 
2.39.5


