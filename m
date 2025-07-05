Return-Path: <netdev+bounces-204278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C4AF9E0E
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 05:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D419E3BEA04
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89710202C5D;
	Sat,  5 Jul 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkqNOMCX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC95383;
	Sat,  5 Jul 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751684939; cv=none; b=UUUSCsrPUVG7J3JhEf7wwGzStw2W4LfAdzZRXT+dPHfxIaqdA1X8DDkzRgmTVqpW66OnSkbhJAsRQwh84y++/nGWdUFC3m8vO7erHA9tWMc5NPdz/uZgIe4/nrBtnhj2L+ak5YXZNnrvFLc3j2UqikAbnfRchGCewp1lwl7xJLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751684939; c=relaxed/simple;
	bh=KpbTmrsrRfUP5yw0LwxCsmoR/Ojb3WLsTy98XGKAlmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtG9SYOMSJhPDXS/2nAP2f3B2Am0/x44xj77VfKikEYOwvKU0VvemeewQbVBoZ9O0/VMO2kuRomsPmK8++fovy9Wa3qilaqfN+C61i9C423GzJkXjjNCYomvdjTOytsHSaYJVEmkByx5w5+Y/gMCBSvqjo/pEA+LhzNCF3FlAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkqNOMCX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748d982e92cso924259b3a.1;
        Fri, 04 Jul 2025 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751684937; x=1752289737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A73jB41l9dOIANrWvvSRKqyz67Ti0po3QDM6Q+/r5UI=;
        b=SkqNOMCX4hDSZsZN+ll68THxwKpn6twkrf/nPAfk0+Pb2HtwZ8maRddXYmJVulZLZH
         jkkD8jtC1LECmGOszU/vHHMVfGN4N83UF/tzNvWQO/iWfbjyWo3CxZiN1mdKCoJKMQnW
         CLvJ8VXwRqlOD/hqsDtuafHnnm8XVZGso+4RxHQ/8XOT+8W5+pceHE+yVNEb6cQlA2xG
         5xQYV50ZUFwCloQKEfjoP1gFZf0DD99R1Cn7Qe5RWl8+fJB2k5qVqRJYTTede51bK27j
         ZMQHiwFyAawPk6rE47lI2AahvUILQi+vPOGE6mkU1HPicaX/84w86qGHj9ILSooPFyj4
         V/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751684937; x=1752289737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A73jB41l9dOIANrWvvSRKqyz67Ti0po3QDM6Q+/r5UI=;
        b=pr1WHETspZI/yGYhVrbQ5xCOHpuN9nPKZclUMhWI+D6rFgiI3ERtnuPCQh8sx97sT9
         kdqLRf2PcVw5+HTUuNXHj4BIUveI8WM4N8dl7Ve510yxw3qjKU84VEiz+2u2mg4IsXRB
         DPTbjzfoVTwIug+v0g0QLHl3/AJEhlAEOwrt8do0bIOWT8w9eDsbJUZD+IGn3X/b6j/0
         5zeG3yBQyiiZz8ItFpTRB97wCHijNzQJ0+dGGxXrk9LA/yUPdcAMop+9na66qUje9fa5
         gvMrQcjXFB3t3Q/mRxIWVF1EqK7k/wuaoc5n5DZin6NWbCBLSDnalV85C+vZxNJYzgay
         qVBA==
X-Forwarded-Encrypted: i=1; AJvYcCX+gF9ayiQPJU6skATrUIsZmc6kuZvkJi6/za3QLpzgYlA4syD1uvgDzyMjaPcy+gSifqRBkI6MIQU3kLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVrBw5Nx1MuJdVn9PxF3QJaSwhSPCpLwm/09PN4gqNjh4tPhvi
	LmqP2SIkCar6G6qzlHHvfUr1LyAZKeAeESoM+Hn18hckDWKnZvxb2cxW
X-Gm-Gg: ASbGncvYE2eMsREdGds7DMX7ekDkN0cgQqyOVYbfwAZX7onEVSa8SaRsCKtkBxwqMMg
	aXceAFpdHA5rMAEosvJdj+EP79Vtn892CRJKN5qtU4oRxYZCUTPs0mp/iwGSiG+KVamPovDXqsR
	ngck50WO6CEUV6kieLaUJGMj0zFrsUzAChDpzzDYh0vHtzxIs8IZAA9fOxKKiMVKPBMNsuNtgVp
	dxK4XDvkKOdPAWysTyHmB04QJgE+GBTOVKGvHu3QPNZ6laOCr/kRu0sZ61Y1O7f/BG0Ri0eH3Wl
	GavxlyGh9RPdGXX4qr7JgatMccrARjK890c2FqkiXC6khuGrz5CLbePN29yqW1nD/sgnoIZ0tcy
	umS1mams=
X-Google-Smtp-Source: AGHT+IG0pKOIl29nVWaK4/4XL/WKriMDoeXtojmRriRddb1jxLPBkUReAaG3NRBSyYFNiefr2P9DzQ==
X-Received: by 2002:a05:6a20:2586:b0:220:2e32:4e28 with SMTP id adf61e73a8af0-227215ad790mr1370752637.42.1751684937301;
        Fri, 04 Jul 2025 20:08:57 -0700 (PDT)
Received: from faisal-ThinkPad-T490.. ([49.207.206.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee62c615sm3135095a12.60.2025.07.04.20.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 20:08:57 -0700 (PDT)
From: Faisal Bukhari <faisalbukhari523@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] netlink: spelling: fix appened -> appended in a comment
Date: Sat,  5 Jul 2025 08:38:41 +0530
Message-ID: <20250705030841.353424-1-faisalbukhari523@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250628104422.268139-1-faisalbukhari523@gmail.com>
References: <20250628104422.268139-1-faisalbukhari523@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in net/netlink/af_netlink.c
appened -> appended

Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..f325ad7c1485 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2455,7 +2455,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	unsigned int flags = 0;
 	size_t tlvlen;
 
-	/* Error messages get the original request appened, unless the user
+	/* Error messages get the original request appended, unless the user
 	 * requests to cap the error message, and get extra error data if
 	 * requested.
 	 */
-- 
2.43.0


