Return-Path: <netdev+bounces-208333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F7CB0B0EB
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 917B93B5D42
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BED15530C;
	Sat, 19 Jul 2025 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CujU4ZOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1C3FE4
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752942689; cv=none; b=lcCMxnk7WLzd6C1GnaEehqhEM6eZjVG3/Uz3fJApBBBumpzp6LYjc+k1AhTqKljlYROQI386Mn1rzVwlFA/28rUH4HwWMuasBx55UGjdmlQQxRPJwU9veSPDGRguHmEdYbyW8Bq4FGZk9xbeUOJGvyjSjb6HkgboUnjzsrMUZ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752942689; c=relaxed/simple;
	bh=IrYvn5biWXIdLFpxgF8Yf/zACDnE28NXSPwyCg/Cep4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g9HKlwWoMX/6IMnBGcR5h+BDHLj7qyQuJB5JAg1didLCtY8CoD81eGJvuOIxwGS1FX835+zYe6T3M5mmYgH/X58Kf5Iomx76Y3jPtI+y/8FD06h7bV5YxoAH3HwUtKlLDOCuPjQZcJzLHUDQlVw/nIXXmFMv2Y76WVgDEt2gPoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CujU4ZOP; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5562838ce68so2997382e87.2
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752942686; x=1753547486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rf7QGnPxn5F918fDzWsKmHGlaa63Dr/AbfLbHJLeBzw=;
        b=CujU4ZOPQ8USuT6wFBJLugeY1NmUE5+aIRmuENNbjb2eHszEEwvRBoQEzMDia6igBn
         EqEho9IHY80/wqycSn2NZSGdaU2L+eyNt0PWS9Etth8hnE/nC/XBCkHQxWUqvh9SmDbb
         vbwaTRSw2gyZi15mI6WhZukSfh1UYvMzSc8YL0V9mGvi2DbxxmDk2jM3nQmH4l9Zrngs
         SxC/+T/NNBu4hc6XVjRm3+oqUj6YpH4GbxnNpY0ZWK5z4GnF0o0pUmE8VkjDX07Yexo/
         87m27Ck4sdaKZoCZZxdQGn/3scX8o7YVkN9FQBfTlsa/xxCjZxIxFnph8CpxCJUSYskS
         43lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752942686; x=1753547486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf7QGnPxn5F918fDzWsKmHGlaa63Dr/AbfLbHJLeBzw=;
        b=YlmCwK/AnDTxLVjF4eU8DxU8dLAuorTBAnMl3CILCjE5KuMdPU69gXQzLDmXn91IvL
         mk0Kvg365EgH8MsdUrJvNTIxRRpvvS/RWsXpkBiRhCwWRvoWxDu+I0WmXFlxUFQgmJ1g
         Vkvil2VnMdyqxUsTToEdLXzLMchbBGTrtQsFowLMI6L6B5yxY6eucNCHeWdQBx1qQPXq
         Teol7N8WQ0ZZp1lj2yEXPS2h+la2EcT1iQFzbkPio6kPWHcyhcz1ladec4sTDWKV901S
         o2IPTCj8pOM3eVAxHDTMgA9S97w9KmeCKbnv7oc6ZQ3UlviGgTDK92VThSy4C0j9eo8x
         KdGA==
X-Gm-Message-State: AOJu0YzTll9l60/UkZe4RcXyidn9mrhUnQbLqNK5AoquwPuqRITpad0d
	RFxrVpeIGbFQxs4VcGo4aUSGrOtxL0BTF/tSZ4Q2u7qcSMJMtyBuHMgj/g3q/pmify4=
X-Gm-Gg: ASbGncuebZ+BcI8Rj9Qv/mKL6/2AiCN+ZUFkScUdeB5yGcQc4+IxHg6ty2MrwchwrgS
	qpZDMCtdm8E2zYjS2UzOxV3HwbG9FrqHvozRWy2DLc89wH5okNlxPJ3NbXlleOIb0ut/Nbvc+tu
	7nOcjXRCBQCi08eTQC1lIbJDKY33ULqOH9W5h2RPv0wG43XA7prvQQr8oxUbm+s9aR+PTYa9gnO
	WgCUji2GHaG+uDGyl+RM3l2K1qSTKPkGKfqrtkSSrD+AYVY49LfItwruCldiJaVhj1oiKkiwYOR
	pUeUapCXCVjZpI56Ayp9h6gnjsR/LnkGpjPoJMh+Na2K1fZKBA/7tQAfwmgvVWCXTUWpbvIH/Yo
	ci22HAX/Iq8HC8PDCQ8Z5lheUN2dXtPel1iNJiHhQGP390n2VFYG8qapbGBN4B44JRI1JFSBJ
X-Google-Smtp-Source: AGHT+IGHf1cTbYGyApesO24EzHyHrEEzEovpdjDDqLYhVduLJcr/Zi1fJBbVbhaziKA7vuBb3pkHyg==
X-Received: by 2002:a05:6512:39c7:b0:553:2868:635e with SMTP id 2adb3069b0e04-55a23f03c38mr3740584e87.23.1752942685751;
        Sat, 19 Jul 2025 09:31:25 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31daf9ddsm766384e87.222.2025.07.19.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 09:31:25 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH iproute2-next] misc: ss.c: fix logical error in main function
Date: Sat, 19 Jul 2025 19:31:22 +0300
Message-Id: <20250719163122.51904-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the line if (!dump_tcpdiag) { there was a logical error 
in checking the descriptor, which the static analyzer complained 
about (this action is always false)

fixed by replacing !dump_tcpdiag with !dump_fp

Reported-by: SVACE static analyzer
Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 misc/ss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index de02fccb..20d0766d 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -6228,7 +6228,7 @@ int main(int argc, char *argv[])
 		}
 		if (dump_tcpdiag[0] != '-') {
 			dump_fp = fopen(dump_tcpdiag, "w");
-			if (!dump_tcpdiag) {
+			if (!dump_fp) {
 				perror("fopen dump file");
 				exit(-1);
 			}
-- 
2.39.2


